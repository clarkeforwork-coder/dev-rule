# Java 適用範圍與版本判定

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

適用於 Java 應用程式、共用函式庫及多模組專案。以下要求由各專案依實際建置、交付及執行方式落實，並承接[開發共通規範](../../../README.md)。

## 版本宣告與相容性

<a id="java-version-declarations"></a>

### 分別記錄版本資訊

專案須記錄建置 JDK、編譯目標與標準函式庫 API 相容範圍，以及實際部署或承諾支援的 Java 執行版本。共用函式庫須明列使用端可依賴的支援範圍。

<a id="java-build-compatibility"></a>

### 建置設定落實限制

版本與相容性要求須寫入受版本控制的建置設定，本機與 CI 遵循一致規則。編譯時須限制允許的語言功能、標準 API 及產物位元碼格式。具體設定方式依適用 Java 版本及建置工具制定。

**版本差異**

- Java 8：JDK 8 的 `javac` 沒有 `--release`，以 JDK 8 平台類別搭配 `-source 8 -target 8` 限制語言、API 與位元碼；交叉編譯須配置目標平台的 `-bootclasspath`，仍須把完整設定納入版本控制。（[JEP 247](https://openjdk.org/jeps/247)）
- Java 11：可用自 Java 9 引入的 `--release N` 同時限制語言、標準 API 與位元碼，例如目標為 Java 8 時使用 `--release 8`；仍須確認建置工具實際傳入此設定，不能只設 `-source`／`-target`。（[JEP 247](https://openjdk.org/jeps/247)）
- Java 17 起：可沿用 `--release N` 指定編譯器支援的目標版本；仍須限制語言、標準 API 與位元碼，且不得把編譯通過當作目標執行環境的行為驗證。（[JEP 247](https://openjdk.org/jeps/247)）

<a id="java-runtime-verification"></a>

### 執行版本驗證

每個承諾支援的執行版本須有實際驗證依據，涵蓋適用的產物啟動、關鍵行為與依賴載入。函式庫須在使用端執行環境驗證載入與關鍵功能。驗證深度依風險決定，結果記錄於 CI 或發布流程。

**版本差異**

- Java 8／11：Java 9 起 server 組態的預設 GC 從 Parallel 改為 G1，跨 Java 8 與 11 驗證時仍須核對實際 GC、記憶體與關鍵行為，不能用較新環境通過代替舊版證據；執行期差異，範例不驗證。（[JEP 248](https://openjdk.org/jeps/248)）
- Java 17 起：CMS 自 Java 14 移除，沿用 CMS 設定可能影響啟動與 GC 選擇；仍須在每個承諾環境驗證實際啟動參數與關鍵行為；執行期差異，範例不驗證。（[JEP 363](https://openjdk.org/jeps/363)）
- Java 21 起：Java 21 可選用分代 ZGC，仍須依實際選用的 GC 驗證記憶體與關鍵行為，不能以可選機制推定效能符合；執行期差異，範例不驗證。（[JEP 439](https://openjdk.org/jeps/439)）

<a id="java-module-versions"></a>

### 多模組版本要求

各模組可依部署與使用需求採不同版本要求，但須逐模組明訂編譯目標、支援範圍及依賴關係。共用模組須符合使用端承諾的相容範圍，並完成對應驗證。

**版本差異**

- Java 8：沒有自 Java 9 引入的 JPMS，以建置模組與 classpath 管理依賴，仍須逐模組明訂目標與使用端相容範圍；Multi-Release JAR 在 Java 8 使用根目錄類別，須驗證該路徑。（[JEP 261](https://openjdk.org/jeps/261)、[JEP 238](https://openjdk.org/jeps/238)）
- Java 11：可採用 JPMS 或自 Java 9 引入的 Multi-Release JAR；仍須按實際 module-path／classpath 與所選版本類別驗證使用端，不以單一載入路徑通過代表全部相容。（[JEP 261](https://openjdk.org/jeps/261)、[JEP 238](https://openjdk.org/jeps/238)）
- Java 17 起：可沿用 JPMS 與 Multi-Release JAR；仍須逐模組限制相容範圍，並驗證各承諾執行版本實際選取的類別與依賴。（[JEP 261](https://openjdk.org/jeps/261)、[JEP 238](https://openjdk.org/jeps/238)）

<a id="java-group-notes-version-declarations"></a>

### 版本宣告與相容性補充說明

例如，建置 JDK 與部署環境使用 Java 21，而產物承諾相容 Java 17 時，編譯須維持 Java 17 的語言、API 及位元碼限制，並有 Java 17 與實際部署環境的驗證依據。

## 依賴、升級與特殊功能

<a id="java-dependency-versions"></a>

### 依賴版本要求

新增或升級依賴時，須核對直接與間接依賴的 Java 版本要求。若超出專案承諾的執行範圍，須先決定保留相容版本、替換依賴或安排專案升級，完成相容性處置後才能採用。[第三方套件與依賴管理](../../../workflow/dependencies.md#build-changes)

**版本差異**

- Java 11：JDK 自 Java 11 移除 JAXB、JAX-WS、CORBA 等指定模組，仍須盤點直接與間接依賴，改用相容的外部依賴或替代實作後驗證；不得用 `--add-modules` 假設可恢復已移除模組。（[JEP 320](https://openjdk.org/jeps/320)）
- Java 17 起：上述已移除模組仍須由相容外部依賴或替代實作承接，並核對其最低 Java 版本；不得因升級建置 JDK 而跳過既有使用端的相容性處置。（[JEP 320](https://openjdk.org/jeps/320)）

<a id="java-build-upgrade"></a>

### 建置升級與支援範圍變更

升級建置 JDK 須維持既有相容承諾。提高最低執行版本須獨立評估部署環境、函式庫使用端與回退需求，明訂遷移順序並完成驗證。對外提供的函式庫須明確告知新的最低版本。

<a id="java-preview-features"></a>

### Preview 功能

專案預設使用正式發布的語言功能與 API。採用 Preview 功能須由專案負責人核准，記錄用途、理由與影響範圍，明訂建置、測試、部署配套及後續升級的維護責任。環境配套無法滿足時，先採正式功能完成需求。

**版本差異**

- Java 8／11：沒有自 Java 12 引入的 Preview 機制，以正式功能完成需求，仍須維持專案承諾版本的語言與 API 限制。（[JEP 12](https://openjdk.org/jeps/12)）
- Java 17 起：Java 17 的 pattern switch 為 Preview，不得使用於規範範例；專案採用仍須依本小節核准並配套相同版本的編譯、測試及部署設定。（[JEP 406](https://openjdk.org/jeps/406)、[JEP 12](https://openjdk.org/jeps/12)）
- Java 21 起：Java 21 的 pattern switch 已正式發布，但 `StructuredTaskScope`、`ScopedValue`、string templates 與 unnamed patterns／variables 為 Preview，不得使用於規範範例；專案採用仍須依本小節核准並明訂升級維護責任。（[JEP 441](https://openjdk.org/jeps/441)、[JEP 453](https://openjdk.org/jeps/453)、[JEP 446](https://openjdk.org/jeps/446)、[JEP 430](https://openjdk.org/jeps/430)、[JEP 443](https://openjdk.org/jeps/443)）

<a id="java-jdk-internals"></a>

### JDK 內部實作與存取限制

專案預設依賴公開且受支援的 JDK API。需要存取內部實作或放寬存取限制時，須依例外流程個別核准，記錄原因、範圍、相關依賴與替代方案，明訂後續處置，並於 JDK 升級時重新驗證。

**違反**

```java
// 未經例外核准，嘗試放寬存取限制以讀取 JDK 私有欄位。
class IntegerReader {
    int read(Integer number) throws ReflectiveOperationException {
        java.lang.reflect.Field field = Integer.class.getDeclaredField("value");
        field.setAccessible(true);
        return field.getInt(number);
    }
}
```

**符合**

```java
// 使用公開且受支援的 API 取得整數值。
class IntegerReader {
    int read(Integer number) {
        return number.intValue();
    }
}
```

**版本差異**

- Java 8：尚無模組強封裝，不能以反射成功證明符合公開 API 要求；仍須審查內部 API 與私有欄位存取，必要使用依例外流程核准；執行期差異，範例不驗證。（[JEP 403](https://openjdk.org/jeps/403)）
- Java 11：部分 JDK 8 已存在套件仍預設允許 classpath 程式非法反射並警告；仍須個別核准必要存取，不得把警告或可執行視為授權；執行期差異，範例不驗證。（[JEP 403](https://openjdk.org/jeps/403)）
- Java 17 起：強封裝使未開放套件的深層反射失敗，`--illegal-access` 無法恢復舊行為；仍須優先使用公開 API，必要的 `--add-opens`／`--add-exports` 逐項記錄核准範圍並於升級時重驗；執行期差異，範例不驗證。（[JEP 403](https://openjdk.org/jeps/403)）

<a id="java-deprecated-api"></a>

### 棄用 API

新增或修改程式須優先採用符合專案版本範圍的替代 API。既有棄用 API 依移除風險與影響安排遷移，特別檢視已標示預定移除的項目。必要的持續使用須經例外核准，記錄原因、適用範圍與重新評估條件。

**違反**

```java
// 新增程式未經例外核准使用已預定移除的建構子，編譯會有警告。
class IntegerFactory {
    Integer create(int value) {
        return new Integer(value);
    }
}
```

**符合**

```java
// 改用 Java 17 支援的替代 API。
class IntegerFactory {
    Integer create(int value) {
        return Integer.valueOf(value);
    }
}
```

**版本差異**

- Java 8：沒有自 Java 9 引入的 `@Deprecated.forRemoval`，以 API 文件及遷移清單辨識移除風險；`Integer(int)` 此版尚未棄用，主違反範例的移除警告不能套用此版，仍須依實際棄用項目安排遷移與例外核准。（[JEP 277](https://openjdk.org/jeps/277)、[Integer Java 8 API](https://docs.oracle.com/javase/8/docs/api/java/lang/Integer.html)）
- Java 11：可用自 Java 9 引入的 `forRemoval` 區分預定移除項目；`Integer(int)` 自 Java 9 棄用但此版尚未標為預定移除，仍須優先使用相容替代 API 並記錄必要例外。（[JEP 277](https://openjdk.org/jeps/277)、[JEP 390](https://openjdk.org/jeps/390)）
- Java 17 起：`Integer(int)` 自 Java 16 標為預定移除，可利用移除警告辨識主違反範例的風險；仍須以 `Integer.valueOf` 等符合支援範圍的 API 遷移，不能只壓掉警告。（[JEP 390](https://openjdk.org/jeps/390)、[JEP 277](https://openjdk.org/jeps/277)）

<a id="java-group-notes-dependency-versions"></a>

### 依賴、升級與特殊功能補充說明

Preview 的採用紀錄及其他例外均依[規範治理](../../../workflow/rule-governance.md)管理。既有程式碼依相同文件的漸進導入要求處理。

## 工具、環境與發布追溯

<a id="java-toolchain-compatibility"></a>

### 建置與驗證工具相容性

Java 版本變更須評估參與編譯、測試、分析及產物處理的工具，包含適用的建置工具、編譯外掛、註解處理器、測試執行器與覆蓋率工具。須確認必要檢查實際執行，且產生的程式碼或其他產物符合版本承諾。

**版本差異**

- Java 11：可用自 Java 9 引入的統一 GC 日誌 `-Xlog:gc*`；仍須確認日誌分析工具支援實際格式，不能以舊解析器未報錯推定檢查已執行；執行期差異，範例不驗證。（[JEP 271](https://openjdk.org/jeps/271)）
- Java 17 起：可沿用統一 GC 日誌，仍須在工具升級時驗證採集與分析確實執行並保留結果；執行期差異，範例不驗證。（[JEP 271](https://openjdk.org/jeps/271)）
- Java 21 起：Java 21 動態載入 agent 會發出警告，仍須核對測試、分析與覆蓋率工具的 agent 載入方式及實際執行結果，不得把未執行的檢查計為通過；執行期差異，範例不驗證。（[JEP 451](https://openjdk.org/jeps/451)）

<a id="java-jdk-distribution"></a>

### JDK 發行商與完整版本

專案須記錄實際使用的 JDK 發行商與完整版本。允許多種發行版本時須明訂支援範圍。修補更新或更換發行商時，依影響驗證相容性並保留紀錄，例如啟動參數、外部連線與關鍵流程。

**版本差異**

- Java 8／11：預設字元集可能依作業系統與地區設定而異，仍須記錄實際發行商、完整版本及相關啟動設定，並驗證外部文字交換與關鍵流程；執行期差異，範例不驗證。（[JEP 400](https://openjdk.org/jeps/400)）
- Java 17 起：Java 17 仍使用環境相依的預設字元集，仍須核對實際環境與啟動設定，不得推定與 Java 21 相同；執行期差異，範例不驗證。（[JEP 400](https://openjdk.org/jeps/400)）
- Java 21 起：自 Java 18 起標準 API 的預設字元集為 UTF-8（主控台 I/O 除外），仍須核對 `file.encoding` 等實際設定並驗證發行版本變更後的外部連線與關鍵流程；執行期差異，範例不驗證。（[JEP 400](https://openjdk.org/jeps/400)）

<a id="java-artifact-traceability"></a>

### 產物與執行環境追溯

每個發布產物須可追溯實際建置 JDK、編譯目標、依賴版本與相容性驗證紀錄。部署後須能核對產物識別與實際 Java 執行環境，包含發行商、完整版本及相關啟動設定。可沿用專案既有建置與部署紀錄。

<a id="java-supported-versions"></a>

## 支援版本與基線

<a id="java-example-baseline"></a>

### 支援版本與主範例基線

本規範支援 Java 8、11、17、21；主範例以 Java 17 撰寫。專案版本低於 17 時，須依各小節「版本差異」條列與對應版本範例落實；高於 17 時主範例仍適用，「Java 21 起」條列是可選的新機制或加嚴。版本差異只描述落實方式，不得新增、放寬或免除任何要求。

<a id="java-version-lifecycle"></a>

### 新版本納入與版本退場

新 JDK 發布不自動成為支援版本，須先盤點對各主題的影響、驗證工具鏈後才加入清單。移除支援版本須依[建置升級與支援範圍變更](#java-build-upgrade)的既有流程決定，決定後從清單移除並清除該版本的條列與範例。

<a id="java-version-differences-index"></a>

### 版本差異索引

| 主題檔 | 小節 | 版本 | 摘要 |
| --- | --- | --- | --- |
| version-policy.md | [建置設定落實限制](version-policy.md#java-build-compatibility) | 8、11、17、21 | 舊工具鏈以目標平台類別限制 API，新工具鏈使用 --release。 |
| version-policy.md | [執行版本驗證](version-policy.md#java-runtime-verification) | 8、11、17、21 | 依預設 GC、CMS 移除與分代 ZGC 驗證實際執行行為。 |
| version-policy.md | [多模組版本要求](version-policy.md#java-module-versions) | 8、11、17、21 | 依 classpath、JPMS 與 Multi-Release JAR 的實際選取路徑驗證相容性。 |
| version-policy.md | [依賴版本要求](version-policy.md#java-dependency-versions) | 11、17、21 | JDK 移除的 JAXB、JAX-WS、CORBA 模組由相容外部依賴或替代實作承接。 |
| version-policy.md | [Preview 功能](version-policy.md#java-preview-features) | 8、11、17、21 | 精確區別各版 Preview 狀態，規範範例使用正式功能，專案採用仍依核准流程。 |
| version-policy.md | [JDK 內部實作與存取限制](version-policy.md#java-jdk-internals) | 8、11、17、21 | JDK 強封裝改變反射存取能力，存取成功與合規判定分屬不同層次。 |
| version-policy.md | [棄用 API](version-policy.md#java-deprecated-api) | 8、11、17、21 | 依 forRemoval 與 Integer 建構子的棄用階段辨識遷移風險。 |
| version-policy.md | [建置與驗證工具相容性](version-policy.md#java-toolchain-compatibility) | 11、17、21 | 驗證統一 GC 日誌解析與動態 agent 工具的實際執行。 |
| version-policy.md | [JDK 發行商與完整版本](version-policy.md#java-jdk-distribution) | 8、11、17、21 | 預設字元集改變時核對完整環境設定與外部交換流程。 |
| types-and-generics.md | [明確宣告型別](types-and-generics.md#java-explicit-types) | 8、11 | Java 8 以 singletonList 建立清單，各版範例沿用明確型別宣告。 |
| types-and-generics.md | [禁止 raw type 與不必要的型別抽象](types-and-generics.md#java-generic-type-information) | 8、11 | 以具名一般類別替代 record，欄位保留已知業務型別。 |
| types-and-generics.md | [不得以向下轉型補回業務型別](types-and-generics.md#java-business-type-casts) | 8、11、17、21 | 舊版以一般類別保留參數契約，型別模式只簡化檢查與轉型語法。 |
| types-and-generics.md | [業務資料結構](types-and-generics.md#java-business-data-shape) | 8、11 | 一般類別以明確型別的固定欄位替代 record。 |
| types-and-generics.md | [集合與映射的宣告型別](types-and-generics.md#java-collection-declarations) | 21 | Sequenced 介面可表達順序及首尾操作，索引及可修改性契約另行維持。 |
| types-and-generics.md | [允許建構端使用菱形運算子](types-and-generics.md#java-diamond-construction) | 8、11 | Java 8 匿名類別明寫建構型別參數，Java 9 起可依限制使用菱形。 |
| types-and-generics.md | [泛型回傳值](types-and-generics.md#java-generic-return-types) | 8、11 | 以一般類別及各版清單工廠保留明確 List<Order> 回傳型別。 |
| null-and-optional.md | [查詢的正常缺值](null-and-optional.md#java-query-absence) | 8、11 | 以 emptyList 或 List.of 表達多筆正常缺值，單筆仍回傳 Optional。 |
| null-and-optional.md | [取值與缺值處置](null-and-optional.md#java-optional-access) | 8、11 | 依 API 版本選用缺值分支與組合方法，維持業務語意及失敗分類。 |
| null-and-optional.md | [使用位置與狀態表達](null-and-optional.md#java-optional-positions) | 8、11、17、21 | 以封閉的普通類別階層或 sealed／record 分別表達三種更新狀態。 |
| null-and-optional.md | [集合內容的空值](null-and-optional.md#java-container-nulls) | 8、11、17、21 | 舊版先驗證再複製，集合工廠與 toList 的 null 行為不同。 |
| null-and-optional.md | [非空驗證的位置](null-and-optional.md#java-nonnull-validation) | 8、11、17、21 | 依版本在一般建構子或 record 緊湊建構子建立非空保證。 |
| value-objects.md | [建立專屬型別的條件](value-objects.md#java-dedicated-value-types) | 8、11、17、21 | 以不同一般類別或 record 保留訂單與客戶識別碼的型別區別。 |
| value-objects.md | [建立時保護不變條件](value-objects.md#java-value-construction-invariants) | 8、11、17、21 | 以一般或緊湊建構子集中驗證，工廠共用建立入口。 |
| value-objects.md | [不可變性](value-objects.md#java-value-immutability) | 8、11、17、21 | 依版本複製並包裝集合或使用 copyOf，record 與 reversed 檢視不自動隔離可變內容。 |
| value-objects.md | [值相等的條件](value-objects.md#java-value-equality) | 8、11、17、21 | 手寫或採 record 產生的相等方法，維持同型別的業務值語意與一致雜湊。 |
| value-objects.md | [正規化規則](value-objects.md#java-value-normalization) | 8、11、17、21 | 以一般或緊湊建構子統一正規化，再依正規化值判等。 |
| value-objects.md | [運算責任](value-objects.md#java-value-operations) | 8、11、17、21 | 一般類別與 record 都由領域元件協調外部匯率政策。 |
| value-objects.md | [資料還原](value-objects.md#java-value-restoration) | 8、11、17、21 | 區分一般類別與 record 的原生反序列化驗證入口，保證不外推到所有框架。 |
| value-objects.md | [一般類別與 record](value-objects.md#java-value-implementation) | 8、11、17、21 | 一般類別與 record 的值語意實作及預設字串表示有所不同。 |
| value-objects.md | [診斷字串與交換格式](value-objects.md#java-diagnostic-representation) | 8、11、17、21 | 一般類別與 record 都透過明確編碼維持交換格式，不依賴 toString。 |
| states-and-results.md | [各狀態的必要資料](states-and-results.md#java-required-state-data) | 8、11、17、21 | 依版本以封閉巢狀類別或 sealed 與 record 保護狀態必要資料。 |
| states-and-results.md | [處理完整性](states-and-results.md#java-exhaustive-result-handling) | 8、11、17、21 | 依版本以列舉分支、switch 運算式或 sealed 搭配 pattern switch 落實完整處理。 |
| states-and-results.md | [穩定的外部代碼](states-and-results.md#java-stable-external-codes) | 8、11、17、21 | 依版本使用 switch 敘述或運算式維持固定代碼映射並拒絕未知值。 |
| states-and-results.md | [封閉或允許擴充](states-and-results.md#java-model-extensibility) | 8、11、17、21 | 依版本以私有基底建構子與巢狀 final 子類別或 sealed／permits 保護封閉契約。 |
| boundary-mapping.md | [明確控制欄位及來源](boundary-mapping.md#java-mapping-fields) | 8、11 | final 類別取代 record，明列欄位與可信來源。 |
| boundary-mapping.md | [失敗明確回報](boundary-mapping.md#java-mapping-integrity) | 8、11 | final 類別取代 record，轉換失敗仍明確拋出。 |
| boundary-mapping.md | [保留更新意圖](boundary-mapping.md#java-update-intent) | 8、11、17、21 | 依版本以封閉巢狀類別、record／sealed 或 record pattern 與 pattern switch 表達更新意圖。 |
| boundary-mapping.md | [集合與可變元素的隔離](boundary-mapping.md#java-mutable-isolation) | 8、11、17、21 | 依版本逐一複製並包裝、使用 copyOf 或 toList；reversed 仍是共享檢視。 |
| boundary-mapping.md | [各方向分別定義](boundary-mapping.md#java-directional-mapping) | 8、11 | 不同 final 類別維持輸入與輸出契約分離。 |
| boundary-mapping.md | [明確維護責任](boundary-mapping.md#java-mapping-ownership) | 8、11 | final 類別搭配方法完成簡單映射，不強制 Mapper 層。 |
| boundary-mapping.md | [驗證實際映射路徑](boundary-mapping.md#java-mapping-verification) | 8、11 | final 結果類別與存取方法，測試仍走實際映射。 |
| classes-and-construction.md | [建構期間的安全性](classes-and-construction.md#java-construction-safety) | 21 | 建置 JDK 21 可用 this-escape 輔助檢查，仍審查所有建構路徑。 |
| classes-and-construction.md | [依需求選擇建立方式](classes-and-construction.md#java-construction-entrypoints) | 8、11、17、21 | 以一般類別建構子或 record 標準建構子集中驗證所有建立入口。 |
| classes-and-construction.md | [`super` 呼叫與 `final` 的擴充限制](classes-and-construction.md#java-override-scope) | 8、11、17、21 | 依版本以可見性與審查或 sealed 限制繼承，仍以固定入口保留必要檢查。 |
| equality-hashing-ordering.md | [明訂比較語意](equality-hashing-ordering.md#java-comparison-semantics) | 8、11、17、21 | 依版本採傳統轉型或 instanceof 型別模式，維持識別碼比較語意。 |
| equality-hashing-ordering.md | [相等與雜湊契約](equality-hashing-ordering.md#java-equality-hash-contract) | 8、11、17、21 | 以一般類別手寫或 record 產生相等與雜湊，確認元件比較符合契約。 |
| equality-hashing-ordering.md | [雜湊集合中的穩定性](equality-hashing-ordering.md#java-hash-collection-stability) | 8、11、17、21 | 依版本以複製後封裝、集合工廠或防禦複製的 record 保持鍵穩定。 |
| equality-hashing-ordering.md | [跨型別相等範圍](equality-hashing-ordering.md#java-cross-type-equality) | 8、11、17、21 | 依版本以建構子可見性或 sealed 限制擴充，仍明訂跨型別相等範圍。 |
| equality-hashing-ordering.md | [自然順序與情境排序](equality-hashing-ordering.md#java-ordering-choice) | 8、11、17、21 | 一般類別與 record 均可實作自然順序，情境順序由 Comparator 表達。 |
| equality-hashing-ordering.md | [比較為零與相等性](equality-hashing-ordering.md#java-sorted-key-equivalence) | 8、11、17、21 | 一般類別與 record 的排序集合均以比較為零判同。 |
| collections-and-ownership.md | [明確定義修改權與參考關係](collections-and-ownership.md#java-collection-ownership) | 21 | 反向檢視與來源共享資料，其修改行為取決於來源集合。 |
| collections-and-ownership.md | [區分不可修改與不可變快照](collections-and-ownership.md#java-snapshots-and-views) | 8、11、17、21 | 舊版先複製再包裝，新版可收集不可修改結果，反向檢視並非隔離快照。 |
| collections-and-ownership.md | [順序與重複資料](collections-and-ownership.md#java-order-and-duplicates) | 11、21 | 工廠 Set／Map 不保證順序，SequencedCollection 表達順序而不決定重複值契約。 |
| collections-and-ownership.md | [限制資料累積](collections-and-ownership.md#java-bounded-accumulation) | 8、11、17、21 | 依版本用 limit 或有界產生器限制來源，再排序並收集不可修改結果。 |
| collections-and-ownership.md | [延遲讀取的資源責任](collections-and-ownership.md#java-lazy-resource-lifetime) | 8、11、17、21 | 依版本採 collect 包裝或 toList，皆在資源範圍內完成終端操作。 |
| collections-and-ownership.md | [批次修改的失敗保證](collections-and-ownership.md#java-batch-failure-state) | 8、11 | 依版本用 Arrays.asList 或 List.of 初始化，維持副本成功後才替換的失敗保證。 |
| exceptions-and-resources.md | [明確的故障分類](exceptions-and-resources.md#java-exception-classification) | 8 | 以讀取位元組及嚴格 UTF-8 解碼保留 IOException 故障分類。 |
| exceptions-and-resources.md | [Checked 與 Unchecked 的選擇](exceptions-and-resources.md#java-checked-unchecked) | 8 | 替代 readString 時保留受檢查契約及呼叫端處置責任。 |
| exceptions-and-resources.md | [捕捉範圍與處置相符](exceptions-and-resources.md#java-catch-scope) | 8 | 舊版讀取與解碼仍只將檔案不存在轉成缺值。 |
| exceptions-and-resources.md | [優先使用語言資源管理機制](exceptions-and-resources.md#java-resource-management) | 8、11、21 | 依版本採資源別名、既有變數 TWR 及 executor／HTTP client 的 AutoCloseable。 |
| exceptions-and-resources.md | [保留操作與清理失敗](exceptions-and-resources.md#java-suppressed-failures) | 8、11 | 別名與既有變數 TWR 均保留 suppressed 清理失敗。 |
| exceptions-and-resources.md | [有效期與關閉契約](exceptions-and-resources.md#java-resource-close-contract) | 8、11、21 | 舊版由擁有者安排關閉，新版 close 的等待行為與期限契約相關。 |
| numbers-dates-text.md | [依語意選擇數值型別](numbers-dates-text.md#java-numeric-representation) | 8、11、17、21 | 依版本以一般類別或 record 承載精確十進位。 |
| numbers-dates-text.md | [範圍與轉換檢查](numbers-dates-text.md#java-numeric-range-checks) | 21 | clamp 將值限制在區間內，與回報超限的契約語意不同。 |
| numbers-dates-text.md | [BigDecimal 判同語意](numbers-dates-text.md#java-decimal-equivalence) | 8、11、17、21 | 一般類別手寫判同、雜湊與排序，record 的元件相等仍受 BigDecimal 正規化影響。 |
| numbers-dates-text.md | [依業務語意選擇時間型別](numbers-dates-text.md#java-temporal-representation) | 8、11、17、21 | 一般類別或 record 均以 Instant 表示唯一時點。 |
| numbers-dates-text.md | [可控制的時間基準](numbers-dates-text.md#java-clock-source) | 8、11、17、21 | Clock 維持舊版注入；17 起可選 InstantSource。 |
| numbers-dates-text.md | [解析與輸出契約](numbers-dates-text.md#java-temporal-parsing-formatting) | 11、17、21 | CLDR 預設與更新可能改變既有輸入解析及輸出格式。 |
| numbers-dates-text.md | [邊界與環境差異驗收](numbers-dates-text.md#java-boundary-verification) | 21 | UTF-8 預設變更影響既有資料的編碼相容性驗證。 |
| lambda-and-stream.md | [意圖與可讀性優先](lambda-and-stream.md#java-intent-readability) | 8、11 | 以收集及不可修改包裝取代 toList，保留具名計價責任。 |
| lambda-and-stream.md | [明確的參數型別](lambda-and-stream.md#java-lambda-parameter-types) | 8、11 | 舊版收集保留結果保證，Java 11 的 Lambda var 不改變既有明確型別寫法。 |
| lambda-and-stream.md | [明確累積結果](lambda-and-stream.md#java-result-accumulation) | 17、21 | toList 只供不可修改結果，需可修改結果時保留 toCollection。 |
| lambda-and-stream.md | [延遲與短路範圍](lambda-and-stream.md#java-lazy-short-circuit) | 11 | 前綴與有限產生 API 改變消費範圍，短路仍可能略過後續資料。 |
| lambda-and-stream.md | [平行處理的採用條件](lambda-and-stream.md#java-parallel-stream-adoption) | 21 | 虛擬執行緒不消除平行 Stream 的 common pool 資源評估與量測責任。 |
| lambda-and-stream.md | [維持錯誤分類](lambda-and-stream.md#java-failure-classification) | 8 | 以讀取位元組及嚴格解碼取代 readString，保留 IOException 契約。 |
| lambda-and-stream.md | [明確消費範圍](lambda-and-stream.md#java-stream-consumption) | 8 | 防禦性複製及不可修改包裝維持快照，各自建立 Stream。 |
| concurrency-and-async.md | [統一管理執行資源](concurrency-and-async.md#java-execution-resources) | 21 | 虛擬執行緒逐工作建立，仍由擁有者管理並以共用 Semaphore 限制下游容量。 |
| concurrency-and-async.md | [等待期限與逾時處置](concurrency-and-async.md#java-deadline-budget) | 8、11 | 舊版以 Future.get 承接預算，較新版逾時結果 API 不會自動停止底層工作。 |
| concurrency-and-async.md | [取消傳遞與實際停止](concurrency-and-async.md#java-cancellation-propagation) | 21 | StructuredTaskScope 為 Preview，仍沿工作控制物件傳遞取消並追蹤停止。 |
| concurrency-and-async.md | [`Future` 與 `CompletableFuture` 的結果鏈](concurrency-and-async.md#java-result-reception) | 8 | 改用 java.util.logging 記錄故障，保留原結果鏈。 |
| concurrency-and-async.md | [多工作組合的完成條件](concurrency-and-async.md#java-task-completion) | 21 | StructuredTaskScope 為 Preview，仍以正式結果組合 API 落實完成契約。 |
| concurrency-and-async.md | [執行位置與阻塞行為](concurrency-and-async.md#java-execution-location) | 21 | Java 21 虛擬執行緒持 monitor 阻塞時可能釘住載體執行緒。 |
| concurrency-and-async.md | [明確傳遞與清理脈絡](concurrency-and-async.md#java-context-propagation) | 21 | ScopedValue 為 Preview，正式功能範例沿用明確傳值及 ThreadLocal 清理或還原。 |
| concurrency-and-async.md | [鎖定範圍與取得策略](concurrency-and-async.md#java-lock-scope) | 21 | 避免長阻塞釘住時仍保留完整原子範圍及所有退出路徑的解鎖。 |
| concurrency-and-async.md | [受控關閉](concurrency-and-async.md#java-controlled-shutdown) | 21 | close 無期限等待，有期限契約仍使用 shutdown 與 awaitTermination。 |
| concurrency-and-async.md | [可控制的併發驗收](concurrency-and-async.md#java-controlled-verification) | 21 | join(Duration) 提供限時終止確認，仍檢查布林結果與工作結果。 |
| reflection-and-suppression.md | [維持封裝與不變條件](reflection-and-suppression.md#java-reflective-encapsulation) | 8、11、17、21 | 依版本審查特殊存取、JDK 強封裝與 record final 欄位限制，維持正式建立流程。 |
| reflection-and-suppression.md | [使用前驗證契約](reflection-and-suppression.md#java-dynamic-contract-validation) | 8、11、17、21 | 舊版先檢查型別再轉型，新版可用型別模式，均驗證契約版本。 |
| reflection-and-suppression.md | [區分故障與執行結果](reflection-and-suppression.md#java-reflection-failure) | 11、17、21 | 區分存取檢查與放寬失敗，強封裝下仍保留故障原因。 |
| reflection-and-suppression.md | [限定檢查抑制](reflection-and-suppression.md#java-warning-suppression) | 8、11、21 | 區分 deprecation、removal 及 this-escape，將抑制限定在具體規則與最小範圍。 |
| reflection-and-suppression.md | [產生碼不擴大豁免](reflection-and-suppression.md#java-generated-code) | 8、11、17、21 | 調整 Generated 註解與型別驗證語法，維持手寫銜接的型別檢查。 |
| reflection-and-suppression.md | [驗證限制實際有效](reflection-and-suppression.md#java-dynamic-verification) | 11、17、21 | 依版本使用封裝設定實測允許及拒絕路徑，不以編譯成功替代執行驗證。 |
| naming-packages-docs.md | [一致的命名形式](naming-packages-docs.md#java-naming-form) | 8、11、17、21 | 核對底線與受限型別名稱，保留有意義命名及合法的 yield 限定呼叫。 |
| naming-packages-docs.md | [套件與架構邊界](naming-packages-docs.md#java-package-boundaries) | 8、11 | 以套件可見性及依賴檢查維持邊界，採用 JPMS 時區分 exports 與 opens。 |
| naming-packages-docs.md | [補足契約資訊](naming-packages-docs.md#java-javadoc-contract) | 8、11、21 | 舊版以嚴格解碼實作整檔讀取，新版以 readString 與 snippet 保留契約說明。 |
| naming-packages-docs.md | [重新命名與搬移的影響](naming-packages-docs.md#java-rename-impact) | 11、17、21 | 搬移時核對模組與服務配置，遷移 yield 呼叫仍維持名稱相容性。 |
| naming-packages-docs.md | [形式與語意分別驗收](naming-packages-docs.md#java-document-verification) | 8、11、17、21 | code 與 snippet 的文件產生結果不等同範例的編譯與語意驗證。 |

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依本次變更與適用能力執行下列檢查，將結果連到受驗產物及其版本。測試層級、證據與執行門檻依[共通測試策略](../../../quality/testing.md#execution-gates-and-acceptance)與[規範驗證](../../../quality/rule-verification.md#verification-coverage)制定。

### 共同驗收

- [檢查配置可重現](../../../quality/rule-verification.md#reproducible-check-configuration)。
- [實際執行範圍](../../../quality/rule-verification.md#actual-check-scope)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-version-differences"></a>[支援版本與主範例基線](#java-example-baseline) | 版本差異須驗收：移除版本差異區塊後要求不變、版本事實有官方來源、版本範例可在對應 `--release` 編譯。 |
| <a id="acceptance-java-version-target"></a>[分別記錄版本資訊](#java-version-declarations)、[建置設定落實限制](#java-build-compatibility) | 核對版本宣告與實際建置設定。以不符合目標版本的語法或標準 API 案例，確認適用檢查會拒絕，並核對產物格式。 |
| <a id="acceptance-java-runtime-matrix"></a>[執行版本驗證](#java-runtime-verification)、[多模組版本要求](#java-module-versions) | 查核各承諾執行版本的實際驗證結果。多模組按依賴關係核對使用端與提供端的相容範圍，不能只依單一較新環境通過推論所有版本符合。 |
| <a id="acceptance-java-version-upgrade"></a>[依賴版本要求](#java-dependency-versions)、[建置升級與支援範圍變更](#java-build-upgrade) | 核對實際解析出的直接與間接依賴要求。提高最低版本時檢查使用端影響、遷移順序及回退安排，確認支援範圍變更已有明確決策。 |
| <a id="acceptance-java-api-exceptions"></a>[Preview 功能](#java-preview-features)、[JDK 內部實作與存取限制](#java-jdk-internals)、[棄用 API](#java-deprecated-api) | 依實際使用情形核對 Preview、內部 API、存取放寬與棄用 API 的紀錄。確認適用核准、環境配套、維護責任及重新評估條件，並驗證替代做法符合目標版本。 |
| <a id="acceptance-java-toolchain-compatibility"></a>[建置與驗證工具相容性](#java-toolchain-compatibility)、[JDK 發行商與完整版本](#java-jdk-distribution) | Java 環境或工具變更後，核對必要測試與分析確實執行，避免將被略過的檢查計為通過。確認產生碼與產物仍相容，並保留發行商及完整版本變更的驗證結果。 |
| <a id="acceptance-java-artifact-runtime"></a>[產物與執行環境追溯](#java-artifact-traceability) | 從指定發布產物查回建置環境、編譯目標、依賴與驗證紀錄，再核對部署環境中的實際產物及 Java 環境。 |

無法取得某個承諾版本的執行結果時，須列為尚未驗證，明示缺少的環境或證據。審查與合併條件依[Git、PR 與程式碼審查](../../../workflow/git-pr-review.md#merge-conditions-branch-protection)處理。
