# Java 集合與資料所有權

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[程式碼設計與公開介面](../../../coding/code-design.md)，定義集合及其元素的所有權、修改與處理契約。集合宣告依[型別宣告與泛型](types-and-generics.md)，空值依[null 與 Optional](null-and-optional.md)，鍵與元素的比較依[相等性、雜湊與排序](equality-hashing-ordering.md)。具體併發 API 與資源管理方式由後續 Java 主題展開。

本文件另依[co-01](../../../coding/collections-and-ownership.md#co-01)、[co-02](../../../coding/collections-and-ownership.md#co-02)、[co-03](../../../coding/collections-and-ownership.md#co-03)、[co-09](../../../coding/collections-and-ownership.md#co-09)、[co-07](../../../coding/resource-lifecycle.md#co-07)、[co-06](../../../quality/performance.md#co-06)辦理。

## 所有權與集合語意

<a id="java-collection-ownership"></a>

### 明確定義修改權與參考關係

Java 集合介面本身不能取代所有權契約；接收或回傳集合時須涵蓋可變元素及參考保留行為。

<a id="java-snapshots-and-views"></a>

### 區分不可修改與不可變快照

Java 不可修改包裝可能仍是來源的檢視；外層複製可能保留相同可變元素，須驗證實際隔離。

## 修改與併發

本組要求依[co-04](../../../coding/collections-and-ownership.md#co-04)、[co-05](../../../coding/concurrency-and-async.md#co-05)辦理。

## 資料規模、資源與批次結果

<a id="java-lazy-resource-lifetime"></a>

### 延遲讀取的資源責任

Java 資源型 Iterator／Stream 須明確有效期及關閉責任；必要時在資源範圍內產生受控結果，關閉方式依例外與資源管理。

<a id="java-batch-failure-state"></a>

### 批次修改的失敗保證

Java 批次集合方法拋出例外不代表未修改；不要求所有集合操作具有交易能力，須核對約定的失敗後狀態。

<a id="java-collection-verification"></a>

### 所有權與行為驗收

Java 集合的實際修改、遍歷、檢視及資源路徑依下方驗收，不重測標準函式庫本身。

<a id="java-closing-requirements"></a>

## 補充要求

邊界間的參考隔離另依[邊界物件與資料映射](boundary-mapping.md)，共用元件的狀態與生命週期依[類別、介面與物件建立](classes-and-construction.md)。資源範圍與容量依[效能與資源使用](../../../quality/performance.md)，失敗與部分成功依[錯誤處理](../../../coding/error-handling.md)。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響及實際使用路徑選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。

### 共同驗收

- [明確定義修改權與參考關係、區分不可修改與不可變快照](../../../coding/collections-and-ownership.md#acceptance-collection-ownership)。
- [順序與重複資料](../../../coding/collections-and-ownership.md#acceptance-order-duplicates)。
- [遍歷期間的修改](../../../coding/collections-and-ownership.md#acceptance-traversal-mutation)。
- [複合操作的原子性](../../../coding/concurrency-and-async.md#acceptance-compound-atomicity)。
- [限制資料累積](../../../quality/performance.md#acceptance-bounded-accumulation)。
- [延遲讀取的資源責任](../../../coding/resource-lifecycle.md#acceptance-lazy-resource-lifetime)。
- [多步驟與部分成功](../../../quality/rule-verification.md#acceptance-partial-operation)。
- [所有權與行為驗收](../../../coding/collections-and-ownership.md#acceptance-collection-coverage)。
- [失敗後狀態](../../../coding/error-handling.md#acceptance-failure-state)。

### Java 語言增量驗收

上述驗收須經實際採用的 Java 集合、迭代與資源路徑執行，各條 Java 使用限制仍適用。

既有程式碼與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行降低要求。
