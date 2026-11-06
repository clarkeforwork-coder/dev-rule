# frozen_string_literal: true
require 'open3'
require 'pathname'
require 'json'
require 'optparse'
require 'tmpdir'

Dir.chdir(File.expand_path('..', __dir__))
options = {}
OptionParser.new do |p|
  p.on('--batch N', Integer) { |v| options[:batch] = v }
  p.on('--baseline COMMIT') { |v| options[:baseline] = v }
  p.on('--rules-baseline COMMIT') { |v| options[:rules_baseline] = v }
  p.on('--target COMMIT') { |v| options[:target] = v }
  p.on('--trace-only') { options[:trace_only] = true }
  p.on('--check-scope') { options[:check_scope] = true }
end.parse!
abort('--check-scope 須指定 --batch，且不能與 --trace-only 併用') if options[:check_scope] && (!options[:batch] || options[:trace_only])
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
  output, status = Open3.capture2e(*args, 'show', "#{commit}:#{path}")
  raise "無法讀取 #{commit}:#{path}" unless status.success?
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
base=options[:rules_baseline] || policy.fetch('baseline')
git_args = ['git']
git_args << "--git-dir=#{ENV['ACCEPTANCE_GIT_DIR']}" if ENV['ACCEPTANCE_GIT_DIR']
resolve = ->(ref) { value, status = Open3.capture2e(*git_args, 'rev-parse', '--verify', "#{ref}^{commit}"); status.success? ? value.strip : nil }
abort('正文基準與逐句差異清單不一致') unless resolve.call(base) && resolve.call(base) == resolve.call(policy.fetch('baseline'))
manifest=JSON.parse(File.read('scripts/acceptance-batches.json'))
paths=Dir.glob('rules/**/*').select { |p| File.file?(p) }.sort
base_paths_args=['git'];base_paths_args<<"--git-dir=#{ENV['ACCEPTANCE_GIT_DIR']}" if ENV['ACCEPTANCE_GIT_DIR']
base_paths,status=Open3.capture2(*base_paths_args,'ls-tree','-r','--name-only',base,'rules')
expected_paths=base_paths.lines.map(&:strip).sort
errors << 'Rules file inventory changed' unless paths==expected_paths
preserved=0
paths.each do |path|
  source=original(base,path).lines.map(&:chomp)
  edits=policy.fetch('changes').select{|c| c['path']==path}.sort_by{|c| c['baseline_line']}
  expected=[];cursor=0
  edits.each do |edit|
    pos=edit.fetch('baseline_line')-1; removed=edit.fetch('remove')
    errors << "Invalid approved edit #{path}:#{pos+1}" unless pos>=cursor && source[pos,removed.size]==removed && !edit.fetch('reason').empty?
    expected.concat(source[cursor...pos]);expected.concat(edit.fetch('insert'));cursor=pos+removed.size
  end
  expected.concat(source[cursor..]); actual=File.readlines(path).map(&:chomp)
  i=0;active=false
  actual.each_with_index do |line,n|
    if line==expected[i]
      i+=1;preserved+=1
      active=true if line.match?(/^\| (?:契約|對應決策|Java 條文) \| (?:驗收內容|語言增量驗收) \|/)
      active=false unless line.start_with?('|')
    elsif active && row_content(line) && row_content(line).size>8 && line.include?('acceptance-')
      # 允許在既有驗收表增加完整列；不能刪除或改寫已核對列。
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
batches=options[:batch] ? [options[:batch].to_s] : manifest.keys
stats=[]
batches.each do |n|
  report="docs/acceptance-cleanup-batch-#{n}.md"
  body=File.read(report)
  baseline=options[:baseline] || body[/基準提交：`([^`]+)`/,1]
  if options[:check_scope]
    batch_paths = manifest.fetch(n).fetch('files').values.map { |slug| "rules/stacks/java/common/#{slug}.md" }
    scope.each do |path|
      old = original(baseline, path)
      current = File.read(path)
      errors << "Out of scope Java change #{path}" if !batch_paths.include?(path) && old != current
      errors << "Batch Java body changed #{path}" unless old.split('## 驗收要求').first == current.split('## 驗收要求').first
    end
  end
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
    if entry && entry['original']==m[2] && entry['target']==m[3] && text && text.include?(entry['replacement']) && !entry['replacement'].empty? && !entry['reason'].empty?
      rewritten+=1
    else
      errors << "Trace fragment absent from destination #{m[1]}: #{m[3]}"
    end
  end
  stats << {batch:n.to_i,baseline:baseline,original_rows:rows,verbatim_fragments:verbatim,listed_rewritten_fragments:rewritten}
end
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
puts JSON.pretty_generate({source:ENV.fetch('ACCEPTANCE_SOURCE','working-tree'),rules_baseline:base,protected_rule_files:paths.size,matched_approved_rule_lines:preserved,explicit_change_blocks:policy['changes'].size,completed_java_files:scope.size,completed_duplicate_rows:duplicates.size,remaining_global_duplicate_common_rows:common_tests.count{|t|scope.any?{|p|acceptance_rows(File.read(p)).any?{|v|normalize(v)==t}}},checked_local_links:links,trace_checks:stats,semantic_duplication_check:'人工檢查項目；換句話說的重複無法由本腳本判斷（T3）'})
