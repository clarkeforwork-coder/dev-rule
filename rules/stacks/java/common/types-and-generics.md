# Java 型別宣告與泛型

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[共通型別安全](../../../coding/type-safety.md)，適用於自行撰寫的 Java 程式碼，包含測試與整合元件。語法及 API 須符合[適用範圍與版本判定](version-policy.md)。

## 明確宣告與型別關係

<a id="java-explicit-types"></a>

### 明確宣告型別

參數、回傳值、欄位與區域變數須明確宣告型別，保留必要的泛型資訊，不使用 `var` 取代型別標註。

**違反**

```java
// 使用 var 省略區域變數的型別標註。
class Example {
    void prepare() {
        var names = List.of("Ada");
    }
}
```

**符合**

```java
// 區域變數明確宣告元素型別。
class Example {
    void prepare() {
        List<String> names = List.of("Ada");
    }
}
```

**版本差異**

- Java 8：沒有 `List.of`（Java 9 引入），以 `Collections.singletonList` 建立此單元素清單；仍須明確宣告 `List<String>`，維持元素型別資訊。（[List.of API @since 9](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html#of(E))）
- Java 11：區域變數 `var` 自 Java 10 起、Lambda 參數 `var` 自 Java 11 起可編譯，但會省略要求的型別標註，不得使用；仍須明確宣告型別。（[JEP 286](https://openjdk.org/jeps/286)、[JEP 323](https://openjdk.org/jeps/323)）

**符合（Java 8）**

```java
// 區域變數明確宣告元素型別，使用舊版的單元素清單工廠。
class Example {
    void prepare() {
        List<String> names = Collections.singletonList("Ada");
    }
}
```

<a id="java-generic-type-information"></a>

### 禁止 raw type 與不必要的型別抽象

使用泛型型別時須宣告型別參數，禁止 raw type。承載業務語意的參數、回傳值與欄位須保留業務所需的型別資訊，不得以 `Object`、萬用字元或無必要的泛型隱藏已知型別。泛型與萬用字元僅在確有型別抽象需求，且能維持必要約束與關聯時使用；不僅依所在層級或是否出現 `?` 判定合理性。

**違反**

```java
// 已知訂單型別卻以 Object 隱藏業務資訊。
record Order(String id) {}
class Example {
    private final Object order = new Order("A1");
}
```

**符合**

```java
// 欄位保留已知的訂單型別。
record Order(String id) {}
class Example {
    private final Order order = new Order("A1");
}
```

**版本差異**

- Java 8／11：`record` 自 Java 16 起（JEP 395）；沒有 `record`，以具名一般類別承載訂單；欄位仍須宣告為 `Order`，維持已知業務型別的同一保證。（[JEP 395](https://openjdk.org/jeps/395)）

**符合（Java 8）**

```java
// 具名一般類別與欄位宣告保留訂單型別。
final class Order {
    private final String id;
    Order(String id) { this.id = id; }
    String id() { return id; }
}
class Example {
    private final Order order = new Order("A1");
}
```

<a id="java-input-output-type-relation"></a>

### 輸入與輸出的型別關聯

依[型別安全](../../../coding/type-safety.md#containers-and-generics)執行。Java 泛型簽章須實際連結輸入與輸出的型別；特定業務操作直接使用其型別，不要求呼叫端轉型補回。

**違反**

```java
// 回傳 Object 使集合元素與回傳型別失去關聯。
class Example {
    static <T> Object first(List<T> values) {
        return values.get(0);
    }
}
```

**符合**

```java
// 同一型別參數連結輸入元素與回傳值。
class Example {
    static <T> T first(List<T> values) {
        return values.get(0);
    }
}
```

<a id="java-business-type-casts"></a>

### 不得以向下轉型補回業務型別

自行撰寫的程式碼不得以強制向下轉型補回遺失的業務型別資訊，應透過資料契約、泛型或多型設計保留型別。外部資料須在邊界完成驗證與明確型別轉換，不能讓型別不明的資料流入業務流程。工具或第三方 API 限制須依例外流程個別處理，不預先開放整合處例外。本項針對參考型別的向下轉型，數值轉換另依適用規範處理。

**違反**

```java
// 先遺失訂單型別，再以向下轉型補回。
record Order(String id) {}
class Example {
    String orderId(Object order) {
        return ((Order) order).id();
    }
}
```

**符合**

```java
// 參數契約保留訂單型別，不需向下轉型。
record Order(String id) {}
class Example {
    String orderId(Order order) {
        return order.id();
    }
}
```

**版本差異**

- Java 8／11：`record` 自 Java 16 起（JEP 395）；沒有 `record`，以具名一般類別搭配明確的 `Order` 參數契約，維持不靠向下轉型補回業務型別的同一保證。（[JEP 395](https://openjdk.org/jeps/395)）
- Java 17 起：`instanceof` 型別模式自 Java 16 正式發布，可將型別測試、轉換與變數宣告合併；用它猜回先前遺失的業務型別仍會破壞契約，不得以模式語法掩蓋此設計，仍須保留業務型別。（[JEP 394](https://openjdk.org/jeps/394)）

**符合（Java 8）**

```java
// 一般類別搭配明確參數契約，不需向下轉型。
final class Order {
    private final String id;
    Order(String id) { this.id = id; }
    String id() { return id; }
}
class Example {
    String orderId(Order order) {
        return order.id();
    }
}
```

**違反（Java 17）**

```java
// 先遺失業務型別，再用型別模式猜回，仍破壞參數契約。
record Order(String id) {}
class Example {
    String orderId(Object order) {
        if (order instanceof Order value) return value.id();
        throw new IllegalArgumentException("非訂單");
    }
}
```

<a id="java-type-safety-warnings"></a>

### 型別安全警告

新增或修改程式碼不得留下 raw type 或 unchecked 警告，須修正造成警告的契約與實作，不得以 `@SuppressWarnings` 或關閉檢查規避要求。工具限制須依例外流程個別核准，記錄影響範圍、型別安全依據與驗證方式。

**違反**

```java
// 以 @SuppressWarnings 抑制 raw type 與 unchecked 警告。
class Example {
    @SuppressWarnings({"rawtypes", "unchecked"})
    List<String> names() {
        List values = new ArrayList();
        values.add("Ada");
        return values;
    }
}
```

**符合**

```java
// 修正集合契約與實作，無須抑制型別安全警告。
class Example {
    List<String> names() {
        List<String> values = new ArrayList<>();
        values.add("Ada");
        return values;
    }
}
```

<a id="java-group-notes-explicit-types"></a>

### 本組補充說明

既有程式碼的漸進導入、工具產生碼與個別例外依[規範治理](../../../workflow/rule-governance.md)辦理。測試不得透過不安全轉型偽造有效物件，另見[測試程式碼要求](../../../coding/type-safety.md#acceptance)。

## 資料結構與泛型契約

<a id="java-business-data-shape"></a>

### 業務資料結構

依[型別安全](../../../coding/type-safety.md#containers-and-generics)執行。例如固定欄位資料不得改以 `Map<String, Object>` 或 `Object[]` 承載；真正動態的映射仍須保留明確鍵值型別。

**違反**

```java
// 固定的訂單欄位以任意鍵與 Object 值承載。
class Example {
    Map<String, Object> order() {
        return Map.of("id", "A1", "quantity", 2);
    }
}
```

**符合**

```java
// 固定欄位以具名且具明確型別的物件承載。
record Order(String id, int quantity) {}
class Example {
    Order order() {
        return new Order("A1", 2);
    }
}
```

**版本差異**

- Java 8／11：`record` 自 Java 16 起（JEP 395）；沒有 `record`，以具名一般類別宣告固定欄位與建構子；仍須保留各欄位型別，不得改用 `Map<String, Object>` 或 `Object[]`，維持資料結構的同一保證。（[JEP 395](https://openjdk.org/jeps/395)）

**符合（Java 8）**

```java
// 具名一般類別明確宣告固定的訂單欄位。
final class Order {
    private final String id;
    private final int quantity;
    Order(String id, int quantity) { this.id = id; this.quantity = quantity; }
    String id() { return id; }
    int quantity() { return quantity; }
}
class Example {
    Order order() {
        return new Order("A1", 2);
    }
}
```

<a id="java-generic-capabilities"></a>

### 型別能力與約束

泛型操作所需的型別能力與關聯，須透過型別參數、上界或明確的參數契約表達，不得依賴未宣告的型別假設、執行期猜測或強制轉型。無實際通用需求時，直接使用明確型別，不為使用泛型而額外建立介面。

**違反**

```java
// 泛型未宣告數值能力，依靠執行期轉型取值。
class Example {
    static <T> double total(List<T> values) {
        return values.stream().mapToDouble((T v) -> ((Number) v).doubleValue()).sum();
    }
}
```

**符合**

```java
// 上界明確表達各種數值型別都需提供的能力。
class Example {
    static <T extends Number> double total(List<T> values) {
        return values.stream().mapToDouble(Number::doubleValue).sum();
    }
}
```

<a id="java-collection-declarations"></a>

### 集合與映射的宣告型別

宣告型別須表達使用端所需的操作與語意，優先使用能完整表達契約的介面；不得過度泛化而迫使使用端轉型，也不應無必要地暴露具體實作類別。可修改性、排序方式等保證須依契約另行明訂，不僅憑集合介面推定。

**違反**

```java
// 使用端只需按索引讀取，卻無必要地要求具體實作。
class Example {
    String first(ArrayList<String> names) {
        return names.get(0);
    }
}
```

**符合**

```java
// List 介面已完整表達按索引讀取的需求。
class Example {
    String first(List<String> names) {
        return names.get(0);
    }
}
```

**版本差異**

- Java 21 起：可用新引入的 `SequencedCollection`、`SequencedSet`、`SequencedMap` 表達遍歷順序與首尾操作；只需首項的契約可用 `SequencedCollection`，需要索引時仍須使用 `List`，排序方式與可修改性仍須另行明訂。（[JEP 431](https://openjdk.org/jeps/431)）

**符合（Java 21）**

```java
// 只取遍歷順序的首項；呼叫端須提供非空集合，不要求索引操作。
class Example {
    String first(SequencedCollection<String> names) {
        return names.getFirst();
    }
}
```

<a id="java-diamond-construction"></a>

### 允許建構端使用菱形運算子

變數已明確宣告完整型別時，允許使用 `<>` 省略建構時重複的泛型參數；不得因此省略宣告端所需的型別資訊或改用 raw type。

**違反**

```java
// 建構端使用菱形運算子，宣告端卻使用 raw type，產生警告。
class Example {
    void prepare() {
        List names = new ArrayList<>();
    }
}
```

**符合**

```java
// 宣告端保留完整型別，建構端省略重複資訊。
class Example {
    void prepare() {
        List<String> names = new ArrayList<>();
    }
}
```

**版本差異**

- Java 8：匿名類別建構不能使用菱形運算子，以完整建構型別參數維持同一保證；宣告端仍須保留完整泛型資訊。（[JEP 213](https://openjdk.org/jeps/213)）
- Java 11：自 Java 9 起，匿名類別在推導型別可表示於簽章等限制下可用菱形運算子；宣告端仍須保留完整泛型資訊，匿名類別內非 `private` 方法須覆寫超型別方法。（[JEP 213](https://openjdk.org/jeps/213)）

**符合（Java 8）**

```java
// 匿名類別建構明寫型別參數，宣告端也保留元素型別。
class Example {
    void prepare() {
        List<String> names = new AbstractList<String>() {
            @Override public String get(int index) {
                if (index != 0) throw new IndexOutOfBoundsException();
                return "Ada";
            }
            @Override public int size() { return 1; }
        };
    }
}
```

**符合（Java 11）**

```java
// 匿名類別建構使用菱形運算子，宣告端仍保留元素型別。
class Example {
    void prepare() {
        List<String> names = new AbstractList<>() {
            @Override public String get(int index) {
                if (index != 0) throw new IndexOutOfBoundsException();
                return "Ada";
            }
            @Override public int size() { return 1; }
        };
    }
}
```

<a id="java-generic-return-types"></a>

### 泛型回傳值

回傳值須提供明確、可直接使用的型別；只有契約確實需要表達未知型別或其上下界時，才使用萬用字元，不得為預留彈性而增加使用端負擔，也不得以萬用字元取代不可變性設計。

**違反**

```java
// 訂單型別已知，卻以萬用字元增加使用端負擔。
record Order(String id) {}
class Example {
    List<?> orders() {
        return List.of(new Order("A1"));
    }
}
```

**符合**

```java
// 回傳值明確提供可直接使用的訂單元素型別。
record Order(String id) {}
class Example {
    List<Order> orders() {
        return List.of(new Order("A1"));
    }
}
```

**版本差異**

- Java 8：`record` 自 Java 16 起（JEP 395）；沒有 `List.of`（Java 9 引入）及 `record`，以 `Collections.singletonList` 與具名一般類別替代；回傳值仍須宣告 `List<Order>`，維持可直接使用元素型別的同一保證。（[List.of API @since 9](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html#of(E))、[JEP 395](https://openjdk.org/jeps/395)）
- Java 11：可用 Java 9 引入的 `List.of` 建立不可修改清單，訂單仍以一般類別承載；回傳值仍須宣告 `List<Order>`，不得以萬用字元代替不可變性設計。（[List.of API @since 9](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html#of(E))、[JEP 395](https://openjdk.org/jeps/395)）

**符合（Java 8）**

```java
// 一般類別與單元素清單保留可直接使用的回傳元素型別。
final class Order {
    private final String id;
    Order(String id) { this.id = id; }
    String id() { return id; }
}
class Example {
    List<Order> orders() {
        return Collections.singletonList(new Order("A1"));
    }
}
```

**符合（Java 11）**

```java
// 使用清單工廠仍明確宣告訂單元素型別。
final class Order {
    private final String id;
    Order(String id) { this.id = id; }
    String id() { return id; }
}
class Example {
    List<Order> orders() {
        return List.of(new Order("A1"));
    }
}
```

<a id="java-type-parameter-names"></a>

### 泛型參數命名

名稱須能辨識用途與關聯。簡單情境可使用 `T`、`K`、`V` 等通行慣例名稱；具有不同責任或較複雜關聯時，應使用能表達角色的名稱，例如 `Source` 與 `Target`，並在必要時補充契約說明，不強制所有泛型參數使用長名稱。

**違反**

```java
// 多階段契約的三種角色僅以無語意的編號區分。
interface Pipeline<T1, T2, T3> {
    T2 decode(T1 source);
    T3 process(T2 decoded);
    T1 encode(T3 result);
}
```

**符合**

```java
// 型別參數名稱表達來源、解碼資料與結果的角色。
interface Pipeline<Source, Decoded, Result> {
    Decoded decode(Source source);
    Result process(Decoded decoded);
    Source encode(Result result);
}
```

<a id="java-closing-requirements"></a>

## 補充要求

例如，下列宣告保留元素與鍵值型別，並允許建構端省略重複資訊；其中 `ordersById` 表達依識別碼查找訂單的關係，不是用任意欄位名稱拼湊單一訂單：

```java
List<Order> orders = new ArrayList<>();
Map<OrderId, Order> ordersById = new HashMap<>();
```

固定結構的訂單輸入則應使用明確物件，例如 `CreateOrderRequest`。邊界物件的拆分與映射責任另依[邊界物件](../../../architecture/boundary-objects.md#separation)與[資料映射](../../../architecture/data-mapping.md#mapping-ownership)。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更範圍核對下列項目，包含受影響的呼叫端與測試程式碼。測試層級及證據依[共通測試策略](../../../quality/testing.md#test-levels-and-cases)與[規範驗證](../../../quality/rule-verification.md#verification-coverage)；可自動判斷的要求依[規範驗證](../../../quality/rule-verification.md#verification-coverage)納入檢查，型別是否表達正確業務語意則由人工審查。

### 共同驗收

- [容器與泛型、禁止主動繞過檢查](../../../coding/type-safety.md#acceptance-data-shape)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-explicit-types"></a>[明確宣告型別](#java-explicit-types)、[允許建構端使用菱形運算子](#java-diamond-construction) | 檢查參數、回傳值、欄位與區域變數的明確宣告及泛型資訊，拒絕以 `var` 代替標註。允許的 `<>` 不得被誤判為 raw type，且宣告端須保留完整型別。 |
| <a id="acceptance-java-generic-relations"></a>[禁止 raw type 與不必要的型別抽象](#java-generic-type-information)、[輸入與輸出的型別關聯](#java-input-output-type-relation)、[型別能力與約束](#java-generic-capabilities) | 從實際呼叫處確認泛型的需求、約束及輸入輸出關聯，沒有用 `Object`、萬用字元或無依據的型別參數掩蓋業務型別。以代表性不相容型別案例確認適用的編譯檢查會拒絕。 |
| <a id="acceptance-java-unsafe-casts"></a>[不得以向下轉型補回業務型別](#java-business-type-casts)、[型別安全警告](#java-type-safety-warnings) | 啟用適用的 raw type 與 unchecked 警告檢查，確認新增與修改部分沒有違規，且未透過抑制或關閉檢查隱藏問題。審查向下轉型是否在補回遺失的業務型別；外部輸入以合法及不合法資料驗證邊界處理，必要例外須有核准及驗證依據。 |
| <a id="acceptance-java-generic-return"></a>[集合與映射的宣告型別](#java-collection-declarations)、[泛型回傳值](#java-generic-return-types) | 從使用端確認集合介面及回傳型別足以完成契約操作，不需要補做轉型；檢查暴露實作類別或萬用字元是否有必要，且未將其誤作不可變性保證。 |
| <a id="acceptance-java-type-parameter-names"></a>[泛型參數命名](#java-type-parameter-names) | 審查泛型參數名稱是否足以辨識責任及關聯，複雜契約有必要說明，不僅依名稱長度判定。 |

工具尚未涵蓋的要求須列入審查，不能將編譯通過視為全部符合。檢查設定的建立或調整須確認能偵測對應違規；既有違規基準不得放寬新增與修改部分的要求。
