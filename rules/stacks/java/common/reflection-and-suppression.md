# Java 反射、動態能力與檢查抑制

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[型別安全](../../../coding/type-safety.md)及[規範治理](../../../workflow/rule-governance.md)，定義動態能力、特殊存取與檢查抑制的限制。手寫整合與測試程式碼適用相同要求，工具限制不構成自動例外。Java 型別要求另依[型別宣告與泛型](types-and-generics.md)，JDK 內部 API 與存取放寬另依[版本要求](version-policy.md)。

## 動態能力與存取邊界

本組由共通規範承接的要求：[受控目標與授權](../../../quality/security.md#dynamic-target-authorization)。

<a id="java-dynamic-type-contract"></a>

### 明確需求與型別契約

反射與動態呼叫須有明確需求，已知的業務能力優先透過靜態型別契約表達。必要動態能力須集中於責任明確的元件，限制影響範圍並提供具型別的內部契約，不得藉此繞過型別安全要求。框架整合、外掛或通用工具的動態名稱與未知物件不得任意散入業務流程。

**違反**

```java
// 已知業務能力仍透過動態名稱呼叫。
class Example {
    void execute(Object service) throws ReflectiveOperationException {
        service.getClass().getMethod("submit").invoke(service);
    }
}
```

**符合**

```java
// 已知業務能力以靜態型別契約表達。
class Example {
    interface Submission { void submit(); }
    void execute(Submission service) {
        service.submit();
    }
}
```

<a id="java-reflective-encapsulation"></a>

### 維持封裝與不變條件

反射與動態能力不得繞過可見性設計、建立驗證或業務不變條件。需要特殊存取時，優先採用受支援的整合方式；必要的存取放寬須個別核准並驗證影響，不得以框架、映射或測試用途自行豁免。例如不能以直接寫入私有欄位避開正式建立規則。

**違反**

```java
// 反射直接寫入私有欄位，繞過金額驗證。
class Example {
    static class Amount {
        private int value;
        Amount(int value) {
            if (value < 0) throw new IllegalArgumentException("金額不可為負");
            this.value = value;
        }
    }
    Amount restore(int value) throws ReflectiveOperationException {
        Amount amount = new Amount(0);
        Amount.class.getDeclaredField("value").setInt(amount, value);
        return amount;
    }
}
```

**符合**

```java
// 還原時使用正式建構子，維持金額驗證。
class Example {
    static class Amount {
        private int value;
        Amount(int value) {
            if (value < 0) throw new IllegalArgumentException("金額不可為負");
            this.value = value;
        }
    }
    Amount restore(int value) {
        return new Amount(value);
    }
}
```

**版本差異**

- Java 8：沒有 Java 9 引入的模組封裝，須以公開 API、正式建構子及特殊存取審查維持同一封裝保證；反射成功仍不代表已獲核准；執行期差異，範例不驗證。（[JEP 403](https://openjdk.org/jeps/403)）
- Java 11：預設仍容許未命名模組反射存取部分 JDK 8 已存在套件的內部成員，仍須逐項核准特殊存取，不得把警告或呼叫成功當成授權；執行期差異，範例不驗證。（[JEP 403](https://openjdk.org/jeps/403)）
- Java 17 起：`record` 自 Java 16 起（JEP 395）；Java 16 起預設強封裝 JDK 內部實作，Java 17 起 `--illegal-access` 無法恢復寬鬆模式；必要的 `--add-opens` 仍須個別核准，且 `record` 之 final 欄位即使放寬存取也不能反射寫入，仍須走正式建立流程維持不變條件；執行期差異，範例不驗證。（[JEP 403](https://openjdk.org/jeps/403)、[JEP 395](https://openjdk.org/jeps/395)、[AccessibleObject API](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/reflect/AccessibleObject.html#setAccessible(boolean))）

<a id="java-dynamic-contract-validation"></a>

### 使用前驗證契約

依[使用前驗證契約的共通要求](../../../coding/type-safety.md#dynamic-contract-validation)執行。Java 動態元件須驗證能力、版本及型別，不只確認名稱存在，也不靠未驗證轉型掩蓋不相容。

**違反**

```java
// 外掛註冊時直接轉型，未驗證能力、版本及型別。
class Example {
    interface Plugin { int version(); String render(); }
    Plugin register(Object candidate) {
        return (Plugin) candidate;
    }
}
```

**符合**

```java
// 外掛註冊先確認能力介面與型別，再驗證支援的契約版本。
class Example {
    interface Plugin { int version(); String render(); }
    Plugin register(Object candidate) {
        if (!(candidate instanceof Plugin plugin) || plugin.version() != 1) {
            throw new IllegalArgumentException("外掛契約不相容");
        }
        return plugin;
    }
}
```

**版本差異**

- Java 8／11：沒有 Java 16 正式發布的 `instanceof` 型別模式，先以傳統 `instanceof` 確認能力介面再轉型，仍須驗證契約版本，維持同一保證。（[JEP 394](https://openjdk.org/jeps/394)）
- Java 17 起：可用 `instanceof` 型別模式合併型別檢查與變數綁定，仍須額外驗證外掛契約版本。（[JEP 394](https://openjdk.org/jeps/394)）

**符合（Java 8）**

```java
// 外掛先確認介面再轉型，並驗證支援的契約版本。
class Example {
    interface Plugin { int version(); String render(); }
    Plugin register(Object candidate) {
        if (!(candidate instanceof Plugin)) {
            throw new IllegalArgumentException("外掛契約不相容");
        }
        Plugin plugin = (Plugin) candidate;
        if (plugin.version() != 1) {
            throw new IllegalArgumentException("外掛契約不相容");
        }
        return plugin;
    }
}
```

<a id="java-reflection-failure"></a>

### 區分故障與執行結果

依[區分故障與執行結果的共通要求](../../../coding/error-handling.md#dynamic-failure-classification)執行。Java 反射或動態呼叫的外層例外須保留原始原因。

**違反**

```java
// 包裝反射故障時只留下訊息，遺失原始原因。
class Example {
    Object create(Class<?> type) {
        try {
            return type.getConstructor().newInstance();
        } catch (ReflectiveOperationException failure) {
            throw new IllegalStateException("動態建立失敗：" + type.getName());
        }
    }
}
```

**符合**

```java
// 包裝時保留反射例外及其原因鏈，供呼叫端辨別故障。
class Example {
    Object create(Class<?> type) {
        try {
            return type.getConstructor().newInstance();
        } catch (ReflectiveOperationException failure) {
            throw new IllegalStateException("動態建立失敗：" + type.getName(), failure);
        }
    }
}
```

**版本差異**

- Java 11：可用 Java 9 起的 `canAccess` 檢查呼叫端能否存取；必要且已核准的存取放寬若使用 `trySetAccessible`，回傳 `false` 仍須視為存取失敗，不能當成正常業務結果；`setAccessible` 的 `InaccessibleObjectException` 也不得遺失原因或被吞掉；執行期差異，範例不驗證。（[AccessibleObject API `@since 9`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/reflect/AccessibleObject.html#trySetAccessible())）
- Java 17 起：JDK 強封裝使先前依賴寬鬆存取的反射路徑可能失敗，仍須保留存取故障及原始原因，不得轉成查無資料或成功結果；執行期差異，範例不驗證。（[JEP 403](https://openjdk.org/jeps/403)）

## 檢查抑制與產生碼

<a id="java-warning-suppression"></a>

### 限定檢查抑制

依[限定檢查抑制的共通要求](../../../workflow/rule-governance.md#suppression-scope)執行。Java `@SuppressWarnings` 須限具體規則及最小範圍；raw type／unchecked 仍遵守型別與泛型規範的禁止事項及個別核准要求。

**違反**

```java
// 僅需抑制未使用序列化的內部例外警告，卻擴及整個外層類別。
@SuppressWarnings("serial")
class Example {
    static class LocalFailure extends RuntimeException {}
    void execute() { throw new LocalFailure(); }
}
```

**符合**

```java
// 此內部例外不作序列化；僅在該型別抑制序列化警告，使用方式改變時重查。
class Example {
    @SuppressWarnings("serial")
    static class LocalFailure extends RuntimeException {}
    void execute() { throw new LocalFailure(); }
}
```

**版本差異**

- Java 8：沒有 Java 9 引入的 `removal` 警告分類，普通棄用警告以 `deprecation` 精確指定，仍須限制在必要的最小範圍，維持同一抑制保證。（[JEP 277](https://openjdk.org/jeps/277)）
- Java 11：可用 Java 9 起的 `removal` 指定預定移除警告，`deprecation` 不會抑制這類警告；仍須按實際警告選擇具體規則及最小範圍，不得將兩者一律合併抑制。（[JEP 277](https://openjdk.org/jeps/277)）
- Java 21 起：可用新增的 `javac -Xlint:this-escape` 檢查建構期間可能外洩的 `this`；對應的 `@SuppressWarnings("this-escape")` 仍須限定具體規則及最小範圍，不得用抑制代替修正建構安全問題。（[JDK 21 發行說明，JDK-8015831](https://www.oracle.com/java/technologies/javase/21-relnote-issues.html)）

**符合（Java 8）**

```java
// 已核准的舊介面銜接僅在必要方法抑制普通棄用警告。
class Legacy {
    @Deprecated static void execute() {}
}
class Example {
    @SuppressWarnings("deprecation")
    void execute() { Legacy.execute(); }
}
```

**符合（Java 11）**

```java
// 已核准的暫時銜接僅在必要方法抑制預定移除警告。
class Legacy {
    @Deprecated(forRemoval = true) static void execute() {}
}
class Example {
    @SuppressWarnings("removal")
    void execute() { Legacy.execute(); }
}
```

<a id="java-generated-code"></a>

### 產生碼不擴大豁免

依[產生碼不擴大豁免的共通要求](../../../workflow/rule-governance.md#generated-code-exceptions)執行。Java 產生碼須由來源／設定重建；手寫銜接維持完整型別檢查，重建後確認例外範圍仍適用。

**違反**

```java
// 手寫銜接將產生碼的未知結果直接轉型，未維持型別驗證。
class Example {
    interface GeneratedClient { Object read(); }
    String read(GeneratedClient client) {
        return (String) client.read();
    }
}
```

**符合**

```java
// 手寫銜接驗證產生碼的結果型別，對內提供明確契約。
class Example {
    interface GeneratedClient { Object read(); }
    String read(GeneratedClient client) {
        Object value = client.read();
        if (value instanceof String text) return text;
        throw new IllegalArgumentException("產生碼結果不符合字串契約");
    }
}
```

**版本差異**

- Java 8：沒有 Java 16 正式發布的 `instanceof` 型別模式，手寫銜接以傳統型別檢查後轉型維持同一保證；產生來源可使用 `javax.annotation.Generated` 標記，仍須由來源／設定重建且不得擴大檢查排除範圍。（[JEP 394](https://openjdk.org/jeps/394)、[JEP 320](https://openjdk.org/jeps/320)）
- Java 11：以傳統 `instanceof` 檢查後轉型維持手寫銜接的同一型別保證；JDK 已移除提供 `javax.annotation.Generated` 的模組，可改用 Java 9 起的 `javax.annotation.processing.Generated`，仍須同步核對產生器與檢查工具的註解識別及排除範圍。（[JEP 394](https://openjdk.org/jeps/394)、[JEP 320](https://openjdk.org/jeps/320)、[Generated API `@since 9`](https://docs.oracle.com/en/java/javase/21/docs/api/java.compiler/javax/annotation/processing/Generated.html)）
- Java 17 起：可用 `instanceof` 型別模式驗證並綁定產生碼的結果，仍須讓手寫銜接維持完整型別檢查，產生碼標記不得擴及手寫部分。（[JEP 394](https://openjdk.org/jeps/394)）

**符合（Java 8）**

```java
// 僅標記可重建的產生介面，手寫銜接先檢查再轉型。
class Example {
    @javax.annotation.Generated("ClientGenerator")
    interface GeneratedClient { Object read(); }
    String read(GeneratedClient client) {
        Object value = client.read();
        if (value instanceof String) return (String) value;
        throw new IllegalArgumentException("產生碼結果不符合字串契約");
    }
}
```

**符合（Java 11）**

```java
// 使用新版產生碼標記，手寫銜接仍先檢查再轉型。
class Example {
    @javax.annotation.processing.Generated("ClientGenerator")
    interface GeneratedClient { Object read(); }
    String read(GeneratedClient client) {
        Object value = client.read();
        if (value instanceof String) return (String) value;
        throw new IllegalArgumentException("產生碼結果不符合字串契約");
    }
}
```

<a id="java-dynamic-verification"></a>

### 驗證限制實際有效

依[驗證限制實際有效的共通要求](../../../quality/rule-verification.md#dynamic-control-verification)執行。Java 實際反射、存取及重新產生路徑依[本文件驗收要求](#驗收要求)，不只確認警告消失或成功目標能執行。

**版本差異**

- Java 11：可用 `--illegal-access=warn`／`debug` 找出相容模式容許的舊 JDK 內部反射路徑，再用 `--illegal-access=deny` 驗證拒絕路徑；仍須實際執行受影響操作，不能只確認成功目標能執行；執行期差異，範例不驗證。（[JEP 403](https://openjdk.org/jeps/403)）
- Java 17 起：`--illegal-access` 已不能切換封裝模式，須以實際部署的模組與個別核准的開放設定驗證允許及拒絕路徑，仍須確認限制有效，不得把編譯成功當成存取已驗證；執行期差異，範例不驗證。（[JEP 403](https://openjdk.org/jeps/403)）

<a id="java-closing-requirements"></a>

## 補充要求

目標與操作權限另依[安全規範](../../../quality/security.md#dynamic-target-authorization)，動態呼叫的失敗傳遞依[例外與資源管理](exceptions-and-resources.md)。建立與還原仍須遵守[類別、介面與物件建立](classes-and-construction.md)及[值物件規範](value-objects.md)。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md#test-levels-and-cases)與[規範驗證](../../../quality/rule-verification.md#verification-coverage)。

### 共同驗收

- [受控目標與授權](../../../quality/security.md#acceptance-dynamic-target-authorization)。
- [使用前驗證契約](../../../coding/type-safety.md#acceptance-dynamic-contract)。
- [區分故障與執行結果](../../../coding/error-handling.md#acceptance-dynamic-failure)。
- [限定檢查抑制](../../../workflow/rule-governance.md#acceptance-suppression-scope)。
- [產生碼不擴大豁免](../../../workflow/rule-governance.md#acceptance-generated-code)。
- [驗證限制實際有效](../../../quality/rule-verification.md#acceptance-dynamic-controls)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-reflection-boundary"></a>[明確需求與型別契約](#java-dynamic-type-contract) | 審查動態能力的必要性、管理位置與內部型別契約。反射與動態呼叫均須納入，確認對內提供明確型別契約，動態名稱及未知物件沒有散入業務流程。 |
| <a id="acceptance-java-reflective-access"></a>[維持封裝與不變條件](#java-reflective-encapsulation) | 核對特殊存取的核准範圍，以及建立與還原不會繞過必要驗證或產出無效物件。對反射與動態能力核對特殊存取的必要性及受支援替代方式，經實際建立及還原路徑確認維持不變條件及封裝；例如私有欄位寫入或存取放寬亦不得繞過上述保證。 |

偏離禁止事項須依[例外核准流程](../../../workflow/rule-governance.md)取得明確決策，不因工具限制自行放寬，也不得將核准擴及其他位置。
