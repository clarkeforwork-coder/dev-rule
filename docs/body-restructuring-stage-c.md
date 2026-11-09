# 正文整理階段 C：第一部分

起點：`3f68be483882d8dbfb6611bd58c40ec7446414af`。正文基準仍為 `350668eb14ede247af22c782323beebf940c2a5f`。本部分只處理連結與版面，不改正文義務、不搬驗收、不合併檔案。

## 提交與範圍

- `06569c2`：先新增版面轉換、別名比對、句子集合與正負向測試。
- `c8f7f5b`：74 個共通歷史錨點改用語意名稱，同位置保留舊別名；Java 連結與 JSON 同步。
- `f5d4f0a`：15 份文件重生分組與引言指路，三段中間尾段回原分組；version-policy 搬空的「補充要求」標題與錨點移除。
- `62f0342`：Java 索引僅列仍有 Java 正文的小節標題，不新增規則。
- 文件與驗證收尾提交接在以上提交之後，包含本紀錄、共用對照、指南、實際驗證輸出及封存測試的明確執行入口。

## 錨點與相容性

第五節全部 74 筆已執行，調整建議名稱的筆數為 **0**。新錨點後緊接舊錨點，兩者指向同一段正文。集中清冊見[相容別名](common-anchor-aliases.md)及 `docs/common-anchor-aliases.json`。rules 不再連到舊代號；15 份 JSON 的來源、承接及差異記錄以同一別名表正規化，沒有舊代號的連結目標。歷史原文仍可從基準還原，前階段共通改動紀錄與工作者原始回報保留歷史原文。

## 固定格式與實例

以下例子逐字取自現行 Java 去向紀錄；路徑相對於該 Java 文件。

分組指路：

```markdown
本組下列要求由共通規範承接：[繼承的可替代性](../../../coding/code-design.md#substitutability)、[必要資料與依賴齊備](../../../coding/resource-lifecycle.md#initialization-readiness)。
```

引言保留：

```markdown
本文件另依[資料驗證](../../../coding/validation.md)辦理。
```

分組尾段：

```markdown
<a id="java-group-notes-version-declarations"></a>

### 本組補充說明

例如，建置 JDK 與部署環境使用 Java 21，而產物承諾相容 Java 17 時，編譯須維持 Java 17 的語言、API 及位元碼限制，並有 Java 17 與實際部署環境的驗證依據。
```

分組指路只列該組整條移除的條文，依完整目標路徑排序去重；已拆分或保留的條文不列。引言只保留未在正文、指路或其他段落出現的基準共通目標。全站現有 19 個分組指路、1 個引言保留句；唯一引言保留句是 value-objects 的整份資料驗證入口，不能用分組內較窄的責任分工錨點取代。

## 回原分組的段落

- `rules/stacks/java/common/types-and-generics.md` →「明確宣告與型別關係」，錨點 `java-group-notes-explicit-types`：

```text
既有程式碼的漸進導入、工具產生碼與個別例外依[規範治理](../../../workflow/rule-governance.md)辦理。測試不得透過不安全轉型偽造有效物件，另見[測試程式碼要求](../../../quality/rule-verification.md#測試程式碼)。
```

- `rules/stacks/java/common/version-policy.md` →「版本宣告與相容性」，錨點 `java-group-notes-version-declarations`：

```text
例如，建置 JDK 與部署環境使用 Java 21，而產物承諾相容 Java 17 時，編譯須維持 Java 17 的語言、API 及位元碼限制，並有 Java 17 與實際部署環境的驗證依據。
```

- `rules/stacks/java/common/version-policy.md` →「依賴、升級與特殊功能」，錨點 `java-group-notes-dependency-versions`：

```text
Preview 的採用紀錄及其他例外均依[規範治理](../../../workflow/rule-governance.md#例外核准)管理。既有程式碼依相同文件的漸進導入要求處理。
```

已掃描全部 15 份基準：只有以上三段屬非最後分組尾段。types-and-generics 與 lambda-and-stream 的程式碼示例原本位於最後分組之後，保持在補充要求；沒有將它們誤搬到前組。

## 句子集合比對實際輸出

```json
{
  "start": "3f68be483882d8dbfb6611bd58c40ec7446414af",
  "files": 54,
  "nonblank_units": 1999,
  "sentence_multisets_equal": true,
  "method": "正規化連結別名，排除空白、錨點行、固定指路句與固定補充標題；保留重複數及程式碼行",
  "excluded": "rules/stacks/java/README.md"
}
```

比對保留每一非空單位及其出現次數，包含程式碼；正規化連結目標、排除錨點與固定指路／補充標題。它單獨不能判斷正文所屬小節，因此主檢查另逐檔比對工具計算的完整期待文件，防止任意搬段、改標題或夾帶內容。Java 索引只有摘要例外，主檢查也逐列計算期待標題清單，其他文字不開例外。

## 工具與測試

- 新 `body-presentation.rb`：74 筆清冊及相鄰別名、分組與引言期待整句（診斷含期待值）、中間尾段與錨點、全部連結、第五節與歷史 ID 清冊、現行驗收追溯、句子集合、Java JSON 與完整 rules 內容皆核對。
- 新 `verify-body-sentences.rb` 可獨立重跑以上比對；`apply-body-presentation.rb` 按 aliases／layout／index 執行，只產生既定轉換，已啟用時先檢查現況。
- 新 `test-body-presentation.rb` 20 案：一個完整正向案例涵蓋全部 15 份、非空與空分組、引言與三段尾段；19 個負向案例涵蓋起點、含隱藏檔的 Java／共通紀錄清冊、別名清冊、舊別名、正文、舊連結、缺指路、代碼標籤、夾帶義務、錯誤去向、尾段文字與標題、驗收、第五節清冊與名稱、前階段追溯及重複句。
- 原正文／政策測試使用階段 B 起點暫存資料，演練使用原固定分派資料；沒有讓舊格式測試放寬成接受任意新格式。現行階段 C 有獨立直接檢查。
- 原封存 `test-verify-acceptance.rb` 在階段 C 直接執行時，明確建立封存基準暫存 checkout 執行舊測試，輸出 archived_at 與範圍；不再把「已封存」當成不明失敗，也不將封存測試當現行測試。
- 語意承接保證仍由固定階段 B 快照的完整檢查承接。現行版先證明是該快照的核准精確轉換，並直接重跑現行驗收追溯。輸出分開 `legacy_snapshot_local_links` 與 `current_local_links`，明列 presentation 狀態。

完整實際輸出見[驗證紀錄](body-restructuring-verification-results.md)。本紀錄可用 `ruby scripts/record-body-stage-c.rb` 重生，驗證紀錄使用 `ruby scripts/record-body-verification.rb`。

## 未處理事項

Java 小節錨點未改，包含先前指出的 `java-specific-responsibility`、`java-mapping-integrity` 及驗收類英文字差異。驗收整合、殘留整理敘述、原有「下方表格」定位、CA-06／CO-08 驗收重疊、集合是否併入他檔均未處理，留最後階段第二部分。此部分沒有新增或刪除規範義務。

## 第二部分：驗收歸位、分工與指代修正

起點：`53c26dcbecbdd31c6082ffd91f608660a2d38b0d`；正文基準仍為 `350668eb14ede247af22c782323beebf940c2a5f`。上文是第一部分的歷史紀錄，本節補充第二部分的實際處理；未重新整理其他主題。

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

`acceptance-task-ownership`：

```markdown
本列核對工作擁有者與責任移交；結果分類與接收路徑見[結果接收驗收](#acceptance-result-reception)。
```

`acceptance-result-reception`：

```markdown
本列核對結果分類與接收路徑；工作擁有者與責任移交見[工作追蹤驗收](#acceptance-task-ownership)。
```

`acceptance-failure-state`：

```markdown
本列核對例外後的實際狀態；全部或部分成功及項目對應見[多步驟與部分成功驗收](#acceptance-partial-operation)。
```

`acceptance-partial-operation`：

```markdown
本列核對全部或部分成功及項目對應；例外後的實際狀態見[失敗後狀態驗收](#acceptance-failure-state)。
```


### 指代修正逐筆前後文字

ST-10 與 NT-14 同時出現在第八次審閱 L12 與待決 L2，分別只修一次；下列八筆為指代與標題修正，最後一筆為另行核准的驗收增補。代號是歷史 Java 條文識別碼，不是現行條號。

#### 修正 1：`rules/stacks/java/common/states-and-results.md`

L12／七 L2 ST-10：共同與 Java 驗收並列，使用端分支及封閉模型精確指向共通。

原文：

```markdown
Java 狀態型別、使用端分支、`enum` 外部代碼及封閉模型依下方表格驗收，並核對實際副作用。
```

現行：

```markdown
Java 狀態型別、使用端分支、`enum` 外部代碼及封閉模型依[本文件驗收要求](#驗收要求)與[處理完整性、封閉或允許擴充驗收](../../../coding/domain-modeling.md#acceptance-model-extensibility)驗收，並核對實際副作用。
```

#### 修正 2：`rules/stacks/java/common/numbers-dates-text.md`

L12／七 L2 NT-14：整節含共同引用與 Java 實際路徑，不限只有兩列的表格。

原文：

```markdown
Java `BigDecimal`、`java.time`、`Clock` 及字串轉換的實際路徑依下方表格驗收。
```

現行：

```markdown
Java `BigDecimal`、`java.time`、`Clock` 及字串轉換的實際路徑依[本文件驗收要求](#驗收要求)驗收。
```

#### 修正 3：`rules/stacks/java/common/collections-and-ownership.md`

L12：明確指向現存 Java 條文，共通要求仍由原引用承接。

原文：

```markdown
各條 Java 使用限制仍適用。
```

現行：

```markdown
本文件的 Java 使用限制仍適用。
```

#### 修正 4：`rules/stacks/java/common/value-objects.md`

七／L2 VO-10：保留全部受驗對象，指向覆蓋列與詳細還原列。

原文：

```markdown
Java 的 `equals()`、`hashCode()`、`record` 自動產生方法與還原路徑依下方驗收表驗證，不機械式測試每個產生的方法。
```

現行：

```markdown
Java 的 `equals()`、`hashCode()`、`record` 自動產生方法與還原路徑依[Java 業務保證驗收](#acceptance-java-value-method-coverage)與[共通資料還原驗收](../../../coding/domain-modeling.md#acceptance-value-restoration)驗證，不機械式測試每個產生的方法。
```

#### 修正 5：`rules/stacks/java/common/boundary-mapping.md`

七／L2 BM-04：拒絕與缺陷留 Java，部分成功連到共通主要列。

原文：

```markdown
依下方 Java 實際映射路徑驗收拒絕、缺陷與部分成功，不以建立了目標型別就視為有效。
```

現行：

```markdown
依[Java 實際映射路徑驗收](#acceptance-java-mapping-failure)與[多步驟及部分成功驗收](../../../coding/error-handling.md#acceptance-partial-operation)驗收拒絕、缺陷與部分成功，不以建立了目標型別就視為有效。
```

#### 修正 6：`rules/stacks/java/common/collections-and-ownership.md`

七／L6：主題已存在，將後續展開改為現行入口。

原文：

```markdown
具體併發 API 與資源管理方式由後續 Java 主題展開。
```

現行：

```markdown
具體併發 API 與資源管理方式分別見[併發與非同步處理](concurrency-and-async.md)與[例外與資源管理](exceptions-and-resources.md)。
```

#### 修正 7：`rules/architecture/data-mapping.md`

七／L6：移除整理階段用語，摘要正文逐字保留。

原文：

```markdown
## 既有共同保證的落實
```

現行：

```markdown
## 相關共通契約
```

#### 修正 8：`rules/quality/rule-verification.md`

七／L6：下列並非型別要求，改連實際型別安全來源。

原文：

```markdown
測試程式碼同樣遵守下列型別安全要求。
```

現行：

```markdown
測試程式碼同樣遵守[型別安全要求](../coding/type-safety.md)。
```

#### 修正 9：`rules/stacks/java/common/boundary-mapping.md`

L13 第二點：唯一新增核對取自 BM-04 正文「不得略過欄位或產生不完整物件掩蓋失敗」。

原文：

```markdown
確認沒有以預設值或半成品掩蓋問題。
```

現行：

```markdown
確認沒有以預設值或半成品掩蓋問題，且未略過欄位或產生不完整物件掩蓋失敗。
```

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

#### 領域建模：專屬型別的總體驗證

摘要／正文（`rules/coding/domain-modeling.md`）：

> 專屬型別須驗證建立、邊界值、相等性、不可變性及適用的運算與還原行為，不能只測建立成功。

驗收承接：

- `acceptance-value-immutability`：對含可變資料的型別，修改傳入或取出的資料，確認原值物件未受影響。檢查封裝與必要的複製，不能只檢查外層欄位是否為唯讀。
- `acceptance-value-operations`：驗證適用運算的結果、單位與有效性限制，原物件維持不變。確認不相容的值依契約拒絕或處理，使用端未各自拆值繞過規則。
- `acceptance-value-restoration`：經實際採用的反序列化、持久化或框架映射路徑驗證合法與不合法資料。涉及歷史資料時，確認按明訂版本或遷移規則還原，不產出違反契約的物件。

#### 領域建模：狀態與副作用

摘要／正文（`rules/coding/domain-modeling.md`）：

> 狀態與結果模型新增或變更時，須驗證受影響的合法轉換、拒絕、重複操作、必要資料與使用端分支，以及適用的外部代碼映射。同時確認結果與實際狀態、副作用一致，不僅測試型別建立成功，也不要求涵蓋所有無業務意義的排列組合。

驗收承接：

- `acceptance-model-coverage`：核對測試涵蓋變更影響的轉換、拒絕、重複操作、資料及分支；以實際狀態與必要副作用驗證結果，而不只檢查回傳型別或成功標記。
- `acceptance-model-extensibility`：核對模型的封閉或擴充契約與實作限制，審查受影響的使用端分支。模型新增情況時確認適用檢查能發現未處理處，工具未涵蓋者由測試與審查補足；未知或擴充結果不得落入假成功。

#### 領域建模：結果分類

摘要／正文（`rules/coding/domain-modeling.md`）：

> 契約需要區分成功、重複操作、拒絕或尚未完成時，須明確建模，不得將已受理視為業務完成。

驗收承接：

- `acceptance-operation-results`：驗證成功、重複操作、拒絕及未完成等適用結果。核對必要原因與資料可由型別判斷，業務完成與已受理有所區別，技術故障未被轉成一般拒絕。

#### 資料映射：欄位、禁止傳遞與失敗

摘要／正文（`rules/architecture/data-mapping.md`）：

> 驗證應涵蓋必要欄位的正確映射、禁止欄位未被傳遞，以及轉換失敗的處理。

驗收承接：

- `acceptance-mapping-paths`：確認測試執行實際採用的映射實作或工具產出，必要時涵蓋序列化與反序列化邊界；斷言須涵蓋欄位值、拒絕結果與禁止傳遞的資料，不僅確認物件非空。對需要區分更新意圖的契約，從實際接收入口分別提供省略、明確清空及設定值，確認意圖傳遞到業務操作並產生約定效果。
- `acceptance-mapping-fields`：核對允許欄位及來源，以含管理欄位的外部輸入驗證其無法覆寫可信資料，並確認內部敏感欄位未輸出。映射設定或契約變更時，確認新增來源或目標欄位不會自動擴大允許範圍。

#### 資料映射：實際路徑

摘要／正文（`rules/architecture/data-mapping.md`）：

> 使用工具或框架時須驗證實際映射路徑，不能只測試手寫替代版本，也不能僅確認轉換成功或物件型別正確。涉及反序列化或序列化設定時，須透過實際邊界路徑驗證。

驗收承接：

- `acceptance-mapping-paths`：確認測試執行實際採用的映射實作或工具產出，必要時涵蓋序列化與反序列化邊界；斷言須涵蓋欄位值、拒絕結果與禁止傳遞的資料，不僅確認物件非空。對需要區分更新意圖的契約，從實際接收入口分別提供省略、明確清空及設定值，確認意圖傳遞到業務操作並產生約定效果。

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
{
  "start": "53c26dcbecbdd31c6082ffd91f608660a2d38b0d",
  "acceptance_anchors": 126,
  "unique": true,
  "unchanged_after_link_normalization": 121,
  "registered_additions": [
    "acceptance-task-ownership",
    "acceptance-result-reception",
    "acceptance-failure-state",
    "acceptance-partial-operation",
    "acceptance-java-mapping-failure"
  ],
  "moved": [
    {
      "anchor": "acceptance-interface-purpose",
      "from": "rules/quality/rule-verification.md",
      "to": "rules/architecture/dependency-composition.md"
    },
    {
      "anchor": "acceptance-partial-operation",
      "from": "rules/quality/rule-verification.md",
      "to": "rules/coding/error-handling.md"
    }
  ],
  "all_other_rules_exact": true
}
```

15 個新案例包含四個逐步正向案例，以及新增檔案、重複／刪除錨點、弱化原列、分工錯文、漏略過欄位、未核准指代、其他正文、其他主題搬動與偽造清單的十一個負向案例。全部測試與命令原始輸出見[驗證紀錄](body-restructuring-verification-results.md)。

逐筆核准前後文字在 `scripts/final-acceptance-plan.json`，內容雜湊由工具固定；啟用步驟在 `docs/final-acceptance.json`。Java 去向紀錄的 `final_reference_changes` 與既有共通紀錄的 `final_acceptance_changes` 是追加登錄，原句的歷史證據沒有刪除。主檢查要求現行內容恰等於固定起點的核准轉換；保留／拆分的一般規則未放寬。舊驗收追溯先逆轉明列增補再比對，以免原片段的完整目的列檢查失去意義；現行增補另由精確全文及驗收錨點檢查約束。

人工仍須複核指代是否符合實際語意、分工是否清楚，以及歷史移除句與共通依據的涵蓋關係；工具只能證明錨點有效、列文保留與差異恰為核准清單，不能由連結存在推出語意充分。
