#!/usr/bin/env ruby
# frozen_string_literal: true
require 'yaml'
require 'cgi'
require 'fileutils'

module PmdRulesets
  ROOT = File.expand_path('../../..', __dir__)
  HEADER = <<~XML
    <?xml version="1.0" encoding="UTF-8"?>
    <ruleset name="Java 共通規範" xmlns="http://pmd.sourceforge.net/ruleset/2.0.0"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="http://pmd.sourceforge.net/ruleset/2.0.0 https://pmd.sourceforge.io/ruleset_2_0_0.xsd">
      <description>依 tools/java/rule-map.yml 建立；候選規則不在預設集合。</description>
  XML
  def self.escape(value)
    CGI.escapeHTML(value.to_s)
  end
  def self.name(row)
    row.fetch('check').split(/[\/:]/).last
  end
  def self.runtime_name(row)
    return name(row) if row['check'].start_with?('custom:')
    @mapping_counts ||= YAML.load_file(File.join(ROOT, "tools/java/rule-map.yml"))
                            .select { |r| r["tool"] == "pmd" }
                            .group_by { |r| r["check"] }.transform_values(&:size)
    duplicated = @mapping_counts.fetch(row.fetch("check")) > 1
    duplicated ? "#{name(row)}_#{row.fetch("id").tr("-", "_")}" : name(row)
  end
  def self.reference(row)
    row['check']
  end
  def self.rule(rows, ref: nil, definition: false)
    first = rows.first
    message = rows.map { |r| "[#{r['id']}] #{r['title']} → #{r['rule']}" }.join('；')
    attrs = if definition
              %(name="#{name(first)}" language="java" class="net.sourceforge.pmd.lang.rule.xpath.XPathRule")
            else
              %(ref="#{escape(ref || reference(first))}" name="#{runtime_name(first)}")
            end
    xml = "  <!-- #{rows.map { |r| r['id'] }.join('、')} -->\n"
    xml += "  <rule #{attrs} message=\"#{escape(message)}\" externalInfoUrl=\"https://github.com/clarkeforwork-coder/dev-rule/blob/main/#{escape(first['rule'])}\">\n"
    xml += "    <description>#{escape(first['note'])}</description>\n" if definition
    xml += "    <priority>#{rows.any? { |r| r['level'] == 'error' } ? 1 : 3}</priority>\n"
    if definition
      xml += "    <properties>\n      <property name=\"xpath\"><value><![CDATA[#{first.fetch('xpath')}]]></value></property>\n    </properties>\n"
    end
    # note 僅提議可放寬的屬性，不代表已核准放寬；保留內建預設。
    xml + "  </rule>\n"
  end
  def self.build
    rows = YAML.load_file(File.join(ROOT, 'tools/java/rule-map.yml')).select { |r| r['tool'] == 'pmd' }
    { 'ruleset.xml' => rows.reject { |r| r['status'] == 'candidate' },
      'ruleset-candidates.xml' => rows.select { |r| r['status'] == 'candidate' } }.each do |file, selected|
      body = selected.group_by { |r| r['check'].start_with?('custom:') ? r['check'] : r['id'] }.values.map do |group|
        custom = group.first['check'].start_with?('custom:')
        raise "#{name(group.first)} 的 XPath 不一致" if custom && !group.map { |r| r['xpath'] }.uniq.one?
        rule(group, definition: custom)
      end.join
      if file == 'ruleset-candidates.xml'
        body = "  <!-- JV-SR-006 ExhaustiveSwitchHasDefault 的訊息由內建規則動態產生，message 覆寫無效；不得直接升正式，須先修訊息與 report.awk 相容性。 -->\n" + body
      end
      File.write(File.join(__dir__, file), HEADER + body + "</ruleset>\n")
    end
  end
end
PmdRulesets.build if $PROGRAM_NAME == __FILE__
