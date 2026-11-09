# 第五次審閱修正回報

起點 `3597a64`；固定正文基準仍為 `350668eb14ede247af22c782323beebf940c2a5f`。本輪沒有展開其他 14 份 Java 文件，沒有更改 CA-06／CO-08 提交新增的條文或驗收列，也沒有合併檔案、改歷史錨點、搬移驗收、推送或修改 main。

## 提交範圍

| 提交 | 範圍 |
| --- | --- |
| `71cec1f` | M1／M2／M3、L4／L5／L6 規範還原、來源補登，並套用驗收第一欄規則。 |
| `6e9ca9c` | 結構化被刪子句、歷史 ID／種類一致性、驗收全文、現行增文、移入句、共通檔名、工作者範圍、清冊與空驗收保護及診斷測試。 |
| `890bc90` | 重寫平行作業說明：分類例外、只准兩檔、條號、移入句、步驟、Ruby 版本與協調者收尾。 |
| 本回報所在提交 | 共通隱藏／非 JSON 檔名檢查、說明範例格式修正、維持部分成功引用的最小 BM-04 還原、L8～L11 紀錄、實際撤回及可重現驗證產生器。 |

## 二十項處理結果

| 問題 | 狀態與處理 |
| --- | --- |
| M1 | 已修。共通映射摘要恢復「不得略過欄位或產生不完整物件掩蓋失敗」及原失敗分類引言；部分成功仍引用主要來源，其他收斂保留。已更正「Java 完整承接」的錯誤判斷；選 B 不變，刪除延至 Java 逐字移入且全部合併後。 |
| M2 | 已修。JN-03 還原「不得掩蓋缺值」，沒有以故障後降級條文替代正常缺值限制。 |
| M3 | 已修。JN 引言恢復整份資料驗證／領域建模連結，JN-06 去向補 code-design#cl-06 與 domain-modeling#狀態建模；逐項列原文，範圍原則寫進說明。 |
| M4 | 已修機械與格式部分。每句填自己的理由及目的地完整一句；removed_assertions 驗證原子句、現行已刪、承接原文在指定共通小節。N17／N04 現在拒絕。語意是否相關仍須人工，輸出實際句子清單而非固定口號。 |
| M5 | 已修六項及模糊處。說明明訂待確認兩條、已提升 CA／CO 的混合拆分、imports、非表格條號、移除後第一欄及只准兩檔；另給分類對照、句子格式、尾段、程式碼／清單切分、步驟、回報方式與 Ruby 2.6 要求。 |
| M6 | 已修。工作者不得改共用遷移／待決／驗證檔，工具按主題與起點檢查提交、暫存、工作區及未追蹤路徑；暫存儲存庫兩檔通過、多改遷移文件拒絕。合併後由協調者統一更新。 |
| M7 | 已修。驗收非表格全文保護、history_id 與 kind／action 交叉核對、整條保留全文、新增句登錄、共通檔名允許清單及實際人工句單；已完成不得留「尚未整理」。九項指定 N 案例均有診斷測試。 |
| L1 | 已修。每個負向案例同時比結束碼與預期診斷；補連結、錨點、種類、空去向、驗收理由／重複、共通基準／範圍、三項 merged 檢查等，不能因另一個例外而算通過。 |
| L2 | 已修。承接待決第三／四節 153 ID、第六節 19 ID 清冊與空驗收列檢查，均有測試。 |
| L3 | 已修。刪除驗收子工具未使用的 visible_markdown、acceptance_mask、table_mask、位置白名單、插入判斷及 options。 |
| L4 | 已修。JN-01 錯誤處理、JN 引言、映射摘要的錯誤處理／資料驗證／空值語意／邊界／集合恢復整份連結；精確錨點只能額外補，不縮小既有整份引用。 |
| L5 | 已修。JN-02 逐句證據補「捕捉與處置責任」的不得無依據回傳空值與預設值原文。 |
| L6 | 已修。領域摘要補連 st-10 模型驗收，差異已登錄；VO-10 首句逐字不變。 |
| L7 | 已修。表頭統一「對應要求」；整條移除填共通規則連結，轉驗收入口填純文字「覆蓋要求（原驗收入口）」，不連回本節；樣板已套用。 |
| L8 | 依指示記錄，不改規則。共通決策文件說明 CA-06 接收／ca-01 擁有者，以及 CO-08 例外後狀態／既有部分操作的重疊與分工；整合留全部合併後。 |
| L9 | 已修。共通決策列出撤回後須同步的三份紀錄、作業說明、驗收新增白名單及未來 Java／JSON 來源；兩提交在暫存複本各自實際 revert 並通過檢查。 |
| L10 | 已加註。待決第七節 L2 列保留歷史文字，補明現行為驗收章節而非正文第 10 條。 |
| L11 | 已修。提交 record-body-verification.rb，擷取常駐、診斷負測、實際撤回、歷史基準及三種 diff 檢查，重生實際結果。 |
| L12 | 已修。未整理／行尾測試動態建立基準未變夾具；未綁定 value-objects 或任何仍 pending 的主題。 |
| L13 | 已修。驗收辨識支援固定新表頭「對應要求」，主檢查只准原表頭或該固定改名；任意改名有負向案例，不會靜默略過。 |

## 新欄位與額外規則

- `sentences[].history_id`：來源條號，未編號內容為 null；與基準所有權核對。
- `sentences[].removed_assertions[]`：text 為被刪子句；source_uri 與 source_text 為共通錨點及承接原文。移除句的 targets 集合必須一致。
- `imports[]`：source_path、source_text、target_uri、history_id、reason，核對固定共通基準與 Java 目的小節。此階段沒有在正式樣板移入句子；合法及不合法情境只在暫存複本測試。
- `acceptance_text_changes[]`：before、after、references（before 條號／after 錨點連結）、reason；只能替換條號，其餘逐字不動。
- `acceptance_additions[]`：只能使用協調者在工具明列的三項既有／核准增文，不能自填任意新義務。

本輪統一的分類慣例：第三節直接按判斷映射；第四節「否」有 removed_assertions 者列拆分，沒有刪斷言只補引用者列保留增量。樣板 JN-02／03 因此改列拆分；要求本身不變。CA-06／CO-08 是核准提升後的例外，不再依舊「是」整條保留。未具直接涵蓋的句子仍留 Java，reason 記疑義並回報協調者。

## 檢查與測試對照

| 檢查 | 代表案例 |
| --- | --- |
| 驗收全文、治理句與共同連結 | N02c、N02d、N02f；任意增文及非條號變更 |
| 整條保留／移除、ID 小節及完成狀態 | N08c、N13、N14、N12b、N16；所屬 ID 錯誤 |
| 子句承接、完整目的句 | N04、N17；原句不存在、現行仍在、共通原文不存在、缺承接證據 |
| 共通登錄與來源 | N06b；隱藏與非 JSON 檔、共通基準、Java 路徑、理由、決策及刪文不符 |
| 移入格式 | 合法暫存移入、非共通來源、基準不存在、未寫入、ID 不符、理由不足 |
| 清冊／驗收追溯 | 153／19 清冊各少列、空驗收、追溯缺片段、第二欄改動、表頭任意改名 |
| 一般保護 | 未整理／行尾動態夾具、隱藏規則檔、失效連結／錨點、重複錨點、空去向、種類／狀態／理由錯誤、merged 三項 |
| 工作者範圍 | 暫存儲存庫只改兩檔通過，多改 docs/java-rule-migration.md 失敗 |
| 獨立撤回 | 暫存複本各自 git revert b1d2f33、5a16124，之後執行常駐檢查 |

完整實際指令、每個案例的期望與實際診斷、常駐人工句單見[驗證紀錄](body-restructuring-verification-results.md)。沒有推定未執行的測試已通過。

## 人工限制與未執行事項

即使被刪子句、承接原文和錨點都逐字存在，機器仍無法證明它們語意相關；若同時把來源與原文偽造為無關但存在的內容，仍須人工判斷。常駐輸出列出本次各個改寫／移除原句、目的句、子句證據與理由，供逐項複核。沒有把最低字數或 exit 0 當成不降低要求的證明。

VO-10 首句依使用者決定維持現狀；其餘 14 份 Java 文件與基準逐字相同。BM-04 真正移入 Java、集合合併、74 個錨點改名、M4 驗收整合與 L8 重疊整理均按指示留後續，未擅自執行。沒有不同意或另外略過的審閱項目。

## 規則前後文字（相對 3597a64）

```diff
diff --git a/rules/architecture/data-mapping.md b/rules/architecture/data-mapping.md
index fe74058..c0482f3 100644
--- a/rules/architecture/data-mapping.md
+++ b/rules/architecture/data-mapping.md
@@ -52,4 +52,4 @@

 ## 既有共同保證的落實

-映射失敗與部分成功依[錯誤分類](../coding/error-handling.md#失敗分類與表達)、[程式缺陷](../coding/error-handling.md#程式缺陷與不變條件)、[多步驟與部分成功](../coding/error-handling.md#多步驟與部分成功)及[資料驗證](../coding/validation.md#責任分工)。更新意圖依[空值語意](../coding/nullability.md#空值語意)。隔離與共用值依[邊界隔離](boundary-objects.md#不可變性)、[共用值契約](boundary-objects.md#隔離與拆分)、[值物件不可變性](../coding/domain-modeling.md#vo-03)及[集合所有權](../coding/collections-and-ownership.md#co-01)，沿用[邊界隔離驗收](boundary-objects.md#acceptance-boundary-isolation)。轉換形式及共用依[責任配置](#責任配置)、[介面用途](dependency-composition.md#介面與抽象)及[共用能力](shared-capabilities.md)。
+映射失敗依[錯誤處理](../coding/error-handling.md)及[資料驗證](../coding/validation.md)區分外部不合法資料與內部缺陷；不得略過欄位或產生不完整物件掩蓋失敗。部分成功依[多步驟與部分成功](../coding/error-handling.md#多步驟與部分成功)。更新意圖依[空值語意](../coding/nullability.md)。隔離與共用值依[邊界隔離](boundary-objects.md)、[共用值契約](boundary-objects.md#隔離與拆分)、[值物件不可變性](../coding/domain-modeling.md#vo-03)及[集合所有權](../coding/collections-and-ownership.md)，沿用[邊界隔離驗收](boundary-objects.md#acceptance-boundary-isolation)。轉換形式及共用依[責任配置](#責任配置)、[介面用途](dependency-composition.md#介面與抽象)及[共用能力](shared-capabilities.md)。
diff --git a/rules/coding/domain-modeling.md b/rules/coding/domain-modeling.md
index 0d4ac24..575fd51 100644
--- a/rules/coding/domain-modeling.md
+++ b/rules/coding/domain-modeling.md
@@ -107,4 +107,4 @@ Entity 若以識別碼定義相等性，須明訂識別碼產生前後的比較

 ## 模型驗證與還原

-專屬型別須驗證建立、邊界值、相等性、不可變性及適用的運算與還原行為，不能只測建立成功。狀態轉換與外部存在性、授權分別依[狀態建模](#狀態建模)、[專屬型別](#專屬型別)及[資料驗證](validation.md#責任分工)。數值、時間及文字處理細節依[共同資料語意](numbers-dates-text.md)。
+專屬型別須驗證建立、邊界值、相等性、不可變性及適用的運算與還原行為，不能只測建立成功。狀態轉換與外部存在性、授權分別依[狀態建模](#狀態建模)及[模型驗收](#st-10)、[專屬型別](#專屬型別)及[資料驗證](validation.md#責任分工)。數值、時間及文字處理細節依[共同資料語意](numbers-dates-text.md)。
diff --git a/rules/stacks/java/common/null-and-optional.md b/rules/stacks/java/common/null-and-optional.md
index 056e3cf..51b919d 100644
--- a/rules/stacks/java/common/null-and-optional.md
+++ b/rules/stacks/java/common/null-and-optional.md
@@ -2,7 +2,7 @@

 本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

-本文件承接[空值語意](../../../coding/nullability.md)、[型別安全](../../../coding/type-safety.md)、[錯誤處理](../../../coding/error-handling.md)、[資料驗證](../../../coding/validation.md#責任分工)與[領域建模](../../../coding/domain-modeling.md#專屬型別)，適用於自行撰寫的 Java 程式碼，包含測試與整合元件。語法與 API 須符合[版本要求](version-policy.md)，型別使用另依[型別宣告與泛型](types-and-generics.md)。
+本文件承接[空值語意](../../../coding/nullability.md)、[型別安全](../../../coding/type-safety.md)、[錯誤處理](../../../coding/error-handling.md)、[資料驗證](../../../coding/validation.md)與[領域建模](../../../coding/domain-modeling.md)，適用於自行撰寫的 Java 程式碼，包含測試與整合元件。語法與 API 須符合[版本要求](version-policy.md)，型別使用另依[型別宣告與泛型](types-and-generics.md)。

 ## 查詢與 Optional

@@ -10,7 +10,7 @@

 ### 查詢的正常缺值

-單筆查詢允許正常不存在時，使用 `Optional<T>`；多筆查詢無結果時使用空集合，不回傳 `null`。依業務要求必須存在卻不存在時，表達明確的業務失敗；查詢技術故障依[失敗分類與表達](../../../coding/error-handling.md#失敗分類與表達)傳遞，不得混為正常缺值。
+單筆查詢允許正常不存在時，使用 `Optional<T>`；多筆查詢無結果時使用空集合，不回傳 `null`。依業務要求必須存在卻不存在時，表達明確的業務失敗；查詢技術故障依[錯誤處理](../../../coding/error-handling.md)傳遞，不得混為正常缺值。

 <a id="java-optional-nonnull"></a>

@@ -22,7 +22,7 @@

 ### 取值與缺值處置

-使用 `Optional` 的值前，須明確處理缺值情境，不得僅憑預期直接取值。替代值、缺值分支與失敗處理須符合業務語意；替代結果與錯誤分類依[降級與替代結果](../../../coding/error-handling.md#降級與替代結果)及[失敗分類](../../../coding/error-handling.md#失敗分類與表達)。選用取值或拋出例外的方法本身不代表符合規範；若依已成立的不變條件必定有值，違反時須按[程式缺陷](../../../coding/error-handling.md#程式缺陷與不變條件)處理。
+使用 `Optional` 的值前，須明確處理缺值情境，不得僅憑預期直接取值。替代值、缺值分支與失敗處理須符合業務語意，不得掩蓋缺值；替代結果與錯誤分類依[降級與替代結果](../../../coding/error-handling.md#降級與替代結果)及[失敗分類](../../../coding/error-handling.md#失敗分類與表達)。選用取值或拋出例外的方法本身不代表符合規範；若依已成立的不變條件必定有值，違反時須按[程式缺陷](../../../coding/error-handling.md#程式缺陷與不變條件)處理。

 <a id="java-optional-positions"></a>

@@ -87,12 +87,12 @@ Java 的 `Optional` 與內部 `null` 在 API 邊界轉換，依[API 邊界的缺

 ### Java 語言增量驗收

-| Java 條文 | 語言增量驗收 |
+| 對應要求 | 語言增量驗收 |
 | --- | --- |
 | <a id="acceptance-java-optional-results"></a>[查詢](#java-query-absence)、[Optional 非空](#java-optional-nonnull)、[取值](#java-optional-access) | 驗證有值、單筆正常查無資料、多筆空結果，以及適用的必須存在卻不存在、查詢故障與結果未知。確認 `Optional` 本身非空，呼叫端的缺值分支、替代值與失敗分類符合契約。 |
 | <a id="acceptance-java-optional-positions"></a>[使用位置](#java-optional-positions)、[集合空值](#java-container-nulls) | 審查參數與欄位採用 `Optional` 的必要性及配套。需要多狀態時分別驗證未提供、清空與設定值；集合等輸入含不允許的空值時，確認依契約處理，沒有默默丟棄或替換資料。 |
 | <a id="acceptance-java-null-contract"></a>[驗證責任](../../../coding/validation.md#責任分工)、[工具契約](#java-null-contract-tools)、[非空預設](#java-nonnull-default) | 核對非空預設、可空標註、檢查範圍及實際驗證位置。確認適用工具能偵測違反契約的使用方式；必填外部輸入缺值時依契約拒絕，且未產生不應發生的副作用。 |
 | <a id="acceptance-java-optional-adaptation"></a>[第三方轉換](#java-third-party-optional) | 檢查第三方回傳值轉成 `Optional` 的路徑，只有契約允許的正常缺值才能使用空的 `Optional`。 |
-| <a id="acceptance-java-optional-coverage"></a>[驗收要求](#驗收要求) | 核對案例覆蓋受影響的有值與缺值分類，測試資料及替身遵守型別契約，未為製造案例而關閉檢查或使用不安全轉型。Optional、非空標註與實際 API 路徑均納入適用案例。 |
+| <a id="acceptance-java-optional-coverage"></a>覆蓋要求（原驗收入口） | 核對案例覆蓋受影響的有值與缺值分類，測試資料及替身遵守型別契約，未為製造案例而關閉檢查或使用不安全轉型。Optional、非空標註與實際 API 路徑均納入適用案例。 |

 既有程式碼、工具限制與個別例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行放寬要求。
```
