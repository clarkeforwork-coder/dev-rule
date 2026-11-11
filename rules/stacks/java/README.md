# Java 語言規範

本目錄承接[開發共通規範](../../README.md)，制定 Java 語言的共同要求及版本差異。專案採用的版本、配置與核准例外記錄於各自專案。

Java 跨版本共用要求集中於 `common/`，此處的 common 不等於跨語言共通層。版本差異文件補充各版本的實作方式及適用條件，共同要求由主要文件維護。Framework 的機制與使用慣例由對應的 Framework 規範制定。

## 已制定文件

| 文件 | 內容 |
| --- | --- |
| [適用範圍與版本判定](common/version-policy.md) | 說明 Java 建置、API 與執行版本的相容範圍，以及 JDK 工具鏈與發布產物的驗證追溯。 |
| [型別宣告與泛型](common/types-and-generics.md) | 說明 Java 明確型別宣告、泛型關聯與集合簽章，以及 raw type、向下轉型和型別警告的限制。 |
| [null 與 Optional](common/null-and-optional.md) | 說明 Java 的非空預設、Optional 使用與缺值處置，以及標註、第三方 API 和序列化邊界的空值契約。 |
| [專屬值型別與領域值物件](common/value-objects.md) | 說明 Java 專屬值型別的建立與還原，以及 final、record、相等方法和字串表示的值語意限制。 |
| [狀態與結果建模](common/states-and-results.md) | 說明 Java 狀態與結果型別、分支完整性，以及 enum 外部代碼和 sealed 模型的契約。 |
| [邊界物件與資料映射](common/boundary-mapping.md) | 說明 Java 欄位映射、反序列化與更新意圖，以及集合和可變元素在邊界轉換中的隔離。 |
| [類別、介面與物件建立](common/classes-and-construction.md) | 說明 Java 類別與介面的契約、建構安全及依賴取得，以及 Builder、覆寫和共用實例的生命週期限制。 |
| [相等性、雜湊與排序](common/equality-hashing-ordering.md) | 說明 Java equals、hashCode、Comparable 與 Comparator 的關係，以及雜湊和排序集合的穩定性。 |
| [集合與資料所有權](common/collections-and-ownership.md) | 說明 Java 集合的參考所有權、檢視與快照，以及遍歷修改、併發操作和延遲資源的行為限制。 |
| [例外與資源管理](common/exceptions-and-resources.md) | 說明 Java 例外分類與中斷傳遞，以及 AutoCloseable、try-with-resources 和清理失敗的資源契約。 |
| [數值、日期時間與文字處理](common/numbers-dates-text.md) | 說明 Java 數值轉換、BigDecimal、java.time 與 Clock 的語意，以及字串長度和格式轉換的邊界。 |
| [Lambda 與 Stream](common/lambda-and-stream.md) | 說明 Java Lambda 型別表達與 Stream 的延遲、短路、歸約和平行執行，以及副作用、失敗和消費範圍。 |
| [併發與非同步處理](common/concurrency-and-async.md) | 說明 Java 執行資源、可見性與同步，以及 Future 結果鏈、取消、期限和執行緒脈絡的處理。 |
| [反射、動態能力與檢查抑制](common/reflection-and-suppression.md) | 說明 Java 反射與動態元件的目標、型別及封裝限制，以及檢查抑制和產生碼的適用範圍。 |
| [命名、套件與文件](common/naming-packages-docs.md) | 說明 Java 識別字與套件命名、Javadoc 契約，以及重新命名、動態引用和範例的驗證。 |

內容欄摘要各文件的 Java 增量；由共通承接的主題見各文件分組下的指路句與共同驗收。

Java 8、11、17、21 的版本差異內嵌於各主題小節的主範例之後，依版本條列與對應範例閱讀；支援版本、主範例基線與差異索引見[支援版本與基線](common/version-policy.md#java-supported-versions)。Framework 規範及具體工具配置仍待制定。

## 驗收入口

驗收以唯一主要來源維護：共同案例引用共通文件，Java 只補語言機制的驗收增量。必要檢查的對應、可重現設定、實際範圍、證據、有效門檻及安全診斷由[規範驗證](../../quality/rule-verification.md)維護；基準及抑制依[規範治理](../../workflow/rule-governance.md)，自動修正及合併依[Git／PR](../../workflow/git-pr-review.md)。

Java 專案須將宣告、泛型警告、空值、依賴邊界及版本限制等適用語言要求對應到實際編譯／分析／測試或人工審查；工具未涵蓋之處明列缺口。工具、規則版本與執行命令由專案依支援 JDK 及建置方式配置，不只依賴 IDE。

相關共通主題：[集合與資料所有權](../../coding/collections-and-ownership.md)、[資源生命週期](../../coding/resource-lifecycle.md)、[併發與非同步](../../coding/concurrency-and-async.md)、[數值、日期時間與文字](../../coding/numbers-dates-text.md)。
