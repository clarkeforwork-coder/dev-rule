# Checkstyle 精確例外

`suppressions.xml` 預設為空：測試及產生碼都不是自動豁免。依[例外核准](../../../rules/workflow/rule-governance.md#exception-approval)、[限定檢查抑制](../../../rules/workflow/rule-governance.md#suppression-scope)及[產生碼不擴大豁免](../../../rules/workflow/rule-governance.md#generated-code-exceptions)，先記錄核准人、決策、規範 ID、原因、精確範圍、替代方案、風險、補償措施及重驗條件，再把核准範圍加入使用端專案自己的抑制檔。不能僅為讓測試變綠而抑制原規範違反範例。

透過 Java properties 指定絕對路徑：

```properties
checkstyle.suppressions.file=/absolute/project/config/checkstyle-suppressions.xml
```

將該 properties 檔傳給 Checkstyle CLI 的 `-p`。未指定時，預設相對於工作目錄的 `tools/java/checkstyle/suppressions.xml`；從其他目錄執行務必指定 properties。檔案不存在會報錯，不靜默放行。

以下只是核准後可採用的範本，不是既有核准，不直接放入預設檔：

```xml
<!-- 決策 ADR-123：核准人、原因、補償驗證與到期條件須連到實際紀錄。 -->
<!-- 測試刻意示範禁用的日期解析模式；只限這個反例所在行。 -->
<suppress files="[/\\]src[/\\]test[/\\]java[/\\]example[/\\]DateParserTest\.java$"
          id="JV-ND-026" lines="41-45"/>
<!-- MapStruct 產生器無法避免的警告抑制：只限一個產生碼檔與一條規則。 -->
<suppress files="[/\\]target[/\\]generated-sources[/\\]annotations[/\\]example[/\\]OrderMapperImpl\.java$"
          id="JV-TG-011"/>
```

測試例外以刻意驗證錯誤路徑或外部 API 契約為理由，不能排除整個 `src/test`。工具產生碼先修正產生器版本、範本或設定；必要時才核准特定輸出檔的特定規則，不能以 `generated` 目錄名稱直接全面排除，手寫銜接程式與 AI 撰寫程式仍受檢查。

JV-TG-011 涉型別安全，須另記安全依據及驗證方式；JV-ER-008 的執行緒最外層嚴重故障處置須保留原故障，不能將吞掉故障當成誤報；JV-ND-016 的 JDBC／舊框架邊界、JV-ND-019 的固定時間長度及 JV-ND-022 的時鐘實作可依實際契約精確判定。其他 `static final` 非常數物件命名（JV-NP-002）、框架覆寫介面也須先確認原因，不預設放寬整個專案。

行號變動、產生器更新或規則變更後重驗抑制範圍。修復後刪除基準項目，並以範圍外的同規則反例確認檢查仍有效。本設定不啟用任意原始碼 `@SuppressWarnings("checkstyle:...")` 放行，所有例外集中在可審查的 SuppressionFilter 檔。
