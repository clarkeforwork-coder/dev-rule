# frozen_string_literal: true
# 常駐結構檢查；--batch 搭配 --baseline、--target 執行批次差異檢查。
require 'open3'
require 'pathname'
require 'json'
require 'optparse'

Dir.chdir(File.expand_path('..', __dir__))
options = {}
OptionParser.new do |parser|
  parser.banner = '用法：ruby scripts/verify-acceptance.rb [--batch N --baseline COMMIT [--target COMMIT]]'
  parser.on('--batch N', Integer) { |v| options[:batch] = v }
  parser.on('--baseline COMMIT') { |v| options[:baseline] = v }
  parser.on('--rules-baseline COMMIT') { |v| options[:rules_baseline] = v }
  parser.on('--target COMMIT') { |v| options[:target] = v }
end.parse!
abort('批次檢查須同時指定 --batch 與 --baseline') if !!options[:batch] != !!options[:baseline]
abort('--target 僅用於批次檢查') if options[:target] && !options[:batch]
manifest = JSON.parse(File.read('scripts/acceptance-batches.json'))
completed = manifest.values.flat_map { |b| b.fetch('files').values }.uniq
scope = completed.map { |s| "rules/stacks/java/common/#{s}.md" }
errors = []
def original(commit, path)
  output, status = Open3.capture2('git', 'show', "#{commit}:#{path}")
  raise "Cannot read #{path}" unless status.success?
  output
end
def normalize(text)
  text.gsub(/<[^>]*>/, '').gsub(/\[([^\]]+)\]\([^)]+\)/, '\1').delete('`*_').gsub(/\s+/, '')
end
def tests(body)
  active = false
  body.lines.map do |line|
    if line.match?(/^\| (?:契約|對應決策|Java 條文) \| (?:驗收內容|語言增量驗收) \|/)
      active = true
      nil
    elsif active && line.start_with?('|') && !line.start_with?('| ---')
      line.split(' | ', 3).last.sub(/ \|\s*$/, '')
    else
      active = false unless line.start_with?('|')
      nil
    end
  end.compact
end

# 規則正文抽取只排除明確的驗收區；編輯性刪文依複核紀錄列管。
def rule_body(path, text)
  editorial = ['條號保留供既有決策與驗收追蹤，不代表引用條目另有一套政策。', '以下保留本輪決策的確認順序。']
  editorial.each { |phrase| text = text.gsub(phrase, '') }
  return text.split('## 驗收要求').first if path.include?('/stacks/java/common/')
  acceptance = /\A(?:補充契約驗收|契約驗收|驗收要求|多步驟失敗驗收|介面用途驗收)\z/
  skip_level = nil
  result = []
  text.lines.each do |line|
    if (heading = line.match(/^(\#{1,6}) (.+)$/))
      level = heading[1].size
      skip_level = nil if skip_level && level <= skip_level
      skip_level = level if heading[2].match?(acceptance)
    end
    next if skip_level
    next if line.match?(/^<a id="acceptance-/)
    # 共通既有驗收段落的補充，不是新增規則正文。
    next if line.start_with?('需要區分更新意圖時，從實際接收入口')
    result << line
  end
  result.join.gsub(/\n{3,}/, "\n\n").strip
end

files = Dir.glob('**/*.md').reject { |p| p.start_with?('.git/') }.sort
common = Dir.glob('rules/**/*.md').reject { |p| p.include?('/stacks/') }
common_tests = common.flat_map { |p| tests(File.read(p)).map { |t| normalize(t) } }
duplicates = scope.flat_map do |p|
  tests(File.read(p)).select { |t| common_tests.include?(normalize(t)) }.map { |t| [p, t] }
end
errors << "Scoped duplicate acceptance: #{duplicates}" unless duplicates.empty?

trace = []
row_count = 0
if options[:batch]
  batch = manifest.fetch(options[:batch].to_s)
  baseline = options[:baseline]
  read_target = ->(p) { options[:target] ? original(options[:target], p) : File.read(p) }
  batch_scope = batch.fetch('files').values.map { |s| "rules/stacks/java/common/#{s}.md" }
  Dir.glob('rules/stacks/java/common/*.md').each do |p|
    old = original(baseline, p)
    now = read_target.call(p)
    errors << "Java rule body changed #{p}" unless old.split('## 驗收要求').first == now.split('## 驗收要求').first
    errors << "Out of scope Java change #{p}" if !batch_scope.include?(p) && old != now
  end
  common.each do |p|
    old = original(baseline, p)
    now = read_target.call(p)
    if p == 'rules/quality/rule-verification.md'
      old.split(/\n\s*\n/).each do |block|
        next if block.start_with?('|', '#', '<a ')
        errors << "Common prose removed/changed #{p}: #{block[0,50]}" unless now.include?(block)
      end
    else
      errors << "Common rule body changed #{p}" unless rule_body(p, old) == rule_body(p, now)
    end

  end
  report = read_target.call("docs/acceptance-cleanup-batch-#{options[:batch]}.md")
  trace = report.lines.map { |l| l.match(/^\| ([A-Z]+-[\d、]+-\d+) \| (.+) \| \[主要驗收\]\(([^)]+)\) \|/) }.compact
  errors << 'Duplicate trace IDs' unless trace.map { |m| m[1] }.uniq.size == trace.size
  expected_ids = []
  batch.fetch('files').each do |prefix, slug|
    original(baseline, "rules/stacks/java/common/#{slug}.md").lines.each do |line|
      m = line.match(/^\| ([\d、]+) \| (.+) \|\s*$/)
      next unless m
      row_count += 1
      pieces = trace.select { |r| r[1].match?(/\A#{prefix}-#{Regexp.escape(m[1])}-\d+\z/) }
      expected_ids.concat(pieces.map { |r| r[1] })
      errors << "Missing/changed original fragments #{prefix}-#{m[1]}" unless pieces.map { |r| r[2] }.join == m[2]
    end
  end
  errors << 'Unexpected trace fragments' unless expected_ids.sort == trace.map { |r| r[1] }.sort
end

if options[:rules_baseline]
  Dir.glob('rules/**/*.md').each do |p|
    next if p.end_with?('/README.md')
    old = original(options[:rules_baseline], p)
    now = File.read(p)
    if p == 'rules/quality/rule-verification.md'
      # 此檔交錯編排政策與驗收；保護政策段落，驗收章節允許歸位。
      protected_sections = ['共同把關', '測試程式碼', '動態限制與文件驗證',
        '檢查配置可重現', '實際執行範圍', '檢查設定本身的有效性',
        '證據版本與快取有效性', '結果分類與安全診斷', '合併門檻實際有效']
      protected_sections.each do |title|
        extract = lambda do |body|
          body.split(/^## #{Regexp.escape(title)}\n/, 2).last.to_s.split(/^## /).first.to_s
            .gsub(/^<a id="[^"]+"><\/a>\n/, '').split(/^驗收：/).first.to_s.strip
        end
        errors << "Rule policy changed #{p}: #{title}" unless extract.call(old) == extract.call(now)
      end
    else
      errors << "Rule body changed #{p}" unless rule_body(p, old) == rule_body(p, now)
    end
  end
end

# 檢查所有 Markdown 的檔案及章節，包括行內的驗收錨點。
anchors = {}
files.each do |p|
  body = File.read(p)
  explicit = body.scan(/<a id="([^"]+)"/).flatten
  errors << "Duplicate anchor #{p}" unless explicit.uniq == explicit
  counts = Hash.new(0)
  implicit = body.scan(/^\#{1,6}\s+(.+)$/).flatten.map do |title|
    slug = title.downcase.gsub(/[\p{P}\p{S}&&[^_-]]/, '').gsub(/\s/, '-')
    n = counts[slug]; counts[slug] += 1
    n.zero? ? slug : "#{slug}-#{n}"
  end
  anchors[p] = explicit + implicit
  errors << "Colliding explicit/heading anchor scripts/verify-acceptance-batch-2.rb" unless anchors[p].uniq == anchors[p]
end
links = 0
files.each do |p|
  File.read(p).scan(/\]\(([^\s)]+)\)/).flatten.each do |uri|
    next if uri.match?(/\A(?:https?:|mailto:)/)
    links += 1
    file, fragment = uri.split('#', 2)
    target = file.empty? ? p : Pathname.new(File.join(File.dirname(p), file)).cleanpath.to_s
    errors << "Missing file #{p}: #{uri}" unless File.file?(target)
    errors << "Missing fragment #{p}: #{uri}" if fragment && anchors.key?(target) && !anchors[target].include?(fragment)
  end
end

# 全站數字用於顯示剩餘工作，不能把本批零重複宣稱為全部完成。
all_java = Dir.glob('rules/stacks/java/common/*.md').flat_map { |p| tests(File.read(p)).map { |t| normalize(t) } }
remaining = common_tests.count { |t| all_java.include?(t) }
abort(errors.join("\n")) unless errors.empty?
result = {completed_java_files: scope.size, completed_duplicate_rows: duplicates.size,
  checked_local_links: links, remaining_global_duplicate_common_rows: remaining}
result[:rules_baseline] = options[:rules_baseline] if options[:rules_baseline]
result[:rule_body_unchanged] = true if options[:rules_baseline]
if options[:batch]
  result.merge!(batch: options[:batch], baseline: baseline, target: options[:target] || 'working-tree',
    original_acceptance_rows: row_count, traced_fragments: trace.size, rule_body_unchanged: true)
end
puts JSON.pretty_generate(result)
