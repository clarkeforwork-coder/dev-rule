#!/usr/bin/env ruby
# frozen_string_literal: true
require 'yaml'
require 'json'
require 'open3'
require 'tmpdir'
require 'optparse'
require_relative 'extract-examples'
require_relative '../pmd/build-rulesets'

options = { pmd: ENV.fetch('PMD_BIN', 'pmd'), aux: ENV['PMD_AUX_CLASSPATH'] }
OptionParser.new do |parser|
  parser.banner = '用法：ruby run-pmd.rb [--pmd /路徑/bin/pmd] [--output 暫存目錄] [--aux-classpath 路徑]'
  parser.on('--pmd PATH') { |value| options[:pmd] = value }
  parser.on('--output DIR') { |value| options[:output] = value }
  parser.on('--aux-classpath PATH') { |value| options[:aux] = value }
end.parse!
abort '不接受額外參數' unless ARGV.empty?
options[:output] ||= Dir.mktmpdir('pmd-examples-')
FileUtils.mkdir_p(options[:output])
version, status = Open3.capture2e(options[:pmd], '--version')
abort "無法執行 PMD：#{version}" unless status.success? && version.match?(/PMD 7\.29\.0\b/)
puts "工具：#{version.lines.find { |line| line.include?('PMD ') }&.strip}"
puts "範例與原始報告：#{File.expand_path(options[:output])}"
manifest = ENV['JAVA_EXAMPLES_DIR'] ? JSON.parse(File.read(File.join(ENV['JAVA_EXAMPLES_DIR'], 'manifest.json'))) : JavaExamples.extract(options[:output])
puts "抽取：#{manifest.size} 個範例，#{manifest.map { |e| e['file'] }.uniq.size} 份文件"
rows = YAML.load_file(File.join(JavaExamples::ROOT, 'tools/java/rule-map.yml')).select do |row|
  row['tool'] == 'pmd' && %w[verified partial].include?(row['status'])
end
hits = Hash.new { |hash, key| hash[key] = [] }
errors = {}
infrastructure_failures = []
manifest.group_by { |example| example['version'] }.sort.each do |java, examples|
  list = File.join(options[:output], "java-#{java}.txt")
  report = File.join(options[:output], "pmd-java-#{java}.json")
  File.write(list, examples.map { |e| e['path'] }.join("\n") + "\n")
  command = [options[:pmd], 'check', '--file-list', list, '--rulesets',
             File.join(JavaExamples::ROOT, 'tools/java/pmd/ruleset.xml'),
             '--use-version', "java-#{java}", '--format', 'json', '--report-file', report,
             '--no-cache', '--threads', '1']
  command += ['--aux-classpath', options[:aux]] if options[:aux]
  output, result = Open3.capture2e(*command)
  File.write(File.join(options[:output], "pmd-java-#{java}.log"), output)
  begin
    data = JSON.parse(File.read(report))
    data.fetch('files').each { |file| hits[File.expand_path(file.fetch('filename'))] = file.fetch('violations') }
    data.fetch('processingErrors', []).each { |error| errors[File.expand_path(error.fetch('filename'))] = error['message'] }
    config_errors = data.fetch('configurationErrors', [])
    unless [0, 4].include?(result.exitstatus) && config_errors.empty? && data.fetch('processingErrors', []).empty?
      infrastructure_failures << "Java #{java} 執行失敗（結束碼 #{result.exitstatus}）：#{config_errors.to_json}；詳 #{report} 與同名 log"
    end
  rescue JSON::ParserError, Errno::ENOENT, KeyError => error
    infrastructure_failures << "Java #{java} 報告無效：#{error.message}；#{output}"
  end
end
passed = failed = partial = 0
rows.each do |row|
  file, anchor = row.fetch('rule').split('#')
  name = PmdRulesets.runtime_name(row)
  examples = manifest.select { |e| e['file'] == file && e['anchor'] == anchor }
  problems = []
  %w[violation compliant].each do |kind|
    problems << "缺少 #{kind} 規範範例" unless examples.any? { |e| e['kind'] == kind }
  end
  observations = examples.map do |example|
    count = hits[example['path']].count { |hit| hit['rule'] == name }
    expected = example['kind'] == 'violation' ? count.positive? : count.zero?
    label = File.basename(example['path'], '.java')
    problems << "#{label} 解析失敗：#{errors[example['path']]}" if errors.key?(example['path'])
    problems << "#{label} 預期#{example['kind'] == 'violation' ? '命中' : '不命中'}，實際 #{count}" unless expected
    "#{label}=#{count}"
  end
  if row['status'] == 'partial'
    partial += 1
    state = '部分（僅報告）'
  elsif problems.empty? && infrastructure_failures.empty?
    passed += 1
    state = '通過'
  else
    failed += 1
    state = '失敗'
  end
  puts "#{state} #{row['id']} #{name}：#{observations.join('、')}"
  problems.each { |problem| puts "  #{problem}" }
end
infrastructure_failures.each { |failure| puts "工具錯誤：#{failure}" }
puts "總結：verified 通過 #{passed}／失敗 #{failed}；partial #{partial} 筆（不計失敗）；工具錯誤 #{infrastructure_failures.size}"
exit(failed.zero? && infrastructure_failures.empty? ? 0 : 1)
