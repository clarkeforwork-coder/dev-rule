# 正文整理階段 B：14 位工作者的原始回報

以下是各工作者完成時送回協調者的訊息原文，依送達順序排列；除移除一處與內容無關的外部網址外未經編修。承接是否充分仍以各份去向紀錄與獨立審閱為準。

## [worker_done] 分派前準備完成：7b2667c

- from: term_123655af-6a0f-4a35-88b0-8a67a05eac06
- at: 2026-11-09T07:37:51Z
- payload: {"taskId":"task_0773ae4c4278","dispatchId":"ctx_470117d939d4","outcome":"succeeded","filesModified":["docs/body-restructuring-guide.md","docs/body-restructuring-review-7.md","docs/body-restructuring-stage-a.md","docs/body-restructuring-verification-results.md","docs/body-structure-survey.md","docs/pending-decisions.md","scripts/body-structure-checks.rb","scripts/test-body-policy.rb","scripts/test-body-rehearsals.rb"],"reportPath":"/Users/clarkeyeh/orca/workspaces/dev-rule/java-common-separation/docs/body-restructuring-review-7.md"}

已提交 7b2667c，補齊三條分派規則、BM-03 雙側去向範例與常見卡關說明，工具只新增保留 Java 小節及至少一句正文的檢查並改善去向診斷。乾淨 HEAD 主檢查與五支測試全部通過，案例分別為 76、40、6、18、2 個，BM-03 正向通過且 K01 至 K03 全部命中指定條號診斷而拒絕。rules 與樣板 JSON 均無差異，工作區僅七份審閱報告未追蹤，R7-M4、R7-M5 及其餘未指定低度問題依指示保留後續處理，未推送且可由協調者接續分派。

## [status] 例外與資源：逐條處理與協調事項

- from: term_194bd77d-e6f2-4410-a33e-d1c8f1be13a2
- at: 2026-11-09T07:41:53Z
- payload: {"taskId":"task_d936ca3649de","dispatchId":"ctx_69aedb7b746b"}

提交：3cf18fec4b36ddef0dc067549f871d2c0816f0d7。
逐條處理表（保留均指正文逐字完整保留）：
EX-01｜第四節否｜保留增量｜保留例外分類、標準或第三方選擇、邊界原因與業務失敗限制｜未移除｜java-exception-classification。
EX-02｜第四節否｜保留增量｜保留 Checked／Unchecked、處置宣告及恢復重試限制｜未移除｜java-checked-unchecked。
EX-03｜第四節否｜保留增量｜保留具體捕捉、try 範圍、入口分類與 Throwable／Error 限制｜未移除｜java-catch-scope。
EX-04｜第四節否｜保留增量｜保留中斷傳遞、恢復旗標、停止取消及清理要求｜未移除｜java-interruption。
EX-05｜第四節可能、強制保留清單｜整條保留｜保留 AutoCloseable／try-with-resources、借用與框架所有權、可靠釋放與垃圾回收限制｜未移除｜java-resource-management。
EX-06｜第四節否｜保留增量｜保留 suppressed exceptions、清理關係、finally 及單獨清理失敗處置｜未移除｜java-suppressed-failures。
EX-07｜第三節重述｜整條移除｜原共通連結保留於檔頭｜移除引用句與多資源建構失敗清理、移交前責任、依賴釋放順序重述｜rules/coding/resource-lifecycle.md#ex-07。
EX-08｜第三節重述｜整條移除｜原共通連結保留於檔頭｜移除引用句與非同步使用不可提前關閉、不得假設 close 重複呼叫重述｜rules/coding/resource-lifecycle.md#ex-08。
EX-09｜第四節否｜保留增量｜保留全部失敗路徑驗收、實際框架配置與適用範圍｜未移除｜java-failure-coverage。
涵蓋不直接而額外保守保留：無；保留處理均依明訂分類與強制清單。未決語意判斷：無；EX-07 的建構失敗對應共通元件初始化失敗，EX-08 的 API 名稱依待決清單確認沒有額外限制，刪除子句的共通完整原句均從檔案逐字登錄。
本文件沒有第三節判為驗收入口而待決定的條文；EX-09 是第四節否，仍完整保留正文。需要協調者更新 docs/pending-decisions.md:107-108、193-199 的現行定位與完成狀態，以及 docs/java-rule-migration.md:117-125 的現行定位；原分組錨點仍在，所以不是斷鏈，但不能再以舊條號當現行正文定位。
驗收追溯檔 acceptance-cleanup-batch-2.md 的既有驗收錨點全部保留，不需變更；java-rule-classification.md 的歷史行號維持歷史資料。共用驗證紀錄留給協調者重生。
作業說明衝突、工具診斷卡關與待修改共通義務：無。未新增報告檔，詳盡逐句證據在指定 JSON。

## [status] 例外與資源：提交後驗證結果

- from: term_194bd77d-e6f2-4410-a33e-d1c8f1be13a2
- at: 2026-11-09T07:42:08Z
- payload: {"taskId":"task_d936ca3649de","dispatchId":"ctx_69aedb7b746b"}

提交後於根目錄執行結果：ruby scripts/verify-body-restructuring.rb 結束碼 0；ruby scripts/test-body-restructuring.rb 結束碼 0，76 案例全部 matched=true；ruby scripts/test-body-policy.rb 結束碼 0，40 案例全部 matched=true。ruby scripts/verify-body-worker-scope.rb --topic exceptions-and-resources --start 7b2667c72d2163a5be9e782dec13946ed7590e90 --expected-start 7b2667c72d2163a5be9e782dec13946ed7590e90 結束碼 0，工作者範圍通過且 changed 只有指定兩檔。git diff --check 7b2667c72d2163a5be9e782dec13946ed7590e90..HEAD 結束碼 0、無輸出；git status --short 結束碼 0、無輸出；git diff --stat 同範圍只列指定兩檔，368 insertions、84 deletions。另執行 test-body-worker-scope.rb 結束碼 0，6 案例全部 matched=true；提交前 git diff --check 亦通過。JSON status=completed，沒有尚未整理理由；人工逐句核對與程式字串對照確認 EX-01 至 EX-06、EX-09 原正文完整一致，EX-07／08 的所有移除要求都有原文承接證據。

## [worker_done] 完成 exceptions-and-resources：3cf18fe

- from: term_194bd77d-e6f2-4410-a33e-d1c8f1be13a2
- at: 2026-11-09T07:42:17Z
- payload: {"taskId":"task_d936ca3649de","dispatchId":"ctx_69aedb7b746b","outcome":"succeeded","filesModified":["rules/stacks/java/common/exceptions-and-resources.md","docs/body-restructuring/java/exceptions-and-resources.json"]}

已完成指定兩檔並提交 3cf18fec4b36ddef0dc067549f871d2c0816f0d7，正文改語意小標題、逐句紀錄完成且驗收內容完整保留。EX-07／08 由共通原文逐筆承接後移除，另七條逐字保留，提交後結構、76 項負向、40 項政策、範圍與差異檢查全部通過且工作區乾淨。剩餘為協調者複核合併並更新共用待決與遷移定位，逐條處理表、無未決判斷聲明及實際測試結果已分別以 status 訊息送達。

## [status] version-policy 完整逐條交接與驗證結果

- from: term_dbeca9f5-31e8-4504-a074-2c7fcc3a1e97
- at: 2026-11-09T07:42:21Z
- payload: {"taskId":"task_f86a4973fdea","dispatchId":"ctx_48dcb6c4d567"}

提交：57afa95ca990d6619c45f2459fafbe65611a61d6

逐條處理表（第三、六節無本主題列，以下判斷均來自第四節）：

| 歷史 ID | 判斷 | 種類 | 保留內容 | 移除／共通承接 |
| --- | --- | --- | --- | --- |
| JV-01 | 否 | 保留增量 | 保留建置 JDK、編譯目標、標準 API 與執行支援範圍；待決清單指出共通資料契約無法直接涵蓋 JDK 執行支援承諾。 去向：rules/stacks/java/common/version-policy.md#java-version-declarations | 無移除；無新增承接錨點 |
| JV-02 | 否 | 保留增量 | 保留受版本控制的建置設定、本機與 CI 一致性及 Java 語言、API、位元碼限制，依第四節否的預設處理不抽背景。 去向：rules/stacks/java/common/version-policy.md#java-build-compatibility | 無移除；無新增承接錨點 |
| JV-03 | 否 | 保留增量 | 保留每個承諾執行版本、函式庫使用端載入與關鍵功能驗證，以及風險深度與 CI 或發布證據。 去向：rules/stacks/java/common/version-policy.md#java-runtime-verification | 無移除；無新增承接錨點 |
| JV-04 | 否 | 保留增量 | 保留逐模組編譯目標、支援範圍、依賴關係與共用模組對使用端的相容性驗證。 去向：rules/stacks/java/common/version-policy.md#java-module-versions | 無移除；無新增承接錨點 |
| JV-05 | 否 | 保留增量 | 保留直接與間接依賴 Java 版本核對、超出承諾範圍時先完成處置的採用條件及既有共通連結。 去向：rules/stacks/java/common/version-policy.md#java-dependency-versions | 無移除；無新增承接錨點 |
| JV-06 | 否 | 保留增量 | 保留建置 JDK 升級的既有承諾與最低執行版本變更的部署、使用端、回退、遷移驗證及公告。 去向：rules/stacks/java/common/version-policy.md#java-build-upgrade | 無移除；無新增承接錨點 |
| JV-07 | 否 | 保留增量 | 保留正式功能預設、Preview 負責人核准與紀錄、建置測試部署配套、維護責任及配套不足時的處置。 去向：rules/stacks/java/common/version-policy.md#java-preview-features | 無移除；無新增承接錨點 |
| JV-08 | 否 | 保留增量 | 保留公開受支援 JDK API 預設、內部存取個別例外程序、替代方案、後續處置及升級重新驗證。 去向：rules/stacks/java/common/version-policy.md#java-jdk-internals | 無移除；無新增承接錨點 |
| JV-09 | 否 | 保留增量 | 保留符合版本範圍的替代 API、預定移除風險與遷移、持續使用例外核准及重新評估條件。 去向：rules/stacks/java/common/version-policy.md#java-deprecated-api | 無移除；無新增承接錨點 |
| JV-10 | 否 | 保留增量 | 保留 Java 版本變更對編譯、測試、分析與產物工具的評估、必要檢查實際執行與產物版本承諾。 去向：rules/stacks/java/common/version-policy.md#java-toolchain-compatibility | 無移除；無新增承接錨點 |
| JV-11 | 否 | 保留增量 | 保留 JDK 發行商、完整版本、多發行版本支援與更新驗證；待決清單指出第三方依賴管理不能直接代替執行環境識別。 去向：rules/stacks/java/common/version-policy.md#java-jdk-distribution | 無移除；無新增承接錨點 |
| JV-12 | 否 | 保留增量 | 保留發布產物到建置 JDK、編譯目標、依賴及驗證的追溯，以及部署識別、Java 環境與啟動設定核對。 去向：rules/stacks/java/common/version-policy.md#java-artifact-traceability | 無移除；無新增承接錨點 |

保守保留與疑義：本輪依「否」預設逐字保留所有條文，沒有需要核准的拆句判斷。JV-01 的「專案須記錄建置 JDK、編譯目標與標準函式庫 API 相容範圍，以及實際部署或承諾支援的 Java 執行版本。」及「共用函式庫須明列使用端可依賴的支援範圍。」依待決清單保留，資料契約不能直接代替 JDK 執行支援義務；JV-11 全部三句保留，第三方依賴管理不能直接代替 JDK 發行商、完整版本、多發行版本支援與修補／發行商變更驗證。其他條文亦依作業說明不抽共同背景，沒有刪字、限定詞或新義務。

版面與追溯：12 個三級標題沿用原粗體文字，語意錨點逐條建立；兩段尾段依原次序移到 java-closing-requirements，history_id 均為 null；7 筆 acceptance_changes 包含表頭與六列第一欄，第二欄及驗收非表格文字均不變。JSON 為 completed，38 個原始切句 action 全為保留，removed_assertions 全空，無「尚未整理」理由。

協調者待辦：本主題沒有「驗收入口」條文。docs/pending-decisions.md 第 149–160 行仍用第 1–12 條標籤連向分組，docs/java-rule-migration.md 第 24–35 行仍有「原第 N 條及驗收表」及整份文件目的地，可按本 JSON 映射統一更新；舊分組仍存在，所以未造成失效錨點。docs/acceptance-cleanup-batch-3.md 使用的 acceptance-java 錨點全部保留，不需改動。範例段遠離第一組的可讀性取捨依作業說明維持補充要求位置，未擅自套用後續可讀性決策。無其他問題、無作業說明衝突、無工具診斷卡關。

實際驗證結果（提交後根目錄執行）：
- ruby scripts/verify-body-restructuring.rb：exit 0，153 條去向驗證通過，本主題 12 條均保留增量。
- ruby scripts/test-body-restructuring.rb：exit 0，76/76 案例符合預期。
- ruby scripts/test-body-policy.rb：exit 0，40/40 案例符合預期。
- ruby scripts/verify-body-worker-scope.rb --topic version-policy --start 7b2667c72d2163a5be9e782dec13946ed7590e90 --expected-start 7b2667c72d2163a5be9e782dec13946ed7590e90：exit 0，工作者範圍通過。
- git diff --check 7b2667c72d2163a5be9e782dec13946ed7590e90..HEAD：exit 0，無輸出。
- git status --short：exit 0，無輸出，乾淨。
- git diff --stat 7b2667c72d2163a5be9e782dec13946ed7590e90..HEAD：只有指定兩檔，441 insertions(+)、126 deletions(-)。
另執行 ruby scripts/test-body-worker-scope.rb：exit 0，6/6 案例符合預期；與 git show 350668e 原文逐條核對及字串比對均確認 12 條正文、38 個原始切句完整保留。

未新增報告檔，所有詳細紀錄在指定 JSON；本訊息作為完整交接回報。


## [status] lambda-and-stream 完整處理與驗證回報

- from: term_a9bc7c8d-be2a-49b4-b574-e84b9b549e06
- at: 2026-11-09T07:42:27Z
- payload: {"taskId":"task_def899082c96","dispatchId":"ctx_c185e102654b"}

提交：d45d1632e219e592c2151a5935fdce40fcd9fa62。僅指定兩檔，JSON completed，36 個來源單位全部保留，沒有改寫或移除斷言；分組不變，示例逐行移至補充要求，驗收第二欄與非表格原文不變。

逐條處理表（每條移除內容與承接共通錨點均為「無」，全部原文保留）：
| 歷史 ID | 待決判斷 | 去向種類 | 保留內容 | Java 錨點 |
| LS-01 | 第三節重述；第六節可移除純引用、保留適用說明 | 整條保留 | 原引用、Stream 不強制取代迴圈、複雜或獨立責任具名方法或清楚流程、不要求每個 Lambda 抽方法 | java-intent-readability |
| LS-02 | 否 | 保留增量 | 參數型別、禁省略與 var、方法參考條件、泛型資訊 | java-lambda-parameter-types |
| LS-03 | 否 | 保留增量 | 中間操作、peek、外部呼叫及 forEach 副作用保證 | java-intermediate-side-effects |
| LS-04 | 是，必須整條保留 | 整條保留 | 累積設計、禁止隱藏修改外部狀態、跨元素責任 | java-result-accumulation |
| LS-05 | 否 | 保留增量 | 延遲、終端、短路、完整驗證與逐項處理 | java-lazy-short-circuit |
| LS-06 | 否 | 保留增量 | 平行採用需求、隔離順序歸約失敗、阻塞資源、負載收益 | java-parallel-stream-adoption |
| LS-07 | 是，必須整條保留 | 整條保留 | 初始值、結合性、分段合併、順序與可變容器 | java-reduction-collection |
| LS-08 | 否 | 保留增量 | 分類、函式介面例外限制、原因、禁隱藏拋出、部分成功 | java-failure-classification |
| LS-09 | 否 | 保留增量 | 單次消費、禁共用、快照重取一致性、有效期與關閉 | java-stream-consumption |
| LS-10 | 否 | 保留增量 | 變更觸發驗收、執行語意、平行隔離效能、不重測函式庫等邊界 | java-execution-verification |

涵蓋疑義與保守決定：LS-01 原句「Java Lambda／Stream 不強制取代迴圈；複雜或獨立責任採具名方法或清楚流程，不要求每個 Lambda 都抽方法。」完整保留。已讀 code-design.md 的「依責任與變更原因決定是否拆分函式，保留清楚的流程入口。」及 naming.md 的「一組條件共同表達明確業務概念，且名稱有助理解時，才抽取成具名判斷。」；這些句子沒有直接涵蓋完整 Java 表達選擇，因此不據此刪除。純引用句也保留，避免為刪引用而新增指路；rules.reason 與句子理由已記錄具體疑義及「整理前原文未提交，無法證明完整覆蓋」。除此沒有未定判斷。

協調者事項：本份沒有第三節判斷為驗收入口的條文，LS-10 是第四節「否」，未轉為驗收入口。請複核 LS-01 保守處置；統一更新 docs/java-rule-migration.md:140–149 的現行目的地與原條號顯示，以及 docs/pending-decisions.md:122、201–209、323 的 LS 連結。分組錨點仍有效，既有 acceptance 錨點全保留，acceptance-cleanup-batch-5.md 的歷史追溯不需破壞。未發現其他需改 rules 入站連結。作業說明與任務沒有衝突，沒有工具拒絕或卡關。

提交後實際結果：ruby scripts/verify-body-restructuring.rb exit 0，已讀本份人工清單（10 去向、9 驗收變更），只有 LS-01 屬保守分類；ruby scripts/test-body-restructuring.rb exit 0；ruby scripts/test-body-policy.rb exit 0，40 案例全 matched；指定 start/expected-start 的 verify-body-worker-scope exit 0，工作者範圍通過；git diff --check 7b2667c72d2163a5be9e782dec13946ed7590e90..HEAD exit 0 無輸出；git status --short exit 0 空白；git diff --stat 僅兩檔，339 insertions、84 deletions。額外 test-body-worker-scope.rb exit 0，6 案例全 matched；人工與逐字檢查確認 10 條正文及 36 來源單位未減少。

## [worker_done] version-policy 整理完成並提交 57afa95

- from: term_dbeca9f5-31e8-4504-a074-2c7fcc3a1e97
- at: 2026-11-09T07:42:30Z
- payload: {"taskId":"task_f86a4973fdea","dispatchId":"ctx_48dcb6c4d567","outcome":"succeeded","filesModified":["rules/stacks/java/common/version-policy.md","docs/body-restructuring/java/version-policy.json"]}

已完成 version-policy 指定兩檔並提交 57afa95ca990d6619c45f2459fafbe65611a61d6，完整逐條表與驗證結果已透過 status 訊息 msg_8378c6307af2 送達。十二條均依否判斷保留增量，三十八個原始切句逐字保留，提交後全部指定檢查通過且工作區乾淨。剩餘由協調者複核合併及統一更新 pending-decisions 與 java-rule-migration 的舊條號定位，本主題沒有驗收入口待決或未完成條文。

## [worker_done] lambda-and-stream 已提交並通過驗證

- from: term_a9bc7c8d-be2a-49b4-b574-e84b9b549e06
- at: 2026-11-09T07:42:35Z
- payload: {"taskId":"task_def899082c96","dispatchId":"ctx_c185e102654b","outcome":"succeeded","filesModified":["rules/stacks/java/common/lambda-and-stream.md","docs/body-restructuring/java/lambda-and-stream.json"]}

已完成指定兩檔整理並提交 d45d1632e219e592c2151a5935fdce40fcd9fa62，逐條處理表與完整驗證結果已透過 msg_0c830355d0ae 回報。全部指定檢查通過且工作區乾淨，10 條正文與 36 個來源單位逐字保留，LS-01 因共通涵蓋不直接而保守整條保留。剩餘由協調者複核 LS-01 並更新共用追溯文件的現行連結，本份沒有待處理驗收入口或未完成條文。

## [status] collections-and-ownership 完整處理與驗證回報

- from: term_91644d1f-7eca-494c-85d0-05021d4b7135
- at: 2026-11-09T07:42:53Z
- payload: {"taskId":"task_3fe3001fba57","dispatchId":"ctx_35baafa9a2bb"}

完成提交：b82cfed43af102e5dc90c73b911e982efbe9700f（只有指定兩檔、起點後一個提交）。JSON 狀態 completed，9 條、24 來源句，11 保留、13 移除，無尚未整理理由。

逐條處理表（共通路徑均以 rules/ 為根）：
|歷史 ID|第三節判斷|去向種類|保留|移除與承接|
|CO-01|重述|拆分|Java 集合介面不能取代所有權契約及可變元素／參考保留整句|純引用句→coding/collections-and-ownership.md#co-01|
|CO-02|重述|拆分|不可修改包裝可能是檢視、外層複製保留可變元素、實際隔離整句|純引用句→coding/collections-and-ownership.md#co-02|
|CO-03|重述|整條移除|無 Java 正文；原引用保留於引言|引用與順序、重複元素、重複鍵、不意外去重覆蓋→coding/collections-and-ownership.md#co-03|
|CO-04|重述|整條移除|無 Java 正文；分組保留並指路|引用與支援遍歷操作、未拋例外不代表安全、不得捕捉後直接重跑→coding/collections-and-ownership.md#co-04|
|CO-05|重述|整條移除|無 Java 正文；分組保留並指路|引用與單一操作不能推導多步驟／跨鍵原子性→coding/concurrency-and-async.md#co-05|
|CO-06|重述|整條移除|無 Java 正文；原引用保留於引言|引用與 Iterator／Stream 不保證有界、排序去重分組成本→quality/performance.md#co-06|
|CO-07|重述|拆分|資源型 Iterator／Stream 有效期、關閉責任、受控結果及關閉方式整句|純引用句→coding/resource-lifecycle.md#co-07|
|CO-08|待確認；第六節待補證；指南核准混合優先|拆分|批次例外不代表未修改、不強制交易能力、核對約定狀態整句|純引用句→coding/error-handling.md#failure-state-guarantee；錯誤處理整份連結仍在補充要求|
|CO-09|重述|拆分|實際修改、遍歷、檢視、資源路徑依下方驗收及不重測標準函式庫整句|純引用句→coding/collections-and-ownership.md#co-09|

第四節無本文件對應列。保守保留與猶豫：CO-01 共通未直接寫出 Java 介面不能取代所有權契約；CO-02 未直接寫出 Java 不可修改包裝仍可能是來源檢視；CO-07 未直接指定關閉方式依例外與資源管理；CO-08 正文明訂狀態未直接表述核對實際狀態；CO-09 未直接列出實際遍歷路徑與依下方驗收定位。因此以上附句逐字保留，沒有以推論刪掉。CO-08 歷史理由保留「整理前原文未提交，無法證明完整覆蓋」。

協調者事項：本份沒有判斷為驗收入口的條文（CO-09 是重述）。請複核上述保守保留，更新 docs/java-rule-migration.md:108–116 的原第 N 條及驗收表定位，以及 docs/pending-decisions.md:98–106、322 的原條號／分組定位；舊分組錨點仍存在，並非斷鏈。整份是否併入例外仍由協調者決定。檔頭「具體併發 API 與資源管理方式由後續 Java 主題展開」按禁止任意改寫保留；對應 pending-decisions L6 留後續處理。本份基準沒有驗收表，故沒有表頭／第一欄可改，也無數字條號引用；全部驗收非表格文字與共同連結保留，新增指定 acceptance-failure-state。

工具卡點：CO-08 原句的「失敗後狀態」僅加 Markdown 連結，工具仍報「未申報的刪除片段 CO-08: [失敗後狀態]」。依指南恢復原句，原因寫入 JSON；未改工具、白名單或虛構移除斷言，已解除阻塞。無作業說明與派工衝突，無未完成條文。

逐句人工核對已完成：對照 git show 350668e 的全部原句、實際共通原文與 JSON，條件、禁止事項、範圍均原留或登錄承接，尾段兩句歸補充要求。
提交後實際結果：
- ruby scripts/verify-body-restructuring.rb：exit 0，JSON 輸出有效。
- ruby scripts/test-body-restructuring.rb：exit 0，76 案例，matched=false 0。
- ruby scripts/test-body-policy.rb：exit 0，40 案例，matched=false 0。
- ruby scripts/verify-body-worker-scope.rb --topic collections-and-ownership --start 7b2667c72d2163a5be9e782dec13946ed7590e90 --expected-start 7b2667c72d2163a5be9e782dec13946ed7590e90：exit 0，工作者範圍通過。
- git diff --check 7b2667c72d2163a5be9e782dec13946ed7590e90..HEAD：exit 0，無輸出。
- git status --short：exit 0，無輸出，工作區乾淨。
- git diff --stat 起點..HEAD：只列指定兩檔，346 insertions、115 deletions。
- 額外 ruby scripts/test-body-worker-scope.rb：exit 0，6 案例全部 matched=true。
詳細證據皆在指定 JSON，未另建報告或修改共用檔。

## [worker_done] collections-and-ownership 已完成並提交

- from: term_91644d1f-7eca-494c-85d0-05021d4b7135
- at: 2026-11-09T07:43:02Z
- payload: {"taskId":"task_3fe3001fba57","dispatchId":"ctx_35baafa9a2bb","outcome":"succeeded","filesModified":["rules/stacks/java/common/collections-and-ownership.md","docs/body-restructuring/java/collections-and-ownership.json"]}

已完成指定兩檔的正文與逐句承接整理，提交為 b82cfed43af102e5dc90c73b911e982efbe9700f，JSON 已標 completed。CO-03 至 CO-06 由共通承接，其餘保守保留 Java 附句，提交後全部指定檢查通過且工作區乾淨。完整逐條表與診斷已送於 msg_7c071ef03424，剩餘跨檔定位更新、保守保留複核及是否併檔由協調者處理。

## [status] boundary-mapping 逐條交付報告

- from: term_9e892330-7f2b-4215-928e-0af4dca8bb76
- at: 2026-11-09T07:43:22Z
- payload: {"taskId":"task_58bb1ea2ea07","dispatchId":"ctx_401d10978152"}

boundary-mapping 詳細交付報告（測試最終結果另隨完成通知）

提交：592d09b，僅修改 rules/stacks/java/common/boundary-mapping.md 與 docs/body-restructuring/java/boundary-mapping.json，狀態 completed。

逐條處理表（未註明刪除者均逐字保留全部原文）：
| ID | 待決判斷 | 去向種類 | 保留／移除與承接 |
| BM-01 | 重述 | 整條移除 | 移除引用句及模組內傳遞、不強制 DTO、對外／跨模組公開契約句；由 rules/architecture/boundary-objects.md#隔離與拆分 的兩句原文承接，整份連結仍在檔頭。 |
| BM-02 | 重述 | 整條保留 | 保留同名／新增來源欄位限制與可信欄位來源及三份引用；無刪除，現行 #java-mapping-fields。 |
| BM-03 | 重述 | 整條移除 | 移除引用句及格式解析、建立專屬型別、補查前協調句；由 rules/architecture/data-mapping.md#bm-03 原句承接，原連結移至檔頭固定引用。 |
| BM-04 | 待確認，核准選 B 優先 | 整條保留 | 原兩句逐字保留，另依 imports 移入「不得略過欄位或產生不完整物件掩蓋失敗」；現行 #java-mapping-integrity。 |
| BM-05 | 否 | 保留增量 | 原兩句逐字保留，包含 Java 欄位、預設值、反序列化、明確型別一路傳遞與 null／Optional；現行 #java-update-intent。 |
| BM-06 | 重述 | 整條保留 | 保留集合外層複製、符合契約的不可變值共用、不要求全面深層複製與兩份引用；現行 #java-mutable-isolation。 |
| BM-07 | 重述 | 整條保留 | 保留反向產生判斷與 Framework 配置責任及引用；現行 #java-directional-mapping。 |
| BM-08 | 重述 | 整條保留 | 保留方法、專責類別、Mapper 介面／包裝層與三份引用；現行 #java-mapping-ownership。 |
| BM-09 | 重述 | 整條移除 | 移除引用句及實際映射、適用序列化／反序列化、不得只測手寫替代句；由 rules/architecture/data-mapping.md#bm-09 的實際映射與序列化邊界完整原句承接，原連結移至檔頭。 |

保守保留及沒有把握的判斷：
BM-02「Java 映射工具不得因同名或來源新增欄位而擴大傳遞範圍；租戶與建立者等可信欄位仍依伺服器契約取得。」共通允許欄位與新增欄位可涵蓋部分內容，但未直接點明「同名」觸發，故整條留下。
BM-06「Java 複製集合外層不一定隔離可變元素；符合契約的不可變值可共用，不要求全面深層複製。」現行兩份主要引用未直接完整承接共用值及不強制深層複製的適用範圍，且第六節要求補正引用組合後才能移除，故不以摘要或驗收代替正文證據。
BM-07「Java 映射工具支援反向產生不代表可直接採用；具體工具配置另由 Framework 規範落實。」後半配置責任無 bm-07 直接承接句，整條留下。
BM-08「Java 簡單映射可使用方法，有實際責任或共用需求才建立專責類別，不強制 Mapper 介面或包裝層。」共通責任配置／介面規則可涵蓋部分，但方法與 Mapper 包裝層未有同樣直接完整原句，整條留下供複核。
BM-01／02／04／06／08 的歷史去向理由均保留「整理前原文未提交，無法證明完整覆蓋」。

協調者後續事項：
1. 本份沒有分類為「驗收入口」而待決的條文；BM-04 按選 B 保留原驗收文字，不能把它誤作入口轉換。
2. 合併確認後才刪 rules/architecture/data-mapping.md「既有共同保證的落實」內已移入的禁止句，本工作區未改共通。
3. docs/java-rule-migration.md:79–87 的「原第 N 條及驗收表」與現行定位、docs/pending-decisions.md:80–87、182、316–320、345 的舊條號／分組連結需統一更新；分組與驗收錨點都仍存在，沒有為改名而破壞它們。
4. docs/pending-decisions.md:345 的 L2 建議把 BM-04 部分成功改精確引用仍留給協調者；本輪整條保留規則禁止自行改寫。

驗證與卡關：逐句人工核對基準 350668e，23 個來源單位中 17 保留、6 移除，另 1 句核准移入；全部條件、禁止及範圍有原句或共通證據，驗收第二欄及非表格內容不變。第一次常駐檢查拒絕 BM-01 同條重複理由，已按純引用與後附斷言分別填具體理由後通過，未修改工具或白名單；無說明衝突或未解診斷。


## [status] 併發正文整理：逐條處置與保守判斷報告

- from: term_3e4fdedc-ec80-4060-a6b6-ea2cb6aacecf
- at: 2026-11-09T07:43:30Z
- payload: {"taskId":"task_ed44d673b773","dispatchId":"ctx_866e69b1fdc1"}

提交：195eba3d9176aac96e18df2a8ee05027222d4047；僅指定兩檔，JSON completed。逐句紀錄含完整來源原文及保守理由，未新增報告檔。

| 歷史 ID | 待決判斷 | 去向 | 保留／移除與承接 |
| --- | --- | --- | --- |
| CA-01 | 重述 | 整條移除 | 接手元件、脫離流程責任與結果處置移至 rules/coding/concurrency-and-async.md#ca-01；引用留檔頭 |
| CA-02 | 混合 | 拆分 | 保留 Executor、ExecutorService、框架提交及共同引用；只移除虛擬執行緒下游容量子句，由同共通檔 #ca-02 承接 |
| CA-03 | 第四節是、選 B | 整條保留 | 可見性交付、不可變資料、隔離快照、同步原子性及 volatile 限制全部逐字保留 |
| CA-04 | 重述 | 整條移除 | 等待逾時不等於停止、整體時間預算由同共通檔 #ca-04 承接；引用留檔頭 |
| CA-05 | 增量 | 保留增量 | 取消訊號、中斷與最外層 Future 限制全文保留；無移除 |
| CA-06 | 原第四節是，已核准提升比照混合 | 整條保留（保守） | 接收與處置路徑、不得忽略工作控制物件、Future／CompletableFuture、結果鏈原因分類恢復降級全文保留；無移除 |
| CA-07 | 重述 | 整條保留（保守） | 驗證完成順序及剩餘任務處置、第一完成非第一成功全文保留；無移除 |
| CA-08 | 重述 | 整條移除 | executor 執行安排、阻塞及同一受限資源等待由同共通檔 #ca-08 承接；引用留檔頭 |
| CA-09 | 增量 | 保留增量 | ThreadLocal／日誌脈絡不自動沿用與結束清理還原全文保留；無移除 |
| CA-10 | 重述 | 整條移除 | 全退出路徑、必要檢查不得移出原子範圍由同共通檔 #ca-10 承接；引用留檔頭 |
| CA-11 | 重述 | 整條保留（保守） | 開始關閉不等於工作結束與實際關閉資源釋放驗證全文保留；無移除 |
| CA-12 | 重述 | 整條保留（保守） | 受控協調完成條件、同步／可見性審查及不得單憑睡眠或壓測全文保留；無移除 |

涵蓋不足及猶豫處：CA-06「不得忽略回傳的工作控制物件而遺失故障」未直接出現在 async-result-reception，第一句與 Java 失效情境相連，故整條保留；第二句也完整保留 Future／CompletableFuture 結果鏈限制。CA-07「須驗證完成順序及剩餘任務處置」的驗證動作未在 ca-07 正文直接列出。CA-11「實際關閉與資源釋放依共同契約驗證」的驗證動作未在 ca-11 正文直接列出。CA-12「並審查同步／可見性設計」中的可見性審查未在 ca-12 直接列出；這三條均整條保留，不以驗收倒推正文完整涵蓋。

需協調者處理：本主題沒有第三節分類為「驗收入口」的條文；CA-12 判斷是重述，不擅自轉入口。請複核 CA-06／07／11／12 的保守處置。docs/java-rule-migration.md:150-161 的原條號與 CA-03／06 整份定位、docs/pending-decisions.md:123-132、210-211 的舊條號及分組定位可依 JSON 現行去向更新；分組全部保留，因此沒有製造斷鏈。歷史分類與 acceptance-cleanup-batch-2.md 的原編號是歷史證據，本次未改。

工具卡點：同條引用句與實質要求理由相同遭拒，已分開具體說明；將 CA-06 原文字「明確接收及處置路徑」加上 async-result-reception 連結，遭工具回報「未申報的刪除片段 CA-06」，已依指引還原原句、採整條保留，未更動工具或白名單。作業說明與任務無另發現衝突。核准 reception 共同驗收連結已補，兩列 Java 驗收第二欄與所有非表格驗收原文不減少。

已對 git show 350668e 的完整正文逐句複核；保留句原樣存在，被刪子句的共通來源完整句逐字載於 JSON。提交後的範圍檢查、diff --check 均 exit 0；git status --short 無輸出；diff --stat 僅兩檔，444 insertions、125 deletions。常駐與兩組負向測試正在提交後重跑，完成後會另補實際計數並送唯一 worker_done。


## [worker_done] boundary-mapping 完成並通過驗證

- from: term_9e892330-7f2b-4215-928e-0af4dca8bb76
- at: 2026-11-09T07:43:44Z
- payload: {"taskId":"task_58bb1ea2ea07","dispatchId":"ctx_401d10978152","outcome":"succeeded","filesModified":["rules/stacks/java/common/boundary-mapping.md","docs/body-restructuring/java/boundary-mapping.json"]}

已完成 boundary-mapping 指定兩檔並提交 592d09b4f13f5002a2be3816ab0ea49a1df2f807，JSON 為 completed，逐條表與疑點詳見先前訊息 msg_309ab23a3b75。BM-01／03／09 移除且有逐句共通證據，BM-02／06／07／08 保守整條保留、BM-04 原文與移入句完整、BM-05 保留增量；提交後 verify-body-restructuring、test-body-restructuring（76 案例）、test-body-policy（40 案例）、指定起點 verify-body-worker-scope、git diff --check 起點..HEAD、git status --short 全數 exit 0，status 無輸出且 diff stat 僅兩檔，另提交前 test-body-worker-scope 六案例均符合預期。剩餘事項僅協調者複核保守保留理由、更新 migration／pending 舊條號連結，以及確認 BM-04 移入後刪共通摘要，沒有未處理條文或未解工具問題。

## [worker_done] 完成：Java 併發正文整理 195eba3

- from: term_3e4fdedc-ec80-4060-a6b6-ea2cb6aacecf
- at: 2026-11-09T07:43:48Z
- payload: {"taskId":"task_ed44d673b773","dispatchId":"ctx_866e69b1fdc1","outcome":"succeeded","filesModified":["rules/stacks/java/common/concurrency-and-async.md","docs/body-restructuring/java/concurrency-and-async.json"]}

已以唯一提交 195eba3d9176aac96e18df2a8ee05027222d4047 完成指定兩檔整理與 completed 逐句紀錄，詳細十二條處置表及原文涵蓋理由已由狀態訊息 msg_4fc270af3580 送達。提交後常駐檢查 exit 0、正文負向測試 76/76、政策測試 40/40、指定起點範圍檢查與 diff --check 全通過，另已通過六項範圍工具測試，git status 無輸出且 diff --stat 僅兩檔。剩餘由協調者複核 CA-06／07／11／12 保守整條保留與 CA-06 純加連結遭拒的工具診斷，並更新既有跨檔歷史定位；本主題沒有待決驗收入口條文且未留下未處理項目。

## [status] value-objects 完整處理表與驗證結果

- from: term_3d609da8-237b-4b9f-8be8-078467ee07ae
- at: 2026-11-09T07:45:19Z
- payload: {"taskId":"task_303457b8ebb5","dispatchId":"ctx_e6191375b956"}

提交：cd71a677118da43f23cf315566072963820a02b3（起點後恰一個提交）。JSON status=completed；只有指定兩檔變動，420 insertions、95 deletions。全部十條及基準逐句人工比對完成，沒有未處理條文；共通原文逐字取自實際檔案，驗收第二欄、共同驗收、引言及治理尾句完全保留。

逐條處理表（D=rules/coding/domain-modeling.md；C=rules/coding/code-design.md；V=rules/coding/validation.md）：
| 歷史 ID | 待決判斷 | 去向種類 | 保留內容 | 移除內容與承接 |
| --- | --- | --- | --- | --- |
| VO-01 | 重述 | 整條移除 | 整份領域建模引用留於引言；驗收保留 | 引用句、OrderId／CustomerId 型別區隔與一般描述資料免包裝 → D#專屬型別；證據含不同用途 ID、實際阻止誤用及描述性資料三句 |
| VO-02 | 重述 | 整條移除 | 領域建模及資料驗證整份引用與全部驗收 | 建立驗證 → D#專屬型別、V#責任分工；建構子／工廠一致驗證 → C#cl-06；合法值不代表存在／授權 → D#專屬型別 |
| VO-03 | 增量 | 保留增量 | 全文逐字：final 不代表內容不可變、傳入／取出隔離及原引用 | 無 |
| VO-04 | 第四節否 | 保留增量 | 全文逐字：equals／hashCode、相等雜湊、業務區別、產生方法與全部例子 | 無 |
| VO-05 | 混合 | 拆分 | 原共同引用；Java 建構子、工廠及其他建立入口須讓 equals／hashCode 反映已定義值語意 | 「一致執行正規化，並」→ D#vo-05；保留主詞與須字 |
| VO-06 | 重述 | 拆分（保守） | 原共同引用；「跨幣別等依賴外部政策的操作由領域元件協調。」 | 操作保留專屬型別 → D#vo-06、D#專屬型別；必要邊界呈現讀底層值 → D#vo-06 |
| VO-07 | 混合 | 拆分 | 原共同引用；Java 建構、反序列化、持久化共同保證及類別／record 不得形成驗證旁路的完整原句 | 「具體框架配置另訂。」→ D#vo-07；rules.targets 同列 Java 與共通 |
| VO-08 | 第四節否 | 保留增量 | 全文逐字：版本、類別／record 選擇、公開產生方法、可變內容、敏感字串與版本引用 | 無 |
| VO-09 | 第四節可能；強制保留 | 整條保留 | 全文逐字：診斷與交換格式分別定義、toString 禁止默認契約與敏感揭露限制 | 無 |
| VO-10 | 驗收入口 | 整條保留 | 全文逐字：equals／hashCode／record 產生方法、還原路徑及不機械式逐一測試 | 無；交協調者決定 |

保守與不確定處：VO-06 原文明訂「領域元件」，共通外部政策句只稱「負責元件」，不確定能否直接承接責任限定，因此留住後半句；VO-07 共通還原原文未直接點名 Java 建構與一般類別／record 選擇，不刪該完整 Java 句，僅刪明確涵蓋的框架配置句。VO-10 依明文決策整條留住，不利用未列管摘要消除覆蓋義務；VO-01、02、10 的歷史理由均保留「整理前原文未提交，無法證明完整覆蓋」。除此之外沒有懸而未決的工作者處置。

協調者事項：
1. VO-10 驗收入口整條保留待決定，共通「模型驗證與還原」摘要首句完全未動。
2. docs/pending-decisions.md 第 65–71、177–179、310–312、343 行仍以舊條號與分組定位連結本檔，請依 JSON 現行去向更新；第 371 行的既有驗收錨點仍有效。
3. docs/java-rule-migration.md 第 59–68 行仍寫「原第 N 條及驗收表」，共通／Java 現行入口可依 JSON 同步；docs/java-rule-classification.md 第 202–211 行保留歷史分類，不在本工作者範圍。
4. docs/acceptance-cleanup-batch-4.md 與 docs/acceptance-rewritten-fragments.json 的驗收錨點仍有效，未發現 rules 其他文件需更新的舊條號入站連結。
5. 沒有作業說明與任務衝突，沒有無法理解的工具診斷或持續阻塞；固定 link_retention 格式使資料驗證入口標籤使用 validation，照指南執行未改共用格式。

實際驗證（提交後）：
- ruby scripts/verify-body-restructuring.rb：exit 0；153 歷史 ID、15 份文件、completed 2／pending 13、86 驗收列、2052 本地連結；已閱讀本主題人工複核清單，VO-06 與 VO-10 的保守處置符合上述理由。
- ruby scripts/test-body-restructuring.rb：exit 0，76 案全部 matched=true。
- ruby scripts/test-body-policy.rb：exit 0，40 案全部 matched=true。
- ruby scripts/verify-body-worker-scope.rb --topic value-objects --start 7b2667c72d2163a5be9e782dec13946ed7590e90 --expected-start 7b2667c72d2163a5be9e782dec13946ed7590e90：exit 0，工作者範圍通過，僅兩個指定檔案。
- git diff --check 7b2667c72d2163a5be9e782dec13946ed7590e90..HEAD：exit 0，無輸出。
- git status --short：exit 0，無輸出（乾淨）。
- git diff --stat 起點..HEAD：僅 docs/body-restructuring/java/value-objects.json 與 rules/stacks/java/common/value-objects.md。
- 額外依指南執行 test-body-worker-scope.rb：exit 0，6 案全部 matched=true；git diff --check 350668eb14ede247af22c782323beebf940c2a5f..HEAD：exit 0。
沒有另建報告檔；逐句證據與疑義皆在指定 JSON。依 orchestration 技能（/Users/clarkeyeh/.agents/skills/orchestration/SKILL.md）使用本 Run 回報，未推送、未建立 PR、未向其他服務發送訊息。


## [worker_done] value-objects 已完成並驗證

- from: term_3d609da8-237b-4b9f-8be8-078467ee07ae
- at: 2026-11-09T07:45:29Z
- payload: {"taskId":"task_303457b8ebb5","dispatchId":"ctx_e6191375b956","outcome":"succeeded","filesModified":["rules/stacks/java/common/value-objects.md","docs/body-restructuring/java/value-objects.json"]}

已完成 value-objects 正文與逐句承接紀錄並提交 cd71a677118da43f23cf315566072963820a02b3，僅修改指定兩檔且工作區乾淨。提交後全部指定檢查通過，正文負向測試 76 案與政策測試 40 案均符合預期，VO-06 與 VO-07 的涵蓋疑慮已保守保留並登錄。完整十條處理表、證據與實際結果已在訊息 msg_e120a66f2932 回報，剩餘 VO-10 驗收入口及跨檔舊定位連結請協調者決定與更新。

## [status] naming-packages-docs 逐條處理與待收尾事項

- from: term_0abe793f-c9cd-405e-ab67-c4053e230a8d
- at: 2026-11-09T07:46:24Z
- payload: {"taskId":"task_5a98a79f6874","dispatchId":"ctx_465509371093"}

提交：8f4fad87fb9f1fc1e80009e88eb676ca61cb5b07（僅指定兩檔）；提交後完整驗證仍在執行，完成後另送 worker_done。
處理表（歷史 ID｜判斷｜去向種類｜保留｜移除與承接）：
ND-01｜否｜保留增量｜命名形式、縮寫、final 與 I 前綴全部原文｜無移除。
ND-02｜待補證｜整條保留｜共通引用與 Service／Handler／Helper／Utils 責任一致全部原文｜無移除。
ND-03｜否｜保留增量｜套件組織、公開內部界線、共用依賴與可見性檢查全部原文｜無移除。
ND-04｜否｜保留增量｜完整契約、適用範圍、Javadoc 與權威來源全部原文｜無移除。
ND-05｜重述｜整條移除｜引言保留原共通錨點，既有共同驗收保持原文｜移除純引用句與 TODO 追蹤禁止模糊標記句，全部承接 rules/coding/code-design.md#nd-05；JSON 逐筆登錄共通完整原句。
ND-06｜否｜保留增量｜改名搬移、動態引用、相容遷移、文件驗證與 IDE 限制全部原文｜無移除。
ND-07｜增量｜保留增量｜共通政策引用及 Java 命名、Javadoc、範例與支援版本驗證全部原文｜無移除。
覆蓋不直接而保留：ND-02 的「Java 的 Service、Handler、Helper、Utils 可使用，但名稱須有明確責任且與行為一致」；共通 naming 的具體名稱主要針對變數，未直接承接類別後綴責任限制，因此連純引用句也保留，reason 已保留「整理前原文未提交，無法證明完整覆蓋」。除這項既定待補證外，無其他未把握判斷。
協調者收尾：本主題無第三節判為驗收入口條文；ND-04 已確認的 Javadoc 驗收完整保留；docs/pending-decisions.md:139-141、214-217、324 的條號與分組連結需改為新小節（ND-05 改共通錨點），docs/java-rule-migration.md:170-176 的現行去向需統一更新並保留歷史追溯。舊分組錨點仍存在，未造成斷鏈；未改其他檔案。
作業規則無衝突，未遇工具診斷卡關；未新增義務、未推送、未建立 PR。

## [status] states-and-results 逐條處理與協調事項

- from: term_f05badaf-c66c-45db-961d-06afe0c1d2f1
- at: 2026-11-09T07:46:30Z
- payload: {"taskId":"task_3c45385167dc","dispatchId":"ctx_dfc5e31c51f1"}

提交：76de923c2913cf2c1c6910a8a8b7bcd1aa69bb43；僅修改指定 Markdown 與 JSON，狀態 completed，28 句登錄為保留 22 句、移除 6 句。
逐條處理表（歷史 ID｜判斷｜種類｜保留／移除與承接）：
ST-01｜是、選 B｜整條保留｜互斥型別、enum、布林禁止及獨立業務面向全部原文；無移除。
ST-02｜重述｜整條保留｜必要資料及不得只靠狀態碼與多可空欄位全部原文；無移除。
ST-03｜重述｜整條保留｜setter 禁止繞過及既有／新物件由模型決定全部原文；無移除。
ST-04｜重述｜整條移除｜原共通引用改保留於檔頭；結果區別、資料及不要求複雜物件由 rules/coding/domain-modeling.md#st-04 原句承接。
ST-05｜重述｜整條保留｜失敗型別、具型別原因代碼、技術故障例外及不得混入業務失敗全部原文；無移除。
ST-06｜重述｜整條移除｜原引用留檔頭；編譯檢查、測試審查補足及 default 不得當成功由 domain-modeling.md#st-06 兩句承接。
ST-07｜可能｜整條保留｜外部代碼映射、ordinal、名稱相容性、未知代碼及轉換類別全部原文；無移除。
ST-08｜增量｜保留增量｜sealed 與其他版本的可見性、建立入口、檢查全部原文及共同引用；無移除。
ST-09｜重述｜整條移除｜原引用留檔頭；可變參考與必要資料隔離、不要求完整複製由 domain-modeling.md#st-09 兩句承接。
ST-10｜驗收入口｜整條保留｜型別、分支、enum、封閉模型及實際副作用全部原文，交協調者決定。
保守保留與不確定處：ST-02 共通條文帶不同狀態需要不同資料的條件，未直接寫不得只用狀態碼與多可空欄位讓使用端推測；ST-03 共通未直接明訂修改既有或產生新物件由模型決定；ST-05 共通未直接列不同失敗型別或具型別原因代碼選擇，且技術故障例外句有非預期限定，故三條均不刪。三條 reason 已保留整理前原文未提交、無法證明完整覆蓋的限制文字。
協調事項：pending-decisions.md 第 72–79、180–181、313–315、344 行仍用舊條號與分組連結，須統一改現行連結；java-rule-migration.md 第 69–78 行需同步現行去向與原第幾條標籤。ST-10 所稱下方表格不含使用端分支及封閉模型的問題依 L2 留交協調者，未改寫。
作業說明無衝突或不明卡關；第一次檢查指出同條移除理由重複，已將純引用句與實質斷言分別寫理由後通過，未改工具。已人工逐句對照 350668e，七條保留正文、尾段及驗收內容不變，三條移除斷言逐筆有共通完整原句證據。
提交後常駐檢查 exit 0（153 IDs、15 文件、completed 2／pending 13、86 驗收列）；範圍檢查 exit 0；兩個基準的 diff --check exit 0；diff --stat 僅指定兩檔，git status --short 空白。負向測試首輪已通過，正於提交後重跑以附精確案例數。

## [status] 相等性雜湊與排序：逐條處理及協調事項

- from: term_153ffd1a-a2b3-484b-82b8-7eaf877e4f73
- at: 2026-11-09T07:46:32Z
- payload: {"taskId":"task_9f60efeb8c6c","dispatchId":"ctx_55081e2788da"}

提交：5535796（單一提交，僅指定 Markdown 與 JSON）；JSON 為 completed。
逐條處理（未註明刪除者均逐字保留全文，只換小標題／錨點）：
| 歷史 ID | 待決判斷 | 去向 | 保留／刪除 |
| EQ-01 | 增量 | 保留增量 | 共通引用、equals 落實比較語意及不得任意比較 Entity 全欄位全部保留 |
| EQ-02 | 是 | 整條保留 | equals 關係、null 與 hashCode 全部保留 |
| EQ-03 | 是 | 整條保留 | 集合內穩定、不可變鍵及移出修改重加全部保留 |
| EQ-04 | 混合 | 拆分 | 保留共通連結與無跨實例需求不強制覆寫 equals；刪「識別碼變化不得破壞雜湊或排序集合契約」，承接 rules/coding/domain-modeling.md#eq-04 |
| EQ-05 | 是 | 整條保留 | 跨型別範圍、對稱遞移、擴充限制及 instanceof/getClass 全部保留 |
| EQ-06 | 可能 | 整條保留 | Comparable/Comparator、自然／情境排序及欄位方向同值處理全部保留 |
| EQ-07 | 是 | 整條保留 | 比較關係、同次依據穩定、不得溢位或失精度相減全部保留 |
| EQ-08 | 否 | 保留增量 | 比較為零、equals、不得合併資料及 TreeSet/TreeMap 案例全部保留 |
| EQ-09 | 是 | 整條保留 | 排序穩定、移出重加／重建及比較器變更資料檢查全部保留 |
| EQ-10 | 否 | 保留增量 | 關係與集合驗收全部保留；非驗收入口分類，不轉入口 |
EQ-04 逐字承接原文：建立時即具備穩定識別碼，或持久化後才取得識別碼，須各自明訂適用規則與使用限制；識別碼變化不得破壞集合契約。
涵蓋不足／不確定：六條強制保留依既定決策，不另抽共同背景；沒有額外的保守保留例外或未決判斷。EQ-04 共通的集合契約涵蓋 Java 所列兩種集合，依第三節混合判斷拆去該子句；已登錄完整來源，供獨立語意複核。
協調者事項：沒有整條保留待決定的驗收入口；docs/pending-decisions.md:96–97、185–192 的歷史條號與分組定位，及 docs/java-rule-migration.md:98–107 的「原第 N 條及驗收表」可依本 JSON 更新現行錨點，歷史文字保留策略由協調者決定；現有驗收錨點全保留，acceptance-cleanup-batch-1.md 連結不需修改。共通歷史 eq-01／eq-04 錨點依指南留待後續批次改名。
作業說明與任務無衝突，沒有卡住或無法解讀的診斷，未改工具／共通檔／他人紀錄。十條已與 git show 350668e 的基準逐條比較，僅 EQ-04 登錄子句不同；驗收第二欄未減少，「依第 10 條」只換錨點。


## [status] types-and-generics 逐條完成報告與保守保留事項

- from: term_fdfa2648-9f28-45f9-a6d9-b51345f22e7b
- at: 2026-11-09T07:46:38Z
- payload: {"taskId":"task_e97b53375a69","dispatchId":"ctx_a776cbff5b6d"}

提交：47c65b6769a24a6f6a188954092689553f14e055；僅指定兩檔，JSON completed，34 個來源單位均保留，無改寫或移除斷言。

逐條處理表（所有條文「移除內容／承接共通錨點」均為「無／不適用」）：
| 歷史 ID | 判斷 | 去向種類 | 保留內容 |
| JT-01 | 否 | 保留增量 | 各宣告位置、泛型資訊、禁用 var 全文 |
| JT-02 | 否 | 保留增量 | raw type 禁令、Object／萬用字元與泛型抽象界線全文 |
| JT-03 | 重述 | 整條保留 | 整份型別安全引用、泛型簽章實際連結輸入輸出、特定業務型別及呼叫端不補轉型全文 |
| JT-04 | 否 | 保留增量 | 向下轉型禁令、邊界驗證、例外及數值轉換界線全文 |
| JT-05 | 否 | 保留增量 | raw／unchecked 警告、禁止抑制檢查、例外核准紀錄全文 |
| JT-06 | 重述 | 整條保留 | 整份型別安全引用、固定欄位 Map／Object[] 禁令、動態映射鍵值型別全文 |
| JT-07 | 否 | 保留增量 | 泛型能力與約束、禁止猜測轉型及不額外建立介面全文 |
| JT-08 | 否 | 保留增量 | 集合宣告介面與實作選擇、可修改性及排序契約全文 |
| JT-09 | 否 | 保留增量 | 完整宣告前提及建構端菱形運算子界線全文 |
| JT-10 | 否 | 保留增量 | 明確回傳、萬用字元上下界必要性及不可變性限制全文 |
| JT-11 | 否 | 保留增量 | 泛型命名用途關聯、短名稱及複雜角色與說明全文 |

保守保留及不確定判斷：
JT-03「Java 泛型簽章須實際連結輸入與輸出的型別；特定業務操作直接使用其型別，不要求呼叫端轉型補回。」共通 rules/coding/type-safety.md#容器與泛型 的原句為「泛型必須表達真實型別關係，或搭配實際的解析與驗證機制。」及「例如容器限制元素型別，或方法連結輸入與輸出的型別。」共通另有禁止無保證泛型結果，但對 Java 簽章必須連結與業務操作不得要求呼叫端補轉型，未能確認逐句直接涵蓋，故保留。
JT-06「例如固定欄位資料不得改以 `Map<String, Object>` 或 `Object[]` 承載；真正動態的映射仍須保留明確鍵值型別。」共通原句「固定結構資料必須使用明確資料型別，不得以任意鍵值容器代替。」與「真正動態的鍵值資料可以使用 Dictionary／Map，但鍵和值的型別都必須明確。」可支持 Map 及動態鍵值，但 Object[] 陣列不是直接明列的任意鍵值容器，是否直接涵蓋仍有疑慮，故整條保留。
兩條 rules.reason 均已保留「整理前原文未提交，無法證明完整覆蓋」，句子 reason 亦記錄具體原因；不是宣稱已還原更早遺失原文。

協調者事項：本份無驗收入口條文；請複核 JT-03／06 的保守保留。docs/pending-decisions.md 第 58、59、161–169、306、307 行的歷史條號顯示與分組連結可更新為 JSON 語意小節；docs/java-rule-migration.md 第 36–46 行仍是原條號及驗收入口連結，亦需統一更新（其中 JT-03／06 原改引用狀態與此次保守保留需調和）。原分組與驗收錨點仍保留，沒有製造失效連結；其他 Java 檔均是整份連結，不需修改。歷史分類、審閱與驗收追溯報告未動。
作業說明無衝突或不清楚的阻塞，未遇工具拒絕；沒有擴充工具、白名單或改共用檔。驗收第二欄及非表格內容全數逐字保留，分組中間尾段、範例與最後尾段依原順序集中於 java-closing-requirements。


## [status] numbers-dates-text 逐條處理與人工複核回報

- from: term_46110884-4f05-44c8-8d04-91512df59a48
- at: 2026-11-09T07:46:47Z
- payload: {"taskId":"task_9b5bbe062772","dispatchId":"ctx_b530e8d4096c"}

提交：41eefe5e6a8e3bb8680de9fce277a22e60094964；唯一提交且僅指定兩檔，JSON completed。
逐條處理表（「全留」表示全部原句含既有引用逐字保留、無移除；共通錨點位於 rules/coding/numbers-dates-text.md）：
歷史 ID | 待決判斷 | 種類 | 保留／移除與承接
NT-01 | 增量 | 保留增量 | 全留 BigDecimal／最小單位整數選擇與浮點禁止
NT-02 | 增量 | 保留增量 | 全留精確來源、浮點轉 BigDecimal 限制與業務驗證
NT-03 | 重述 | 整條保留 | 全留精度、捨入、時機及禁止 API 預設或呼叫端決定
NT-04 | 重述 | 整條移除 | 移除引用句與縮窄轉型／溢位回繞／小數捨棄檢查、強制轉型不得掩蓋超限；承接 #nt-04 前兩句，引用入口留檔頭
NT-05 | 否 | 保留增量 | 全留 BigDecimal 判同、小數位數、1.0／1.00、正規化與相等雜湊排序一致
NT-06 | 增量 | 保留增量 | 全留 java.time／LocalDate／Instant／LocalDateTime 選擇與限制
NT-07 | 重述 | 整條移除 | 移除引用句與明確時區偏移、不得讓函式庫決定不存在或重複當地時間處置；承接 #nt-07 兩句，引用入口留檔頭
NT-08 | 增量 | 保留增量 | 全留 Duration／Period／業務計算及營業日限制
NT-09 | 增量 | 保留增量 | 全留 Clock 與單調時間來源
NT-10 | 重述 | 整條保留 | 全留格式、地區、時區偏移、精度與禁止寬鬆修正／前段解析
NT-11 | 重述 | 整條移除 | 移除引用句與明確編碼、禁止系統預設及未授權替換掩蓋損失；承接 #nt-11 前兩句，引用入口留檔頭
NT-12 | 增量 | 保留增量 | 全留 String.length()／UTF-16、代理對及字元組合限制
NT-13 | 重述 | 整條移除 | 移除引用句與比較／大小寫／正規化的地區用途及預設限制；承接 #nt-13 第一、第三句，引用入口留檔頭
NT-14 | 驗收入口 | 整條保留 | 全留共同引用及 BigDecimal、java.time、Clock、字串實際路徑的下方表格驗收要求

涵蓋不直接及猶豫判斷：NT-03「Java 數值運算依契約指定精度、捨入模式及時機，不能讓 API 預設或各呼叫端自行決定。」對照共通 nt-03 以「可能損失精度的運算」為條件且同節未直接列 API 預設；未將跨引言推論當完整證據，整條留原文。NT-10「Java 解析及格式化須明訂格式、地區、時區／偏移及精度，不允許寬鬆修正非法日期或只解析前段。」對照共通 nt-10「必要的地區設定」，無法確認範圍完全一致，整條留原文；這兩項已寫 rules 與 sentences reason。

協調者事項：NT-14 按作業說明保留，需決定是否改驗收入口；既有 L2 指出 java.time 與字串案例不全有 Java 表獨立列，這次未擅改「依下方表格驗收」。更新 docs/pending-decisions.md:109–121、200、346 的舊條號標籤／分組去向，以及 docs/java-rule-migration.md:126–139 的「原第 N 條及驗收表」現行對照；既有分組與驗收錨點都保留，沒有製造失效連結。歷史分類與驗收追溯文件維持原狀，由協調者依歷史用途決定是否更新；共用驗證紀錄需合併後統一重生。

作業規則無衝突；第六節沒有 NT 對應列，特別注意事項表亦無本檔列。沒有工具診斷卡關，也未修改工具或共用文件。逐句重新對照 git show 350668e 的全文：十條保留正文逐字相同、四條移除的每個子句有共通完整原句證據；驗收只改表頭與兩列第一欄，第二欄及全部非表格內容逐字相同。提交前常駐檢查、重整負向測試、政策負向測試、工作者範圍負向測試、範圍檢查、diff 檢查均 exit 0；提交後驗收重跑結果另續報。


## [status] 提交後驗收全部通過

- from: term_153ffd1a-a2b3-484b-82b8-7eaf877e4f73
- at: 2026-11-09T07:46:48Z
- payload: {"taskId":"task_9f60efeb8c6c","dispatchId":"ctx_55081e2788da"}

提交 5535796e536a3889c607c455c344a4b0cb13a80c。提交後 verify-body-restructuring.rb 結束碼 0（153 歷史 ID、15 文件、2 completed、13 pending、86 驗收列、重複 Java 驗收列 0）；test-body-restructuring.rb 結束碼 0，76/76 案例符合預期；test-body-policy.rb 結束碼 0，40/40 案例符合預期。verify-body-worker-scope.rb 使用指定 start 與 expected-start 7b2667c72d2163a5be9e782dec13946ed7590e90，結束碼 0，工作者範圍通過。git diff --check 指定起點..HEAD 結束碼 0、無輸出；git status --short 結束碼 0、無輸出。git diff --stat 僅列指定 JSON 與 Markdown，2 files changed、328 insertions、77 deletions。另依指南執行 test-body-worker-scope.rb 結束碼 0，6/6 案例符合預期；逐句比對十條均通過，唯一差異是已登錄的 EQ-04 子句。

## [status] types-and-generics 實際驗收結果

- from: term_fdfa2648-9f28-45f9-a6d9-b51345f22e7b
- at: 2026-11-09T07:46:50Z
- payload: {"taskId":"task_e97b53375a69","dispatchId":"ctx_a776cbff5b6d"}

提交後實際結果：ruby scripts/verify-body-restructuring.rb 結束碼 0；ruby scripts/test-body-restructuring.rb 結束碼 0，76 案全數 matched=true；ruby scripts/test-body-policy.rb 結束碼 0，40 案全數 matched=true；ruby scripts/verify-body-worker-scope.rb --topic types-and-generics --start 7b2667c72d2163a5be9e782dec13946ed7590e90 --expected-start 7b2667c72d2163a5be9e782dec13946ed7590e90 結束碼 0，工作者範圍通過；git diff --check 7b2667c72d2163a5be9e782dec13946ed7590e90..HEAD 無輸出且結束碼 0；git status --short 無輸出。git diff --stat 起點..HEAD 僅 types-and-generics.json（324 行異動）與 types-and-generics.md（93 行異動），合計 330 insertions、87 deletions；另依作業說明執行 test-body-worker-scope.rb，結束碼 0，6 案全通過。逐句人工比對基準並另以 Ruby 核對，11 條全文與 34 個來源單位逐字保留；詳細處理表已在 msg_e68eb0119222。

## [worker_done] states-and-results 已完成並提交 76de923

- from: term_f05badaf-c66c-45db-961d-06afe0c1d2f1
- at: 2026-11-09T07:46:52Z
- payload: {"taskId":"task_3c45385167dc","dispatchId":"ctx_dfc5e31c51f1","outcome":"succeeded","filesModified":["rules/stacks/java/common/states-and-results.md","docs/body-restructuring/java/states-and-results.json"]}

已完成指定兩檔並提交 76de923c2913cf2c1c6910a8a8b7bcd1aa69bb43，逐條處理表與保守判斷已送於 msg_540d466f9225，JSON 為 completed。ST-04／06／09 移除並附共通承接證據，其餘七條保留；提交後常駐、範圍與 diff 檢查皆 exit 0，負向測試 76／76、政策測試 40／40、範圍測試 6／6 全數符合預期，僅指定兩檔異動且工作區乾淨。剩餘由協調者複核 ST-02／03／05 的保守保留、決定 ST-10 驗收入口，以及統一更新 pending-decisions 與 java-rule-migration 的舊條號連結。

## [status] naming-packages-docs 驗證實際結果

- from: term_0abe793f-c9cd-405e-ab67-c4053e230a8d
- at: 2026-11-09T07:46:54Z
- payload: {"taskId":"task_5a98a79f6874","dispatchId":"ctx_465509371093"}

提交後實際結果：ruby scripts/verify-body-restructuring.rb 結束碼 0（153 歷史 ID、86 驗收列，完成 2 份）；ruby scripts/test-body-restructuring.rb 結束碼 0（76 案例全部診斷匹配）；ruby scripts/test-body-policy.rb 結束碼 0（40 案例全部診斷匹配）；ruby scripts/verify-body-worker-scope.rb --topic naming-packages-docs --start 7b2667c72d2163a5be9e782dec13946ed7590e90 --expected-start 7b2667c72d2163a5be9e782dec13946ed7590e90 結束碼 0（工作者範圍通過）；git diff --check 7b2667c72d2163a5be9e782dec13946ed7590e90..HEAD 結束碼 0、無輸出；git status --short 結束碼 0、無輸出。git diff --stat 起點..HEAD 只列指定 JSON 與 Markdown，合計 281 插入、66 刪除；另跑 test-body-worker-scope.rb 六案例全部匹配，以及基準 350668e..HEAD diff --check 通過。逐句人工檢查及六條保留正文逐字比對皆完成；JSON completed 且無尚未整理理由，最後收信無待處理訊息。

## [worker_done] 完成 naming-packages-docs：8f4fad8

- from: term_0abe793f-c9cd-405e-ab67-c4053e230a8d
- at: 2026-11-09T07:46:54Z
- payload: {"taskId":"task_5a98a79f6874","dispatchId":"ctx_465509371093","outcome":"succeeded","filesModified":["rules/stacks/java/common/naming-packages-docs.md","docs/body-restructuring/java/naming-packages-docs.json"]}

已完成命名套件文件正文與逐句 JSON 紀錄，僅提交指定兩檔，提交為 8f4fad87fb9f1fc1e80009e88eb676ca61cb5b07。ND-05 由共通 nd-05 完整承接而移除，其餘六條原文及全部驗收保留，提交後指定檢查全部通過且工作區乾淨。剩餘由協調者複核 ND-02 既定待補證與更新共用對照文件的現行定位，逐條處理表及測試結果已另以 status 訊息送達。

## [status] classes-and-construction 完整處理表與複核事項

- from: term_c2faf634-e2df-4922-83a7-05a3e326fe97
- at: 2026-11-09T07:46:55Z
- payload: {"taskId":"task_cadbf19503ab","dispatchId":"ctx_8f000fc52e0e"}

提交：b0eef5d24cbd4457d3955ad26dd105eb67953d0a；唯一修改為指定 Markdown 與 JSON，status=completed。
逐條處理表（「移除」均含原純引用句，引用目標已逐一保留於檔頭）：
| 歷史 ID | 待決判斷 | 去向種類 | 保留／移除與承接 |
| CL-01 | 重述 | 整條保留 | 全文保留至 #java-interface-purpose；無刪除 |
| CL-02 | 重述 | 整條移除 | 父型別輸入、結果、行為與優先組合委派由 rules/coding/code-design.md#cl-02 承接 |
| CL-03 | 重述 | 整條移除 | 必要資料依賴、建構子不必外部連線或啟動背景工作、明確生命週期由 rules/coding/resource-lifecycle.md#cl-03 承接 |
| CL-04 | 是 | 整條保留 | this 外洩、可覆寫方法禁令及啟動就緒條件逐字留至 #java-construction-safety；無刪除 |
| CL-05 | 重述 | 整條保留 | 明確依賴、延後或按次建立、禁止隱藏全域查找逐字留至 #java-explicit-dependencies；無刪除 |
| CL-06 | 重述 | 整條移除 | 建構子、具名工廠與 Builder 選擇、暫存組裝資料及不得產出無效物件由 rules/coding/code-design.md#cl-06 承接 |
| CL-07 | 可能 | 整條保留 | 擴充範圍、super 檢查與 final／代理相容逐字留至 #java-override-scope；無刪除 |
| CL-08 | 重述 | 整條移除 | 不機械拆單一方法、同責任共用契約、執行期授權另檢由 rules/coding/code-design.md#cl-08 承接 |
| CL-09 | 重述 | 整條移除 | 使用者訂單實例欄位隔離及框架注入不保證安全生命週期由 rules/coding/resource-lifecycle.md#cl-09 承接 |
| CL-10 | 重述 | 整條保留 | 建構、繼承、覆寫及框架代理實際路徑與值物件免完整框架逐字留至 #java-lifecycle-verification；無刪除 |
保守判斷與不確定處：CL-01「Java 可依契約依賴介面或具體類別；單一實作不構成省略必要架構隔離的理由。」需合讀架構邊界，無直接明列單一實作例外否定；另保留「整理前原文未提交，無法證明完整覆蓋」限制。CL-05「需要延後或按次建立時使用工廠或提供者」較共通「可注入」明確，因此沒有以可選語氣取代要求。CL-10「Java 建構、繼承、覆寫及框架代理須驗證實際路徑」較共通建立條件、替代契約、實際框架配置明列更多路徑，因此整句及整條留下；以上三條請複核保守處置。
協調事項：本主題沒有判斷為「驗收入口」的條文；CL-10 是重述分類，保留係承接不直接。請統一更新 docs/pending-decisions.md:88–95、183–184、321 的舊條號／分組連結及 docs/java-rule-migration.md:88–97 的「原第 N 條及驗收表」連結標籤／現行去向；分組與驗收錨點仍存在，沒有破壞連結，歷史追溯保留原意。沒有改動其他檔案，無新 schema、Notion 寫入、推送或 PR。
卡關紀錄：第一次常駐檢查報「同條改寫／移除理由重複 CL-02」，已將純引用句與政策句理由分開；未改工具或白名單，沒有未解診斷或作業規則衝突。
人工逐句對照：26 個來源句，16 句保留、10 句移除；17 筆被刪子句逐一附共通完整原句。五條保留正文與 350668e 原文完全相同，所有分組、尾段、共同連結及驗收第二欄保留。
提交前檢查：verify-body-restructuring、test-body-restructuring、test-body-policy、test-body-worker-scope 均 exit 0；範圍檢查及 diff --check 通過。提交後範圍檢查通過，git diff --check 起點..HEAD 無輸出，git status --short 空白，stat 僅兩檔（396 insertions、104 deletions）；提交後三組核心檢查正在完成，結果將隨 worker_done 回報。


## [status] reflection-and-suppression 逐條整理報告

- from: term_380233dd-9d78-4766-a42b-532fe28af531
- at: 2026-11-09T07:46:57Z
- payload: {"taskId":"task_751da9424384","dispatchId":"ctx_e2cb626a75cb"}

提交：01897759ef844989ac9bf43e57d1061aa3e664e1；僅修改指派的 Markdown 與 JSON，status=completed。
逐條處理表（歷史 ID｜待決判斷｜去向種類｜保留｜移除及共通承接）：
RF-01｜第四節否｜保留增量｜明確需求、靜態型別契約、集中責任與動態名稱／未知物件限制全部原文｜無。
RF-02｜重述｜整條移除｜原共通錨點在引言保留｜純引用句及受控目標、型別符合仍須授權，承接 rules/quality/security.md#rf-02 的兩個完整原句。
RF-03｜第四節否｜保留增量｜封裝、不變條件、特殊存取核准與私有欄位例子全部原文｜無。
RF-04｜重述｜整條移除｜原共通錨點在引言保留｜純引用句及能力／版本／型別、不得只憑名稱與未驗證轉型，承接 rules/coding/type-safety.md#rf-04 的前兩個完整原句。
RF-05｜混合｜拆分｜原共通引用句及 Java 反射或動態呼叫的外層例外須保留原始原因｜移除「不能據此推定目標未執行而替換或重跑」，承接 rules/coding/error-handling.md#rf-05 第二句。
RF-06｜混合｜拆分｜Java SuppressWarnings 與 raw type／unchecked 操作句完整原文｜僅移除純引用句，在引言保留 rules/workflow/rule-governance.md#rf-06，去向同時列 Java 小節與共通錨點。
RF-07｜驗收入口｜整條保留｜來源／設定重建、手寫銜接完整型別檢查、重建後確認例外範圍及引用句全部原文｜無，交協調者決定。
RF-08｜驗收入口｜整條保留｜實際反射、存取與重新產生路徑、不能只確認警告消失或成功執行及引用句全部原文｜無，交協調者決定。
保守處理與疑慮：RF-06 共通沒有直接點名 SuppressWarnings 與 raw type／unchecked 禁令，抽掉最小範圍要求還會留下失去謂語的 Java 主詞，因此整句留下，未新造句式；理由已登錄 JSON。除此之外沒有未決的覆蓋疑慮。基準 24 句逐句核對，18 句保留、5 句移除、1 句改寫，所有移除子句均登錄共通完整原句，驗收第二欄與非表格文字逐字保留。
協調者後續：RF-07、RF-08 整條保留待決；docs/pending-decisions.md 第 133–138、212–213 行的舊條號及分組定位、docs/java-rule-migration.md 第 162–169 行的原第幾條及驗收表定位需統一更新，既有分組與驗收錨點未破壞；docs/acceptance-cleanup-batch-1.md 的歷史 ID 及驗收錨點仍有效，不需改其歷史資料。未發現其他問題。
作業說明無衝突或不清楚之處；初次檢查拒絕 RF-02 同條理由重複，已將 RF-02／RF-04 純引用句與實質斷言分別寫明理由，未修改工具。提交前常駐檢查、正文負向測試、政策負向測試、工作者範圍負向測試均 exit 0；提交後常駐與範圍檢查已 exit 0，兩組負向測試正在重跑，完成後另報。git diff --check 與起點..HEAD 檢查通過，git status --short 空白，diff --stat 只有指定兩檔（296 insertions、84 deletions）。

## [worker_done] 完成 equality-hashing-ordering：5535796

- from: term_153ffd1a-a2b3-484b-82b8-7eaf877e4f73
- at: 2026-11-09T07:46:59Z
- payload: {"taskId":"task_9f60efeb8c6c","dispatchId":"ctx_55081e2788da","outcome":"succeeded","filesModified":["rules/stacks/java/common/equality-hashing-ordering.md","docs/body-restructuring/java/equality-hashing-ordering.json"]}

已完成指定兩檔的十條語意錨點、逐句紀錄及驗收定位整理，單一提交為 5535796e536a3889c607c455c344a4b0cb13a80c。唯一刪除為 EQ-04 已由共通 eq-04 明文承接的集合契約子句，其餘正文與驗收要求完整保留，提交後所有指定檢查通過且工作區乾淨。逐條處理表與實際測試結果已由前兩封 status 回報，剩餘僅協調者更新共用追溯文件的舊條號定位並進行獨立複核。

## [worker_done] types-and-generics 完成：47c65b6

- from: term_fdfa2648-9f28-45f9-a6d9-b51345f22e7b
- at: 2026-11-09T07:47:02Z
- payload: {"taskId":"task_e97b53375a69","dispatchId":"ctx_a776cbff5b6d","outcome":"succeeded","filesModified":["rules/stacks/java/common/types-and-generics.md","docs/body-restructuring/java/types-and-generics.json"]}

已完成 types-and-generics 的語意小標題、補充要求與逐句紀錄，僅修改指定兩檔並提交 47c65b6769a24a6f6a188954092689553f14e055。全部指定驗收與額外範圍負向測試通過，34 個來源單位及驗收內容逐字保留，JT-03／06 因承接不夠直接而整條保留。後續請協調者複核上述兩條及統一更新待決清單與遷移對照連結，逐條處理表、理由及實際指令結果已送達 msg_e68eb0119222 與 msg_8be37baa85bc。

## [worker_done] numbers-dates-text 已完成並通過驗收

- from: term_46110884-4f05-44c8-8d04-91512df59a48
- at: 2026-11-09T07:47:08Z
- payload: {"taskId":"task_9b5bbe062772","dispatchId":"ctx_b530e8d4096c","outcome":"succeeded","filesModified":["rules/stacks/java/common/numbers-dates-text.md","docs/body-restructuring/java/numbers-dates-text.json"]}

已完成 numbers-dates-text 的正文與逐句紀錄並建立唯一提交 41eefe5e6a8e3bb8680de9fce277a22e60094964，僅修改指定兩檔且 JSON 為 completed，逐條處理表與承接證據說明已送於 msg_534a1a93e05c。提交後 verify-body-restructuring 為 exit 0、test-body-restructuring 的 76 案與 test-body-policy 的 40 案全部符合預期且 exit 0、指定起點的 verify-body-worker-scope 與 git diff --check 均 exit 0、git status --short 為空且 exit 0、diff --stat 僅兩檔共 453 增行與 126 刪行，另提交前 test-body-worker-scope 六案全部通過。剩餘由協調者複核保守保留 NT-03 與 NT-10 的範圍差異、決定整條保留的 NT-14 驗收入口及更新共用舊條號對照連結，本份指定工作無未完成條文且無工具卡關。

## [worker_done] classes-and-construction 整理與驗證完成

- from: term_c2faf634-e2df-4922-83a7-05a3e326fe97
- at: 2026-11-09T07:47:11Z
- payload: {"taskId":"task_cadbf19503ab","dispatchId":"ctx_8f000fc52e0e","outcome":"succeeded","filesModified":["rules/stacks/java/common/classes-and-construction.md","docs/body-restructuring/java/classes-and-construction.json"]}

已僅修改指定兩檔並提交 b0eef5d24cbd4457d3955ad26dd105eb67953d0a，五條重述移交共通、五條逐字保留，完整逐條處理表已送於 msg_accc55cfdd6e。提交後 verify-body-restructuring、test-body-restructuring（76 案例）、test-body-policy（40 案例）、指定起點範圍檢查及 diff 檢查全部 exit 0，負向案例 matched 全為 true，git status 為空且 stat 僅兩檔，另 test-body-worker-scope 六案例通過。剩餘由協調者複核 CL-01、CL-05、CL-10 的保守保留理由並統一更新待決清單與遷移表舊條號連結，本工作無未完成項目或未解診斷。

## [worker_done] reflection-and-suppression 完成並通過驗證

- from: term_380233dd-9d78-4766-a42b-532fe28af531
- at: 2026-11-09T07:47:24Z
- payload: {"taskId":"task_751da9424384","dispatchId":"ctx_e2cb626a75cb","outcome":"succeeded","filesModified":["rules/stacks/java/common/reflection-and-suppression.md","docs/body-restructuring/java/reflection-and-suppression.json"]}

已完成 reflection-and-suppression 正文與逐句承接紀錄，僅修改指派兩檔並提交 01897759ef844989ac9bf43e57d1061aa3e664e1，逐條處理表及完整疑義已於 msg_b9e47cf3eec3 回報。提交後 verify-body-restructuring、test-body-restructuring（76 案例）、test-body-policy（40 案例）、指定起點 verify-body-worker-scope 與 git diff --check 起點..HEAD 全部 exit 0，所有測試 matched=true，額外 test-body-worker-scope 的 6 案例亦通過，git status --short 空白且 diff --stat 只有兩檔。剩餘由協調者複核 RF-06 保守原文、決定 RF-07／RF-08 驗收入口及統一更新 pending-decisions 與 java-rule-migration 的舊條號定位，本任務沒有未完成條文。
