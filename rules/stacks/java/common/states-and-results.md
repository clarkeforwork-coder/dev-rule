# Java 狀態與結果建模

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[領域建模](../../../coding/domain-modeling.md)與[錯誤處理](../../../coding/error-handling.md)，定義 Java 狀態與操作結果的型別要求。實作須符合[版本要求](version-policy.md)、[型別宣告與泛型](types-and-generics.md)及[空值契約](null-and-optional.md)。

## 狀態與轉換

<a id="java-explicit-state-types"></a>

### 明確的狀態型別

互斥的業務狀態須使用明確型別；僅需區分固定狀態名稱時，可使用 `enum`。不得以多個獨立布林值表達互斥狀態。不同業務面向須分別建模，不得強行合併，例如付款與配送狀態可各自表達，再明訂兩者之間的限制。

**違反**

```java
// 互斥狀態以獨立布林值表示，可能同時成立。
record Payment(boolean pending, boolean paid, boolean failed) {}
```

**符合**

```java
// 固定且互斥的付款狀態以列舉表示。
enum PaymentState { PENDING, PAID, FAILED }
```

<a id="java-required-state-data"></a>

### 各狀態的必要資料

依[領域建模](../../../coding/domain-modeling.md#state-modeling)執行。Java 應以對應狀態型別保護必要資料，不只用狀態碼搭配多個可空欄位讓使用端推測。

**違反**

```java
// 已付款狀態仍允許缺少交易編號。
record Payment(State state, String transactionId) {
    enum State { PENDING, PAID }
}
```

**符合**

```java
// 已付款型別在建立時保護必要的交易編號。
sealed interface Payment permits Pending, Paid {}
record Pending() implements Payment {}
record Paid(String transactionId) implements Payment {
    Paid { Objects.requireNonNull(transactionId); }
}
```

**版本差異**

- Java 8／11：`record` 自 Java 16 起（JEP 395）；沒有 `record` 與 `sealed`（Java 17 正式發布），以私有建構子的抽象類別及巢狀 `final` 子類別維持狀態型別的同一保證；必要資料仍須在子類別建構子驗證。（[JEP 395](https://openjdk.org/jeps/395)、[JEP 409](https://openjdk.org/jeps/409)）
- Java 17 起：可用 `sealed` 限制狀態型別並以 `record` 承載各狀態資料；必要資料仍須在建構時驗證，`record` 不會自動拒絕空值。（[JEP 395](https://openjdk.org/jeps/395)、[JEP 409](https://openjdk.org/jeps/409)）

**符合（Java 8）**

```java
// 封閉狀態階層，已付款型別在建立時保護交易編號。
abstract class Payment {
    private Payment() {}
    static final class Pending extends Payment {}
    static final class Paid extends Payment {
        private final String transactionId;
        Paid(String transactionId) {
            this.transactionId = Objects.requireNonNull(transactionId);
        }
        String transactionId() { return transactionId; }
    }
}
```

<a id="java-business-state-transitions"></a>

### 業務操作控制轉換

依[領域建模](../../../coding/domain-modeling.md#state-modeling)執行。Java 公開狀態 setter 不得成為繞過業務操作的入口；修改既有物件或產生新狀態物件由模型決定。

**違反**

```java
// 公開 setter 讓使用端繞過只允許待處理訂單取消的規則。
class Order {
    enum State { PENDING, SHIPPED, CANCELLED }
    enum CancelResult { CANCELLED, INVALID_STATE }
    private State state = State.PENDING;
    public void setState(State state) { this.state = state; }
    public CancelResult cancel() {
        if (state != State.PENDING) return CancelResult.INVALID_STATE;
        state = State.CANCELLED;
        return CancelResult.CANCELLED;
    }
}
```

**符合**

```java
// 取消只能經由檢查來源狀態的業務操作。
class Order {
    enum State { PENDING, SHIPPED, CANCELLED }
    enum CancelResult { CANCELLED, INVALID_STATE }
    private State state = State.PENDING;
    public CancelResult cancel() {
        if (state != State.PENDING) return CancelResult.INVALID_STATE;
        state = State.CANCELLED;
        return CancelResult.CANCELLED;
    }
}
```

## 操作結果與使用端處理

本組由共通規範承接的要求：[結果與目前狀態分開表達](../../../coding/domain-modeling.md#operation-results)。

<a id="java-typed-business-failures"></a>

### 具型別的業務失敗

依[錯誤處理](../../../coding/error-handling.md#failure-classification)執行。Java 可用不同失敗型別或具型別原因代碼；技術故障仍透過例外，不為統一格式混入一般業務失敗。

**違反**

```java
// 為統一結果格式而將技術故障混入一般業務失敗。
class Reservation {
    interface Stock { boolean reserve() throws IOException; }
    enum Result { ACCEPTED, SOLD_OUT, TECHNICAL_FAILURE }
    Result reserve(Stock stock) {
        try { return stock.reserve() ? Result.ACCEPTED : Result.SOLD_OUT; }
        catch (IOException failure) { return Result.TECHNICAL_FAILURE; }
    }
}
```

**符合**

```java
// 業務失敗以原因代碼表達，技術故障仍透過例外傳遞。
class Reservation {
    interface Stock { boolean reserve() throws IOException; }
    enum Result { ACCEPTED, SOLD_OUT }
    Result reserve(Stock stock) throws IOException {
        return stock.reserve() ? Result.ACCEPTED : Result.SOLD_OUT;
    }
}
```

<a id="java-exhaustive-result-handling"></a>

### 處理完整性

依[處理完整性的共通要求](../../../coding/domain-modeling.md#exhaustive-result-handling)執行。Java 優先利用適用版本的編譯檢查；工具無法涵蓋的分支由測試及審查補足，不以 `default` 將未知狀態當成功。

**違反**

```java
// 預設分支把未處理的待確認結果當成成功。
class Display {
    enum Result { SUCCESS, REJECTED, PENDING }
    String message(Result result) {
        return switch (result) {
            case REJECTED -> "拒絕";
            default -> "成功";
        };
    }
}
```

**符合**

```java
// 列舉 switch 運算式列出全部情況並接受編譯完整性檢查。
class Display {
    enum Result { SUCCESS, REJECTED, PENDING }
    String message(Result result) {
        return switch (result) {
            case SUCCESS -> "成功";
            case REJECTED -> "拒絕";
            case PENDING -> "待確認";
        };
    }
}
```

**版本差異**

- Java 8／11：沒有 switch 運算式（Java 14 正式發布，見 [JEP 361](https://openjdk.org/jeps/361)），以列舉 switch 敘述列出已知分支，並以 `default: throw` 拒絕未知狀態；完整性仍須由測試及審查補足。
- Java 17 起：可用列舉 switch 運算式接受編譯器的窮盡檢查；Java 17 的 pattern switch 為 Preview（[JEP 406](https://openjdk.org/jeps/406)），不得用於規範範例，專案採用依 [Preview 功能要求](version-policy.md#java-preview-features)處理；仍不得把未知狀態當成功。
- Java 21 起：可用正式的 pattern switch（[JEP 409](https://openjdk.org/jeps/409)、[JEP 441](https://openjdk.org/jeps/441)）搭配 sealed 型別接受窮盡檢查；仍須完整處理分支，不以 `default` 將未知狀態當成功。

**符合（Java 11）**

```java
// 列出已知結果並拒絕未知狀態，完整性另由測試及審查補足。
class Display {
    enum Result { SUCCESS, REJECTED, PENDING }
    String message(Result result) {
        switch (result) {
            case SUCCESS: return "成功";
            case REJECTED: return "拒絕";
            case PENDING: return "待確認";
            default: throw new IllegalStateException("未知結果");
        }
    }
}
```

**符合（Java 21）**

```java
// 封閉結果型別搭配模式 switch，缺少分支時由編譯器拒絕。
sealed interface Result permits Success, Rejected, Pending {}
record Success() implements Result {}
record Rejected() implements Result {}
record Pending() implements Result {}
class Display {
    String message(Result result) {
        return switch (result) {
            case Success success -> "成功";
            case Rejected rejected -> "拒絕";
            case Pending pending -> "待確認";
        };
    }
}
```

## 外部代碼、擴充與結果資料

本組由共通規範承接的要求：[結果保留當時事實](../../../coding/domain-modeling.md#result-facts)。

<a id="java-stable-external-codes"></a>

### 穩定的外部代碼

持久化或跨邊界傳遞狀態時，須明訂穩定的外部代碼與映射，不得使用 `ordinal()` 作為業務契約。若採用列舉名稱作為外部值，須將名稱納入相容性管理，重新命名不能僅視為內部整理。未知代碼依契約處理，不得默默映射成任意既有狀態。不強制額外建立轉換類別，但映射與影響須可辨識。

**違反**

```java
// 使用列舉位置作為外部代碼，排序變更就改變契約。
enum State {
    PENDING, PAID;
    int externalCode() { return ordinal(); }
    static State fromCode(int code) { return values()[code]; }
}
```

**符合**

```java
// 外部代碼固定映射，未知代碼依此範例契約拒絕。
enum State {
    PENDING(10), PAID(20);
    private final int code;
    State(int code) { this.code = code; }
    int externalCode() { return code; }
    static State fromCode(int code) {
        return switch (code) {
            case 10 -> PENDING;
            case 20 -> PAID;
            default -> throw new IllegalArgumentException("未知狀態代碼");
        };
    }
}
```

**版本差異**

- Java 8／11：沒有 switch 運算式（Java 14 正式發布），以 switch 敘述維持外部代碼固定映射的同一保證；仍須拒絕本範例契約未定義的代碼，不以 `ordinal()` 代替映射。（[JEP 361](https://openjdk.org/jeps/361)）
- Java 17 起：可用 switch 運算式表達外部代碼映射；仍須明訂穩定代碼並依契約處理未知值，語法不會自動保護代碼相容性。（[JEP 361](https://openjdk.org/jeps/361)）

**符合（Java 8）**

```java
// 外部代碼固定映射，以傳統分支拒絕未知代碼。
enum State {
    PENDING(10), PAID(20);
    private final int code;
    State(int code) { this.code = code; }
    int externalCode() { return code; }
    static State fromCode(int code) {
        switch (code) {
            case 10: return PENDING;
            case 20: return PAID;
            default: throw new IllegalArgumentException("未知狀態代碼");
        }
    }
}
```

<a id="java-model-extensibility"></a>

### 封閉或允許擴充

依[封閉或允許擴充的共通要求](../../../coding/domain-modeling.md#model-extensibility)執行。支援 `sealed` 的 Java 版本可用其限制實作；其他版本以可見性、建立入口及檢查維持封閉契約，不強制同一語法。

**違反**

```java
// 契約只允許成功或拒絕，但介面未限制其他實作。
interface Result {}
record Success() implements Result {}
record Rejected() implements Result {}
record Unexpected() implements Result {}
```

**符合**

```java
// 以 sealed 限制此封閉契約只允許成功或拒絕。
sealed interface Result permits Success, Rejected {}
record Success() implements Result {}
record Rejected() implements Result {}
```

**版本差異**

- Java 8／11：沒有 `sealed`（Java 17 正式發布），以私有建構子的抽象類別及巢狀 `final` 子類別維持封閉契約的同一保證；仍須檢查可見性與建立入口，避免其他實作進入模型。（[JEP 409](https://openjdk.org/jeps/409)）
- Java 17 起：可用 `sealed` 與 `permits` 限制直接子型別；仍須依契約控制後續擴充，`non-sealed` 會重新開放該分支，不得用它破壞原本的封閉契約。（[JEP 409](https://openjdk.org/jeps/409)）

**符合（Java 8）**

```java
// 私有基底建構子與巢狀 final 子類別封閉結果階層。
abstract class Result {
    private Result() {}
    static final class Success extends Result {}
    static final class Rejected extends Result {}
}
```

<a id="java-model-acceptance"></a>

### 模型驗收

依[模型驗收的共通要求](../../../coding/domain-modeling.md#model-verification)執行。Java 狀態型別、使用端分支、`enum` 外部代碼及封閉模型依[本文件驗收要求](#驗收要求)與[處理完整性、封閉或允許擴充驗收](../../../coding/domain-modeling.md#acceptance-model-extensibility)驗收，並核對實際副作用。

<a id="java-closing-requirements"></a>

## 補充要求

對外結果與完成程度另依[API 操作語意](../../../interfaces/api-contracts.md#operation-scope-and-success)及[事件可靠性](../../../interfaces/events.md#recoverable-publication)；代碼與資料格式變更依[資料契約](../../../interfaces/data-contracts.md#compatibility-and-changes)及[資料遷移](../../../data/migrations.md#version-compatibility)。不可變資料的保護方式另見[專屬值型別與領域值物件](value-objects.md)。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依受影響的模型與呼叫端選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md#test-levels-and-cases)與[規範驗證](../../../quality/rule-verification.md#verification-coverage)。

### 共同驗收

- [結果與目前狀態分開表達](../../../coding/domain-modeling.md#acceptance-operation-results)。
- [處理完整性、封閉或允許擴充](../../../coding/domain-modeling.md#acceptance-model-extensibility)。
- [結果保留當時事實](../../../coding/domain-modeling.md#acceptance-result-facts)。
- [模型驗收](../../../coding/domain-modeling.md#acceptance-model-coverage)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-independent-state-models"></a>[明確的狀態型別](#java-explicit-state-types)、[各狀態的必要資料](#java-required-state-data) | 審查互斥狀態與獨立業務面向是否正確分開，必要資料是否由對應型別保護。確認不能建立契約禁止的狀態與資料組合，不以僅存在狀態碼作為符合依據。 |
| <a id="acceptance-java-state-transition"></a>[業務操作控制轉換](#java-business-state-transitions) | 驗證允許與不允許的來源狀態、前置條件及轉換後資料。確認公開介面沒有可繞過規則的任意設定路徑，拒絕時未產生不應發生的副作用。 |
| <a id="acceptance-java-enum-codes"></a>[穩定的外部代碼](#java-stable-external-codes) | 經適用的傳輸或持久化路徑驗證外部代碼與狀態對應，未知代碼依契約處理。確認未使用 `ordinal()` 作為業務代碼，採用列舉名稱時已評估重新命名的相容性影響。 |

既有程式碼與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不因版本或工具限制自行降低要求。
