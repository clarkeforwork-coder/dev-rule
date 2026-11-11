# Java 集合與資料所有權

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[程式碼設計與公開介面](../../../coding/code-design.md)，定義集合及其元素的所有權、修改與處理契約。集合宣告依[型別宣告與泛型](types-and-generics.md)，空值依[null 與 Optional](null-and-optional.md)，鍵與元素的比較依[相等性、雜湊與排序](equality-hashing-ordering.md)。具體併發 API 與資源管理方式分別見[併發與非同步處理](concurrency-and-async.md)與[例外與資源管理](exceptions-and-resources.md)。

## 所有權與集合語意

<a id="java-collection-ownership"></a>

### 明確定義修改權與參考關係

依[明確定義修改權與參考關係的共通要求](../../../coding/collections-and-ownership.md#collection-ownership)執行。Java 集合介面本身不能取代所有權契約；接收或回傳集合時須涵蓋可變元素及參考保留行為。

**違反**

```java
// 宣稱回傳隔離快照，實際卻回傳原集合與可變元素參考。
class Names {
    private final List<StringBuilder> values;
    Names(List<StringBuilder> values) { this.values = values; }
    /** 回傳與來源隔離的集合及元素快照。 */
    List<StringBuilder> values() { return values; }
}
```

**符合**

```java
// 明訂保留原參考，雙方皆可修改集合與元素，且變更互相可見。
class Names {
    private final List<StringBuilder> values;
    /** 保留傳入集合與元素參考；雙方可修改，變更互相可見。 */
    Names(List<StringBuilder> values) { this.values = values; }
    /** 回傳原集合與元素參考；呼叫端與本物件共用修改權。 */
    List<StringBuilder> values() { return values; }
}
```

**版本差異**

- Java 21 起：可用 `reversed()` 提供反向檢視；仍須明訂它與原集合共用元素及底層資料的參考關係，修改能力依原集合而定。（[`SequencedCollection.reversed` API @since 21](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/SequencedCollection.html#reversed())）

**符合（Java 21）**

```java
// 明訂反向檢視仍與來源共用資料及可變元素。
class Names {
    private final List<StringBuilder> values;
    /** 保留原集合與元素參考，變更互相可見。 */
    Names(List<StringBuilder> values) { this.values = values; }
    /** 回傳共用資料的反向檢視；修改能力依原集合，元素仍共用。 */
    List<StringBuilder> values() { return values.reversed(); }
}
```

<a id="java-snapshots-and-views"></a>

### 區分不可修改與不可變快照

依[區分不可修改與不可變快照的共通要求](../../../coding/collections-and-ownership.md#snapshots-and-views)執行。Java 不可修改包裝可能仍是來源的檢視；外層複製可能保留相同可變元素，須驗證實際隔離。

**違反**

```java
// 宣稱不可變快照，卻仍共用可變元素。
class Snapshots {
    static List<StringBuilder> immutableSnapshot(List<StringBuilder> source) {
        return List.copyOf(source);
    }
}
```

**符合**

```java
// 將可變元素轉為不可變值，再建立與來源隔離的快照。
class Snapshots {
    static List<String> immutableSnapshot(List<StringBuilder> source) {
        return source.stream().map(StringBuilder::toString).toList();
    }
}
```

**版本差異**

- Java 8：沒有 Java 10 引入的 `List.copyOf`，也沒有 Java 16 引入的 `Stream.toList()`；以新集合收集轉換後的不可變元素，再用 `Collections.unmodifiableList` 包裝維持同一隔離保證，仍須避免直接包裝來源。（[`List.copyOf` API @since 10](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html#copyOf(java.util.Collection))、[`Stream.toList` API @since 16](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/stream/Stream.html#toList())）
- Java 11：可用 Java 10 引入的 `Collectors.toUnmodifiableList()` 或 `List.copyOf` 建立不可修改結果；仍須先處理可變元素，兩者拒絕 null 且不深複製元素，`copyOf` 也不保證建立新物件。（[`Collectors.toUnmodifiableList` API @since 10](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/stream/Collectors.html#toUnmodifiableList())、[`List.copyOf` API @since 10](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html#copyOf(java.util.Collection))）
- Java 17 起：可用 Java 16 引入的 `Stream.toList()` 取得不可修改結果；仍須如主範例先把可變元素轉成不可變值，外層不可修改不等於元素隔離。（[`Stream.toList` API @since 16](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/stream/Stream.html#toList())）
- Java 21 起：`reversed()` 會產生來源的反向檢視，不得當作隔離快照；仍須先轉換可變元素並收集獨立結果。（[`SequencedCollection.reversed` API @since 21](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/SequencedCollection.html#reversed())）

**符合（Java 8）**

```java
// 收集轉換後的不可變元素，再包裝獨立的新串列。
class Snapshots {
    static List<String> immutableSnapshot(List<StringBuilder> source) {
        List<String> values = source.stream().map(StringBuilder::toString)
                .collect(Collectors.toCollection(ArrayList::new));
        return Collections.unmodifiableList(values);
    }
}
```

**符合（Java 11）**

```java
// 先隔離可變元素，再收集為不可修改串列。
class Snapshots {
    static List<String> immutableSnapshot(List<StringBuilder> source) {
        return source.stream().map(StringBuilder::toString)
                .collect(Collectors.toUnmodifiableList());
    }
}
```

**違反（Java 21）**

```java
// 反向檢視仍共用底層集合與可變元素，並非不可變快照。
class Snapshots {
    static List<StringBuilder> immutableSnapshot(List<StringBuilder> source) {
        return source.reversed();
    }
}
```

**符合（Java 21）**

```java
// 反向遍歷後轉換元素並收集，建立隔離的反向快照。
class Snapshots {
    static List<String> immutableSnapshot(List<StringBuilder> source) {
        return source.reversed().stream().map(StringBuilder::toString).toList();
    }
}
```

<a id="java-order-and-duplicates"></a>

### 順序與重複資料

依[順序與重複資料的共通要求](../../../coding/collections-and-ownership.md#order-and-duplicates)執行。Java 選用或轉換 List、Set、Map 時須維持約定順序、重複元素與重複鍵處理，不意外去重或覆蓋。

**違反**

```java
// 契約要求保留輸入順序與重複值，轉成集合卻丟失這些語意。
class Copies {
    static List<String> preserveOrderAndDuplicates(List<String> source) {
        return new ArrayList<>(new HashSet<>(source));
    }
}
```

**符合**

```java
// 直接複製串列，保留契約要求的順序與重複值。
class Copies {
    static List<String> preserveOrderAndDuplicates(List<String> source) {
        return new ArrayList<>(source);
    }
}
```

**版本差異**

- Java 11：Java 9 引入的 `Set.of`／`Map.of` 不保證迭代順序，不得用來承載順序契約；仍須使用如主範例的 List 保留順序與重複值，重複鍵另依契約處理。（[`Set.of` API @since 9](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Set.html)、[`Map.of` API @since 9](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/Map.html)）
- Java 21 起：可用 `SequencedCollection` 表達遭遇順序；仍須依具體集合維持重複值契約，不能因 `SequencedSet` 有順序就以它取代保留重複值的 List。（[`SequencedCollection` API @since 21](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/SequencedCollection.html)）

**符合（Java 21）**

```java
// 接受有遭遇順序的集合，複製到串列時保留來源順序與重複值。
class Copies {
    static List<String> preserveOrderAndDuplicates(SequencedCollection<String> source) {
        return new ArrayList<>(source);
    }
}
```

## 修改與併發

<a id="java-traversal-mutation"></a>

### 遍歷期間的修改

依[遍歷期間的修改的共通要求](../../../coding/collections-and-ownership.md#traversal-mutation)執行。Java 遍歷修改須使用集合支援的操作；未拋出遍歷修改例外不代表安全，也不得捕捉後直接重跑。

**違反**

```java
// 以增強迴圈遍歷時直接移除來源元素，破壞遍歷契約。
class Removal {
    static void removeEmpty(List<String> values) {
        for (String value : values) {
            if (value.isEmpty()) values.remove(value);
        }
    }
}
```

**符合**

```java
// 使用迭代器支援的移除操作，刪除遍歷遇到的所有空字串。
class Removal {
    static void removeEmpty(List<String> values) {
        for (Iterator<String> it = values.iterator(); it.hasNext();) {
            if (it.next().isEmpty()) it.remove();
        }
    }
}
```

<a id="java-compound-atomicity"></a>

### 複合操作的原子性

依[複合操作的原子性的共通要求](../../../coding/concurrency-and-async.md#compound-atomicity)執行。Java concurrent collection 的單一操作保證不能推導為多步驟或跨鍵操作原子性。

**違反**

```java
// 檢查與寫入分成兩步，併發呼叫可能覆蓋已存在的值。
class Registry {
    private final ConcurrentMap<String, String> values = new ConcurrentHashMap<>();
    void registerIfAbsent(String key, String value) {
        if (!values.containsKey(key)) values.put(key, value);
    }
}
```

**符合**

```java
// 使用原子的條件寫入，維持僅在鍵不存在時登錄的契約。
class Registry {
    private final ConcurrentMap<String, String> values = new ConcurrentHashMap<>();
    void registerIfAbsent(String key, String value) {
        values.putIfAbsent(key, value);
    }
}
```

## 資料規模、資源與批次結果

<a id="java-bounded-accumulation"></a>

### 限制資料累積

依[限制資料累積的共通要求](../../../quality/performance.md#bounded-accumulation)執行。Java Iterator 或 Stream 不保證實際有界；排序、去重及分組的保留資料成本仍須核對。

**違反**

```java
// 只需排序前一百筆，卻先排序持續產生的串流而無限累積。
class Samples {
    static List<Integer> sortedFirstHundred() {
        return Stream.iterate(0, (Integer n) -> n + 1).sorted().limit(100).toList();
    }
}
```

**符合**

```java
// 先界定前一百筆的處理範圍，再排序，限制中間資料累積。
class Samples {
    static List<Integer> sortedFirstHundred() {
        return Stream.iterate(0, (Integer n) -> n + 1).limit(100).sorted().toList();
    }
}
```

**版本差異**

- Java 8：沒有 Java 9 引入的三參數 `Stream.iterate` 與 `takeWhile`，以 `limit` 限制筆數後排序維持同一有界保證；沒有 Java 16 引入的 `toList()`，以收集後不可修改包裝保留主範例結果語意，仍須先限制累積範圍。（[`Stream` API @since 9／16](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/stream/Stream.html)）
- Java 11：可用 Java 9 引入的三參數 `Stream.iterate` 或 `takeWhile` 表達停止條件；仍須確保條件能界定資料量並在排序前生效，以 Java 10 引入的 `toUnmodifiableList()` 保留不可修改結果。（[`Stream` API @since 9](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/stream/Stream.html)、[`Collectors.toUnmodifiableList` API @since 10](https://docs.oracle.com/en/java/javase/11/docs/api/java.base/java/util/stream/Collectors.html#toUnmodifiableList())）
- Java 17 起：可用 Java 16 引入的 `Stream.toList()` 收集結果；仍須先限制來源及中間操作的累積量，終端收集不會讓無界排序變成有界。（[`Stream.toList` API @since 16](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/stream/Stream.html#toList())）

**符合（Java 8）**

```java
// 限制前一百筆後排序，收集並包裝為不可修改結果。
class Samples {
    static List<Integer> sortedFirstHundred() {
        List<Integer> values = Stream.iterate(0, (Integer n) -> n + 1)
                .limit(100).sorted().collect(Collectors.toCollection(ArrayList::new));
        return Collections.unmodifiableList(values);
    }
}
```

**符合（Java 11）**

```java
// 產生器最多提供一百筆，再排序並收集不可修改結果。
class Samples {
    static List<Integer> sortedFirstHundred() {
        return Stream.iterate(0, (Integer n) -> n < 100, (Integer n) -> n + 1)
                .sorted().collect(Collectors.toUnmodifiableList());
    }
}
```

<a id="java-lazy-resource-lifetime"></a>

### 延遲讀取的資源責任

依[延遲讀取的資源責任的共通要求](../../../coding/resource-lifecycle.md#lazy-resource-lifetime)執行。Java 資源型 Iterator／Stream 須明確有效期及關閉責任；必要時在資源範圍內產生受控結果，關閉方式依例外與資源管理。

**違反**

```java
// 回傳延遲串流時已關閉檔案，呼叫端無法在有效期內讀取。
class Lines {
    static Stream<String> firstTen(Path path) throws IOException {
        try (Stream<String> lines = Files.lines(path)) {
            return lines.limit(10);
        }
    }
}
```

**符合**

```java
// 在方法負責關閉的資源範圍內完成讀取，回傳受控結果。
class Lines {
    static List<String> firstTen(Path path) throws IOException {
        try (Stream<String> lines = Files.lines(path)) {
            return lines.limit(10).toList();
        }
    }
}
```

**版本差異**

- Java 8／11：沒有 Java 16 引入的 `Stream.toList()`，以 `collect` 收集新串列再包裝為不可修改結果維持同一保證；仍須在 try-with-resources 範圍內完成終端操作，不能把延遲讀取留到關閉之後。（[`Stream.toList` API @since 16](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/stream/Stream.html#toList())）
- Java 17 起：可用 Java 16 引入的 `Stream.toList()` 收集受控結果；仍須在資源有效期內完成讀取，終端操作不取代關閉責任。（[`Stream.toList` API @since 16](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/stream/Stream.html#toList())）

**符合（Java 8）**

```java
// 在資源範圍內收集前十行，關閉後只回傳已完成的結果。
class Lines {
    static List<String> firstTen(Path path) throws IOException {
        try (Stream<String> lines = Files.lines(path)) {
            List<String> values = lines.limit(10)
                    .collect(Collectors.toCollection(ArrayList::new));
            return Collections.unmodifiableList(values);
        }
    }
}
```

<a id="java-batch-failure-state"></a>

### 批次修改的失敗保證

依[錯誤處理](../../../coding/error-handling.md#failure-state-guarantee)執行。Java 批次集合方法拋出例外不代表未修改；不要求所有集合操作具有交易能力，須核對約定的失敗後狀態。

**違反**

```java
// 約定失敗時值不變，直接批次修改卻可能在例外前已改動部分值。
class Values {
    private List<Integer> values = new ArrayList<>(List.of(1, 0));
    /** 除以零時拋出例外，並保留呼叫前的所有值。 */
    void invert() {
        values.replaceAll((Integer value) -> 10 / value);
    }
}
```

**符合**

```java
// 在副本完成批次運算後才替換，例外時原集合保持不變。
class Values {
    private List<Integer> values = new ArrayList<>(List.of(1, 0));
    /** 除以零時拋出例外，並保留呼叫前的所有值。 */
    void invert() {
        List<Integer> updated = new ArrayList<>(values);
        updated.replaceAll((Integer value) -> 10 / value);
        values = updated;
    }
}
```

**版本差異**

- Java 8：沒有 Java 9 引入的 `List.of`，以 `Arrays.asList` 初始化後複製為 `ArrayList` 維持同一保證；仍須在副本完成批次運算後才替換原集合。（[`List.of` API @since 9](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html)）
- Java 11：可用 Java 9 引入的 `List.of` 建立初始資料；仍須複製至可修改集合，並在副本運算成功後才替換，工廠方法不提供批次修改的交易保證。（[`List.of` API @since 9](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html)）

**符合（Java 8）**

```java
// 以舊版集合工廠初始化，保留副本運算成功後才替換的保證。
class Values {
    private List<Integer> values = new ArrayList<>(Arrays.asList(1, 0));
    /** 除以零時拋出例外，並保留呼叫前的所有值。 */
    void invert() {
        List<Integer> updated = new ArrayList<>(values);
        updated.replaceAll((Integer value) -> 10 / value);
        values = updated;
    }
}
```

<a id="java-collection-verification"></a>

### 所有權與行為驗收

依[所有權與行為驗收的共通要求](../../../coding/collections-and-ownership.md#collection-verification)執行。Java 集合的實際修改、遍歷、檢視及資源路徑依[本文件驗收要求](#驗收要求)，不重測標準函式庫本身。

<a id="java-closing-requirements"></a>

## 補充要求

邊界間的參考隔離另依[邊界物件與資料映射](boundary-mapping.md)，共用元件的狀態與生命週期依[類別、介面與物件建立](classes-and-construction.md)。資源範圍與容量依[效能與資源使用](../../../quality/performance.md#resource-limits-and-admission)，失敗與部分成功依[錯誤處理](../../../coding/error-handling.md#partial-success)。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響及實際使用路徑選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md#test-levels-and-cases)與[規範驗證](../../../quality/rule-verification.md#verification-coverage)。

### 共同驗收

- [明確定義修改權與參考關係、區分不可修改與不可變快照](../../../coding/collections-and-ownership.md#acceptance-collection-ownership)。
- [順序與重複資料](../../../coding/collections-and-ownership.md#acceptance-order-duplicates)。
- [遍歷期間的修改](../../../coding/collections-and-ownership.md#acceptance-traversal-mutation)。
- [複合操作的原子性](../../../coding/concurrency-and-async.md#acceptance-compound-atomicity)。
- [限制資料累積](../../../quality/performance.md#acceptance-bounded-accumulation)。
- [延遲讀取的資源責任](../../../coding/resource-lifecycle.md#acceptance-lazy-resource-lifetime)。
- [多步驟與部分成功](../../../coding/error-handling.md#acceptance-partial-operation)。
- [所有權與行為驗收](../../../coding/collections-and-ownership.md#acceptance-collection-coverage)。
- [失敗後狀態](../../../coding/error-handling.md#acceptance-failure-state)。

### Java 語言增量驗收

上述驗收須經實際採用的 Java 集合、迭代與資源路徑執行，本文件的 Java 使用限制仍適用。

既有程式碼與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行降低要求。
