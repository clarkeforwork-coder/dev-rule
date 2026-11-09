# 第八次審閱修正紀錄

基準為 `350668eb14ede247af22c782323beebf940c2a5f`，修正起點為 `b0f13eb`。規範及去向修正提交為 `1623990`；共通檔未改。

## 種類變動及逐字核對

- CA-02：拆分 → 整條保留；`rules/stacks/java/common/concurrency-and-async.md#java-execution-resources`；完整基準正文逐字核對通過。
- CA-08：整條移除 → 整條保留；`rules/stacks/java/common/concurrency-and-async.md#java-execution-location`；完整基準正文逐字核對通過。
- CA-10：整條移除 → 整條保留；`rules/stacks/java/common/concurrency-and-async.md#java-lock-scope`；完整基準正文逐字核對通過。
- CO-01：拆分 → 整條保留；`rules/stacks/java/common/collections-and-ownership.md#java-collection-ownership`；完整基準正文逐字核對通過。
- CO-02：拆分 → 整條保留；`rules/stacks/java/common/collections-and-ownership.md#java-snapshots-and-views`；完整基準正文逐字核對通過。
- CO-07：拆分 → 整條保留；`rules/stacks/java/common/collections-and-ownership.md#java-lazy-resource-lifetime`；完整基準正文逐字核對通過。
- CO-08：拆分 → 整條保留；`rules/stacks/java/common/collections-and-ownership.md#java-batch-failure-state`；完整基準正文逐字核對通過。
- CO-09：拆分 → 整條保留；`rules/stacks/java/common/collections-and-ownership.md#java-collection-verification`；完整基準正文逐字核對通過。
- BM-09：整條移除 → 整條保留；`rules/stacks/java/common/boundary-mapping.md#java-mapping-verification`；完整基準正文逐字核對通過。
- VO-05：拆分 → 整條保留；`rules/stacks/java/common/value-objects.md#java-value-normalization`；完整基準正文逐字核對通過。
- EQ-04：拆分 → 整條保留；`rules/stacks/java/common/equality-hashing-ordering.md#java-entity-identity-lifecycle`；完整基準正文逐字核對通過。
- RF-06：拆分 → 整條保留；`rules/stacks/java/common/reflection-and-suppression.md#java-warning-suppression`；完整基準正文逐字核對通過。

153 條最新種類統計：

- 保留增量：60 條。
- 拆分：9 條。
- 整條保留：55 條。
- 整條移除：28 條。
- 轉為驗收入口：1 條。

## 每處前後文字（完整規範差異）

以下差異逐字擷取，新增條文正文已在上面與基準完整核對；小標題與錨點採既定格式。

```diff
diff --git a/rules/stacks/java/common/boundary-mapping.md b/rules/stacks/java/common/boundary-mapping.md
index 837729a..ea3676a 100644
--- a/rules/stacks/java/common/boundary-mapping.md
+++ b/rules/stacks/java/common/boundary-mapping.md
@@ -4,7 +4,7 @@

 本文件承接[邊界物件](../../../architecture/boundary-objects.md)與[資料映射](../../../architecture/data-mapping.md)，適用於 Java 的 API、模組、持久化及第三方整合邊界。實際分層與依賴方向由專案架構決定，具體映射與序列化工具設定由 Framework 規範及專案配置落實。

-本文件另依[bm-03](../../../architecture/data-mapping.md#bm-03)、[bm-09](../../../architecture/data-mapping.md#bm-09)辦理。
+本文件另依[bm-03](../../../architecture/data-mapping.md#bm-03)辦理。

 ## 契約與映射責任

@@ -48,6 +48,12 @@

 依[資料映射](../../../architecture/data-mapping.md)、[共用能力](../../../architecture/shared-capabilities.md)、[框架與依賴組裝](../../../architecture/dependency-composition.md)執行。Java 簡單映射可使用方法，有實際責任或共用需求才建立專責類別，不強制 Mapper 介面或包裝層。

+<a id="java-mapping-verification"></a>
+
+### 驗證實際映射路徑
+
+依[驗證實際映射路徑的共通要求](../../../architecture/data-mapping.md#bm-09)執行。Java 測試須經實際映射及適用的序列化／反序列化路徑，不能只測手寫替代版本。
+
 <a id="java-closing-requirements"></a>

 ## 補充要求
diff --git a/rules/stacks/java/common/collections-and-ownership.md b/rules/stacks/java/common/collections-and-ownership.md
index 5e3b0cb..9963682 100644
--- a/rules/stacks/java/common/collections-and-ownership.md
+++ b/rules/stacks/java/common/collections-and-ownership.md
@@ -4,7 +4,7 @@

 本文件承接[程式碼設計與公開介面](../../../coding/code-design.md)，定義集合及其元素的所有權、修改與處理契約。集合宣告依[型別宣告與泛型](types-and-generics.md)，空值依[null 與 Optional](null-and-optional.md)，鍵與元素的比較依[相等性、雜湊與排序](equality-hashing-ordering.md)。具體併發 API 與資源管理方式由後續 Java 主題展開。

-本文件另依[co-01](../../../coding/collections-and-ownership.md#co-01)、[co-02](../../../coding/collections-and-ownership.md#co-02)、[co-03](../../../coding/collections-and-ownership.md#co-03)、[co-09](../../../coding/collections-and-ownership.md#co-09)、[co-07](../../../coding/resource-lifecycle.md#co-07)、[co-06](../../../quality/performance.md#co-06)辦理。
+本文件另依[co-03](../../../coding/collections-and-ownership.md#co-03)、[co-06](../../../quality/performance.md#co-06)辦理。

 ## 所有權與集合語意

@@ -12,13 +12,13 @@

 ### 明確定義修改權與參考關係

-Java 集合介面本身不能取代所有權契約；接收或回傳集合時須涵蓋可變元素及參考保留行為。
+依[明確定義修改權與參考關係的共通要求](../../../coding/collections-and-ownership.md#co-01)執行。Java 集合介面本身不能取代所有權契約；接收或回傳集合時須涵蓋可變元素及參考保留行為。

 <a id="java-snapshots-and-views"></a>

 ### 區分不可修改與不可變快照

-Java 不可修改包裝可能仍是來源的檢視；外層複製可能保留相同可變元素，須驗證實際隔離。
+依[區分不可修改與不可變快照的共通要求](../../../coding/collections-and-ownership.md#co-02)執行。Java 不可修改包裝可能仍是來源的檢視；外層複製可能保留相同可變元素，須驗證實際隔離。

 ## 修改與併發

@@ -30,19 +30,19 @@ Java 不可修改包裝可能仍是來源的檢視；外層複製可能保留相

 ### 延遲讀取的資源責任

-Java 資源型 Iterator／Stream 須明確有效期及關閉責任；必要時在資源範圍內產生受控結果，關閉方式依例外與資源管理。
+依[延遲讀取的資源責任的共通要求](../../../coding/resource-lifecycle.md#co-07)執行。Java 資源型 Iterator／Stream 須明確有效期及關閉責任；必要時在資源範圍內產生受控結果，關閉方式依例外與資源管理。

 <a id="java-batch-failure-state"></a>

 ### 批次修改的失敗保證

-Java 批次集合方法拋出例外不代表未修改；不要求所有集合操作具有交易能力，須核對約定的失敗後狀態。
+依[錯誤處理](../../../coding/error-handling.md)執行。Java 批次集合方法拋出例外不代表未修改；不要求所有集合操作具有交易能力，須核對約定的失敗後狀態。

 <a id="java-collection-verification"></a>

 ### 所有權與行為驗收

-Java 集合的實際修改、遍歷、檢視及資源路徑依下方驗收，不重測標準函式庫本身。
+依[所有權與行為驗收的共通要求](../../../coding/collections-and-ownership.md#co-09)執行。Java 集合的實際修改、遍歷、檢視及資源路徑依下方驗收，不重測標準函式庫本身。

 <a id="java-closing-requirements"></a>

diff --git a/rules/stacks/java/common/concurrency-and-async.md b/rules/stacks/java/common/concurrency-and-async.md
index c62d3d1..d6c0977 100644
--- a/rules/stacks/java/common/concurrency-and-async.md
+++ b/rules/stacks/java/common/concurrency-and-async.md
@@ -4,7 +4,7 @@

 本文件承接[錯誤處理](../../../coding/error-handling.md)與[效能與資源使用](../../../quality/performance.md)，定義 Java 併發工作的所有權、同步、結果及生命週期。中斷與資源清理另依[例外與資源管理](exceptions-and-resources.md)，具體 API 須符合[版本要求](version-policy.md)。

-本文件另依[ca-01](../../../coding/concurrency-and-async.md#ca-01)、[ca-04](../../../coding/concurrency-and-async.md#ca-04)、[ca-08](../../../coding/concurrency-and-async.md#ca-08)、[ca-10](../../../coding/concurrency-and-async.md#ca-10)辦理。
+本文件另依[ca-01](../../../coding/concurrency-and-async.md#ca-01)、[ca-04](../../../coding/concurrency-and-async.md#ca-04)辦理。

 ## 工作所有權與執行資源

@@ -12,7 +12,7 @@

 ### 統一管理執行資源

-依[統一管理執行資源的共通要求](../../../coding/concurrency-and-async.md#ca-02)執行。Java 可用明確提供的 `Executor`、`ExecutorService` 或框架提交工作。
+依[統一管理執行資源的共通要求](../../../coding/concurrency-and-async.md#ca-02)執行。Java 可用明確提供的 `Executor`、`ExecutorService` 或框架提交工作；虛擬執行緒也須遵守下游容量。

 <a id="java-visibility-sharing"></a>

@@ -42,12 +42,24 @@

 ## 執行位置、脈絡與同步

+<a id="java-execution-location"></a>
+
+### 執行位置與阻塞行為
+
+依[執行位置與阻塞行為的共通要求](../../../coding/concurrency-and-async.md#ca-08)執行。Java 任務及回呼須明確安排 executor 與阻塞行為，避免占用同一受限 executor 等待其排隊工作。
+
 <a id="java-context-propagation"></a>

 ### 明確傳遞與清理脈絡

 依[明確傳遞與清理脈絡的共通要求](../../../coding/concurrency-and-async.md#ca-09)執行。Java 不假設 `ThreadLocal` 或日誌脈絡自動沿用；共用執行緒上的脈絡須在結束時清理或還原。

+<a id="java-lock-scope"></a>
+
+### 鎖定範圍與取得策略
+
+依[鎖定範圍與取得策略的共通要求](../../../coding/concurrency-and-async.md#ca-10)執行。Java 同步與鎖的實作須涵蓋全部退出路徑，必要檢查不能為縮短持鎖而移出原子範圍。
+
 ## 關閉與驗證

 <a id="java-controlled-shutdown"></a>
diff --git a/rules/stacks/java/common/equality-hashing-ordering.md b/rules/stacks/java/common/equality-hashing-ordering.md
index 0dbe31f..8a306a8 100644
--- a/rules/stacks/java/common/equality-hashing-ordering.md
+++ b/rules/stacks/java/common/equality-hashing-ordering.md
@@ -28,7 +28,7 @@

 ### Entity 識別碼的生命週期

-依[Entity 識別碼的生命週期的共通要求](../../../coding/domain-modeling.md#eq-04)執行。Java 沒有跨實例相等需求時不強制覆寫 `equals()`。
+依[Entity 識別碼的生命週期的共通要求](../../../coding/domain-modeling.md#eq-04)執行。Java 沒有跨實例相等需求時不強制覆寫 `equals()`；識別碼變化不得破壞雜湊或排序集合契約。

 <a id="java-cross-type-equality"></a>

diff --git a/rules/stacks/java/common/reflection-and-suppression.md b/rules/stacks/java/common/reflection-and-suppression.md
index 4771760..069910d 100644
--- a/rules/stacks/java/common/reflection-and-suppression.md
+++ b/rules/stacks/java/common/reflection-and-suppression.md
@@ -4,7 +4,7 @@

 本文件承接[型別安全](../../../coding/type-safety.md)及[規範治理](../../../workflow/rule-governance.md)，定義動態能力、特殊存取與檢查抑制的限制。手寫整合與測試程式碼適用相同要求，工具限制不構成自動例外。Java 型別要求另依[型別宣告與泛型](types-and-generics.md)，JDK 內部 API 與存取放寬另依[版本要求](version-policy.md)。

-本文件另依[rf-04](../../../coding/type-safety.md#rf-04)、[rf-02](../../../quality/security.md#rf-02)、[rf-06](../../../workflow/rule-governance.md#rf-06)辦理。
+本文件另依[rf-04](../../../coding/type-safety.md#rf-04)、[rf-02](../../../quality/security.md#rf-02)辦理。

 ## 動態能力與存取邊界

@@ -32,7 +32,7 @@

 ### 限定檢查抑制

-Java `@SuppressWarnings` 須限具體規則及最小範圍；raw type／unchecked 仍遵守型別與泛型規範的禁止事項及個別核准要求。
+依[限定檢查抑制的共通要求](../../../workflow/rule-governance.md#rf-06)執行。Java `@SuppressWarnings` 須限具體規則及最小範圍；raw type／unchecked 仍遵守型別與泛型規範的禁止事項及個別核准要求。

 <a id="java-generated-code"></a>

diff --git a/rules/stacks/java/common/value-objects.md b/rules/stacks/java/common/value-objects.md
index 846b54c..389f540 100644
--- a/rules/stacks/java/common/value-objects.md
+++ b/rules/stacks/java/common/value-objects.md
@@ -26,7 +26,7 @@

 ### 正規化規則

-依[正規化規則的共通要求](../../../coding/domain-modeling.md#vo-05)執行。Java 建構子、工廠及其他建立入口須讓 `equals()` 與 `hashCode()` 反映已定義的值語意。
+依[正規化規則的共通要求](../../../coding/domain-modeling.md#vo-05)執行。Java 建構子、工廠及其他建立入口須一致執行正規化，並讓 `equals()` 與 `hashCode()` 反映已定義的值語意。

 <a id="java-value-operations"></a>

```

## 證據及限制

CA-01 的結果處置改由 async-result-reception 完整原句承接，接手元件仍由 ca-01 承接；ND-05 增列 nd-05 首句支持註解維護，保留原有 TODO 證據。CA-08／CA-10 已還原，不再保留其移除紀錄；其他相關的多筆承接證據未刪。

檢查工具、格式、白名單均未修改；只同步階段 B 產生器敘述。六份 Java 文件及七份 JSON 是逐條點名範圍；驗收標準的「五份」與實際檔名數不符，採明確條目。L5 不改，L7、L14 僅維持觀察；L9 至 L13、L15 未處理，依指示留下一階段。全部規範改動均為還原或引言連結清單調整。

實際命令與完整輸出見[驗證紀錄](body-restructuring-verification-results.md)。
