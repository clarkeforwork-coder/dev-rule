# frozen_string_literal: true
require_relative 'body-restructuring-lib'
Dir.chdir(File.expand_path('..',__dir__))
out,err,status=Open3.capture3('ruby','scripts/verify-body-restructuring.rb')
abort err unless status.success?
check=JSON.parse(out)
records=Dir['docs/body-restructuring/java/*.json'].sort.map{|p|JSON.parse(File.read(p))}
map=records.flat_map{|r|r['rules'].map{|e|[e['id'],e.merge('path'=>r['path'])]}}.to_h
escape=->(s){s.to_s.gsub('|','\\|').gsub("\n",' ')}
rows=->(head,data){"| #{head.join(' | ')} |\n| #{head.map{'---'}.join(' | ')} |\n"+data.map{|a|'| '+a.map{|s|escape.call(s)}.join(' | ')+' |'}.join("\n")+"\n"}
text=<<'DOC'
# 正文整理階段 B：合併與收尾紀錄

本檔由 `ruby scripts/record-body-stage-b.rb` 讀取 git 合併紀錄、15 份去向紀錄及常駐檢查輸出產生；總表不手抄。工作者原始回報原樣保存在[原始回報](body-restructuring-stage-b-worker-reports.md)。正文基準仍為 `350668eb14ede247af22c782323beebf940c2a5f`，共同分派起點為 `7b2667c72d2163a5be9e782dec13946ed7590e90`，整合收尾起點為 `2872bb1`。

## 提交對照

DOC
merges,status=Open3.capture2('git','log','--reverse','--first-parent','--merges','--format=%H %P %s','7b2667c..2872bb1');abort unless status.success?
data=merges.lines.map{|l|h,parent,worker,subject=l.strip.split(' ',4);[subject,worker,h]};raise '合併清冊不是 14 份' unless data.size==14
text+=rows.call(%w[文件 工作者提交 合併提交],data)
text+="\n## 153 條最終去向\n\n原判斷保持原文，CA-06 與 CO-08 的核准例外仍由工具處理；正文中的歷史 ID 僅在追溯保留。\n\n"
raise '去向清冊不是 153 條' unless check['rule_dispositions'].size==153
text+=rows.call(['歷史 ID','待決清單判斷','實際去向種類','現行 Java 或共通錨點'],check['rule_dispositions'].sort_by{|e|e['id']}.map{|e|[e['id'],e['decision'],e['kind'],map.fetch(e['id'])['targets'].join('、')]})
manual=check['manual_review_sentences'];conservative=manual.select{|e|e['conservative']};retained=conservative.reject{|e|e['decision']=='驗收入口'}
text+="\n## 與原判斷不同的保守處置\n\n工具列 #{conservative.size} 條保守去向，其中五條是已核准整條保留的驗收入口；其餘 #{retained.size} 條如下，理由直接取工作者 JSON。全部依本輪決策維持，不重新刪改。\n\n"
text+=rows.call(['歷史 ID','原判斷','實際去向','工作者理由'],retained.sort_by{|e|e['history_id']}.map{|e|e.values_at('history_id','decision','actual','reason')})
text+="\nCO-08、RF-06、VO-07 的實際種類符合核准混合處理，但工作者另指出核對狀態、Java 警告抑制主詞與還原入口的承接不直接，故相關整句保留；詳見原始回報與逐句 JSON，未把種類相同誤作沒有語意複核需求。\n"
text+="\n## 人工複核數量\n\n常駐輸出共 #{check['manual_review_count']} 項（不同類別可能涉及同一句，不是獨立義務數）。\n\n"
text+=rows.call(%w[類別 項數],manual.group_by{|e|e['type']||e['action']}.sort.map{|type,items|[type,items.size]})
text+="\n機器核對原文、清冊、位置及結構；共通承接是否充分、增減限定是否改變要求、保守理由是否成立仍須人工逐句複核。已核准保留不代表已證明與共通完全等價。\n"
text+="\n## 收尾確認與 BM-04\n\n共用遷移表及待決清單第三、四、六、七、八節的現行連結已更新；原判斷、歷史條號、歷史建議及整理前原文未提交的限制保留，第九節追加執行狀態。\n\n"
%w[concurrency-and-async collections-and-ownership].each do |topic|
 r=records.find{|r|r['path'].end_with?(topic+'.md')};r['acceptance_additions'].each{|s|raise '驗收增文遺失' unless File.read(r['path']).include?(s);text+="- `#{topic}`：#{s.strip.gsub("../../../", "../rules/")}\n"}
end
%w[exceptions-and-resources equality-hashing-ordering].each do |topic|
 r=records.find{|r|r['path'].end_with?(topic+'.md')};r['acceptance_text_changes'].each do |e|
 text+="\n`#{topic}` 非表格變更：\n\n```text\n原文：#{e['before']}\n現文：#{e['after']}\n```\n"
 end
end
text+=<<'DOC'

主檢查核對上述非表格段落只有登錄的條號替換，其餘文字逐字一致；EX 的失敗路徑驗收連向 `java-failure-coverage`（歷史 EX-09），EQ 的關係與集合驗收連向 `java-relationship-coverage`（歷史 EQ-10）。

BM-04 的 `java-mapping-integrity` 小節已逐字包含「不得略過欄位或產生不完整物件掩蓋失敗」。共通改動只刪除分號及該禁止子句：

```text
前：映射失敗依[錯誤處理](../coding/error-handling.md)及[資料驗證](../coding/validation.md)區分外部不合法資料與內部缺陷；不得略過欄位或產生不完整物件掩蓋失敗。
後：映射失敗依[錯誤處理](../coding/error-handling.md)及[資料驗證](../coding/validation.md)區分外部不合法資料與內部缺陷。
```

登錄於 `docs/body-restructuring/common/existing-sources.json` 的一／BM-04 決策，摘要後續各句未動；15 份 Java 文件及其 JSON 全未改。

## 工具收尾與未執行事項

R7-M4：演練使用固定分派前提交的完整 rules／docs 暫存快照與目前 scripts，自身連結與夾具一致；HEAD 的完成文件另由主檢查與負向測試驗證。R7-L12：演練起點提交使用 `--allow-empty`，乾淨 checkout 不會輸出 nothing to commit 污染 JSON。R7-L13：收尾指南要求先 checkout 工作者分支最新提交，再用協調者固定起點執行範圍檢查，不在整合分支或起點冒充工作者最終結果。

五條驗收入口 VO-10、ST-10、RF-07、RF-08、NT-14 全部已核准整條保留，不轉換。集合併檔、74 個共通歷史錨點改名、指路文字可讀性、驗收整合、CA-06／CO-08 驗收重疊與分工，全留下一階段。本輪不修改 Java 文件。

併發與集合皆已完成，原提升提交的獨立撤回驗證不再適用，工具明列 applicable=false；不能據此宣稱日後可單獨撤回，必須同步處理 Java 來源與引用。原始回報的「交協調者決定」保留為歷史，五條入口與保守處置現已依本輪決策確認。

## 一致性掃描（只列出，不修改）

DOC
scan=records.map do |r|
 s=File.read(r['path']);intro=s.split(/^## /,2).first;headings=s.scan(/^### (.+)$/).flatten
 [File.basename(r['path'],'.md'),r['rules'].group_by{|e|e['kind']}.map{|k,v|"#{k} #{v.size}"}.join('、'),r.fetch('group_routes',[]).size,r.fetch('link_retention',[]).size,s.include?('## 補充要求') ? '有' : '無',headings.size,intro.lines.count]
end
text+=rows.call(['文件','去向分布','空分組指路筆數','引言保留連結筆數','結尾小節','三級標題數','引言行數'],scan)
text+=<<'DOC'

- 錨點皆採 `java-` 加語意字串，細粒度命名仍不同：版本以 declarations／verification 等行為命名，型別以 type-relation／shape 等概念命名，映射混合 fields／integrity／ownership；不統一或新增別名。
- 同為「重述」有整條移除、拆分、整條保留三種結果，差異由上表與保守理由說明；第四節「否」大多保留增量而原文不動，樣板部分拆分。種類名稱不能單獨代表實際刪改幅度。
- 只有集合的空分組使用固定指路文字；其餘保留的分組仍含正文。引言保留連結用共通歷史錨點或英文檔名作標籤，可讀性與原有中文引用不一致，依決策留待後續。
- 驗收第一欄仍有差異：樣板移除入口使用「覆蓋要求（原驗收入口）」，其他五條入口保留 Java 錨點；整條移除者使用共通錨點。集合無獨立 Java 驗收表，沿用共同驗收清單。
- 14 份有尾段的文件採「補充要求」及 `java-closing-requirements`；equality-hashing-ordering 基準沒有分組尾段，因此沒有另立結尾小節。基準分組中間的尾段與程式碼示例亦集中移到結尾。version-policy 範例因此離第一組較遠，屬 R7-M5 尚未處理的可讀性議題。
- 工作者指出 CA-06／CO-08 僅加連結仍遭未申報刪除診斷，已還原原句並保守處置；本輪不修改工具的正文轉換規則。
- ST-10、NT-14 等「依下方表格」的適用案例有部分實際位於共同引用；歷史 L2 問題維持原文，未因入口已核准保留而默認定位完全準確。BM-04 的部分成功入口亦留待驗收整合。
- 以上掃描是寫法及已知定位問題清單，不替代獨立審閱對 153 條斷言承接的判定。

實際命令與完整輸出見[驗證紀錄](body-restructuring-verification-results.md)。本報告及驗證紀錄均可用各自產生器重生；驗證結果採連續兩次逐位元組比對。
DOC
File.write('docs/body-restructuring-stage-b.md',text)
puts "已產生 153 條總表、#{retained.size} 條保守處置、#{manual.size} 項人工複核分類與 14 組提交對照。"
