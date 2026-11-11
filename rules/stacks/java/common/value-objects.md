# Java 專屬值型別與領域值物件

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[領域建模](../../../coding/domain-modeling.md)，適用於 Java 專屬值型別與領域值物件。型別使用與空值處理另依[型別宣告與泛型](types-and-generics.md)及[null 與 Optional](null-and-optional.md)。具有身分與生命週期的 Entity，其狀態變更另依業務規則管理，不因本文件而要求所有 Entity 不可變。

本文件另依[資料驗證](../../../coding/validation.md)辦理。

## 型別責任與有效性

<a id="java-dedicated-value-types"></a>

### 建立專屬型別的條件

依[領域建模](../../../coding/domain-modeling.md#dedicated-types)執行。Java 的 `OrderId` 與 `CustomerId` 須維持不同業務型別；一般描述性資料不要求機械式包裝。

**違反**

```java
// 訂單與客戶共用識別碼型別，無法阻止混用。
record Id(long value) {}
record Order(Id orderId, Id customerId) {}
```

**符合**

```java
// 訂單與客戶使用不同業務型別，避免識別碼混用。
record OrderId(long value) {}
record CustomerId(long value) {}
record Order(OrderId orderId, CustomerId customerId) {}
```

<a id="java-value-construction-invariants"></a>

### 建立時保護不變條件

依[領域建模](../../../coding/domain-modeling.md#dedicated-types)、[資料驗證](../../../coding/validation.md#validation-responsibilities)執行。Java 建構子或工廠維持一致驗證；合法 `OrderId` 不代表訂單存在或已取得存取權。

**違反**

```java
// 此例識別碼須為正數，但直接呼叫建構子可繞過工廠驗證。
record OrderId(long value) {
    static OrderId of(long value) {
        if (value <= 0) throw new IllegalArgumentException();
        return new OrderId(value);
    }
}
```

**符合**

```java
// 此例識別碼須為正數，所有建立入口共用建構子的驗證。
record OrderId(long value) {
    OrderId {
        if (value <= 0) throw new IllegalArgumentException();
    }
    static OrderId of(long value) { return new OrderId(value); }
}
```

<a id="java-value-immutability"></a>

### 不可變性

依[不可變性的共通要求](../../../coding/domain-modeling.md#value-immutability)執行。Java 欄位標示 `final` 不代表內容不可變；傳入及取出可變集合或巢狀物件時，須以不可變表示、封裝或必要的防禦性複製維持隔離。

**違反**

```java
// 欄位雖為 final，傳入與取出的集合仍可改變物件內容。
final class Tags {
    private final List<String> values;
    Tags(List<String> values) { this.values = values; }
    List<String> values() { return values; }
}
```

**符合**

```java
// 複製為不可變集合，隔離傳入與取出路徑的修改。
final class Tags {
    private final List<String> values;
    Tags(List<String> values) { this.values = List.copyOf(values); }
    List<String> values() { return values; }
}
```

## 相等性、正規化與運算

<a id="java-value-equality"></a>

### 值相等的條件

須明訂相等條件，並維持 `equals()` 與 `hashCode()` 一致，相等物件須具有相同雜湊值。相等性須保留業務概念的區別，不得只比較底層值或物件身分，也不得未經確認就採用自動產生的相等性。例如不同實例的相同訂單識別碼可相等，但相同數字的 `OrderId` 與 `CustomerId` 不應相等；金額相同而幣別不同也不應視為相等。

**違反**

```java
// 此例訂單識別碼以數值判等，卻沿用物件身分相等性。
final class OrderId {
    private final long value;
    OrderId(long value) { this.value = value; }
}
```

**符合**

```java
// 已確認以同型別的數值判等，產生的相等性及雜湊符合契約。
record OrderId(long value) {}
record CustomerId(long value) {}
```

<a id="java-value-normalization"></a>

### 正規化規則

依[正規化規則的共通要求](../../../coding/domain-modeling.md#value-normalization)執行。Java 建構子、工廠及其他建立入口須一致執行正規化，並讓 `equals()` 與 `hashCode()` 反映已定義的值語意。

**違反**

```java
// 此例代碼約定忽略大小寫，但只有工廠正規化，直接建立時不一致。
record Code(String value) {
    static Code of(String value) {
        return new Code(value.toUpperCase(Locale.ROOT));
    }
}
```

**符合**

```java
// 此例代碼約定忽略大小寫，各入口先統一表示再以正規化值判等。
record Code(String value) {
    Code { value = value.toUpperCase(Locale.ROOT); }
    static Code of(String value) { return new Code(value); }
}
```

<a id="java-value-operations"></a>

### 運算責任

依[運算責任的共通要求](../../../coding/domain-modeling.md#value-operations)執行。跨幣別等依賴外部政策的操作由領域元件協調。

**違反**

```java
// 值物件自行查詢外部匯率政策並協調換匯。
interface Rates { BigDecimal rate(String from, String to); }
record Money(BigDecimal amount, String currency) {
    Money exchange(String target, Rates rates) {
        return new Money(amount.multiply(rates.rate(currency, target)), target);
    }
}
```

**符合**

```java
// 由領域元件協調外部匯率政策與換匯。
interface Rates { BigDecimal rate(String from, String to); }
record Money(BigDecimal amount, String currency) {}
record Exchange(Rates rates) {
    Money convert(Money source, String target) {
        BigDecimal rate = rates.rate(source.currency(), target);
        return new Money(source.amount().multiply(rate), target);
    }
}
```

## 還原、實作形式與對外表示

<a id="java-value-restoration"></a>

### 資料還原

依[資料還原的共通要求](../../../coding/domain-modeling.md#value-restoration)執行。Java 建構、反序列化及持久化還原均須維持共同保證；一般類別或 `record` 的實作選擇不得形成驗證旁路。

**違反**

```java
// 此例識別碼須為正數，但持久化還原入口跳過驗證。
final class OrderId {
    private final long value;
    OrderId(long value) { this(value, true); }
    private OrderId(long value, boolean validate) {
        if (validate && value <= 0) throw new IllegalArgumentException();
        this.value = value;
    }
    static OrderId restore(long stored) { return new OrderId(stored, false); }
}
```

**符合**

```java
// 持久化還原與一般建立共用正數驗證，不形成旁路。
final class OrderId {
    private final long value;
    OrderId(long value) {
        if (value <= 0) throw new IllegalArgumentException();
        this.value = value;
    }
    static OrderId restore(long stored) { return new OrderId(stored); }
}
```

<a id="java-value-implementation"></a>

### 一般類別與 record

可依支援的 Java 版本與業務需求，選用一般類別或 `record`，不強制所有值物件採用相同形式。選擇須符合驗證、不可變性與相等性要求，並檢視自動產生的方法是否適合公開，不因採用特定語法就視為符合規範。可變內容仍須保護，敏感值不得因自動產生字串表示而洩漏。語言功能另依[版本要求](version-policy.md)。

**違反**

```java
// record 自動產生的字串表示會洩漏敏感權杖。
record AccessToken(String value) {}
```

**符合**

```java
// 覆寫字串表示，避免自動產生的方法洩漏敏感權杖。
record AccessToken(String value) {
    @Override public String toString() { return "AccessToken[REDACTED]"; }
}
```

<a id="java-diagnostic-representation"></a>

### 診斷字串與交換格式

值物件的診斷字串與持久化、傳輸格式須分別定義，不得默認以 `toString()` 作為穩定的資料交換契約。對外表示須遵守格式、相容性與敏感資料揭露要求，不能因值被包成物件就允許輸出原值。

**違反**

```java
// 將診斷字串默認為傳輸契約，格式會隨 toString 改變。
record OrderId(long value) {}
class OrderIdCodec {
    String encode(OrderId id) { return id.toString(); }
}
```

**符合**

```java
// 此例交換契約明訂為十進位數字，編碼不依賴診斷字串。
record OrderId(long value) {}
class OrderIdCodec {
    String encode(OrderId id) { return Long.toString(id.value()); }
}
```

<a id="java-value-test-coverage"></a>

### 業務保證的測試

依[領域建模](../../../coding/domain-modeling.md#model-validation-restoration)、[共通測試策略](../../../quality/testing.md#test-levels-and-cases)執行。Java 的 `equals()`、`hashCode()`、`record` 自動產生方法與還原路徑依[本文件驗收要求](#驗收要求)驗證，不機械式測試每個產生的方法。

<a id="java-closing-requirements"></a>

## 補充要求

映射與歷史資料處理另見[資料映射](../../../architecture/data-mapping.md#conversion-requirements)及[資料遷移](../../../data/migrations.md#version-compatibility)；敏感資料與診斷輸出依[安全規範](../../../quality/security.md#sensitive-data-and-copies)及[日誌、稽核與可觀測性](../../../quality/observability.md#diagnostic-logging-and-tracing)。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依受影響的值型別與實際使用路徑選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md#test-levels-and-cases)與[規範驗證](../../../quality/rule-verification.md#verification-coverage)。

### 共同驗收

- [不可變性](../../../coding/domain-modeling.md#acceptance-value-immutability)。
- [正規化規則](../../../coding/domain-modeling.md#acceptance-value-normalization)。
- [運算責任](../../../coding/domain-modeling.md#acceptance-value-operations)。
- [資料還原](../../../coding/domain-modeling.md#acceptance-value-restoration)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-value-validity"></a>[專屬型別](../../../coding/domain-modeling.md#dedicated-types)、[建立入口](../../../coding/code-design.md#construction-entrypoints)、[驗證責任](../../../coding/validation.md#validation-responsibilities) | 審查專屬型別能否阻止業務概念混用，相關介面有無退回一般字串或數字。驗證合法值、邊界值及不合法值，確認建立成功後符合自身規則，且未將格式有效誤當成存在性或授權成立。 |
| <a id="acceptance-java-final-references"></a>[不可變性](#java-value-immutability) | 檢查 final 欄位仍可能指向可變內容的路徑；不得以欄位修飾詞作為不可變性證據。 |
| <a id="acceptance-java-value-equality"></a>[值相等的條件](#java-value-equality) | 驗證不同實例的相等值及具代表性的不相等值，相等物件的雜湊值須相同。適用時確認作為集合元素或映射鍵的行為符合契約，不要求不相等物件一定具有不同雜湊值。 |
| <a id="acceptance-java-generated-representation"></a>[一般類別與 record](#java-value-implementation)、[診斷字串與交換格式](#java-diagnostic-representation) | 核對實作形式符合支援版本，產生的方法與手寫方法均遵循相等性、不可變性及揭露契約。確認診斷字串未被默認當成交換格式，對外映射符合約定且未洩漏敏感值。 |
| <a id="acceptance-java-value-method-coverage"></a>[業務保證的測試](#java-value-test-coverage) | 核對測試涵蓋受影響的業務保證與失效邊界，不以只有建立成功的案例代替驗收，也不要求無業務邏輯的存取方法逐一測試。Java 的 equals()、hashCode()、record 產生方法與還原路徑均納入適用案例。 |

既有程式碼與必要例外依[規範治理](../../../workflow/rule-governance.md)辦理，不因工具或框架產生物件而自行豁免。
