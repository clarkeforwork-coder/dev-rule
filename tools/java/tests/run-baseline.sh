#!/bin/sh
# 本庫測試可使用 Ruby；消費端 run.sh 不需要 Ruby。
set -eu
base=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
exec ruby - "$base" <<'RUBY'
require 'tmpdir'
require 'open3'
require 'cgi'
base = ARGV.fetch(0)
run = File.join(base, 'baseline/run.sh')
homes = [ENV['JAVA_HOME'] || (`/usr/libexec/java_home -v 17`.strip if File.executable?('/usr/libexec/java_home'))]
java8 = ENV['JAVA8_HOME'] || Dir['/private/tmp/{dev-rule-hook-assets,inv-codex-b/tools}/zulu8*/Contents/Home'].first
homes << java8 if java8
homes = homes.compact.uniq
abort '請指定 JAVA_HOME；完整矩陣另指定 JAVA8_HOME' if homes.empty?
homes.each do |jdk|
  puts "執行期：#{jdk}"
  Dir.mktmpdir('baseline-test') do |dir|
    env = {'JAVA_HOME'=>jdk, 'DEV_RULE_BASELINE_CACHE'=>File.join(dir, 'cache')}
    source = File.join(dir, 'Sample.java')
    baseline = File.join(dir, 'baseline.tsv')
    pmd = File.join(dir, 'pmd.xml')
    cs = File.join(dir, 'checkstyle.xml')
    msg = '[JV-TG-005] 禁止 raw type → rules/stacks/java/common/types-and-generics.md#java-generic-type-information'
    warn = '[JV-ER-031] 例外警告 → rules/stacks/java/common/exceptions-and-resources.md#java-interruption'
    write = lambda do |lines, pmd_rows, cs_rows|
      File.write(source, lines.join("\n") + "\n")
      File.write(pmd, '<pmd><file name="Sample.java">' + pmd_rows.map { |line| "<violation beginline=\"#{line}\" priority=\"1\">#{CGI.escapeHTML(msg)}</violation>" }.join + '</file></pmd>')
      File.write(cs, '<checkstyle><file name="Sample.java">' + cs_rows.map { |line, severity| "<error line=\"#{line}\" severity=\"#{severity}\" message=\"#{CGI.escapeHTML(severity == 'error' ? msg : warn)}\"/>" }.join + '</file></checkstyle>')
    end
    call = lambda do |name, command, expected, extra=[]|
      output, status = Open3.capture2e(env, run, command, '--baseline', baseline, '--pmd', pmd, '--checkstyle', cs, *extra, chdir: dir)
      puts "#{name}（預期 #{expected}，實際 #{status.exitstatus}）\n#{output}"
      abort "失敗：#{name}" unless status.exitstatus == expected
      output
    end
    lines = ['class Sample {', '  java.util.List old;', '  // 固定分隔', '  java.util.List other;', '}']
    write.call(lines, [2], [[4, 'error']])
    call.call('建立既有違規', 'create', 0, ['--owner', 'team-java', '--due', '2027-03-01'])
    original = File.read(baseline)
    File.write(baseline, original.sub('baseline-v2', 'baseline-v1'))
    call.call('拒絕舊版單行指紋', 'check', 2)
    File.write(baseline, original)
    call.call('既有違規通過', 'check', 0)
    call.call('禁止覆蓋基準', 'create', 2, ['--owner', 'team-java', '--due', '2027-03-01'])
    shifted = [ '', '', '' ] + lines
    write.call(shifted, [5], [[7, 'error']])
    call.call('上方插入三行', 'check', 0)
    adjacent = shifted.dup.insert(5, '  // 相鄰行新增註解')
    write.call(adjacent, [5], [[8, 'error']])
    output = call.call('相鄰行插入須審查', 'check', 1)
    abort '新增診斷未印指紋' unless output.match?(/sha256=[0-9a-f]{64}/)
    call.call('相鄰行插入後 rekey 成功', 'rekey', 0)
    rekeyed = File.read(baseline)
    abort 'rekey 未只更新指紋' unless original.lines.zip(rekeyed.lines).all? { |a,b| a.start_with?('#') ? a == b : a.split("\t").values_at(0,1,2,4,5,6,7,8) == b.split("\t").values_at(0,1,2,4,5,6,7,8) }
    abort 'rekey 未改變指紋' if rekeyed == original
    call.call('rekey 後 check 通過', 'check', 0)
    call.call('rekey 無變動可重跑', 'rekey', 0)
    File.write(baseline, original)
    real_added = adjacent.dup.insert(9, '  java.util.List fresh;')
    write.call(real_added, [5, 10], [[8, 'error']])
    call.call('同檔同規則新增真違規 rekey 拒絕', 'rekey', 1)
    abort '拒絕的 rekey 修改基準' unless File.read(baseline) == original
    write.call(adjacent, [5, 5], [[8, 'error']])
    call.call('rekey 次數不等拒絕', 'rekey', 1)
    abort '次數不等修改基準' unless File.read(baseline) == original
    write.call(shifted, [5], [[7, 'error']])
    File.write(cs, File.read(cs).sub('severity="error"', 'severity="warning"'))
    call.call('rekey 同規則等級改變拒絕', 'rekey', 1)
    abort '等級改變修改基準' unless File.read(baseline) == original
    added = shifted.dup.insert(8, '  java.util.List fresh;')
    write.call(added, [5, 9], [[7, 'error']])
    output = call.call('只列新增違規', 'check', 1)
    abort '列出舊違規或未列新違規' unless output.include?('Sample.java:9 ') && !output.include?('Sample.java:5 ') && !output.include?('Sample.java:7 ')
    call.call('prune 不吸收新增違規', 'prune', 1)
    abort '失敗的 prune 修改基準' unless original == File.read(baseline)
    duplicate = shifted.dup.insert(8, '  java.util.List old;')
    write.call(duplicate, [5, 9], [[7, 'error']])
    call.call('相同內容新增一筆仍失敗', 'check', 1)
    fixed = shifted.dup
    fixed[4] = '  java.util.List<String> old;'
    write.call(fixed, [], [[7, 'error']])
    call.call('已清償預設阻擋', 'check', 1)
    call.call('可明確容許已清償', 'check', 0, ['--allow-stale'])
    call.call('移除已清償違規', 'prune', 0)
    abort 'prune 未縮小基準或未保留責任' unless File.size(baseline) < original.bytesize && File.read(baseline).include?("team-java\t2027-03-01")
    call.call('清償後通過', 'check', 0)
    write.call(shifted, [5], [[7, 'error']])
    call.call('已清償違規復發失敗', 'check', 1)
    write.call(fixed, [], [[7, 'error'], [5, 'warning']])
    call.call('新 warning 不阻擋', 'check', 0)
    File.write(pmd, '<pmd><error filename="Sample.java" msg="解析失敗"/></pmd>')
    call.call('工具錯誤不可被過濾', 'check', 2)
    File.write(pmd, '<!DOCTYPE pmd [<!ENTITY x SYSTEM "file:///etc/passwd">]><pmd/>')
    call.call('拒絕 XML 外部實體', 'check', 2)
    File.delete(pmd)
    call.call('缺少報告失敗', 'check', 2)
    File.delete(baseline)
    swap = ['void a() {', '  workA();', '} catch (Exception e) {', '  recoverA();', '}',
            'void b() {', '  workB();', '} catch (Exception e) {', '  recoverB();', '}']
    write.call(swap, [3], [])
    call.call('建立上下文基準', 'create', 0, ['--owner', 'team-java', '--due', '2001-01-01'])
    output = call.call('到期警告', 'check', 0)
    abort '缺少到期資訊' unless output.include?('基準已逾期：Sample.java') && output.include?('due=2001-01-01')
    write.call(swap, [8], [])
    call.call('同檔同規則同內容一修一增不得抵銷', 'check', 1)
    write.call(swap, [3], [])
    File.write(pmd, File.read(pmd).sub('</pmd>', '<suppressedviolation filename="Sample.java" suppressiontype="nopmd"><message>approved</message><usermsg>reason</usermsg></suppressedviolation></pmd>'))
    output = call.call('PMD 核准抑制可並存', 'check', 0)
    abort '未統計抑制' unless output.include?('略過 PMD 已抑制診斷：1 筆')
    File.write(pmd, File.read(pmd).gsub('suppressedviolation', 'unknown'))
    call.call('未知元素仍拒絕', 'check', 2)
    write.call(swap, [3], [])
    File.binwrite(source, "\xA4\x40")
    output = call.call('非 UTF-8 帶檔名', 'check', 2)
    abort '未列來源檔名' unless output.include?('Sample.java') && output.include?('UTF-8')
    puts '全部基準情境通過'

  end
end
puts '提示：未設定 JAVA8_HOME，此次只驗證目前 JDK；完整驗收須另跑 JDK 8。' unless java8 || homes.any? { |h| h.include?('zulu8') }
if ENV['BASELINE_BUILD_INTEGRATION'] == '1'
require 'tmpdir'
require 'fileutils'
require 'open3'
root=File.expand_path('../..', base)
Dir.mktmpdir('c3-integration-') do |dir|
 FileUtils.mkdir_p("#{dir}/vendor"); File.symlink(root,"#{dir}/vendor/dev-rule")
 FileUtils.mkdir_p("#{dir}/src/main/java")
 src="#{dir}/src/main/java/Probe.java"
 File.write(src,"final class Probe { void consume(java.util.List values) {} }\n")
 FileUtils.cp("#{root}/tools/java/ci/maven/pom-fragment.xml", "#{dir}/pom.xml")
 File.write("#{dir}/settings.gradle.kts", "rootProject.name = \"baseline-probe\"\n")
 File.write("#{dir}/build.gradle.kts", "plugins { java }\nrepositories { mavenCentral() }\napply(from = \"vendor/dev-rule/tools/java/ci/gradle/rules.gradle.kts\")\n")
 baseline="#{dir}/dev-rule-baseline.tsv"
 env={'JAVA_HOME'=>homes.first}
 [['maven',[ENV.fetch('MAVEN_BIN', 'mvn'),'-B','-Pdev-rule-baseline','verify'],['target/pmd.xml','target/checkstyle-result.xml']], ['gradle',[ENV.fetch('GRADLE_BIN', 'gradle'),'-PdevRuleBaseline','check','--no-daemon','--console=plain'],['build/reports/pmd/main.xml','build/reports/checkstyle/main.xml']]].each do |tool,cmd,reports|
  File.write(src,"final class Probe { void consume(java.util.List values) {} }\n")
  File.delete(baseline) if File.exist?(baseline)
  output,status=Open3.capture2e(env,*cmd,chdir:dir)
  abort "#{tool} 未產生報告：#{output}" unless reports.all?{|p|File.file?("#{dir}/#{p}")}
  puts "#{tool} 缺少基準 exit=#{status.exitstatus}"
  abort '缺少基準竟通過' if status.success?
  output,status=Open3.capture2e(env,"#{root}/tools/java/baseline/run.sh",'create','--baseline',baseline,'--pmd',reports[0],'--checkstyle',reports[1],'--owner','team-java','--due','2027-03-01',chdir:dir)
  puts output; abort 'create 失敗' unless status.success?
  output,status=Open3.capture2e(env,*cmd,chdir:dir)
  puts "#{tool} 既有違規 exit=#{status.exitstatus}"
  abort output unless status.success?
  if tool == 'gradle'
    output,status=Open3.capture2e(env,*cmd,'-x','pmdMain',chdir:dir)
    puts "gradle 排除必要工作 exit=#{status.exitstatus}"
    abort output if status.success? || !output.include?('基準必要工作被排除')
  end
  File.write(src,"final class Probe { void consume(java.util.List values) {} void another(java.util.List other) {} }\n")
  output,status=Open3.capture2e(env,*cmd,chdir:dir)
  puts "#{tool} 新增違規 exit=#{status.exitstatus}"
  abort output if status.success? || !output.include?('新增 error：')
 end
end
end
RUBY
