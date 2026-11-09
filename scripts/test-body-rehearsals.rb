# frozen_string_literal: true
require 'tmpdir'
require 'fileutils'
require_relative 'body-rehearsal-fixtures'
ROOT=File.expand_path('..',__dir__)
GIT=File.expand_path(Open3.capture2('git','rev-parse','--git-common-dir',chdir:ROOT).first.strip,ROOT)
ENV['BODY_GIT_DIR']=GIT
cases={
 '分組清空與最後條文移除'=>lambda{
  r=BodyRehearsal.convert('collections-and-ownership')
  %w[CO-01 CO-02 CO-03 CO-09].each{|id|BodyRehearsal.remove(r,id,['rules/coding/collections-and-ownership.md#'+id.downcase])};BodyRehearsal.finish_links(r)
 },
 'R7 H02 BM-03 拆分同列 Java 與共通去向'=>lambda{r=BodyRehearsal.convert('boundary-mapping');BodyRehearsal.remove(r,'BM-03',['rules/architecture/data-mapping.md#bm-03'],true);BodyRehearsal.finish_links(r)},
 'R7 第四節否原句不動填保留增量'=>lambda{
  r=BodyRehearsal.convert('exceptions-and-resources');r['rules'].find{|e|e['id']=='EX-02'}['kind']='保留增量';BodyRehearsal.save(r)
 },
 'EX 條號改錨點'=>lambda{BodyRehearsal.convert('exceptions-and-resources')},
 'EQ 條號改錨點'=>lambda{BodyRehearsal.convert('equality-hashing-ordering')},
 'CA 清單正常增文'=>lambda{BodyRehearsal.convert('concurrency-and-async')},
 'CO 清單正常增文'=>lambda{BodyRehearsal.convert('collections-and-ownership')},
 'BM 移入及協調者刪共通'=>lambda{
  BodyRehearsal.convert('boundary-mapping');p='rules/architecture/data-mapping.md';File.write(p,File.read(p).sub('；不得略過欄位或產生不完整物件掩蓋失敗',''))
  j='docs/body-restructuring/common/existing-sources.json';r=JSON.parse(File.read(j));r['changes'].reject!{|e|e['path']==p}
  r['changes']+=BodyRestructuring.edits(BodyRestructuring.original(p),File.read(p)).map{|e|e.merge('path'=>p,'decision'=>'一／BM-04','reason'=>'協調者確認 BM-04 已完整逐字承接禁止句，才刪除暫留共通摘要，其他收斂不變。')};File.write(j,JSON.pretty_generate(r)+"\n")
 },
 'JT 重複引用僅移除一條'=>lambda{r=BodyRehearsal.convert('types-and-generics');BodyRehearsal.remove(r,'JT-03',['rules/coding/type-safety.md#容器與泛型']);BodyRehearsal.finish_links(r)},
  '另一份完整整理 ND-01 至 ND-07'=>lambda{
  r=BodyRehearsal.convert('naming-packages-docs')
  BodyRehearsal.remove(r,'ND-05',['rules/coding/code-design.md#nd-05'])
  notes={
   'ND-01'=>'命名形式、縮寫與 final／I 前綴限制均與 Java 識別字一併敘述；保守留全文，避免以共通變數命名取代類別契約。',
   'ND-02'=>'待補證依核准清單整條保留，Service／Handler／Helper／Utils 的責任要求不因共通命名摘要而移除。',
   'ND-03'=>'套件責任、可見性與不強制目錄的界線一併保留；公開／內部的 Java package 施行範圍交人工複核。',
   'ND-04'=>'契約資訊的選案範圍與 Javadoc 就近維護相連，保守保留不要求每個方法全部項目的邊界。',
   'ND-06'=>'IDE 直接引用不能涵蓋設定與動態使用端；保留完整核對與遷移限制，避免拆分時弱化間接引用要求。',
   'ND-07'=>'共通驗收已有引用，後句保留 Javadoc 參照、可執行範例與支援版本的 Java 增量，未刪既有斷言。'
  }
  r['rules'].each{|e|e['reason']=notes[e['id']] if notes[e['id']]}
  r['rules'].find{|e|e['id']=='ND-07'}['kind']='保留增量'
  BodyRehearsal.finish_links(r)
 }
}
results=[]
cases.each do |name,work|
 Dir.mktmpdir('body-rehearsal-') do |dir|
  %w[rules docs scripts].each{|p|FileUtils.cp_r(File.join(ROOT,p),dir)}
  Dir.chdir(dir) do
   begin
    work.call
    out,status=Open3.capture2e({'BODY_ROOT'=>dir,'BODY_GIT_DIR'=>GIT},'ruby','scripts/verify-body-restructuring.rb')
    results<<{test:name,exit:status.exitstatus,matched:status.success?,diagnostic:status.success? ? '主檢查通過' : out.lines.first.to_s.strip}
   rescue => e;results<<{test:name,matched:false,diagnostic:e.message};end
  end
 end
end
# 真正建立三個工作者分支，每支只有兩檔，再合併；不只疊加目錄內容。
Dir.mktmpdir('body-merge-') do |dir|
 repo=File.join(dir,'repo');_,err,status=Open3.capture3('git','clone','--quiet','--shared',ROOT,repo);raise err unless status.success?
 %w[rules docs scripts].each{|p|FileUtils.cp_r(File.join(ROOT,p),repo)}
 Dir.chdir(repo) do
  system('git','config','user.name','Rehearsal');system('git','config','user.email','rehearsal@example.invalid')
  system('git','add','rules','docs','scripts');system('git','commit','-qm','演練工具起點')
  start=Open3.capture2('git','rev-parse','HEAD').first.strip
  topics=%w[boundary-mapping exceptions-and-resources collections-and-ownership]
  topics.each_with_index do |topic,i|
   system('git','checkout','-qb',"worker-#{i}",start)
   BodyRehearsal.convert(topic)
   system('git','add',"rules/stacks/java/common/#{topic}.md","docs/body-restructuring/java/#{topic}.json");system('git','commit','-qm',topic)
   out,status=Open3.capture2e('ruby','scripts/verify-body-worker-scope.rb','--topic',topic,'--start',start,'--expected-start',start)
   results<<{test:"三工作者 #{topic} 範圍",exit:status.exitstatus,matched:status.success?&&out.include?('工作者範圍通過'),diagnostic:status.success? ? '工作者範圍通過' : out}
  end
  system('git','checkout','-qb','integration',start)
  topics.each_index do |i|
   out,status=Open3.capture2e('git','merge','--no-ff','-m',"merge worker #{i}","worker-#{i}")
   results<<{test:"合併 worker #{i}",exit:status.exitstatus,matched:status.success?,diagnostic:status.success? ? '無衝突合併' : out}
  end
  out,status=Open3.capture2e({'BODY_ROOT'=>repo,'BODY_GIT_DIR'=>GIT},'ruby','scripts/verify-body-restructuring.rb')
  results<<{test:'三工作者合併主檢查',exit:status.exitstatus,matched:status.success?,diagnostic:status.success? ? '主檢查通過' : out.lines.first}
  out,status=Open3.capture2e('ruby','scripts/test-body-reverts.rb')
  results<<{test:'集合完成後撤回適用性',exit:status.exitstatus,matched:status.success?&&out.include?('"applicable": false'),diagnostic:status.success? ? '明確略過已整理集合的獨立撤回；併發仍測試' : out.lines.first}
 end
end
puts JSON.pretty_generate(results)
exit(results.all?{|r|r[:matched]} ? 0 : 1)
