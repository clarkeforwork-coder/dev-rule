# frozen_string_literal: true
require_relative 'body-presentation'
Dir.chdir(File.expand_path('..',__dir__))
F=FinalAcceptance
out,status=Open3.capture2e('ruby','scripts/verify-final-acceptance.rb');abort(out) unless status.success?
plan=F.steps
text=<<~DOC
## 第二部分：驗收歸位、分工與指代修正

起點：`#{F::START}`；正文基準仍為 `350668eb14ede247af22c782323beebf940c2a5f`。上文是第一部分的歷史紀錄，本節補充第二部分的實際處理；未重新整理其他主題。

- `7afa278`：介面用途列歸位，原表改導向，逐筆轉換工具與測試先到位。
- `7c3d651`：多步驟與部分成功列歸位，所有原入口改連新位置。
- `5365c72`：四列保留原文字，追加分工及互連；更新驗收入口的現況描述。
- `f5019a4`：八筆指代／標題修正，另補一筆 Java 映射驗收。
- 其後紀錄提交：待決狀態、重疊盤點、總結及實際驗證輸出。

兩列先逐字搬移，只有列內相對連結調整。後續四列增補與映射增補另有白名單，不將搬移當成改寫權限。規範驗證原位置的兩張表均只含搬走的一列，故移除空表頭、留下導向；其他驗收列未移動。

### 搬移位置

| 錨點 | 原位置 | 現行位置 |
| --- | --- | --- |
| acceptance-interface-purpose | `rules/quality/rule-verification.md` 架構檢查與可測試性 | [框架與依賴組裝](../rules/architecture/dependency-composition.md#acceptance-interface-purpose) 補充契約驗收 |
| acceptance-partial-operation | `rules/quality/rule-verification.md` 錯誤處理驗證與驗收 | [錯誤處理](../rules/coding/error-handling.md#acceptance-partial-operation) 補充契約驗收 |

### 四列追加的分工文字

DOC
plan.find{|s|s['id']=='division'}['ops'].select{|o|o['before'].start_with?('|')}.each do |o|
 id=o['before'][/id="([^"]+)"/,1];b=o['before'].sub(/ \|\n$/,'');a=o['after'].sub(/ \|\n$/,'')
 text+="`#{id}`：\n\n```markdown\n#{a.delete_prefix(b)}\n```\n\n"
end
text+="\n### 指代修正逐筆前後文字\n\nST-10 與 NT-14 同時出現在第八次審閱 L12 與待決 L2，分別只修一次；下列八筆為指代與標題修正，最後一筆為另行核准的驗收增補。代號是歷史 Java 條文識別碼，不是現行條號。\n\n"
plan.find{|s|s['id']=='references'}['ops'].each_with_index do |o,i|
 text+="#### 修正 #{i+1}：`#{o['path']}`\n\n#{o['reason']}\n\n原文：\n\n```markdown\n#{o['before']}\n```\n\n現行：\n\n```markdown\n#{o['after']}\n```\n\n"
end
text+=<<~DOC
### 經核對不改的兩處

classes-and-construction 補充要求的前後文字相同：

```markdown
授權限制仍依[安全規範](../../../quality/security.md)。
```

安全文件的「授權與資料範圍」仍明訂伺服器授權、欄位權限與各入口檢查；連結沒有指回已移除的 Java 條文。正文條目移除不使整份安全規範入口失效。

states-and-results 補充要求的前後文字相同：

```markdown
不可變資料的保護方式另見[專屬值型別與領域值物件](value-objects.md)。
```

值物件的「不可變性」仍明訂 final 不等於內容不可變，以及不可變表示、封裝、防禦性複製；連結確實承接保護方式，未聲稱所有結果物件都是值物件。

### M4 第二列：只盤點、不修改的重疊句對

以下引文逐字取自現行檔案；只是要求與驗收的語意交集，不代表可直接刪除任一方。摘要可能另含適用邊界，故本輪沒有合併。

DOC
pairs=[
 ['領域建模：專屬型別的總體驗證','rules/coding/domain-modeling.md','專屬型別須驗證建立、邊界值、相等性、不可變性及適用的運算與還原行為，不能只測建立成功。',%w[acceptance-value-immutability acceptance-value-operations acceptance-value-restoration]],
 ['領域建模：狀態與副作用','rules/coding/domain-modeling.md','狀態與結果模型新增或變更時，須驗證受影響的合法轉換、拒絕、重複操作、必要資料與使用端分支，以及適用的外部代碼映射。同時確認結果與實際狀態、副作用一致，不僅測試型別建立成功，也不要求涵蓋所有無業務意義的排列組合。',%w[acceptance-model-coverage acceptance-model-extensibility]],
 ['領域建模：結果分類','rules/coding/domain-modeling.md','契約需要區分成功、重複操作、拒絕或尚未完成時，須明確建模，不得將已受理視為業務完成。',%w[acceptance-operation-results]],
 ['資料映射：欄位、禁止傳遞與失敗','rules/architecture/data-mapping.md','驗證應涵蓋必要欄位的正確映射、禁止欄位未被傳遞，以及轉換失敗的處理。',%w[acceptance-mapping-paths acceptance-mapping-fields]],
 ['資料映射：實際路徑','rules/architecture/data-mapping.md','使用工具或框架時須驗證實際映射路徑，不能只測試手寫替代版本，也不能僅確認轉換成功或物件型別正確。涉及反序列化或序列化設定時，須透過實際邊界路徑驗證。',%w[acceptance-mapping-paths]]
]
pairs.each do |label,path,quote,ids|
 raw=File.read(path);raise '盤點引文不符' unless raw.include?(quote)
 text+="#### #{label}\n\n摘要／正文（`#{path}`）：\n\n> #{quote}\n\n驗收承接：\n\n"
 ids.each{|id|row=raw.lines.find{|l|l.include?(%(<a id="#{id}">))};raise '缺盤點列' unless row;content=row.split(' | ')[1].sub(/ \|\s*$/,'').strip;text+="- `#{id}`：#{content}\n"}
 text+="\n"
end
text+=<<~DOC
### 集合文件與刻意不處理的事項

Java 集合仍保留所有權、不可變集合、遍歷與串流、失敗後狀態及資源有效期等多條正文，不是只剩失敗狀態提醒；原合併條件不成立，維持獨立文件。五條先前判為「驗收入口」但保守保留的條文不再轉換；本輪只精確修正其中三處指代。

規範驗證的其他主題驗收不全面搬移；上述 M4 句對不刪不改；歷次 H1 的例外治理尾句、H2 的介面與部分成功政策、L7 的保守重複均維持。Java 小節錨點名稱沒有改。沒有新增共通義務，只有核准的 BM-04「略過欄位」驗收補充；這句仍是 Java 要求，不因列管而自動適用其他語言。

### 可重跑檢查與實際輸出

```sh
ruby scripts/verify-final-acceptance.rb
ruby scripts/test-final-acceptance.rb
ruby scripts/verify-body-restructuring.rb
ruby scripts/record-body-verification.rb
```

錨點比對與全文比對實際輸出：

```json
#{out.strip}
```

15 個新案例包含四個逐步正向案例，以及新增檔案、重複／刪除錨點、弱化原列、分工錯文、漏略過欄位、未核准指代、其他正文、其他主題搬動與偽造清單的十一個負向案例。全部測試與命令原始輸出見[驗證紀錄](body-restructuring-verification-results.md)。

逐筆核准前後文字在 `scripts/final-acceptance-plan.json`，內容雜湊由工具固定；啟用步驟在 `docs/final-acceptance.json`。Java 去向紀錄的 `final_reference_changes` 與既有共通紀錄的 `final_acceptance_changes` 是追加登錄，原句的歷史證據沒有刪除。主檢查要求現行內容恰等於固定起點的核准轉換；保留／拆分的一般規則未放寬。舊驗收追溯先逆轉明列增補再比對，以免原片段的完整目的列檢查失去意義；現行增補另由精確全文及驗收錨點檢查約束。

人工仍須複核指代是否符合實際語意、分工是否清楚，以及歷史移除句與共通依據的涵蓋關係；工具只能證明錨點有效、列文保留與差異恰為核准清單，不能由連結存在推出語意充分。
DOC
p='docs/body-restructuring-stage-c.md';prefix=File.read(p).split(/^## 第二部分：/,2).first
File.write(p,prefix.rstrip+"\n\n"+text)
puts '階段 C 第二部分已更新，包含逐筆前後文、五組重疊盤點與實際比對輸出。'
