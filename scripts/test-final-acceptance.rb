# frozen_string_literal: true
require_relative 'body-presentation'
ROOT=File.expand_path('..',__dir__)
ENV['BODY_GIT_DIR']=File.expand_path(Open3.capture2('git','rev-parse','--git-common-dir',chdir:ROOT).first.strip,ROOT)
ids=%w[interface partial division references]
rv='rules/quality/rule-verification.md';dep='rules/architecture/dependency-composition.md';err='rules/coding/error-handling.md';bm='rules/stacks/java/common/boundary-mapping.md'
cases=(1..4).map{|n|["核准步驟 #{ids.take(n).join('+')}",nil,ids.take(n),lambda{}]}
cases += [
 ['驗收不能留兩份','驗收錨點重複',ids,lambda{File.open(rv,'a'){|f|f.puts File.read(dep).lines.find{|l|l.include?('id="acceptance-interface-purpose"')}}}],
 ['不能刪驗收','驗收錨點清冊不同',ids,lambda{File.write(dep,File.read(dep).lines.reject{|l|l.include?('id="acceptance-interface-purpose"')}.join)}],
 ['不能縮小原列','未核准驗收增補',ids,lambda{File.write(dep,File.read(dep).sub('也未省略必要隔離','可以省略必要隔離'))}],
 ['分工不能刪原斷言','未核准驗收增補',ids,lambda{File.write(err,File.read(err).sub('不以拋例外推定未修改','不檢查例外後狀態'))}],
 ['分工必須逐字符合核准','未核准驗收增補',ids,lambda{File.write(err,File.read(err).sub('本列核對例外後的實際狀態','本列只核對例外'))}],
 ['略過欄位必須核對','非登錄改動',ids,lambda{File.write(bm,File.read(bm).sub('，且未略過欄位或產生不完整物件掩蓋失敗',''))}],
 ['指代不得任意改寫','非登錄改動',ids,lambda{File.write(bm,File.read(bm).sub('不以建立了目標型別就視為有效','建立了目標型別就視為有效'))}],
 ['未列共通正文不可改','非登錄改動',ids,lambda{File.open(err,'a'){|f|f.puts '其他規範可以略過。'}}],
 ['不搬其他主題','非登錄改動',ids,lambda{File.write(rv,File.read(rv).sub('## 補償流程驗收','## 其他驗收'))}],
 ['不能偽造核准清單','最後驗收核准清單內容變動',ids,lambda{File.open('scripts/final-acceptance-plan.json','a'){|f|f.puts ' '}}]
]
results=[]
cases.each do |name,diagnostic,steps,mutate|
 Dir.mktmpdir('body-final-test-') do |dir|
  %w[rules docs scripts].each{|p|FileUtils.cp_r(File.join(ROOT,p),dir)}
  Dir.chdir(dir) do
   File.write(FinalAcceptance::CONFIG,JSON.generate({start:FinalAcceptance::START,steps:steps}))
   files,_=BodyPresentation.render(JSON.parse(File.read(BodyPresentation::CONFIG)))
   files.each{|p,t|File.write(p,t)};mutate.call
   out,s=Open3.capture2e({'BODY_ROOT'=>dir},'ruby',File.join(dir,'scripts/verify-final-acceptance.rb'))
   results<<{test:name,exit:s.exitstatus,matched:diagnostic ? !s.success?&&out.include?(diagnostic) : s.success?,diagnostic:diagnostic ? out.lines.find{|l|l.include?(diagnostic)}.to_s.strip : '核准搬移、增補及其餘全文一致'}
  end
 end
end
puts JSON.pretty_generate(results)
exit(results.all?{|r|r[:matched]} ? 0 : 1)
