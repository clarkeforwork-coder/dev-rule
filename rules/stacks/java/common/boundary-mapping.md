# Java 邊界物件與資料映射

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[邊界物件](../../../architecture/boundary-objects.md)與[資料映射](../../../architecture/data-mapping.md)，適用於 Java 的 API、模組、持久化及第三方整合邊界。實際分層與依賴方向由專案架構決定，具體映射與序列化工具設定由 Framework 規範及專案配置落實。

本文件另依[bm-03](../../../architecture/data-mapping.md#bm-03)辦理。

## 契約與映射責任

<a id="java-mapping-fields"></a>

### 明確控制欄位及來源

依[資料映射](../../../architecture/data-mapping.md)、[API 操作語意與介面設計](../../../interfaces/api-contracts.md)、[安全](../../../quality/security.md)執行。Java 映射工具不得因同名或來源新增欄位而擴大傳遞範圍；租戶與建立者等可信欄位仍依伺服器契約取得。

## 轉換完整性與隔離

<a id="java-mapping-integrity"></a>

### 失敗明確回報

依[錯誤處理](../../../coding/error-handling.md)、[資料驗證](../../../coding/validation.md)、[資料映射](../../../architecture/data-mapping.md)執行。依下方 Java 實際映射路徑驗收拒絕、缺陷與部分成功，不以建立了目標型別就視為有效。不得略過欄位或產生不完整物件掩蓋失敗。

<a id="java-update-intent"></a>

### 保留更新意圖

映射須保留契約要求的未提供、明確清空與設定值等差異，不得因 Java 欄位、預設值或反序列化行為而合併不同意圖。需要多種更新狀態時，須使用明確型別一路傳遞至負責更新的業務操作，不能僅依同一個 `null` 或 `Optional` 推測三種意圖。

<a id="java-mutable-isolation"></a>

### 可變參考隔離

依[邊界物件](../../../architecture/boundary-objects.md)、[程式碼設計與公開介面](../../../coding/code-design.md)執行。Java 複製集合外層不一定隔離可變元素；符合契約的不可變值可共用，不要求全面深層複製。

<a id="java-directional-mapping"></a>

### 各方向分別定義

依[各方向分別定義的共通要求](../../../architecture/data-mapping.md#bm-07)執行。Java 映射工具支援反向產生不代表可直接採用；具體工具配置另由 Framework 規範落實。

## 維護與驗證

<a id="java-mapping-ownership"></a>

### 明確維護責任

依[資料映射](../../../architecture/data-mapping.md)、[共用能力](../../../architecture/shared-capabilities.md)、[框架與依賴組裝](../../../architecture/dependency-composition.md)執行。Java 簡單映射可使用方法，有實際責任或共用需求才建立專責類別，不強制 Mapper 介面或包裝層。

<a id="java-mapping-verification"></a>

### 驗證實際映射路徑

依[驗證實際映射路徑的共通要求](../../../architecture/data-mapping.md#bm-09)執行。Java 測試須經實際映射及適用的序列化／反序列化路徑，不能只測手寫替代版本。

<a id="java-closing-requirements"></a>

## 補充要求

型別與缺值處理另依[型別宣告與泛型](types-and-generics.md)及[null 與 Optional](null-and-optional.md)；專屬型別的建立與還原依[值物件規範](value-objects.md)。失敗分類依[錯誤處理](../../../coding/error-handling.md)，可信欄位與資料揭露依[安全規範](../../../quality/security.md)。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響與實際邊界選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。

### 共同驗收

- [隔離與拆分](../../../architecture/boundary-objects.md#acceptance-boundary-separation)。
- [轉換要求、最小必要欄位](../../../architecture/data-mapping.md#acceptance-mapping-fields)。
- [不可變性](../../../architecture/boundary-objects.md#acceptance-boundary-isolation)。
- [責任配置](../../../architecture/data-mapping.md#acceptance-mapping-owner)。
- [聚焦轉換與必要驗證](../../../architecture/data-mapping.md#acceptance-mapping-responsibility)。
- [各方向分別定義](../../../architecture/data-mapping.md#acceptance-directional-mapping)。
- [驗證實際映射路徑](../../../architecture/data-mapping.md#acceptance-mapping-paths)。
- [多步驟與部分成功](../../../quality/rule-verification.md#acceptance-partial-operation)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-mapping-failure"></a>[失敗明確回報](#java-mapping-integrity) | 透過 Java 實際映射路徑輸入不合法資料、內部必要資料缺失與轉換失敗，確認沒有以預設值或半成品掩蓋問題。 |
| <a id="acceptance-java-update-intent"></a>[保留更新意圖](#java-update-intent) | 核對 Java 欄位、預設值與反序列化路徑未合併省略、明確清空及設定值的不同意圖。 |

既有程式碼、工具限制與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行降低型別安全與邊界要求。
