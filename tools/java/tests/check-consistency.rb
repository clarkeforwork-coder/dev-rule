#!/usr/bin/env ruby
# frozen_string_literal: true
require 'yaml'
require 'rexml/document'
require_relative '../pmd/build-rulesets'
root = PmdRulesets::ROOT
rows = YAML.load_file(File.join(root, 'tools/java/rule-map.yml'))
errors = []
check = ->(ok, message) { errors << message unless ok }
%w[pmd checkstyle].each do |tool|
  %w[active candidate].each do |set|
    candidate = set == 'candidate'
    filename = tool == 'pmd' ? (candidate ? 'ruleset-candidates.xml' : 'ruleset.xml') : (candidate ? 'candidates.xml' : 'checkstyle.xml')
    content = File.read(File.join(root, 'tools/java', tool, filename))
    document = REXML::Document.new(content)
    expected = rows.select { |r| r['tool'] == tool && (candidate ? r['status'] == 'candidate' : %w[verified partial].include?(r['status'])) }
    nodes = if tool == 'pmd'
              document.root.get_elements('rule')
            else
              REXML::XPath.match(document, '//module').reject { |n| %w[Checker TreeWalker SuppressionFilter].include?(n.attributes['name']) }
            end
    seen = []
    nodes.each do |node|
      props = node.get_elements('property').to_h { |p| [p.attributes['name'], p.attributes['value']] }
      messages = tool == 'pmd' ? [node.attributes['message']] : node.get_elements('message').map { |m| m.attributes['value'] } + [props['message']].compact
      ids = tool == 'pmd' ? messages.first.to_s.scan(/\[(JV-[A-Z]+-\d{3})\]/).flatten : [props['id']]
      group = expected.select { |r| ids.include?(r['id']) }
      check.call(!ids.empty? && group.size == ids.size, "#{tool}/#{filename} 未登錄或集合錯誤：#{ids}")
      seen.concat(ids)
      next if group.empty?
      group.each do |row|
        id = row['id']
        prefix = "[#{id}] #{row['title']} → #{row['rule']}"
        check.call(!messages.empty? && messages.all? { |m| m.to_s.split('；').include?(prefix) || m.to_s.start_with?(prefix) }, "#{id} 訊息 ID／錨點錯誤")
        if tool == 'pmd'
          custom = row['check'].start_with?('custom:')
          check.call(node.attributes['name'] == PmdRulesets.runtime_name(row), "#{id} PMD 名稱錯誤")
          check.call(custom ? node.attributes['ref'].nil? : node.attributes['ref'] == row['check'], "#{id} PMD 規則引用錯誤")
          if custom
            check.call(node.attributes['class'] == 'net.sourceforge.pmd.lang.rule.xpath.XPathRule', "#{id} 自訂規則非內嵌 XPath")
            check.call(node.elements['properties/property[@name="xpath"]/value']&.text == row['xpath'], "#{id} XPath 與 rule-map 不一致")
          end
          check.call(node.elements['priority']&.text == (group.any? { |r| r['level'] == 'error' } ? '1' : '3'), "#{id} PMD 等級錯誤")
          check.call(node.attributes['externalInfoUrl'].to_s.end_with?("/#{group.first['rule']}"), "#{id} URL 錨點錯誤")
        else
          check.call(node.attributes['name'] == row['check'].split('[').first, "#{id} Checkstyle 模組錯誤")
          check.call(props['severity'] == (row['level'] == 'error' ? 'error' : 'warning'), "#{id} Checkstyle 等級錯誤")
          if row['check'].include?('[illegalClassNames=')
            names = row['check'][/\[illegalClassNames=(.*)\]/, 1].split(',')
            check.call(props['illegalClassNames'].to_s.split(',').sort == (names + names.map { |n| "java.lang.#{n}" }).sort, "#{id} 捕捉類別設定錯誤")
          end
        end
      end
    end
    check.call(seen.sort == expected.map { |r| r['id'] }.sort, "#{tool}/#{filename} 缺少或重複映射：#{expected.map { |r| r['id'] } - seen}")
    if tool == 'pmd'
      names = nodes.map { |n| n.attributes['name'] }
      check.call(names.uniq == names, "#{filename} 重複執行名稱")
      if candidate
        check.call(content.include?('JV-SR-006 ExhaustiveSwitchHasDefault') && content.include?('message 覆寫無效'), '候選動態訊息限制未註明')
      end
    end
    puts "#{tool}/#{filename}：#{nodes.size} 規則，#{expected.size} 映射"
  end
end
check.call(!Dir.exist?(File.join(root, 'tools/java/pmd/rules')), '不應有獨立 PMD 自訂規則副本')
ci_rows = rows.select { |r| %w[javac errorprone spotbugs].include?(r['tool']) }
ci_rows.select { |r| r['status'] == 'verified' }.each do |row|
  check.call(row['note'].match?(/CI實證JDK=(?:8|11|17|21)(?:,(?:8|11|17|21))*；/), "#{row['id']} 缺少 CI 實證平台")
end
%w[include include-candidates].each do |set|
  content = File.read(File.join(root, "tools/java/spotbugs/#{set}.xml"))
  patterns = REXML::XPath.match(REXML::Document.new(content), '//Bug').map { |n| n.attributes['pattern'] }
  expected = rows.select { |r| r['tool'] == 'spotbugs' && (set == 'include-candidates' ? r['status'] == 'candidate' : %w[verified partial].include?(r['status'])) }
  check.call(patterns.sort == expected.map { |r| r['check'] }.uniq.sort, "SpotBugs #{set} 集合不符或重複")
  expected.each { |r| check.call(content.include?("[#{r['id']}] #{r['title']} → #{r['rule']}"), "#{r['id']} SpotBugs 訊息註解不符") }
end
properties = File.readlines(File.join(root, 'tools/java/spotbugs/pattern-map.properties')).reject { |s| s.start_with?('#') || s.strip.empty? }
mapping = properties.to_h do |line|
  key, value = line.strip.split('=', 2)
  [key, value.gsub(/\\u([0-9a-f]{4})/i) { [$1.to_i(16)].pack('U') }]
end
expected = rows.select { |r| r['tool'] == 'spotbugs' }.group_by { |r| r['check'] }.transform_values do |group|
  group.map { |r| "[#{r['id']}] #{r['title']} → #{r['rule']}" }.join('；')
end
check.call(mapping == expected && mapping.size == properties.size, 'SpotBugs pattern-map 缺漏、重複或訊息不符')
[8, 11, 17, 21].each do |jdk|
  content = File.read(File.join(root, "tools/java/errorprone/flags-jdk#{jdk}.txt"))
  active = content.lines.map(&:strip).reject { |s| s.empty? || s.start_with?('#') }
  check.call(active.first == '-XepDisableAllChecks' && active.uniq == active, "Error Prone JDK #{jdk} 預設檢查未關閉或重複參數")
  expected = rows.select { |r| r['tool'] == 'errorprone' }.group_by { |r| r['check'] }
  expected.each do |name, group|
    group.each { |r| check.call(content.include?("[#{r['id']}] #{r['title']} → #{r['rule']}"), "#{r['id']} Error Prone 註解不符") }
    severity = group.any? { |r| r['level'] == 'error' } ? 'ERROR' : 'WARN'
    flag = "-Xep:#{name}:#{severity}"
    unavailable = jdk <= 11 && %w[NonApiType IdentifierName].include?(name)
    enabled = !unavailable && group.any? { |r| %w[partial verified].include?(r['status']) }
    check.call(enabled ? active.include?(flag) : !active.any? { |f| f.start_with?("-Xep:#{name}:") }, "Error Prone #{jdk}/#{name} 候選隔離、版本或等級不符")
  end
  check.call(active.drop(1).all? { |f| f.match?(/\A-Xep:[A-Za-z0-9]+:(?:ERROR|WARN)\z/) && expected.key?(f.split(':')[1]) }, "Error Prone #{jdk} 未登錄參數")
end
puts "CI 設定：#{ci_rows.size} 映射，SpotBugs 候選隔離／診斷對照與四版 Error Prone 參數。"
puts errors.empty? ? '一致性：零問題（雙向映射、候選隔離、訊息、等級、內嵌 XPath）。' : errors.join("\n")
exit(errors.empty? ? 0 : 1)
