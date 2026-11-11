#!/usr/bin/env ruby
# 合成正反例防回歸；不把 partial 自動提升為 verified。
require 'open3'
require 'json'
require 'yaml'
require 'rexml/document'
root = File.expand_path('../../..', __dir__)
base = File.join(__dir__, 'fixtures/synthetic')
rows = YAML.load_file(File.join(root, 'tools/java/rule-map.yml'))
pmd = ENV.fetch('PMD_BIN', File.join(__dir__, 'pmd-cli.sh'))
output, errors, status = Open3.capture3(pmd, 'check', '-d', base, '-R', File.join(root, 'tools/java/pmd/ruleset.xml'), '-f', 'json', '--no-cache', '--use-version', 'java-17')
raise "PMD 失敗：#{errors}\n#{output}" unless [0, 4].include?(status.exitstatus)
data = JSON.parse(output)
raise "PMD 解析失敗：#{data}" unless data.fetch('processingErrors', []).empty? && data.fetch('configurationErrors', []).empty?
pmd_events = data.fetch('files').to_h { |f| [File.expand_path(f['filename']), f['violations']] }
cs_files = Dir[File.join(base, 'JV-*/*.java')].sort
output, status = Open3.capture2e(File.join(root, 'tools/java/hooks/toolbox.sh'), 'checkstyle', '-c', File.join(root, 'tools/java/checkstyle/checkstyle.xml'), '-f', 'xml', *cs_files)
xml = output[/<\?xml.*<\/checkstyle>/m]
raise "Checkstyle 報告無效：#{output}" unless xml
doc = REXML::Document.new(xml)
cs_events = doc.root.get_elements('file').to_h { |f| [File.expand_path(f.attributes['name']), f.get_elements('error')] }
errors = cs_events.values.flatten.count { |e| e.attributes['severity']=='error' }
raise "Checkstyle 異常退出碼 #{status.exitstatus}" unless status.exitstatus == errors % 256
failures = []
Dir[File.join(base, '*/*.java')].sort.each do |file|
  name = File.basename(File.dirname(file))
  bad = File.basename(file).start_with?('bad')
  if name.start_with?('JV-')
    hits = cs_events.fetch(File.expand_path(file)).select { |v| v.attributes['source']==name }
    row = rows.find { |r| r['id']==name }
    severity = row['level']=='error' ? 'error' : 'warning'
    correct = hits.all? { |v| v.attributes['severity']==severity }
  else
    hits = pmd_events.fetch(File.expand_path(file), []).select { |v| v['rule']==name }
    row = rows.find { |r| r['check']=="custom:#{name}" }
    correct = hits.all? { |v| v['priority']==(row['level']=='error' ? 1 : 3) }
  end
  ok = (bad ? !hits.empty? : hits.empty?) && correct
  # 單一 raw 宣告不可因兩筆 rule-map 重複執行。
  ok &&= hits.size == 1 if name=='RawGenericType' && bad
  label = "#{name}/#{File.basename(file)}"
  puts "#{ok ? '通過' : '失敗'} #{label}：命中 #{hits.size}"
  failures << label unless ok
end
puts "合成樣本：#{Dir[File.join(base, '*/*.java')].size} 個，失敗 #{failures.size}。"
exit(failures.empty? ? 0 : 1)
