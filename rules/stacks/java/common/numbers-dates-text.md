# Java 數值、日期時間與文字處理

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[型別安全](../../../coding/type-safety.md)與[領域建模](../../../coding/domain-modeling.md)，定義 Java 數值、時間與文字的表示及轉換要求。專屬型別與正規化依[值物件規範](value-objects.md)，比較與集合判同另依[相等性、雜湊與排序](equality-hashing-ordering.md)。

## 數值表示與運算

本組下列要求由共通規範承接：[範圍與轉換檢查](../../../coding/numbers-dates-text.md#numeric-range-checks)。

<a id="java-numeric-representation"></a>

### 依語意選擇數值型別

依[依語意選擇數值型別的共通要求](../../../coding/numbers-dates-text.md#numeric-representation)執行。Java 精確十進位語意使用 `BigDecimal` 或契約允許的最小單位整數，不以二進位浮點數作精確表示。

<a id="java-exact-numeric-sources"></a>

### 從精確來源建立

依[從精確來源建立的共通要求](../../../coding/numbers-dates-text.md#exact-numeric-sources)執行。Java 精確值不可先轉浮點數再轉 `BigDecimal` 期待還原；直接從契約允許的精確來源建立後仍須驗證業務限制。

<a id="java-rounding-policy"></a>

### 明訂捨入規則

依[明訂捨入規則的共通要求](../../../coding/numbers-dates-text.md#rounding-policy)執行。Java 數值運算依契約指定精度、捨入模式及時機，不能讓 API 預設或各呼叫端自行決定。

<a id="java-decimal-equivalence"></a>

### BigDecimal 判同語意

須明訂數值相等與小數位數的關係，依契約選擇比較及正規化方式。例如 `1.0` 與 `1.00` 是否視為相同，須確認小數位數是呈現格式或資料語意的一部分。專屬型別的相等、雜湊與排序須維持一致，不得讓格式差異意外改變業務判同或集合行為。

## 日期時間語意與來源

本組下列要求由共通規範承接：[明確的時區轉換](../../../coding/numbers-dates-text.md#timezone-conversion)。

<a id="java-temporal-representation"></a>

### 依業務語意選擇時間型別

依[依業務語意選擇時間型別的共通要求](../../../coding/numbers-dates-text.md#temporal-representation)執行。Java 優先使用 `java.time`：日期可用 `LocalDate`，確切時點可用 `Instant`；不得以 `LocalDateTime` 冒充唯一時點，必要時保留時區或偏移。

<a id="java-durations-calendar-periods"></a>

### 區分時間長度與日曆規則

依[區分時間長度與日曆規則的共通要求](../../../coding/numbers-dates-text.md#durations-and-calendar-periods)執行。Java 按語意使用 `Duration`、`Period` 或業務計算，不假設一般日曆間隔包含營業日規則。

<a id="java-clock-source"></a>

### 可控制的時間基準

依[可控制的時間基準的共通要求](../../../coding/numbers-dates-text.md#time-source)執行。Java 業務目前時間優先由明確提供的 `Clock` 取得；耗時及等待期限使用適合的單調時間來源。

<a id="java-temporal-parsing-formatting"></a>

### 解析與輸出契約

依[解析與輸出契約的共通要求](../../../coding/numbers-dates-text.md#temporal-parsing-formatting)執行。Java 解析及格式化須明訂格式、地區、時區／偏移及精度，不允許寬鬆修正非法日期或只解析前段。

## 文字編碼、長度與比較

本組下列要求由共通規範承接：[明確指定字元編碼](../../../coding/numbers-dates-text.md#character-encoding)、[用途明確的文字轉換](../../../coding/numbers-dates-text.md#text-transformations)。

<a id="java-text-length-units"></a>

### 長度與截取單位

依[長度與截取單位的共通要求](../../../coding/numbers-dates-text.md#text-length-units)執行。Java `String.length()` 計算 UTF-16 單位，不是通用字數；截取不能切斷代理對或契約要求保留的字元組合。

<a id="java-boundary-verification"></a>

### 邊界與環境差異驗收

依[邊界與環境差異驗收的共通要求](../../../coding/numbers-dates-text.md#data-boundary-verification)執行。Java `BigDecimal`、`java.time`、`Clock` 及字串轉換的實際路徑依下方表格驗收。

<a id="java-closing-requirements"></a>

## 補充要求

對外格式與轉換另依[資料契約](../../../interfaces/data-contracts.md)及[Java 邊界物件與資料映射](boundary-mapping.md)；具體 API 與語法使用須符合[版本要求](version-policy.md)。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依受影響契約選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。

### 共同驗收

- [依語意選擇數值型別、從精確來源建立](../../../coding/numbers-dates-text.md#acceptance-numeric-sources)。
- [明訂捨入規則、範圍與轉換檢查](../../../coding/numbers-dates-text.md#acceptance-numeric-range-rounding)。
- [依業務語意選擇時間型別、明確的時區轉換、區分時間長度與日曆規則](../../../coding/numbers-dates-text.md#acceptance-temporal-semantics)。
- [解析與輸出契約](../../../coding/numbers-dates-text.md#acceptance-temporal-format)。
- [明確指定字元編碼、長度與截取單位、用途明確的文字轉換](../../../coding/numbers-dates-text.md#acceptance-text-semantics)。
- [邊界與環境差異驗收](../../../coding/numbers-dates-text.md#acceptance-data-boundaries)。
- [可控制的時間基準](../../../coding/numbers-dates-text.md#acceptance-time-source)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-decimal-equivalence"></a>[BigDecimal 判同語意](#java-decimal-equivalence) | 以數值相同但小數位數不同及其他代表性資料，確認比較、正規化、雜湊與集合判同符合契約。 |
| <a id="acceptance-java-clock-injection"></a>[可控制的時間基準](#java-clock-source) | 以注入的 Clock 驗證業務時間邊界前、當下與之後，核對實際 Java 取時路徑使用該 Clock。 |

既有程式碼與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行降低要求。
