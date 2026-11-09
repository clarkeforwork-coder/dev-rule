# frozen_string_literal: true
require 'tmpdir'
require 'fileutils'
require_relative 'body-structure-checks'
ROOT=File.expand_path('..',__dir__)
GIT_DIR=File.expand_path(Open3.capture2('git','rev-parse','--git-common-dir',chdir:ROOT).first.strip,ROOT)
ENV['BODY_GIT_DIR']=GIT_DIR
J='rules/stacks/java/common/null-and-optional.md'
RECORD='docs/body-restructuring/java/null-and-optional.json'
def edit_record(path)
 r=JSON.parse(File.read(path));yield r;File.write(path,JSON.pretty_generate(r)+"\n")
end
def patch_jn(r,from,to)
 File.write(J,File.read(J).sub(from,to));r['edits']=BodyRestructuring.edits(BodyRestructuring.original(J),File.read(J)).map{|e|e.merge('reason'=>'負向測試明確登錄現況差異，以驗證其他獨立保護能否拒絕不合法改動。')}
end
def pending_fixture
 p=Dir.glob('docs/body-restructuring/java/*.json').find{|f|f!=RECORD && JSON.parse(File.read(f))['status']=='pending'} || Dir.glob('docs/body-restructuring/java/*.json').find{|f|f!=RECORD}
 r=JSON.parse(File.read(p));base=BodyRestructuring.original(r['path']);File.write(r['path'],base);r['status']='pending';r['edits']=[];r['imports']=[];r['acceptance_changes']=[];r['acceptance_text_changes']=[];r['acceptance_additions']=[]
 prefix=r['rules'][0]['id'].split('-')[0];heading=nil;targets={}
 base.lines.each{|l|heading=l.sub(/^## /,'').strip.downcase.gsub(/[\p{P}\p{S}&&[^_-]]/,'').gsub(/\s/,'-') if l.start_with?('## ');targets[format('%s-%02d',prefix,l.to_i)]=r['path']+'#'+heading if l.match?(/^\d+\. /)}
 root=r['path']+'#'+base.lines.first.sub(/^# /,'').strip.downcase.gsub(/[\p{P}\p{S}&&[^_-]]/,'').gsub(/\s/,'-')
 r['rules'].each{|e|e['kind']='整條保留';e['targets']=[targets[e['id']]];e['reason']='尚未整理，測試固定基準未變保護，不依賴此主題目前是否已完成。'}
 r['sentences'].each{|s|s['action']='保留';s['targets']=[{'uri'=>s['history_id'] ? targets[s['history_id']] : root,'text'=>s['source']}];s['removed_assertions']=[];s.delete('common_sources')}
 File.write(p,JSON.pretty_generate(r)+"\n");[p,r]
end
cases=[]
def add(cases,name,diagnostic,command=nil,&block);cases<<[name,diagnostic,command,block];end
add(cases,'乾淨複本',nil){}
add(cases,'N02c 刪共同驗收連結','基準共通連結遺漏'){|r|patch_jn(r,"- [測試程式碼](../../../quality/rule-verification.md#測試程式碼)。\n",'')}
add(cases,'N02d 刪例外治理尾句','基準共通連結遺漏'){|r|patch_jn(r,File.read(J).lines.last,'')}
add(cases,'N02f 改引言並同步目的文字','驗收非表格內容未依基準保留'){|r|patch_jn(r,'，不因引用共通驗收而略過','');r['sentences'].each{|s|s['targets'].each{|t|t['text']=t['text'].to_s.sub('，不因引用共通驗收而略過','') if t['text']}}}
add(cases,'N08c 整條保留改寫','整條保留必須逐句保留'){|r|patch_jn(r,'預設不允許 `null`','預設不建議 `null`');e=r['sentences'].find{|s|s['history_id']=='JN-11'};e['action']='改寫';e['reason']='測試將整條保留偷偷改寫，確認種類與句子處置必須一致。';e['targets'][0]['text']=e['source'].sub('不允許','不建議')}
add(cases,'N13 假整條移除','整條移除必須逐句移除'){|r|r['rules'].find{|e|e['id']=='JN-05'}['kind']='整條移除'}
add(cases,'N14 ID 指錯小節','歷史 ID 去向與句子小節不一致'){|r|r['rules'][0]['targets']=[J+'#java-api-absence']}
add(cases,'N12b 保留小節新增義務','整條保留小節含刪改或新增句子'){|r|patch_jn(r,'查詢結果另遵循本文件的 `Optional` 與空集合要求。','查詢結果另遵循本文件的 `Optional` 與空集合要求。所有查詢必須額外送出稽核事件。')}
add(cases,'N06b 自行新增共通清單','未核准的共通紀錄檔名'){File.write('docs/body-restructuring/common/zz.json',JSON.generate({'baseline'=>BodyRestructuring::BASELINE,'changes'=>[]}))}
add(cases,'N16 假完成','已完成紀錄仍有尚未整理去向'){p,_=pending_fixture;edit_record(p){|r|r['status']='completed'}}
add(cases,'N17 改寫僅貼兩字','改寫 text 必須為目的地完整一句'){|r|r['sentences'][6]['targets'][0]['text']='契約'}
add(cases,'N04 無關錨點未同步證據','移除去向與承接證據不一致'){|r|r['sentences'].select{|s|s['action']=='移除'}.each{|s|s['targets']=[{'uri'=>'rules/quality/performance.md#co-06'}]};r['rules'].find{|e|e['id']=='JN-06'}['targets']=['rules/quality/performance.md#co-06']}
add(cases,'未整理文件異動（動態基準夾具）','未整理文件改動'){_,r=pending_fixture;File.open(r['path'],'a'){|f|f.puts '未登錄變更'}}
add(cases,'行尾變更（動態基準夾具）','未整理文件改動'){_,r=pending_fixture;File.binwrite(r['path'],File.binread(r['path']).gsub("\n","\r\n"))}
add(cases,'未登錄共通改動','未登錄改動 rules/coding/nullability.md'){File.open('rules/coding/nullability.md','a'){|f|f.puts '未登錄'}}
add(cases,'歷史 ID 遺漏','歷史 ID 集合不完整或重複'){|r|r['rules'].pop}
add(cases,'去向種類無效','去向種類無效'){|r|r['rules'][0]['kind']='任意'}
add(cases,'Java 基準移動','Java 基準不符'){|r|r['baseline']='HEAD'}
add(cases,'句子遺漏','基準逐句去向不完整'){|r|r['sentences'].pop}
add(cases,'去向文字不存在','去向文字不存在'){|r|r['sentences'][0]['targets'][0]['text']='不存在的句子。'}
add(cases,'去向錨點不存在','去向錨點無效'){|r|r['rules'][0]['targets'][0]+='-不存在'}
add(cases,'改寫理由不足','句子改寫／移除理由不足'){|r|r['sentences'][6]['reason']=' '}
add(cases,'共通來源指向 Java','共通來源指向 Java'){|r|r['sentences'][6]['common_sources']=[J+'#java-query-absence']}
add(cases,'共通基準不符','共通基準不符'){edit_record('docs/body-restructuring/common/ca-06.json'){|r|r['baseline']='HEAD'}}
add(cases,'共通修改 Java','共通清單不得修改 Java 文件'){edit_record('docs/body-restructuring/common/ca-06.json'){|r|r['changes'][0]['path']=J}}
add(cases,'共通決策缺漏','共通差異缺決策列'){edit_record('docs/body-restructuring/common/ca-06.json'){|r|r['changes'][0].delete('decision')}}
add(cases,'共通來源刪文不符','差異區塊重疊或來源不符'){edit_record('docs/body-restructuring/common/ca-06.json'){|r|r['changes'][0]['remove']=['假的來源']}}
add(cases,'共通理由不足','差異理由不足'){edit_record('docs/body-restructuring/common/ca-06.json'){|r|r['changes'][0]['reason']='x'}}
add(cases,'狀態無效','整理狀態無效'){|r|r['status']='任意'}
add(cases,'隱藏檔','rules 檔案清單變更未登錄'){File.write('rules/.unregistered','x')}
add(cases,'連結檔案不存在','連結檔案不存在'){File.write('docs/negative-link.md','[測試](不存在.md)')}
add(cases,'連結錨點不存在','連結錨點不存在'){File.write('docs/negative-link.md','[測試](../rules/coding/nullability.md#不存在)')}
add(cases,'重複錨點','錨點重複'){File.write('docs/negative-anchor.md',"<a id=\"x\"></a>\n<a id=\"x\"></a>\n")}
add(cases,'移除目的地是 Java','移除須指向共通條文'){|r|r['sentences'][16]['targets']=[{'uri'=>J+'#java-query-absence'}]}
add(cases,'驗收變更理由不足','驗收變更來源／理由無效'){|r|r['acceptance_changes'][0]['reason']='x'}
add(cases,'驗收重複登錄','驗收變更重複'){|r|r['acceptance_changes']<<r['acceptance_changes'].last.dup}
add(cases,'驗收第二欄改動','驗收內容不得以條號調整之名改寫'){|r|r['acceptance_changes'][1]['after']=r['acceptance_changes'][1]['after'].sub('驗證有值','忽略有值');File.write(J,File.read(J).sub('驗證有值','忽略有值'))}
add(cases,'L13 任意表頭名稱','驗收表頭不允許任意改名'){|r|r['acceptance_changes'][0]['after']=r['acceptance_changes'][0]['after'].sub('對應要求','隨意名稱');File.write(J,File.read(J).sub('| 對應要求 |','| 隨意名稱 |'))}
add(cases,'待決 153 ID 清冊缺列','Pending decision ID inventory changed'){p='docs/pending-decisions.md';s=File.read(p);File.write(p,s.sub(/^\| \[JT-03 第.*\n/,''))}
add(cases,'待決 19 ID 清冊缺列','Pending reference ID inventory changed'){p='docs/pending-decisions.md';s=File.read(p);a,b=s.split('## 六、',2);File.write(p,a+'## 六、'+b.sub(/^\| \[JT-03 第.*\n/,''))}
add(cases,'L2 空驗收列','Empty acceptance',['ruby','scripts/verify-body-acceptance.rb']){p='rules/coding/nullability.md';File.write(p,File.read(p)+"\n| 契約 | 驗收內容 |\n| --- | --- |\n| 空案例 |  |\n")}
add(cases,'追溯片段遺漏','Missing/changed original fragments',['ruby','scripts/verify-body-acceptance.rb']){p='docs/acceptance-cleanup-batch-1.md';File.write(p,File.read(p).lines.reject{|l|l.start_with?('| CL-')}.join)}
add(cases,'句子所屬 ID 錯誤','句子所屬歷史 ID 不符'){|r|r['sentences'][3]['history_id']='JN-02'}
add(cases,'被刪子句不存在','被刪子句不在基準原句'){|r|r['sentences'][6]['removed_assertions'][0]['text']='虛構的原句'}
add(cases,'刪除子句仍在','被刪子句仍在現行文件'){|r|r['sentences'][6]['removed_assertions'][0]['text']='Optional'}
add(cases,'共通承接原文不存在','承接原文不在共通小節'){|r|r['sentences'][6]['removed_assertions'][0]['source_text']='這一句並沒有存在於該共通小節之內。'}
add(cases,'移除缺承接證據','移除句缺少子句承接證據'){|r|r['sentences'][16]['removed_assertions']=[]}
add(cases,'未登錄新句','現行正文句子未登錄'){|r|patch_jn(r,'### 查詢的正常缺值',"### 查詢的正常缺值\n\n所有查詢另須建立稽核紀錄。")}
add(cases,'驗收任意增文','驗收增文未列白名單'){|r|r['acceptance_additions']<<"新義務。\n"}
add(cases,'非表格改動不是條號','驗收非表格只准改條號引用'){|r|r['acceptance_text_changes']=[{'before'=>"\n",'after'=>"放寬\n",'references'=>[{'before'=>'共同驗收','after'=>'放寬'}],'reason'=>'負向測試假裝條號替換，應拒絕其他驗收內容的任意變更。'}]}
add(cases,'整份併入種類不一致','整份併入種類不一致'){|r|r['status']='merged'}
add(cases,'整份併入沒有接收檔','整份併入檔案狀態不符'){|r|r['status']='merged';r['rules'].each{|e|e['kind']='整份併入他檔'};r['merged_target']='rules/不存在.md'}
add(cases,'整份併入漏完整刪文','整份併入未登錄完整刪文'){|r|r['status']='merged';r['rules'].each{|e|e['kind']='整份併入他檔'};r['merged_target']='rules/coding/nullability.md';File.delete(J);r['edits']=[]}
def add_import(r,write=true)
 text='不得略過欄位或產生不完整物件掩蓋失敗'
 r['imports']=[{'source_path'=>'rules/architecture/data-mapping.md','source_text'=>text,'target_uri'=>J+'#java-api-absence','history_id'=>'JN-12','reason'=>'暫存複本只用樣板測試移入格式，來源逐字取固定共通基準，不寫入實際分支。'}]
 patch_jn(r,'具體序列化配置由 Framework 規範落實。','具體序列化配置由 Framework 規範落實。'+text+'。') if write
end
add(cases,'未核准樣板移入遭拒','移入句不在核准清單'){|r|add_import(r)}
add(cases,'移入來源非共通','移入來源必須為共通檔'){|r|add_import(r);r['imports'][0]['source_path']=J}
add(cases,'移入原文不在基準','移入原文不在固定基準'){|r|add_import(r);r['imports'][0]['source_text']='這是未核准而且不存在的共通新義務。'}
add(cases,'移入原文未寫入','移入原文不在 Java 目的小節'){|r|add_import(r,false)}
add(cases,'移入 ID 不符','移入句所屬 ID 或小節不符'){|r|add_import(r);r['imports'][0]['history_id']='JN-05'}
add(cases,'未核准移入且理由不足','移入句不在核准清單'){|r|add_import(r);r['imports'][0]['reason']='x'}
add(cases,'歷史去向理由不足','歷史去向理由不足'){|r|r['rules'][0]['reason']='x'}
add(cases,'歷史去向清空','歷史 ID 沒有現行去向'){|r|r['rules'][0]['targets']=[]}
add(cases,'句子處置無效','句子處置無效'){|r|r['sentences'][0]['action']='任意'}
add(cases,'句子去向清空','句子沒有去向'){|r|r['sentences'][0]['targets']=[]}
add(cases,'去向不在同一小節','去向文字不存在'){|r|r['sentences'][6]['targets'][0]['uri']=J+'#java-container-nulls'}
add(cases,'非分類 Java 檔案','Java 文件不在原分類範圍'){|r|r['path']='rules/coding/nullability.md';r['status']='completed'}
add(cases,'隱藏共通清單','未核准的共通紀錄檔名'){File.write('docs/body-restructuring/common/.zz.json','{}')}
add(cases,'非 JSON 共通檔','未核准的共通紀錄檔名'){File.write('docs/body-restructuring/common/zz.txt','未核准')}
add(cases,'追溯格式破損','Malformed trace rows',['ruby','scripts/verify-body-acceptance.rb']){p='docs/acceptance-cleanup-batch-1.md';File.write(p,File.read(p).sub('[主要驗收]','[失準標籤]'))}
add(cases,'追溯 ID 重複','Duplicate trace IDs',['ruby','scripts/verify-body-acceptance.rb']){p='docs/acceptance-cleanup-batch-1.md';s=File.read(p);File.write(p,s+s.lines.find{|l|l.start_with?('| CL-')})}
add(cases,'追溯多餘片段','Unexpected trace fragments',['ruby','scripts/verify-body-acceptance.rb']){p='docs/acceptance-cleanup-batch-1.md';s=File.read(p);File.write(p,s+s.lines.find{|l|l.start_with?('| CL-')}.sub(/CL-[\d、]+-\d+/,'ZZ-99-1'))}
add(cases,'追溯目的地改寫不符','Invalid rewritten fragment',['ruby','scripts/verify-body-acceptance.rb']){p='docs/acceptance-rewritten-fragments.json';r=JSON.parse(File.read(p));r[0]['replacement']='假的目的列';File.write(p,JSON.generate(r))}
add(cases,'追溯缺承接文字','Trace fragment absent from destination',['ruby','scripts/verify-body-acceptance.rb']){p='docs/acceptance-cleanup-batch-1.md';s=File.read(p);l=s.lines.find{|x|x.start_with?('| CL-')};File.write(p,s.sub(l,l.sub(/\]\([^)]+\)/,'](../rules/coding/nullability.md#acceptance-third-party-null)')))}
add(cases,'主入口拒絕追溯改寫','驗收追溯失敗'){p='docs/acceptance-rewritten-fragments.json';r=JSON.parse(File.read(p));r[0]['replacement']='假的目的列';File.write(p,JSON.generate(r))}
add(cases,'共通 Java 驗收重複','Scoped duplicate acceptance',['ruby','scripts/verify-body-acceptance.rb']){text=File.read(J).lines.find{|l|l.include?('acceptance-java-optional-results')}.split(' | ',3)[1];File.open('rules/coding/nullability.md','a'){|f|f.puts "\n| 契約 | 驗收內容 |\n| --- | --- |\n| 測試 | #{text} |"}}
results=[]


cases.each do |name,diagnostic,command,mutation|
 Dir.mktmpdir('body-negative-') do |dir|
  %w[rules docs scripts].each{|p|FileUtils.cp_r(File.join(ROOT,p),dir)}
  Dir.chdir(dir) do
   r=JSON.parse(File.read(RECORD));mutation.call(r);File.write(RECORD,JSON.pretty_generate(r)+"\n")
   out,status=Open3.capture2e({'BODY_ROOT'=>dir,'BODY_GIT_DIR'=>GIT_DIR},*(command||['ruby','scripts/verify-body-restructuring.rb']))
   expected=diagnostic ? 1 : 0
   results<<{test:name,expected_exit:expected,actual_exit:status.exitstatus,expected_diagnostic:diagnostic,matched:status.exitstatus==expected && (!diagnostic||out.include?(diagnostic)),diagnostic:status.success? ? '通過' : out.lines.first.to_s.strip}
  end
 end
end
# 工作者範圍：建立極小獨立儲存庫，涵蓋提交、工作區及未追蹤檔案。
Dir.mktmpdir('body-worker-scope-') do |dir|
 Dir.chdir(dir) do
  system('git','init','-q');%w[rules/stacks/java/common docs/body-restructuring/java].each{|p|FileUtils.mkdir_p(p)}
  [J,RECORD,'docs/java-rule-migration.md'].each{|p|File.write(p,'base')};system('git','add','.');system('git','-c','user.name=Test','-c','user.email=test@example.invalid','commit','-qm','fixture')
  start=Open3.capture2('git','rev-parse','HEAD').first.strip
  [J,RECORD].each{|p|File.write(p,'changed')}
  [false,true].each do |outside|
   File.write('docs/java-rule-migration.md','changed') if outside
   out,status=Open3.capture2e('ruby',File.join(ROOT,'scripts/verify-body-worker-scope.rb'),'--topic','null-and-optional','--start',start)
   diagnostic=outside ? '工作者超出允許範圍：docs/java-rule-migration.md' : '工作者範圍通過'
   results<<{test:outside ? '工作者越界' : '工作者只改兩檔',expected_exit:outside ? 1 : 0,actual_exit:status.exitstatus,expected_diagnostic:diagnostic,matched:status.exitstatus==(outside ? 1 : 0)&&out.include?(diagnostic),diagnostic:out.strip}
  end
 end
end
puts JSON.pretty_generate(results)
exit(results.all?{|r|r[:matched]} ? 0 : 1)
