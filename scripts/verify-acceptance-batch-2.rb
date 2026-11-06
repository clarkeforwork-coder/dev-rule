# frozen_string_literal: true
# 本批結構與追溯檢查；語意審查仍依 docs/acceptance-cleanup-batch-2.md。
require 'open3'
require 'pathname'
require 'json'

Dir.chdir(File.expand_path('..', __dir__))
baseline = 'e8d32e7bd1b9e073f62f8092398daf7d1b57dce1'
slugs = %w[concurrency-and-async collections-and-ownership exceptions-and-resources]
scope = slugs.map { |s| "rules/stacks/java/common/#{s}.md" }
prefixes = %w[CA CO EX]
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

files = Dir.glob('{rules,docs}/**/*.md').sort
common = Dir.glob('rules/**/*.md').reject { |p| p.include?('/stacks/') }
common_tests = common.flat_map { |p| tests(File.read(p)).map { |t| normalize(t) } }
duplicates = scope.flat_map do |p|
  tests(File.read(p)).select { |t| common_tests.include?(normalize(t)) }.map { |t| [p, t] }
end
errors << "Scoped duplicate acceptance: #{duplicates}" unless duplicates.empty?

# 所有 Java 編號條文不得改動，非本批文件也不得順便修改驗收。
Dir.glob('rules/stacks/java/common/*.md').each do |p|
  old = original(baseline, p)
  now = File.read(p)
  errors << "Java rule body changed #{p}" unless old.split('## 驗收要求').first == now.split('## 驗收要求').first
  errors << "Out of scope Java change #{p}" if !scope.include?(p) && old != now
end
# 共通既有規則正文的段落保持不變；僅允許驗收列及既有多步驟失敗的驗收入口變更。
common.each do |p|
  old = original(baseline, p)
  now = File.read(p)
  old.split(/\n\s*\n/).each do |block|
    next if block.start_with?('|') || block.start_with?('#') || block.start_with?('<a ')
    errors << "Common prose removed/changed #{p}: #{block[0,50]}" unless now.include?(block)
  end
end

# 原列分句可重組，且每片段恰有一個目的地。
report = File.read('docs/acceptance-cleanup-batch-2.md')
trace = report.lines.map { |l| l.match(/^\| ((?:CA|CO|EX)-[\d、]+-\d+) \| (.+) \| \[主要驗收\]\(([^)]+)\) \|/) }.compact
errors << 'Trace must contain 44 unique fragments' unless trace.size == 44 && trace.map { |m| m[1] }.uniq.size == 44
scope.zip(prefixes).each do |p, prefix|
  original(baseline, p).lines.each do |line|
    m = line.match(/^\| ([\d、]+) \| (.+) \|\s*$/)
    next unless m
    pieces = trace.select { |r| r[1].match?(/\A#{prefix}-#{Regexp.escape(m[1])}-\d+\z/) }
    errors << "Missing/changed original fragments #{prefix}-#{m[1]}" unless pieces.map { |r| r[2] }.join == m[2]
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
puts JSON.pretty_generate({baseline: baseline, scope_java_files: scope.size, scoped_duplicate_rows: duplicates.size,
  original_acceptance_rows: 23, traced_fragments: trace.size, rule_body_unchanged: true,
  checked_local_links: links, remaining_global_duplicate_common_rows: remaining})
