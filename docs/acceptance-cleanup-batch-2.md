# 驗收整理第二批

基準提交：`e8d32e7bd1b9e073f62f8092398daf7d1b57dce1`（第一批完成後的乾淨工作區）。僅本機提交，不推送。

## 範圍與完成標準

- 本批限 Java 併發／非同步、集合／所有權、例外／資源三份文件及其對應共同驗收。規則正文與適用範圍不變。
- 本批 Java 與共通驗收逐字重複須為零；忽略空白及 Markdown 標記比對，另由人工確認沒有換句話重述。
- 原驗收逐句／分句可重組為基準原文，每片段連至唯一現行主要驗收。共通來源不能附帶搬入未定義的語言義務。
- 保留先前批次成果，其餘十二份 Java 文件不修改；本地連結及錨點有效，格式檢查通過。
- 不新增可見性、非同步結果接收等跨語言義務；CA-03、CA-06 的原有 Java 檢查留在 Java。鎖定策略驗收只對應既有共通鎖定規則。
- 本批不處理正文純引用條目、歷史規則錨點或「驗收規則」章節重整；這些仍屬後續工作。

## 拆分與引用

| 原驗收 | 處理 |
| --- | --- |
| CA 1、6 | 工作擁有者與責任移交留共通；Future／CompletableFuture 結果路徑、故障分類留 Java。 |
| CA 3、10 | 資料交付、可見性與共享資料驗證留 Java；多鎖策略、鎖範圍、釋放及持鎖外部操作留共通。 |
| CA 2、8 及 4、5 | 均已有共同主要規則，合併案例保留單一共同來源，Java 直接引用。 |
| CO 1、2 及其他集合案例 | 所有權／快照等共同案例直接引用；批次失敗驗收歸回既有錯誤處理規則，不新增政策。 |
| EX 1、2、3 | 三條均屬 Java 例外機制，同一契約案例可共同驗證，不為拆表而重複同一案例。 |
| EX 7、8 | 部分取得、責任移交與關閉契約直接引用共同來源。Java 保留中斷、AutoCloseable、suppressed exceptions 等增量。 |

## 原驗收逐句追溯

以下是歷史證據，不是另一份有效驗收。執行時依連結的現行主要來源。

| 片段 ID | 基準原文 | 現行唯一主要來源 |
| --- | --- | --- |
| CA-1、6-1 | 核對工作擁有者、責任移交 | [主要驗收](../rules/coding/concurrency-and-async.md#acceptance-task-ownership) |
| CA-1、6-2 | 與結果接收路徑； | [主要驗收](../rules/stacks/java/common/concurrency-and-async.md#acceptance-java-task-results) |
| CA-1、6-3 | 觸發成功、失敗及取消，確認故障可追查，例外分類保留，未以替代值假裝成功。 | [主要驗收](../rules/stacks/java/common/concurrency-and-async.md#acceptance-java-task-results) |
| CA-2、8-1 | 核對實際執行配置、各階段執行位置及阻塞關係。 | [主要驗收](../rules/coding/concurrency-and-async.md#acceptance-execution-resources) |
| CA-2、8-2 | 依風險模擬容量耗盡、排隊與拒絕，確認不超出下游限制，也不因同一受限資源上的相互等待而無法前進。 | [主要驗收](../rules/coding/concurrency-and-async.md#acceptance-execution-resources) |
| CA-3、10-1 | 審查資料交付、同步範圍、鎖定與可見性保證，以受控交錯驗證不變條件及共享狀態。 | [主要驗收](../rules/stacks/java/common/concurrency-and-async.md#acceptance-java-visibility) |
| CA-3、10-2 | 核對多鎖策略、退出釋放及持鎖期間的外部操作，不以測試偶然成功代替設計依據。 | [主要驗收](../rules/coding/concurrency-and-async.md#acceptance-lock-scope) |
| CA-4、5-1 | 驗證期限承接整體預算，逾時與取消後工作依契約停止或受控繼續。 | [主要驗收](../rules/coding/concurrency-and-async.md#acceptance-deadline-cancellation) |
| CA-4、5-2 | 確認相關子工作收到所需訊號，未確認停止的工作仍有擁有者，執行名額依實際資源釋放回收。 | [主要驗收](../rules/coding/concurrency-and-async.md#acceptance-deadline-cancellation) |
| CA-7-1 | 以不同完成順序及子工作失敗驗證全部成功、部分成功或競速等適用契約。 | [主要驗收](../rules/coding/concurrency-and-async.md#acceptance-task-composition) |
| CA-7-2 | 核對每項結果與來源對應，剩餘工作持續受到管理，未將最快失敗當成第一個成功。 | [主要驗收](../rules/coding/concurrency-and-async.md#acceptance-task-composition) |
| CA-9-1 | 在共用執行資源上交錯執行不同租戶或身分的工作，驗證脈絡正確傳遞，成功、失敗與取消後均清理或還原，沒有跨工作污染。 | [主要驗收](../rules/coding/concurrency-and-async.md#acceptance-context-isolation) |
| CA-9-2 | 核對延後執行的授權仍依契約確認。 | [主要驗收](../rules/coding/concurrency-and-async.md#acceptance-context-isolation) |
| CA-11-1 | 在排隊及執行中仍有工作時啟動關閉，核對停止受理、等待期限、取消或接手安排與資源釋放順序。 | [主要驗收](../rules/coding/resource-lifecycle.md#acceptance-controlled-shutdown) |
| CA-11-2 | 期限後未完成或未知結果仍可追蹤，不被當成已結束。 | [主要驗收](../rules/coding/resource-lifecycle.md#acceptance-controlled-shutdown) |
| CA-12-1 | 確認案例使用明確的協調與完成條件，等待有期限且失敗保留診斷資訊，涵蓋受影響的交錯與故障路徑。 | [主要驗收](../rules/quality/testing.md#acceptance-controlled-interleaving) |
| CA-12-2 | 壓力測試結果須搭配同步及生命週期審查，不作為唯一安全證據。 | [主要驗收](../rules/quality/testing.md#acceptance-controlled-interleaving) |
| CO-1、2-1 | 修改傳入或回傳的集合與適用的可變元素，確認修改權及隔離符合契約。 | [主要驗收](../rules/coding/collections-and-ownership.md#acceptance-collection-ownership) |
| CO-1、2-2 | 改變來源後核對快照仍固定、檢視依約反映變更，不能只測試增刪操作是否遭拒。 | [主要驗收](../rules/coding/collections-and-ownership.md#acceptance-collection-ownership) |
| CO-3-1 | 以有順序意義、重複元素及重複鍵的資料驗證選用與轉換後的結果，確認拒絕、合併或取代符合契約，沒有默默丟失應保留項目。 | [主要驗收](../rules/coding/collections-and-ownership.md#acceptance-order-duplicates) |
| CO-4-1 | 驗證適用的遍歷新增、移除或其他修改路徑，核對實際處理項目與副作用。 | [主要驗收](../rules/coding/collections-and-ownership.md#acceptance-traversal-mutation) |
| CO-4-2 | 確認沒有以例外後重跑掩蓋問題，不僅以未拋例外判定安全。 | [主要驗收](../rules/coding/collections-and-ownership.md#acceptance-traversal-mutation) |
| CO-5-1 | 對共享複合操作，以受控交錯或併發案例驗證約定的原子性及業務條件； | [主要驗收](../rules/coding/concurrency-and-async.md#acceptance-compound-atomicity) |
| CO-5-2 | 跨鍵或跨集合的保證須驗證整個操作，不僅確認單一集合操作安全。 | [主要驗收](../rules/coding/concurrency-and-async.md#acceptance-compound-atomicity) |
| CO-6-1 | 使用代表性資料量核對載入範圍與處理界限，確認來源、中間操作及結果收集沒有無限制累積； | [主要驗收](../rules/quality/performance.md#acceptance-bounded-accumulation) |
| CO-6-2 | 依風險檢查排序、分組或去重的資源成本。 | [主要驗收](../rules/quality/performance.md#acceptance-bounded-accumulation) |
| CO-7-1 | 對依賴外部資源的延遲讀取，分別驗證完成、提前停止及失敗後正確釋放，並確認讀取期間資源有效、擁有者與關閉責任明確。 | [主要驗收](../rules/coding/resource-lifecycle.md#acceptance-lazy-resource-lifetime) |
| CO-8-1 | 在批次處理中途製造契約適用的失敗，核對集合實際狀態符合全部成功或部分成功的保證； | [主要驗收](../rules/coding/error-handling.md#acceptance-partial-operation) |
| CO-8-2 | 部分成功結果須可對應已完成與未完成的項目。 | [主要驗收](../rules/coding/error-handling.md#acceptance-partial-operation) |
| CO-9-1 | 核對測試涵蓋變更影響的所有權與行為保證，不以元素內容相同取代參考隔離、生命週期或失敗狀態的驗證，也不強制測試不適用的情境。 | [主要驗收](../rules/coding/collections-and-ownership.md#acceptance-collection-coverage) |
| EX-1、2、3-1 | 核對例外型別、宣告、轉換及捕捉範圍是否符合契約與處置責任。 | [主要驗收](../rules/stacks/java/common/exceptions-and-resources.md#acceptance-java-exception-contract) |
| EX-1、2、3-2 | 以適用的不同故障來源驗證分類，確認業務失敗、技術故障與程式缺陷未混淆，包裝後仍保留原始原因。 | [主要驗收](../rules/stacks/java/common/exceptions-and-resources.md#acceptance-java-exception-contract) |
| EX-4-1 | 對可中斷的操作送出中斷，確認依契約向上傳遞，或在無法傳遞時恢復旗標並停止或取消； | [主要驗收](../rules/stacks/java/common/exceptions-and-resources.md#acceptance-java-interruption) |
| EX-4-2 | 沒有吞掉後繼續等待、執行或重試，必要清理仍正確完成。 | [主要驗收](../rules/stacks/java/common/exceptions-and-resources.md#acceptance-java-interruption) |
| EX-5-1 | 分別驗證正常完成、提前退出與操作失敗時釋放自行擁有的資源，借用與框架管理資源未被擅自關閉。 | [主要驗收](../rules/stacks/java/common/exceptions-and-resources.md#acceptance-java-resource-closing) |
| EX-5-2 | 核對非區域生命週期的釋放責任，不依賴垃圾回收。 | [主要驗收](../rules/stacks/java/common/exceptions-and-resources.md#acceptance-java-resource-closing) |
| EX-6-1 | 模擬操作與清理同時失敗，確認原始故障及 suppressed exceptions 或相應故障關係可追查，未被 `finally` 的控制流程覆蓋。 | [主要驗收](../rules/stacks/java/common/exceptions-and-resources.md#acceptance-java-suppressed-failures) |
| EX-6-2 | 另驗證只有清理失敗時的完成判定與回報。 | [主要驗收](../rules/stacks/java/common/exceptions-and-resources.md#acceptance-java-suppressed-failures) |
| EX-7-1 | 在後續資源取得或初始化步驟製造失敗，確認先前已取得的資源依正確順序釋放。 | [主要驗收](../rules/coding/resource-lifecycle.md#acceptance-partial-acquisition) |
| EX-7-2 | 核對所有權移交前後的責任，避免洩漏或不當重複關閉。 | [主要驗收](../rules/coding/resource-lifecycle.md#acceptance-partial-acquisition) |
| EX-8-1 | 驗證實際使用期間資源持續有效，尤其是委派及非同步路徑； | [主要驗收](../rules/coding/resource-lifecycle.md#acceptance-close-contract) |
| EX-8-2 | 核對關閉後操作與重複關閉依契約處理，不假設可繼續使用或重複關閉必定安全。 | [主要驗收](../rules/coding/resource-lifecycle.md#acceptance-close-contract) |
| EX-9-1 | 核對案例覆蓋變更影響的故障、中斷與清理路徑。 | [主要驗收](../rules/stacks/java/common/exceptions-and-resources.md#acceptance-java-failure-coverage) |
| EX-9-2 | 依賴框架行為的保證須有實際生命週期驗證，不只測試替身或成功流程。 | [主要驗收](../rules/stacks/java/common/exceptions-and-resources.md#acceptance-java-failure-coverage) |

## 驗證方式

在儲存庫根目錄執行 `ruby scripts/verify-acceptance.rb --batch 2 --baseline e8d32e7 --target 6a16349` 與 `git diff --check`。本批腳本固定對照上述基準；先前批次的腳本是歷史批次檢查，不能在後續合法修改後要求其「其他檔案未變」條件繼續成立。本批另外核對先前三份 Java 文件與基準逐字相同。

## 驗證結果

- 23 列原驗收拆為 44 個原文片段，逐列重新串接與基準完全相同；各片段均有唯一主要驗收目的地。
- 本批三份 Java 文件與共通驗收的逐字重複為 0；全站剩餘重複由 35 列降為 18 列，其他主題尚未全部完成。
- Java 規則正文及共通既有規則正文未變，其餘十二份 Java 文件（包含第一批三份）逐字未變。
- 人工核對 CA 1、6 與 CA 3、10 的分工：共同所有權／鎖定規則不再附帶 Java 結果鏈或可見性驗收。集合與 EX 7、8 使用共同主要來源，不以換句話重述取代引用。
- EX 1、2、3 的合併案例仍留在同一 Java 層，驗證相同例外契約的型別、宣告與捕捉，不附帶提升共同義務。
- 所有 1,380 個本地連結及章節引用、`git diff --check` 通過。機械檢查只能證明結構、追溯與逐字差異；上述責任分工另經人工審查。

常駐檢查：`ruby scripts/verify-acceptance.rb`。批次差異以 `--target` 指定歷史受驗提交；省略時檢查工作區。歷史批次的範圍限制不套用到後續提交。

## 獨立審閱後的重現方式

上文保留當批執行紀錄；舊提交沒有逐句差異與已改寫清單，不能用修正後檢查器回報通過。現行追溯檢查：`ruby scripts/verify-acceptance.rb --batch 2`；基準自本文讀取。常駐檢查預設同時執行五批追溯與全檔保護；`--target` 的全部讀取及統計皆來自指定提交，不混入工作區。精確差異與改寫理由見 [檢查差異清單](acceptance-check-policy.json)、[已改寫片段清單](acceptance-rewritten-fragments.json)及[審閱修正紀錄](review-remediation.md)。
