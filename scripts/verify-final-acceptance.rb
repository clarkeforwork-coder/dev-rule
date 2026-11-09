# frozen_string_literal: true
require_relative 'body-presentation'
Dir.chdir(ENV.fetch('BODY_ROOT',File.expand_path('..',__dir__)))
F=FinalAcceptance
abort('最後驗收階段尚未啟用') unless F.active?
paths=BodyPresentation.paths
before=paths.to_h{|p|[p,BodyRestructuring.original(p,F::START)]}
actual=paths.to_h{|p|[p,File.read(p)]}
expected=F.transform(before)
errors=[]
actual.each{|p,t|errors<<"非登錄改動 #{p}" unless t==expected[p]}
def rows(files)
 result={}
 files.each do |p,t|
  lines=t.lines
  lines.each_with_index do |l,i|
   l.scan(/<a id="(acceptance-[^"]+)"><\/a>/).flatten.each do |id|
    raise "驗收錨點重複 #{id}" if result.key?(id)
    content=l.start_with?('|') ? l.strip : l.sub(/.*?<\/a>/,'').strip
    content=lines[(i+1)..].drop_while{|x|x.strip.empty?}.take_while{|x|!x.strip.empty?}.join.strip if content.empty?
    raise "驗收內容為空 #{id}" if content.empty?
    result[id]={'path'=>p,'text'=>content}
   end
  end
 end
 result
end
def norm(t);t.gsub(/<a id="[^"]+"><\/a>/,'').gsub(/\]\([^)]+\)/,'](目標)');end
b=rows(before);a=rows(actual);e=rows(expected)
errors<<'驗收錨點清冊不同' unless b.keys.sort==a.keys.sort
allowed=%w[acceptance-task-ownership acceptance-result-reception acceptance-failure-state acceptance-partial-operation acceptance-java-mapping-failure]
changed=[];moved=[]
b.each do |id,x|
 next unless a[id]
 moved<<{'anchor'=>id,'from'=>x['path'],'to'=>a[id]['path']} if x['path']!=a[id]['path']
 next if norm(x['text'])==norm(a[id]['text'])
 changed<<id
 errors<<"未核准驗收增補 #{id}" unless allowed.include?(id)&&norm(a[id]['text'])==norm(e[id]['text'])
end
abort(errors.join("\n")) unless errors.empty?
puts JSON.pretty_generate({start:F::START,acceptance_anchors:b.size,unique:true,unchanged_after_link_normalization:b.size-changed.size,registered_additions:changed,moved:moved,all_other_rules_exact:true})
