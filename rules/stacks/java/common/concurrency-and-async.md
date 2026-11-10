# Java 併發與非同步處理

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[錯誤處理](../../../coding/error-handling.md)與[效能與資源使用](../../../quality/performance.md)，定義 Java 併發工作的所有權、同步、結果及生命週期。中斷與資源清理另依[例外與資源管理](exceptions-and-resources.md)，具體 API 須符合[版本要求](version-policy.md)。

## 工作所有權與執行資源

本組由共通規範承接的要求：[明確的工作擁有者](../../../coding/concurrency-and-async.md#task-ownership)、[結果接收與故障處置](../../../coding/concurrency-and-async.md#async-result-reception)。

<a id="java-execution-resources"></a>

### 統一管理執行資源

依[統一管理執行資源的共通要求](../../../coding/concurrency-and-async.md#execution-resources)執行。Java 可用明確提供的 `Executor`、`ExecutorService` 或框架提交工作；虛擬執行緒也須遵守下游容量。

<a id="java-visibility-sharing"></a>

### 可見性與共享資料

跨執行緒資料須透過具備可見性保證的方式交付，優先使用不可變資料或符合契約的隔離快照。需要共享可變狀態時，須明訂同步與原子性範圍，不得以單一 `volatile` 欄位或偶然成功的執行結果推定整個物件安全。

## 期限、取消與結果

<a id="java-deadline-budget"></a>

### 等待期限與逾時處置

依[等待期限與逾時處置的共通要求](../../../coding/concurrency-and-async.md#deadline-budget)執行。Java 非同步等待的逾時不代表底層工作已停止；等待 API 須承接整體時間預算。

<a id="java-cancellation-propagation"></a>

### 取消傳遞與實際停止

依[取消傳遞與實際停止的共通要求](../../../coding/concurrency-and-async.md#cancellation-and-termination)執行。Java 取消訊號及中斷依任務契約傳遞，不把取消最外層 Future 視為全部子工作已停止。

<a id="java-result-reception"></a>

### `Future` 與 `CompletableFuture` 的結果鏈

非同步任務的成功、失敗與取消結果須有明確接收及處置路徑，不得忽略回傳的工作控制物件而遺失故障。`Future`、`CompletableFuture` 等結果須由負責元件處理；結果鏈中的例外轉換須保留原因與分類，只有契約允許的恢復或降級才能轉成替代結果，不得一律以空值或預設值將失敗變為成功。

<a id="java-task-completion"></a>

### 多工作組合的完成條件

依[多工作組合的完成條件的共通要求](../../../coding/concurrency-and-async.md#task-completion-contract)執行。Java 多工作組合須驗證完成順序及剩餘任務處置，第一個完成不等於第一個成功。

## 執行位置、脈絡與同步

<a id="java-execution-location"></a>

### 執行位置與阻塞行為

依[執行位置與阻塞行為的共通要求](../../../coding/concurrency-and-async.md#execution-and-blocking)執行。Java 任務及回呼須明確安排 executor 與阻塞行為，避免占用同一受限 executor 等待其排隊工作。

<a id="java-context-propagation"></a>

### 明確傳遞與清理脈絡

依[明確傳遞與清理脈絡的共通要求](../../../coding/concurrency-and-async.md#context-propagation)執行。Java 不假設 `ThreadLocal` 或日誌脈絡自動沿用；共用執行緒上的脈絡須在結束時清理或還原。

<a id="java-lock-scope"></a>

### 鎖定範圍與取得策略

依[鎖定範圍與取得策略的共通要求](../../../coding/concurrency-and-async.md#lock-scope)執行。Java 同步與鎖的實作須涵蓋全部退出路徑，必要檢查不能為縮短持鎖而移出原子範圍。

## 關閉與驗證

<a id="java-controlled-shutdown"></a>

### 受控關閉

依[受控關閉的共通要求](../../../coding/resource-lifecycle.md#controlled-shutdown)執行。Java 執行元件開始關閉或發出停止要求不代表工作全數結束；實際關閉與資源釋放依共同契約驗證。

<a id="java-controlled-verification"></a>

### 可控制的併發驗收

依[可控制的併發驗收的共通要求](../../../quality/testing.md#controlled-interleaving)執行。Java 測試使用可控制的協調與完成條件，並審查同步／可見性設計，不以固定睡眠或壓力測試單獨證明安全。

<a id="java-closing-requirements"></a>

## 補充要求

共享集合的複合操作另依[集合與資料所有權](collections-and-ownership.md)，元件生命週期依[類別、介面與物件建立](classes-and-construction.md)，平行資料處理依[Lambda 與 Stream](lambda-and-stream.md)。身分及延後執行授權依[安全規範](../../../quality/security.md#授權與資料範圍)，追蹤與故障紀錄依[日誌、稽核與可觀測性](../../../quality/observability.md#診斷日誌與追蹤)。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響及實際使用路徑選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md#層級與案例選擇)與[規範驗證](../../../quality/rule-verification.md#verification-coverage)。

### 共同驗收

- [明確的工作擁有者](../../../coding/concurrency-and-async.md#acceptance-task-ownership)。
- [統一管理執行資源、執行位置與阻塞行為](../../../coding/concurrency-and-async.md#acceptance-execution-resources)。
- [等待期限與逾時處置、取消傳遞與實際停止](../../../coding/concurrency-and-async.md#acceptance-deadline-cancellation)。
- [多工作組合的完成條件](../../../coding/concurrency-and-async.md#acceptance-task-composition)。
- [明確傳遞與清理脈絡](../../../coding/concurrency-and-async.md#acceptance-context-isolation)。
- [鎖定範圍與取得策略](../../../coding/concurrency-and-async.md#acceptance-lock-scope)。
- [受控關閉](../../../coding/resource-lifecycle.md#acceptance-controlled-shutdown)。
- [可控制的併發驗收](../../../quality/testing.md#acceptance-controlled-interleaving)。
- [結果接收與故障處置](../../../coding/concurrency-and-async.md#acceptance-result-reception)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-visibility"></a>[可見性與共享資料](#java-visibility-sharing) | 審查 Java 跨執行緒資料交付的可見性保證、共享資料的同步範圍及適用的鎖定方式；以受控交錯核對不變條件與共享狀態，不能只以單一 `volatile` 欄位或偶然成功推定整個物件安全。 |
| <a id="acceptance-java-task-results"></a>[`Future` 與 `CompletableFuture` 的結果鏈](#java-result-reception) | 沿 Java `Future`／`CompletableFuture` 的實際接收及結果鏈路徑觸發成功、失敗與取消，核對故障可追查、原始原因與分類保留，且未以替代值把失敗變成成功。 |

既有程式碼、框架限制與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行降低要求。
