# Java 語言規範

本目錄承接[開發共通規範](../../README.md)，制定 Java 語言的共同要求及版本差異。專案採用的版本、配置與核准例外記錄於各自專案。

Java 跨版本共用要求集中於 `common/`，此處的 common 不等於跨語言共通層。版本差異文件補充各版本的實作方式及適用條件，共同要求由主要文件維護。Framework 的機制與使用慣例由對應的 Framework 規範制定。

## 已制定文件

| 文件 | 內容 |
| --- | --- |
| [適用範圍與版本判定](common/version-policy.md) | 版本宣告、建置限制、執行驗證、多模組與依賴相容性、升級及發布追溯 |
| [型別宣告與泛型](common/types-and-generics.md) | 明確宣告、泛型約束與關聯、轉型限制、警告檢查、集合契約與命名 |
| [null 與 Optional](common/null-and-optional.md) | 非空契約、查詢缺值、取值處理、集合內容、第三方整合與 API 缺值轉換 |
| [專屬值型別與領域值物件](common/value-objects.md) | 建立驗證、不可變性、相等性、正規化、運算、還原與對外表示 |
| [狀態與結果建模](common/states-and-results.md) | 狀態資料、業務轉換、結果與失敗原因、完整處理、穩定代碼及擴充契約 |
| [邊界物件與資料映射](common/boundary-mapping.md) | 契約拆分、欄位來源、轉換責任、失敗與更新意圖、資料隔離及映射驗收 |
| [類別、介面與物件建立](common/classes-and-construction.md) | 能力契約、繼承與覆寫、建立條件、明確依賴、生命週期與共用狀態 |
| [相等性、雜湊與排序](common/equality-hashing-ordering.md) | 相等契約、Entity 識別、跨型別比較、自然順序、排序判同與集合穩定性 |
| [集合與資料所有權](common/collections-and-ownership.md) | 修改權、快照與檢視、順序與重複、複合操作、資料範圍與資源生命週期 |
| [例外與資源管理](common/exceptions-and-resources.md) | 故障分類、捕捉責任、中斷傳遞、資源所有權、失敗清理與關閉契約 |
| [數值、日期時間與文字處理](common/numbers-dates-text.md) | 精度與捨入、範圍檢查、時間語意與來源、編碼、文字長度及正規化 |
| [Lambda 與 Stream](common/lambda-and-stream.md) | 明確型別、可讀性、副作用、延遲與短路、平行處理、歸約及消費範圍 |
| [併發與非同步處理](common/concurrency-and-async.md) | 工作所有權、執行容量、可見性、期限與取消、結果組合、脈絡、鎖定及關閉 |
| [反射、動態能力與檢查抑制](common/reflection-and-suppression.md) | 動態目標、契約驗證、特殊存取、故障分類、最小抑制範圍與產生碼 |
| [命名、套件與文件](common/naming-packages-docs.md) | 命名形式與責任、套件邊界、Javadoc 契約、註解、重新命名及文件驗收 |

上述 15 份主題已依共通與語言責任整理。自動檢查的 9 項決策已整合至共通規範驗證、規範治理及 Git／PR，不另建立重複的 Java 治理政策。Java 8、11、17、21 的版本差異、Framework 規範及具體工具配置仍待制定。

## 驗收入口

各主題文件的「驗收要求」保留原決策編號與 Java 具體案例；執行時同時遵循所引用共通契約的驗收。必要檢查的對應、可重現設定、實際範圍、證據、有效門檻及安全診斷由[規範驗證](../../quality/rule-verification.md)維護；基準及抑制依[規範治理](../../workflow/rule-governance.md)，自動修正及合併依[Git／PR](../../workflow/git-pr-review.md)。

Java 專案須將宣告、泛型警告、空值、依賴邊界及版本限制等適用語言要求對應到實際編譯／分析／測試或人工審查；工具未涵蓋之處明列缺口。工具、規則版本與執行命令由專案依支援 JDK 及建置方式配置，不只依賴 IDE。

新增共通主題：[集合與資料所有權](../../coding/collections-and-ownership.md)、[資源生命週期](../../coding/resource-lifecycle.md)、[併發與非同步](../../coding/concurrency-and-async.md)、[數值、日期時間與文字](../../coding/numbers-dates-text.md)。
