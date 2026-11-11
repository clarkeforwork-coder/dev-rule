# 規則整併取捨紀錄

> 以下保留首版匯入歷史。後續 ER-008 拆分、LS-013 狀態、ND-009 XPath 及 test 層還原，以 [收尾裁決](../tests/validation.md) 與目前 rule-map 為準。

來源盤點只讀；本階段不重新宣稱執行 Java 工具，實證依研究者的盤點及同名報告。

## 來源指紋

- `inv-claude-a`：89 筆，SHA-256 `fb2cce6950aba3b9e01dcc03ed0926e3221d4cc9a6b021e150b2735516b2bb7a`。
- `inv-codex-a`：57 筆，SHA-256 `91eb372d59548ac50440661d74e1ec55099f409b542fedc083fe4f931fba4b04`。
- `inv-claude-b`：110 筆，SHA-256 `fab0d0e5477c87f4f669d490e30b751dbf8e0431d52e36a3768782032262bbb0`。
- `inv-codex-b`：62 筆，SHA-256 `7a7c73eefe96322d2c0a4e34b810836b76474e124175d9d05b2b31eb77f30dd2`。

## 判定原則與範圍

- 四份檔案共 318 筆；排除 30 筆沒有 java- 小節錨點的驗收索引，這些引用不另增加小節分母。
- 四份盤點的文件分工互斥，沒有跨研究者的同小節重複；var／Lambda 分屬不同錨點，依一條映射只對一個錨點保留兩筆，沒有虛構雙來源。
- PMD 自訂名稱原本均為 PascalCase，且沒有同語意的異名，故不強行改名；寬鬆版與精確版 XPath 語意不同，保留失敗候選以免重新採用。
- check 移除工具前綴；Checkstyle 設定移入 note，正式模組名放 check；同小節相同模組的不同配置合併，配置與誤報仍完整保留。
- manual 與尚未實作的 test 同小節合併為一筆 manual，note 保留具體驗收；不把待寫測試當作現有工具。
- verified 只表示該規則已證明正反例成功，並非整個小節或所有 Java 版本完整自動化；已知未命中的反例列 partial，只有失敗、未執行或另一規則的旁證列 candidate。
- 原盤點 true/true 仍可降級：NoVar 的 Lambda 主例漏報、IdentifierName／SpotBugs 命名只抓部分、MutableStaticState 漏靜態 final 登錄、OptionalReturnNull 漏間接 null、EnumOrdinalAtBoundary 與 EnumDefaultHidesCases 的補強合法例誤報均列 partial。
- CatchThrowableOrError 只有另一條規則的旁證，維持 candidate；CatchConcurrentModification 等具 sample caught 的補充實證保守列 partial，不把 null 自動當 true。
- javac --release 來源明列 unverified，保留 candidate；合成成功但原條文無範例的 ArchUnit／ParallelStreamUsage／doclint 則依來源 true/true 列 verified，note 明示合成來源。
- 拆分命名規則後，原範例只證明 TypeName／ConstantName／MethodName 與相應 PMD 三條；泛型參數原例是介面宣告，僅 InterfaceTypeParameterName 計 verified，其餘 candidate。
- 版本政策 java-supported-versions 是章節相容錨點而非 ### 小節，不另外計數；java-example-baseline 才是對應小節。

## 逐項合併、拆分與等級修正

- `inv-claude-a` 第 7 筆 `custom:GenericMethodReturnsObject`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- `inv-claude-a` 第 14 筆 `SuppressWarningsWithoutExplanation`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- `inv-claude-a` 第 28 筆：拆分 ClassTypeParameterName、InterfaceTypeParameterName、MethodTypeParameterName、RecordTypeParameterName；只有可從原範例定位命中的模組列 verified。
- `inv-claude-a` 第 52 筆：拆分 TypeName、ConstantName、MethodName、MemberName、ParameterName、LocalVariableName、LocalFinalVariableName、StaticVariableName、LambdaParameterName、PatternVariableName、RecordComponentName、PackageName；只有可從原範例定位命中的模組列 verified。
- `inv-claude-a` 第 53 筆：拆分 ClassNamingConventions、FieldNamingConventions、MethodNamingConventions、FormalParameterNamingConventions、LocalVariableNamingConventions；只有可從原範例定位命中的模組列 verified。
- `inv-claude-a` 第 54 筆 `IdentifierName`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- `inv-claude-a` 第 55 筆 `AbbreviationAsWordInName`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- `inv-claude-a` 第 56 筆 `NM_METHOD_NAMING_CONVENTION`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- ArchUnit 三個合成案例拆成 `custom:InternalPackageNotPublic`、`custom:SharedPackageNoBusinessDependency`、`custom:NestedStorageNotPublic`；沿用原實證，落地仍須按專案邊界設定。
- 套件邊界的 jdeps／Enforcer 複合筆拆成三筆 candidate；`--check` 僅列 11／17／21，舊拼法 `-jdkinternals` 僅列 8。
- `inv-claude-a` 第 72 筆 `-Xlint:this-escape`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- `inv-claude-a` 第 74 筆 `category/java/design.xml/MutableStaticState`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- `inv-claude-b` 第 3 筆 `custom:ListFromHashSetLosesOrder`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- `inv-claude-b` 第 12 筆 `custom:SortedBeforeLimit`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- `inv-claude-b` 第 65 筆 `EqualsGetClass`：level `false` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- `inv-claude-b` 第 89 筆 `custom:BigDecimalRecordWithoutNormalization`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- `inv-claude-b` 第 90 筆 `BigDecimalEquals`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- `inv-claude-b` 第 95 筆 `custom:DurationUsedForCalendarDay`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- `inv-claude-b` 第 96 筆 `RegexpSinglelineJava[format=Duration\.of(Days|Hours)\(]`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- `inv-claude-b` 第 103 筆 `custom:DateTimeFormatterPatternNotStrict`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- `inv-codex-b` 第 27 筆 `none`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- `inv-codex-b` 第 33 筆 `none`：level `"warn"` → `error`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。
- RawGenericType 的菱形運算子映射原本只有文字引用；逐字複用同盤點 java-generic-type-information 的已實證 XPath。
- 合併 `rules/stacks/java/common/lambda-and-stream.md#java-reduction-collection / none / none` 的 2 筆（inv-claude-a）；保留設定／測試責任與全部 note。
- 合併 `rules/stacks/java/common/classes-and-construction.md#java-construction-entrypoints / none / none` 的 2 筆（inv-claude-a）；保留設定／測試責任與全部 note。
- 合併 `rules/stacks/java/common/exceptions-and-resources.md#java-catch-scope / checkstyle / IllegalCatch` 的 2 筆（inv-claude-b）；保留設定／測試責任與全部 note。
