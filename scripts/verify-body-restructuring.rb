# frozen_string_literal: true
require_relative 'body-restructuring-lib'
require_relative 'body-structure-checks'
include BodyRestructuring
Dir.chdir(ENV.fetch('BODY_ROOT',File.expand_path('..',__dir__)))
B=BodyRestructuring
errors=[]
def require_check(ok,message); raise message unless ok; end
def visible(text)
  fence=false
  text.lines.map{|l|if l.match?(/^\s*(`{3,}|~{3,})/);fence=!fence;"\n";else;fence ? "\n" : l;end}.join
end
files=(Dir.glob('{rules,docs}/**/*.md',File::FNM_DOTMATCH)+['README.md']).select{|p|File.file?(p)}
anchors={}
files.each do |p|
 text=visible(File.read(p));counts=Hash.new(0)
 ids=text.scan(/<a id="([^"]+)"/).flatten+text.scan(/^\#{1,6}\s+(.+)$/).flatten.map{|s|slug=s.downcase.gsub(/[\p{P}\p{S}&&[^_-]]/,'').gsub(/\s/,'-');n=counts[slug];counts[slug]+=1;n==0 ? slug : "#{slug}-#{n}"}
 require_check(ids.uniq==ids,"錨點重複 #{p}");anchors[p]=ids
end
check_uri=lambda do |uri|
 p,a=uri.split('#',2);require_check(File.file?(p)&&a&&anchors.fetch(p,[]).include?(a),"去向錨點無效 #{uri}")
end
# 驗證目的內容落在指定錨點所在小節／表列，不能只在同檔任意位置找到。
excerpt=lambda do |uri|
 path,id=uri.split('#',2);lines=File.readlines(path);counts=Hash.new(0);index=nil;level=1
 lines.each_with_index do |line,i|
  if line.include?(%(<a id="#{id}">));index=i;break;end
  if h=line.match(/^(\#{1,6})\s+(.+)$/)
   slug=h[2].downcase.gsub(/[\p{P}\p{S}&&[^_-]]/,'').gsub(/\s/,'-');n=counts[slug];counts[slug]+=1;slug="#{slug}-#{n}" unless n.zero?
   if slug==id;index=i;level=h[1].size;break;end
  end
 end
 return '' unless index
 return lines[index] if lines[index].start_with?('|')
 if lines[index].start_with?('<a ')
  next_heading=((index+1)...lines.size).find{|i|!lines[i].strip.empty?}
  if next_heading && (h=lines[next_heading].match(/^(\#{1,6}) /));level=h[1].size;index=next_heading;end
 end
 tail=lines[(index+1)..].take_while{|l|!(h=l.match(/^(\#{1,6}) /)) || h[1].size>level}
 ([lines[index]]+tail).join
end
manifest=JSON.parse(File.read('scripts/acceptance-batches.json')).values.flat_map{|b|b['files'].to_a}.to_h
records=Dir.glob('docs/body-restructuring/java/*.json').map{|p|JSON.parse(File.read(p))}
expected_ids=File.read('docs/java-rule-classification.md').scan(/^\| ([A-Z]{2}-\d{2})[： ]/).flatten.reject{|id|id.start_with?('AU-')}.uniq.sort
require_check(records.flat_map{|r|r['rules'].map{|e|e['id']}}.sort==expected_ids && expected_ids.size==153,'歷史 ID 集合不完整或重複')
common_paths=Dir.glob('docs/body-restructuring/common/**/*',File::FNM_DOTMATCH).select{|p|File.file?(p)}
require_check((common_paths-BodyStructure::COMMON_FILES.map{|p|"docs/body-restructuring/common/#{p}"}).empty?,'未核准的共通紀錄檔名')
common=common_paths.map{|p|JSON.parse(File.read(p))}
registered={};sentence_count=0;acceptance_count=0;manual=[]
records.each do |r|
 require_check(r['baseline']==B::BASELINE,'Java 基準不符')
 path=r.fetch('path');base=B.original(path);
 if r['status']=='merged'
  require_check(r['rules'].all?{|e|e['kind']=='整份併入他檔'},'整份併入種類不一致')
  require_check(!File.exist?(path)&&File.file?(r.fetch('merged_target')),'整份併入檔案狀態不符')
  require_check(B.apply(base,r.fetch('edits')).empty?,'整份併入未登錄完整刪文')
 end
require_check(!registered.key?(path),'重複文件紀錄');registered[path]=r.fetch('edits')
 require_check(%w[pending completed merged].include?(r['status']),'整理狀態無效')
 require_check(File.binread(path)==base.b && r['edits'].empty?,"未整理文件改動 #{path}") if r['status']=='pending'
 prefix=manifest.find{|_,slug|path=="rules/stacks/java/common/#{slug}.md"}.to_a.first
 require_check(prefix,'Java 文件不在原分類範圍')
 require_check(r['rules'].map{|e|e['id']}==B.rules(base).map{|n,_,_|format('%s-%02d',prefix,n)},'文件歷史 ID 不符合基準條文')
 r['rules'].each do |e|
  require_check(B::KINDS.include?(e['kind']),'去向種類無效');require_check(e['targets'].is_a?(Array)&&!e['targets'].empty?,'歷史 ID 沒有現行去向')
  e['targets'].each{|u|check_uri.call(u)}
  require_check(e['reason'].to_s.gsub(/\s/,'').size>=10,'歷史去向理由不足')
 end
 require_check(r['sentences'].map{|s|s['source']}==B.sentences(base),"基準逐句去向不完整 #{path}")
 r['sentences'].each do |s|
  sentence_count+=1
  require_check(%w[保留 改寫 移除].include?(s['action']),'句子處置無效')
  require_check(!s.fetch('targets').empty?,'句子沒有去向')
  require_check(s.fetch('reason','').gsub(/\s/,'').size>=20,'句子改寫／移除理由不足') unless s['action']=='保留'
  s.fetch('common_sources',[]).each{|u|check_uri.call(u);require_check(!u.split('#').first.include?('/stacks/'),'共通來源指向 Java')}
  s['targets'].each do |t|
   check_uri.call(t.fetch('uri'));p=t['uri'].split('#').first
   if s['action']=='移除';require_check(!p.include?('/stacks/'),'移除須指向共通條文')
   else
    require_check(t['text'].is_a?(String)&&!t['text'].strip.empty?&&excerpt.call(t['uri']).include?(t['text']),'去向文字不存在')
    require_check(t['text']==s['source'],'保留句子不是逐字保留') if s['action']=='保留'
   end
  end
 end
 manual.concat(BodyStructure.verify(r,base,prefix,excerpt,check_uri))
 # 基準每一驗收表列（含表頭）都必須保留；調整標籤須逐筆登錄。
 rows=base.split('## 驗收要求',2).last.lines.select{|l|l.start_with?('|')}
 current=r['status']=='merged' ? r.fetch('merged_target') : path
 actual=File.read(current).split('## 驗收要求',2).last.to_s
 r.fetch('acceptance_changes').each{|e|require_check(rows.include?(e['before'])&&e['reason'].to_s.gsub(/\s/,'').size>=20,'驗收變更來源／理由無效')}
 rows.each do |row|
  acceptance_count+=1;replacement=r['acceptance_changes'].select{|e|e['before']==row};require_check(replacement.size<=1,'驗收變更重複')
  expected=replacement.empty? ? row : replacement.first.fetch('after')
  require_check(row.include?('<a id=') || expected==row || (row=="| Java 條文 | 語言增量驗收 |\n" && expected=="| 對應要求 | 語言增量驗收 |\n"),'驗收表頭不允許任意改名')
  require_check(expected.split(' | ',3)[1..]==row.split(' | ',3)[1..],'驗收內容不得以條號調整之名改寫')
  require_check(!expected.strip.empty?&&actual.lines.include?(expected),"驗收列消失 #{path}")
 end
end
common.each do |r|
 require_check(r['baseline']==B::BASELINE,'共通基準不符')
 r.fetch('changes').each do |e|
  require_check(e['decision'].to_s.start_with?('一／','七／','八／'),'共通差異缺決策列')
  require_check(!e['path'].include?('/stacks/java/common/'),'共通清單不得修改 Java 文件')
  (registered[e['path']]||=[])<<e
 end
end
args=['git'];args<<"--git-dir=#{ENV['BODY_GIT_DIR']}" if ENV['BODY_GIT_DIR']
paths,status=Open3.capture2(*args,'ls-tree','-r','--name-only',B::BASELINE,'rules');require_check(status.success?,'基準檔案清單失敗')
paths=paths.lines.map(&:strip);require_check((registered.keys-paths).empty?,'差異清單包含未知檔案');actual=Dir.glob('rules/**/*',File::FNM_DOTMATCH).select{|p|File.file?(p)}
merged=records.select{|r|r['status']=='merged'}.map{|r|r['path']}
require_check(actual.sort==(paths-merged).sort,'rules 檔案清單變更未登錄為整份併入')
paths.each do |p|
 next if merged.include?(p)
 expected=B.apply(B.original(p),(registered[p]||[]).sort_by{|e|e['baseline_line']})
 require_check(File.binread(p)==expected.b,"未登錄改動 #{p}")
end
links=0
files.each do |p|
 visible(File.read(p)).scan(/\]\(([^\s)]+)\)/).flatten.each do |uri|
  next if uri.match?(/\A(?:https?:|mailto:)/)
  f,a=uri.split('#',2);t=f.empty? ? p : Pathname.new(File.join(File.dirname(p),f)).cleanpath.to_s
  require_check(File.file?(t),"連結檔案不存在 #{p}: #{uri}")
  require_check(anchors.fetch(t,[]).include?(a),"連結錨點不存在 #{p}: #{uri}") if a && anchors.key?(t)
  links+=1
 end
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
abort(errors.join("\n")) unless errors.empty?
trace_output,trace_status=Open3.capture2e('ruby',File.expand_path('verify-body-acceptance.rb',__dir__))
require_check(trace_status.success?,"驗收追溯失敗：\n#{trace_output}")
trace_result=JSON.parse(trace_output)
puts JSON.pretty_generate({baseline:B::BASELINE,acceptance:trace_result,historical_ids:expected_ids.size,java_files:records.size,completed:records.count{|r|r['status']=='completed'},pending:records.count{|r|r['status']=='pending'},body_sentences:sentence_count,preserved_acceptance_rows:acceptance_count,common_change_blocks:common.sum{|r|r['changes'].size},local_links:links,manual_review_count:manual.size,manual_review_sentences:manual,manual_limitations:['即使承接原文逐字存在，是否與被刪斷言相關仍須逐項人工複核','語意等價、理由充分性與語意重複無法機械證明']})
