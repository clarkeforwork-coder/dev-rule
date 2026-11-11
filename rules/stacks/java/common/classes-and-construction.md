# Java 類別、介面與物件建立

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[框架與依賴組裝](../../../architecture/dependency-composition.md)及[程式碼設計與公開介面](../../../coding/code-design.md)，定義 Java 類別契約、建立方式與生命週期的共同要求。具體 DI、代理與啟動配置由 Framework 規範及專案落實，仍須符合專案架構的依賴方向。

## 介面、繼承與建立條件

本組由共通規範承接的要求：[繼承的可替代性](../../../coding/code-design.md#substitutability)、[必要資料與依賴齊備](../../../coding/resource-lifecycle.md#initialization-readiness)。

<a id="java-interface-purpose"></a>

### 介面或具體類別的契約依賴

依[框架與依賴組裝](../../../architecture/dependency-composition.md#interfaces)、[模組責任與公開入口](../../../architecture/module-boundaries.md#public-entry-points)執行。Java 可依契約依賴介面或具體類別；單一實作不構成省略必要架構隔離的理由。

<a id="java-construction-safety"></a>

### 建構期間的安全性

建構期間不得讓 `this` 外洩至可能使用該物件的外部元件，也不得呼叫可被覆寫的方法。事件註冊、回呼發布與背景工作啟動等行為，須在物件建立完成且符合生命週期條件後執行，避免使用尚未完成初始化的物件。

**違反**

```java
// 建構子呼叫可覆寫方法，子類別欄位此時尚未初始化。
class Base {
    Base() { initialize(); }
    void initialize() {}
}
class Child extends Base {
    private final List<String> names = new ArrayList<>();
    @Override void initialize() { System.out.println(names.size()); }
}
```

**符合**

```java
// 建構子只呼叫私有方法，不會派送至子類別的覆寫方法。
class Base {
    Base() { initialize(); }
    private void initialize() {}
}
class Child extends Base {
    private final List<String> names = new ArrayList<>();
    void showNameCount() { System.out.println(names.size()); }
}
```

## 依賴、建立方式與擴充

本組由共通規範承接的要求：[介面的能力劃分](../../../coding/code-design.md#interface-capabilities)。

<a id="java-explicit-dependencies"></a>

### 明確取得依賴

依[明確取得依賴的共通要求](../../../architecture/dependency-composition.md#explicit-dependencies)執行。Java 服務透過明確依賴取得；需要延後或按次建立時使用工廠或提供者，不隱藏查全域容器、靜態服務登錄或單例。

**違反**

```java
// 每次執行都隱藏查詢靜態服務登錄以取得工作提供者。
class Registry {
    static Supplier<Runnable> jobs = () -> () -> {};
}
class Service {
    void execute() { Registry.jobs.get().run(); }
}
```

**符合**

```java
// 明確傳入提供者，並在每次執行時取得工作。
class Service {
    private final Supplier<Runnable> jobs;
    Service(Supplier<Runnable> jobs) { this.jobs = jobs; }
    void execute() { jobs.get().run(); }
}
```

<a id="java-construction-entrypoints"></a>

### 依需求選擇建立方式

依[依需求選擇建立方式的共通要求](../../../coding/code-design.md#construction-entrypoints)執行。Java 可選建構子、具名工廠或 Builder；Builder 可暫存組裝中資料，但 `build` 不得產出無效物件。

**違反**

```java
// 此例區間要求起點不大於終點，但 build 可產出相反的無效區間。
record Range(int start, int end) {}
class RangeBuilder {
    int start = 10;
    int end = 1;
    Range build() { return new Range(start, end); }
}
```

**符合**

```java
// Builder 可暫存起訖顛倒的資料，所有建立入口共用區間驗證。
record Range(int start, int end) {
    Range {
        if (start > end) throw new IllegalArgumentException("Invalid range");
    }
}
class RangeBuilder {
    int start = 10;
    int end = 1;
    Range build() { return new Range(start, end); }
}
```

<a id="java-override-scope"></a>

### `super` 呼叫與 `final` 的擴充限制

類別與方法的繼承、覆寫範圍須依明確的擴充需求設計，不供擴充的部分應適當限制。必要業務檢查不得依賴子類別自行遵守才能成立，例如不能只靠子類別記得呼叫 `super`。框架需要的代理或繼承機制須與上述保證相容，不一律強制或禁止使用 `final`。

**違反**

```java
// 子類別未呼叫 super，便繞過金額必須為正的必要檢查。
class Payment {
    void pay(int amount) {
        if (amount <= 0) throw new IllegalArgumentException("Invalid amount");
    }
}
class CashPayment extends Payment {
    @Override void pay(int amount) { System.out.println(amount); }
}
```

**符合**

```java
// 固定入口保留必要檢查，只讓子類別擴充檢查後的付款處理。
abstract class Payment {
    final void pay(int amount) {
        if (amount <= 0) throw new IllegalArgumentException("Invalid amount");
        process(amount);
    }
    protected abstract void process(int amount);
}
class CashPayment extends Payment {
    @Override protected void process(int amount) { System.out.println(amount); }
}
```

## 共用範圍與驗證

本組由共通規範承接的要求：[生命週期與可變狀態相容](../../../coding/resource-lifecycle.md#shared-lifecycle)。

<a id="java-lifecycle-verification"></a>

### 契約與生命週期驗收

依[契約與生命週期驗收的共通要求](../../../coding/resource-lifecycle.md#lifecycle-verification)執行。Java 建構、繼承、覆寫及框架代理須驗證實際路徑；單純值物件不必啟動完整框架。

<a id="java-closing-requirements"></a>

## 補充要求

專屬型別的建立與不可變性另依[值物件規範](value-objects.md)，狀態轉換依[狀態與結果建模](states-and-results.md)，非空條件依[null 與 Optional](null-and-optional.md)。授權限制仍依[安全規範](../../../quality/security.md#authorization-and-data-scope)。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md#test-levels-and-cases)與[規範驗證](../../../quality/rule-verification.md#verification-coverage)。

### 共同驗收

- [介面與抽象](../../../architecture/dependency-composition.md#acceptance-interface-purpose)。
- [繼承的可替代性](../../../coding/code-design.md#acceptance-substitutability)。
- [必要資料與依賴齊備](../../../coding/resource-lifecycle.md#acceptance-initialization-readiness)。
- [明確取得依賴](../../../architecture/dependency-composition.md#acceptance-explicit-dependencies)。
- [依需求選擇建立方式](../../../coding/code-design.md#acceptance-construction-entrypoints)。
- [介面的能力劃分](../../../coding/code-design.md#acceptance-interface-capabilities)。
- [生命週期與可變狀態相容](../../../coding/resource-lifecycle.md#acceptance-shared-lifecycle)。
- [契約與生命週期驗收](../../../coding/resource-lifecycle.md#acceptance-lifecycle-coverage)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-construction-safety"></a>[建構期間的安全性](#java-construction-safety) | 審查 Java 建構路徑是否讓 `this` 外洩或呼叫可覆寫方法；以適用的註冊、回呼及背景啟動路徑確認物件完成建構且已就緒後才被使用。 |
| <a id="acceptance-java-override-safety"></a>[`super` 呼叫與 `final` 的擴充限制](#java-override-scope) | 核對 Java 類別與方法的擴充範圍及覆寫方式，確認必要檢查不依賴子類記得呼叫 `super`。涉及代理或繼承式框架機制時，驗證實際配置仍維持原保證，不一律以加上或移除 `final` 當作修正。 |

既有程式碼、框架限制與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行放寬要求。
