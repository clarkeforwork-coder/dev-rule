# frozen_string_literal: true
require 'tmpdir'
require 'fileutils'
require_relative 'body-rehearsal-fixtures'
ROOT=File.expand_path('..',__dir__)
GIT=File.expand_path(Open3.capture2('git','rev-parse','--git-common-dir',chdir:ROOT).first.strip,ROOT)
ENV['BODY_GIT_DIR']=GIT
J=BodyStructure::JN
RECORD='docs/body-restructuring/java/null-and-optional.json'
def patch(r,from,to)
 File.write(J,File.read(J).sub(from,to));r['sentences'].each{|s|s['targets'].each{|t|t['text']=t['text'].sub(from,to) if t['text']}};BodyRehearsal.save(r)
end
cases=[]
def add(c,n,d,&b);c<<[n,d,b];end
add(cases,'X02 一級來源擴大範圍','承接原文不在共通小節'){|r|a=r['sentences'].find{|s|s['history_id']=='JN-09'&&!s['removed_assertions'].empty?}['removed_assertions'].first;a['source_uri']='rules/coding/nullability.md#空值語意'}
add(cases,'X05 未申報缺值禁止刪除','未申報的刪除片段'){|r|patch(r,'，不得掩蓋缺值','')}
add(cases,'X06 任意子句碎片','未申報的刪除片段'){|r|r['sentences'][8]['removed_assertions'][0]['text']='反錯誤分'}
add(cases,'X08 未核准移入','移入句不在核准清單'){|r|i=BodyStructure::APPROVED_IMPORTS[0].merge('history_id'=>'JN-12','target_uri'=>J+'#java-api-absence','reason'=>'測試將核准句移到錯誤的 Java 文件，必須由核准清單拒絕。');r['imports']=[i];patch(r,'具體序列化配置由 Framework 規範落實。','具體序列化配置由 Framework 規範落實。'+i['source_text']+'。')}
add(cases,'X09 移入不完整','移入句不在核准清單'){|_|r=BodyRehearsal.convert('boundary-mapping');i=r['imports'][0];File.write(r['path'],File.read(r['path']).sub(i['source_text'],'不得略過欄位或產生不完整物件'));i['source_text']='不得略過欄位或產生不完整物件';BodyRehearsal.save(r)}
add(cases,'X10 條文改指一級','條文小標題不符基準'){|r|u=J+'#java-null-與-optional';old=r['rules'][0]['targets'][0];r['rules'][0]['targets']=[u];r['sentences'].each{|s|s['targets'].each{|t|t['uri']=u if t['uri']==old}}}
add(cases,'X11 保留清單改種類','必須整條保留 JN-11'){|r|r['rules'].find{|e|e['id']=='JN-11'}['kind']='拆分'}
add(cases,'X12 重複理由','同條改寫／移除理由重複'){|r|ss=r['sentences'].select{|s|s['history_id']=='JN-12'};ss[1]['reason']=ss[0]['reason']}
add(cases,'X13 第一欄夾帶限定','驗收第一欄不符固定格式'){|r|e=r['acceptance_changes'][1];old=e['after'];e['after']=old.sub(' | 驗證','（僅公開 API） | 驗證');patch(r,old,e['after'])}
add(cases,'X15 改小標題','條文小標題不符基準'){|r|patch(r,'### 集合內容的空值','### 集合內容的空值（僅對外）')}
add(cases,'X16b 插入標題','條文小節含額外標題'){|r|patch(r,'### 集合內容的空值',"### 集合內容的空值\n\n#### 內部不受限制。")}
add(cases,'X16c 錨點行藏義務','正文錨點行含未核准內容'){|r|patch(r,'## 契約維護與對外表示',"<a id=\"java-x\"></a>內部不受限制。\n\n## 契約維護與對外表示")}
add(cases,'X17d 未併入卻標種類','整份併入種類只允許 merged'){|r|r['rules'][0]['kind']='整份併入他檔'}
add(cases,'X17e 任意驗收入口','必須整條保留 JN-05'){|r|r['rules'].find{|e|e['id']=='JN-05'}['kind']='轉為驗收入口'}
add(cases,'X25 漏報刪除子句','未申報的刪除片段'){|r|r['sentences'].find{|s|s['history_id']=='JN-08'&&!s['removed_assertions'].empty?}['removed_assertions']=[]}
%w[X26 X27].each_with_index{|id,i|add(cases,id+' 承接碎片','承接原文不在共通小節'){|r|a=r['sentences'][6]['removed_assertions'][i];a['source_text']=a['source_text'][0,8]}}
add(cases,'承接子句誤指 Java','承接子句必須指向共通'){|r|r['sentences'][6]['removed_assertions'][0]['source_uri']=J+'#java-query-absence'}
add(cases,'驗收非表格來源錯誤','驗收非表格變更來源／理由無效'){|_|r=BodyRehearsal.convert('exceptions-and-resources');r['acceptance_text_changes'][0]['before']='不存在的原句';BodyRehearsal.save(r)}
add(cases,'驗收非表格改了非條號','驗收非表格包含非條號改動'){|_|r=BodyRehearsal.convert('equality-hashing-ordering');r['acceptance_text_changes'][0]['after']+='不必驗證。';BodyRehearsal.save(r)}
add(cases,'清空分組漏指路','清空分組缺少指路文字'){|_|r=BodyRehearsal.convert('collections-and-ownership');%w[CO-01 CO-02 CO-03].each{|id|BodyRehearsal.remove(r,id,['rules/coding/collections-and-ownership.md#'+id.downcase])};BodyRehearsal.finish_links(r);r['group_routes']=[];BodyRehearsal.save(r)}
add(cases,'指路文字夾義務','指路文字不符固定格式'){|_|r=BodyRehearsal.convert('collections-and-ownership');%w[CO-01 CO-02 CO-03].each{|id|BodyRehearsal.remove(r,id,['rules/coding/collections-and-ownership.md#'+id.downcase])};BodyRehearsal.finish_links(r);r['group_routes'][0]['text']+='可免驗證。';BodyRehearsal.save(r)}
add(cases,'漏基準共同連結','基準共通連結遺漏'){|r|patch(r,'[測試程式碼](../../../quality/rule-verification.md#測試程式碼)','測試程式碼')}
add(cases,'尾段無獨立小節','分組尾段必須指向獨立結尾小節'){|r|r['sentences'].select{|s|s['targets'].any?{|t|t['uri']==J+'#java-closing-requirements'}}.each{|s|s['targets'][0]['uri']=J+'#java-api-absence'};patch(r,"<a id=\"java-closing-requirements\"></a>\n\n## 補充要求\n\n",'')}
add(cases,'BM 未移入','BM-04 缺少完整核准移入句'){|_|r=BodyRehearsal.convert('boundary-mapping');i=r['imports'].pop;File.write(r['path'],File.read(r['path']).sub(i['source_text']+'。',''));BodyRehearsal.save(r)}
add(cases,'CA 未增驗收','缺少必要共同驗收增文'){|_|r=BodyRehearsal.convert('concurrency-and-async');File.write(r['path'],File.read(r['path']).sub(r['acceptance_additions'].first,''));r['acceptance_additions']=[];BodyRehearsal.save(r)}
add(cases,'重複文件紀錄','重複文件紀錄'){|r|File.write('docs/body-restructuring/java/duplicate.json',JSON.generate(r))}
add(cases,'文件 ID 順序錯誤','文件歷史 ID 不符合基準條文'){|r|r['rules'][0],r['rules'][1]=r['rules'][1],r['rules'][0]}
add(cases,'差異清單未知檔案','差異清單包含未知檔案'){|_|p='docs/body-restructuring/common/existing-sources.json';r=JSON.parse(File.read(p));r['changes']<<{'path'=>'rules/unknown.md','decision'=>'一／BM-04','baseline_line'=>1,'remove'=>[],'insert'=>[],'reason'=>'測試清單引用不存在的基準規則檔案，必須拒絕未核准的來源。'};File.write(p,JSON.generate(r))}
add(cases,'新增一般規則檔','rules 檔案清單變更未登錄'){|_|File.write('rules/unknown.md','未核准')}
add(cases,'保留句文字改寫','保留句子不是逐字保留'){|r|r['sentences'][0]['targets'][0]['text']='本文件只維護 Java 的具體要求'}
add(cases,'驗收列遺失且同步刪列紀錄','去向錨點無效'){|r|e=r['acceptance_changes'].last;patch(r,e['after'],'')}
add(cases,'核准移入理由不足','移入句理由不足'){|_|r=BodyRehearsal.convert('boundary-mapping');r['imports'][0]['reason']='x';BodyRehearsal.save(r)}
add(cases,'完整轉換卻留數字第一欄','驗收第一欄不符固定格式'){|_|r=BodyRehearsal.convert('exceptions-and-resources');e=r['acceptance_changes'].find{|e|e['before'].include?('<a id=')};File.write(r['path'],File.read(r['path']).sub(e['after'],e['before']));r['acceptance_changes'].delete(e);BodyRehearsal.save(r)}
results=[]
cases.each do |name,diagnostic,mutation|
 Dir.mktmpdir('body-policy-') do |dir|
  %w[rules docs scripts].each{|p|FileUtils.cp_r(File.join(ROOT,p),dir)}
  Dir.chdir(dir) do
   r=JSON.parse(File.read(RECORD));mutation.call(r);File.write(RECORD,JSON.pretty_generate(r)+"\n")
   out,status=Open3.capture2e({'BODY_ROOT'=>dir,'BODY_GIT_DIR'=>GIT},'ruby','scripts/verify-body-restructuring.rb')
   results<<{test:name,expected:diagnostic,exit:status.exitstatus,matched:status.exitstatus==1&&out.include?(diagnostic),diagnostic:out.lines.first.to_s.strip}
  end
 end
end
puts JSON.pretty_generate(results);exit(results.all?{|r|r[:matched]} ? 0 : 1)
