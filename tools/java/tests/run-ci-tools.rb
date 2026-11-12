#!/usr/bin/env ruby
# frozen_string_literal: true
# 僅本庫驗收需要 Ruby；消費端使用原生 javac／Maven／Gradle 與設定檔。
require 'yaml'
require 'json'
require 'digest'
require 'open3'
require 'rexml/document'
require_relative 'extract-examples'

base = File.expand_path('..', __dir__)
rows = YAML.load_file(File.join(base, 'rule-map.yml')).select { |r| %w[javac errorprone spotbugs].include?(r['tool']) }
home = ENV['JAVA_HOME']
javac = home ? File.join(home, 'bin/javac') : 'javac'
java = home ? File.join(home, 'bin/java') : 'java'
jar = home ? File.join(home, 'bin/jar') : 'jar'
version, status = Open3.capture2e(javac, '-version')
abort version unless status.success?
major = version[/javac (?:1\.)?(\d+)/, 1].to_i
abort "不支援 JDK #{major}" unless [8, 11, 17, 21].include?(major)
profile = File.read(File.join(base, "profiles/jdk#{major}.env")).scan(/^([A-Z_0-9]+)='([^']*)'$/).to_h
cache = File.expand_path(ENV.fetch('DEV_RULE_CI_CACHE', '~/.cache/dev-rule/java-ci'))
FileUtils.mkdir_p(cache)
fetch = lambda do |key|
  url, sha = profile.fetch(key + '_URL'), profile.fetch(key + '_SHA256')
  path = File.join(cache, sha + '-' + url.split('/').last)
  unless File.file?(path) && Digest::SHA256.file(path).hexdigest == sha
    abort "離線快取缺少或校驗失敗：#{path}" if ENV['DEV_RULE_OFFLINE'] == '1'
    tmp = path + ".#{Process.pid}.tmp"
    begin
      ok = system('curl', '--fail', '--location', '--silent', '--show-error', '--retry', '2', '--connect-timeout', '15', '--max-time', '600', url, '-o', tmp)
      abort "下載／SHA-256 校驗失敗：#{url}" unless ok && Digest::SHA256.file(tmp).hexdigest == sha
      File.rename(tmp, path)
    ensure
      FileUtils.rm_f(tmp)
    end
  end
  path
end
ep = fetch.call('ERRORPRONE')
sb_zip = fetch.call('SPOTBUGS')
boot = fetch.call('ERRORPRONE_JAVAC') if major == 8
puts "CI 工具：#{version.strip}；Error Prone #{profile.fetch('ERRORPRONE_VERSION')}；SpotBugs #{profile.fetch('SPOTBUGS_VERSION')}（SHA-256 已校驗）"
$stdout.sync = true
results = []
failures = []
Dir.mktmpdir('java-ci-tools-') do |work|
  # 每次從已校驗封裝重新展開，避免信任遭修改的解壓快取。
  sb_dir = File.join(work, 'spotbugs')
  FileUtils.mkdir_p(sb_dir)
  out, st = Open3.capture2e(jar, 'xf', sb_zip, chdir: sb_dir)
  abort "SpotBugs 展開失敗：#{out}" unless st.success?
  sb = Dir[File.join(sb_dir, 'spotbugs-*/lib/spotbugs.jar')].fetch(0)
  # 候選只在驗收時加入；消費端 include.xml 不啟用它們。
  filter = REXML::Document.new('<FindBugsFilter/>')
  %w[include.xml include-candidates.xml].each do |name|
    REXML::Document.new(File.read(File.join(base, 'spotbugs', name))).root.elements.each do |node|
      filter.root.add_element(node.deep_clone)
    end
  end
  test_filter = File.join(work, 'include-all.xml')
  File.write(test_filter, filter.to_s)
  lint_source = File.join(work, 'Lint.java')
  File.write(lint_source, 'class Lint { java.util.List raw; }')
  lint_args = ["@#{File.join(base, 'javac', "lint-jdk#{major}.txt")}", '-d', work, lint_source]
  log, st = Open3.capture2e(javac, '-J-Duser.language=en', *lint_args)
  abort "javac lint 設定未產生 rawtypes 診斷：#{log}" unless st.success? && log.include?('[rawtypes]')
  log, st = Open3.capture2e(javac, '-J-Duser.language=en', '-Werror', *lint_args)
  abort "javac lint -Werror 未阻擋：#{log}" if st.success? || !log.include?('[rawtypes]')
  File.write(lint_source, 'class Lint { java.util.List<String> typed; }')
  log, st = Open3.capture2e(javac, '-J-Duser.language=en', '-Werror', *lint_args)
  abort "javac lint 符合例被阻擋：#{log}" unless st.success?
  puts '設定分析：javac lint argument file 正反例與 -Werror 阻擋通過（不計涵蓋率）。'
  vm = if major == 8
         ["-J-Xbootclasspath/p:#{boot}"]
       else
         %w[api file main model parser processing tree util code comp].map { |p| "-J--add-exports=jdk.compiler/com.sun.tools.javac.#{p}=ALL-UNNAMED" } +
           %w[code comp].map { |p| "-J--add-opens=jdk.compiler/com.sun.tools.javac.#{p}=ALL-UNNAMED" }
       end
  opts = ['-XDcompilePolicy=simple']
  opts += ['--should-stop=ifError=FLOW', '-XDaddTypeAnnotationsToSymbol=true'] if major >= 17
  # 啟動測試只驗證鎖定工具與完整政策可分析，不計入原範例涵蓋率。
  smoke = File.join(work, 'Smoke.java')
  File.write(smoke, 'class Smoke { volatile int count; void increment() { count++; new Exception(); } }')
  smoke_classes = File.join(work, 'smoke-classes')
  FileUtils.mkdir_p(smoke_classes)
  flags = File.readlines(File.join(base, 'errorprone', "flags-jdk#{major}.txt")).map(&:strip).reject { |s| s.empty? || s.start_with?('#') }
  # 政策所有 ERROR 改 WARN，避免刻意違反的啟動樣本中止編譯。
  smoke_flags = flags.map { |f| f.sub(/:ERROR$/, ':WARN') }
  log, st = Open3.capture2e(javac, *vm, *opts, '-classpath', ep, '-proc:none', '-d', smoke_classes,
                           "-Xplugin:ErrorProne #{smoke_flags.join(' ')} -Xep:DeadException:WARN", smoke)
  abort "Error Prone 完整政策啟動失敗：#{log}" unless st.success? && log.include?('[DeadException]')
  smoke_xml = File.join(work, 'smoke.xml')
  log, st = Open3.capture2e(java, '-jar', sb, '-textui', '-low', '-xml', '-output', smoke_xml, smoke_classes)
  abort "SpotBugs 啟動分析失敗：#{log}" unless st.success? && File.read(smoke_xml).include?('type="VO_VOLATILE_INCREMENT"')
  puts '啟動分析：Error Prone 完整 flags／DeadException、SpotBugs VO_VOLATILE_INCREMENT 通過（不計涵蓋率）。'
  manifest = JavaExamples.extract(File.join(work, 'examples'))
  compile_cache = {}
  spot_cache = {}
  rows.each do |row|
    id, tool, check = row.values_at('id', 'tool', 'check')
    deprecated = %w[JV-VP-019 JV-VP-020].include?(id)
    examples = manifest.select { |e| "#{e['file']}##{e['anchor']}" == row['rule'] && (e['version'] <= major || deprecated) }
    results_for_row = []
    reason = nil
    unless row['versions'].include?(major)
      reason = "執行 JDK #{major} 不適用此映射"
    end
    reason ||= '原小節沒有此 JDK 可編譯的正反例配對' unless %w[violation compliant].all? { |k| examples.any? { |e| e['kind'] == k } }
    if reason.nil?
      examples.each_with_index do |example, index|
        path = example.fetch('path')
        release = example.fetch('version')
        # 棄用狀態取實際目標平台；原例語法可在 8 起編譯，API 狀態則隨 JDK 改變。
        release = major if %w[JV-VP-019 JV-VP-020].include?(id)
        dest = File.join(work, "#{id}-#{index}")
        FileUtils.mkdir_p(dest)
        source = File.join(dest, 'Snippet.java')
        FileUtils.cp(path, source)
        target = major == 8 ? ['-source', '8', '-target', '8'] : ['--release', release.to_s]
        common = ['-encoding', 'UTF-8', '-proc:none', '-Xlint:-options', *target, '-d', dest, source]
        baseline_key = [path, release]
        unless compile_cache.key?(baseline_key)
          log, st = Open3.capture2e(javac, *common)
          raise "原範例無法編譯 #{id} #{example['kind']}/#{release}：#{log}" unless st.success?
          compile_cache[baseline_key] = dest
        end
        hit = false
        case tool
        when 'javac'
          flags = check.split.reject { |f| f == '-Werror' }
          log, st = Open3.capture2e(javac, '-J-Duser.language=en', '-J-Duser.country=US', *common, *flags)
          if check.start_with?('-Xdoclint:')
            hit = log.match?(/(?:warning|error): (?:no comment|no @param|no @return|no @throws|reference not found|invalid (?:input|use)|malformed HTML|unknown tag|element not closed|unexpected end tag|bad HTML entity)/)
          else
            raise "javac 失敗 #{id}：#{log}" unless st.success?
            categories = check[/\A-Xlint:([^ ]+)/, 1].to_s.split(',')
            hit = categories.include?('all') ? log.match?(/warning: \[/) : categories.any? { |c| log.include?("[#{c}]") }
          end
        when 'errorprone'
          # WARN 保留完整編譯，避免 ERROR 截斷後續診斷；消費端等級另由 flags 檔控制。
          log, st = Open3.capture2e(javac, *vm, *common, '-classpath', ep, *opts,
                                   "-Xplugin:ErrorProne -XepDisableAllChecks -Xep:#{check}:WARN")
          if log.include?("#{check} is not a valid checker name")
            reason = "Error Prone #{profile['ERRORPRONE_VERSION']} 無 #{check}"
            break
          end
          raise "Error Prone 執行失敗 #{id}：#{log}" unless st.success?
          hit = log.include?("[#{check}]")
        when 'spotbugs'
          unless spot_cache.key?(baseline_key)
            xml = File.join(dest, 'spotbugs.xml')
            log, st = Open3.capture2e(java, '-jar', sb, '-textui', '-effort:max', '-low', '-xml:withMessages',
                                     '-include', test_filter,
                                     '-exclude', File.join(base, 'spotbugs/exclude.xml'),
                                     '-output', xml, compile_cache.fetch(baseline_key))
            raise "SpotBugs 執行失敗 #{id}：#{log}" unless st.success? && File.file?(xml)
            doc = REXML::Document.new(File.read(xml))
            errors = doc.elements['BugCollection/Errors']
            raise "SpotBugs 分析不完整 #{id}：#{errors}" if errors && (errors.attributes['errors'].to_i > 0 || errors.attributes['missingClasses'].to_i > 0)
            spot_cache[baseline_key] = REXML::XPath.match(doc, '//BugInstance').map { |b| b.attributes['type'] }
          end
          hit = spot_cache.fetch(baseline_key).include?(check)
        end
        results_for_row << { 'kind' => example['kind'], 'release' => release, 'hit' => hit }
      end
    end
    bad = results_for_row.select { |e| e['kind'] == 'violation' }
    good = results_for_row.select { |e| e['kind'] == 'compliant' }
    passed = reason.nil? && !bad.empty? && !good.empty? && bad.all? { |e| e['hit'] } && good.none? { |e| e['hit'] }
    # verified 的已驗證目標平台不得回歸；沒有原配對的舊 JDK 明示未驗證，不冒稱通過。
    expected = row['note'][/CI實證JDK=([0-9,]+)/, 1].to_s.split(',').map(&:to_i)
    failures << id if row['status'] == 'verified' && expected.include?(major) && !passed
    label = passed ? '通過' : (reason ? '未驗證' : '局部／未命中')
    detail = reason || "違反 #{bad.count { |e| e['hit'] }}/#{bad.size}；符合誤報 #{good.count { |e| e['hit'] }}/#{good.size}"
    puts "#{id} #{tool}/#{check}：#{label}；#{detail}"
    results << { 'id' => id, 'jdk' => major, 'passed' => passed, 'reason' => reason, 'examples' => results_for_row }
  rescue StandardError => e
    failures << id
    warn "#{id} 工具／範例錯誤：#{e.message}"
    results << { 'id' => id, 'jdk' => major, 'passed' => false, 'error' => e.message }
  end
end
if ARGV.length == 2 && ARGV.first == '--json'
  File.write(ARGV.last, JSON.pretty_generate(results) + "\n")
elsif !ARGV.empty?
  abort '用法：ruby run-ci-tools.rb [--json /暫存路徑/results.json]'
end
puts "總結：#{results.size} 筆；正反例通過 #{results.count { |r| r['passed'] }}；未驗證 #{results.count { |r| r['reason'] }}；工具錯誤／verified 回歸 #{failures.uniq.size}。"
exit(failures.empty? ? 0 : 1)
