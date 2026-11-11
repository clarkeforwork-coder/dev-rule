#!/usr/bin/env ruby
# 合成證據只支援 partial，不提升 verified。
require 'tmpdir'
require 'open3'
require 'json'
require 'rexml/document'
root = File.expand_path('../../..', __dir__)
Dir.mktmpdir('java-synthetic-') do |dir|
  source = File.join(dir, 'Probe.java')
  File.write(source, <<~JAVA)
    import java.util.List;
    class Probe {
      void bad(List<String> values) {
        values.parallelStream().count();
        try { run(); } catch (Throwable failure) { throw failure; }
        try { run(); } catch (Error failure) { throw failure; }
      }
      void good(List<String> values) {
        values.stream().count();
        try { run(); } catch (IllegalArgumentException failure) { throw failure; }
      }
      void run() {}
    }
  JAVA
  pmd = ENV.fetch('PMD_BIN', File.join(root, 'tools/java/tests/pmd-cli.sh'))
  output, errors, status = Open3.capture3(pmd, 'check', '-d', source, '-R', File.join(root, 'tools/java/pmd/ruleset.xml'), '-f', 'json', '--no-cache')
  raise "PMD 失敗：#{output}" unless [0, 4].include?(status.exitstatus)
  data = JSON.parse(output)
  raise 'PMD 解析失敗' unless data.fetch('processingErrors', []).empty? && data.fetch('configurationErrors', []).empty?
  hits = data.fetch('files').flat_map { |f| f['violations'] }.select { |v| v['rule'] == 'ParallelStreamUsage' }
  raise "JV-LS-013 命中不符：#{hits}" unless hits.map { |v| v['beginline'] } == [4]
  puts '合成樣本 JV-LS-013：parallelStream 命中 1，stream 命中 0（partial）。'
  output, status = Open3.capture2e(File.join(root, 'tools/java/hooks/toolbox.sh'), 'checkstyle', '-c', File.join(root, 'tools/java/checkstyle/checkstyle.xml'), '-f', 'xml', source)
  xml = output[/<\?xml.*<\/checkstyle>/m]
  raise "Checkstyle 無效：#{output}" unless xml && status.exitstatus == 2
  hits = REXML::XPath.match(REXML::Document.new(xml), '//error').select { |e| e.attributes['source'] == 'JV-ER-008' }
  raise "JV-ER-008 命中不符：#{hits}" unless hits.map { |e| e.attributes['line'].to_i }.sort == [5, 6] && hits.all? { |e| e.attributes['severity'] == 'error' }
  puts '合成樣本 JV-ER-008：Throwable／Error 各命中 1，具體例外命中 0（partial）。'
end
