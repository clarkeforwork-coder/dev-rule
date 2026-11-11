# PMD 例外與精確抑制

技術抑制不是例外核准。依 [例外核准](../../../rules/workflow/rule-governance.md#exception-approval)，先記錄阻礙、替代方案、影響、風險與補償措施，由專案指定負責人（個人專案為擁有者）決定，留下核准人、結果、具體規範與位置、重新檢視條件。依 [限定檢查抑制](../../../rules/workflow/rule-governance.md#suppression-scope)，真正誤報也須保留判定依據；不得將尚未處理的違規稱為誤報。

優先在最小宣告使用 `@SuppressWarnings("PMD.<Name>")`，並以鄰近註解連到核准紀錄。`// NOPMD — 核准紀錄與理由` 只適用無法用宣告精確處理的單行；它會抑制該行所有 PMD 診斷，使用前確認不會掩蓋其他規則。不得使用 `@SuppressWarnings("PMD")` 或 `all` 全面略過。

排除路徑只適用已核准且明確界定的產生碼或框架銜接檔案；在專案自己的 ruleset 使用 `<exclude-pattern>.*/generated/ExactAdapter\.java</exclude-pattern>`，不要改共用規則集。這會排除該檔案的所有規則，應優先採用單一規則抑制；不得排除整個手寫來源集。產生碼仍適用 [產生碼不擴大豁免](../../../rules/workflow/rule-governance.md#generated-code-exceptions)，並保留範圍外命中的回歸案例。

預設集合是規範檢查目錄，導入專案時仍須配置適用範圍：`NoFixedSleepInConcurrencyTest` 只適用併發驗收測試；資源管理擁有者的 `NoUnmanagedThread`、邊界層反射／動態資料形狀等須逐點處理。此處沒有預先核准任何排除，也未藉 note 的「可放寬」擅自設定 allowedTypes、allowedResourceTypes 等白名單。

以下逐項保留對照表中的適用邊界與風險；「可能合理」仍須確認實際契約。沒有列出合法情境的規則，僅在外部固定契約／產生器限制或已證實工具誤報時提案，不能以方便為由自行抑制。candidate 僅供獨立實驗，無須在正常程式加入抑制以配合失敗候選。

## UseExplicitTypes

- [JV-TG-002 明確宣告型別](../../../rules/stacks/java/common/types-and-generics.md#java-explicit-types)（verified）：只抓區域變數／for／try 資源的 var；Lambda 參數 var 由 custom:NoInferredLambdaParameterType 補；Java 8 無 var，規則在 8 無意義但執行無誤報；；實證版本：17、8。

JV-TG-002 抑制：`@SuppressWarnings("PMD.UseExplicitTypes")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## RawGenericType

- [JV-TG-005 禁止 raw type 與不必要的型別抽象](../../../rules/stacks/java/common/types-and-generics.md#java-generic-type-information)（partial）：pre-commit 近似版（不編譯）：只認白名單內的 JDK 泛型型別，專案自訂泛型須加入白名單；完整檢查以 javac -Xlint:rawtypes 為準；本小節自身違反範例（Object）抓不到；以 java-diamond-construction／java-type-safety-warnings 的 raw type 違反範例與合成範例（List raw、Map<String, List>、Comparable raw）實證抓到，instanceof List／List.class／List.of() 不誤報；第一版用 typeIs(Comparable) 會把 String 當 raw 誤報，已改 typeIsExactly；；實證版本：17、8。
- [JV-TG-025 允許建構端使用菱形運算子](../../../rules/stacks/java/common/types-and-generics.md#java-diamond-construction)（verified）：XPath 同 java-generic-type-information 的 custom:RawGenericType；菱形 <> 的 TypeArguments 節點存在（Diamond=true），不會被誤判為 raw type；；實證版本：17、8、11。

JV-TG-005 抑制：`@SuppressWarnings("PMD.RawGenericType_JV_TG_005")`。

JV-TG-025 抑制：`@SuppressWarnings("PMD.RawGenericType_JV_TG_025")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## GenericMethodReturnsObject

- [JV-TG-007 輸入與輸出的型別關聯](../../../rules/stacks/java/common/types-and-generics.md#java-input-output-type-relation)（verified）：啟發式：宣告型別參數的方法卻回傳 Object；只涵蓋本小節範例的形狀；回傳 Map<String, Object> 或接受 List<?> 再轉型等其他失去關聯的寫法抓不到；反射／序列化工具方法可能合理回傳 Object，需 @SuppressWarnings("PMD.GenericMethodReturnsObject")；；實證版本：17。

JV-TG-007 抑制：`@SuppressWarnings("PMD.GenericMethodReturnsObject")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## DowncastFromObject

- [JV-TG-009 不得以向下轉型補回業務型別](../../../rules/stacks/java/common/types-and-generics.md#java-business-type-casts)（verified）：對靜態型別恰為 Object 的運算式做轉型或 instanceof（含 Java 16+ 型別模式，違反（Java 17）範例也抓到）；equals(Object) 排除；只抓「從 Object 猜回」；從較寬的業務型別向下轉型（例如 (CashPayment) payment）需要型別階層資訊，本規則不抓；邊界層（JNDI、反序列化、Map<String, Object> 取值、框架回呼）會大量命中，須以套件層級 exclude 或 @SuppressWarnings 配合例外流程；；實證版本：17、8。

JV-TG-009 抑制：`@SuppressWarnings("PMD.DowncastFromObject")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## NoSuppressTypeSafetyWarnings

- [JV-TG-014 型別安全警告](../../../rules/stacks/java/common/types-and-generics.md#java-type-safety-warnings)（verified）：與 Checkstyle SuppressWarnings 等價，二選一；；實證版本：17。

JV-TG-014 抑制：`@SuppressWarnings("PMD.NoSuppressTypeSafetyWarnings")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ObjectValuedDataShape

- [JV-TG-017 業務資料結構](../../../rules/stacks/java/common/types-and-generics.md#java-business-data-shape)（verified）：回傳值、欄位、參數或 record 元件型別為 Map<?, Object> 或 Object[]；JSON／框架 Model（Spring Model attributes、JDBC 列）在邊界層合法，需對邊界套件 exclude；真正動態映射改用明確值型別即可通過；；實證版本：17、8。

JV-TG-017 抑制：`@SuppressWarnings("PMD.ObjectValuedDataShape")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## LooseCoupling

- [JV-TG-022 集合與映射的宣告型別](../../../rules/stacks/java/common/types-and-generics.md#java-collection-declarations)（verified）：符合（Java 21）的 SequencedCollection 以 --use-version java-21 解析無誤報；規則也檢查區域變數與欄位（ArrayList<String> list = new ArrayList<>() 會被抓），可用 allowedTypes 放寬；條文用「不應」故 warn；；實證版本：17、21。

JV-TG-022 抑制：`@SuppressWarnings("PMD.LooseCoupling")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## UnboundedWildcardReturnType

- [JV-TG-026 泛型回傳值](../../../rules/stacks/java/common/types-and-generics.md#java-generic-return-types)（verified）：只抓回傳型別中的無界 ?（含巢狀），Class<?> 排除；有上下界的萬用字元（契約確實需要）不抓；反射／序列化工具層回傳 List<?> 可能合理，需 suppress；；實證版本：17、8、11。

JV-TG-026 抑制：`@SuppressWarnings("PMD.UnboundedWildcardReturnType")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## TypeParameterNamingConventions

- [JV-TG-032 泛型參數命名](../../../rules/stacks/java/common/types-and-generics.md#java-type-parameter-names)（candidate）：不採用：PMD 7.29 此規則沒有 pattern 屬性可設定（設定會報 Cannot set non-existent property），預設只允許單一大寫字母，符合範例的 Source／Decoded／Result 也被抓；Error Prone 的 TypeParameterNaming 同樣與符合範例衝突；；實證版本：17。

JV-TG-032 抑制：`@SuppressWarnings("PMD.TypeParameterNamingConventions")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## NoInferredLambdaParameterType

- [JV-LS-004 明確的參數型別](../../../rules/stacks/java/common/lambda-and-stream.md#java-lambda-parameter-types)（verified）：同時抓省略型別（value ->）與 (var value) ->（違反（Java 11）範例，@VarKeyword=true）；明確型別 (String value) 的 @TypeInferred=false；內建 UseExplicitTypes 不抓 Lambda 參數的 var；誤報低，但既有程式碼幾乎全部省略 Lambda 參數型別，命中量極大，需基準線或只對新增／修改行報告；；實證版本：17、11、8。

JV-LS-004 抑制：`@SuppressWarnings("PMD.NoInferredLambdaParameterType")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## StreamPeekUsage

- [JV-LS-007 中間操作不隱藏業務副作用](../../../rules/stacks/java/common/lambda-and-stream.md#java-intermediate-side-effects)（verified）：抓所有 Stream.peek；peek 的官方用途是除錯記錄，純 log 的 peek 會誤報，需 suppress 或團隊約定不用 peek；其他中間操作（filter／map）內的副作用無法靜態判斷；；實證版本：17。

JV-LS-007 抑制：`@SuppressWarnings("PMD.StreamPeekUsage")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ForEachAccumulatesExternalState

- [JV-LS-009 明確累積結果](../../../rules/stacks/java/common/lambda-and-stream.md#java-result-accumulation)（verified）：Stream／Iterable／Map 的 forEach Lambda 內對外部集合、Map 或 StringBuilder 呼叫修改方法；符合範例（collect）與符合（Java 17）（toList）均乾淨；抓不到以方法參考（result::add）累積、計數器／旗標（int[] 或 AtomicInteger）累積的寫法；forEach 刻意寫入外部 Map（groupingBy 難以表達時）會被抓，需 suppress；；實證版本：17。

JV-LS-009 抑制：`@SuppressWarnings("PMD.ForEachAccumulatesExternalState")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ParallelStreamUsage

- [JV-LS-013 平行處理的採用條件](../../../rules/stacks/java/common/lambda-and-stream.md#java-parallel-stream-adoption)（verified）：本小節沒有規範範例，以合成範例實證（parallelStream() 與 stream().parallel() 各抓到一次，stream().count() 乾淨）；所有平行處理都會被報，已核准者須 @SuppressWarnings("PMD.ParallelStreamUsage") 並附量測依據，這正是條文要求的例外流程；；實證版本：17。

JV-LS-013 抑制：`@SuppressWarnings("PMD.ParallelStreamUsage")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## LambdaCatchWithoutRethrow

- [JV-LS-016 維持錯誤分類](../../../rules/stacks/java/common/lambda-and-stream.md#java-failure-classification)（verified）：Lambda 內的 catch 沒有任何 throw（吞錯或回傳替代值）；允許部分成功且保留各筆結果的流程（catch 後記錄到結果物件）會被抓，需 suppress；內建 EmptyCatchBlock／AvoidCatchingGenericException 抓不到此範例（catch 非空、型別具體）；；實證版本：17、8。

JV-LS-016 抑制：`@SuppressWarnings("PMD.LambdaCatchWithoutRethrow")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## StreamVariableReused

- [JV-LS-018 明確消費範圍](../../../rules/stacks/java/common/lambda-and-stream.md#java-stream-consumption)（verified）：型別為 Stream 的區域變數在同一方法內被讀取兩次以上（XPath 3.1 let）；Stream 變數重新指派（s = s.filter(...)）或先 try-with-resources 再消費一次的合法寫法會誤報；欄位型 Stream 與跨方法共用不抓；SpotBugs／Error Prone 2.52 皆無「重用已消費 Stream」檢查；；實證版本：17、8。

JV-LS-018 抑制：`@SuppressWarnings("PMD.StreamVariableReused")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ClassNamingConventions

- [JV-NP-015 一致的命名形式](../../../rules/stacks/java/common/naming-packages-docs.md#java-naming-form)（verified）：與 Checkstyle 等價，二選一；FieldNamingConventions 對 static final 以 constantPattern 檢查，同樣會要求 Logger 常數全大寫；ClassNamingConventions 預設另要求工具類名稱以 Utils/Helper 等結尾（utilityClassPattern），與本組 java-specific-responsibility 的「名稱須與責任一致」無衝突但會額外報告，可設 utilityClassPattern 放寬；；實證版本：17；原盤點合併多模組，未獨立證明命中的模組保守列 candidate。

JV-NP-015 抑制：`@SuppressWarnings("PMD.ClassNamingConventions")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## FieldNamingConventions

- [JV-NP-016 一致的命名形式](../../../rules/stacks/java/common/naming-packages-docs.md#java-naming-form)（verified）：與 Checkstyle 等價，二選一；FieldNamingConventions 對 static final 以 constantPattern 檢查，同樣會要求 Logger 常數全大寫；ClassNamingConventions 預設另要求工具類名稱以 Utils/Helper 等結尾（utilityClassPattern），與本組 java-specific-responsibility 的「名稱須與責任一致」無衝突但會額外報告，可設 utilityClassPattern 放寬；；實證版本：17；原盤點合併多模組，未獨立證明命中的模組保守列 candidate。

JV-NP-016 抑制：`@SuppressWarnings("PMD.FieldNamingConventions")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## FormalParameterNamingConventions

- [JV-NP-017 一致的命名形式](../../../rules/stacks/java/common/naming-packages-docs.md#java-naming-form)（candidate）：與 Checkstyle 等價，二選一；FieldNamingConventions 對 static final 以 constantPattern 檢查，同樣會要求 Logger 常數全大寫；ClassNamingConventions 預設另要求工具類名稱以 Utils/Helper 等結尾（utilityClassPattern），與本組 java-specific-responsibility 的「名稱須與責任一致」無衝突但會額外報告，可設 utilityClassPattern 放寬；；實證版本：17；原盤點合併多模組，未獨立證明命中的模組保守列 candidate。

JV-NP-017 抑制：`@SuppressWarnings("PMD.FormalParameterNamingConventions")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## LocalVariableNamingConventions

- [JV-NP-018 一致的命名形式](../../../rules/stacks/java/common/naming-packages-docs.md#java-naming-form)（candidate）：與 Checkstyle 等價，二選一；FieldNamingConventions 對 static final 以 constantPattern 檢查，同樣會要求 Logger 常數全大寫；ClassNamingConventions 預設另要求工具類名稱以 Utils/Helper 等結尾（utilityClassPattern），與本組 java-specific-responsibility 的「名稱須與責任一致」無衝突但會額外報告，可設 utilityClassPattern 放寬；；實證版本：17；原盤點合併多模組，未獨立證明命中的模組保守列 candidate。

JV-NP-018 抑制：`@SuppressWarnings("PMD.LocalVariableNamingConventions")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## MethodNamingConventions

- [JV-NP-019 一致的命名形式](../../../rules/stacks/java/common/naming-packages-docs.md#java-naming-form)（verified）：與 Checkstyle 等價，二選一；FieldNamingConventions 對 static final 以 constantPattern 檢查，同樣會要求 Logger 常數全大寫；ClassNamingConventions 預設另要求工具類名稱以 Utils/Helper 等結尾（utilityClassPattern），與本組 java-specific-responsibility 的「名稱須與責任一致」無衝突但會額外報告，可設 utilityClassPattern 放寬；；實證版本：17；原盤點合併多模組，未獨立證明命中的模組保守列 candidate。

JV-NP-019 抑制：`@SuppressWarnings("PMD.MethodNamingConventions")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ConstructorCallsOverridableMethod

- [JV-CC-003 建構期間的安全性](../../../rules/stacks/java/common/classes-and-construction.md#java-construction-safety)（verified）：違反範例報「Overridable method called during object construction: Base.initialize()」；符合範例（private initialize）乾淨；框架要求建構子呼叫 init 的少數情況需 suppress；；實證版本：17。

JV-CC-003 抑制：`@SuppressWarnings("PMD.ConstructorCallsOverridableMethod")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## MutableStaticState

- [JV-CC-006 明確取得依賴](../../../rules/stacks/java/common/classes-and-construction.md#java-explicit-dependencies)（partial）：違反範例的 static Supplier<Runnable> jobs（可變靜態登錄）被抓；符合範例（建構子注入）乾淨；只涵蓋「可變靜態欄位」這一種隱藏依賴來源；static final 登錄、getInstance() 單例、全域容器查詢抓不到，故 warn；快取類非 final static 欄位會命中；；實證版本：17。

JV-CC-006 抑制：`@SuppressWarnings("PMD.MutableStaticState")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ReturnEmptyCollectionRatherThanNull

- [JV-NO-001 查詢的正常缺值](../../../rules/stacks/java/common/null-and-optional.md#java-query-absence)（verified）：只涵蓋集合／陣列／Map 的直接 return null；單筆正常缺值的業務分類仍人工；合法可空第三方介面需有明訂例外；已實跑；未通過違反命中或符合不誤報時屬淘汰候選，不是可啟用規則；；實證版本：8、17。

JV-NO-001 抑制：`@SuppressWarnings("PMD.ReturnEmptyCollectionRatherThanNull")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## OptionalReturnNull

- [JV-NO-003 Optional 本身非空](../../../rules/stacks/java/common/null-and-optional.md#java-optional-nonnull)（partial）：只涵蓋 java.util.Optional 方法直接 return null；間接變數回傳、欄位與參數為缺口，補強反例已證明 indirectNull 不被抓；已實跑；未通過違反命中或符合不誤報時屬淘汰候選，不是可啟用規則；；實證版本：17。

JV-NO-003 抑制：`@SuppressWarnings("PMD.OptionalReturnNull")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## OverrideBothEqualsAndHashcode

- [JV-VO-006 值相等的條件](../../../rules/stacks/java/common/value-objects.md#java-value-equality)（candidate）：淘汰候選：規則容許兩個方法都不覆寫，原違反剛好是此情形；也不能判斷跨幣別等業務相等條件；已實跑；未通過違反命中或符合不誤報時屬淘汰候選，不是可啟用規則；；實證版本：8、17。
- [JV-EH-004 相等與雜湊契約](../../../rules/stacks/java/common/equality-hashing-ordering.md#java-equality-hash-contract)（partial）：對應子句「須同時設計相容的 hashCode()」；本節違反範例兩者皆有實作（錯在語意），故不報；Checkstyle EqualsHashCode 行為相同（同樣本實證）；；實證版本：17、8；補充實證：samples/SubClauses3.java:15（只覆寫 equals）caught；規範 java-cross-type-equality 違反範例的 Child 亦被報。
- [JV-EH-012 跨型別相等範圍](../../../rules/stacks/java/common/equality-hashing-ordering.md#java-cross-type-equality)（verified）：違反範例因 Child 只覆寫 equals 而被報（間接命中，抓的是雜湊契約而非對稱性）；Checkstyle EqualsHashCode 同樣命中違反範例 11 行；；實證版本：17、8。

JV-VO-006 抑制：`@SuppressWarnings("PMD.OverrideBothEqualsAndHashcode_JV_VO_006")`。

JV-EH-004 抑制：`@SuppressWarnings("PMD.OverrideBothEqualsAndHashcode_JV_EH_004")`。

JV-EH-012 抑制：`@SuppressWarnings("PMD.OverrideBothEqualsAndHashcode_JV_EH_012")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ExhaustiveSwitchHasDefault

- [JV-SR-006 處理完整性](../../../rules/stacks/java/common/states-and-results.md#java-exhaustive-result-handling)（candidate）：淘汰或需例外：以完整 switch 出現 default 為判斷；詳見每版本實測，不能直接等同禁止未知結果當成功；已實跑；未通過違反命中或符合不誤報時屬淘汰候選，不是可啟用規則；；實證版本：11、17、21。

JV-SR-006 抑制：`@SuppressWarnings("PMD.ExhaustiveSwitchHasDefault")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## NonExhaustiveSwitch

- [JV-SR-007 處理完整性](../../../rules/stacks/java/common/states-and-results.md#java-exhaustive-result-handling)（candidate）：淘汰候選：內建規則不檢查 switch expression；原違反由 default 滿足語法完整性，未命中；已實跑；未通過違反命中或符合不誤報時屬淘汰候選，不是可啟用規則；；實證版本：11、17、21。

JV-SR-007 抑制：`@SuppressWarnings("PMD.NonExhaustiveSwitch")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## EnumDefaultHidesCases

- [JV-SR-008 處理完整性](../../../rules/stacks/java/common/states-and-results.md#java-exhaustive-result-handling)（partial）：僅審查候選：抓 enum 缺少明列常數且有 default；不判斷成功語意；補強測試顯示 default throw 也會被抓，不能直接作阻擋門檻，須核定完整明列契約及例外；已實跑；未通過違反命中或符合不誤報時屬淘汰候選，不是可啟用規則；；實證版本：11、17、21。

JV-SR-008 抑制：`@SuppressWarnings("PMD.EnumDefaultHidesCases")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## EnumOrdinalAtBoundary

- [JV-SR-010 穩定的外部代碼](../../../rules/stacks/java/common/states-and-results.md#java-stable-external-codes)（partial）：只可套用已確認屬外部代碼的映射來源檔或以理由抑制；XPath 本身不識別邊界，內部 ordinal 索引可合法且已實測誤報，禁止全域直接阻擋；不能證明代碼穩定性；已實跑；未通過違反命中或符合不誤報時屬淘汰候選，不是可啟用規則；；實證版本：8、17。

JV-SR-010 抑制：`@SuppressWarnings("PMD.EnumOrdinalAtBoundary")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ListFromHashSetLosesOrder

- [JV-CO-003 順序與重複資料](../../../rules/stacks/java/common/collections-and-ownership.md#java-order-and-duplicates)（verified）：只抓「List ← HashSet 建構」這一種失去順序與重複值的寫法；Set.of／Map.of 不保證順序、SequencedSet 不保留重複等屬契約判斷，見同節 manual 筆；；誤報風險說明：刻意用 HashSet 去重再排序的寫法也會被報；用 LinkedHashSet／TreeSet 表達意圖者不報；建議 warn 並允許 @SuppressWarnings；；實證版本：17、21。

JV-CO-003 抑制：`@SuppressWarnings("PMD.ListFromHashSetLosesOrder")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## CatchConcurrentModification

- [JV-CO-006 遍歷期間的修改](../../../rules/stacks/java/common/collections-and-ownership.md#java-traversal-mutation)（partial）：對應子句「未拋出遍歷修改例外不代表安全，也不得捕捉後直接重跑」；規範無此違反範例，以自製樣本實證；；誤報風險說明：捕捉 CME 幾乎只用於重跑或忽略；若為記錄後重新拋出可抑制；；實證版本：17；補充實證：samples/SubClauses3.java:7 caught。

JV-CO-006 抑制：`@SuppressWarnings("PMD.CatchConcurrentModification")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ModifyCollectionInForeach

- [JV-CO-007 遍歷期間的修改](../../../rules/stacks/java/common/collections-and-ownership.md#java-traversal-mutation)（verified）：PMD 7 XPath；pre-commit 層的對應規則；；誤報風險說明：同 Error Prone，remove 後 break 會被報；只比對變數名稱，被遍歷集合若是方法回傳值（for (x : get())）則抓不到；；實證版本：17。

JV-CO-007 抑制：`@SuppressWarnings("PMD.ModifyCollectionInForeach")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ConcurrentMapCheckThenAct

- [JV-CO-008 複合操作的原子性](../../../rules/stacks/java/common/collections-and-ownership.md#java-compound-atomicity)（verified）：SpotBugs AT_OPERATION_SEQUENCE_ON_CONCURRENT_ABSTRACTION 對規範違反範例（欄位型別 ConcurrentMap 介面）不報，只對宣告為 ConcurrentHashMap 的欄位報（samples/SubClauses.java:33），故 pre-commit 以本規則為主；；誤報風險說明：containsKey／get==null 後接 put／remove／replace 的同鍵檢查再寫入；在已持鎖區段內屬合理寫法時需抑制；只看 ConcurrentMap 型別的接收者，宣告為 Map 介面者抓不到；；實證版本：17。

JV-CO-008 抑制：`@SuppressWarnings("PMD.ConcurrentMapCheckThenAct")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## SortedBeforeLimit

- [JV-CO-011 限制資料累積](../../../rules/stacks/java/common/collections-and-ownership.md#java-bounded-accumulation)（verified）：與 UnboundedStreamStatefulOp 互補：本規則不看來源是否無界，只看「先排序再截取」；；誤報風險說明：有限來源的 sorted().limit(n) 只是效能問題而非無界累積，會被報；建議 warn；；實證版本：17、8、11。

JV-CO-011 抑制：`@SuppressWarnings("PMD.SortedBeforeLimit")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## UnboundedStreamStatefulOp

- [JV-CO-012 限制資料累積](../../../rules/stacks/java/common/collections-and-ownership.md#java-bounded-accumulation)（verified）：Java 11 符合範例用三參數 iterate（有停止條件）→ 不報；Java 8／17 符合範例 limit 在 sorted 之前 → 不報；；誤報風險說明：只針對 Stream.generate／二參數 Stream.iterate 這類確定無界的來源，且 limit／takeWhile 不在 sorted／distinct 之前；；實證版本：17、8、11。

JV-CO-012 抑制：`@SuppressWarnings("PMD.UnboundedStreamStatefulOp")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## LazyStreamReturnedFromTryWithResources

- [JV-CO-015 延遲讀取的資源責任](../../../rules/stacks/java/common/collections-and-ownership.md#java-lazy-resource-lifetime)（verified）：回傳型別為 List 等已收集結果者不報（符合範例）；；誤報風險說明：回傳的 Stream／Iterator 必須直接引用 try-with-resources 的資源變數才報；；實證版本：17、8。

JV-CO-015 抑制：`@SuppressWarnings("PMD.LazyStreamReturnedFromTryWithResources")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## PreserveStackTrace

- [JV-ER-002 明確的故障分類](../../../rules/stacks/java/common/exceptions-and-resources.md#java-exception-classification)（partial）：對應子句「需要邊界轉換時，須保留原始原因」；Error Prone UnusedException（預設關閉）同樣本亦報；；誤報風險說明：刻意不帶原因（例如對外隱藏內部資訊）需抑制；；實證版本：17、8；補充實證：samples/SubClauses.java:8 caught（catch 後 throw new X(msg) 未帶 cause）。
- [JV-RS-005 區分故障與執行結果](../../../rules/stacks/java/common/reflection-and-suppression.md#java-reflection-failure)（verified）：採用：保留反射包裝的原始原因；訊息分類與跨 helper 的傳遞仍須審查；實證：bad-17=1, good-17=0；詳 pmd-results.json；；實證版本：17。

JV-ER-002 抑制：`@SuppressWarnings("PMD.PreserveStackTrace_JV_ER_002")`。

JV-RS-005 抑制：`@SuppressWarnings("PMD.PreserveStackTrace_JV_RS_005")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## AvoidThrowingRawExceptionTypes

- [JV-ER-003 明確的故障分類](../../../rules/stacks/java/common/exceptions-and-resources.md#java-exception-classification)（partial）：對應子句「沒有明確語意的 RuntimeException」；規範無此違反範例；對應 SpotBugs THROWS_METHOD_THROWS_RUNTIMEEXCEPTION（同樣本實測亦報）與 Error Prone ThrowSpecificExceptions（預設關閉，同樣本實測報）；；實證版本：17、8；補充實證：samples/SubClauses.java:12 caught（throw new RuntimeException(cause)）。

JV-ER-003 抑制：`@SuppressWarnings("PMD.AvoidThrowingRawExceptionTypes")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## SignatureDeclareThrowsException

- [JV-ER-004 明確的故障分類](../../../rules/stacks/java/common/exceptions-and-resources.md#java-exception-classification)（verified）：只抓 throws java.lang.Exception；throws Throwable 另見 Checkstyle IllegalThrows 筆；；誤報風險說明：測試方法、實作框架介面（Callable.call、AutoCloseable.close 等）常宣告 throws Exception；設 IgnoreJUnitCompletely=true，覆寫框架方法者需 @SuppressWarnings("PMD.SignatureDeclareThrowsException")；；實證版本：17、8。

JV-ER-004 抑制：`@SuppressWarnings("PMD.SignatureDeclareThrowsException")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## AvoidCatchingGenericException

- [JV-ER-009 捕捉範圍與處置相符](../../../rules/stacks/java/common/exceptions-and-resources.md#java-catch-scope)（verified）：PMD 7.29 的此規則一併涵蓋 Exception／RuntimeException／NullPointerException／Throwable／Error（樣本 Throwable、Error 亦報），無法分級，故 Throwable／Error 的 error 等級改由自訂 CatchThrowableOrError 承擔；AvoidCatchingThrowable 自 7.18.0 起標記 deprecated，8.0 移除，不建議新設定採用；；誤報風險說明：同 IllegalCatch；入口層需 @SuppressWarnings("PMD.AvoidCatchingGenericException")；；實證版本：17、8。

JV-ER-009 抑制：`@SuppressWarnings("PMD.AvoidCatchingGenericException")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## CatchThrowableOrError

- [JV-ER-010 捕捉範圍與處置相符](../../../rules/stacks/java/common/exceptions-and-resources.md#java-catch-scope)（candidate）：取代已棄用的 AvoidCatchingThrowable 並加入 Error；；誤報風險說明：同上；；實證版本：17、8；補充實證：samples/SubClauses.java:16,19（經 AvoidCatchingGenericException 同位置實證；本規則 XPath 與 PMD 已棄用的 AvoidCatchingThrowable 相同形式）。

JV-ER-010 抑制：`@SuppressWarnings("PMD.CatchThrowableOrError")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## EmptyCatchBlock

- [JV-ER-015 保留中斷意圖](../../../rules/stacks/java/common/exceptions-and-resources.md#java-interruption)（verified）：只抓空 catch；吞掉後有其他敘述的情況由自訂規則涵蓋；Error Prone EmptyCatch（預設 WARNING）對違反範例亦報；；誤報風險說明：通用規則；allowCommentedBlocks 可放寬有註解者；；實證版本：17。

JV-ER-015 抑制：`@SuppressWarnings("PMD.EmptyCatchBlock")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## SwallowedInterruptedException

- [JV-ER-016 保留中斷意圖](../../../rules/stacks/java/common/exceptions-and-resources.md#java-interruption)（verified）：等同 Sonar S2142 的語意；；誤報風險說明：以其他取消機制（例如設定旗標後 return）處理者會被報，需抑制；多重捕捉亦涵蓋（樣本 catch (InterruptedException | ExecutionException) + cancel 不報）；；實證版本：17。

JV-ER-016 抑制：`@SuppressWarnings("PMD.SwallowedInterruptedException")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## UseTryWithResources

- [JV-ER-018 優先使用語言資源管理機制](../../../rules/stacks/java/common/exceptions-and-resources.md#java-resource-management)（partial）：只抓 try／finally 內呼叫 close() 的寫法；本節違反範例沒有 finally 所以不報（在 java-suppressed-failures 違反範例有報）；列入作為「優先使用 try-with-resources」的樣式提醒；；實證版本：17、8、11、21。
- [JV-ER-024 保留操作與清理失敗](../../../rules/stacks/java/common/exceptions-and-resources.md#java-suppressed-failures)（verified）：違反範例 finally { resource.close(); } 被報「Consider using a try-with-resources statement」；三個符合範例（含 Java 8 別名、Java 11 try (resource)）皆不報；注意 javac -Xlint:try 反而對符合範例報「resource never referenced in body」，對此規範樣式不宜啟用；；實證版本：17、8、11。

JV-ER-018 抑制：`@SuppressWarnings("PMD.UseTryWithResources_JV_ER_018")`。

JV-ER-024 抑制：`@SuppressWarnings("PMD.UseTryWithResources_JV_ER_024")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## CloseResource

- [JV-ER-019 優先使用語言資源管理機制](../../../rules/stacks/java/common/exceptions-and-resources.md#java-resource-management)（verified）：Java 8 別名寫法 try (InputStream owned = input) 與 Java 11 try (input) 實測皆不誤報；Java 21 ExecutorService 範例在 JDK 21 執行期下亦不報；；誤報風險說明：借用資源、回傳資源給呼叫端、框架管理的 Connection 等依條文本就不該關閉，CloseResource 仍會報；需用 closeTargets／allowedResourceTypes／closeNotInFinally 屬性與 @SuppressWarnings("PMD.CloseResource") 細調；；實證版本：17、8、11、21。

JV-ER-019 抑制：`@SuppressWarnings("PMD.CloseResource")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## DoNotThrowExceptionInFinally

- [JV-ER-025 保留操作與清理失敗](../../../rules/stacks/java/common/exceptions-and-resources.md#java-suppressed-failures)（partial）：對應子句「其他控制流程掩蓋原結果」（finally 中 throw）；；實證版本：17、8、11；補充實證：samples/SubClauses.java:28 caught。

JV-ER-025 抑制：`@SuppressWarnings("PMD.DoNotThrowExceptionInFinally")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ReturnFromFinallyBlock

- [JV-ER-026 保留操作與清理失敗](../../../rules/stacks/java/common/exceptions-and-resources.md#java-suppressed-failures)（partial）：對應子句「不得以 finally 中的 return 掩蓋原結果」；規範無此違反範例；；實證版本：17、8、11；補充實證：samples/SubClauses.java:24 caught。

JV-ER-026 抑制：`@SuppressWarnings("PMD.ReturnFromFinallyBlock")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ResourceCapturedByAsyncTask

- [JV-ER-028 有效期與關閉契約](../../../rules/stacks/java/common/exceptions-and-resources.md#java-resource-close-contract)（verified）：規範違反範例 CompletableFuture.runAsync(lambda 使用 input, executor) 被報；；誤報風險說明：在 try 內同步等待結果的 executor.submit(() -> input.read()).get() 也會被報（samples/SubClauses.java:61 實測報）；此類需抑制；Java 21 符合範例（ExecutorService 本身是資源、lambda 不引用它）不報；；實證版本：17。

JV-ER-028 抑制：`@SuppressWarnings("PMD.ResourceCapturedByAsyncTask")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## IdentityEqualsWithStateHashCode

- [JV-EH-008 Entity 識別碼的生命週期](../../../rules/stacks/java/common/equality-hashing-ordering.md#java-entity-identity-lifecycle)（verified）：只涵蓋違反範例這一種「身分相等＋可變狀態雜湊」組合；；誤報風險說明：樣式很窄（equals 為 this == other 且 hashCode 讀取非 final 欄位），幾乎必為錯；但涵蓋面也窄；；實證版本：17。

JV-EH-008 抑制：`@SuppressWarnings("PMD.IdentityEqualsWithStateHashCode")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ComparatorBySubtraction

- [JV-EH-017 比較關係一致](../../../rules/stacks/java/common/equality-hashing-ordering.md#java-comparator-relations)（verified）：Error Prone 對 Integer 相減無對應檢查；只有 BadComparable 抓「long 相減後縮窄成 int」（同樣本 47 行報），對規範違反範例不報；；誤報風險說明：比較兩個已知有界的小整數（例如 enum ordinal 相減）技術上不會溢位但仍會被報；；實證版本：17；補充實證：samples/SubClauses.java:47 compareTo 中 (int)(rank - other.rank) 亦 caught。

JV-EH-017 抑制：`@SuppressWarnings("PMD.ComparatorBySubtraction")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## OverrideBothEqualsAndHashCodeOnComparable

- [JV-EH-019 比較為零與相等性](../../../rules/stacks/java/common/equality-hashing-ordering.md#java-sorted-key-equivalence)（partial）：PMD 7.17.0 新增；只涵蓋子句「自然順序原則上應與相等性一致」的最低限度（Comparable 類別缺 equals／hashCode）；規範違反範例是 record 加情境 Comparator，不報；SpotBugs Eq: 'defines compareTo and uses Object.equals' 於同樣本亦報；；誤報風險說明：僅作排序用、不放入集合的 Comparable 類別也會被報；；實證版本：17、8；補充實證：samples/SubClauses.java:47（implements Comparable 卻未覆寫 equals／hashCode）caught。

JV-EH-019 抑制：`@SuppressWarnings("PMD.OverrideBothEqualsAndHashCodeOnComparable")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## AvoidDecimalLiteralsInBigDecimalConstructor

- [JV-ND-003 從精確來源建立](../../../rules/stacks/java/common/numbers-dates-text.md#java-exact-numeric-sources)（verified）：PMD 7 實作為 matchesSig('java.math.BigDecimal#new(double)')，不限字面值，故 new BigDecimal(Double.parseDouble(text)) 也被報（規則名稱易誤導）；；實證版本：17。

JV-ND-003 抑制：`@SuppressWarnings("PMD.AvoidDecimalLiteralsInBigDecimalConstructor")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## BigDecimalFromFloatingPoint

- [JV-ND-004 從精確來源建立](../../../rules/stacks/java/common/numbers-dates-text.md#java-exact-numeric-sources)（verified）：內建規則的超集：加上 valueOf(double)；SpotBugs DMI_BIGDECIMAL_CONSTRUCTED_FROM_DOUBLE 只針對無法精確表示的字面常數，對違反範例不報；；誤報風險說明：BigDecimal.valueOf(double) 在來源本來就是量測 double 時合理；若只要內建規則的建構子部分，可不採用本規則；；實證版本：17；補充實證：samples/SubClauses.java:43 BigDecimal.valueOf(double) caught。

JV-ND-004 抑制：`@SuppressWarnings("PMD.BigDecimalFromFloatingPoint")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## BigDecimalWithoutRoundingMode

- [JV-ND-006 明訂捨入規則](../../../rules/stacks/java/common/numbers-dates-text.md#java-rounding-policy)（partial）：規範違反範例是把 scale 與 RoundingMode 交給呼叫端決定（語意違反），工具抓不到；本規則只涵蓋「讓 API 預設決定」的子句；；誤報風險說明：單參數 divide 遇非終止小數會拋 ArithmeticException、單參數 setScale 遇需捨入會拋例外，幾乎總是未明訂捨入；；實證版本：17；補充實證：samples/SubClauses.java:40,41 divide(b)／setScale(2) caught。

JV-ND-006 抑制：`@SuppressWarnings("PMD.BigDecimalWithoutRoundingMode")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## NarrowingPrimitiveCast

- [JV-ND-009 範圍與轉換檢查](../../../rules/stacks/java/common/numbers-dates-text.md#java-numeric-range-checks)（verified）：條文「須明確檢查」字面為 error，但實務誤報高；Java 21 違反範例 Math.clamp 屬語意（clamp 本身是合法 API），不報；；誤報風險說明：位元運算、序列化、影像／音訊處理等大量合法縮窄轉型會被報；已排除 hashCode 方法內（樣本 53 行不報）；建議先以 warn 導入並允許逐處抑制，或限縮為 long→int；；實證版本：17、21。

JV-ND-009 抑制：`@SuppressWarnings("PMD.NarrowingPrimitiveCast")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## BigDecimalRecordWithoutNormalization

- [JV-ND-013 BigDecimal 判同語意](../../../rules/stacks/java/common/numbers-dates-text.md#java-decimal-equivalence)（candidate）：寬鬆版啟發式；被 ComparableBigDecimalRecordEqualsMismatch 取代；；誤報風險說明：實測誤報 numbers-dates-text.md java-numeric-representation 的符合範例 record Amount(BigDecimal value)；小數位數是否屬語意需契約決定；不建議採用，列出以記錄已試過；；實證版本：17、8。

JV-ND-013 抑制：`@SuppressWarnings("PMD.BigDecimalRecordWithoutNormalization")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ComparableBigDecimalRecordEqualsMismatch

- [JV-ND-014 BigDecimal 判同語意](../../../rules/stacks/java/common/numbers-dates-text.md#java-decimal-equivalence)（verified）：只適用 record（Java 16+）；Java 8 符合範例為一般類別、自行實作三者，不在範圍（實測不報）；；誤報風險說明：record 以 BigDecimal.compareTo 排序卻沿用自動 equals，compareTo==0 與 equals 必然不一致；；實證版本：17、8。

JV-ND-014 抑制：`@SuppressWarnings("PMD.ComparableBigDecimalRecordEqualsMismatch")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ReplaceJavaUtilDate

- [JV-ND-017 依業務語意選擇時間型別](../../../rules/stacks/java/common/numbers-dates-text.md#java-temporal-representation)（partial）：PMD 7.16.0 新增；只涵蓋 java.util.Date；Error Prone JavaUtilDate（預設關閉）同樣本 36 行亦報；；誤報風險說明：同上；；實證版本：17、8；補充實證：samples/SubClauses.java:36,38 caught。

JV-ND-017 抑制：`@SuppressWarnings("PMD.ReplaceJavaUtilDate")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## DurationUsedForCalendarDay

- [JV-ND-020 區分時間長度與日曆規則](../../../rules/stacks/java/common/numbers-dates-text.md#java-durations-calendar-periods)（verified）：符合範例 start.plus(Period.ofDays(1)) 不報；；誤報風險說明：契約真的要「恰好 24 小時後」時屬合法；只抓字面常數倍數，變數小時數抓不到；；實證版本：17。

JV-ND-020 抑制：`@SuppressWarnings("PMD.DurationUsedForCalendarDay")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## NowWithoutClock

- [JV-ND-024 可控制的時間基準](../../../rules/stacks/java/common/numbers-dates-text.md#java-clock-source)（verified）：Instant.now(clock)、source.instant() 不報；實測 PMD 在 JDK 8／11／17／21 執行期下結果一致；；誤報風險說明：測試碼、日誌時間戳、非業務用途的計時會被報；以 package／測試來源集排除，或在組態／Clock 供應者處抑制；System.nanoTime 等單調來源刻意不報；；實證版本：17、8、11、21；補充實證：samples/SubClauses.java:36,50,51 new Date()／currentTimeMillis()／LocalDate.now() caught。

JV-ND-024 抑制：`@SuppressWarnings("PMD.NowWithoutClock")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## SimpleDateFormatNeedsLocale

- [JV-ND-027 解析與輸出契約](../../../rules/stacks/java/common/numbers-dates-text.md#java-temporal-parsing-formatting)（partial）：對應子句「明訂地區」的舊 API 版本；Error Prone DefaultLocale（預設關閉）同樣本亦報；；實證版本：17；補充實證：samples/SubClauses.java:38 caught。

JV-ND-027 抑制：`@SuppressWarnings("PMD.SimpleDateFormatNeedsLocale")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## DateTimeFormatterPatternNotStrict

- [JV-ND-028 解析與輸出契約](../../../rules/stacks/java/common/numbers-dates-text.md#java-temporal-parsing-formatting)（verified）：涵蓋條文「須明訂格式、地區…不允許寬鬆修正」的預設 SMART 情況（未呼叫 withResolverStyle）；注意 STRICT 必須搭配 uuuu 而非 yyyy，否則解析失敗；可另加 XPath 檢查 STRICT 鏈上的字面樣式含 yyyy；；誤報風險說明：只用於格式化輸出的 formatter 不需要 STRICT；formatter 存成欄位後另行 withResolverStyle 也會被報；ofPattern 未給 Locale 在純數字 ISO 樣式下影響有限；建議 warn；；實證版本：17。

JV-ND-028 抑制：`@SuppressWarnings("PMD.DateTimeFormatterPatternNotStrict")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## LenientDateTimeResolver

- [JV-ND-029 解析與輸出契約](../../../rules/stacks/java/common/numbers-dates-text.md#java-temporal-parsing-formatting)（verified）：；誤報風險說明：明確指定 SMART／LENIENT 幾乎都是刻意放寬，與條文「不允許寬鬆修正非法日期」直接衝突；；實證版本：17。

JV-ND-029 抑制：`@SuppressWarnings("PMD.LenientDateTimeResolver")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## DoNotUseThreads

- [JV-CA-001 統一管理執行資源](../../../rules/stacks/java/common/concurrency-and-async.md#java-execution-resources)（candidate）：拒絕整體採用：主範例通過，但 Java 21 符合例誤報 4 處，連 ExecutorService 型別也禁止；與規範允許擁有者建立 executor 衝突；改用 NoUnmanagedThread；實證：bad-17=1, good-17=0, good-21=4；詳 pmd-results.json；；實證版本：17、21。

JV-CA-001 抑制：`@SuppressWarnings("PMD.DoNotUseThreads")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## NoUnmanagedThread

- [JV-CA-002 統一管理執行資源](../../../rules/stacks/java/common/concurrency-and-async.md#java-execution-resources)（verified）：採用：限定非資源管理元件；ThreadFactory、測試基礎設施及核准擁有者需精確例外；不涵蓋 Thread.ofVirtual().start 等其他建立 API，也不證明容量管理；實證：bad-17=1, good-17=0, good-21=0；詳 pmd-results.json；；實證版本：17、21。

JV-CA-002 抑制：`@SuppressWarnings("PMD.NoUnmanagedThread")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## NoFixedSleepInConcurrencyTest

- [JV-CA-015 可控制的併發驗收](../../../rules/stacks/java/common/concurrency-and-async.md#java-controlled-verification)（verified）：條件式採用：只套用併發驗收測試來源；正常程式退避、延遲模擬或測試刻意控制計時可能合法，須允許精確例外；只抓 Thread.sleep(long/int)，不涵蓋其他間接等待；實證：bad-17=1, good-17=0, good-21=0；詳 pmd-results.json；；實證版本：17、21。

JV-CA-015 抑制：`@SuppressWarnings("PMD.NoFixedSleepInConcurrencyTest")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## ReviewReflectiveFieldWrite

- [JV-RS-002 維持封裝與不變條件](../../../rules/stacks/java/common/reflection-and-suppression.md#java-reflective-encapsulation)（verified）：條件式採用：標出 Field 寫入供封裝審查，不能從語法判定業務不變條件；序列化框架與合法映射需逐點核准；未配置例外前不適合整個儲存庫直接阻擋；實證：bad-17=1, good-17=0；詳 pmd-results.json；；實證版本：17。

JV-RS-002 抑制：`@SuppressWarnings("PMD.ReviewReflectiveFieldWrite")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## UnnecessaryWarningSuppression

- [JV-RS-007 限定檢查抑制](../../../rules/stacks/java/common/reflection-and-suppression.md#java-warning-suppression)（candidate）：拒絕作為本條覆蓋：外層 serial 違反例沒有命中；此內建規則不等同 javac 所有警告範圍驗證；改用局部 MisplacedSerialSuppression 並人工審查；實證：bad-17=0, good-17=0, good-8=0, good-11=0；詳 pmd-results.json；；實證版本：8、11、17。

JV-RS-007 抑制：`@SuppressWarnings("PMD.UnnecessaryWarningSuppression")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## MisplacedSerialSuppression

- [JV-RS-008 限定檢查抑制](../../../rules/stacks/java/common/reflection-and-suppression.md#java-warning-suppression)（verified）：採用局部模式：非 Serializable 類別本身沒有 serial 需求，應把 serial 抑制移至需要的內層型別；仍不能證明其他抑制的最小範圍、核准理由；實證：bad-17=1, good-17=0, good-8=0, good-11=0；詳 pmd-results.json；；實證版本：8、11、17。

JV-RS-008 抑制：`@SuppressWarnings("PMD.MisplacedSerialSuppression")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。

## AvoidAccessibilityAlteration

- [JV-VP-017 JDK 內部實作與存取限制](../../../rules/stacks/java/common/version-policy.md#java-jdk-internals)（verified）：採用局部模式：抓 setAccessible(true)，不能涵蓋 trySetAccessible、命令列開放或全部 JDK 內部實作；內建 PrivilegedAction 排除也可能漏報，不能當核准；實證：bad-17=1, good-17=0；詳 pmd-results.json；；實證版本：17。

JV-VP-017 抑制：`@SuppressWarnings("PMD.AvoidAccessibilityAlteration")`。

只有單行且確認其他診斷不受影響時才用 `// NOPMD`；路徑排除依上述最小範圍與核准要求處理。
