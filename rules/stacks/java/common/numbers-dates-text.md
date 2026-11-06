# Java 數值、日期時間與文字處理

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。條號保留供既有決策與驗收追蹤，不代表引用條目另有一套政策。

本文件承接[型別安全](../../../coding/type-safety.md)與[領域建模](../../../coding/domain-modeling.md)，定義 Java 數值、時間與文字的表示及轉換要求。專屬型別與正規化依[值物件規範](value-objects.md)，比較與集合判同另依[相等性、雜湊與排序](equality-hashing-ordering.md)。

## 數值表示與運算

1. **依語意選擇數值型別**。依[依語意選擇數值型別的共通要求](../../../coding/numbers-dates-text.md#nt-01)執行。Java 精確十進位語意使用 `BigDecimal` 或契約允許的最小單位整數，不以二進位浮點數作精確表示。
2. **從精確來源建立**。依[從精確來源建立的共通要求](../../../coding/numbers-dates-text.md#nt-02)執行。Java 精確值不可先轉浮點數再轉 `BigDecimal` 期待還原；直接從契約允許的精確來源建立後仍須驗證業務限制。
3. **明訂捨入規則**。依[明訂捨入規則的共通要求](../../../coding/numbers-dates-text.md#nt-03)執行。Java 數值運算依契約指定精度、捨入模式及時機，不能讓 API 預設或各呼叫端自行決定。
4. **範圍與轉換檢查**。依[範圍與轉換檢查的共通要求](../../../coding/numbers-dates-text.md#nt-04)執行。Java 縮窄轉型、整數溢位回繞與小數捨棄須明確檢查，不能用強制轉型掩蓋超限。
5. **BigDecimal 判同語意**。須明訂數值相等與小數位數的關係，依契約選擇比較及正規化方式。例如 `1.0` 與 `1.00` 是否視為相同，須確認小數位數是呈現格式或資料語意的一部分。專屬型別的相等、雜湊與排序須維持一致，不得讓格式差異意外改變業務判同或集合行為。

## 日期時間語意與來源

6. **依業務語意選擇時間型別**。依[依業務語意選擇時間型別的共通要求](../../../coding/numbers-dates-text.md#nt-06)執行。Java 優先使用 `java.time`：日期可用 `LocalDate`，確切時點可用 `Instant`；不得以 `LocalDateTime` 冒充唯一時點，必要時保留時區或偏移。
7. **明確的時區轉換**。依[明確的時區轉換的共通要求](../../../coding/numbers-dates-text.md#nt-07)執行。Java 時區轉換須明確指定契約時區或偏移，不讓函式庫預設決定不存在或重複當地時間的業務處置。
8. **區分時間長度與日曆規則**。依[區分時間長度與日曆規則的共通要求](../../../coding/numbers-dates-text.md#nt-08)執行。Java 按語意使用 `Duration`、`Period` 或業務計算，不假設一般日曆間隔包含營業日規則。
9. **可控制的時間基準**。依[可控制的時間基準的共通要求](../../../coding/numbers-dates-text.md#nt-09)執行。Java 業務目前時間優先由明確提供的 `Clock` 取得；耗時及等待期限使用適合的單調時間來源。
10. **解析與輸出契約**。依[解析與輸出契約的共通要求](../../../coding/numbers-dates-text.md#nt-10)執行。Java 解析及格式化須明訂格式、地區、時區／偏移及精度，不允許寬鬆修正非法日期或只解析前段。

## 文字編碼、長度與比較

11. **明確指定字元編碼**。依[明確指定字元編碼的共通要求](../../../coding/numbers-dates-text.md#nt-11)執行。Java 文字與位元組轉換明確指定字元編碼；不得靠系統預設或未授權替換掩蓋資料損失。
12. **長度與截取單位**。依[長度與截取單位的共通要求](../../../coding/numbers-dates-text.md#nt-12)執行。Java `String.length()` 計算 UTF-16 單位，不是通用字數；截取不能切斷代理對或契約要求保留的字元組合。
13. **用途明確的文字轉換**。依[用途明確的文字轉換的共通要求](../../../coding/numbers-dates-text.md#nt-13)執行。Java 字串比較、大小寫與正規化須使用明確地區及用途，不無意依賴環境預設。
14. **邊界與環境差異驗收**。依[邊界與環境差異驗收的共通要求](../../../coding/numbers-dates-text.md#nt-14)執行。Java `BigDecimal`、`java.time`、`Clock` 及字串轉換的實際路徑依下方表格驗收。

對外格式與轉換另依[資料契約](../../../interfaces/data-contracts.md)及[Java 邊界物件與資料映射](boundary-mapping.md)；具體 API 與語法使用須符合[版本要求](version-policy.md)。

## 驗收要求

依變更影響與實際使用路徑選擇案例，測試層級與執行門檻依[共通測試策略](../../../quality/testing.md)。

### 共同驗收

- [data-1-2](../../../coding/numbers-dates-text.md#acceptance-data-1-2)。
- [data-3-4](../../../coding/numbers-dates-text.md#acceptance-data-3-4)。
- [data-6-7-8](../../../coding/numbers-dates-text.md#acceptance-data-6-7-8)。
- [data-10](../../../coding/numbers-dates-text.md#acceptance-data-10)。
- [data-11-12-13](../../../coding/numbers-dates-text.md#acceptance-data-11-12-13)。
- [data-14](../../../coding/numbers-dates-text.md#acceptance-data-14)。
- [time-source](../../../coding/numbers-dates-text.md#acceptance-time-source)。

### Java 語言增量驗收

| Java 條文 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-nt-5"></a>5 | 以數值相同但小數位數不同及其他代表性資料，確認比較、正規化、雜湊與集合判同符合契約。 |
| <a id="acceptance-java-nt-9"></a>9 | 以注入的 Clock 驗證業務時間邊界前、當下與之後，核對實際 Java 取時路徑使用該 Clock。 |
