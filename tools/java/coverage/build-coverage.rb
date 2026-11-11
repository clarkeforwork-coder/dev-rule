# frozen_string_literal: true
require 'yaml'
require 'pathname'

ROOT = Pathname.new(__dir__).join('../../..').expand_path
MAP = ROOT.join('tools/java/rule-map.yml')
OUTPUT = ROOT.join('tools/java/coverage/coverage.md')
STATUSES = %w[verified partial candidate manual].freeze
TIERS = %w[pre-commit ci-compile ci-bytecode ci-arch ci-build test manual].freeze
TOOLS = %w[pmd checkstyle javac errorprone spotbugs archunit jdeps jdeprscan maven-enforcer gradle none].freeze
CODES = %w[TG LS NP CC NO VO SR BM CO ER EH ND CA RS VP].zip(%w[types-and-generics lambda-and-stream naming-packages-docs classes-and-construction null-and-optional value-objects states-and-results boundary-mapping collections-and-ownership exceptions-and-resources equality-hashing-ordering numbers-dates-text concurrency-and-async reflection-and-suppression version-policy]).to_h.freeze
FIELDS = %w[id rule title level tier tool check versions status false_positive_risk note source].freeze

def cell(value)
  value.to_s.gsub('&', '&amp;').gsub('<', '&lt;').gsub('>', '&gt;').gsub('|', '&#124;').gsub("\n", '<br>')
end

def table(lines, headers, rows)
  lines << "| #{headers.join(' | ')} |"
  lines << "| #{headers.map { '---' }.join(' | ')} |"
  rows.each { |r| lines << "| #{r.map { |v| cell(v) }.join(' | ')} |" }
  lines << ''
end

abort '用法：ruby tools/java/coverage/build-coverage.rb [--check]' unless ARGV.empty? || ARGV == ['--check']
rows = YAML.safe_load(MAP.read, permitted_classes: [], permitted_symbols: [], aliases: false)
abort 'rule-map 必須是非空陣列' unless rows.is_a?(Array) && !rows.empty?
sections = {}
documents = ROOT.glob('rules/stacks/java/common/*.md').sort
# 只取緊接 java- 錨點的 ###；同一章的相容錨點或驗收表中的錨點不另計。
documents.each do |file|
  file.read.scan(/<a id="(java-[^"]+)"><\/a>\s*\n### ([^\n]+)/) do |anchor,title|
    key = "#{file.relative_path_from(ROOT)}##{anchor}"
    abort "重複小節 #{key}" if sections.key?(key)
    sections[key] = title
  end
end
errors = []
ids = []
keys = []
rows.each_with_index do |r,i|
  unless r.is_a?(Hash)
    errors << "第 #{i+1} 筆不是物件"
    next
  end
  id = r['id']
  ids << id
  errors << "#{id} 欄位不符" unless (r.keys-FIELDS-['xpath']).empty? && (FIELDS-r.keys).empty?
  errors << "#{id} 錨點不屬於 Java 小節：#{r['rule']}" unless sections.key?(r['rule'])
  errors << "#{id} 標題不符" unless sections[r['rule']] == r['title']
  code = CODES.key(File.basename(r['rule'].to_s.split('#').first.to_s,'.md'))
  errors << "#{id} ID 格式／文件縮寫錯誤" unless code && id.to_s.match?(/\AJV-#{code}-\d{3}\z/) && !id.end_with?('-000')
  {'level'=>%w[error warn], 'tier'=>TIERS, 'tool'=>TOOLS, 'status'=>STATUSES, 'false_positive_risk'=>%w[low medium high]}.each do |field,allowed|
    errors << "#{id} #{field} 值錯誤" unless allowed.include?(r[field])
  end
  versions = r['versions']
  errors << "#{id} versions 錯誤" unless versions.is_a?(Array) && !versions.empty? && (versions-[8,11,17,21]).empty? && versions == versions.uniq.sort
  source = r['source']
  errors << "#{id} source 錯誤" unless source.is_a?(Array) && !source.empty? && (source-%w[inv-claude-a inv-codex-a inv-claude-b inv-codex-b]).empty? && source.uniq == source
  errors << "#{id} note 空白" unless r['note'].is_a?(String) && !r['note'].strip.empty?
  check = r['check'].to_s
  errors << "#{id} check 空白" if check.empty?
  errors << "#{id} 自訂名稱不是 PascalCase" if check.start_with?('custom:') && !check.match?(/\Acustom:[A-Z][A-Za-z0-9]*\z/)
  needs_xpath = r['tool']=='pmd' && check.start_with?('custom:')
  errors << "#{id} XPath 欄位不符" unless needs_xpath ? r['xpath'].is_a?(String) && !r['xpath'].empty? : !r.key?('xpath')
  if r['status']=='manual' || r['tool']=='none' || r['tier']=='manual'
    errors << "#{id} 人工欄位不一致" unless r.values_at('status','tool','check') == %w[manual none none] && %w[manual test].include?(r['tier'])
  end
  keys << r.values_at('rule','tool','check')
end
errors << 'ID 重複' unless ids.uniq.size == ids.size
errors << '小節 × 工具規則重複' unless keys.uniq.size == keys.size
missing = sections.keys - rows.map { |r| r.is_a?(Hash) ? r['rule'] : nil }
errors.concat(missing.map { |r| "缺少小節 #{r}" })
rows.select { |r| r.is_a?(Hash) && r.key?('xpath') }.group_by { |r| r['check'] }.each do |check,group|
  errors << "#{check} 同名 XPath 不一致" unless group.map { |r| r['xpath'] }.uniq.size == 1
end
abort errors.join("\n") unless errors.empty?

covered = rows.select { |r| r['status']=='verified' && %w[pmd checkstyle javac errorprone spotbugs].include?(r['tool']) }.map { |r| r['rule'] }.uniq.size
ratio = format('%.2f%%', covered * 100.0 / sections.size)
lines = ['# Java 工具涵蓋率', '', '由 `ruby tools/java/coverage/build-coverage.rb` 產生；請修改 rule-map.yml 後重建，勿直接修改本檔。', '', '## 總表', '']
summary = [['文件數',documents.size],['小節數',sections.size],['映射筆數',rows.size]]
STATUSES.each { |s| summary << ["status：#{s}（筆）",rows.count { |r| r['status']==s }] }
TIERS.each { |t| summary << ["tier：#{t}（筆）",rows.count { |r| r['tier']==t }] }
TOOLS.each { |t| summary << ["tool：#{t}（筆）",rows.count { |r| r['tool']==t }] }
summary << ['本庫 PMD／Checkstyle／javac／Error Prone／SpotBugs verified 小節數',covered]
summary << ['CI 層未 verified（映射筆數；不計涵蓋率）',rows.count { |r| r['tier'].start_with?('ci-') && r['status'] != 'verified' }]
summary << ['涵蓋率（verified 小節／全部小節）',"#{covered}／#{sections.size} = #{ratio}"]
table(lines,%w[項目 數量],summary)
lines += ['每小節只要有一筆本庫可重跑的 PMD／Checkstyle／javac／Error Prone／SpotBugs verified 即計入分子，同小節多規則不重複計數；status／tier／tool 欄則按映射筆數計算。partial、candidate、manual 均不計分子；verified 不代表整個小節、所有版本或所有合法例外都已自動驗證。', '', 'manual 可與 verified 並存，表示該小節仍有工具無法替代的審查或尚待實作的契約測試；candidate 包含失敗候選，不是啟用建議。實證版本、合成範例與漏報限制見 rule-map.yml 的 note。', '']
documents.each do |doc|
  path = doc.relative_path_from(ROOT).to_s
  lines += ["## #{doc.basename}", '']
  table(lines,%w[小節 錨點 等級 tier 工具與規則 status CI層候選],rows.select { |r| r['rule'].start_with?(path+'#') }.map { |r| [r['title'],r['rule'].split('#').last,r['level'],r['tier'],"#{r['tool']}：#{r['check']}（#{r['id']}）",r['status'],r['tier'].start_with?('ci-') ? (r['status'] == 'verified' ? '否（本庫已重跑）' : '是（未達 verified）') : '—'] })
end
lines += ['## 自訂規則清單', '', '同名規則可對應多個小節；XPath 為來源的完整字串，HTML 跳脫只為安全顯示，原值以 YAML 為準。ArchUnit 自訂規則不使用 XPath。', '']
rows.select { |r| r['check'].start_with?('custom:') }.group_by { |r| [r['tool'],r['check']] }.each do |(tool,check),group|
  lines += ["### #{check}", '', "工具：#{tool}；來源：#{group.flat_map { |r| r['source'] }.uniq.join('、')}。", '']
  table(lines,%w[來源小節 status],group.map { |r| [r['rule'],r['status']] })
  lines += ['```xpath',group.first['xpath'],'```',''] if group.first['xpath']
end
{'test' => '測試驗收', 'manual' => '人工審查'}.each do |tier, label|
  lines += ["## 工具未涵蓋的必要內容清單（#{label}）", '', '即使同小節有 verified，這些責任仍不可省略；test 表待實作驗收，不表示已有可執行測試。', '']
  table(lines,%w[小節 錨點 等級 審查／測試內容], rows.select { |r| r['status']=='manual' && r['tier']==tier }.map { |r| [r['title'],r['rule'],r['level'],r['note']] })
end
content = lines.join("\n").rstrip+"\n"
if ARGV == ['--check']
  abort 'coverage.md 已過期；請重新產生' unless OUTPUT.exist? && OUTPUT.read == content
else
  OUTPUT.write(content)
end
puts "通過：#{documents.size} 份文件、#{sections.size} 個 Java 小節。"
puts "通過：#{rows.size} 筆映射的錨點存在、標題相符、ID 唯一、欄位合法。"
puts '通過：全部 Java 小節至少一筆映射；沒有重複的小節 × 工具規則。'
puts '通過：自訂名稱與 XPath 欄位合法，同名 XPath 一致。'
puts "涵蓋率：#{covered}／#{sections.size} = #{ratio}。"
puts ARGV.empty? ? '已更新：tools/java/coverage/coverage.md' : '通過：coverage.md 與 rule-map.yml 一致。'
