# Java 反射、動態能力與檢查抑制

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[型別安全](../../../coding/type-safety.md)及[規範治理](../../../workflow/rule-governance.md)，定義動態能力、特殊存取與檢查抑制的限制。手寫整合與測試程式碼適用相同要求，工具限制不構成自動例外。Java 型別要求另依[型別宣告與泛型](types-and-generics.md)，JDK 內部 API 與存取放寬另依[版本要求](version-policy.md)。

## 動態能力與存取邊界

本組由共通規範承接的要求：[受控目標與授權](../../../quality/security.md#dynamic-target-authorization)、[使用前驗證契約](../../../coding/type-safety.md#dynamic-contract-validation)。

<a id="java-dynamic-type-contract"></a>

### 明確需求與型別契約

反射與動態呼叫須有明確需求，已知的業務能力優先透過靜態型別契約表達。必要動態能力須集中於責任明確的元件，限制影響範圍並提供具型別的內部契約，不得藉此繞過型別安全要求。框架整合、外掛或通用工具的動態名稱與未知物件不得任意散入業務流程。

<a id="java-reflective-encapsulation"></a>

### 維持封裝與不變條件

反射與動態能力不得繞過可見性設計、建立驗證或業務不變條件。需要特殊存取時，優先採用受支援的整合方式；必要的存取放寬須個別核准並驗證影響，不得以框架、映射或測試用途自行豁免。例如不能以直接寫入私有欄位避開正式建立規則。

<a id="java-reflection-failure"></a>

### 區分故障與執行結果

依[區分故障與執行結果的共通要求](../../../coding/error-handling.md#dynamic-failure-classification)執行。Java 反射或動態呼叫的外層例外須保留原始原因。

## 檢查抑制與產生碼

<a id="java-warning-suppression"></a>

### 限定檢查抑制

依[限定檢查抑制的共通要求](../../../workflow/rule-governance.md#suppression-scope)執行。Java `@SuppressWarnings` 須限具體規則及最小範圍；raw type／unchecked 仍遵守型別與泛型規範的禁止事項及個別核准要求。

<a id="java-generated-code"></a>

### 產生碼不擴大豁免

依[產生碼不擴大豁免的共通要求](../../../workflow/rule-governance.md#generated-code-exceptions)執行。Java 產生碼須由來源／設定重建；手寫銜接維持完整型別檢查，重建後確認例外範圍仍適用。

<a id="java-dynamic-verification"></a>

### 驗證限制實際有效

依[驗證限制實際有效的共通要求](../../../quality/rule-verification.md#dynamic-control-verification)執行。Java 實際反射、存取及重新產生路徑依[本文件驗收要求](#驗收要求)，不只確認警告消失或成功目標能執行。

<a id="java-closing-requirements"></a>

## 補充要求

目標與操作權限另依[安全規範](../../../quality/security.md)，動態呼叫的失敗傳遞依[例外與資源管理](exceptions-and-resources.md)。建立與還原仍須遵守[類別、介面與物件建立](classes-and-construction.md)及[值物件規範](value-objects.md)。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。

### 共同驗收

- [受控目標與授權](../../../quality/security.md#acceptance-dynamic-target-authorization)。
- [使用前驗證契約](../../../coding/type-safety.md#acceptance-dynamic-contract)。
- [區分故障與執行結果](../../../coding/error-handling.md#acceptance-dynamic-failure)。
- [限定檢查抑制](../../../workflow/rule-governance.md#acceptance-suppression-scope)。
- [產生碼不擴大豁免](../../../workflow/rule-governance.md#acceptance-generated-code)。
- [驗證限制實際有效](../../../quality/rule-verification.md#acceptance-dynamic-controls)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-reflection-boundary"></a>[明確需求與型別契約](#java-dynamic-type-contract) | 審查動態能力的必要性、管理位置與內部型別契約。反射與動態呼叫均須納入，確認對內提供明確型別契約，動態名稱及未知物件沒有散入業務流程。 |
| <a id="acceptance-java-reflective-access"></a>[維持封裝與不變條件](#java-reflective-encapsulation) | 核對特殊存取的核准範圍，以及建立與還原不會繞過必要驗證或產出無效物件。對反射與動態能力核對特殊存取的必要性及受支援替代方式，經實際建立及還原路徑確認維持不變條件及封裝；例如私有欄位寫入或存取放寬亦不得繞過上述保證。 |

偏離禁止事項須依[例外核准流程](../../../workflow/rule-governance.md#例外核准)取得明確決策，不因工具限制自行放寬，也不得將核准擴及其他位置。
