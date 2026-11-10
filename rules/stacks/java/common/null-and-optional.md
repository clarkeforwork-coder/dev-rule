# Java null 與 Optional

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[空值語意](../../../coding/nullability.md)、[型別安全](../../../coding/type-safety.md)、[錯誤處理](../../../coding/error-handling.md)、[資料驗證](../../../coding/validation.md)與[領域建模](../../../coding/domain-modeling.md)，適用於自行撰寫的 Java 程式碼，包含測試與整合元件。語法與 API 須符合[版本要求](version-policy.md)，型別使用另依[型別宣告與泛型](types-and-generics.md)。

## 查詢與 Optional

<a id="java-query-absence"></a>

### 查詢的正常缺值

單筆查詢允許正常不存在時，使用 `Optional<T>`；多筆查詢無結果時使用空集合，不回傳 `null`。依業務要求必須存在卻不存在時，表達明確的業務失敗；查詢技術故障依[錯誤處理](../../../coding/error-handling.md#失敗分類與表達)傳遞，不得混為正常缺值。

<a id="java-optional-nonnull"></a>

### Optional 本身非空

宣告使用 `Optional` 的位置，`Optional` 本身不得為 `null`。空的 `Optional` 只能表示契約允許的正常缺值，不得掩蓋業務失敗、技術故障或尚未確認的結果。

<a id="java-optional-access"></a>

### 取值與缺值處置

使用 `Optional` 的值前，須明確處理缺值情境，不得僅憑預期直接取值。替代值、缺值分支與失敗處理須符合業務語意，不得掩蓋缺值；替代結果與錯誤分類依[降級與替代結果](../../../coding/error-handling.md#降級與替代結果)及[失敗分類](../../../coding/error-handling.md#失敗分類與表達)。選用取值或拋出例外的方法本身不代表符合規範；若依已成立的不變條件必定有值，違反時須按[程式缺陷](../../../coding/error-handling.md#程式缺陷與不變條件)處理。

<a id="java-optional-positions"></a>

### 使用位置與狀態表達

`Optional` 主要用於方法回傳的正常缺值。參數與欄位須依業務語意設計，不全面包裝，也不全面禁止使用；採用時須確認契約及相關框架可正確處理。需要區分多種狀態時，依[空值語意](../../../coding/nullability.md#空值語意)使用能完整表達狀態的明確型別，不得以 `Optional` 混合表示。

## 空值限制與整合責任

<a id="java-container-nulls"></a>

### 集合內容的空值

集合與陣列元素，以及映射的鍵和值，預設不得為 `null`。必要缺值須明訂語意與處理方式，優先以明確型別表達。外部資料含有不允許的 `null` 時，須在邊界拒絕或依契約處理，不得默默移除或替換而掩蓋不合法資料。

<a id="java-nonnull-validation"></a>

### 非空驗證的位置

依[資料驗證](../../../coding/validation.md#責任分工)、[錯誤處理](../../../coding/error-handling.md#程式缺陷與不變條件)、[領域建模](../../../coding/domain-modeling.md)執行。Java 接收、建立及狀態變更位置依上述非空保證驗證；內部可靠契約已成立時不逐層重複檢查。

<a id="java-null-contract-tools"></a>

### 工具可辨識的契約

專案須統一可由工具辨識的空值契約表達方式，明訂非空預設、可空位置與適用範圍。可自動判斷的違規及工具缺口依[共同把關](../../../quality/rule-verification.md#verification-coverage)納入檢查、驗證與審查。標註、文件與實際行為須一致；標註不能取代外部輸入的執行期驗證。註解套件與工具由專案依版本及框架選定。

<a id="java-third-party-optional"></a>

### 第三方空值行為

依[第三方空值行為](../../../coding/nullability.md#third-party-null-contract)確認契約；第三方明訂 `null` 是正常查無資料時，才轉成空的 `Optional`。

## 契約維護與對外表示

<a id="java-null-contract-evolution"></a>

### 空值契約變更

依[空值契約變更](../../../coding/nullability.md#null-contract-evolution)評估相容性與使用端影響；Java 空值標註、`Optional` 使用及缺值處置須同步更新。

<a id="java-nonnull-default"></a>

### 預設非空與明確語意

Java 的參數、回傳值與欄位預設不允許 `null`；允許時須明確標示並定義語意，不得以同一個 `null` 混合表示需要不同處理方式的狀態。查詢結果另遵循本文件的 `Optional` 與空集合要求。

<a id="java-api-absence"></a>

### API 邊界的缺值轉換

Java 的 `Optional` 與內部 `null` 在 API 邊界轉換，依[API 邊界的缺值轉換](../../../interfaces/api-contracts.md#api-absence-representation)落實對外契約。具體序列化配置由 Framework 規範落實。

<a id="java-closing-requirements"></a>

## 補充要求

對外缺值表達須與[API 操作語意與介面設計](../../../interfaces/api-contracts.md#api-absence-representation)及[資料契約](../../../interfaces/data-contracts.md#主要定義來源)一致。本文件不統一指定所有查無資料情境的 HTTP 狀態，也不將欄位省略與 JSON `null` 視為可任意互換。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依受影響的契約、呼叫端與邊界選擇案例；自動檢查、行為測試與人工審查共同把關，測試層級、證據及其餘事項另依[規範驗證](../../../quality/rule-verification.md#verification-coverage)及[共通測試策略](../../../quality/testing.md#層級與案例選擇)辦理。

不合法資料從允許承接它的邊界輸入；型別要求依[型別安全](../../../coding/type-safety.md#禁止主動繞過檢查)。

### 共同驗收

- [第三方空值行為](../../../coding/nullability.md#acceptance-third-party-null)。
- [空值契約變更](../../../coding/nullability.md#acceptance-null-contract-change)。
- [API 邊界的缺值轉換](../../../interfaces/api-contracts.md#acceptance-api-absence)。
- [測試程式碼](../../../quality/rule-verification.md#測試程式碼)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-optional-results"></a>[查詢](#java-query-absence)、[Optional 非空](#java-optional-nonnull)、[取值](#java-optional-access) | 驗證有值、單筆正常查無資料、多筆空結果，以及適用的必須存在卻不存在、查詢故障與結果未知。確認 `Optional` 本身非空，呼叫端的缺值分支、替代值與失敗分類符合契約。 |
| <a id="acceptance-java-optional-positions"></a>[使用位置](#java-optional-positions)、[集合空值](#java-container-nulls) | 審查參數與欄位採用 `Optional` 的必要性及配套。需要多狀態時分別驗證未提供、清空與設定值；集合等輸入含不允許的空值時，確認依契約處理，沒有默默丟棄或替換資料。 |
| <a id="acceptance-java-null-contract"></a>[驗證責任](../../../coding/validation.md#責任分工)、[工具契約](#java-null-contract-tools)、[非空預設](#java-nonnull-default) | 核對非空預設、可空標註、檢查範圍及實際驗證位置。確認適用工具能偵測違反契約的使用方式；必填外部輸入缺值時依契約拒絕，且未產生不應發生的副作用。 |
| <a id="acceptance-java-optional-adaptation"></a>[第三方轉換](#java-third-party-optional) | 檢查第三方回傳值轉成 `Optional` 的路徑，只有契約允許的正常缺值才能使用空的 `Optional`。 |
| <a id="acceptance-java-optional-coverage"></a>案例覆蓋 | 核對案例覆蓋受影響的有值與缺值分類，測試資料及替身遵守型別契約，未為製造案例而關閉檢查或使用不安全轉型。Optional、非空標註與實際 API 路徑均納入適用案例。 |

既有程式碼、工具限制與個別例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行放寬要求。
