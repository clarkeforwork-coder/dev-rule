# Java null 與 Optional

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[空值語意](../../../coding/nullability.md)、[型別安全](../../../coding/type-safety.md)與[錯誤處理](../../../coding/error-handling.md)，適用於自行撰寫的 Java 程式碼，包含測試與整合元件。語法與 API 須符合[版本要求](version-policy.md)，型別使用另依[型別宣告與泛型](types-and-generics.md)。

## 查詢與 Optional

1. **查詢的正常缺值**。單筆查詢允許正常不存在時，使用 `Optional<T>`；多筆查詢無結果時使用空集合，不回傳 `null`。依業務要求必須存在卻不存在時，表達明確的業務失敗；查詢技術故障另依錯誤處理規範傳遞，不得混為正常缺值。
2. **Optional 本身非空**。宣告使用 `Optional` 的位置，`Optional` 本身不得為 `null`。空的 `Optional` 只能表示契約允許的正常缺值，不得掩蓋業務失敗、技術故障或尚未確認的結果。
3. **取值與缺值處置**。使用 `Optional` 的值前，須明確處理缺值情境，不得僅憑預期直接取值。替代值、缺值分支與失敗處理須符合業務語意，不得掩蓋缺值或違反錯誤分類。選用取值或拋出例外的方法本身不代表符合規範；若依已成立的不變條件必定有值，違反時須按程式缺陷處理。
4. **使用位置與狀態表達**。`Optional` 主要用於方法回傳的正常缺值。參數與欄位須依業務語意設計，不全面包裝，也不全面禁止使用；採用時須確認契約及相關框架可正確處理。需要區分未提供、清空與設定值等多種狀態時，須使用能完整表達狀態的明確型別，不得以 `Optional` 混合表示。

## 空值限制與整合責任

5. **集合內容的空值**。集合與陣列元素，以及映射的鍵和值，預設不得為 `null`。必要缺值須明訂語意與處理方式，優先以明確型別表達。外部資料含有不允許的 `null` 時，須在邊界拒絕或依契約處理，不得默默移除或替換而掩蓋不合法資料。
6. **非空驗證的位置**。依[資料驗證](../../../coding/validation.md)、[錯誤處理](../../../coding/error-handling.md)、[領域建模](../../../coding/domain-modeling.md)執行。Java 接收、建立及狀態變更位置依上述非空保證驗證；內部可靠契約已成立時不逐層重複檢查。
7. **工具可辨識的契約**。專案須統一可由工具辨識的空值契約表達方式，明訂非空預設、可空位置與適用範圍，將可自動判斷的違規納入檢查。標註、文件與實際行為須一致；工具無法涵蓋的部分仍須驗證與審查，標註不能取代外部輸入的執行期驗證。註解套件與工具由專案依版本及框架選定。
8. **第三方空值行為**。依[第三方空值行為的共通要求](../../../coding/nullability.md#jn-08)執行。第三方明訂 `null` 是正常查無資料時，才轉成空的 `Optional`；契約不明或違約的 `null` 不得擅自視為正常缺值。

## 契約維護與對外表示

9. **空值契約變更**。依[空值契約變更的共通要求](../../../coding/nullability.md#jn-09)執行。Java 空值標註、`Optional` 使用及缺值處置須同步更新，不因 Java 方法簽章未變就視為相容。
10. **空值情境驗收**。依[規範驗證](../../../quality/rule-verification.md)、[共通測試策略](../../../quality/testing.md)、[型別安全](../../../coding/type-safety.md)執行。保留本文件驗收表中的 `Optional`、非空標註及實際 API 路徑案例；不合法資料從允許承接它的邊界輸入。
11. **預設非空與明確語意**。Java 的參數、回傳值與欄位預設不允許 `null`；允許時須明確標示並定義語意，不得以同一個 `null` 混合表示需要不同處理方式的狀態。查詢結果另遵循本文件的 `Optional` 與空集合要求。
12. **API 邊界的缺值轉換**。依[API 邊界的缺值轉換的共通要求](../../../interfaces/api-contracts.md#jn-12)執行。Java 的 `Optional` 與內部 `null` 在 API 邊界轉換；不要求對外暴露 `Optional`。具體序列化配置由 Framework 規範落實，不能用預設輸出代替契約。

對外缺值表達須與[API 操作語意與介面設計](../../../interfaces/api-contracts.md)及[資料契約](../../../interfaces/data-contracts.md)一致。本文件不統一指定所有查無資料情境的 HTTP 狀態，也不將欄位省略與 JSON `null` 視為可任意互換。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依受影響的契約、呼叫端與邊界選擇案例；自動檢查、行為測試與人工審查共同把關，測試層級、證據及其餘事項另依[規範驗證](../../../quality/rule-verification.md)及[共通測試策略](../../../quality/testing.md)辦理。

### 共同驗收

- [第三方空值行為](../../../coding/nullability.md#acceptance-third-party-null)。
- [空值契約變更](../../../coding/nullability.md#acceptance-null-contract-change)。
- [API 邊界的缺值轉換](../../../interfaces/api-contracts.md#acceptance-api-absence)。
- [測試程式碼](../../../quality/rule-verification.md#測試程式碼)。

### Java 語言增量驗收

| Java 條文 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-optional-results"></a>1、2、3 | 驗證有值、單筆正常查無資料、多筆空結果，以及適用的必須存在卻不存在、查詢故障與結果未知。確認 `Optional` 本身非空，呼叫端的缺值分支、替代值與失敗分類符合契約。 |
| <a id="acceptance-java-optional-positions"></a>4、5 | 審查參數與欄位採用 `Optional` 的必要性及配套。需要多狀態時分別驗證未提供、清空與設定值；集合等輸入含不允許的空值時，確認依契約處理，沒有默默丟棄或替換資料。 |
| <a id="acceptance-java-null-contract"></a>6、7、11 | 核對非空預設、可空標註、檢查範圍及實際驗證位置。確認適用工具能偵測違反契約的使用方式；必填外部輸入缺值時依契約拒絕，且未產生不應發生的副作用。 |
| <a id="acceptance-java-optional-adaptation"></a>8 | 檢查第三方回傳值轉成 `Optional` 的路徑，只有契約允許的正常缺值才能使用空的 `Optional`。 |
| <a id="acceptance-java-optional-coverage"></a>10 | 核對案例覆蓋受影響的有值與缺值分類，測試資料及替身遵守型別契約，未為製造案例而關閉檢查或使用不安全轉型。Optional、非空標註與實際 API 路徑均納入適用案例。 |

既有程式碼、工具限制與個別例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行放寬要求。
