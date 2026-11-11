# Java null 與 Optional

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[空值語意](../../../coding/nullability.md)、[型別安全](../../../coding/type-safety.md)、[錯誤處理](../../../coding/error-handling.md)、[資料驗證](../../../coding/validation.md)與[領域建模](../../../coding/domain-modeling.md)，適用於自行撰寫的 Java 程式碼，包含測試與整合元件。語法與 API 須符合[版本要求](version-policy.md)，型別使用另依[型別宣告與泛型](types-and-generics.md)。

## 查詢與 Optional

<a id="java-query-absence"></a>

### 查詢的正常缺值

單筆查詢允許正常不存在時，使用 `Optional<T>`；多筆查詢無結果時使用空集合，不回傳 `null`。依業務要求必須存在卻不存在時，表達明確的業務失敗；查詢技術故障依[錯誤處理](../../../coding/error-handling.md#failure-classification)傳遞，不得混為正常缺值。

**違反**

```java
// 正常查無資料卻以 null 表示單筆與多筆結果。
class Queries {
    String findOne() { return null; }
    List<String> findAll() { return null; }
}
```

**符合**

```java
// 單筆正常缺值使用 Optional，多筆無結果使用空集合。
class Queries {
    Optional<String> findOne() { return Optional.empty(); }
    List<String> findAll() { return List.of(); }
}
```

**版本差異**

- Java 8：沒有 Java 9 引入的 `List.of()`，以 `Collections.emptyList()` 維持多筆無結果回傳空集合的同一保證；單筆正常缺值仍須回傳 `Optional.empty()`。（[List.of API @since 9](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html#of())）
- Java 11：可用自 Java 9 起提供的 `List.of()` 表達空集合；仍須區分正常缺值、業務失敗與技術故障。（[List.of API @since 9](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html#of())）

**符合（Java 8）**

```java
// 單筆正常缺值使用 Optional，多筆無結果使用 Java 8 的空集合工廠。
class Queries {
    Optional<String> findOne() { return Optional.empty(); }
    List<String> findAll() { return Collections.emptyList(); }
}
```

<a id="java-optional-nonnull"></a>

### Optional 本身非空

宣告使用 `Optional` 的位置，`Optional` 本身不得為 `null`。空的 `Optional` 只能表示契約允許的正常缺值，不得掩蓋業務失敗、技術故障或尚未確認的結果。

**違反**

```java
// 契約允許正常查無資料，卻回傳 null 作為 Optional。
class Lookup {
    Optional<String> find() { return null; }
}
```

**符合**

```java
// 契約允許正常查無資料，回傳非 null 的空 Optional。
class Lookup {
    Optional<String> find() { return Optional.empty(); }
}
```

<a id="java-optional-access"></a>

### 取值與缺值處置

使用 `Optional` 的值前，須明確處理缺值情境，不得僅憑預期直接取值。替代值、缺值分支與失敗處理須符合業務語意，不得掩蓋缺值；替代結果與錯誤分類依[降級與替代結果](../../../coding/error-handling.md#fallback-results)及[失敗分類](../../../coding/error-handling.md#failure-classification)。選用取值或拋出例外的方法本身不代表符合規範；若依已成立的不變條件必定有值，違反時須按[程式缺陷](../../../coding/error-handling.md#defects-and-invariants)處理。

**違反**

```java
// 查詢回傳的暱稱可能缺值，卻直接取值。
class Greeting {
    interface Nicknames { Optional<String> find(long userId); }
    String greet(Nicknames nicknames, long userId) {
        Optional<String> nickname = nicknames.find(userId);
        return "你好，" + nickname.get();
    }
}
```

**符合**

```java
// 依問候契約，查無暱稱時使用不帶稱呼的問候語。
class Greeting {
    interface Nicknames { Optional<String> find(long userId); }
    String greet(Nicknames nicknames, long userId) {
        Optional<String> nickname = nicknames.find(userId);
        return nickname.map((String name) -> "你好，" + name).orElse("你好");
    }
}
```

**版本差異**

- Java 8：沒有後續的 `isEmpty()` 等新增方法，以 `!isPresent()`、`map`／`orElseGet` 或 `orElseThrow(Supplier)` 維持明確處理缺值的同一保證；仍須依契約選擇替代值或失敗，不能改成直接 `get()`。（[Optional API @since 1.8；isEmpty @since 11](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Optional.html)）
- Java 11：可用 Java 9 引入的 `or`／`ifPresentOrElse`／`stream`、Java 10 引入的無參數 `orElseThrow()` 與 Java 11 引入的 `isEmpty()`；仍須依業務語意處理缺值，不能以無參數拋例外或空串流掩蓋必要結果缺失。（[Optional API @since 9、10、11](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Optional.html)）

**符合（Java 8）**

```java
// 查無暱稱時回傳一般問候，確認有值後才取值。
class Greeting {
    interface Nicknames { Optional<String> find(long userId); }
    String greet(Nicknames nicknames, long userId) {
        Optional<String> nickname = nicknames.find(userId);
        if (!nickname.isPresent()) { return "你好"; }
        return "你好，" + nickname.get();
    }
}
```

**符合（Java 11）**

```java
// 用 isEmpty 明確處理正常缺值，有值分支維持相同問候語意。
class Greeting {
    interface Nicknames { Optional<String> find(long userId); }
    String greet(Nicknames nicknames, long userId) {
        Optional<String> nickname = nicknames.find(userId);
        if (nickname.isEmpty()) { return "你好"; }
        return "你好，" + nickname.get();
    }
}
```

<a id="java-optional-positions"></a>

### 使用位置與狀態表達

`Optional` 主要用於方法回傳的正常缺值。參數與欄位須依業務語意設計，不全面包裝，也不全面禁止使用；採用時須確認契約及相關框架可正確處理。需要區分多種狀態時，依[空值語意](../../../coding/nullability.md#null-state-semantics)使用能完整表達狀態的明確型別，不得以 `Optional` 混合表示。

**違反**

```java
// 更新需要區分保留、清空與設定，Optional 卻只能表達兩種狀態。
record NicknameChange(Optional<String> value) {}
```

**符合**

```java
// 以明確型別分別表達保留、清空與設定暱稱。
sealed interface NicknameChange {
    record Keep() implements NicknameChange {}
    record Clear() implements NicknameChange {}
    record Set(String value) implements NicknameChange {
        public Set { Objects.requireNonNull(value); }
    }
}
```

**版本差異**

- Java 8／11：沒有正式的 record 與 sealed，以私有建構子的抽象類別及巢狀 final 子類別分別表達保留、清空與設定，維持完整狀態的同一保證；設定值仍須驗證非空。（[JEP 395：Java 16](https://openjdk.org/jeps/395)、[JEP 409：Java 17](https://openjdk.org/jeps/409)）
- Java 17 起：可用 Java 16 正式發布的 record 與 Java 17 正式發布的 sealed 限定狀態型別；仍須分別表達保留、清空與設定，不能以 Optional 混合多種狀態。（[JEP 395](https://openjdk.org/jeps/395)、[JEP 409](https://openjdk.org/jeps/409)）

**符合（Java 8）**

```java
// 私有父類別建構子限制擴充，三種狀態各自具有明確型別。
abstract class NicknameChange {
    private NicknameChange() {}
    static final class Keep extends NicknameChange {}
    static final class Clear extends NicknameChange {}
    static final class Set extends NicknameChange {
        private final String value;
        Set(String value) { this.value = Objects.requireNonNull(value); }
        String value() { return value; }
    }
}
```

## 空值限制與整合責任

<a id="java-container-nulls"></a>

### 集合內容的空值

集合與陣列元素，以及映射的鍵和值，預設不得為 `null`。必要缺值須明訂語意與處理方式，優先以明確型別表達。外部資料含有不允許的 `null` 時，須在邊界拒絕或依契約處理，不得默默移除或替換而掩蓋不合法資料。

**違反**

```java
// 外部名稱清單不允許 null，卻默默移除不合法元素。
class Names {
    List<String> accept(List<String> input) {
        return input.stream().filter(Objects::nonNull).toList();
    }
}
```

**符合**

```java
// 外部名稱清單不允許 null，依輸入契約拒絕不合法元素。
class Names {
    List<String> accept(List<String> input) {
        if (input.stream().anyMatch(Objects::isNull)) {
            throw new IllegalArgumentException("名稱不得為空");
        }
        return List.copyOf(input);
    }
}
```

**版本差異**

- Java 8：沒有 Java 10 引入的 `List.copyOf`，以明確驗證後複製並包裝為不可修改清單維持同一保證；仍須拒絕不合法的 null 元素，不得默默移除。（[List.copyOf API @since 10](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html#copyOf(java.util.Collection))）
- Java 11：可用 Java 9 的 `List.of` 與 Java 10 的 `List.copyOf` 拒絕 null 元素；仍須依邊界契約處理不合法資料，主範例先驗證以保留明確的輸入錯誤語意。（[List API @since 9、10](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html)）
- Java 17 起：Java 16 引入的 `Stream.toList()` 不會拒絕 null 元素，僅收集會讓不合法元素流入結果；仍須在邊界驗證，不得以過濾或替換掩蓋不合法資料。（[Stream.toList API @since 16](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/stream/Stream.html#toList())）

**符合（Java 8）**

```java
// 先拒絕不合法元素，再複製並包裝，保留主範例的輸入錯誤語意。
class Names {
    List<String> accept(List<String> input) {
        if (input.stream().anyMatch(Objects::isNull)) {
            throw new IllegalArgumentException("名稱不得為空");
        }
        return Collections.unmodifiableList(new ArrayList<>(input));
    }
}
```

**符合（Java 17）**

```java
// toList 不代替非空驗證，收集前先拒絕不合法元素。
class Names {
    List<String> accept(List<String> input) {
        if (input.stream().anyMatch(Objects::isNull)) {
            throw new IllegalArgumentException("名稱不得為空");
        }
        return input.stream().toList();
    }
}
```

<a id="java-nonnull-validation"></a>

### 非空驗證的位置

依[資料驗證](../../../coding/validation.md#validation-responsibilities)、[錯誤處理](../../../coding/error-handling.md#defects-and-invariants)、[領域建模](../../../coding/domain-modeling.md)執行。Java 接收、建立及狀態變更位置依上述非空保證驗證；內部可靠契約已成立時不逐層重複檢查。

**違反**

```java
// 建立時未驗證非空，讓不合法狀態進入領域物件。
record Name(String value) {
    int length() { return value.length(); }
}
```

**符合**

```java
// 建立時保證非空，內部使用已成立的契約而不重複檢查。
record Name(String value) {
    Name { Objects.requireNonNull(value); }
    int length() { return value.length(); }
}
```

**版本差異**

- Java 8／11：沒有 Java 16 正式發布的 record 緊湊建構子，以一般類別的建構子維持建立時驗證非空的同一保證；內部仍須依已成立的契約使用值。（[JEP 395](https://openjdk.org/jeps/395)）
- Java 17 起：可用自 Java 16 起正式提供的 record 緊湊建構子集中驗證；record 不會自動拒絕 null，建立時仍須明確驗證非空。（[JEP 395](https://openjdk.org/jeps/395)）

**符合（Java 8）**

```java
// 一般建構子建立非空保證，內部使用時不重複檢查。
final class Name {
    private final String value;
    Name(String value) { this.value = Objects.requireNonNull(value); }
    String value() { return value; }
    int length() { return value.length(); }
}
```

<a id="java-null-contract-tools"></a>

### 工具可辨識的契約

專案須統一可由工具辨識的空值契約表達方式，明訂非空預設、可空位置與適用範圍。可自動判斷的違規及工具缺口依[共同把關](../../../quality/rule-verification.md#verification-coverage)納入檢查、驗證與審查。標註、文件與實際行為須一致；標註不能取代外部輸入的執行期驗證。註解套件與工具由專案依版本及框架選定。

<a id="java-third-party-optional"></a>

### 第三方空值行為

依[第三方空值行為](../../../coding/nullability.md#third-party-null-contract)確認契約；第三方明訂 `null` 是正常查無資料時，才轉成空的 `Optional`。

**違反**

```java
// 第三方契約保證回傳非空，卻將違約的 null 當作正常缺值。
class Adapter {
    interface Vendor { String load(); }
    Optional<String> load(Vendor vendor) {
        return Optional.ofNullable(vendor.load());
    }
}
```

**符合**

```java
// 第三方未允許正常缺值且保證非空，違約的 null 須回報整合故障。
class Adapter {
    interface Vendor { String load(); }
    String load(Vendor vendor) {
        String value = vendor.load();
        if (value == null) {
            throw new IllegalStateException("第三方違反非空契約");
        }
        return value;
    }
}
```

## 契約維護與對外表示

<a id="java-null-contract-evolution"></a>

### 空值契約變更

依[空值契約變更](../../../coding/nullability.md#null-contract-evolution)評估相容性與使用端影響；Java 空值標註、`Optional` 使用及缺值處置須同步更新。

<a id="java-nonnull-default"></a>

### 預設非空與明確語意

Java 的參數、回傳值與欄位預設不允許 `null`；允許時須明確標示並定義語意，不得以同一個 `null` 混合表示需要不同處理方式的狀態。查詢結果另遵循本文件的 `Optional` 與空集合要求。

**違反**

```java
// 未標示可空及其語意，卻接受 null 作為停用到期時間。
class Expiration {
    boolean expired(Instant deadline, Instant now) {
        return deadline != null && !now.isBefore(deadline);
    }
}
```

**符合**

```java
// 文件限定 null 代表永不到期，專案空值標註套件另依工具契約小節選定。
class Expiration {
    /** @param deadline 可為 null，僅表示永不到期。 */
    boolean expired(Instant deadline, Instant now) {
        return deadline != null && !now.isBefore(deadline);
    }
}
```

<a id="java-api-absence"></a>

### API 邊界的缺值轉換

Java 的 `Optional` 與內部 `null` 在 API 邊界轉換，依[API 邊界的缺值轉換](../../../interfaces/api-contracts.md#api-absence-representation)落實對外契約。具體序列化配置由 Framework 規範落實。

**違反**

```java
// 對外契約要求缺值省略 nickname 欄位，卻直接暴露 Optional。
class Response {
    Map<String, Object> fields(Optional<String> nickname) {
        return Map.of("nickname", nickname);
    }
}
```

**符合**

```java
// 此為序列化欄位映射，依對外契約省略缺值欄位並將有值暱稱輸出為字串。
class Response {
    Map<String, Object> fields(Optional<String> nickname) {
        Map<String, Object> fields = new HashMap<>();
        nickname.ifPresent((String value) -> fields.put("nickname", value));
        return fields;
    }
}
```

<a id="java-closing-requirements"></a>

## 補充要求

對外缺值表達須與[API 操作語意與介面設計](../../../interfaces/api-contracts.md#api-absence-representation)及[資料契約](../../../interfaces/data-contracts.md#primary-contract-source)一致。本文件不統一指定所有查無資料情境的 HTTP 狀態，也不將欄位省略與 JSON `null` 視為可任意互換。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依受影響的契約、呼叫端與邊界選擇案例；自動檢查、行為測試與人工審查共同把關，測試層級、證據及其餘事項另依[規範驗證](../../../quality/rule-verification.md#verification-coverage)及[共通測試策略](../../../quality/testing.md#test-levels-and-cases)辦理。

不合法資料從允許承接它的邊界輸入；型別要求依[型別安全](../../../coding/type-safety.md#no-type-check-bypasses)。

### 共同驗收

- [第三方空值行為](../../../coding/nullability.md#acceptance-third-party-null)。
- [空值契約變更](../../../coding/nullability.md#acceptance-null-contract-change)。
- [API 邊界的缺值轉換](../../../interfaces/api-contracts.md#acceptance-api-absence)。
- [測試程式碼](../../../coding/type-safety.md#acceptance)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-optional-results"></a>[查詢](#java-query-absence)、[Optional 非空](#java-optional-nonnull)、[取值](#java-optional-access) | 驗證有值、單筆正常查無資料、多筆空結果，以及適用的必須存在卻不存在、查詢故障與結果未知。確認 `Optional` 本身非空，呼叫端的缺值分支、替代值與失敗分類符合契約。 |
| <a id="acceptance-java-optional-positions"></a>[使用位置](#java-optional-positions)、[集合空值](#java-container-nulls) | 審查參數與欄位採用 `Optional` 的必要性及配套。需要多狀態時分別驗證未提供、清空與設定值；集合等輸入含不允許的空值時，確認依契約處理，沒有默默丟棄或替換資料。 |
| <a id="acceptance-java-null-contract"></a>[驗證責任](../../../coding/validation.md#validation-responsibilities)、[工具契約](#java-null-contract-tools)、[非空預設](#java-nonnull-default) | 核對非空預設、可空標註、檢查範圍及實際驗證位置。確認適用工具能偵測違反契約的使用方式；必填外部輸入缺值時依契約拒絕，且未產生不應發生的副作用。 |
| <a id="acceptance-java-optional-adaptation"></a>[第三方轉換](#java-third-party-optional) | 檢查第三方回傳值轉成 `Optional` 的路徑，只有契約允許的正常缺值才能使用空的 `Optional`。 |
| <a id="acceptance-java-optional-coverage"></a>案例覆蓋 | 核對案例覆蓋受影響的有值與缺值分類，測試資料及替身遵守型別契約，未為製造案例而關閉檢查或使用不安全轉型。Optional、非空標註與實際 API 路徑均納入適用案例。 |

既有程式碼、工具限制與個別例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行放寬要求。
