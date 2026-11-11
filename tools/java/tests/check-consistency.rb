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
    document = REXML::Document.new(File.read(File.join(root, 'tools/java', tool, filename)))
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
      id = tool == 'pmd' ? messages.first.to_s[/\A\[(JV-[A-Z]+-\d{3})\]/, 1] : props['id']
      row = expected.find { |r| r['id'] == id }
      check.call(!row.nil?, "#{tool}/#{filename} 未登錄或集合錯誤：#{id || node.attributes['name']}")
      next unless row
      seen << id
      prefix = "[#{id}] #{row['title']} → #{row['rule']}"
      check.call(!messages.empty? && messages.all? { |m| m.start_with?(prefix) }, "#{id} 訊息 ID／錨點錯誤")
      if tool == 'pmd'
        ref = row['check'].start_with?('custom:') ? "rules/#{PmdRulesets.name(row)}.xml/#{PmdRulesets.name(row)}" : row['check']
        check.call(node.attributes['ref'] == ref && node.attributes['name'] == PmdRulesets.runtime_name(row), "#{id} PMD 規則引用錯誤")
        check.call(node.elements['priority']&.text == (row['level'] == 'error' ? '1' : '3'), "#{id} PMD 等級錯誤")
        check.call(node.attributes['externalInfoUrl'].to_s.end_with?("/#{row['rule']}"), "#{id} URL 錨點錯誤")
      else
        check.call(node.attributes['name'] == row['check'].split('[').first, "#{id} Checkstyle 模組錯誤")
        check.call(props['severity'] == (row['level'] == 'error' ? 'error' : 'warning'), "#{id} Checkstyle 等級錯誤")
        if row['check'].include?('[illegalClassNames=')
          names = row['check'][/\[illegalClassNames=(.*)\]/, 1].split(',')
          check.call(props['illegalClassNames'].to_s.split(',').sort == (names + names.map { |n| "java.lang.#{n}" }).sort, "#{id} 捕捉類別設定錯誤")
        end
      end
    end
    check.call(seen.sort == expected.map { |r| r['id'] }.sort, "#{tool}/#{filename} 缺少或重複映射：#{expected.map { |r| r['id'] } - seen}")
    puts "#{tool}/#{filename}：#{nodes.size} 規則，#{expected.size} 映射"
  end
end
custom = rows.select { |r| r['tool'] == 'pmd' && r['check'].start_with?('custom:') }.group_by { |r| PmdRulesets.name(r) }
paths = Dir[File.join(root, 'tools/java/pmd/rules/*.xml')]
check.call(paths.map { |p| File.basename(p, '.xml') }.sort == custom.keys.sort, 'PMD 自訂定義存在額外／缺少規則')
custom.each do |name, group|
  path = File.join(root, 'tools/java/pmd/rules', "#{name}.xml")
  next unless File.file?(path)
  doc = REXML::Document.new(File.read(path))
  xpath = doc.root.elements['rule/properties/property[@name="xpath"]/value']&.text
  check.call(group.all? { |r| r['xpath'] == xpath }, "#{name} XPath 與 rule-map 不一致")
end
puts errors.empty? ? '一致性：零問題（雙向映射、候選隔離、訊息、等級、XPath）。' : errors.join("\n")
exit(errors.empty? ? 0 : 1)
