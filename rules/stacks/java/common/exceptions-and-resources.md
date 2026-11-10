# Java 例外與資源管理

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[錯誤處理](../../../coding/error-handling.md)，定義 Java 例外傳遞、中斷及資源生命週期的共同要求。預期業務失敗依[狀態與結果建模](states-and-results.md)使用明確結果型別；元件建立及延遲讀取的所有權另依[類別、介面與物件建立](classes-and-construction.md)與[集合與資料所有權](collections-and-ownership.md)。

## 例外契約與捕捉責任

<a id="java-exception-classification"></a>

### 明確的故障分類

例外型別須能表達契約所需的故障分類，避免無必要的籠統宣告或拋出，例如一律使用 `throws Exception` 或沒有明確語意的 `RuntimeException`。既有標準或第三方例外足以表達且符合架構隔離時，不強制自訂例外。需要邊界轉換時，須保留原始原因，不改變故障語意，也不將預期業務失敗改用例外表示。

<a id="java-checked-unchecked"></a>

### Checked 與 Unchecked 的選擇

須依故障語意及呼叫端的處理責任選擇，同類契約維持一致慣例。需要呼叫端明確處置或向上宣告的技術故障可使用 Checked Exception；由統一入口處理的故障或程式缺陷，可使用適當的 Unchecked Exception。不得只為省略宣告或捕捉而任意轉換，也不得僅依例外是否受編譯器檢查，就判定能否恢復或重試。

<a id="java-catch-scope"></a>

### 捕捉範圍與處置相符

優先捕捉具體例外並縮小 `try` 範圍，不得將不同來源的故障一律轉成同一業務結果。最外層入口可依責任統一處理尚未處理的例外，但仍須保留分類，不得假裝恢復成功。不得以廣泛捕捉 `Throwable` 或 `Error` 掩蓋嚴重故障並繼續操作。

<a id="java-interruption"></a>

### 保留中斷意圖

`InterruptedException` 須依呼叫契約向上傳遞；無法傳遞而在本層捕捉時，須恢復中斷旗標並停止或依明確取消契約處理。不得吞掉中斷後照常執行或自動重試，必要清理不得掩蓋中斷意圖。

## 資源所有權與失敗清理

本組由共通規範承接的要求：[部分取得與所有權移交](../../../coding/resource-lifecycle.md#partial-acquisition)、[有效期與關閉契約](../../../coding/resource-lifecycle.md#resource-close-contract)。

<a id="java-resource-management"></a>

### 優先使用語言資源管理機制

由目前操作負責關閉且支援 `AutoCloseable` 的資源，優先使用 `try-with-resources`，讓使用範圍與關閉時機對應，涵蓋正常完成及例外退出。借用或框架管理的資源依所有權契約處理，不得擅自關閉。其他生命週期須明訂可靠的釋放方式，不以垃圾回收代替必要的資源管理。

<a id="java-suppressed-failures"></a>

### 保留操作與清理失敗

操作與清理同時失敗時，須保留原始例外及清理例外的關係，不得覆蓋或遺失 suppressed exceptions。使用 `try-with-resources` 時須保留其記錄的清理例外，自行清理時也須維持故障關係。不得以 `finally` 中的 `return` 或其他控制流程掩蓋原結果；單獨發生的清理失敗也須依資源契約判斷完成保證與回報方式，不得默默忽略。

<a id="java-failure-coverage"></a>

### 失敗路徑驗收

例外處理或資源生命週期新增及變更時，須依影響驗證故障分類、原因保留、中斷傳遞與適用的資源釋放路徑，涵蓋部分初始化及清理失敗，並確認所有權與實際使用期間一致，不僅驗證成功流程。涉及框架管理的生命週期時須驗證實際配置，不能只靠替身推定正確；不要求每個方法套用全部情境。

<a id="java-closing-requirements"></a>

## 補充要求

故障日誌與對外回應仍須遵守[日誌、稽核與可觀測性](../../../quality/observability.md)及[資料契約](../../../interfaces/data-contracts.md)，不因保留例外原因而直接對外揭露內部資訊。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響及實際使用路徑選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。

### 共同驗收

- [部分取得與所有權移交](../../../coding/resource-lifecycle.md#acceptance-partial-acquisition)。
- [有效期與關閉契約](../../../coding/resource-lifecycle.md#acceptance-close-contract)。

### Java 語言增量驗收

<a id="acceptance-java-failure-coverage"></a>

依[失敗路徑驗收](#java-failure-coverage)核對本次案例涵蓋受影響的 Java 故障、中斷、部分初始化與清理路徑；依賴框架的保證須經實際生命週期驗證，不只測替身或成功流程。

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-exception-contract"></a>[明確的故障分類](#java-exception-classification)、[Checked 與 Unchecked 的選擇](#java-checked-unchecked)、[捕捉範圍與處置相符](#java-catch-scope) | 核對 Java 例外型別、Checked／Unchecked 宣告、邊界轉換及 `try`／捕捉範圍與處置責任一致；以適用故障來源驗證業務失敗、技術故障與程式缺陷沒有混淆，包裝後仍保留原始原因。 |
| <a id="acceptance-java-interruption"></a>[保留中斷意圖](#java-interruption) | 對可中斷的 Java 操作送出中斷，確認 `InterruptedException` 依契約向上傳遞；無法傳遞時恢復中斷旗標並停止或取消。核對沒有吞掉後繼續等待、執行或重試，必要清理仍完成。 |
| <a id="acceptance-java-resource-closing"></a>[優先使用語言資源管理機制](#java-resource-management) | 以正常完成、提前退出及操作失敗路徑核對 Java 自行擁有的 `AutoCloseable`／`try-with-resources` 資源確實釋放，借用或框架管理資源未被擅自關閉；非區域生命週期有明確釋放責任，不依賴垃圾回收。 |
| <a id="acceptance-java-suppressed-failures"></a>[保留操作與清理失敗](#java-suppressed-failures) | 模擬 Java 操作與清理同時失敗，確認原始故障及 suppressed exceptions 或相應關係可追查，沒有被 `finally` 控制流程覆蓋；另驗證只有清理失敗時的完成判定與回報。 |

既有程式碼、工具限制與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行放寬要求。
