# Java 集合與資料所有權

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[程式碼設計與公開介面](../../../coding/code-design.md)，定義集合及其元素的所有權、修改與處理契約。集合宣告依[型別宣告與泛型](types-and-generics.md)，空值依[null 與 Optional](null-and-optional.md)，鍵與元素的比較依[相等性、雜湊與排序](equality-hashing-ordering.md)。具體併發 API 與資源管理方式由後續 Java 主題展開。

## 所有權與集合語意

1. **明確定義修改權與參考關係**。依[明確定義修改權與參考關係的共通要求](../../../coding/collections-and-ownership.md#co-01)執行。Java 集合介面本身不能取代所有權契約；接收或回傳集合時須涵蓋可變元素及參考保留行為。
2. **區分不可修改與不可變快照**。依[區分不可修改與不可變快照的共通要求](../../../coding/collections-and-ownership.md#co-02)執行。Java 不可修改包裝可能仍是來源的檢視；外層複製可能保留相同可變元素，須驗證實際隔離。
3. **順序與重複資料**。依[順序與重複資料的共通要求](../../../coding/collections-and-ownership.md#co-03)執行。Java 選用或轉換 List、Set、Map 時須維持約定順序、重複元素與重複鍵處理，不意外去重或覆蓋。

## 修改與併發

4. **遍歷期間的修改**。依[遍歷期間的修改的共通要求](../../../coding/collections-and-ownership.md#co-04)執行。Java 遍歷修改須使用集合支援的操作；未拋出遍歷修改例外不代表安全，也不得捕捉後直接重跑。
5. **複合操作的原子性**。依[複合操作的原子性的共通要求](../../../coding/concurrency-and-async.md#co-05)執行。Java concurrent collection 的單一操作保證不能推導為多步驟或跨鍵操作原子性。

## 資料規模、資源與批次結果

6. **限制資料累積**。依[限制資料累積的共通要求](../../../quality/performance.md#co-06)執行。Java Iterator 或 Stream 不保證實際有界；排序、去重及分組的保留資料成本仍須核對。
7. **延遲讀取的資源責任**。依[延遲讀取的資源責任的共通要求](../../../coding/resource-lifecycle.md#co-07)執行。Java 資源型 Iterator／Stream 須明確有效期及關閉責任；必要時在資源範圍內產生受控結果，關閉方式依例外與資源管理。
8. **批次修改的失敗保證**。依[錯誤處理](../../../coding/error-handling.md)執行。Java 批次集合方法拋出例外不代表未修改；不要求所有集合操作具有交易能力，須核對約定的失敗後狀態。
9. **所有權與行為驗收**。依[所有權與行為驗收的共通要求](../../../coding/collections-and-ownership.md#co-09)執行。Java 集合的實際修改、遍歷、檢視及資源路徑依下方驗收，不重測標準函式庫本身。

邊界間的參考隔離另依[邊界物件與資料映射](boundary-mapping.md)，共用元件的狀態與生命週期依[類別、介面與物件建立](classes-and-construction.md)。資源範圍與容量依[效能與資源使用](../../../quality/performance.md)，失敗與部分成功依[錯誤處理](../../../coding/error-handling.md)。

## 驗收要求

共同驗收直接依主要來源執行：[所有權與快照](../../../coding/collections-and-ownership.md#acceptance-collection-ownership)、[順序與重複](../../../coding/collections-and-ownership.md#acceptance-order-duplicates)、[遍歷修改](../../../coding/collections-and-ownership.md#acceptance-traversal-mutation)、[複合原子性](../../../coding/concurrency-and-async.md#acceptance-compound-atomicity)、[資料累積](../../../quality/performance.md#acceptance-bounded-accumulation)、[延遲資源](../../../coding/resource-lifecycle.md#acceptance-lazy-resource-lifetime)、[批次失敗](../../../quality/rule-verification.md#acceptance-partial-operation)、[所有權覆蓋](../../../coding/collections-and-ownership.md#acceptance-collection-coverage)。

依變更影響及實際使用路徑選擇案例，測試層級與證據依[共通測試策略](../../../quality/testing.md)及[規範驗證](../../../quality/rule-verification.md)。

上述驗收須經實際採用的 Java 集合、迭代與資源路徑執行，各條 Java 使用限制仍適用。

既有程式碼與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行降低要求。
