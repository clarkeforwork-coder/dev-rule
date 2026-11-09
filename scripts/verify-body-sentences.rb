# frozen_string_literal: true
require_relative 'body-presentation'
Dir.chdir(ENV.fetch('BODY_ROOT',File.expand_path('..',__dir__)))
P=BodyPresentation
skip='rules/stacks/java/README.md'
def units(text,path)
 text=BodyPresentation.rename(text,path,true)
 text.lines.reject{|l|l.strip.empty?||l.start_with?('<a id=','本文件另依','本組要求依','本組下列要求由共通規範承接：')||['### 本組補充說明','## 補充要求'].include?(l.strip)}.map(&:strip).sort
end
current=P.paths.to_h{|p|[p,File.read(p)]}
current=FinalAcceptance.undo(current) if FinalAcceptance.active?
failures=[];count=0
P.paths.each do |path|
 next if path==skip
 before=units(P.old(path),path);after=units(current.fetch(path),path)
 failures<<path unless before==after;count+=before.size
end
abort('句子集合變動：'+failures.join('、')) unless failures.empty?
puts JSON.pretty_generate({start:P::START,files:P.paths.size-1,nonblank_units:count,sentence_multisets_equal:true,method:'正規化連結別名，排除空白、錨點行、固定指路句與固定補充標題；保留重複數及程式碼行',excluded:skip,registered_final_changes_reversed:FinalAcceptance.active?})
