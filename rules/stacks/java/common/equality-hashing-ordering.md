# Java 相等性、雜湊與排序

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件延伸[專屬值型別與領域值物件](value-objects.md)的相等性要求，涵蓋 Entity、繼承關係及集合使用。型別與擴充設計另依[型別宣告與泛型](types-and-generics.md)及[類別、介面與物件建立](classes-and-construction.md)；ORM 代理等具體相容方式由 Framework 規範處理。

## 相等性與雜湊

<a id="java-comparison-semantics"></a>

### 明訂比較語意

依[明訂比較語意的共通要求](../../../coding/domain-modeling.md#identity-semantics)執行。Java `equals()` 須落實選定比較語意，不任意將 Entity 所有欄位納入比較。

**違反**

```java
// 約定依識別碼判同，卻把狀態也納入比較。
final class Order {
    enum Status { PENDING, CANCELLED }
    private final long id;
    private Status status = Status.PENDING;
    Order(long id) { this.id = id; }
    void cancel() { status = Status.CANCELLED; }
    @Override public boolean equals(Object other) {
        return other instanceof Order o && id == o.id && status == o.status;
    }
    @Override public int hashCode() { return Objects.hash(id, status); }
}
```

**符合**

```java
// 依識別碼判同，狀態差異不影響同一 Entity 的相等性。
final class Order {
    enum Status { PENDING, CANCELLED }
    private final long id;
    private Status status = Status.PENDING;
    Order(long id) { this.id = id; }
    void cancel() { status = Status.CANCELLED; }
    @Override public boolean equals(Object other) {
        return other instanceof Order o && id == o.id;
    }
    @Override public int hashCode() { return Long.hashCode(id); }
}
```

**版本差異**

- Java 8／11：沒有 `instanceof` 型別模式，以傳統 `instanceof` 判斷後轉型維持同一保證；仍須只比較約定的識別碼，不把 Entity 狀態納入判同。（型別模式自 Java 16 正式發布，[JEP 394](https://openjdk.org/jeps/394)）
- Java 17 起：可用 `instanceof` 型別模式合併型別檢查與變數宣告；仍須依選定語意比較，不因語法簡化改變相等範圍。（[JEP 394](https://openjdk.org/jeps/394)）

**符合（Java 8）**

```java
// 傳統型別判斷後轉型，仍只以識別碼判同。
final class Order {
    enum Status { PENDING, CANCELLED }
    private final long id;
    private Status status = Status.PENDING;
    Order(long id) { this.id = id; }
    void cancel() { status = Status.CANCELLED; }
    @Override public boolean equals(Object other) {
        if (!(other instanceof Order)) return false;
        Order o = (Order) other;
        return id == o.id;
    }
    @Override public int hashCode() { return Long.hashCode(id); }
}
```

<a id="java-equality-hash-contract"></a>

### 相等與雜湊契約

自訂 `equals()` 須維持自反、對稱、遞移與一致性，並正確處理 `null`。比較依據未改變時結果須一致，與 `null` 比較須不相等。須同時設計相容的 `hashCode()`，保證相等物件具有相同雜湊值，不得反過來以雜湊值相同判定相等。

**違反**

```java
// 雜湊碰撞不代表兩個值相等。
record Code(String value) {
    @Override public boolean equals(Object other) {
        return other instanceof Code c && hashCode() == c.hashCode();
    }
    @Override public int hashCode() { return Objects.hashCode(value); }
}
```

**符合**

```java
// 直接比較值並由相同的值計算雜湊。
record Code(String value) {
    @Override public boolean equals(Object other) {
        return other instanceof Code c && Objects.equals(value, c.value);
    }
    @Override public int hashCode() { return Objects.hashCode(value); }
}
```

**版本差異**

- Java 8／11：`record` 自 Java 16 起（JEP 395）；沒有 record 與 `instanceof` 型別模式，以 `final` 類別、傳統型別判斷與轉型實作相等及雜湊，維持同一保證；仍須以同一比較依據處理 `null`、相等與雜湊。（`instanceof` 型別模式自 Java 16 正式發布，[JEP 394](https://openjdk.org/jeps/394)、[JEP 395](https://openjdk.org/jeps/395)）
- Java 17 起：`record` 自 Java 16 起（JEP 395）；可用 record 產生依同一 record 型別及元件判同的 `equals()` 與相容 `hashCode()`；仍須確認元件比較符合契約，陣列元件的預設比較是參考相等，自訂方法時也須維持完整相等與雜湊契約。（[JEP 395](https://openjdk.org/jeps/395)、[Record API](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Record.html)，`@since 16`）

**符合（Java 8）**

```java
// 一般類別明確實作相容的值相等與雜湊。
final class Code {
    private final String value;
    Code(String value) { this.value = value; }
    @Override public boolean equals(Object other) {
        if (!(other instanceof Code)) return false;
        Code c = (Code) other;
        return Objects.equals(value, c.value);
    }
    @Override public int hashCode() { return Objects.hashCode(value); }
}
```

**符合（Java 17）**

```java
// 字串元件的值比較符合契約，採用 record 產生的相等與雜湊。
record Code(String value) {}
```

<a id="java-hash-collection-stability"></a>

### 雜湊集合中的穩定性

物件作為雜湊集合的鍵或元素期間，影響 `equals()` 與 `hashCode()` 的資料須保持不變。優先使用不可變且穩定的鍵，例如以 `OrderId` 作為訂單映射的鍵。必要變更須先移出、再修改並重新加入，處理可能與既有項目相等的情況，不得在集合內直接改變比較依據。

**違反**

```java
// 清單作為雜湊集合元素時，仍直接修改影響判同的內容。
class Example {
    void run() {
        List<Integer> key = new ArrayList<>(List.of(1));
        Set<List<Integer>> keys = new HashSet<>();
        keys.add(key);
        key.set(0, 2);
    }
}
```

**符合**

```java
// 使用不可變清單，集合內元素的比較依據保持穩定。
class Example {
    void run() {
        List<Integer> key = List.of(1);
        Set<List<Integer>> keys = new HashSet<>();
        keys.add(key);
    }
}
```

**版本差異**

- Java 8：沒有 `List.of`，以複製後的清單加上 `Collections.unmodifiableList` 維持同一保證；仍須避免可變來源或元素改變鍵的相等與雜湊，唯讀檢視本身不能隔離來源修改。（[List.of API](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html#of(E))，`@since 9`）
- Java 11：可用自 Java 9 起的 `List.of` 建立不可修改清單，或自 Java 10 起的 `List.copyOf` 隔離來源清單的結構變更；仍須確保元素的比較依據穩定，兩者皆不會深層複製元素。（[List API](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html)，`of @since 9`、`copyOf @since 10`）
- Java 17 起：`record` 自 Java 16 起（JEP 395）；可用 record 宣告鍵，但其元件欄位的 `final` 不會凍結可變元件；仍須防禦複製並保持元件比較依據穩定，避免自動產生的雜湊隨內容改變。（[JEP 395](https://openjdk.org/jeps/395)）

**符合（Java 8）**

```java
// 複製清單後封裝，整數元素的比較依據也保持不變。
class Example {
    void run() {
        List<Integer> key = Collections.unmodifiableList(
                new ArrayList<>(Arrays.asList(1)));
        Set<List<Integer>> keys = new HashSet<>();
        keys.add(key);
    }
}
```

**符合（Java 11）**

```java
// 將來源清單複製為不可修改清單，整數元素保持穩定。
class Example {
    void run() {
        List<Integer> source = new ArrayList<>(List.of(1));
        List<Integer> key = List.copyOf(source);
        Set<List<Integer>> keys = new HashSet<>();
        keys.add(key);
    }
}
```

**符合（Java 17）**

```java
// 清單元件先複製，確保 record 鍵的相等與雜湊保持穩定。
record Key(List<Integer> values) {
    Key { values = List.copyOf(values); }
}
class Example {
    void run() {
        Set<Key> keys = new HashSet<>();
        keys.add(new Key(new ArrayList<>(List.of(1))));
    }
}
```

<a id="java-entity-identity-lifecycle"></a>

### Entity 識別碼的生命週期

依[Entity 識別碼的生命週期的共通要求](../../../coding/domain-modeling.md#identity-lifecycle)執行。Java 沒有跨實例相等需求時不強制覆寫 `equals()`；識別碼變化不得破壞雜湊或排序集合契約。

**違反**

```java
// 配發識別碼時改變集合內 Entity 的雜湊值。
class Entity {
    Long id;
    @Override public boolean equals(Object other) { return this == other; }
    @Override public int hashCode() { return Objects.hashCode(id); }
    static void run() {
        Entity entity = new Entity();
        Set<Entity> entities = new HashSet<>();
        entities.add(entity);
        entity.id = 1L;
    }
}
```

**符合**

```java
// 無跨實例判同需求，保留物件身分語意以承受識別碼配發。
class Entity {
    Long id;
    static void run() {
        Entity entity = new Entity();
        Set<Entity> entities = new HashSet<>();
        entities.add(entity);
        entity.id = 1L;
    }
}
```

<a id="java-cross-type-equality"></a>

### 跨型別相等範圍

允許繼承的型別須明訂跨型別的相等範圍，父子型別不得各自採用互相矛盾的比較規則。新增子型別或比較欄位時，須維持對稱性、遞移性與雜湊契約；無法維持時，應調整型別關係或限制擴充。不一律指定使用 `instanceof` 或 `getClass()`，應先依契約決定哪些具體型別可以相等。

**違反**

```java
// 父型別接受子型別，子型別卻拒絕父型別，破壞對稱性。
class Base {
    @Override public boolean equals(Object other) { return other instanceof Base; }
    @Override public int hashCode() { return 0; }
}
class Child extends Base {
    @Override public boolean equals(Object other) { return other instanceof Child; }
}
```

**符合**

```java
// 約定僅同一具體型別相等，且子型別沿用同一比較規則。
class Base {
    @Override public final boolean equals(Object other) {
        return other != null && getClass() == other.getClass();
    }
    @Override public final int hashCode() { return getClass().hashCode(); }
}
class Child extends Base {}
```

**版本差異**

- Java 8／11：沒有 sealed 型別，需要限制擴充時可用私有建構子與巢狀子類別維持同一保證；仍須明訂允許相等的具體型別並維持對稱與遞移契約。（sealed 自 Java 17 正式發布，[JEP 409](https://openjdk.org/jeps/409)）
- Java 17 起：`record` 自 Java 16 起（JEP 395）；可用 `sealed` 與 `permits` 限制直接子型別；仍須明訂跨型別相等範圍，封閉繼承集合不會自動產生正確的 `equals()` 或 `hashCode()`，`record` 則隱含為 `final`，其預設相等性只接受同一 record 型別。（[JEP 409](https://openjdk.org/jeps/409)、[JEP 395](https://openjdk.org/jeps/395)）

**符合（Java 8）**

```java
// 私有建構子限制擴充，父子型別沿用僅同一具體型別相等的規則。
class Base {
    private Base() {}
    @Override public final boolean equals(Object other) {
        return other != null && getClass() == other.getClass();
    }
    @Override public final int hashCode() { return getClass().hashCode(); }
    static final class Child extends Base {}
}
```

**符合（Java 17）**

```java
// 封閉直接子型別，仍明確約定僅同一具體型別相等。
sealed class Base permits Child {
    @Override public final boolean equals(Object other) {
        return other != null && getClass() == other.getClass();
    }
    @Override public final int hashCode() { return getClass().hashCode(); }
}
final class Child extends Base {}
```

## 排序與集合判同

<a id="java-ordering-choice"></a>

### 自然順序與情境排序

只有型別具有明確且普遍適用的自然順序時，才實作 `Comparable`；依使用情境變動的排序須使用用途明確的 `Comparator`。排序規則須明訂比較欄位、方向與必要的同值處理，不將任意情境的順序固定為型別契約，也不要求所有可排序物件都實作 `Comparable`。

**違反**

```java
// 將促銷頁專用的價格排序固定成產品的自然順序。
record Product(long id, int price) implements Comparable<Product> {
    @Override public int compareTo(Product other) {
        return Comparator.comparingInt(Product::price)
                .thenComparingLong(Product::id).compare(this, other);
    }
}
```

**符合**

```java
// 促銷頁以用途明確的比較器按價格升冪，同價按識別碼升冪。
record Product(long id, int price) {
    static final Comparator<Product> PROMOTION_ORDER =
            Comparator.comparingInt(Product::price).thenComparingLong(Product::id);
}
```

**版本差異**

- Java 8／11：`record` 自 Java 16 起（JEP 395）；沒有 record，以一般類別宣告欄位及存取方法，並以用途明確的 `Comparator` 維持同一保證；仍須區分情境排序與自然順序，不因改用類別就加入 `Comparable`。（[JEP 395](https://openjdk.org/jeps/395)）
- Java 17 起：可用 record 宣告產品資料；仍須明訂排序契約，record 自動產生的成員不包含 `Comparable` 實作或情境比較器。（[JEP 395](https://openjdk.org/jeps/395)）

**符合（Java 8）**

```java
// 一般類別保留價格與識別碼存取方法，由促銷比較器定義情境排序。
final class Product {
    private final long id;
    private final int price;
    Product(long id, int price) { this.id = id; this.price = price; }
    long id() { return id; }
    int price() { return price; }
    static final Comparator<Product> PROMOTION_ORDER =
            Comparator.comparingInt(Product::price).thenComparingLong(Product::id);
}
```

<a id="java-comparator-relations"></a>

### 比較關係一致

`Comparable` 與 `Comparator` 須維持方向一致性、遞移性及比較為零時的一致關係。同次排序使用穩定的比較依據，不隱藏外部查詢或依賴持續變動的時間、設定與狀態；需要這些資訊時，先取得本次排序使用的固定資料。數值比較不得以可能溢位或損失精度的相減方式實作。

**違反**

```java
// 相減可能溢位，使比較方向錯誤。
class Example {
    static final Comparator<Integer> ASCENDING = (Integer left, Integer right) -> left - right;
}
```

**符合**

```java
// 使用整數比較方法，極端值也能維持正確方向。
class Example {
    static final Comparator<Integer> ASCENDING = Integer::compare;
}
```

<a id="java-sorted-key-equivalence"></a>

### 比較為零與相等性

須明訂比較結果為零與 `equals()` 的關係。自然順序原則上應與相等性一致；情境排序可讓不同物件比較為零，但用於排序集合或映射時，須確認元素與鍵的判同語意符合契約，不得意外合併應分別保留的資料。例如僅按金額比較不同訂單，在列表排序中可合理，但用於 `TreeSet` 或 `TreeMap` 時，須確認比較為零所造成的判同效果；必要時加入穩定識別等符合契約的次要依據。

**違反**

```java
// 集合須保留不同訂單，卻讓同金額的訂單判為同一元素。
record Order(long id, int amount) {}
class Example {
    Set<Order> orders() {
        Set<Order> orders = new TreeSet<>(Comparator.comparingInt(Order::amount));
        orders.add(new Order(1, 100));
        orders.add(new Order(2, 100));
        return orders;
    }
}
```

**符合**

```java
// 同金額時再按識別碼比較，保留不同訂單且比較為零與相等一致。
record Order(long id, int amount) {}
class Example {
    Set<Order> orders() {
        Set<Order> orders = new TreeSet<>(Comparator.comparingInt(Order::amount)
                .thenComparingLong(Order::id));
        orders.add(new Order(1, 100));
        orders.add(new Order(2, 100));
        return orders;
    }
}
```

**版本差異**

- Java 8／11：`record` 自 Java 16 起（JEP 395）；沒有 record，以一般類別手寫相等與雜湊，並以相同欄位組合比較器維持同一保證；仍須確認排序集合的比較為零與約定的相等性一致，不合併應保留的訂單。（[JEP 395](https://openjdk.org/jeps/395)）
- Java 17 起：可用 record 產生依元件判同的相等與雜湊；仍須自行設計排序比較器，使比較為零符合集合判同契約，record 不會產生自然順序。（[JEP 395](https://openjdk.org/jeps/395)）

**符合（Java 8）**

```java
// 相等與排序都依金額及識別碼，保留同金額的不同訂單。
class Example {
    static final class Order {
        final long id;
        final int amount;
        Order(long id, int amount) { this.id = id; this.amount = amount; }
        @Override public boolean equals(Object o) { return o instanceof Order && id == ((Order) o).id && amount == ((Order) o).amount; }
        @Override public int hashCode() { return Objects.hash(id, amount); }
    }
    Set<Order> orders() {
        Set<Order> orders = new TreeSet<>(Comparator.comparingInt((Order o) -> o.amount).thenComparingLong((Order o) -> o.id));
        Collections.addAll(orders, new Order(1, 100), new Order(2, 100));
        return orders;
    }
}
```

<a id="java-sorted-collection-stability"></a>

### 排序集合中的穩定性

物件作為排序集合的元素或排序映射的鍵期間，排序依據與比較規則須保持穩定。必要變更須先移出再重新加入，或依新規則重建結構，不得假設集合會自動重新排序。比較器設定變更同樣須處理既有結構，並確認資料未因判同規則而遺失。

**違反**

```java
// 直接修改排序集合內的排序依據，不會觸發自動重排。
class Item {
    int rank;
    static void run() {
        Set<Item> items = new TreeSet<>(Comparator.comparingInt((Item i) -> i.rank));
        Item item = new Item();
        items.add(item);
        item.rank = 2;
    }
}
```

**符合**

```java
// 先移出再修改排序依據，重新加入時明確處理判同衝突。
class Item {
    int rank;
    static void run() {
        Set<Item> items = new TreeSet<>(Comparator.comparingInt((Item i) -> i.rank));
        Item item = new Item();
        items.add(item);
        items.remove(item);
        item.rank = 2;
        if (!items.add(item)) throw new IllegalStateException("排序值已存在");
    }
}
```

<a id="java-relationship-coverage"></a>

### 關係與集合行為驗收

相等性、雜湊或排序規則新增及變更時，須驗證受影響的關係契約與實際集合行為，涵蓋適用的識別變化、跨型別比較、同值判定及修改後重新加入，不僅測試少數比較結果。不要求測試不適用的繼承或持久化情境，也不因使用工具產生方法就省略契約驗證。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md#test-levels-and-cases)與[規範驗證](../../../quality/rule-verification.md#verification-coverage)。

### 共同驗收

- [明訂比較語意](../../../coding/domain-modeling.md#acceptance-identity-semantics)。
- [Entity 識別碼的生命週期](../../../coding/domain-modeling.md#acceptance-identity-lifecycle)。

### Java 語言增量驗收

<a id="acceptance-java-relationship-coverage"></a>

依[關係與集合行為驗收](#java-relationship-coverage)，核對本次驗收同時涵蓋受影響的 Java 關係契約與實際集合操作；不能只測少數成對比較，也不能因方法由工具產生就省略驗證。

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-equality-hash-contract"></a>[相等與雜湊契約](#java-equality-hash-contract) | 對 Java `equals()` 驗證自反、對稱、遞移、一致性及 `null` 處理，並確認相等物件具有相同 `hashCode()`；不要求不同物件雜湊必不同，也不以雜湊相同判定相等。 |
| <a id="acceptance-java-hash-collection-stability"></a>[雜湊集合中的穩定性](#java-hash-collection-stability) | 以實際 Java 雜湊集合核對鍵或元素的查找、去重及移除；確認在集合內比較依據保持穩定。需要變更比較依據時，驗證先移出、修改再加入的結果及重複處置。 |
| <a id="acceptance-java-cross-type-equality"></a>[跨型別相等範圍](#java-cross-type-equality) | 對允許繼承的 Java 型別，以父子型別及必要的多物件組合驗證 `equals()` 的對稱、遞移與 `hashCode()` 契約；比較涉及框架代理時，經實際代理路徑驗證。 |
| <a id="acceptance-java-ordering-choice"></a>[自然順序與情境排序](#java-ordering-choice) | 審查 Java 型別採 `Comparable` 或用途明確的 `Comparator` 是否符合自然順序或情境排序的契約。 |
| <a id="acceptance-java-comparator-relations"></a>[比較關係一致](#java-comparator-relations) | 驗證 Java 比較器的方向、同值與遞移關係，以及同次排序比較依據的穩定性；涵蓋適用的極端數值，確認不以相減造成溢位或精度損失及錯誤順序。 |
| <a id="acceptance-java-sorted-key-equivalence"></a>[比較為零與相等性](#java-sorted-key-equivalence) | 核對比較為零與 `equals()` 的約定，將不同但排序值相同的資料放入實際採用的 Java 排序集合或映射，確認鍵判同及資料保留符合契約。 |
| <a id="acceptance-java-sorted-collection-stability"></a>[排序集合中的穩定性](#java-sorted-collection-stability) | 核對 Java 排序元素、鍵及比較器設定的變更路徑；驗證移出重加或重建後的順序、查找及資料保留，不依賴既有集合自動調整。 |

既有程式碼與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行放寬要求。
