# Java 類別、介面與物件建立

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[框架與依賴組裝](../../../architecture/dependency-composition.md)及[程式碼設計與公開介面](../../../coding/code-design.md)，定義 Java 類別契約、建立方式與生命週期的共同要求。具體 DI、代理與啟動配置由 Framework 規範及專案落實，仍須符合專案架構的依賴方向。

## 介面、繼承與建立條件

1. **介面的用途**。依[框架與依賴組裝](../../../architecture/dependency-composition.md)、[模組責任與公開入口](../../../architecture/module-boundaries.md)執行。Java 可依契約依賴介面或具體類別；單一實作不構成省略必要架構隔離的理由。
2. **繼承的可替代性**。依[繼承的可替代性的共通要求](../../../coding/code-design.md#cl-02)執行。Java 子類別須維持父型別輸入、結果及行為保證；僅共用實作時優先組合或委派。
3. **必要資料與依賴齊備**。依[必要資料與依賴齊備的共通要求](../../../coding/resource-lifecycle.md#cl-03)執行。Java 建構完成須具備必要資料與依賴；外部連線或背景工作不必放在建構子，依明確生命週期啟動。
4. **建構期間的安全性**。建構期間不得讓 `this` 外洩至可能使用該物件的外部元件，也不得呼叫可被覆寫的方法。事件註冊、回呼發布與背景工作啟動等行為，須在物件建立完成且符合生命週期條件後執行，避免使用尚未完成初始化的物件。

## 依賴、建立方式與擴充

5. **明確取得依賴**。依[明確取得依賴的共通要求](../../../architecture/dependency-composition.md#cl-05)執行。Java 服務透過明確依賴取得；需要延後或按次建立時使用工廠或提供者，不隱藏查全域容器、靜態服務登錄或單例。
6. **依需求選擇建立方式**。依[依需求選擇建立方式的共通要求](../../../coding/code-design.md#cl-06)執行。Java 可選建構子、具名工廠或 Builder；Builder 可暫存組裝中資料，但 `build` 不得產出無效物件。
7. **控制繼承與覆寫範圍**。類別與方法的繼承、覆寫範圍須依明確的擴充需求設計，不供擴充的部分應適當限制。必要業務檢查不得依賴子類別自行遵守才能成立，例如不能只靠子類別記得呼叫 `super`。框架需要的代理或繼承機制須與上述保證相容，不一律強制或禁止使用 `final`。
8. **介面的能力劃分**。依[介面的能力劃分的共通要求](../../../coding/code-design.md#cl-08)執行。Java 介面不機械式拆成單一方法；同一責任的操作可共用契約，執行時授權仍須另外檢查。

## 共用範圍與驗證

9. **生命週期與可變狀態相容**。依[生命週期與可變狀態相容的共通要求](../../../coding/resource-lifecycle.md#cl-09)執行。Java 共用服務的實例欄位不得存放會跨操作互相覆蓋的使用者或訂單；框架注入不代表執行緒安全或生命週期正確。
10. **契約與生命週期驗收**。依[契約與生命週期驗收的共通要求](../../../coding/resource-lifecycle.md#cl-10)執行。Java 建構、繼承、覆寫及框架代理須驗證實際路徑；單純值物件不必啟動完整框架。

專屬型別的建立與不可變性另依[值物件規範](value-objects.md)，狀態轉換依[狀態與結果建模](states-and-results.md)，非空條件依[null 與 Optional](null-and-optional.md)。授權限制仍依[安全規範](../../../quality/security.md)。

## 驗收要求

共同驗收直接依主要來源執行：[介面用途](../../../quality/rule-verification.md#acceptance-interface-purpose)、[可替代性](../../../coding/code-design.md#acceptance-substitutability)、[建立與就緒](../../../coding/resource-lifecycle.md#acceptance-initialization-readiness)、[依賴取得](../../../architecture/dependency-composition.md#acceptance-explicit-dependencies)、[建立入口](../../../coding/code-design.md#acceptance-construction-entrypoints)、[介面能力](../../../coding/code-design.md#acceptance-interface-capabilities)、[共享生命週期](../../../coding/resource-lifecycle.md#acceptance-shared-lifecycle)、[生命週期覆蓋](../../../coding/resource-lifecycle.md#acceptance-lifecycle-coverage)。

下表只列 Java 的驗收增量。依變更影響選擇適用案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。

| Java 條文 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-construction-safety"></a>4 | 審查 Java 建構路徑是否讓 `this` 外洩或呼叫可覆寫方法；以適用的註冊、回呼及背景啟動路徑確認物件完成建構且已就緒後才被使用。 |
| <a id="acceptance-java-override-safety"></a>7 | 核對 Java 類別與方法的擴充範圍及覆寫方式，確認必要檢查不依賴子類記得呼叫 `super`。涉及代理或繼承式框架機制時，驗證實際配置仍維持原保證，不一律以加上或移除 `final` 當作修正。 |

既有程式碼、框架限制與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行放寬要求。
