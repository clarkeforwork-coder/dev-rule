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
