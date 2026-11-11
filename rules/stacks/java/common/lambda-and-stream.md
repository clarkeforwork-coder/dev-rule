# Java Lambda 與 Stream

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[程式碼設計與公開介面](../../../coding/code-design.md)，定義 Java Lambda 與 Stream 的表達、執行及驗收要求。型別標註依[型別宣告與泛型](types-and-generics.md)，集合語意與資料規模依[集合與資料所有權](collections-and-ownership.md)，失敗與資源管理依[例外與資源管理](exceptions-and-resources.md)。

## 表達與狀態管理

<a id="java-intent-readability"></a>

### 意圖與可讀性優先

依[程式碼設計與公開介面](../../../coding/code-design.md#function-responsibilities)、[命名與可讀性](../../../coding/naming.md#operations-and-predicates)執行。Java Lambda／Stream 不強制取代迴圈；複雜或獨立責任採具名方法或清楚流程，不要求每個 Lambda 都抽方法。

**違反**

```java
// 計價責任直接混入篩選條件，難以辨識判斷意圖。
class Example {
    List<Integer> affordable(List<Integer> prices, int budget) {
        return prices.stream().filter((Integer price) -> {
            int discounted = price >= 100 ? price * 9 / 10 : price;
            int shipping = discounted >= 80 ? 0 : 10;
            return discounted + shipping <= budget;
        }).toList();
    }
}
```

**符合**

```java
// 將獨立計價責任放入具名方法，篩選條件直接表達意圖。
class Example {
    List<Integer> affordable(List<Integer> prices, int budget) {
        return prices.stream()
                .filter((Integer price) -> totalPrice(price) <= budget).toList();
    }
    int totalPrice(int price) {
        int discounted = price >= 100 ? price * 9 / 10 : price;
        int shipping = discounted >= 80 ? 0 : 10;
        return discounted + shipping;
    }
}
```

**版本差異**

- Java 8／11：沒有 Java 16 引入的 `Stream.toList()`，以收集後包裝為不可修改清單維持同一結果保證；仍須保留具名計價方法與清楚的篩選意圖。（[Stream.toList API @since 16](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/stream/Stream.html#toList())）

**符合（Java 8）**

```java
// 收集後封裝結果，仍以具名方法表達計價責任。
class Example {
    List<Integer> affordable(List<Integer> prices, int budget) {
        List<Integer> result = prices.stream()
                .filter((Integer price) -> totalPrice(price) <= budget)
                .collect(Collectors.toCollection(ArrayList::new));
        return Collections.unmodifiableList(result);
    }
    int totalPrice(int price) {
        int discounted = price >= 100 ? price * 9 / 10 : price;
        int shipping = discounted >= 80 ? 0 : 10;
        return discounted + shipping;
    }
}
```

<a id="java-lambda-parameter-types"></a>

### 明確的參數型別

自行宣告的 Lambda 參數須明確標示型別，不使用省略型別或 `var` 取代。方法參考可在型別契約完整且意圖清楚時使用，不要求機械式改寫成 Lambda；來源集合與相關契約仍須保留泛型資訊。呼叫目標或業務意義不清楚時，使用明確的 Lambda 或具名方法。

**違反**

```java
// 自行宣告的 Lambda 參數省略了型別。
class Example {
    List<String> nonEmpty(List<String> values) {
        return values.stream().filter(value -> !value.isEmpty()).toList();
    }
}
```

**符合**

```java
// 自行宣告的 Lambda 參數明確標示 String 型別。
class Example {
    List<String> nonEmpty(List<String> values) {
        return values.stream().filter((String value) -> !value.isEmpty()).toList();
    }
}
```

**版本差異**

- Java 8：沒有 Java 16 引入的 `Stream.toList()`，以收集及不可修改包裝維持同一結果保證；Lambda 參數仍須明確寫出 `String`。（[Stream.toList API @since 16](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/stream/Stream.html#toList())）
- Java 11：Lambda 參數自 Java 11 起可寫 `var`，會隱藏本小節要求的明確型別，不得以它取代 `String`；仍須使用明確型別，結果收集沿用 Java 8 寫法。（[JEP 323](https://openjdk.org/jeps/323)）

**符合（Java 8）**

```java
// 明確標示參數型別，收集後保留不可修改結果。
class Example {
    List<String> nonEmpty(List<String> values) {
        List<String> result = values.stream()
                .filter((String value) -> !value.isEmpty())
                .collect(Collectors.toCollection(ArrayList::new));
        return Collections.unmodifiableList(result);
    }
}
```

**違反（Java 11）**

```java
// var 雖可編譯，仍未明確寫出 Lambda 參數的 String 型別。
class Example {
    List<String> nonEmpty(List<String> values) {
        List<String> result = values.stream()
                .filter((var value) -> !value.isEmpty())
                .collect(Collectors.toCollection(ArrayList::new));
        return Collections.unmodifiableList(result);
    }
}
```

<a id="java-intermediate-side-effects"></a>

### 中間操作不隱藏業務副作用

Stream 的篩選、轉換及其他中間操作須避免隱藏業務副作用，`peek` 不得承擔必要業務操作。需要寫入或外部呼叫時，須以責任明確的執行步驟表達，並維持順序、失敗與部分成功保證；使用 `forEach` 也不免除上述責任。

**違反**

```java
// 必要的取消操作藏在 peek 中，不能保證執行。
class Example {
    static class Order { boolean cancelled; }
    void cancelAll(List<Order> orders) {
        orders.stream().peek((Order order) -> order.cancelled = true).count();
    }
}
```

**符合**

```java
// 逐項取消以明確迴圈依序執行，沒有隱藏在中間操作。
class Example {
    static class Order { boolean cancelled; }
    void cancelAll(List<Order> orders) {
        for (Order order : orders) {
            order.cancelled = true;
        }
    }
}
```

<a id="java-result-accumulation"></a>

### 明確累積結果

Lambda 與 Stream 的結果累積須使用明確的收集、歸約或流程設計，不得隱藏修改外部集合、計數器或旗標來影響元素處理。需要跨元素狀態時，須明確表達順序與管理責任，可使用清楚的迴圈或適當彙整，不為使用 Stream 而隱藏狀態。

**違反**

```java
// Lambda 修改外部集合來累積結果。
class Example {
    List<String> nonEmpty(List<String> values) {
        List<String> result = new ArrayList<>();
        values.stream().filter((String value) -> !value.isEmpty())
                .forEach((String value) -> result.add(value));
        return result;
    }
}
```

**符合**

```java
// 以收集機制明確累積結果。
class Example {
    List<String> nonEmpty(List<String> values) {
        return values.stream().filter((String value) -> !value.isEmpty())
                .collect(Collectors.toCollection(ArrayList::new));
    }
}
```

**版本差異**

- Java 17 起：可用 Java 16 引入的 `Stream.toList()` 明確累積不可修改結果；仍須符合結果的可變性契約，需要可修改清單時保留主範例的 `toCollection(ArrayList::new)`，不得直接替換。（[Stream.toList API @since 16](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/stream/Stream.html#toList())）

**符合（Java 17）**

```java
// 結果契約為不可修改清單時，以 toList 明確累積。
class Example {
    List<String> nonEmpty(List<String> values) {
        return values.stream().filter((String value) -> !value.isEmpty()).toList();
    }
}
```

## 執行、平行與歸約

<a id="java-lazy-short-circuit"></a>

### 延遲與短路範圍

使用 Stream 時須確認實際執行時機、終端操作與短路範圍，不得把流程建立視為工作完成，也不得假設所有元素都會被處理。契約要求完整驗證或逐項處理時，須選用能維持該保證的明確流程，不把必要工作藏在可能提前停止的操作中。

**違反**

```java
// 契約要求每筆都驗證，allMatch 卻在首筆失敗時短路。
class Example {
    boolean validateEveryItem(List<String> values, Predicate<String> validator) {
        return values.stream().allMatch(validator);
    }
}
```

**符合**

```java
// 每筆都呼叫驗證器，累積結果時不短路。
class Example {
    boolean validateEveryItem(List<String> values, Predicate<String> validator) {
        boolean valid = true;
        for (String value : values) {
            valid &= validator.test(value);
        }
        return valid;
    }
}
```

**版本差異**

- Java 11：自 Java 9 起可用 `takeWhile` 取得有序 Stream 的符合條件前綴、`dropWhile` 捨棄該前綴，或以三參數 `iterate` 限定產生範圍；仍須確認實際處理範圍，完整逐項驗證沿用主範例迴圈，不得用前綴處理取代。（[Stream API @since 9](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/stream/Stream.html#takeWhile(java.util.function.Predicate))）

**違反（Java 11）**

```java
// takeWhile 在失敗處結束前綴，無法滿足每筆都驗證的契約。
class Example {
    boolean validateEveryItem(List<String> values, Predicate<String> validator) {
        return values.stream().takeWhile(validator).count() == values.size();
    }
}
```

<a id="java-parallel-stream-adoption"></a>

### 平行處理的採用條件

採用平行 Stream 須有明確需求，先驗證資料隔離、順序、歸約與失敗語意，評估執行資源及阻塞影響，並以代表性負載量測確認收益。不得僅因資料量大或改寫方便就啟用平行處理，也不得忽略對其他工作及副作用保證的影響。

**版本差異**

- Java 21 起：在 Java 21 的虛擬執行緒內啟用平行 Stream，仍會使用與虛擬執行緒排程器不同的 common ForkJoinPool 執行平行工作；仍須評估阻塞、資源競爭並以代表性負載確認收益，不得因呼叫端改用虛擬執行緒就直接啟用平行處理；執行期差異，範例不驗證。（[JEP 444](https://openjdk.org/jeps/444)）

<a id="java-reduction-collection"></a>

### 歸約與收集契約

須明訂初始值、累積及合併規則，維持所需的結合性與結果語意。允許平行處理時，分段計算再合併也須符合契約。順序敏感的運算須採用能保留該順序的流程，例如逐步捨入不能任意改變分組。可變容器使用適當的收集機制，不以共用可變初始值造成資料互相污染。

**違反**

```java
// 求和的初始值錯設為一，空資料與分段合併都會多算。
class Example {
    int sum(List<Integer> values) {
        return values.stream().reduce(1, Integer::sum);
    }
}
```

**符合**

```java
// 求和以零作為單位元素，累積與合併均使用加法。
class Example {
    int sum(List<Integer> values) {
        return values.stream().reduce(0, Integer::sum);
    }
}
```

## 失敗、消費範圍與驗證

<a id="java-failure-classification"></a>

### 維持錯誤分類

Lambda 與 Stream 中的失敗須遵循既有錯誤分類，不得為配合函式介面而吞錯、回傳替代值或默默移除失敗項目。例外傳遞受介面限制時，須明確調整流程或依邊界契約轉換，保留原始原因，不以隱藏拋出或任意轉換規避要求。允許部分成功時，保留各筆結果與對應關係；技術故障仍依既有例外契約處理。

**違反**

```java
// 為配合函式介面而把讀取失敗替換成空字串，吞掉技術故障。
class Example {
    List<String> readAll(List<Path> paths) throws IOException {
        return paths.stream().map((Path path) -> {
            try { return Files.readString(path); }
            catch (IOException error) { return ""; }
        }).toList();
    }
}
```

**符合**

```java
// 改用明確迴圈，依方法契約傳遞原始 IOException。
class Example {
    List<String> readAll(List<Path> paths) throws IOException {
        List<String> result = new ArrayList<>();
        for (Path path : paths) {
            result.add(Files.readString(path));
        }
        return result;
    }
}
```

**版本差異**

- Java 8：沒有 Java 11 引入的 `Files.readString`，以 `Files.readAllBytes` 與預設回報解碼錯誤的 UTF-8 `CharsetDecoder` 維持同一保證；仍須傳遞讀取與解碼的 `IOException`，不得以替代字元掩蓋錯誤。（[Files.readString API @since 11](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/nio/file/Files.html#readString(java.nio.file.Path))、[CharsetDecoder API @since 1.4](https://docs.oracle.com/javase/8/docs/api/java/nio/charset/CharsetDecoder.html)）

**符合（Java 8）**

```java
import java.nio.ByteBuffer;
// 明確讀取並嚴格解碼，讓讀取與解碼失敗沿原契約傳遞。
class Example {
    List<String> readAll(List<Path> paths) throws IOException {
        List<String> result = new ArrayList<>();
        for (Path path : paths) {
            result.add(StandardCharsets.UTF_8.newDecoder()
                    .decode(ByteBuffer.wrap(Files.readAllBytes(path))).toString());
        }
        return result;
    }
}
```

<a id="java-stream-consumption"></a>

### 明確消費範圍

Stream 須有明確的消費範圍，不得在消費後重用，也不得讓多個流程共用同一實例各自消費。需要重複處理時，須明確選擇範圍受控的快照或重新取得資料，並定義一致性與資源生命週期。提供者能重新取得 Stream 不代表結果必定相同；涉及外部資源時，仍須明訂有效期與關閉責任。

**違反**

```java
// 已消費的 Stream 再次使用，第二次終端操作會失敗。
class Example {
    long countTwice(List<String> values) {
        Stream<String> stream = List.copyOf(values).stream();
        return stream.count() + stream.count();
    }
}
```

**符合**

```java
// 同一份不可變快照各自建立 Stream，消費範圍彼此獨立。
class Example {
    long countTwice(List<String> values) {
        List<String> snapshot = List.copyOf(values);
        return snapshot.stream().count() + snapshot.stream().count();
    }
}
```

**版本差異**

- Java 8：沒有 Java 10 引入的 `List.copyOf`，以防禦性複製、逐項拒絕 null 及不可修改包裝維持同一快照保證；仍須從快照各自建立 Stream，不得重用已消費的實例。（[List.copyOf API @since 10](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/List.html#copyOf(java.util.Collection))）

**符合（Java 8）**

```java
// 複製並封裝同一份快照，兩次處理分別建立 Stream。
class Example {
    long countTwice(List<String> values) {
        List<String> copy = new ArrayList<>(values);
        for (String value : copy) {
            Objects.requireNonNull(value);
        }
        List<String> snapshot = Collections.unmodifiableList(copy);
        return snapshot.stream().count() + snapshot.stream().count();
    }
}
```

<a id="java-execution-verification"></a>

### 執行語意驗收

Lambda 或 Stream 流程新增及變更時，須依影響驗證資料邊界、執行與短路範圍、順序、歸約、失敗及適用的資源保證。平行處理另須驗證隔離與實際效能，不僅確認一般案例的最終結果相同。不重測 Stream 函式庫本身，也不要求每段簡單轉換測試全部情境。

<a id="java-closing-requirements"></a>

## 補充要求

例如參數明確的 Lambda 與意圖清楚的方法參考，均可用於已具完整泛型資訊的來源：

```java
orders.stream().filter((Order order) -> order.isCancellable());
orders.stream().filter(Order::isCancellable);
```

上述片段僅示範篩選條件的表達，尚未消費結果，不代表已完成驗證或執行取消操作。

數值歸約涉及精度與捨入時依[數值、日期時間與文字處理](numbers-dates-text.md)；平行處理的量測依[效能與資源使用](../../../quality/performance.md#performance-measurement)。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md#test-levels-and-cases)與[規範驗證](../../../quality/rule-verification.md#verification-coverage)。

### 共同驗收

- [多步驟與部分成功](../../../coding/error-handling.md#acceptance-partial-operation)。
- [延遲讀取的資源責任](../../../coding/resource-lifecycle.md#acceptance-lazy-resource-lifetime)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-lambda-types"></a>[意圖與可讀性優先](#java-intent-readability)、[明確的參數型別](#java-lambda-parameter-types) | 審查流程意圖與責任是否清楚，複雜邏輯有合適表達；檢查 Lambda 參數明確標註、泛型資訊完整，方法參考可辨識目標與用途，不以縮短行數作為採用依據。 |
| <a id="acceptance-java-stream-side-effects"></a>[中間操作不隱藏業務副作用](#java-intermediate-side-effects)、[明確累積結果](#java-result-accumulation) | 審查中間操作及呼叫方法，確認沒有隱藏業務副作用或修改外部狀態。必要執行步驟的順序、失敗及部分完成有明確契約，跨元素狀態有管理責任。 |
| <a id="acceptance-java-stream-short-circuit"></a>[延遲與短路範圍](#java-lazy-short-circuit) | 以空資料、單筆、多筆及會短路的案例核對實際處理範圍，確認完整驗證或必要工作沒有因延遲與短路而遺漏，不把建立流程視為完成。 |
| <a id="acceptance-java-parallel-stream"></a>[平行處理的採用條件](#java-parallel-stream-adoption) | 採平行處理時，以代表性資料與負載確認結果、順序、隔離及失敗語意，評估阻塞與資源競爭影響，保留量測收益的依據。 |
| <a id="acceptance-java-stream-reduction"></a>[歸約與收集契約](#java-reduction-collection) | 驗證初始值、累積與合併結果；適用時以不同分段方式核對契約一致性。順序敏感運算保留約定順序，可變收集結果不受其他分段或執行污染。 |
| <a id="acceptance-java-functional-exceptions"></a>[維持錯誤分類](#java-failure-classification) | 在適用的處理階段觸發失敗，確認分類與原始原因保留，沒有以空值、替代值或篩除項目掩蓋問題。另核對 Lambda／Stream 函式介面的例外宣告限制與轉換路徑。 |
| <a id="acceptance-java-stream-consumption"></a>[明確消費範圍](#java-stream-consumption) | 核對 Stream 的建立與消費路徑，沒有重用或共用消費；重複取得資料時依契約驗證快照或最新資料語意。 |
| <a id="acceptance-java-stream-coverage"></a>[執行語意驗收](#java-execution-verification) | 確認案例涵蓋受影響的執行語意與資源保證，平行處理有額外隔離及效能證據，不僅比對一般成功案例的最終元素內容。 |

既有程式碼、工具限制與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行放寬要求。
