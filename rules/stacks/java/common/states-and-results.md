# Java 狀態與結果建模

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[領域建模](../../../coding/domain-modeling.md)與[錯誤處理](../../../coding/error-handling.md)，定義 Java 狀態與操作結果的型別要求。實作須符合[版本要求](version-policy.md)、[型別宣告與泛型](types-and-generics.md)及[空值契約](null-and-optional.md)。

## 狀態與轉換

<a id="java-explicit-state-types"></a>

### 明確的狀態型別

互斥的業務狀態須使用明確型別；僅需區分固定狀態名稱時，可使用 `enum`。不得以多個獨立布林值表達互斥狀態。不同業務面向須分別建模，不得強行合併，例如付款與配送狀態可各自表達，再明訂兩者之間的限制。

<a id="java-required-state-data"></a>

### 各狀態的必要資料

依[領域建模](../../../coding/domain-modeling.md)執行。Java 應以對應狀態型別保護必要資料，不只用狀態碼搭配多個可空欄位讓使用端推測。

<a id="java-business-state-transitions"></a>

### 業務操作控制轉換

依[領域建模](../../../coding/domain-modeling.md)執行。Java 公開狀態 setter 不得成為繞過業務操作的入口；修改既有物件或產生新狀態物件由模型決定。

## 操作結果與使用端處理

本組由共通規範承接的要求：[結果與目前狀態分開表達](../../../coding/domain-modeling.md#operation-results)、[處理完整性](../../../coding/domain-modeling.md#exhaustive-result-handling)。

<a id="java-typed-business-failures"></a>

### 具型別的業務失敗

依[錯誤處理](../../../coding/error-handling.md)執行。Java 可用不同失敗型別或具型別原因代碼；技術故障仍透過例外，不為統一格式混入一般業務失敗。

## 外部代碼、擴充與結果資料

本組由共通規範承接的要求：[結果保留當時事實](../../../coding/domain-modeling.md#result-facts)。

<a id="java-stable-external-codes"></a>

### 穩定的外部代碼

持久化或跨邊界傳遞狀態時，須明訂穩定的外部代碼與映射，不得使用 `ordinal()` 作為業務契約。若採用列舉名稱作為外部值，須將名稱納入相容性管理，重新命名不能僅視為內部整理。未知代碼依契約處理，不得默默映射成任意既有狀態。不強制額外建立轉換類別，但映射與影響須可辨識。

<a id="java-model-extensibility"></a>

### 封閉或允許擴充

依[封閉或允許擴充的共通要求](../../../coding/domain-modeling.md#model-extensibility)執行。支援 `sealed` 的 Java 版本可用其限制實作；其他版本以可見性、建立入口及檢查維持封閉契約，不強制同一語法。

<a id="java-model-acceptance"></a>

### 模型驗收

依[模型驗收的共通要求](../../../coding/domain-modeling.md#model-verification)執行。Java 狀態型別、使用端分支、`enum` 外部代碼及封閉模型依[本文件驗收要求](#驗收要求)與[處理完整性、封閉或允許擴充驗收](../../../coding/domain-modeling.md#acceptance-model-extensibility)驗收，並核對實際副作用。

<a id="java-closing-requirements"></a>

## 補充要求

對外結果與完成程度另依[API 操作語意](../../../interfaces/api-contracts.md)及[事件可靠性](../../../interfaces/events.md)；代碼與資料格式變更依[資料契約](../../../interfaces/data-contracts.md)及[資料遷移](../../../data/migrations.md)。不可變資料的保護方式另見[專屬值型別與領域值物件](value-objects.md)。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依受影響的模型與呼叫端選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。

### 共同驗收

- [結果與目前狀態分開表達](../../../coding/domain-modeling.md#acceptance-operation-results)。
- [處理完整性、封閉或允許擴充](../../../coding/domain-modeling.md#acceptance-model-extensibility)。
- [結果保留當時事實](../../../coding/domain-modeling.md#acceptance-result-facts)。
- [模型驗收](../../../coding/domain-modeling.md#acceptance-model-coverage)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-independent-state-models"></a>[明確的狀態型別](#java-explicit-state-types)、[各狀態的必要資料](#java-required-state-data) | 審查互斥狀態與獨立業務面向是否正確分開，必要資料是否由對應型別保護。確認不能建立契約禁止的狀態與資料組合，不以僅存在狀態碼作為符合依據。 |
| <a id="acceptance-java-state-transition"></a>[業務操作控制轉換](#java-business-state-transitions) | 驗證允許與不允許的來源狀態、前置條件及轉換後資料。確認公開介面沒有可繞過規則的任意設定路徑，拒絕時未產生不應發生的副作用。 |
| <a id="acceptance-java-enum-codes"></a>[穩定的外部代碼](#java-stable-external-codes) | 經適用的傳輸或持久化路徑驗證外部代碼與狀態對應，未知代碼依契約處理。確認未使用 `ordinal()` 作為業務代碼，採用列舉名稱時已評估重新命名的相容性影響。 |

既有程式碼與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不因版本或工具限制自行降低要求。
