#!/usr/bin/env ruby
# frozen_string_literal: true
require 'yaml'
require 'json'
require 'digest'
require 'open3'
require 'tmpdir'
require 'fileutils'
require 'rexml/document'
require_relative 'extract-examples'

ROOT = File.expand_path('../../..', __dir__)
CONFIG = File.join(ROOT, 'tools/java/checkstyle')

def java_for(major)
  home = ENV["JAVA#{major}_HOME"]
  if !home && File.executable?('/usr/libexec/java_home')
    value, status = Open3.capture2e('/usr/libexec/java_home', '-F', '-v', major == 8 ? '1.8' : major.to_s)
    home = value.strip if status.success?
  end
  home ? File.join(home, 'bin/java') : nil
end

def audit(java, jar, config, properties, files)
  output, errors, status = Open3.capture3(java, '-jar', jar, '-c', config, '-p', properties, '-f', 'xml', *files)
  raise "Checkstyle 執行失敗：#{errors}\n#{output}" unless output.include?('<checkstyle')
  document = REXML::Document.new(output)
  raise '缺少 Checkstyle 報告根節點' unless document.root.name == 'checkstyle'
  events = {}
  document.elements.each('checkstyle/file') do |file|
    events[file.attributes['name']] = file.get_elements('error').map { |error| error.attributes.each_with_object({}) { |(key, value), result| result[key] = value.to_s } }
  end
  all = events.values.flatten
  # 正常違規退出碼為 error 數（程序碼最多 255）；不能把 crash 當正常違規。
  expected = all.count { |e| e['severity'] == 'error' } % 256
  raise "異常退出碼 #{status.exitstatus}：#{errors}" unless status.exitstatus == expected
  bad = all.reject { |e| e['source'].to_s.match?(/\AJV-[A-Z]+-\d{3}\z/) && e['message'].to_s.start_with?('[JV-') }
  raise "解析或未映射診斷：#{bad}" unless bad.empty?
  files.each { |file| raise "報告缺少 #{file}" unless events.key?(file) }
  events
end

begin
  versions = JSON.parse(File.read(File.join(CONFIG, 'versions.json')))
  selected = ARGV.empty? ? versions.keys : ARGV
  raise "版本必須是 #{versions.keys.join('、')}" unless (selected - versions.keys).empty?
  cache = ENV.fetch('CHECKSTYLE_CACHE', File.join(Dir.tmpdir, 'dev-rule-checkstyle'))
  FileUtils.mkdir_p(cache)
  rules = YAML.load_file(File.join(ROOT, 'tools/java/rule-map.yml')).select { |r| r['tool'] == 'checkstyle' && r['status'] == 'verified' }
  raise '沒有 verified 映射' if rules.empty?
  config_document = REXML::Document.new(File.read(File.join(CONFIG, 'checkstyle.xml')))
  rules.each do |rule|
    modules = REXML::XPath.match(config_document, '//module').select do |node|
      node.get_elements('property').any? { |p| p.attributes['name'] == 'id' && p.attributes['value'] == rule.fetch('id') }
    end
    raise "模組映射不符：#{rule.fetch('id')}" unless modules.length == 1 && modules.first.attributes['name'] == rule.fetch('check').split('[').first
  end
  failures = 0
  selected.each do |version|
    info = versions.fetch(version)
    jar = File.join(cache, "checkstyle-#{version}-all.jar")
    unless File.file?(jar)
      partial = "#{jar}.download-#{Process.pid}"
      begin
        raise '下載失敗' unless system('curl', '--fail', '--location', '--retry', '2', '--output', partial, info.fetch('url'))
        raise '下載 SHA-256 不符' unless Digest::SHA256.file(partial).hexdigest == info.fetch('sha256')
        File.rename(partial, jar)
      ensure
        FileUtils.rm_f(partial)
      end
    end
    raise "SHA-256 不符：#{jar}" unless Digest::SHA256.file(jar).hexdigest == info.fetch('sha256')
    java = ENV['JAVA_HOME'] ? File.join(ENV['JAVA_HOME'], 'bin/java') : java_for(info.fetch('runtime'))
    fallback = !java && info.fetch('runtime') == 8
    java ||= java_for(17)
    raise '找不到 JDK；請設定 JAVA17_HOME／JAVA8_HOME' unless java
    runtime, status = Open3.capture2e(java, '-version')
    raise '無法讀取 Java 版本' unless status.success?
    major = runtime[/version "(?:1\.)?(\d+)/, 1].to_i
    expected_major = ENV['JAVA_HOME'] ? major : (fallback ? 17 : info.fetch('runtime'))
    raise 'Checkstyle 10 需要 JDK 11+' if version == '10.26.1' && major < 11
    raise "JDK 版本不符：預期 #{expected_major}，實際 #{major}" unless major == expected_major
    puts "Checkstyle #{version}；#{runtime.lines.first.strip}"
    puts '本機沒有 JDK 8；9.3 改用 JDK 17，未驗證 JDK 8 執行期。' if fallback
    puts "來源：#{info.fetch('url')}"
    puts "SHA-256：#{info.fetch('sha256')}"
    Dir.mktmpdir('checkstyle-examples-') do |dir|
      properties = File.join(dir, 'checkstyle.properties')
      File.write(properties, "checkstyle.suppressions.file=#{File.join(CONFIG, 'suppressions.xml')}\n")
      manifest = ENV['JAVA_EXAMPLES_DIR'] ? JSON.parse(File.read(File.join(ENV['JAVA_EXAMPLES_DIR'], 'manifest.json'))) : JavaExamples.extract(File.join(dir, 'examples'))
      cases = rules.flat_map do |rule|
        file, anchor = rule.fetch('rule').split('#')
        examples = manifest.select { |e| e['file'] == file && e['anchor'] == anchor }
        raise "#{rule['id']} 缺少正反例" unless %w[violation compliant].all? { |kind| examples.any? { |e| e['kind'] == kind } }
        examples.map do |e|
          [rule, {'bad' => e['kind'] == 'violation', 'label' => "#{e['kind']} Java #{e['version']}"}, e['path']]
        end
      end
      events = audit(java, jar, File.join(CONFIG, 'checkstyle.xml'), properties, cases.map(&:last).uniq)
      # 候選亦須可載入；此控制樣本不是規範正反例，不計入 verified。
      probe = File.join(dir, 'Probe.java')
      File.write(probe, "final class Probe {}\n")
      audit(java, jar, File.join(CONFIG, 'candidates.xml'), properties, [probe])
      puts '正式與候選設定載入：通過'
      failed_rules = []
      cases.each do |rule, example, path|
        hits = events.fetch(path).select do |e|
          e['message'].start_with?("[#{rule.fetch('id')}]") && e['source'] == rule.fetch('id')
        end
        expected_severity = rule.fetch('level') == 'warn' ? 'warning' : 'error'
        ok = (example.fetch('bad') ? !hits.empty? : hits.empty?) && hits.all? { |e| e['severity'] == expected_severity }
        failed_rules << rule.fetch('id') unless ok
        puts "#{ok ? '通過' : '失敗'} #{rule.fetch('id')} #{rule.fetch('check')} #{example.fetch('label')}：命中 #{hits.length}"
      end
      failed_rules.uniq!
      failures += failed_rules.length
      puts "總結 #{version}：#{rules.length} 筆 verified，#{cases.length} 個範例；#{rules.length - failed_rules.length} 筆通過，#{failed_rules.length} 筆失敗。"
      puts "不符映射：#{failed_rules.join('、')}" unless failed_rules.empty?
    end
  end
  exit(failures.zero? ? 0 : 1)
rescue StandardError => e
  warn "驗證中止：#{e.message}"
  exit 2
end
