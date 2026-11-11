# Java 命名、套件與文件

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[命名與可讀性](../../../coding/naming.md)、[程式碼設計與公開介面](../../../coding/code-design.md)及[模組責任與公開入口](../../../architecture/module-boundaries.md)，定義 Java 命名形式、套件組織與契約文件要求。

## 命名與套件責任

<a id="java-naming-form"></a>

### 一致的命名形式

Java 識別字須遵循一致的命名形式，並以業務概念與責任表達含義。類別、介面、列舉與 `record` 使用 `UpperCamelCase`；方法、欄位、參數與區域變數使用 `lowerCamelCase`；常數與列舉常數使用 `UPPER_SNAKE_CASE`；套件名稱使用小寫。團隊須統一縮寫慣例，避免同一概念大小寫不一致。不以 `final` 等修飾詞機械式判定常數，也不強制以 `I` 等名稱前綴標示介面。

**違反**

```java
// 類別、常數與方法未使用各自規定的命名形式。
class order_limit {
    static final int maxOrders = 10;
    boolean Accepts(int orderCount) { return orderCount <= maxOrders; }
}
```

**符合**

```java
// 類別、常數與方法分別使用規定的命名形式。
class OrderLimit {
    static final int MAX_ORDERS = 10;
    boolean accepts(int orderCount) { return orderCount <= MAX_ORDERS; }
}
```

**版本差異**

- Java 8：單獨的 `_` 作為識別字會產生編譯警告，仍須改用表達業務概念的名稱，不得以能編譯作為命名合規依據。（[JEP 213](https://openjdk.org/jeps/213)）
- Java 11：單獨的 `_` 自 Java 9 起是關鍵字，`var` 自 Java 10 起不能作為型別名稱；仍須使用符合大小寫形式且表達責任的名稱，不能只替換成另一個無意義名稱。（[JEP 213](https://openjdk.org/jeps/213)、[JEP 286](https://openjdk.org/jeps/286)）
- Java 17 起：`yield` 自 Java 14、`record` 自 Java 16、`sealed`／`permits` 自 Java 17 起不能作為型別名稱；名為 `yield` 的方法呼叫須加接收者或型別限定，仍須維持名稱與責任一致。這些限制區分大小寫，不代表 `Record` 或同名的合法欄位一律禁止。（[JEP 361](https://openjdk.org/jeps/361)、[JEP 395](https://openjdk.org/jeps/395)、[JEP 409](https://openjdk.org/jeps/409)、[JLS 3.8](https://docs.oracle.com/javase/specs/jls/se17/html/jls-3.html#jls-3.8)）

<a id="java-specific-responsibility"></a>

### 名稱表達具體責任

依[命名與可讀性](../../../coding/naming.md#domain-vocabulary-and-context)、[程式碼設計與公開介面](../../../coding/code-design.md)執行。Java 的 `Service`、`Handler`、`Helper`、`Utils` 可使用，但名稱須有明確責任且與行為一致。

**違反**

```java
// 日期工具的名稱與實際計算訂單總額的責任不一致。
class DateUtils {
    int total(List<Integer> amounts) {
        return amounts.stream().mapToInt(Integer::intValue).sum();
    }
}
```

**符合**

```java
// 訂單總額工具的名稱明確表達實際責任。
class OrderTotalUtils {
    int total(List<Integer> amounts) {
        return amounts.stream().mapToInt(Integer::intValue).sum();
    }
}
```

<a id="java-package-boundaries"></a>

### 套件與架構邊界

套件須依業務或技術責任及專案架構組織，明確區分公開契約與內部實作，不強制固定目錄排列。共用套件須有明確責任與依賴方向，不作為雜項收容處，也不得反向依賴使用它的業務模組。邊界須以可見性及適用檢查落實，不能只靠套件名稱。

**違反**

```java
// 訂單套件入口 OrderService 將內部儲存實作也公開，外部可直接依賴它。
public final class OrderService {
    public static final class OrderStorage {
        private final Map<String, Integer> amounts = new HashMap<>();
        public void save(String orderId, int amount) { amounts.put(orderId, amount); }
    }
    private final OrderStorage storage = new OrderStorage();
    public void save(String orderId, int amount) { storage.save(orderId, amount); }
}
```

**符合**

```java
// 訂單套件只公開入口 OrderService，內部儲存實作以套件可見性限制使用。
public final class OrderService {
    static final class OrderStorage {
        private final Map<String, Integer> amounts = new HashMap<>();
        public void save(String orderId, int amount) { amounts.put(orderId, amount); }
    }
    private final OrderStorage storage = new OrderStorage();
    public void save(String orderId, int amount) { storage.save(orderId, amount); }
}
```

**版本差異**

- Java 8：沒有 Java 9 引入的模組系統，以主範例的套件可見性配合依賴檢查維持公開契約與內部實作的同一保證；仍須檢查共用套件的依賴方向。（[JEP 261](https://openjdk.org/jeps/261)）
- Java 11：可用自 Java 9 起的 `module-info.java`，以 `requires` 宣告模組依賴、`exports` 公開契約套件，另以 `opens` 控制深層反射開放（`exports` 不等於 `opens`）；仍須保留適用的可見性與依賴檢查，不能因套件名稱含 `internal` 就推定實作已被封裝。（[JEP 261](https://openjdk.org/jeps/261)）

## 契約文件與維護

本組由共通規範承接的要求：[實作註解與暫時處理](../../../coding/code-design.md#implementation-notes)。

<a id="java-javadoc-contract"></a>

### 補足契約資訊

供使用端依賴的類別與方法須記錄型別及名稱無法充分表達的契約，依責任補充前置條件、結果、失敗、副作用與適用的生命週期保證。可包含非空、資源所有權、執行緒安全或資料時效等必要資訊，不要求每個方法套用全部項目。優先以 Javadoc 就近維護，或明確引用既有權威契約，避免重複定義；不以重述名稱代替說明。

**違反**

```java
// Javadoc 只重述名稱，使用端看不到前置條件與失敗契約。
class TextReader {
    /** 讀取文字。 */
    public String read(Path path) throws IOException {
        return Files.readString(path, StandardCharsets.UTF_8);
    }
}
```

**符合**

```java
// Javadoc 補充使用端所需的前置條件、結果與失敗契約。
class TextReader {
    /**
     * 讀取整個檔案的 UTF-8 文字，並於返回前關閉自行取得的資源。
     * @param path 非空的檔案路徑
     * @return 檔案文字，空檔案回傳空字串
     * @throws IOException 無法開啟或讀取檔案時
     */
    public String read(Path path) throws IOException {
        return Files.readString(path, StandardCharsets.UTF_8);
    }
}
```

**版本差異**

- Java 8：沒有 `Files.readString`，可用 `Files.readAllBytes` 搭配明確的 UTF-8 解碼器維持整檔讀取、解碼失敗回報及關閉自行取得資源的同一保證；仍須記錄前置條件、結果與失敗契約。（[`Files.readString` API `@since 11`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/nio/file/Files.html#readString(java.nio.file.Path,java.nio.charset.Charset))）
- Java 11：可用自 Java 11 起的 `Files.readString`，直接採主範例寫法；仍須說明 UTF-8、空檔案結果、資源生命週期與讀取失敗，不以方法名稱取代契約。（[`Files.readString` API `@since 11`](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/nio/file/Files.html#readString(java.nio.file.Path,java.nio.charset.Charset))）
- Java 21 起：可用自 Java 18 起的 Javadoc `{@snippet}` 就近展示契約用法，或引用外部範例檔；仍須保留必要契約敘述，並另外編譯及測試範例，Javadoc 產生成功不代表範例或語意正確。（[JEP 413](https://openjdk.org/jeps/413)）

**符合（Java 8）**

```java
import java.nio.ByteBuffer;
// 保留整檔讀取契約，明確以 UTF-8 解碼並回報不合法的位元組。
class TextReader {
    /**
     * 讀取整個檔案的 UTF-8 文字，並於返回前關閉自行取得的資源。
     * @param path 非空的檔案路徑
     * @return 檔案文字，空檔案回傳空字串
     * @throws IOException 無法開啟、讀取檔案或解碼時
     */
    public String read(Path path) throws IOException {
        return StandardCharsets.UTF_8.newDecoder()
            .decode(ByteBuffer.wrap(Files.readAllBytes(path))).toString();
    }
}
```

**符合（Java 21）**

```java
// 用文件片段補充呼叫方式，仍保留完整契約並另外驗證片段。
class TextReader {
    /** 讀取整個檔案的 UTF-8 文字，並於返回前關閉自行取得的資源。
     * {@snippet :
     * new TextReader().read(Path.of("orders.txt"));
     * }
     * @param path 非空的檔案路徑
     * @return 檔案文字，空檔案回傳空字串
     * @throws IOException 無法開啟或讀取檔案時
     */
    public String read(Path path) throws IOException {
        return Files.readString(path, StandardCharsets.UTF_8);
    }
}
```

<a id="java-rename-impact"></a>

### 重新命名與搬移的影響

類別、方法與套件重新命名或搬移時，須核對直接引用、設定、動態機制及外部使用端的影響。已構成公開或持久化契約的名稱，須依相容性要求處理，必要時安排遷移，並同步更新文件、範例與驗證。不僅依賴 IDE 重構結果，也不得因直接引用已更新就推定所有影響已處理。

**版本差異**

- Java 11：採用自 Java 9 起的模組系統時，搬移套件或型別除了更新直接引用，仍須核對 `module-info.java` 的 `exports`／`opens`、`uses`／`provides` 及外部服務或反射設定，維持原有公開契約與必要遷移。（[JEP 261](https://openjdk.org/jeps/261)）
- Java 17 起：`yield` 自 Java 14 起不能用於未限定的方法呼叫；遷移既有同名方法時可加接收者或型別限定來保留名稱，仍須核對動態引用與使用端相容性，不能只因 IDE 已更新直接呼叫就認定遷移完成。（[JEP 361](https://openjdk.org/jeps/361)）

<a id="java-document-verification"></a>

### 形式與語意分別驗收

依[形式與語意分別驗收的共通要求](../../../quality/rule-verification.md#document-verification)執行。Java 命名形式、Javadoc 參照及可執行範例須驗證實際結果；範例能在承諾支援的版本使用，不以文件產生成功代替內容正確。

**版本差異**

- Java 8／11：文件工具沒有 Java 18 引入的 `{@snippet}`，以 `{@code}` 展示並將範例另存為可編譯原始碼或測試，維持形式與語意分別檢查的同一保證；仍須在承諾支援的版本驗證範例。（[JEP 413](https://openjdk.org/jeps/413)）
- Java 17 起：使用 Java 17 的文件工具時仍沿用 `{@code}` 與獨立範例測試；較新文件工具即使成功產生文件，仍須以對應目標版本編譯及測試，不能據此推定舊版本可用。（[JEP 413](https://openjdk.org/jeps/413)）
- Java 21 起：可用自 Java 18 起的 `{@snippet file="TextReaderExample.java"}` 引用外部範例檔，將同一份檔案納入編譯與測試；仍須分別核對 Javadoc 參照、範例結果與契約語意，`javadoc` 本身不會編譯或執行片段。（[JEP 413](https://openjdk.org/jeps/413)）

<a id="java-closing-requirements"></a>

## 補充要求

共用責任與依賴另依[共通機制與程式碼共用](../../../architecture/shared-capabilities.md#shared-code)，泛型參數命名依[型別宣告與泛型](types-and-generics.md)。動態引用的核對依[反射、動態能力與檢查抑制](reflection-and-suppression.md)，名稱成為外部值時另依[相等性、雜湊與排序](equality-hashing-ordering.md)及[狀態與結果建模](states-and-results.md)的契約要求。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md#test-levels-and-cases)與[規範驗證](../../../quality/rule-verification.md#verification-coverage)。

### 共同驗收

- [註解與公開文件、實作註解與暫時處理](../../../coding/code-design.md#acceptance-document-contract)。
- [形式與語意分別驗收](../../../quality/rule-verification.md#acceptance-document-verification)。
- [審查清單](../../../quality/rule-verification.md#review-checklist)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-naming-form"></a>[一致的命名形式](#java-naming-form)、[名稱表達具體責任](#java-specific-responsibility) | 自動檢查適用的命名形式與團隊縮寫慣例，人工從使用處核對名稱與實際責任一致。確認未將所有 `final` 欄位機械式視為常數，也未用籠統後綴掩蓋不同用途。 |
| <a id="acceptance-java-package-boundaries"></a>[套件與架構邊界](#java-package-boundaries) | 審查套件責任、公開與內部界線，以及共用套件依賴方向；以適用的可見性與依賴檢查確認邊界有效，不僅核對目錄名稱。 |
| <a id="acceptance-java-javadoc-contract"></a>[補足契約資訊](#java-javadoc-contract) | 核對供使用端依賴的類別與方法優先以 Javadoc 就近維護必要契約，或明確引用既有權威契約；確認 Javadoc 與實際前置條件、結果、失敗、副作用及適用生命週期一致。 |
| <a id="acceptance-java-rename-paths"></a>[重新命名與搬移的影響](#java-rename-impact) | 重新命名或搬移後，核對直接引用、設定、動態登錄、序列化或持久化引用及外部使用端等適用路徑。確認相容性與必要遷移已有處置，文件與範例同步更新。 |
| <a id="acceptance-java-javadoc-examples"></a>[形式與語意分別驗收](#java-document-verification) | 驗證受影響的連結、Javadoc 參照與適用範例，確認在支援版本下可用。 |

既有程式碼與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行放寬要求。
