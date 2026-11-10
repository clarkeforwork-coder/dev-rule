# frozen_string_literal: true
require_relative 'body-presentation'
Dir.chdir(ENV.fetch('BODY_ROOT',File.expand_path('..',__dir__)))
abort('第九次審閱尚未啟用') unless ReviewNine.active?
paths=BodyPresentation.paths
abort('規則檔案清冊不同') unless Dir.glob('rules/**/*',File::FNM_DOTMATCH).select{|p|File.file?(p)}.sort==paths.sort
base=paths.to_h{|p|[p,BodyRestructuring.original(p,ReviewNine::START)]};expected=base.transform_values(&:dup)
FinalAcceptance.steps.find{|s|s['id']=='review-nine'}['ops'].each do |o|
 p=o['path'];raise "核准前文不符 #{p}" unless expected[p].scan(Regexp.new(Regexp.escape(o['before']))).size==1
 expected[p]=expected[p].sub(o['before'],o['after'])
end
paths.each{|p|abort("第九次審閱清單外差異 #{p}") unless File.binread(p)==expected[p].b}
def units(text)
 text.lines.reject{|l|l.strip.empty?||l.start_with?('<a id=')}.flat_map{|l|l.gsub(/\]\([^)]+\)/,'](連結目標)').strip.split(/(?<=。)/)}
end
def subtract(a,b)
 remaining=b.dup;a.reject{|s|i=remaining.index(s);i ? remaining.delete_at(i) : false}
end
changes=paths.map do |p|
 a=units(base[p]);b=units(expected[p]);next if a==b
 {'path'=>p,'before'=>subtract(a,b),'after'=>subtract(b,a)}
end.compact
j=ReviewNine::JAVA
original=BodyRestructuring.rules(BodyRestructuring.original(j))
required=[original.find{|n,_,_|n==2}[2].split('。')[1]+'。']+original.find{|n,_,_|n==6}[2].scan(/[^。]+。/)
required.each{|s|raise "基準原句未逐字還原：#{s}" unless File.read(j).include?(s)}
puts JSON.pretty_generate({start:ReviewNine::START,files:paths.size,registered_blocks:FinalAcceptance.steps.last['ops'].size,all_changes_registered:true,restored_verbatim:required,sentence_differences:changes})
