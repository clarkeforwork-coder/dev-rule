# frozen_string_literal: true
require_relative 'body-presentation'
ROOT=File.expand_path('..',__dir__)
ENV['BODY_GIT_DIR']=File.expand_path(Open3.capture2('git','rev-parse','--git-common-dir',chdir:ROOT).first.strip,ROOT)
ids=%w[interface partial division references review-nine]
rv='rules/quality/rule-verification.md';dep='rules/architecture/dependency-composition.md';err='rules/coding/error-handling.md';bm='rules/stacks/java/common/boundary-mapping.md'
cases=(1..5).map{|n|["核准步驟 #{ids.take(n).join('+')}",nil,ids.take(n),lambda{}]}
cases += [
 ['新增檔案不能藏驗收錨點','驗收檔案清冊不同',ids,lambda{File.write('rules/.extra.md',%(<a id="acceptance-hidden"></a>\n額外驗收。\n))}],
 ['驗收不能留兩份','驗收錨點重複',ids,lambda{File.open(rv,'a'){|f|f.puts File.read(dep).lines.find{|l|l.include?('id="acceptance-interface-purpose"')}}}],
 ['不能刪驗收','驗收錨點清冊不同',ids,lambda{File.write(dep,File.read(dep).lines.reject{|l|l.include?('id="acceptance-interface-purpose"')}.join)}],
 ['不能縮小原列','未核准驗收增補',ids,lambda{File.write(dep,File.read(dep).sub('也未省略必要隔離','可以省略必要隔離'))}],
 ['分工不能刪原斷言','未核准驗收增補',ids,lambda{File.write(err,File.read(err).sub('不以拋例外推定未修改','不檢查例外後狀態'))}],
 ['分工必須逐字符合核准','未核准驗收增補',ids,lambda{File.write(err,File.read(err).sub('批次修改拋出例外後的狀態另見','所有狀態見'))}],
 ['略過欄位必須核對','非登錄改動',ids,lambda{File.write(bm,File.read(bm).sub('，且未略過欄位或產生不完整物件掩蓋失敗',''))}],
 ['指代不得任意改寫','非登錄改動',ids,lambda{File.write(bm,File.read(bm).sub('不以建立了目標型別就視為有效','建立了目標型別就視為有效'))}],
 ['未列共通正文不可改','非登錄改動',ids,lambda{File.open(err,'a'){|f|f.puts '其他規範可以略過。'}}],
 ['不搬其他主題','非登錄改動',ids,lambda{File.write(rv,File.read(rv).sub('## 補償流程驗收','## 其他驗收'))}],
 ['不能偽造核准清單','最後驗收核准清單內容變動',ids,lambda{File.open('scripts/final-acceptance-plan.json','a'){|f|f.puts ' '}}]
]
jn='rules/stacks/java/common/null-and-optional.md'
cases += [
 ['JN-02 不得弱化','非登錄改動',ids,lambda{File.write(jn,File.read(jn).sub('不得掩蓋業務失敗','不宜掩蓋業務失敗'))}],
 ['JN-06 不得刪除還原句','非登錄改動',ids,lambda{File.write(jn,File.read(jn).sub('Java 接收、建立及狀態變更位置依上述非空保證驗證；內部可靠契約已成立時不逐層重複檢查。',''))}],
 ['指路順序不得倒置','非登錄改動',ids,lambda{p='rules/stacks/java/common/concurrency-and-async.md';t=File.read(p);l=t.lines.find{|s|s.start_with?('本組由共通')};links=l.scan(/\[[^\]]+\]\([^)]+\)/);File.write(p,t.sub(l,'本組由共通規範承接的要求：'+links.reverse.join('、')+"。\n"))}],
 ['不能恢復下列指路句','非登錄改動',ids,lambda{p='rules/stacks/java/common/concurrency-and-async.md';File.write(p,File.read(p).sub('本組由共通規範承接的要求：','本組下列要求由共通規範承接：'))}],
 ['相容標題不得刪除','非登錄改動',ids,lambda{p='rules/architecture/data-mapping.md';File.write(p,File.read(p).sub('<a id="既有共同保證的落實"></a>',''))}],
 ['案例覆蓋不可換回整理用語','非登錄改動',ids,lambda{File.write(jn,File.read(jn).sub('>案例覆蓋','>覆蓋要求（原驗收入口）'))}],
 ['索引說明不可刪','非登錄改動',ids,lambda{p='rules/stacks/java/README.md';File.write(p,File.read(p).lines.reject{|l|l.start_with?('內容欄只列')}.join)}],
 ['分工不得概括較窄範圍','未核准驗收增補',ids,lambda{p='rules/coding/concurrency-and-async.md';File.write(p,File.read(p).sub('結果的分類與接收路徑另見','本列只核對工作擁有者；結果分類見'))}]
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
   out=out.gsub(dir,"<暫存複本>")
   results<<{test:name,exit:s.exitstatus,matched:diagnostic ? !s.success?&&out.include?(diagnostic) : s.success?,diagnostic:diagnostic ? out.lines.find{|l|l.include?(diagnostic)}.to_s.strip : '核准搬移、增補及其餘全文一致'}
  end
 end
end
puts JSON.pretty_generate(results)
exit(results.all?{|r|r[:matched]} ? 0 : 1)
