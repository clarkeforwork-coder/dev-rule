# Java 邊界物件與資料映射

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[邊界物件](../../../architecture/boundary-objects.md)與[資料映射](../../../architecture/data-mapping.md)，適用於 Java 的 API、模組、持久化及第三方整合邊界。實際分層與依賴方向由專案架構決定，具體映射與序列化工具設定由 Framework 規範及專案配置落實。

## 契約與映射責任

本組由共通規範承接的要求：[隔離與拆分](../../../architecture/boundary-objects.md#隔離與拆分)、[聚焦轉換與必要驗證](../../../architecture/data-mapping.md#mapping-responsibility)。

<a id="java-mapping-fields"></a>

### 明確控制欄位及來源

依[資料映射](../../../architecture/data-mapping.md#轉換要求)、[API 操作語意與介面設計](../../../interfaces/api-contracts.md#身分與系統管理欄位)、[安全](../../../quality/security.md#授權與資料範圍)執行。Java 映射工具不得因同名或來源新增欄位而擴大傳遞範圍；租戶與建立者等可信欄位仍依伺服器契約取得。

**違反**

```java
// 租戶欄位直接採用外部輸入，未依伺服器契約取得。
record Request(String name, String tenantId) {}
record Command(String name, String tenantId) {}
class Mapping {
    Command map(Request input, String trustedTenantId) {
        return new Command(input.name(), input.tenantId());
    }
}
```

**符合**

```java
// 明確列出傳遞欄位，租戶來自伺服器提供的可信值。
record Request(String name, String tenantId) {}
record Command(String name, String tenantId) {}
class Mapping {
    Command map(Request input, String trustedTenantId) {
        return new Command(input.name(), trustedTenantId);
    }
}
```

## 轉換完整性與隔離

<a id="java-mapping-integrity"></a>

### 失敗明確回報

依[錯誤處理](../../../coding/error-handling.md#失敗分類與表達)、[資料驗證](../../../coding/validation.md#責任分工)、[資料映射](../../../architecture/data-mapping.md#mapping-path-verification)執行。依[Java 實際映射路徑驗收](#acceptance-java-mapping-failure)與[多步驟及部分成功驗收](../../../coding/error-handling.md#acceptance-partial-operation)驗收拒絕、缺陷與部分成功，不以建立了目標型別就視為有效。不得略過欄位或產生不完整物件掩蓋失敗。

**違反**

```java
// 解析失敗仍回傳缺少必要金額的目標物件，掩蓋失敗。
record Amount(BigDecimal value) {}
class Mapping {
    Amount map(String value) {
        try {
            return new Amount(new BigDecimal(value));
        } catch (NumberFormatException error) {
            return new Amount(null);
        }
    }
}
```

**符合**

```java
// 解析失敗明確回報外部金額格式不合法，不產生半成品。
record Amount(BigDecimal value) {}
class Mapping {
    Amount map(String value) {
        try {
            return new Amount(new BigDecimal(value));
        } catch (NumberFormatException error) {
            throw new IllegalArgumentException("金額格式不合法", error);
        }
    }
}
```

<a id="java-update-intent"></a>

### 保留更新意圖

映射須保留契約要求的未提供、明確清空與設定值等差異，不得因 Java 欄位、預設值或反序列化行為而合併不同意圖。需要多種更新狀態時，須使用明確型別一路傳遞至負責更新的業務操作，不能僅依同一個 `null` 或 `Optional` 推測三種意圖。

**違反**

```java
// 未提供與明確清空都轉成 null，業務操作無法區分。
class Update {
    String name = "原值";
    void map(Map<String, String> input) {
        apply(input.get("name"));
    }
    void apply(String value) {
        if (value != null) name = value;
    }
}
```

**符合**

```java
// 明確型別保留更新意圖，此欄位契約以空字串表示已清空。
sealed interface Change {
    record Absent() implements Change {}
    record Clear() implements Change {}
    record Set(String value) implements Change { public Set { Objects.requireNonNull(value); } }
}
class Update {
    String name = "原值";
    void map(Change input) { apply(input); }
    void apply(Change change) {
        if (change instanceof Change.Clear) name = "";
        else if (change instanceof Change.Set set) name = set.value();
    }
}
```

<a id="java-mutable-isolation"></a>

### 集合與可變元素的隔離

依[邊界物件](../../../architecture/boundary-objects.md#不可變性)、[程式碼設計與公開介面](../../../coding/code-design.md#可見性與狀態所有權)執行。Java 複製集合外層不一定隔離可變元素；符合契約的不可變值可共用，不要求全面深層複製。

**違反**

```java
// 只複製集合外層，呼叫端仍能透過元素修改內部狀態。
class Boundary {
    private final List<StringBuilder> values =
            List.of(new StringBuilder("原值"));
    List<StringBuilder> snapshot() {
        return new ArrayList<>(values);
    }
}
```

**符合**

```java
// 複製可變元素，隔離快照與內部狀態。
class Boundary {
    private final List<StringBuilder> values =
            List.of(new StringBuilder("原值"));
    List<StringBuilder> snapshot() {
        return values.stream().map(StringBuilder::new).toList();
    }
}
```

<a id="java-directional-mapping"></a>

### 各方向分別定義

依[各方向分別定義的共通要求](../../../architecture/data-mapping.md#directional-mapping)執行。Java 映射工具支援反向產生不代表可直接採用；具體工具配置另由 Framework 規範落實。

**違反**

```java
// 直接反轉輸出映射，把遮罩後的電話寫回業務物件。
record User(String name, String phone) {}
record View(String name, String phone) {}
class Mapping {
    View output(User user) { return new View(user.name(), "***"); }
    User input(View view) { return new User(view.name(), view.phone()); }
}
```

**符合**

```java
// 輸入契約只更新名稱，與含遮罩電話的輸出分別定義。
record User(String name, String phone) {}
record View(String name, String phone) {}
record Rename(String name) {}
class Mapping {
    View output(User user) { return new View(user.name(), "***"); }
    User input(Rename input, User current) {
        return new User(input.name(), current.phone());
    }
}
```

## 維護與驗證

<a id="java-mapping-ownership"></a>

### 明確維護責任

依[資料映射](../../../architecture/data-mapping.md#責任配置)、[共用能力](../../../architecture/shared-capabilities.md#共用程式碼)、[框架與依賴組裝](../../../architecture/dependency-composition.md#介面與抽象)執行。Java 簡單映射可使用方法，有實際責任或共用需求才建立專責類別，不強制 Mapper 介面或包裝層。

**違反**

```java
// 僅為單一邊界的一行轉換增設介面與包裝，沒有額外責任或共用需求。
record Request(String name) {}
record Command(String name) {}
interface Mapper { Command map(Request input); }
class CommandMapper implements Mapper {
    public Command map(Request input) { return new Command(input.name()); }
}
class Boundary {
    private final Mapper mapper = new CommandMapper();
    Command accept(Request input) { return mapper.map(input); }
}
```

**符合**

```java
// 單一邊界的簡單轉換直接使用方法，不強制增設 Mapper 層。
record Request(String name) {}
record Command(String name) {}
class Boundary {
    Command accept(Request input) { return map(input); }
    private Command map(Request input) { return new Command(input.name()); }
}
```

<a id="java-mapping-verification"></a>

### 驗證實際映射路徑

依[驗證實際映射路徑的共通要求](../../../architecture/data-mapping.md#mapping-path-verification)執行。Java 測試須經實際映射及適用的序列化／反序列化路徑，不能只測手寫替代版本。

**違反**

```java
// 測試只驗證手寫替代轉換，沒有經過實際採用的映射方法。
record Command(int count) {}
class Boundary {
    static Command map(String input) { return new Command(Integer.parseInt(input)); }
}
class MappingTest {
    void test() {
        Command result = new Command(Integer.parseInt("3"));
        if (result.count() != 3) throw new AssertionError();
    }
}
```

**符合**

```java
// 測試呼叫實際採用的映射方法並檢查欄位值。
record Command(int count) {}
class Boundary {
    static Command map(String input) { return new Command(Integer.parseInt(input)); }
}
class MappingTest {
    void test() {
        Command result = Boundary.map("3");
        if (result.count() != 3) throw new AssertionError();
    }
}
```

<a id="java-closing-requirements"></a>

## 補充要求

型別與缺值處理另依[型別宣告與泛型](types-and-generics.md)及[null 與 Optional](null-and-optional.md)；專屬型別的建立與還原依[值物件規範](value-objects.md)。失敗分類依[錯誤處理](../../../coding/error-handling.md#失敗分類與表達)，可信欄位與資料揭露依[安全規範](../../../quality/security.md#授權與資料範圍)。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響與實際邊界選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md#層級與案例選擇)與[規範驗證](../../../quality/rule-verification.md#verification-coverage)。

### 共同驗收

- [隔離與拆分](../../../architecture/boundary-objects.md#acceptance-boundary-separation)。
- [轉換要求、最小必要欄位](../../../architecture/data-mapping.md#acceptance-mapping-fields)。
- [不可變性](../../../architecture/boundary-objects.md#acceptance-boundary-isolation)。
- [責任配置](../../../architecture/data-mapping.md#acceptance-mapping-owner)。
- [聚焦轉換與必要驗證](../../../architecture/data-mapping.md#acceptance-mapping-responsibility)。
- [各方向分別定義](../../../architecture/data-mapping.md#acceptance-directional-mapping)。
- [驗證實際映射路徑](../../../architecture/data-mapping.md#acceptance-mapping-paths)。
- [多步驟與部分成功](../../../coding/error-handling.md#acceptance-partial-operation)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-mapping-failure"></a>[失敗明確回報](#java-mapping-integrity) | 透過 Java 實際映射路徑輸入不合法資料、內部必要資料缺失與轉換失敗，確認沒有以預設值或半成品掩蓋問題，且未略過欄位或產生不完整物件掩蓋失敗。 |
| <a id="acceptance-java-update-intent"></a>[保留更新意圖](#java-update-intent) | 核對 Java 欄位、預設值與反序列化路徑未合併省略、明確清空及設定值的不同意圖。 |

既有程式碼、工具限制與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行降低型別安全與邊界要求。
