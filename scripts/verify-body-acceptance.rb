# frozen_string_literal: true
require_relative 'body-restructuring-lib'
Dir.chdir(ENV.fetch('BODY_ROOT',File.expand_path('..',__dir__)))
def original(ref,path); BodyRestructuring.original(path,ref); end
MIN_REASON_LENGTH=20
def normalize(text)
  text.gsub(/<[^>]*>/, '').gsub(/\[([^\]]+)\]\([^)]+\)/, '\1').delete('`*_').gsub(/\s+/, '')
end
def visible_markdown(text)
  fence = nil
  text.lines.map do |line|
    if (m = line.match(/^\s*(`{3,}|~{3,})/))
      fence = fence ? nil : m[1]
      "\n"
    else
      fence ? "\n" : line
    end
  end.join
end
def sufficient_reason?(reason)
  reason.is_a?(String) && reason.gsub(/[[:space:]]/, '').length >= MIN_REASON_LENGTH
end
def destination_content(text)
  text.to_s.gsub(/<a\s+id="[^"]+"><\/a>/, '').strip
end
# 明確的驗收章節涵蓋至下一個同級標題；混排政策的章節只承認驗收表、
# 「驗收：」段及緊接該段的獨立錨點，不承認同節政策文字。
def acceptance_mask(path, lines)
  mask = Array.new(lines.size, false)
  level = nil
  section = nil
  mixed = path == 'rules/quality/rule-verification.md'
  lines.each_with_index do |line, i|
    if (h = line.match(/^(\#{1,6}) (.+)$/))
      level = nil if level && h[1].size <= level
      section = h[2] if h[1].size == 2
      level = h[1].size if ['驗收要求', '補充契約驗收', '契約驗收', '介面用途驗收', '多步驟失敗驗收'].include?(h[2])
    end
    mask[i] = true if level
    if mixed && ['架構檢查與可測試性', '錯誤處理驗證與驗收', '檢查配置可重現', '實際執行範圍'].include?(section)
      mask[i] = true if line.start_with?('|', '驗收：')
      if line.match?(/^<a id="acceptance-/)
        following = lines[(i+1)..].find { |l| !l.strip.empty? }
        mask[i] = true if following && following.start_with?('驗收：')
      end
    end
  end
  mask
end
def table_mask(lines)
  mask=Array.new(lines.size,false)
  start=0
  (0..lines.size).each do |i|
    next if i<lines.size && !lines[i].strip.empty?
    block=lines[start...i]
    table=block.any? do |line|
      cells=line.strip.sub(/^\|/,'').sub(/\|$/,'').split('|')
      cells.size>=2 && cells.all?{|cell|cell.strip.match?(/\A:?-{3,}:?\z/)}
    end
    (start...i).each{|j|mask[j]=true} if table
    start=i+1
  end
  mask
end
# 基準行號（1 起算）：只列既有修正實際新增的三個驗收位置。
NEW_ACCEPTANCE_LOCATIONS = {
  ['rules/architecture/boundary-objects.md',33] => '## 契約驗收',
  ['rules/quality/rule-verification.md',27] => 'acceptance-interface-purpose',
  ['rules/quality/rule-verification.md',37] => 'acceptance-partial-operation'
}.freeze
def approved_acceptance_insertion?(path,pos,lines,source)
  marker=NEW_ACCEPTANCE_LOCATIONS[[path,pos+1]]
  if marker
    content=lines.reject{|l|l.strip.empty?}
    return content.all?{|l|l.start_with?('|') || l==marker} && content.any?{|l|l.include?(marker)}
  end
  # 獨立錨點可加在基準已存在的「驗收：」段之前，不能藉新增標題放行正文。
  following=source[pos..].to_a.find{|l|!l.strip.empty?}
  following && following.start_with?('驗收：') && lines.all?{|l|l.strip.empty? || l.match?(/\A<a id="acceptance-[^"]+"><\/a>\z/)}
end
def row_content(line)
  m = line.match(/^\| (.+) \| (.+) \|\s*$/)
  m && !m[1].start_with?('---') ? m[2] : nil
end
def acceptance_rows(body)
  active = false
  body.lines.map do |line|
    if line.match?(/^\| (?:契約|對應決策|Java 條文) \| (?:驗收內容|語言增量驗收) \|/)
      active = true; next
    end
    active = false unless line.start_with?('|')
    row_content(line) if active
  end.compact
end
def destination(uri)
  path, anchor = uri.split('#',2)
  path = Pathname.new(File.join('docs',path)).cleanpath.to_s
  return nil unless anchor && File.file?(path)
  lines = File.readlines(path)
  idx = lines.index { |l| l.include?(%(<a id="#{anchor}"></a>)) }
  return nil unless idx
  return row_content(lines[idx]) if lines[idx].start_with?('|')
  # 獨立錨點只對應緊接的一段，不能用整節掩蓋指錯位置。
  tail = lines[idx].sub(/.*?<\/a>/,'').strip
  return tail unless tail.empty?
  rest = lines[(idx+1)..].drop_while { |l| l.strip.empty? }
  rest.take_while { |l| !l.strip.empty? }.join.strip
end
errors=[]
options={}
manifest=JSON.parse(File.read('scripts/acceptance-batches.json'))
paths=Dir.glob('rules/**/*.md')
common=paths.reject{|p| p.include?('/stacks/')}
scope=manifest.values.flat_map{|b|b.fetch('files').values}.uniq.map{|s|"rules/stacks/java/common/#{s}.md"}
common_tests=common.flat_map{|p| acceptance_rows(File.read(p)).map{|t|normalize(t)}}
duplicates=scope.flat_map{|p| acceptance_rows(File.read(p)).select{|t|common_tests.include?(normalize(t))}.map{|t|[p,t]}}
errors << "Scoped duplicate acceptance: #{duplicates}" unless duplicates.empty?
rewrites=JSON.parse(File.read('docs/acceptance-rewritten-fragments.json'))
rewrites.each do |entry|
  content = destination(entry['target'])
  unless content && destination_content(content) == destination_content(entry['replacement']) && sufficient_reason?(entry['reason'])
    errors << "Invalid rewritten fragment #{entry['id']}: full destination and meaningful-length reason required"
  end
end
batches=options[:batch] ? [options[:batch].to_s] : manifest.keys
stats=[]
batches.each do |n|
  report="docs/acceptance-cleanup-batch-#{n}.md"
  body=File.read(report)
  baseline=options[:baseline] || body[/基準提交：`([^`]+)`/,1]
  traces=body.lines.map{|l| l.match(/^\| ([A-Z]+-[\d、]+-\d+) \| (.+) \| \[主要驗收\]\(([^)]+)\) \|\s*$/)}.compact
  malformed=body.lines.select{|l|l.match?(/^\| [A-Z]+-/) && !traces.any?{|m|m[0]==l}}
  errors << "Malformed trace rows batch #{n}" unless malformed.empty?
  errors << "Duplicate trace IDs batch #{n}" unless traces.map{|m|m[1]}.uniq.size==traces.size
  expected_ids=[];rows=0;verbatim=0;rewritten=0
  manifest.fetch(n).fetch('files').each do |prefix,slug|
    original(baseline,"rules/stacks/java/common/#{slug}.md").lines.each do |line|
      m=line.match(/^\| ([\d、]+) \| (.+) \|\s*$/);next unless m
      rows+=1
      pieces=traces.select{|r|r[1].match?(/\A#{prefix}-#{Regexp.escape(m[1])}-\d+\z/)}
      expected_ids.concat(pieces.map{|r|r[1]})
      errors << "Missing/changed original fragments #{prefix}-#{m[1]}" unless pieces.map{|r|r[2]}.join==m[2] && pieces.map{|r|r[1].split('-').last.to_i}==(1..pieces.size).to_a
    end
  end
  errors << "Unexpected trace fragments batch #{n}" unless expected_ids.sort==traces.map{|r|r[1]}.sort
  traces.each do |m|
    text=destination(m[3])
    if text && text.include?(m[2]);verbatim+=1;next;end
    entry=rewrites.find{|r|r['batch']==n && r['id']==m[1]}
    if entry && entry['original']==m[2] && entry['target']==m[3] && text && destination_content(text) == destination_content(entry['replacement']) && !destination_content(entry['replacement']).empty? && sufficient_reason?(entry['reason'])
      rewritten+=1
    else
      errors << "Trace fragment absent from destination #{m[1]}: #{m[3]}"
    end
  end
  stats << {batch:n.to_i,baseline:baseline,original_rows:rows,verbatim_fragments:verbatim,listed_rewritten_fragments:rewritten}
end
abort(errors.uniq.join("\n")) unless errors.empty?
puts JSON.pretty_generate({duplicate_java_acceptance_rows:duplicates.size,trace_checks:stats})
