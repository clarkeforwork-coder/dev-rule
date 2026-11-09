# frozen_string_literal: true
require 'open3'
require 'pathname'
require 'json'
require 'optparse'
require 'tmpdir'

RULES_BASELINE = '6a1634959d922b2df5f1259cb176a731a5b5f488'.freeze
MIN_REASON_LENGTH = 20

# 驗收階段已封存；目前正文由新工具保護，舊工具僅驗證歷史提交。
unless ARGV.include?('--target') || ENV['ACCEPTANCE_ROOT']
  abort('驗收階段檢查已封存於 350668eb14ede247af22c782323beebf940c2a5f；現行版本請執行 ruby scripts/verify-body-restructuring.rb。歷史驗證使用 --target 提交。')
end
Dir.chdir(File.expand_path('..', __dir__))
options = {}
OptionParser.new do |p|
  p.on('--batch N', Integer) { |v| options[:batch] = v }
  p.on('--baseline COMMIT') { |v| options[:baseline] = v }
  p.on('--rules-baseline COMMIT') { |v| options[:rules_baseline] = v }
  p.on('--target COMMIT') { |v| options[:target] = v }
end.parse!
# --target 的所有檔案及數字都來自該提交，執行的是目前這支檢查器。
if options[:target]
  target = options.delete(:target)
  Dir.mktmpdir('acceptance-target-') do |dir|
    archive, status = Open3.capture2('git', 'archive', target)
    abort('無法匯出目標提交') unless status.success?
    _, status = Open3.capture2('tar', '-x', '-C', dir, stdin_data: archive)
    abort('無法解開目標提交') unless status.success?
    env = {'ACCEPTANCE_ROOT'=>dir, 'ACCEPTANCE_GIT_DIR'=>File.expand_path(`git rev-parse --git-common-dir`.strip), 'ACCEPTANCE_SOURCE'=>target}
    args = options.flat_map { |k,v| v == true ? ["--#{k.to_s.tr('_','-')}"] : ["--#{k.to_s.tr('_','-')}",v.to_s] }
    output, status = Open3.capture2e(env, 'ruby', File.expand_path(__FILE__), *args)
    puts output
    exit status.exitstatus
  end
end
Dir.chdir(ENV.fetch('ACCEPTANCE_ROOT', Dir.pwd))
def original(commit, path)
  args = ['git']
  args << "--git-dir=#{ENV['ACCEPTANCE_GIT_DIR']}" if ENV['ACCEPTANCE_GIT_DIR']
  output, error, status = Open3.capture3(*args, 'show', "#{commit}:#{path}")
  abort("無法讀取基準檔 #{commit}:#{path}：#{error.strip}") unless status.success?
  output
end
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
policy_path='docs/acceptance-check-policy.json'
abort('此受驗版本沒有逐句差異清單；不可用新檢查器宣稱舊版本通過') unless File.file?(policy_path)
policy=JSON.parse(File.read(policy_path))
base=RULES_BASELINE
git_args = ['git']
git_args << "--git-dir=#{ENV['ACCEPTANCE_GIT_DIR']}" if ENV['ACCEPTANCE_GIT_DIR']
resolve = ->(ref) { value, status = Open3.capture2e(*git_args, 'rev-parse', '--verify', "#{ref}^{commit}"); status.success? ? value.strip : nil }
abort('固定正文基準為 6a16349，清單 baseline 不得移動') unless resolve.call(policy.fetch('baseline')) == resolve.call(RULES_BASELINE)
abort('--rules-baseline 只能指定固定正文基準 6a16349') if options[:rules_baseline] && resolve.call(options[:rules_baseline]) != resolve.call(RULES_BASELINE)
manifest=JSON.parse(File.read('scripts/acceptance-batches.json'))
paths=Dir.glob('rules/**/*', File::FNM_DOTMATCH).select { |p| File.file?(p) }.sort
base_paths_args=['git'];base_paths_args<<"--git-dir=#{ENV['ACCEPTANCE_GIT_DIR']}" if ENV['ACCEPTANCE_GIT_DIR']
base_paths,status=Open3.capture2(*base_paths_args,'ls-tree','-r','--name-only',base,'rules')
expected_paths=base_paths.lines.map(&:strip).sort
abort("Rules file inventory changed: added=#{(paths-expected_paths).join(',')}; removed=#{(expected_paths-paths).join(',')}") unless paths==expected_paths
policy.fetch('changes').each do |edit|
  location = "#{edit['path']}:#{edit['baseline_line']}"
  errors << "Invalid edit kind #{location}" unless %w[editorial acceptance].include?(edit['kind'])
  errors << "Invalid approved edit #{location}: reason too short or blank" unless sufficient_reason?(edit['reason'])
end
preserved=0
paths.each do |path|
  baseline_text=original(base,path)
  source=baseline_text.lines.map(&:chomp)
  edits=policy.fetch('changes').select{|c| c['path']==path}.sort_by{|c| c['baseline_line']}
  expected=[];cursor=0;spans=[]
  edits.each do |edit|
    pos=edit.fetch('baseline_line')-1; removed=edit.fetch('remove')
    errors << "Invalid approved edit #{path}:#{pos+1}" unless pos>=cursor && source[pos,removed.size]==removed && sufficient_reason?(edit['reason'])
    expected.concat(source[cursor...pos]);spans << [edit,pos,expected.size];expected.concat(edit.fetch('insert'));cursor=pos+removed.size
  end
  expected.concat(source[cursor..]); actual=File.readlines(path).map(&:chomp)
  old_mask=acceptance_mask(path,source)
  old_tables=table_mask(source);new_tables=table_mask(expected)
  expected_bytes=(expected.join("\n")+(baseline_text.end_with?("\n") ? "\n" : '')).b
  errors << "Rule line endings changed #{path}" if File.binread(path).gsub("\r\n","\n") == expected_bytes && File.binread(path) != expected_bytes
  errors << "Rule final newline changed #{path}" if File.binread(path).end_with?("\n") != expected_bytes.end_with?("\n")
  spans.each do |edit,old_pos,new_pos|
    case edit['kind']
    when 'editorial'
      errors << "Editorial edit touches table #{path}:#{old_pos+1}" if edit['remove'].each_index.any? { |i| old_tables[old_pos+i] } || edit['insert'].each_index.any? { |i| new_tables[new_pos+i] }
    when 'acceptance'
      removed_valid = edit['remove'].each_with_index.all? { |line,i| line.strip.empty? || old_mask[old_pos+i] }
      insertion_valid = edit['insert'].all?(&:empty?) || old_mask[old_pos] || (old_pos == source.size && old_mask.last)
      # 僅允許已明列的新增驗收小節／搬移表格與現有驗收段落的定位錨點。
      insertion_valid ||= approved_acceptance_insertion?(path,old_pos,edit['insert'],source)
      valid = removed_valid && insertion_valid
      errors << "Acceptance edit outside acceptance section #{path}:#{old_pos+1}" unless valid
    else
      errors << "Invalid edit kind #{path}:#{old_pos+1}"
    end
  end
  i=0

  actual.each_with_index do |line,n|
    if line==expected[i]
      i+=1;preserved+=1
    else
      errors << "Protected rule text changed #{path}:#{n+1}: #{line}"
      break
    end
  end
  errors << "Protected rule text missing #{path}: #{expected[i]}" if i<expected.size
  acceptance_rows(actual.join("\n")).each { |t| errors << "Empty acceptance #{path}" if t.strip.size<9 }
end
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
classification=File.read('docs/java-rule-classification.md')
classified=classification.lines.map{|l|l[/^\| ([A-Z]{2}-\d{2})[： ]/,1]}.compact.reject{|id|id.start_with?('AU-')}.uniq.sort
pending=File.read('docs/pending-decisions.md')
assessment=pending.split(/^## 三、/,2).last.to_s.split(/^## 五、/,2).first.to_s
assessed=assessment.scan(/^\| \[([A-Z]{2}-\d{2}) 第/).flatten
errors << 'Pending decision ID inventory changed' unless assessed.sort==classified
reference_ids=classification.lines.select{|l|l.include?('**改引用**')}.map{|l|l[/^\| ([A-Z]{2}-\d{2})[： ]/,1]}.compact.reject{|id|id.start_with?('AU-')}.uniq.sort
reference_section=pending.split(/^## 六、/,2).last.to_s.split(/^## 七、/,2).first.to_s
errors << 'Pending reference ID inventory changed' unless reference_section.scan(/^\| \[([A-Z]{2}-\d{2}) 第/).flatten.sort==reference_ids
# 只檢查儲存庫列管的 Markdown 與新增 docs/rules；不讀未提交的審閱報告。
files=(Dir.glob('{rules,docs}/**/*.md')+['README.md']).select{|p|File.file?(p)}.sort
anchors={}
files.each do |p|
 body=visible_markdown(File.read(p));explicit=body.scan(/<a id="([^"]+)"/).flatten;counts=Hash.new(0)
 implicit=body.scan(/^\#{1,6}\s+(.+)$/).flatten.map do |title|
  slug=title.downcase.gsub(/[\p{P}\p{S}&&[^_-]]/,'').gsub(/\s/,'-');n=counts[slug];counts[slug]+=1;n.zero? ? slug : "#{slug}-#{n}"
 end
 anchors[p]=explicit+implicit
 errors << "Duplicate/colliding anchor #{p}" unless anchors[p].uniq==anchors[p]
end
links=0
files.each do |p|
 visible_markdown(File.read(p)).scan(/\]\(([^\s)]+)\)/).flatten.each do |uri|
  next if uri.match?(/\A(?:https?:|mailto:)/)
  links+=1;file,fragment=uri.split('#',2);target=file.empty? ? p : Pathname.new(File.join(File.dirname(p),file)).cleanpath.to_s
  errors << "Missing file #{p}: #{uri}" unless File.file?(target)
  errors << "Missing fragment #{p}: #{uri}" if fragment && anchors.key?(target) && !anchors[target].include?(fragment)
 end
end
abort(errors.uniq.join("\n")) unless errors.empty?
puts JSON.pretty_generate({source:ENV.fetch('ACCEPTANCE_SOURCE','working-tree'),rules_baseline:base,protected_rule_files:paths.size,matched_approved_rule_lines:preserved,explicit_change_blocks:policy['changes'].size,completed_java_files:scope.size,duplicate_java_acceptance_rows:duplicates.size,checked_local_links:links,trace_checks:stats,line_endings_check:'逐位元組核對 LF／CRLF 與檔尾換行',documentation_content_check:'待決清單與批次說明的內容正確性為人工檢查項目；機械檢查僅核對條目 ID 集合及追溯片段完整性',reason_content_check:'理由內容為人工檢查項目；機械檢查僅限制分類、位置與至少 20 個非空白字元',semantic_duplication_check:'人工檢查項目；換句話說的重複無法由本腳本判斷（T3）'})
