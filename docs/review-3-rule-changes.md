# 第三次審閱規則改動：前後文字與依據

比較起點：`fba46ee`；要求基準：`6a16349`，RF 另對照 `6f7ae5d`。以下 diff 是實際工作區擷取，沒有省略任何規則變更。

## RF 逐斷言核對

| 列／來源 | 斷言與現況 |
| --- | --- |
| 第 1 列／6f7ae5d | 「審查動態能力的必要性、管理位置與內部型別契約。」逐字存在；授權片段仍指共同驗收，未改追溯去向。 |
| 第 1 列／6a16349 | 實際需求以必要性表達；管理位置、確認對內提供明確型別契約、動態名稱及未知物件不得散入業務流程均保留；反射與動態呼叫仍均納入。 |
| 第 3 列／6f7ae5d | 特殊存取核准、建立與還原不繞過必要驗證、不產出無效物件原片段逐字存在；契約預先檢查片段的共同來源未改。 |
| 第 3 列／6a16349 | 必要性、受支援替代方式、核准範圍、實際建立及還原路徑、必要驗證、不變條件與封裝均保留；私有欄位寫入與存取放寬為例子。此列本次不修改。 |

## boundary-mapping.md

6a16349 的專屬引言原文：

```text
依變更影響與實際邊界選擇案例，沿用[共通測試策略](../../../quality/testing.md)及[規範驗證](../../../quality/rule-verification.md)。
```

基準引言的 Java 型別、API、版本與實際框架路徑要求維持；前輪新增的測試層級及證據要求也保留。

```diff
diff --git a/rules/stacks/java/common/boundary-mapping.md b/rules/stacks/java/common/boundary-mapping.md
index f9db620..30d753f 100644
--- a/rules/stacks/java/common/boundary-mapping.md
+++ b/rules/stacks/java/common/boundary-mapping.md
@@ -26,7 +26,7 @@

 ## 驗收要求

-共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。
+共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響與實際邊界選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。

 ### 共同驗收

```

## naming-packages-docs.md

6a16349 的專屬引言原文：

```text
依變更影響選擇檢查，沿用[共通測試策略](../../../quality/testing.md)及[規範驗證](../../../quality/rule-verification.md)。
```

基準引言的 Java 型別、API、版本與實際框架路徑要求維持；前輪新增的測試層級及證據要求也保留。

```diff
diff --git a/rules/stacks/java/common/naming-packages-docs.md b/rules/stacks/java/common/naming-packages-docs.md
index a18aa84..37f9545 100644
--- a/rules/stacks/java/common/naming-packages-docs.md
+++ b/rules/stacks/java/common/naming-packages-docs.md
@@ -21,7 +21,7 @@

 ## 驗收要求

-共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。
+共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇檢查，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。

 ### 共同驗收

```

## null-and-optional.md

6a16349 的專屬引言原文：

```text
依受影響的契約、呼叫端與邊界選擇案例；自動檢查、行為測試與人工審查共同把關，另依[規範驗證](../../../quality/rule-verification.md)及[共通測試策略](../../../quality/testing.md)辦理。
```

基準引言的 Java 型別、API、版本與實際框架路徑要求維持；前輪新增的測試層級及證據要求也保留。

```diff
diff --git a/rules/stacks/java/common/null-and-optional.md b/rules/stacks/java/common/null-and-optional.md
index 0477f7b..70d09a4 100644
--- a/rules/stacks/java/common/null-and-optional.md
+++ b/rules/stacks/java/common/null-and-optional.md
@@ -29,9 +29,7 @@

 ## 驗收要求

-共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。
-
-依受影響的契約、呼叫端與邊界選擇案例；自動檢查、行為測試與人工審查共同把關，另依[規範驗證](../../../quality/rule-verification.md)及[共通測試策略](../../../quality/testing.md)辦理。
+共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依受影響的契約、呼叫端與邊界選擇案例；自動檢查、行為測試與人工審查共同把關，測試層級及證據依[規範驗證](../../../quality/rule-verification.md)及[共通測試策略](../../../quality/testing.md)辦理。

 ### 共同驗收

```

## numbers-dates-text.md

6a16349 的專屬引言原文：

```text
依受影響契約選擇案例，沿用[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。
```

基準引言的 Java 型別、API、版本與實際框架路徑要求維持；前輪新增的測試層級及證據要求也保留。

```diff
diff --git a/rules/stacks/java/common/numbers-dates-text.md b/rules/stacks/java/common/numbers-dates-text.md
index 41c26bb..6f6a107 100644
--- a/rules/stacks/java/common/numbers-dates-text.md
+++ b/rules/stacks/java/common/numbers-dates-text.md
@@ -31,7 +31,7 @@

 ## 驗收要求

-共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。
+共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依受影響契約選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。

 ### 共同驗收

```

## reflection-and-suppression.md

依據：6a16349 第 1 列的「確認對內提供明確型別契約」，與 6f7ae5d 動態能力原片段合併；第 3 列保持前一輪內容。

```diff
diff --git a/rules/stacks/java/common/reflection-and-suppression.md b/rules/stacks/java/common/reflection-and-suppression.md
index 8ddee44..b13acb5 100644
--- a/rules/stacks/java/common/reflection-and-suppression.md
+++ b/rules/stacks/java/common/reflection-and-suppression.md
@@ -37,7 +37,7 @@

 | Java 條文 | 語言增量驗收 |
 | --- | --- |
-| <a id="acceptance-java-reflection-boundary"></a>1 | 審查動態能力的必要性、管理位置與內部型別契約。反射與動態呼叫均須納入，確認動態名稱及未知物件沒有散入業務流程。 |
+| <a id="acceptance-java-reflection-boundary"></a>1 | 審查動態能力的必要性、管理位置與內部型別契約。反射與動態呼叫均須納入，確認對內提供明確型別契約，動態名稱及未知物件沒有散入業務流程。 |
 | <a id="acceptance-java-reflective-access"></a>3 | 核對特殊存取的核准範圍，以及建立與還原不會繞過必要驗證或產出無效物件。對反射與動態能力核對特殊存取的必要性及受支援替代方式，經實際建立及還原路徑確認維持不變條件及封裝；例如私有欄位寫入或存取放寬亦不得繞過上述保證。 |

 偏離禁止事項須依[例外核准流程](../../../workflow/rule-governance.md#例外核准)取得明確決策，不因工具限制自行放寬，也不得將核准擴及其他位置。
```

## states-and-results.md

6a16349 的專屬引言原文：

```text
依受影響的模型與呼叫端選擇案例，沿用[共通測試策略](../../../quality/testing.md)及[規範驗證](../../../quality/rule-verification.md)。
```

基準引言的 Java 型別、API、版本與實際框架路徑要求維持；前輪新增的測試層級及證據要求也保留。

```diff
diff --git a/rules/stacks/java/common/states-and-results.md b/rules/stacks/java/common/states-and-results.md
index 8ce3e26..5848cee 100644
--- a/rules/stacks/java/common/states-and-results.md
+++ b/rules/stacks/java/common/states-and-results.md
@@ -27,7 +27,7 @@

 ## 驗收要求

-共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。
+共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依受影響的模型與呼叫端選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。

 ### 共同驗收

```

## types-and-generics.md

6a16349 的專屬引言原文：

```text
依變更範圍核對下列項目，包含受影響的呼叫端與測試程式碼。可自動判斷的要求依[規範驗證](../../../quality/rule-verification.md)納入檢查；型別是否表達正確業務語意則由人工審查。
```

基準引言的 Java 型別、API、版本與實際框架路徑要求維持；前輪新增的測試層級及證據要求也保留。

```diff
diff --git a/rules/stacks/java/common/types-and-generics.md b/rules/stacks/java/common/types-and-generics.md
index 217124c..63c63ab 100644
--- a/rules/stacks/java/common/types-and-generics.md
+++ b/rules/stacks/java/common/types-and-generics.md
@@ -34,9 +34,7 @@ Map<OrderId, Order> ordersById = new HashMap<>();

 ## 驗收要求

-共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。
-
-依變更範圍核對下列項目，包含受影響的呼叫端與測試程式碼。可自動判斷的要求依[規範驗證](../../../quality/rule-verification.md)納入檢查；型別是否表達正確業務語意則由人工審查。
+共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更範圍核對下列項目，包含受影響的呼叫端與測試程式碼。測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)；可自動判斷的要求依上述規範納入檢查，型別是否表達正確業務語意則由人工審查。

 ### 共同驗收

```

## value-objects.md

6a16349 的專屬引言原文：

```text
依受影響的值型別與實際使用路徑選擇案例，沿用[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。
```

基準引言的 Java 型別、API、版本與實際框架路徑要求維持；前輪新增的測試層級及證據要求也保留。

```diff
diff --git a/rules/stacks/java/common/value-objects.md b/rules/stacks/java/common/value-objects.md
index 412cc86..25d8ea6 100644
--- a/rules/stacks/java/common/value-objects.md
+++ b/rules/stacks/java/common/value-objects.md
@@ -27,7 +27,7 @@

 ## 驗收要求

-共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。
+共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依受影響的值型別與實際使用路徑選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。

 ### 共同驗收

```

## version-policy.md

6a16349 的專屬引言原文：

```text
依本次變更與適用能力執行下列檢查，將結果連到受驗產物及其版本。測試層級與執行門檻依[共通測試策略](../../../quality/testing.md)制定。
```

基準引言的 Java 型別、API、版本與實際框架路徑要求維持；前輪新增的測試層級及證據要求也保留。JV 兩個連結標籤另對齊共通目的節「檢查配置可重現」「實際執行範圍」，目標錨點不變。

```diff
diff --git a/rules/stacks/java/common/version-policy.md b/rules/stacks/java/common/version-policy.md
index ef168fd..3337fc0 100644
--- a/rules/stacks/java/common/version-policy.md
+++ b/rules/stacks/java/common/version-policy.md
@@ -31,14 +31,12 @@ Preview 的採用紀錄及其他例外均依[規範治理](../../../workflow/rul

 ## 驗收要求

-共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。
-
-依本次變更與適用能力執行下列檢查，將結果連到受驗產物及其版本。測試層級與執行門檻依[共通測試策略](../../../quality/testing.md)制定。
+共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依本次變更與適用能力執行下列檢查，將結果連到受驗產物及其版本。測試層級、證據與執行門檻依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)制定。

 ### 共同驗收

-- [檢查配置一致性](../../../quality/rule-verification.md#acceptance-check-configuration)。
-- [必要檢查實際執行](../../../quality/rule-verification.md#acceptance-check-execution)。
+- [檢查配置可重現](../../../quality/rule-verification.md#acceptance-check-configuration)。
+- [實際執行範圍](../../../quality/rule-verification.md#acceptance-check-execution)。

 ### Java 語言增量驗收

```

Lambda／Stream 的「依變更影響選擇案例」本來已與基準一致，本次未改該檔。兩個整節補充引用沒有可替代的驗收錨點，保留不動。
