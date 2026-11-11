# Java 工具涵蓋率

由 `ruby tools/java/coverage/build-coverage.rb` 產生；請修改 rule-map.yml 後重建，勿直接修改本檔。

## 總表

| 項目 | 數量 |
| --- | --- |
| 文件數 | 15 |
| 小節數 | 143 |
| 映射筆數 | 308 |
| status：verified（筆） | 81 |
| status：partial（筆） | 52 |
| status：candidate（筆） | 35 |
| status：manual（筆） | 140 |
| tier：pre-commit（筆） | 111 |
| tier：ci-compile（筆） | 28 |
| tier：ci-bytecode（筆） | 16 |
| tier：ci-arch（筆） | 3 |
| tier：ci-build（筆） | 10 |
| tier：test（筆） | 34 |
| tier：manual（筆） | 106 |
| tool：pmd（筆） | 75 |
| tool：checkstyle（筆） | 36 |
| tool：javac（筆） | 12 |
| tool：errorprone（筆） | 16 |
| tool：spotbugs（筆） | 16 |
| tool：archunit（筆） | 3 |
| tool：jdeps（筆） | 3 |
| tool：jdeprscan（筆） | 1 |
| tool：maven-enforcer（筆） | 4 |
| tool：gradle（筆） | 2 |
| tool：none（筆） | 140 |
| 本庫 PMD／Checkstyle／CI 工具 verified 小節數 | 49 |
| CI 層未 verified（映射筆數；不計涵蓋率） | 38 |
| 涵蓋率（verified 小節／全部小節） | 49／143 = 34.27% |

每小節只要有一筆本庫可重跑的 PMD／Checkstyle／CI 工具 verified 即計入分子，同小節多規則不重複計數；status／tier／tool 欄則按映射筆數計算。partial、candidate、manual 均不計分子；verified 不代表整個小節、所有版本或所有合法例外都已自動驗證。

manual 可與 verified 並存，表示該小節仍有工具無法替代的審查或尚待實作的契約測試；candidate 包含失敗候選，不是啟用建議。實證版本、合成範例與漏報限制見 rule-map.yml 的 note。

## boundary-mapping.md

| 小節 | 錨點 | 等級 | tier | 工具與規則 | status | CI層候選 |
| --- | --- | --- | --- | --- | --- | --- |
| 明確控制欄位及來源 | java-mapping-fields | error | manual | none：none（JV-BM-001） | manual | — |
| 失敗明確回報 | java-mapping-integrity | error | test | none：none（JV-BM-002） | manual | — |
| 保留更新意圖 | java-update-intent | error | test | none：none（JV-BM-003） | manual | — |
| 集合與可變元素的隔離 | java-mutable-isolation | error | ci-bytecode | spotbugs：EI_EXPOSE_REP（JV-BM-004） | candidate | 是（未達 verified） |
| 集合與可變元素的隔離 | java-mutable-isolation | error | ci-bytecode | spotbugs：EI_EXPOSE_REP2（JV-BM-005） | candidate | 是（未達 verified） |
| 集合與可變元素的隔離 | java-mutable-isolation | error | test | none：none（JV-BM-006） | manual | — |
| 各方向分別定義 | java-directional-mapping | error | manual | none：none（JV-BM-007） | manual | — |
| 明確維護責任 | java-mapping-ownership | error | manual | none：none（JV-BM-008） | manual | — |
| 驗證實際映射路徑 | java-mapping-verification | error | test | none：none（JV-BM-009） | manual | — |

## classes-and-construction.md

| 小節 | 錨點 | 等級 | tier | 工具與規則 | status | CI層候選 |
| --- | --- | --- | --- | --- | --- | --- |
| 介面或具體類別的契約依賴 | java-interface-purpose | error | manual | none：none（JV-CC-001） | manual | — |
| 建構期間的安全性 | java-construction-safety | error | ci-compile | javac：-Xlint:this-escape（JV-CC-002） | partial | 是（未達 verified） |
| 建構期間的安全性 | java-construction-safety | error | pre-commit | pmd：category/java/errorprone.xml/ConstructorCallsOverridableMethod（JV-CC-003） | verified | — |
| 建構期間的安全性 | java-construction-safety | error | ci-bytecode | spotbugs：MC_OVERRIDABLE_METHOD_CALL_IN_CONSTRUCTOR（JV-CC-004） | verified | 否（本庫已重跑） |
| 建構期間的安全性 | java-construction-safety | error | manual | none：none（JV-CC-005） | manual | — |
| 明確取得依賴 | java-explicit-dependencies | error | pre-commit | pmd：category/java/design.xml/MutableStaticState（JV-CC-006） | partial | — |
| 明確取得依賴 | java-explicit-dependencies | error | manual | none：none（JV-CC-007） | manual | — |
| 依需求選擇建立方式 | java-construction-entrypoints | error | test | none：none（JV-CC-008） | manual | — |
| `super` 呼叫與 `final` 的擴充限制 | java-override-scope | warn | pre-commit | checkstyle：DesignForExtension（JV-CC-009） | candidate | — |
| `super` 呼叫與 `final` 的擴充限制 | java-override-scope | error | ci-compile | errorprone：MissingSuperCall（JV-CC-010） | partial | 是（未達 verified） |
| `super` 呼叫與 `final` 的擴充限制 | java-override-scope | error | manual | none：none（JV-CC-011） | manual | — |
| 契約與生命週期驗收 | java-lifecycle-verification | error | test | none：none（JV-CC-012） | manual | — |

## collections-and-ownership.md

| 小節 | 錨點 | 等級 | tier | 工具與規則 | status | CI層候選 |
| --- | --- | --- | --- | --- | --- | --- |
| 明確定義修改權與參考關係 | java-collection-ownership | error | manual | none：none（JV-CO-001） | manual | — |
| 區分不可修改與不可變快照 | java-snapshots-and-views | error | manual | none：none（JV-CO-002） | manual | — |
| 順序與重複資料 | java-order-and-duplicates | error | pre-commit | pmd：custom:ListFromHashSetLosesOrder（JV-CO-003） | verified | — |
| 順序與重複資料 | java-order-and-duplicates | error | manual | none：none（JV-CO-004） | manual | — |
| 遍歷期間的修改 | java-traversal-mutation | error | ci-compile | errorprone：ModifyCollectionInEnhancedForLoop（JV-CO-005） | verified | 否（本庫已重跑） |
| 遍歷期間的修改 | java-traversal-mutation | error | pre-commit | pmd：custom:CatchConcurrentModification（JV-CO-006） | partial | — |
| 遍歷期間的修改 | java-traversal-mutation | error | pre-commit | pmd：custom:ModifyCollectionInForeach（JV-CO-007） | verified | — |
| 複合操作的原子性 | java-compound-atomicity | error | pre-commit | pmd：custom:ConcurrentMapCheckThenAct（JV-CO-008） | verified | — |
| 複合操作的原子性 | java-compound-atomicity | error | ci-bytecode | spotbugs：AT_OPERATION_SEQUENCE_ON_CONCURRENT_ABSTRACTION（JV-CO-009） | partial | 是（未達 verified） |
| 複合操作的原子性 | java-compound-atomicity | error | manual | none：none（JV-CO-010） | manual | — |
| 限制資料累積 | java-bounded-accumulation | warn | pre-commit | pmd：custom:SortedBeforeLimit（JV-CO-011） | verified | — |
| 限制資料累積 | java-bounded-accumulation | error | pre-commit | pmd：custom:UnboundedStreamStatefulOp（JV-CO-012） | verified | — |
| 限制資料累積 | java-bounded-accumulation | error | manual | none：none（JV-CO-013） | manual | — |
| 延遲讀取的資源責任 | java-lazy-resource-lifetime | error | ci-compile | errorprone：StreamResourceLeak（JV-CO-014） | partial | 是（未達 verified） |
| 延遲讀取的資源責任 | java-lazy-resource-lifetime | error | pre-commit | pmd：custom:LazyStreamReturnedFromTryWithResources（JV-CO-015） | verified | — |
| 批次修改的失敗保證 | java-batch-failure-state | error | manual | none：none（JV-CO-016） | manual | — |
| 所有權與行為驗收 | java-collection-verification | error | test | none：none（JV-CO-017） | manual | — |

## concurrency-and-async.md

| 小節 | 錨點 | 等級 | tier | 工具與規則 | status | CI層候選 |
| --- | --- | --- | --- | --- | --- | --- |
| 統一管理執行資源 | java-execution-resources | error | pre-commit | pmd：category/java/multithreading.xml/DoNotUseThreads（JV-CA-001） | candidate | — |
| 統一管理執行資源 | java-execution-resources | warn | pre-commit | pmd：custom:NoUnmanagedThread（JV-CA-002） | partial | — |
| 統一管理執行資源 | java-execution-resources | error | manual | none：none（JV-CA-003） | manual | — |
| 可見性與共享資料 | java-visibility-sharing | error | ci-bytecode | spotbugs：VO_VOLATILE_INCREMENT（JV-CA-004） | verified | 否（本庫已重跑） |
| 可見性與共享資料 | java-visibility-sharing | error | manual | none：none（JV-CA-005） | manual | — |
| 等待期限與逾時處置 | java-deadline-budget | error | test | none：none（JV-CA-006） | manual | — |
| 取消傳遞與實際停止 | java-cancellation-propagation | error | test | none：none（JV-CA-007） | manual | — |
| `Future` 與 `CompletableFuture` 的結果鏈 | java-result-reception | error | manual | none：none（JV-CA-008） | manual | — |
| 多工作組合的完成條件 | java-task-completion | error | test | none：none（JV-CA-009） | manual | — |
| 執行位置與阻塞行為 | java-execution-location | error | test | none：none（JV-CA-010） | manual | — |
| 明確傳遞與清理脈絡 | java-context-propagation | error | test | none：none（JV-CA-011） | manual | — |
| 鎖定範圍與取得策略 | java-lock-scope | error | ci-bytecode | spotbugs：UL_UNRELEASED_LOCK（JV-CA-012） | verified | 否（本庫已重跑） |
| 鎖定範圍與取得策略 | java-lock-scope | error | manual | none：none（JV-CA-013） | manual | — |
| 受控關閉 | java-controlled-shutdown | error | test | none：none（JV-CA-014） | manual | — |
| 可控制的併發驗收 | java-controlled-verification | warn | pre-commit | pmd：custom:NoFixedSleepInConcurrencyTest（JV-CA-015） | verified | — |
| 可控制的併發驗收 | java-controlled-verification | error | manual | none：none（JV-CA-016） | manual | — |

## equality-hashing-ordering.md

| 小節 | 錨點 | 等級 | tier | 工具與規則 | status | CI層候選 |
| --- | --- | --- | --- | --- | --- | --- |
| 明訂比較語意 | java-comparison-semantics | error | manual | none：none（JV-EH-001） | manual | — |
| 相等與雜湊契約 | java-equality-hash-contract | error | pre-commit | checkstyle：EqualsHashCode（JV-EH-002） | partial | — |
| 相等與雜湊契約 | java-equality-hash-contract | error | ci-compile | errorprone：EqualsUsingHashCode（JV-EH-003） | verified | 否（本庫已重跑） |
| 相等與雜湊契約 | java-equality-hash-contract | error | pre-commit | pmd：category/java/errorprone.xml/OverrideBothEqualsAndHashcode（JV-EH-004） | partial | — |
| 相等與雜湊契約 | java-equality-hash-contract | error | ci-bytecode | spotbugs：HE_EQUALS_NO_HASHCODE（JV-EH-005） | partial | 是（未達 verified） |
| 相等與雜湊契約 | java-equality-hash-contract | error | test | none：none（JV-EH-006） | manual | — |
| 雜湊集合中的穩定性 | java-hash-collection-stability | error | manual | none：none（JV-EH-007） | manual | — |
| Entity 識別碼的生命週期 | java-entity-identity-lifecycle | error | pre-commit | pmd：custom:IdentityEqualsWithStateHashCode（JV-EH-008） | verified | — |
| Entity 識別碼的生命週期 | java-entity-identity-lifecycle | error | manual | none：none（JV-EH-009） | manual | — |
| 跨型別相等範圍 | java-cross-type-equality | error | pre-commit | checkstyle：EqualsHashCode（JV-EH-010） | verified | — |
| 跨型別相等範圍 | java-cross-type-equality | error | ci-compile | errorprone：EqualsGetClass（JV-EH-011） | candidate | 是（未達 verified） |
| 跨型別相等範圍 | java-cross-type-equality | error | pre-commit | pmd：category/java/errorprone.xml/OverrideBothEqualsAndHashcode（JV-EH-012） | verified | — |
| 跨型別相等範圍 | java-cross-type-equality | error | ci-bytecode | spotbugs：EQ_OVERRIDING_EQUALS_NOT_SYMMETRIC（JV-EH-013） | verified | 否（本庫已重跑） |
| 跨型別相等範圍 | java-cross-type-equality | error | manual | none：none（JV-EH-014） | manual | — |
| 自然順序與情境排序 | java-ordering-choice | error | manual | none：none（JV-EH-015） | manual | — |
| 比較關係一致 | java-comparator-relations | error | ci-compile | errorprone：BadComparable（JV-EH-016） | partial | 是（未達 verified） |
| 比較關係一致 | java-comparator-relations | error | pre-commit | pmd：custom:ComparatorBySubtraction（JV-EH-017） | verified | — |
| 比較關係一致 | java-comparator-relations | error | manual | none：none（JV-EH-018） | manual | — |
| 比較為零與相等性 | java-sorted-key-equivalence | warn | pre-commit | pmd：category/java/errorprone.xml/OverrideBothEqualsAndHashCodeOnComparable（JV-EH-019） | partial | — |
| 比較為零與相等性 | java-sorted-key-equivalence | error | manual | none：none（JV-EH-020） | manual | — |
| 排序集合中的穩定性 | java-sorted-collection-stability | error | manual | none：none（JV-EH-021） | manual | — |
| 關係與集合行為驗收 | java-relationship-coverage | error | test | none：none（JV-EH-022） | manual | — |

## exceptions-and-resources.md

| 小節 | 錨點 | 等級 | tier | 工具與規則 | status | CI層候選 |
| --- | --- | --- | --- | --- | --- | --- |
| 明確的故障分類 | java-exception-classification | error | pre-commit | checkstyle：IllegalThrows（JV-ER-001） | verified | — |
| 明確的故障分類 | java-exception-classification | error | pre-commit | pmd：category/java/bestpractices.xml/PreserveStackTrace（JV-ER-002） | partial | — |
| 明確的故障分類 | java-exception-classification | error | pre-commit | pmd：category/java/design.xml/AvoidThrowingRawExceptionTypes（JV-ER-003） | partial | — |
| 明確的故障分類 | java-exception-classification | error | pre-commit | pmd：category/java/design.xml/SignatureDeclareThrowsException（JV-ER-004） | verified | — |
| 明確的故障分類 | java-exception-classification | error | ci-bytecode | spotbugs：THROWS_METHOD_THROWS_CLAUSE_BASIC_EXCEPTION（JV-ER-005） | partial | 是（未達 verified） |
| 明確的故障分類 | java-exception-classification | error | manual | none：none（JV-ER-006） | manual | — |
| Checked 與 Unchecked 的選擇 | java-checked-unchecked | error | manual | none：none（JV-ER-007） | manual | — |
| 捕捉範圍與處置相符 | java-catch-scope | error | pre-commit | checkstyle：IllegalCatch[illegalClassNames=Throwable,Error]（JV-ER-008） | partial | — |
| 捕捉範圍與處置相符 | java-catch-scope | warn | pre-commit | checkstyle：IllegalCatch[illegalClassNames=Exception,RuntimeException]（JV-ER-031） | verified | — |
| 捕捉範圍與處置相符 | java-catch-scope | warn | pre-commit | pmd：category/java/errorprone.xml/AvoidCatchingGenericException（JV-ER-009） | verified | — |
| 捕捉範圍與處置相符 | java-catch-scope | error | pre-commit | pmd：custom:CatchThrowableOrError（JV-ER-010） | partial | — |
| 捕捉範圍與處置相符 | java-catch-scope | warn | ci-bytecode | spotbugs：REC_CATCH_EXCEPTION（JV-ER-011） | verified | 否（本庫已重跑） |
| 捕捉範圍與處置相符 | java-catch-scope | error | manual | none：none（JV-ER-012） | manual | — |
| 保留中斷意圖 | java-interruption | error | pre-commit | checkstyle：RegexpMultiline（JV-ER-013） | verified | — |
| 保留中斷意圖 | java-interruption | error | ci-compile | errorprone：InterruptedExceptionSwallowed（JV-ER-014） | partial | 是（未達 verified） |
| 保留中斷意圖 | java-interruption | error | pre-commit | pmd：category/java/errorprone.xml/EmptyCatchBlock（JV-ER-015） | verified | — |
| 保留中斷意圖 | java-interruption | error | pre-commit | pmd：custom:SwallowedInterruptedException（JV-ER-016） | verified | — |
| 保留中斷意圖 | java-interruption | error | manual | none：none（JV-ER-017） | manual | — |
| 優先使用語言資源管理機制 | java-resource-management | warn | pre-commit | pmd：category/java/bestpractices.xml/UseTryWithResources（JV-ER-018） | partial | — |
| 優先使用語言資源管理機制 | java-resource-management | error | pre-commit | pmd：category/java/errorprone.xml/CloseResource（JV-ER-019） | verified | — |
| 優先使用語言資源管理機制 | java-resource-management | error | ci-bytecode | spotbugs：OS_OPEN_STREAM_EXCEPTION_PATH（JV-ER-020） | verified | 否（本庫已重跑） |
| 優先使用語言資源管理機制 | java-resource-management | error | manual | none：none（JV-ER-021） | manual | — |
| 保留操作與清理失敗 | java-suppressed-failures | error | ci-compile | errorprone：Finally（JV-ER-022） | partial | 是（未達 verified） |
| 保留操作與清理失敗 | java-suppressed-failures | error | ci-compile | javac：-Xlint:finally（JV-ER-023） | partial | 是（未達 verified） |
| 保留操作與清理失敗 | java-suppressed-failures | error | pre-commit | pmd：category/java/bestpractices.xml/UseTryWithResources（JV-ER-024） | verified | — |
| 保留操作與清理失敗 | java-suppressed-failures | error | pre-commit | pmd：category/java/errorprone.xml/DoNotThrowExceptionInFinally（JV-ER-025） | partial | — |
| 保留操作與清理失敗 | java-suppressed-failures | error | pre-commit | pmd：category/java/errorprone.xml/ReturnFromFinallyBlock（JV-ER-026） | partial | — |
| 保留操作與清理失敗 | java-suppressed-failures | error | manual | none：none（JV-ER-027） | manual | — |
| 有效期與關閉契約 | java-resource-close-contract | error | pre-commit | pmd：custom:ResourceCapturedByAsyncTask（JV-ER-028） | verified | — |
| 有效期與關閉契約 | java-resource-close-contract | error | manual | none：none（JV-ER-029） | manual | — |
| 失敗路徑驗收 | java-failure-coverage | error | test | none：none（JV-ER-030） | manual | — |

## lambda-and-stream.md

| 小節 | 錨點 | 等級 | tier | 工具與規則 | status | CI層候選 |
| --- | --- | --- | --- | --- | --- | --- |
| 意圖與可讀性優先 | java-intent-readability | warn | pre-commit | checkstyle：LambdaBodyLength（JV-LS-001） | verified | — |
| 意圖與可讀性優先 | java-intent-readability | error | manual | none：none（JV-LS-002） | manual | — |
| 明確的參數型別 | java-lambda-parameter-types | error | pre-commit | checkstyle：RegexpSinglelineJava（JV-LS-003） | partial | — |
| 明確的參數型別 | java-lambda-parameter-types | error | pre-commit | pmd：custom:NoInferredLambdaParameterType（JV-LS-004） | verified | — |
| 明確的參數型別 | java-lambda-parameter-types | error | manual | none：none（JV-LS-005） | manual | — |
| 中間操作不隱藏業務副作用 | java-intermediate-side-effects | error | ci-compile | errorprone：ReturnValueIgnored（JV-LS-006） | verified | 否（本庫已重跑） |
| 中間操作不隱藏業務副作用 | java-intermediate-side-effects | error | pre-commit | pmd：custom:StreamPeekUsage（JV-LS-007） | verified | — |
| 中間操作不隱藏業務副作用 | java-intermediate-side-effects | error | manual | none：none（JV-LS-008） | manual | — |
| 明確累積結果 | java-result-accumulation | error | pre-commit | pmd：custom:ForEachAccumulatesExternalState（JV-LS-009） | verified | — |
| 明確累積結果 | java-result-accumulation | error | manual | none：none（JV-LS-010） | manual | — |
| 延遲與短路範圍 | java-lazy-short-circuit | error | ci-compile | errorprone：ReturnValueIgnored（JV-LS-011） | partial | 是（未達 verified） |
| 延遲與短路範圍 | java-lazy-short-circuit | error | manual | none：none（JV-LS-012） | manual | — |
| 平行處理的採用條件 | java-parallel-stream-adoption | error | pre-commit | pmd：custom:ParallelStreamUsage（JV-LS-013） | partial | — |
| 平行處理的採用條件 | java-parallel-stream-adoption | error | test | none：none（JV-LS-014） | manual | — |
| 歸約與收集契約 | java-reduction-collection | error | test | none：none（JV-LS-015） | manual | — |
| 維持錯誤分類 | java-failure-classification | error | pre-commit | pmd：custom:LambdaCatchWithoutRethrow（JV-LS-016） | verified | — |
| 維持錯誤分類 | java-failure-classification | error | manual | none：none（JV-LS-017） | manual | — |
| 明確消費範圍 | java-stream-consumption | warn | pre-commit | pmd：custom:StreamVariableReused（JV-LS-018） | partial | — |
| 明確消費範圍 | java-stream-consumption | error | manual | none：none（JV-LS-019） | manual | — |
| 執行語意驗收 | java-execution-verification | error | test | none：none（JV-LS-020） | manual | — |

## naming-packages-docs.md

| 小節 | 錨點 | 等級 | tier | 工具與規則 | status | CI層候選 |
| --- | --- | --- | --- | --- | --- | --- |
| 一致的命名形式 | java-naming-form | error | pre-commit | checkstyle：AbbreviationAsWordInName（JV-NP-001） | candidate | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | checkstyle：ConstantName（JV-NP-002） | verified | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | checkstyle：LambdaParameterName（JV-NP-003） | candidate | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | checkstyle：LocalFinalVariableName（JV-NP-004） | candidate | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | checkstyle：LocalVariableName（JV-NP-005） | candidate | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | checkstyle：MemberName（JV-NP-006） | candidate | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | checkstyle：MethodName（JV-NP-007） | verified | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | checkstyle：PackageName（JV-NP-008） | candidate | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | checkstyle：ParameterName（JV-NP-009） | candidate | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | checkstyle：PatternVariableName（JV-NP-010） | candidate | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | checkstyle：RecordComponentName（JV-NP-011） | candidate | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | checkstyle：StaticVariableName（JV-NP-012） | candidate | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | checkstyle：TypeName（JV-NP-013） | verified | — |
| 一致的命名形式 | java-naming-form | error | ci-compile | errorprone：IdentifierName（JV-NP-014） | verified | 否（本庫已重跑） |
| 一致的命名形式 | java-naming-form | error | pre-commit | pmd：category/java/codestyle.xml/ClassNamingConventions（JV-NP-015） | verified | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | pmd：category/java/codestyle.xml/FieldNamingConventions（JV-NP-016） | verified | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | pmd：category/java/codestyle.xml/FormalParameterNamingConventions（JV-NP-017） | candidate | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | pmd：category/java/codestyle.xml/LocalVariableNamingConventions（JV-NP-018） | candidate | — |
| 一致的命名形式 | java-naming-form | error | pre-commit | pmd：category/java/codestyle.xml/MethodNamingConventions（JV-NP-019） | verified | — |
| 一致的命名形式 | java-naming-form | error | ci-bytecode | spotbugs：NM_METHOD_NAMING_CONVENTION（JV-NP-020） | verified | 否（本庫已重跑） |
| 一致的命名形式 | java-naming-form | error | manual | none：none（JV-NP-021） | manual | — |
| 名稱表達具體責任 | java-specific-responsibility | error | manual | none：none（JV-NP-022） | manual | — |
| 套件與架構邊界 | java-package-boundaries | error | ci-arch | archunit：custom:InternalPackageNotPublic（JV-NP-023） | partial | 是（未達 verified） |
| 套件與架構邊界 | java-package-boundaries | error | ci-arch | archunit：custom:NestedStorageNotPublic（JV-NP-024） | verified | 否（本庫已重跑） |
| 套件與架構邊界 | java-package-boundaries | error | ci-arch | archunit：custom:SharedPackageNoBusinessDependency（JV-NP-025） | partial | 是（未達 verified） |
| 套件與架構邊界 | java-package-boundaries | error | ci-build | jdeps：--check（JV-NP-026） | candidate | 是（未達 verified） |
| 套件與架構邊界 | java-package-boundaries | error | ci-build | jdeps：-jdkinternals（JV-NP-027） | candidate | 是（未達 verified） |
| 套件與架構邊界 | java-package-boundaries | error | ci-build | maven-enforcer：bannedDependencies（JV-NP-028） | partial | 是（未達 verified） |
| 套件與架構邊界 | java-package-boundaries | error | manual | none：none（JV-NP-029） | manual | — |
| 補足契約資訊 | java-javadoc-contract | warn | pre-commit | checkstyle：JavadocMethod（JV-NP-030） | verified | — |
| 補足契約資訊 | java-javadoc-contract | error | pre-commit | checkstyle：MissingJavadocMethod（JV-NP-031） | partial | — |
| 補足契約資訊 | java-javadoc-contract | error | ci-compile | javac：-Xdoclint:missing（JV-NP-032） | candidate | 是（未達 verified） |
| 補足契約資訊 | java-javadoc-contract | error | manual | none：none（JV-NP-033） | manual | — |
| 重新命名與搬移的影響 | java-rename-impact | error | manual | none：none（JV-NP-034） | manual | — |
| 形式與語意分別驗收 | java-document-verification | error | ci-compile | javac：-Xdoclint:reference,syntax,html（JV-NP-035） | candidate | 是（未達 verified） |
| 形式與語意分別驗收 | java-document-verification | error | test | none：none（JV-NP-036） | manual | — |

## null-and-optional.md

| 小節 | 錨點 | 等級 | tier | 工具與規則 | status | CI層候選 |
| --- | --- | --- | --- | --- | --- | --- |
| 查詢的正常缺值 | java-query-absence | error | pre-commit | pmd：category/java/errorprone.xml/ReturnEmptyCollectionRatherThanNull（JV-NO-001） | verified | — |
| 查詢的正常缺值 | java-query-absence | error | manual | none：none（JV-NO-002） | manual | — |
| Optional 本身非空 | java-optional-nonnull | error | pre-commit | pmd：custom:OptionalReturnNull（JV-NO-003） | partial | — |
| Optional 本身非空 | java-optional-nonnull | error | ci-bytecode | spotbugs：NP_OPTIONAL_RETURN_NULL（JV-NO-004） | verified | 否（本庫已重跑） |
| Optional 本身非空 | java-optional-nonnull | error | manual | none：none（JV-NO-005） | manual | — |
| 取值與缺值處置 | java-optional-access | error | manual | none：none（JV-NO-006） | manual | — |
| 使用位置與狀態表達 | java-optional-positions | error | manual | none：none（JV-NO-007） | manual | — |
| 集合內容的空值 | java-container-nulls | error | manual | none：none（JV-NO-008） | manual | — |
| 非空驗證的位置 | java-nonnull-validation | error | manual | none：none（JV-NO-009） | manual | — |
| 工具可辨識的契約 | java-null-contract-tools | error | manual | none：none（JV-NO-010） | manual | — |
| 第三方空值行為 | java-third-party-optional | error | manual | none：none（JV-NO-011） | manual | — |
| 空值契約變更 | java-null-contract-evolution | error | manual | none：none（JV-NO-012） | manual | — |
| 預設非空與明確語意 | java-nonnull-default | error | manual | none：none（JV-NO-013） | manual | — |
| API 邊界的缺值轉換 | java-api-absence | error | test | none：none（JV-NO-014） | manual | — |

## numbers-dates-text.md

| 小節 | 錨點 | 等級 | tier | 工具與規則 | status | CI層候選 |
| --- | --- | --- | --- | --- | --- | --- |
| 依語意選擇數值型別 | java-numeric-representation | error | manual | none：none（JV-ND-001） | manual | — |
| 從精確來源建立 | java-exact-numeric-sources | error | pre-commit | checkstyle：RegexpSinglelineJava（JV-ND-002） | verified | — |
| 從精確來源建立 | java-exact-numeric-sources | error | pre-commit | pmd：category/java/errorprone.xml/AvoidDecimalLiteralsInBigDecimalConstructor（JV-ND-003） | verified | — |
| 從精確來源建立 | java-exact-numeric-sources | error | pre-commit | pmd：custom:BigDecimalFromFloatingPoint（JV-ND-004） | verified | — |
| 從精確來源建立 | java-exact-numeric-sources | error | manual | none：none（JV-ND-005） | manual | — |
| 明訂捨入規則 | java-rounding-policy | error | pre-commit | pmd：custom:BigDecimalWithoutRoundingMode（JV-ND-006） | partial | — |
| 明訂捨入規則 | java-rounding-policy | error | manual | none：none（JV-ND-007） | manual | — |
| 範圍與轉換檢查 | java-numeric-range-checks | error | ci-compile | errorprone：NarrowingCompoundAssignment（JV-ND-008） | partial | 是（未達 verified） |
| 範圍與轉換檢查 | java-numeric-range-checks | error | pre-commit | pmd：custom:NarrowingPrimitiveCast（JV-ND-009） | verified | — |
| 範圍與轉換檢查 | java-numeric-range-checks | error | ci-bytecode | spotbugs：ICAST_INTEGER_MULTIPLY_CAST_TO_LONG（JV-ND-010） | partial | 是（未達 verified） |
| 範圍與轉換檢查 | java-numeric-range-checks | error | manual | none：none（JV-ND-011） | manual | — |
| BigDecimal 判同語意 | java-decimal-equivalence | error | ci-compile | errorprone：BigDecimalEquals（JV-ND-012） | partial | 是（未達 verified） |
| BigDecimal 判同語意 | java-decimal-equivalence | error | pre-commit | pmd：custom:BigDecimalRecordWithoutNormalization（JV-ND-013） | candidate | — |
| BigDecimal 判同語意 | java-decimal-equivalence | error | pre-commit | pmd：custom:ComparableBigDecimalRecordEqualsMismatch（JV-ND-014） | verified | — |
| BigDecimal 判同語意 | java-decimal-equivalence | error | manual | none：none（JV-ND-015） | manual | — |
| 依業務語意選擇時間型別 | java-temporal-representation | warn | pre-commit | checkstyle：IllegalType（JV-ND-016） | partial | — |
| 依業務語意選擇時間型別 | java-temporal-representation | warn | pre-commit | pmd：category/java/errorprone.xml/ReplaceJavaUtilDate（JV-ND-017） | partial | — |
| 依業務語意選擇時間型別 | java-temporal-representation | error | manual | none：none（JV-ND-018） | manual | — |
| 區分時間長度與日曆規則 | java-durations-calendar-periods | warn | pre-commit | checkstyle：RegexpSinglelineJava（JV-ND-019） | verified | — |
| 區分時間長度與日曆規則 | java-durations-calendar-periods | error | pre-commit | pmd：custom:DurationUsedForCalendarDay（JV-ND-020） | verified | — |
| 區分時間長度與日曆規則 | java-durations-calendar-periods | error | manual | none：none（JV-ND-021） | manual | — |
| 可控制的時間基準 | java-clock-source | warn | pre-commit | checkstyle：RegexpSinglelineJava（JV-ND-022） | verified | — |
| 可控制的時間基準 | java-clock-source | warn | ci-compile | errorprone：JavaTimeDefaultTimeZone（JV-ND-023） | partial | 是（未達 verified） |
| 可控制的時間基準 | java-clock-source | warn | pre-commit | pmd：custom:NowWithoutClock（JV-ND-024） | verified | — |
| 可控制的時間基準 | java-clock-source | error | manual | none：none（JV-ND-025） | manual | — |
| 解析與輸出契約 | java-temporal-parsing-formatting | error | pre-commit | checkstyle：RegexpSinglelineJava（JV-ND-026） | verified | — |
| 解析與輸出契約 | java-temporal-parsing-formatting | error | pre-commit | pmd：category/java/errorprone.xml/SimpleDateFormatNeedsLocale（JV-ND-027） | partial | — |
| 解析與輸出契約 | java-temporal-parsing-formatting | warn | pre-commit | pmd：custom:DateTimeFormatterPatternNotStrict（JV-ND-028） | partial | — |
| 解析與輸出契約 | java-temporal-parsing-formatting | error | pre-commit | pmd：custom:LenientDateTimeResolver（JV-ND-029） | verified | — |
| 解析與輸出契約 | java-temporal-parsing-formatting | error | manual | none：none（JV-ND-030） | manual | — |
| 長度與截取單位 | java-text-length-units | error | manual | none：none（JV-ND-031） | manual | — |
| 邊界與環境差異驗收 | java-boundary-verification | error | test | none：none（JV-ND-032） | manual | — |

## reflection-and-suppression.md

| 小節 | 錨點 | 等級 | tier | 工具與規則 | status | CI層候選 |
| --- | --- | --- | --- | --- | --- | --- |
| 明確需求與型別契約 | java-dynamic-type-contract | error | manual | none：none（JV-RS-001） | manual | — |
| 維持封裝與不變條件 | java-reflective-encapsulation | warn | pre-commit | pmd：custom:ReviewReflectiveFieldWrite（JV-RS-002） | verified | — |
| 維持封裝與不變條件 | java-reflective-encapsulation | error | manual | none：none（JV-RS-003） | manual | — |
| 使用前驗證契約 | java-dynamic-contract-validation | error | test | none：none（JV-RS-004） | manual | — |
| 區分故障與執行結果 | java-reflection-failure | error | pre-commit | pmd：category/java/bestpractices.xml/PreserveStackTrace（JV-RS-005） | verified | — |
| 區分故障與執行結果 | java-reflection-failure | error | manual | none：none（JV-RS-006） | manual | — |
| 限定檢查抑制 | java-warning-suppression | error | pre-commit | pmd：category/java/bestpractices.xml/UnnecessaryWarningSuppression（JV-RS-007） | candidate | — |
| 限定檢查抑制 | java-warning-suppression | error | pre-commit | pmd：custom:MisplacedSerialSuppression（JV-RS-008） | verified | — |
| 限定檢查抑制 | java-warning-suppression | error | manual | none：none（JV-RS-009） | manual | — |
| 產生碼不擴大豁免 | java-generated-code | error | manual | none：none（JV-RS-010） | manual | — |
| 驗證限制實際有效 | java-dynamic-verification | error | test | none：none（JV-RS-011） | manual | — |

## states-and-results.md

| 小節 | 錨點 | 等級 | tier | 工具與規則 | status | CI層候選 |
| --- | --- | --- | --- | --- | --- | --- |
| 明確的狀態型別 | java-explicit-state-types | error | manual | none：none（JV-SR-001） | manual | — |
| 各狀態的必要資料 | java-required-state-data | error | manual | none：none（JV-SR-002） | manual | — |
| 業務操作控制轉換 | java-business-state-transitions | error | manual | none：none（JV-SR-003） | manual | — |
| 具型別的業務失敗 | java-typed-business-failures | error | manual | none：none（JV-SR-004） | manual | — |
| 處理完整性 | java-exhaustive-result-handling | error | ci-compile | javac：-Xlint:all（JV-SR-005） | candidate | 是（未達 verified） |
| 處理完整性 | java-exhaustive-result-handling | error | pre-commit | pmd：category/java/bestpractices.xml/ExhaustiveSwitchHasDefault（JV-SR-006） | candidate | — |
| 處理完整性 | java-exhaustive-result-handling | error | pre-commit | pmd：category/java/bestpractices.xml/NonExhaustiveSwitch（JV-SR-007） | candidate | — |
| 處理完整性 | java-exhaustive-result-handling | error | pre-commit | pmd：custom:EnumDefaultHidesCases（JV-SR-008） | partial | — |
| 處理完整性 | java-exhaustive-result-handling | error | manual | none：none（JV-SR-009） | manual | — |
| 穩定的外部代碼 | java-stable-external-codes | error | pre-commit | pmd：custom:EnumOrdinalAtBoundary（JV-SR-010） | partial | — |
| 穩定的外部代碼 | java-stable-external-codes | error | manual | none：none（JV-SR-011） | manual | — |
| 封閉或允許擴充 | java-model-extensibility | error | manual | none：none（JV-SR-012） | manual | — |
| 模型驗收 | java-model-acceptance | error | test | none：none（JV-SR-013） | manual | — |

## types-and-generics.md

| 小節 | 錨點 | 等級 | tier | 工具與規則 | status | CI層候選 |
| --- | --- | --- | --- | --- | --- | --- |
| 明確宣告型別 | java-explicit-types | error | pre-commit | checkstyle：RegexpSinglelineJava（JV-TG-001） | verified | — |
| 明確宣告型別 | java-explicit-types | error | pre-commit | pmd：category/java/codestyle.xml/UseExplicitTypes（JV-TG-002） | verified | — |
| 明確宣告型別 | java-explicit-types | error | manual | none：none（JV-TG-003） | manual | — |
| 禁止 raw type 與不必要的型別抽象 | java-generic-type-information | error | ci-compile | javac：-Xlint:rawtypes（JV-TG-004） | partial | 是（未達 verified） |
| 禁止 raw type 與不必要的型別抽象 | java-generic-type-information | error | pre-commit | pmd：custom:RawGenericType（JV-TG-005） | partial | — |
| 禁止 raw type 與不必要的型別抽象 | java-generic-type-information | error | manual | none：none（JV-TG-006） | manual | — |
| 輸入與輸出的型別關聯 | java-input-output-type-relation | error | pre-commit | pmd：custom:GenericMethodReturnsObject（JV-TG-007） | verified | — |
| 輸入與輸出的型別關聯 | java-input-output-type-relation | error | manual | none：none（JV-TG-008） | manual | — |
| 不得以向下轉型補回業務型別 | java-business-type-casts | error | pre-commit | pmd：custom:DowncastFromObject（JV-TG-009） | verified | — |
| 不得以向下轉型補回業務型別 | java-business-type-casts | error | manual | none：none（JV-TG-010） | manual | — |
| 型別安全警告 | java-type-safety-warnings | error | pre-commit | checkstyle：SuppressWarnings（JV-TG-011） | verified | — |
| 型別安全警告 | java-type-safety-warnings | error | ci-compile | errorprone：SuppressWarningsWithoutExplanation（JV-TG-012） | verified | 否（本庫已重跑） |
| 型別安全警告 | java-type-safety-warnings | error | ci-compile | javac：-Xlint:rawtypes,unchecked -Werror（JV-TG-013） | partial | 是（未達 verified） |
| 型別安全警告 | java-type-safety-warnings | error | pre-commit | pmd：custom:NoSuppressTypeSafetyWarnings（JV-TG-014） | verified | — |
| 型別安全警告 | java-type-safety-warnings | error | manual | none：none（JV-TG-015） | manual | — |
| 本組補充說明 | java-group-notes-explicit-types | error | manual | none：none（JV-TG-016） | manual | — |
| 業務資料結構 | java-business-data-shape | error | pre-commit | pmd：custom:ObjectValuedDataShape（JV-TG-017） | verified | — |
| 業務資料結構 | java-business-data-shape | error | manual | none：none（JV-TG-018） | manual | — |
| 型別能力與約束 | java-generic-capabilities | error | manual | none：none（JV-TG-019） | manual | — |
| 集合與映射的宣告型別 | java-collection-declarations | warn | pre-commit | checkstyle：IllegalType（JV-TG-020） | verified | — |
| 集合與映射的宣告型別 | java-collection-declarations | warn | ci-compile | errorprone：NonApiType（JV-TG-021） | verified | 否（本庫已重跑） |
| 集合與映射的宣告型別 | java-collection-declarations | warn | pre-commit | pmd：category/java/bestpractices.xml/LooseCoupling（JV-TG-022） | verified | — |
| 集合與映射的宣告型別 | java-collection-declarations | error | manual | none：none（JV-TG-023） | manual | — |
| 允許建構端使用菱形運算子 | java-diamond-construction | error | ci-compile | javac：-Xlint:rawtypes（JV-TG-024） | verified | 否（本庫已重跑） |
| 允許建構端使用菱形運算子 | java-diamond-construction | error | pre-commit | pmd：custom:RawGenericType（JV-TG-025） | verified | — |
| 泛型回傳值 | java-generic-return-types | error | pre-commit | pmd：custom:UnboundedWildcardReturnType（JV-TG-026） | verified | — |
| 泛型回傳值 | java-generic-return-types | error | manual | none：none（JV-TG-027） | manual | — |
| 泛型參數命名 | java-type-parameter-names | warn | pre-commit | checkstyle：ClassTypeParameterName（JV-TG-028） | candidate | — |
| 泛型參數命名 | java-type-parameter-names | warn | pre-commit | checkstyle：InterfaceTypeParameterName（JV-TG-029） | verified | — |
| 泛型參數命名 | java-type-parameter-names | warn | pre-commit | checkstyle：MethodTypeParameterName（JV-TG-030） | candidate | — |
| 泛型參數命名 | java-type-parameter-names | warn | pre-commit | checkstyle：RecordTypeParameterName（JV-TG-031） | candidate | — |
| 泛型參數命名 | java-type-parameter-names | warn | pre-commit | pmd：category/java/codestyle.xml/TypeParameterNamingConventions（JV-TG-032） | candidate | — |
| 泛型參數命名 | java-type-parameter-names | error | manual | none：none（JV-TG-033） | manual | — |

## value-objects.md

| 小節 | 錨點 | 等級 | tier | 工具與規則 | status | CI層候選 |
| --- | --- | --- | --- | --- | --- | --- |
| 建立專屬型別的條件 | java-dedicated-value-types | error | manual | none：none（JV-VO-001） | manual | — |
| 建立時保護不變條件 | java-value-construction-invariants | error | test | none：none（JV-VO-002） | manual | — |
| 不可變性 | java-value-immutability | error | ci-bytecode | spotbugs：EI_EXPOSE_REP（JV-VO-003） | candidate | 是（未達 verified） |
| 不可變性 | java-value-immutability | error | ci-bytecode | spotbugs：EI_EXPOSE_REP2（JV-VO-004） | candidate | 是（未達 verified） |
| 不可變性 | java-value-immutability | error | test | none：none（JV-VO-005） | manual | — |
| 值相等的條件 | java-value-equality | error | pre-commit | pmd：category/java/errorprone.xml/OverrideBothEqualsAndHashcode（JV-VO-006） | candidate | — |
| 值相等的條件 | java-value-equality | error | test | none：none（JV-VO-007） | manual | — |
| 正規化規則 | java-value-normalization | error | test | none：none（JV-VO-008） | manual | — |
| 運算責任 | java-value-operations | error | manual | none：none（JV-VO-009） | manual | — |
| 資料還原 | java-value-restoration | error | test | none：none（JV-VO-010） | manual | — |
| 一般類別與 record | java-value-implementation | error | manual | none：none（JV-VO-011） | manual | — |
| 診斷字串與交換格式 | java-diagnostic-representation | error | manual | none：none（JV-VO-012） | manual | — |
| 業務保證的測試 | java-value-test-coverage | error | test | none：none（JV-VO-013） | manual | — |

## version-policy.md

| 小節 | 錨點 | 等級 | tier | 工具與規則 | status | CI層候選 |
| --- | --- | --- | --- | --- | --- | --- |
| 分別記錄版本資訊 | java-version-declarations | error | ci-build | maven-enforcer：requireJavaVersion（JV-VP-001） | partial | 是（未達 verified） |
| 分別記錄版本資訊 | java-version-declarations | error | manual | none：none（JV-VP-002） | manual | — |
| 建置設定落實限制 | java-build-compatibility | error | ci-build | gradle：JavaCompile.options.release（JV-VP-003） | partial | 是（未達 verified） |
| 建置設定落實限制 | java-build-compatibility | error | ci-compile | javac：--release（JV-VP-004） | candidate | 是（未達 verified） |
| 建置設定落實限制 | java-build-compatibility | error | manual | none：none（JV-VP-005） | manual | — |
| 執行版本驗證 | java-runtime-verification | error | test | none：none（JV-VP-006） | manual | — |
| 多模組版本要求 | java-module-versions | error | test | none：none（JV-VP-007） | manual | — |
| 版本宣告與相容性補充說明 | java-group-notes-version-declarations | error | manual | none：none（JV-VP-008） | manual | — |
| 依賴版本要求 | java-dependency-versions | error | ci-build | gradle：ResolutionStrategy.failOnVersionConflict（JV-VP-009） | partial | 是（未達 verified） |
| 依賴版本要求 | java-dependency-versions | error | ci-build | maven-enforcer：bannedDependencies（JV-VP-010） | partial | 是（未達 verified） |
| 依賴版本要求 | java-dependency-versions | error | ci-build | maven-enforcer：dependencyConvergence（JV-VP-011） | partial | 是（未達 verified） |
| 依賴版本要求 | java-dependency-versions | error | manual | none：none（JV-VP-012） | manual | — |
| 建置升級與支援範圍變更 | java-build-upgrade | error | manual | none：none（JV-VP-013） | manual | — |
| Preview 功能 | java-preview-features | error | ci-compile | javac：-Xlint:preview（JV-VP-014） | candidate | 是（未達 verified） |
| Preview 功能 | java-preview-features | error | manual | none：none（JV-VP-015） | manual | — |
| JDK 內部實作與存取限制 | java-jdk-internals | error | ci-build | jdeps：--jdk-internals（JV-VP-016） | partial | 是（未達 verified） |
| JDK 內部實作與存取限制 | java-jdk-internals | error | pre-commit | pmd：category/java/errorprone.xml/AvoidAccessibilityAlteration（JV-VP-017） | verified | — |
| JDK 內部實作與存取限制 | java-jdk-internals | error | manual | none：none（JV-VP-018） | manual | — |
| 棄用 API | java-deprecated-api | error | ci-compile | javac：-Xlint:deprecation（JV-VP-019） | verified | 否（本庫已重跑） |
| 棄用 API | java-deprecated-api | error | ci-compile | javac：-Xlint:removal（JV-VP-020） | verified | 否（本庫已重跑） |
| 棄用 API | java-deprecated-api | error | ci-build | jdeprscan：--release（JV-VP-021） | verified | 否（本庫已重跑） |
| 棄用 API | java-deprecated-api | error | manual | none：none（JV-VP-022） | manual | — |
| 依賴、升級與特殊功能補充說明 | java-group-notes-dependency-versions | error | manual | none：none（JV-VP-023） | manual | — |
| 建置與驗證工具相容性 | java-toolchain-compatibility | error | test | none：none（JV-VP-024） | manual | — |
| JDK 發行商與完整版本 | java-jdk-distribution | error | manual | none：none（JV-VP-025） | manual | — |
| 產物與執行環境追溯 | java-artifact-traceability | error | manual | none：none（JV-VP-026） | manual | — |
| 支援版本與主範例基線 | java-example-baseline | error | manual | none：none（JV-VP-027） | manual | — |
| 新版本納入與版本退場 | java-version-lifecycle | error | manual | none：none（JV-VP-028） | manual | — |
| 版本差異索引 | java-version-differences-index | warn | manual | none：none（JV-VP-029） | manual | — |

## 自訂規則清單

同名規則可對應多個小節；XPath 為來源的完整字串，HTML 跳脫只為安全顯示，原值以 YAML 為準。ArchUnit 自訂規則不使用 XPath。

### custom:RawGenericType

工具：pmd；來源：inv-claude-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/types-and-generics.md#java-generic-type-information | partial |
| rules/stacks/java/common/types-and-generics.md#java-diamond-construction | verified |

```xpath
//ClassType[not(TypeArguments)][not(parent::ClassType)]
  [not(parent::TypeExpression)][not(parent::ClassLiteral)][not(ancestor::Annotation)][not(ancestor::ImportDeclaration)]
  [pmd-java:typeIsExactly('java.util.Collection') or pmd-java:typeIsExactly('java.util.List') or pmd-java:typeIsExactly('java.util.ArrayList')
   or pmd-java:typeIsExactly('java.util.LinkedList') or pmd-java:typeIsExactly('java.util.Set') or pmd-java:typeIsExactly('java.util.HashSet')
   or pmd-java:typeIsExactly('java.util.LinkedHashSet') or pmd-java:typeIsExactly('java.util.TreeSet') or pmd-java:typeIsExactly('java.util.SortedSet')
   or pmd-java:typeIsExactly('java.util.NavigableSet') or pmd-java:typeIsExactly('java.util.Map') or pmd-java:typeIsExactly('java.util.HashMap')
   or pmd-java:typeIsExactly('java.util.LinkedHashMap') or pmd-java:typeIsExactly('java.util.TreeMap') or pmd-java:typeIsExactly('java.util.SortedMap')
   or pmd-java:typeIsExactly('java.util.NavigableMap') or pmd-java:typeIsExactly('java.util.concurrent.ConcurrentHashMap')
   or pmd-java:typeIsExactly('java.util.concurrent.ConcurrentMap') or pmd-java:typeIsExactly('java.util.Map.Entry') or pmd-java:typeIsExactly('java.util.Queue')
   or pmd-java:typeIsExactly('java.util.Deque') or pmd-java:typeIsExactly('java.util.ArrayDeque') or pmd-java:typeIsExactly('java.util.PriorityQueue')
   or pmd-java:typeIsExactly('java.util.Iterator') or pmd-java:typeIsExactly('java.util.ListIterator') or pmd-java:typeIsExactly('java.lang.Iterable')
   or pmd-java:typeIsExactly('java.util.Optional') or pmd-java:typeIsExactly('java.util.stream.Stream') or pmd-java:typeIsExactly('java.util.Comparator')
   or pmd-java:typeIsExactly('java.lang.Comparable') or pmd-java:typeIsExactly('java.util.function.Function') or pmd-java:typeIsExactly('java.util.function.BiFunction')
   or pmd-java:typeIsExactly('java.util.function.Supplier') or pmd-java:typeIsExactly('java.util.function.Consumer') or pmd-java:typeIsExactly('java.util.function.BiConsumer')
   or pmd-java:typeIsExactly('java.util.function.Predicate') or pmd-java:typeIsExactly('java.util.function.BiPredicate') or pmd-java:typeIsExactly('java.util.function.UnaryOperator')
   or pmd-java:typeIsExactly('java.util.function.BinaryOperator') or pmd-java:typeIsExactly('java.util.concurrent.Future') or pmd-java:typeIsExactly('java.util.concurrent.CompletableFuture')
   or pmd-java:typeIsExactly('java.util.concurrent.Callable') or pmd-java:typeIsExactly('java.lang.Class') or pmd-java:typeIsExactly('java.lang.ThreadLocal')
   or pmd-java:typeIsExactly('java.util.concurrent.atomic.AtomicReference') or pmd-java:typeIsExactly('java.lang.ref.WeakReference') or pmd-java:typeIsExactly('java.util.Enumeration')]
```

### custom:GenericMethodReturnsObject

工具：pmd；來源：inv-claude-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/types-and-generics.md#java-input-output-type-relation | verified |

```xpath
//MethodDeclaration[TypeParameters]/ClassType[pmd-java:typeIsExactly('java.lang.Object')]
```

### custom:DowncastFromObject

工具：pmd；來源：inv-claude-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/types-and-generics.md#java-business-type-casts | verified |

```xpath
(//CastExpression[ClassType][*[2][pmd-java:typeIsExactly('java.lang.Object')]]
 | //InfixExpression[@Operator = 'instanceof'][*[1][pmd-java:typeIsExactly('java.lang.Object')]])
 [not(ancestor::MethodDeclaration[@Name = 'equals' and @Arity = 1])]
```

### custom:NoSuppressTypeSafetyWarnings

工具：pmd；來源：inv-claude-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/types-and-generics.md#java-type-safety-warnings | verified |

```xpath
//Annotation[pmd-java:typeIs('java.lang.SuppressWarnings')]//StringLiteral[@ConstValue = ('rawtypes', 'unchecked', 'all')]
```

### custom:ObjectValuedDataShape

工具：pmd；來源：inv-claude-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/types-and-generics.md#java-business-data-shape | verified |

```xpath
//(MethodDeclaration|FieldDeclaration|FormalParameter|RecordComponent)
  /*[self::ClassType or self::ArrayType]/descendant-or-self::node()/(self::ClassType[pmd-java:typeIs('java.util.Map')]/TypeArguments/ClassType[2][pmd-java:typeIsExactly('java.lang.Object')]
    | ArrayType[ClassType[pmd-java:typeIsExactly('java.lang.Object')]])
```

### custom:UnboundedWildcardReturnType

工具：pmd；來源：inv-claude-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/types-and-generics.md#java-generic-return-types | verified |

```xpath
//MethodDeclaration/ClassType//WildcardType[not(*)][not(parent::TypeArguments/parent::ClassType[pmd-java:typeIs('java.lang.Class')])]
```

### custom:NoInferredLambdaParameterType

工具：pmd；來源：inv-claude-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/lambda-and-stream.md#java-lambda-parameter-types | verified |

```xpath
//LambdaParameter[@TypeInferred = true()]
```

### custom:StreamPeekUsage

工具：pmd；來源：inv-claude-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/lambda-and-stream.md#java-intermediate-side-effects | verified |

```xpath
//MethodCall[@MethodName = 'peek'][*[1][pmd-java:typeIs('java.util.stream.BaseStream')]]
```

### custom:ForEachAccumulatesExternalState

工具：pmd；來源：inv-claude-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/lambda-and-stream.md#java-result-accumulation | verified |

```xpath
//MethodCall[@MethodName = ('forEach', 'forEachOrdered')]
  [*[1][pmd-java:typeIs('java.util.stream.BaseStream') or pmd-java:typeIs('java.lang.Iterable') or pmd-java:typeIs('java.util.Map')]]
  /ArgumentList/LambdaExpression
  [.//MethodCall[@MethodName = ('add', 'addAll', 'put', 'putAll', 'putIfAbsent', 'offer', 'push', 'append', 'remove', 'merge', 'compute', 'computeIfAbsent')]
     [*[1][self::VariableAccess or self::FieldAccess]
          [pmd-java:typeIs('java.util.Collection') or pmd-java:typeIs('java.util.Map') or pmd-java:typeIs('java.lang.StringBuilder')]
          [not(@Name = ancestor::LambdaExpression[1]//VariableId/@Name)]]]
```

### custom:ParallelStreamUsage

工具：pmd；來源：inv-claude-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/lambda-and-stream.md#java-parallel-stream-adoption | partial |

```xpath
//MethodCall[(@MethodName = 'parallelStream' and *[1][pmd-java:typeIs('java.util.Collection')])
          or (@MethodName = 'parallel' and *[1][pmd-java:typeIs('java.util.stream.BaseStream')])]
```

### custom:LambdaCatchWithoutRethrow

工具：pmd；來源：inv-claude-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/lambda-and-stream.md#java-failure-classification | verified |

```xpath
//CatchClause[ancestor::LambdaExpression][not(Block//ThrowStatement)][not(Block//MethodCall[@MethodName=('interrupt','cancel','shutdownNow')])]
```

### custom:StreamVariableReused

工具：pmd；來源：inv-claude-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/lambda-and-stream.md#java-stream-consumption | partial |

```xpath
//VariableId[@LocalVariable = true()][pmd-java:typeIs('java.util.stream.BaseStream')]
  [let $v := ., $n := @Name, $b := ancestor::Block[1] return
    count($b//MethodCall[@MethodName=('count','collect','toList','toArray','forEach','forEachOrdered','reduce','min','max','findFirst','findAny','anyMatch','allMatch','noneMatch','iterator','spliterator','sum','average','summaryStatistics')]
      [VariableAccess[@Name=$n]][ancestor::Block[1] is $b]) > 1]
```

### custom:InternalPackageNotPublic

工具：archunit；來源：inv-claude-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/naming-packages-docs.md#java-package-boundaries | partial |

### custom:NestedStorageNotPublic

工具：archunit；來源：inv-claude-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/naming-packages-docs.md#java-package-boundaries | verified |

### custom:SharedPackageNoBusinessDependency

工具：archunit；來源：inv-claude-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/naming-packages-docs.md#java-package-boundaries | partial |

### custom:OptionalReturnNull

工具：pmd；來源：inv-codex-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/null-and-optional.md#java-optional-nonnull | partial |

```xpath
//ReturnStatement/NullLiteral[ancestor::MethodDeclaration[1]/ClassType[pmd-java:typeIs('java.util.Optional')]][not(ancestor::LambdaExpression)]
```

### custom:EnumDefaultHidesCases

工具：pmd；來源：inv-codex-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/states-and-results.md#java-exhaustive-result-handling | partial |

```xpath
//(SwitchStatement | SwitchExpression)[@EnumSwitch = true()][@ExhaustiveEnumSwitch = false()][*/SwitchLabel[@Default = true()]]
```

### custom:EnumOrdinalAtBoundary

工具：pmd；來源：inv-codex-a。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/states-and-results.md#java-stable-external-codes | partial |

```xpath
//MethodCall[pmd-java:matchesSig('java.lang.Enum#ordinal()')]
```

### custom:ListFromHashSetLosesOrder

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/collections-and-ownership.md#java-order-and-duplicates | verified |

```xpath
//ConstructorCall[pmd-java:typeIs('java.util.List')]/ArgumentList/ConstructorCall[pmd-java:typeIsExactly('java.util.HashSet')]
```

### custom:CatchConcurrentModification

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/collections-and-ownership.md#java-traversal-mutation | partial |

```xpath
//CatchParameter//ClassType[pmd-java:typeIs('java.util.ConcurrentModificationException')]
```

### custom:ModifyCollectionInForeach

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/collections-and-ownership.md#java-traversal-mutation | verified |

```xpath
//MethodCall[@MethodName = ('add','addAll','remove','removeAll','removeIf','retainAll','clear','set','sort','put','putAll','putIfAbsent','replaceAll')][*[1][self::VariableAccess or self::FieldAccess]/@Name = ancestor::ForeachStatement/*[2][self::VariableAccess or self::FieldAccess]/@Name][not(ancestor::LambdaExpression[ancestor::ForeachStatement])]
```

### custom:ConcurrentMapCheckThenAct

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/collections-and-ownership.md#java-compound-atomicity | verified |

```xpath
//IfStatement[(UnaryExpression[@Operator='!']/MethodCall[@MethodName='containsKey'] | MethodCall[@MethodName='containsKey'] | InfixExpression[@Operator=('==','!=')][NullLiteral]/MethodCall[@MethodName='get'])[*[1][pmd-java:typeIs('java.util.concurrent.ConcurrentMap')]]/*[1]/@Name = *[position() > 1]//MethodCall[@MethodName=('put','remove','replace')]/*[1][self::VariableAccess or self::FieldAccess]/@Name]
```

### custom:SortedBeforeLimit

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/collections-and-ownership.md#java-bounded-accumulation | verified |

```xpath
//MethodCall[@MethodName='limit']/MethodCall[1][@MethodName='sorted'][pmd-java:typeIs('java.util.stream.Stream')]
```

### custom:UnboundedStreamStatefulOp

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/collections-and-ownership.md#java-bounded-accumulation | verified |

```xpath
//MethodCall[@MethodName=('sorted','distinct')][descendant::MethodCall[TypeExpression/ClassType[pmd-java:typeIs('java.util.stream.BaseStream')]][@MethodName='generate' or (@MethodName='iterate' and ArgumentList/@Size=2)]][not(descendant::MethodCall[@MethodName=('limit','takeWhile')])]
```

### custom:LazyStreamReturnedFromTryWithResources

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/collections-and-ownership.md#java-lazy-resource-lifetime | verified |

```xpath
//TryStatement[@TryWithResources = true()]/Block//ReturnStatement[not(ancestor::LambdaExpression[ancestor::TryStatement[@TryWithResources = true()]])][not(ancestor::ClassBody[ancestor::TryStatement])]/*[pmd-java:typeIs('java.util.stream.BaseStream') or pmd-java:typeIs('java.util.Iterator') or pmd-java:typeIs('java.util.Spliterator')][descendant-or-self::VariableAccess/@Name = ancestor::TryStatement[@TryWithResources = true()][1]/ResourceList/Resource//VariableId/@Name][not(descendant-or-self::MethodCall[@MethodName=('collect','toList','toArray')][descendant::VariableAccess/@Name = ancestor::TryStatement[@TryWithResources=true()][1]/ResourceList/Resource//VariableId/@Name])]
```

### custom:CatchThrowableOrError

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/exceptions-and-resources.md#java-catch-scope | partial |

```xpath
//CatchParameter//ClassType[pmd-java:typeIsExactly('java.lang.Throwable') or pmd-java:typeIsExactly('java.lang.Error')]
```

### custom:SwallowedInterruptedException

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/exceptions-and-resources.md#java-interruption | verified |

```xpath
//CatchClause[CatchParameter//ClassType[pmd-java:typeIs('java.lang.InterruptedException')]][not(Block//MethodCall[@MethodName='interrupt'])][not(Block//ThrowStatement)][not(Block//MethodCall[@MethodName=('cancel','shutdownNow')])]
```

### custom:ResourceCapturedByAsyncTask

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/exceptions-and-resources.md#java-resource-close-contract | verified |

```xpath
//TryStatement[@TryWithResources = true()]/Block//MethodCall[@MethodName=('runAsync','supplyAsync','submit','execute','schedule','scheduleAtFixedRate','scheduleWithFixedDelay','invokeAll','invokeAny','thenRunAsync','thenApplyAsync','thenAcceptAsync','thenComposeAsync','whenCompleteAsync','handleAsync','start')]/ArgumentList/*[self::LambdaExpression or self::MethodReference][descendant-or-self::*[self::VariableAccess or self::MethodReference]/@Name = ancestor::TryStatement[@TryWithResources = true()][1]/ResourceList/Resource//VariableId/@Name]
```

### custom:IdentityEqualsWithStateHashCode

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/equality-hashing-ordering.md#java-entity-identity-lifecycle | verified |

```xpath
//ClassDeclaration[ClassBody/MethodDeclaration[@Name='equals'][FormalParameters/@Size=1]/Block[@Size=1]/ReturnStatement/InfixExpression[@Operator='=='][ThisExpression]][ClassBody/MethodDeclaration[@Name='hashCode'][FormalParameters/@Size=0][.//VariableAccess[@Name = ancestor::ClassDeclaration[1]/ClassBody/FieldDeclaration/VariableDeclarator/VariableId[@Final = false()]/@Name] or .//FieldAccess[ThisExpression][@Name = ancestor::ClassDeclaration[1]/ClassBody/FieldDeclaration/VariableDeclarator/VariableId[@Final = false()]/@Name]]]
```

### custom:ComparatorBySubtraction

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/equality-hashing-ordering.md#java-comparator-relations | verified |

```xpath
//InfixExpression[@Operator='-'][pmd-java:typeIs('int') or pmd-java:typeIs('long') or pmd-java:typeIs('float') or pmd-java:typeIs('double')][parent::LambdaExpression[pmd-java:typeIs('java.util.Comparator')] or parent::CastExpression/parent::LambdaExpression[pmd-java:typeIs('java.util.Comparator')] or parent::ReturnStatement[ancestor::LambdaExpression[1][pmd-java:typeIs('java.util.Comparator')]] or parent::CastExpression/parent::ReturnStatement[ancestor::LambdaExpression[1][pmd-java:typeIs('java.util.Comparator')]] or parent::ReturnStatement[not(ancestor::LambdaExpression)][ancestor::MethodDeclaration[1][@Name=('compare','compareTo')][FormalParameters/@Size = (1,2)]] or parent::CastExpression/parent::ReturnStatement[not(ancestor::LambdaExpression)][ancestor::MethodDeclaration[1][@Name=('compare','compareTo')]]]
```

### custom:BigDecimalFromFloatingPoint

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/numbers-dates-text.md#java-exact-numeric-sources | verified |

```xpath
//ConstructorCall[pmd-java:typeIs('java.math.BigDecimal')]/ArgumentList/*[1][pmd-java:typeIs('double') or pmd-java:typeIs('float') or pmd-java:typeIs('java.lang.Double') or pmd-java:typeIs('java.lang.Float')] | //MethodCall[@MethodName='valueOf'][TypeExpression/ClassType[pmd-java:typeIs('java.math.BigDecimal')]]/ArgumentList/*[1][pmd-java:typeIs('double') or pmd-java:typeIs('float') or pmd-java:typeIs('java.lang.Double') or pmd-java:typeIs('java.lang.Float')]
```

### custom:BigDecimalWithoutRoundingMode

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/numbers-dates-text.md#java-rounding-policy | partial |

```xpath
//MethodCall[*[1][pmd-java:typeIs('java.math.BigDecimal')]][(@MethodName='divide' and ArgumentList/@Size = 1) or (@MethodName='setScale' and ArgumentList/@Size = 1)]
```

### custom:NarrowingPrimitiveCast

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/numbers-dates-text.md#java-numeric-range-checks | verified |

```xpath
//CastExpression[not(*[2][@CompileTimeConstant = true()])][not(PrimitiveType[@Kind='char'])][not((PrimitiveType[@Kind='byte'] and InfixExpression[@Operator='&'][NumericLiteral[@ValueAsInt=255]]) or (PrimitiveType[@Kind='short'] and InfixExpression[@Operator='&'][NumericLiteral[@ValueAsInt=65535]]))][not(ancestor::MethodDeclaration[@Name='hashCode'])][(PrimitiveType[@Kind=('int','short','byte','char')] and *[2][pmd-java:typeIs('long') or pmd-java:typeIs('double') or pmd-java:typeIs('float')]) or (PrimitiveType[@Kind='long'] and *[2][pmd-java:typeIs('double') or pmd-java:typeIs('float')]) or (PrimitiveType[@Kind=('short','byte','char')] and *[2][pmd-java:typeIs('int')]) or (PrimitiveType[@Kind='float'] and *[2][pmd-java:typeIs('double')])] | //MethodCall[@MethodName='clamp'][TypeExpression/ClassType[@SimpleName='Math']][ArgumentList/FieldAccess[@Name='MIN_VALUE'][TypeExpression/ClassType[@SimpleName='Integer']]][ArgumentList/FieldAccess[@Name='MAX_VALUE'][TypeExpression/ClassType[@SimpleName='Integer']]]
```

### custom:BigDecimalRecordWithoutNormalization

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/numbers-dates-text.md#java-decimal-equivalence | candidate |

```xpath
//RecordDeclaration[RecordComponentList/RecordComponent/ClassType[pmd-java:typeIs('java.math.BigDecimal')]][not(RecordBody/MethodDeclaration[@Name='equals'])][not(RecordBody/*[self::CompactConstructorDeclaration or self::ConstructorDeclaration]//MethodCall[@MethodName=('stripTrailingZeros','setScale')])]
```

### custom:ComparableBigDecimalRecordEqualsMismatch

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/numbers-dates-text.md#java-decimal-equivalence | verified |

```xpath
//RecordDeclaration[ImplementsList/ClassType[pmd-java:typeIs('java.lang.Comparable')]][RecordComponentList/RecordComponent/ClassType[pmd-java:typeIs('java.math.BigDecimal')]][RecordBody/MethodDeclaration[@Name='compareTo']//MethodCall[@MethodName='compareTo'][*[1][pmd-java:typeIs('java.math.BigDecimal')]]][not(RecordBody/MethodDeclaration[@Name='equals'])][not(RecordBody/*[self::CompactConstructorDeclaration or self::ConstructorDeclaration]//MethodCall[@MethodName=('stripTrailingZeros','setScale')])]
```

### custom:DurationUsedForCalendarDay

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/numbers-dates-text.md#java-durations-calendar-periods | verified |

```xpath
//MethodCall[@MethodName=('plus','minus')][*[1][pmd-java:typeIs('java.time.ZonedDateTime') or pmd-java:typeIs('java.time.LocalDateTime') or pmd-java:typeIs('java.time.OffsetDateTime')]]/ArgumentList/MethodCall[TypeExpression/ClassType[pmd-java:typeIs('java.time.Duration')]][@MethodName='ofDays' or (@MethodName='ofHours' and ArgumentList/NumericLiteral[@ValueAsLong mod 24 = 0])] | //MethodCall[@MethodName='plusHours' or @MethodName='minusHours'][*[1][pmd-java:typeIs('java.time.ZonedDateTime')]][ArgumentList/NumericLiteral[@ValueAsLong mod 24 = 0]]
```

### custom:NowWithoutClock

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/numbers-dates-text.md#java-clock-source | verified |

```xpath
//MethodCall[@MethodName='now'][not(ArgumentList/*[pmd-java:typeIs('java.time.Clock')])][TypeExpression/ClassType[pmd-java:typeIs('java.time.temporal.TemporalAccessor')]] | //MethodCall[pmd-java:matchesSig('java.lang.System#currentTimeMillis()')] | //ConstructorCall[pmd-java:matchesSig('java.util.Date#new()')] | //MethodCall[@MethodName='getInstance'][TypeExpression/ClassType[pmd-java:typeIs('java.util.Calendar')]][not(ArgumentList/*[pmd-java:typeIs('java.time.Clock')])]
```

### custom:DateTimeFormatterPatternNotStrict

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/numbers-dates-text.md#java-temporal-parsing-formatting | partial |

```xpath
//MethodCall[@MethodName='ofPattern'][TypeExpression/ClassType[pmd-java:typeIs('java.time.format.DateTimeFormatter')]][ArgumentList/@Size = 1 or not(ancestor::MethodCall[@MethodName='withResolverStyle'][ArgumentList/*[self::FieldAccess or self::VariableAccess][@Name='STRICT'][pmd-java:typeIs('java.time.format.ResolverStyle')]])]
```

### custom:LenientDateTimeResolver

工具：pmd；來源：inv-claude-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/numbers-dates-text.md#java-temporal-parsing-formatting | verified |

```xpath
//MethodCall[@MethodName='withResolverStyle']/ArgumentList/FieldAccess[@Name=('SMART','LENIENT')][TypeExpression/ClassType[pmd-java:typeIs('java.time.format.ResolverStyle')]]
```

### custom:NoUnmanagedThread

工具：pmd；來源：inv-codex-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/concurrency-and-async.md#java-execution-resources | partial |

```xpath
//ConstructorCall[pmd-java:typeIs('java.lang.Thread')][not(parent::ArgumentList/parent::MethodCall[@MethodName='addShutdownHook'][*[1][pmd-java:typeIs('java.lang.Runtime')]])][not(ancestor::MethodDeclaration[@Name='newThread'][parent::ClassBody/parent::*[self::ClassDeclaration or self::AnonymousClassDeclaration][pmd-java:typeIs('java.util.concurrent.ThreadFactory')]])][not(ancestor::LambdaExpression[pmd-java:typeIs('java.util.concurrent.ThreadFactory')])]
```

### custom:NoFixedSleepInConcurrencyTest

工具：pmd；來源：inv-codex-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/concurrency-and-async.md#java-controlled-verification | verified |

```xpath
//MethodCall[pmd-java:matchesSig('java.lang.Thread#sleep(long)') or pmd-java:matchesSig('java.lang.Thread#sleep(long,int)')]
```

### custom:ReviewReflectiveFieldWrite

工具：pmd；來源：inv-codex-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/reflection-and-suppression.md#java-reflective-encapsulation | verified |

```xpath
//MethodCall[@MethodName = ('set','setBoolean','setByte','setChar','setShort','setInt','setLong','setFloat','setDouble')][*[1][pmd-java:typeIs('java.lang.reflect.Field')]]
```

### custom:MisplacedSerialSuppression

工具：pmd；來源：inv-codex-b。

| 來源小節 | status |
| --- | --- |
| rules/stacks/java/common/reflection-and-suppression.md#java-warning-suppression | verified |

```xpath
//ClassDeclaration[not(pmd-java:typeIs('java.io.Serializable'))]/ModifierList/Annotation[pmd-java:typeIs('java.lang.SuppressWarnings')][.//StringLiteral[@ConstValue = 'serial']]
```

## 工具未涵蓋的必要內容清單（測試驗收）

即使同小節有 verified，這些責任仍不可省略；test 表待實作驗收，不表示已有可執行測試。

| 小節 | 錨點 | 等級 | 審查／測試內容 |
| --- | --- | --- | --- |
| 平行處理的採用條件 | rules/stacks/java/common/lambda-and-stream.md#java-parallel-stream-adoption | error | 資料隔離、順序、歸約、失敗語意與代表性負載量測只能靠測試與效能證據；Java 21 虛擬執行緒下的 common ForkJoinPool 行為屬執行期差異。 來源：inventory-inv-claude-a.yml 第 44 筆（JV-LS-014）。 |
| 歸約與收集契約 | rules/stacks/java/common/lambda-and-stream.md#java-reduction-collection | error | 違反範例 reduce(1, Integer::sum) 的錯誤在於單位元素語意；PMD／Error Prone／SpotBugs 全規則掃描皆未報任何相關規則；硬寫「reduce 第一參數為非 0 數字常值」只能抓此一形狀，不採用；驗收表要求以不同分段方式測試（tier test）；初始值、累積與合併結果以空資料、單筆、多筆與分段（parallel）案例測試。 來源：inventory-inv-claude-a.yml 第 45／46 筆（JV-LS-015）。 |
| 執行語意驗收 | rules/stacks/java/common/lambda-and-stream.md#java-execution-verification | error | 驗收條文，無範例；要求的是測試案例涵蓋（資料邊界、短路、順序、歸約、失敗、資源、平行），屬測試層。 來源：inventory-inv-claude-a.yml 第 51 筆（JV-LS-020）。 |
| 形式與語意分別驗收 | rules/stacks/java/common/naming-packages-docs.md#java-document-verification | error | 可執行範例須在承諾支援的版本編譯與測試：儲存庫 scripts/check-rules.rb examples 以 javac --release N 做的正是這件事；{@snippet file=...} 引用的外部範例檔需納入測試原始碼集；語意是否正確仍需人工。 來源：inventory-inv-claude-a.yml 第 68 筆（JV-NP-036）。 |
| 依需求選擇建立方式 | rules/stacks/java/common/classes-and-construction.md#java-construction-entrypoints | error | 「build 不得產出無效物件」需知道業務不變量（start&lt;=end）；違反與符合範例的差異只在 record 緊湊建構子有無檢查，PMD／EP／SpotBugs 全規則掃描均無相關命中；以無效組合呼叫每個建立入口（建構子、工廠、Builder.build）確認拒絕，屬單元測試。 來源：inventory-inv-claude-a.yml 第 76／77 筆（JV-CC-008）。 |
| 契約與生命週期驗收 | rules/stacks/java/common/classes-and-construction.md#java-lifecycle-verification | error | 驗收條文，無範例；建構、繼承、覆寫與框架代理的實際路徑以測試驗證。 來源：inventory-inv-claude-a.yml 第 81 筆（JV-CC-012）。 |
| API 邊界的缺值轉換 | rules/stacks/java/common/null-and-optional.md#java-api-absence | error | 以實際序列化路徑斷言欄位省略／JSON null 與契約相符；Map 放入 Optional 未必就是對外序列化，靜態型別不能證明；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 11 筆（JV-NO-014）。 |
| 建立時保護不變條件 | rules/stacks/java/common/value-objects.md#java-value-construction-invariants | error | 列舉建構子、工廠等建立路徑並輸入零、負值測試拒絕；不變條件內容取決於契約，通用缺少建構子規則會誤報合法 record；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 13 筆（JV-VO-002）。 |
| 不可變性 | rules/stacks/java/common/value-objects.md#java-value-immutability | error | 在傳入後及取出後修改集合並斷言內部值不變；SpotBugs EI_EXPOSE_REP／EI_EXPOSE_REP2 在原範例皆未命中，不得宣稱已涵蓋，反向檢視亦未被抓到；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 14 筆（JV-VO-005）。 |
| 值相等的條件 | rules/stacks/java/common/value-objects.md#java-value-equality | error | 測同型別同值相等、跨型別不相等與雜湊一致；原違反是 equals/hashCode 都未覆寫，OverrideBothEqualsAndHashcode 不會抓到，未讀欄位警告不算本條實證；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 15 筆（JV-VO-007）。 |
| 正規化規則 | rules/stacks/java/common/value-objects.md#java-value-normalization | error | 測不同建立入口與大小寫等價值；規範允許不同正規化政策，不能用缺少 toUpperCase 等語法推定違反；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 16 筆（JV-VO-008）。 |
| 資料還原 | rules/stacks/java/common/value-objects.md#java-value-restoration | error | 以非法歷史值走實際持久化、反序列化及還原入口；布林參數本身不一定是驗證旁路，須驗證路徑共用保證；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 18 筆（JV-VO-010）。 |
| 業務保證的測試 | rules/stacks/java/common/value-objects.md#java-value-test-coverage | error | 本節無 Java 範例；審查測試是否涵蓋實際相等性、不可變性及還原風險，不以產生方法的行覆蓋率替代；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 21 筆（JV-VO-013）。 |
| 模型驗收 | rules/stacks/java/common/states-and-results.md#java-model-acceptance | error | 本節無 Java 範例；需以真實模型與副作用斷言測試狀態轉換、未知代碼、擴充及處理完整性；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 29 筆（JV-SR-013）。 |
| 失敗明確回報 | rules/stacks/java/common/boundary-mapping.md#java-mapping-integrity | error | 經實際映射路徑輸入不合法金額並斷言失敗；null 參數可依其他契約合法存在，不以所有 catch 內建構 null 一律違規；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 31 筆（JV-BM-002）。 |
| 保留更新意圖 | rules/stacks/java/common/boundary-mapping.md#java-update-intent | error | 對省略、清空與設定值分別走反序列化及更新路徑；三態需求及空字串語意取決於契約，Optional 或 Map.get 本身非錯誤；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 32 筆（JV-BM-003）。 |
| 集合與可變元素的隔離 | rules/stacks/java/common/boundary-mapping.md#java-mutable-isolation | error | 修改快照中可變元素並檢查來源隔離；SpotBugs EI 規則沒有抓到原範例的淺層複製或 reversed 檢視，須行為測試；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 33 筆（JV-BM-006）。 |
| 驗證實際映射路徑 | rules/stacks/java/common/boundary-mapping.md#java-mapping-verification | error | 測試是否經實際部署的映射與序列化路徑需要配置及呼叫關係；不能僅以出現 Boundary.map 或測試方法名稱判定；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 36 筆（JV-BM-009）。 |
| 所有權與行為驗收 | rules/stacks/java/common/collections-and-ownership.md#java-collection-verification | error | 驗收小節，無範例；要求以實際集合操作測試，不屬靜態工具範圍。 來源：inventory-inv-claude-b.yml 第 17 筆（JV-CO-017）。 |
| 失敗路徑驗收 | rules/stacks/java/common/exceptions-and-resources.md#java-failure-coverage | error | 驗收小節，無範例；要求測試涵蓋失敗、中斷、部分初始化與清理路徑。 來源：inventory-inv-claude-b.yml 第 50 筆（JV-ER-030）。 |
| 相等與雜湊契約 | rules/stacks/java/common/equality-hashing-ordering.md#java-equality-hash-contract | error | 自反、對稱、遞移、一致性與 null 處理只能以測試驗證（建議 EqualsVerifier 一類測試庫，對應 acceptance-java-equality-hash-contract）；；實證版本：17、8。 來源：inventory-inv-claude-b.yml 第 58 筆（JV-EH-006）。 |
| 關係與集合行為驗收 | rules/stacks/java/common/equality-hashing-ordering.md#java-relationship-coverage | error | 驗收小節，無範例。 來源：inventory-inv-claude-b.yml 第 74 筆（JV-EH-022）。 |
| 邊界與環境差異驗收 | rules/stacks/java/common/numbers-dates-text.md#java-boundary-verification | error | 驗收小節，無範例；JEP 400 預設字元集差異屬執行期；若要工具化，Error Prone DefaultCharset 對應同文件組標題引用的共通要求「明確指定字元編碼」，本次未針對該共通條文實測。 來源：inventory-inv-claude-b.yml 第 108 筆（JV-ND-032）。 |
| 等待期限與逾時處置 | rules/stacks/java/common/concurrency-and-async.md#java-deadline-budget | error | 以可控制完成時間驗證同一預算耗用及逾時處置；XPath 無法可靠追蹤跨方法的時間預算；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 3 筆（JV-CA-006）。 |
| 取消傳遞與實際停止 | rules/stacks/java/common/concurrency-and-async.md#java-cancellation-propagation | error | 取消是否傳到全部子工作、是否遵守中斷契約及真正停止，須執行受控工作驗證；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 4 筆（JV-CA-007）。 |
| 多工作組合的完成條件 | rules/stacks/java/common/concurrency-and-async.md#java-task-completion | error | anyOf 與 allOf 都有合法用途；須按全部成功／首個成功契約測試失敗、取消與不同完成順序；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 6 筆（JV-CA-009）。 |
| 執行位置與阻塞行為 | rules/stacks/java/common/concurrency-and-async.md#java-execution-location | error | 需已知 executor 容量與跨呼叫提交關係；用受控單執行緒 executor 驗證不阻塞，另審查持鎖阻塞；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 7 筆（JV-CA-010）。 |
| 明確傳遞與清理脈絡 | rules/stacks/java/common/concurrency-and-async.md#java-context-propagation | error | 需跨工作重用同一執行緒測試正常、拋錯及巢狀呼叫後的清理／還原；僅搜尋 remove 會漏掉合法還原及誤認錯誤接收者；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 8 筆（JV-CA-011）。 |
| 受控關閉 | rules/stacks/java/common/concurrency-and-async.md#java-controlled-shutdown | error | shutdown、awaitTermination、close 的出現不證明終止；須驗證未完成、逾時、中斷時仍保留工作資源；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 10 筆（JV-CA-014）。 |
| 使用前驗證契約 | rules/stacks/java/common/reflection-and-suppression.md#java-dynamic-contract-validation | error | instanceof 只驗證型別；能力及契約版本需要提供不相容外掛的執行測試，不能用轉型語法當完整驗證；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 16 筆（JV-RS-004）。 |
| 驗證限制實際有效 | rules/stacks/java/common/reflection-and-suppression.md#java-dynamic-verification | error | 須在實際 module-path／classpath 與開放選項下執行允許及拒絕路徑；靜態工具不能證明存取控制生效；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 20 筆（JV-RS-011）。 |
| 執行版本驗證 | rules/stacks/java/common/version-policy.md#java-runtime-verification | error | 每個承諾執行環境均須跑啟動、依賴載入與關鍵功能；--release 編譯不替代執行；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 25 筆（JV-VP-006）。 |
| 多模組版本要求 | rules/stacks/java/common/version-policy.md#java-module-versions | error | 逐模組與使用端驗證依賴、位元碼、JPMS 及 multi-release JAR 真正選取路徑；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 26 筆（JV-VP-007）。 |
| 建置與驗證工具相容性 | rules/stacks/java/common/version-policy.md#java-toolchain-compatibility | error | 版本變更須驗證編譯、測試、分析、處理器與覆蓋率確實執行；本報告的執行期矩陣只是局部工具證據；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 34 筆（JV-VP-024）。 |

## 工具未涵蓋的必要內容清單（人工審查）

即使同小節有 verified，這些責任仍不可省略；test 表待實作驗收，不表示已有可執行測試。

| 小節 | 錨點 | 等級 | 審查／測試內容 |
| --- | --- | --- | --- |
| 明確宣告型別 | rules/stacks/java/common/types-and-generics.md#java-explicit-types | error | 「保留必要的泛型資訊」中與業務語意相關的部分（宣告型別是否足以表達契約）仍需人工；raw type 部分見 java-generic-type-information。 來源：inventory-inv-claude-a.yml 第 3 筆（JV-TG-003）。 |
| 禁止 raw type 與不必要的型別抽象 | rules/stacks/java/common/types-and-generics.md#java-generic-type-information | error | 「以 Object、萬用字元或無必要的泛型隱藏已知型別」需知道業務上已知什麼型別，工具無法判斷；本小節違反範例（Object order 欄位）無任何工具抓到。 來源：inventory-inv-claude-a.yml 第 6 筆（JV-TG-006）。 |
| 輸入與輸出的型別關聯 | rules/stacks/java/common/types-and-generics.md#java-input-output-type-relation | error | 泛型簽章是否「實際連結」輸入與輸出，須對照呼叫端契約判斷。 來源：inventory-inv-claude-a.yml 第 8 筆（JV-TG-008）。 |
| 不得以向下轉型補回業務型別 | rules/stacks/java/common/types-and-generics.md#java-business-type-casts | error | 是否「補回遺失的業務型別」、外部資料是否已在邊界驗證、第三方 API 限制的例外核准，均需人工。 來源：inventory-inv-claude-a.yml 第 10 筆（JV-TG-010）。 |
| 型別安全警告 | rules/stacks/java/common/types-and-generics.md#java-type-safety-warnings | error | 「關閉檢查」（例如建置設定移除 -Xlint）與例外核准紀錄需在 CI 設定審查與例外流程確認。 來源：inventory-inv-claude-a.yml 第 15 筆（JV-TG-015）。 |
| 本組補充說明 | rules/stacks/java/common/types-and-generics.md#java-group-notes-explicit-types | error | 治理流程條文（漸進導入、工具產生碼、個別例外），無範例；「測試不得透過不安全轉型偽造有效物件」可將 custom:DowncastFromObject 與 -Xlint:unchecked 同樣套用到測試原始碼集。 來源：inventory-inv-claude-a.yml 第 16 筆（JV-TG-016）。 |
| 業務資料結構 | rules/stacks/java/common/types-and-generics.md#java-business-data-shape | error | 「固定欄位」與「真正動態」的判斷依業務；其他以通用容器承載固定欄位的寫法（List&lt;String&gt; 當欄位序列）工具抓不到。 來源：inventory-inv-claude-a.yml 第 18 筆（JV-TG-018）。 |
| 型別能力與約束 | rules/stacks/java/common/types-and-generics.md#java-generic-capabilities | error | 違反範例是對型別變數 T 做 (Number) 轉型；PMD 7 XPath 沒有「運算式型別是型別變數」的判斷函式（typeIs/typeIsExactly 對 T 無法區分），javac／Error Prone／SpotBugs 亦無對應檢查，故全部小節為人工。 來源：inventory-inv-claude-a.yml 第 19 筆（JV-TG-019）。 |
| 集合與映射的宣告型別 | rules/stacks/java/common/types-and-generics.md#java-collection-declarations | error | 「不得過度泛化迫使使用端轉型」與可修改性／排序保證是否另行明訂，需人工對照使用端。 來源：inventory-inv-claude-a.yml 第 23 筆（JV-TG-023）。 |
| 泛型回傳值 | rules/stacks/java/common/types-and-generics.md#java-generic-return-types | error | 有界萬用字元是否「契約確實需要」、是否以萬用字元取代不可變性設計，需人工。 來源：inventory-inv-claude-a.yml 第 27 筆（JV-TG-027）。 |
| 泛型參數命名 | rules/stacks/java/common/types-and-generics.md#java-type-parameter-names | error | 名稱是否足以辨識責任與關聯、複雜契約是否補充說明，依驗收表「不僅依名稱長度判定」需人工。 來源：inventory-inv-claude-a.yml 第 30 筆（JV-TG-033）。 |
| 意圖與可讀性優先 | rules/stacks/java/common/lambda-and-stream.md#java-intent-readability | error | 責任是否獨立、意圖是否清楚屬語意判斷。 來源：inventory-inv-claude-a.yml 第 32 筆（JV-LS-002）。 |
| 明確的參數型別 | rules/stacks/java/common/lambda-and-stream.md#java-lambda-parameter-types | error | 方法參考是否「型別契約完整且意圖清楚」需人工。 來源：inventory-inv-claude-a.yml 第 35 筆（JV-LS-005）。 |
| 中間操作不隱藏業務副作用 | rules/stacks/java/common/lambda-and-stream.md#java-intermediate-side-effects | error | forEach 內寫入／外部呼叫的順序、失敗與部分成功保證需人工。 來源：inventory-inv-claude-a.yml 第 38 筆（JV-LS-008）。 |
| 明確累積結果 | rules/stacks/java/common/lambda-and-stream.md#java-result-accumulation | error | 跨元素狀態的順序與管理責任需人工。 來源：inventory-inv-claude-a.yml 第 40 筆（JV-LS-010）。 |
| 延遲與短路範圍 | rules/stacks/java/common/lambda-and-stream.md#java-lazy-short-circuit | error | allMatch／anyMatch／findFirst／takeWhile 是否符合「每筆都處理」的契約，只有知道契約才能判斷；驗收表要求以空／單筆／多筆／短路案例測試。 來源：inventory-inv-claude-a.yml 第 42 筆（JV-LS-012）。 |
| 維持錯誤分類 | rules/stacks/java/common/lambda-and-stream.md#java-failure-classification | error | 錯誤分類是否維持、原始原因是否保留、邊界轉換是否符合契約需人工。 來源：inventory-inv-claude-a.yml 第 48 筆（JV-LS-017）。 |
| 明確消費範圍 | rules/stacks/java/common/lambda-and-stream.md#java-stream-consumption | error | 快照一致性、外部資源有效期與關閉責任需人工對照契約。 來源：inventory-inv-claude-a.yml 第 50 筆（JV-LS-019）。 |
| 一致的命名形式 | rules/stacks/java/common/naming-packages-docs.md#java-naming-form | error | 「以業務概念與責任表達含義」、「不強制 I 前綴」與版本差異中的關鍵字限制（_、var、yield、record、sealed 不能作型別名）：後者由 javac 以編譯錯誤擋下，前者需人工。 來源：inventory-inv-claude-a.yml 第 57 筆（JV-NP-021）。 |
| 名稱表達具體責任 | rules/stacks/java/common/naming-packages-docs.md#java-specific-responsibility | error | 違反範例 DateUtils 計算訂單總額，名稱與責任不一致屬語意；PMD／Checkstyle／EP 全規則掃描皆無相關命中。 來源：inventory-inv-claude-a.yml 第 58 筆（JV-NP-022）。 |
| 套件與架構邊界 | rules/stacks/java/common/naming-packages-docs.md#java-package-boundaries | error | 套件責任劃分、什麼算公開契約、共用套件的責任是否明確，需架構審查；工具只能檢查已定義的邊界。 來源：inventory-inv-claude-a.yml 第 61 筆（JV-NP-029）。 |
| 補足契約資訊 | rules/stacks/java/common/naming-packages-docs.md#java-javadoc-contract | error | Javadoc 是否「只重述名稱」、前置條件／結果／失敗／副作用／生命週期是否與實作一致，需人工；工具只能檢查標籤存在。 來源：inventory-inv-claude-a.yml 第 65 筆（JV-NP-033）。 |
| 重新命名與搬移的影響 | rules/stacks/java/common/naming-packages-docs.md#java-rename-impact | error | 流程條文，無範例；直接引用由編譯擋下；設定、反射、序列化名稱、外部使用端與 module-info 的 exports／opens／uses／provides 需以變更清單人工核對（ArchUnit 可額外檢查「反射存取的類別名稱是否存在」但屬專案自訂）。 來源：inventory-inv-claude-a.yml 第 66 筆（JV-NP-034）。 |
| 介面或具體類別的契約依賴 | rules/stacks/java/common/classes-and-construction.md#java-interface-purpose | error | 無範例；是否需要介面隔離屬架構判斷；ArchUnit 只能檢查已定義的層間依賴，無法判斷「單一實作是否該抽介面」。 來源：inventory-inv-claude-a.yml 第 69 筆（JV-CC-001）。 |
| 建構期間的安全性 | rules/stacks/java/common/classes-and-construction.md#java-construction-safety | error | 事件註冊、回呼發布、背景工作啟動是否在生命週期條件滿足後才執行，需審查建構與啟動路徑。 來源：inventory-inv-claude-a.yml 第 73 筆（JV-CC-005）。 |
| 明確取得依賴 | rules/stacks/java/common/classes-and-construction.md#java-explicit-dependencies | error | 全域容器查詢、靜態服務登錄、單例取用屬語意；可依專案框架以 ArchUnit 禁止依賴特定 ServiceLocator／ApplicationContext 類別（專案自訂，未實證）。 來源：inventory-inv-claude-a.yml 第 75 筆（JV-CC-007）。 |
| `super` 呼叫與 `final` 的擴充限制 | rules/stacks/java/common/classes-and-construction.md#java-override-scope | error | 哪些檢查是「必要業務檢查」、擴充範圍是否符合需求、代理與繼承機制是否相容，需人工；sealed／permits 與 final 是否合適亦然。 來源：inventory-inv-claude-a.yml 第 80 筆（JV-CC-011）。 |
| 查詢的正常缺值 | rules/stacks/java/common/null-and-optional.md#java-query-absence | error | 查詢是否允許正常缺值、必要結果不存在及技術故障分類由契約決定；集合回傳 null 可局部自動檢查，單筆回傳型別不可只憑方法名稱推定；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 1 筆（JV-NO-002）。 |
| Optional 本身非空 | rules/stacks/java/common/null-and-optional.md#java-optional-nonnull | error | 自動規則僅涵蓋直接回傳 null；欄位、參數及間接資料流，以及 Optional.empty 是否掩蓋失敗，仍須契約與行為審查；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 2 筆（JV-NO-005）。 |
| 取值與缺值處置 | rules/stacks/java/common/null-and-optional.md#java-optional-access | error | 必須識別已成立的不變條件及跨分支支配關係；全面禁止 Optional.get 會誤報 Java 8、11 的符合範例，缺值處理是否符合業務語意需審查；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 3 筆（JV-NO-006）。 |
| 使用位置與狀態表達 | rules/stacks/java/common/null-and-optional.md#java-optional-positions | error | Optional 參數與欄位並非全面禁止；三態是否必要取決於更新契約，不能機械式套用禁 Optional 欄位規則；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 4 筆（JV-NO-007）。 |
| 集合內容的空值 | rules/stacks/java/common/null-and-optional.md#java-container-nulls | error | filter(Objects::nonNull) 可依明訂契約合法使用；未知容器元素與邊界契約無法靠通用 XPath 判定，須確認拒絕或替換語意並做輸入測試；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 5 筆（JV-NO-008）。 |
| 非空驗證的位置 | rules/stacks/java/common/null-and-optional.md#java-nonnull-validation | error | 未提供一致的空值標註、非空預設及可信內部契約範圍；不能要求每個 record 都有 requireNonNull，須審查邊界及建立入口；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 6 筆（JV-NO-009）。 |
| 工具可辨識的契約 | rules/stacks/java/common/null-and-optional.md#java-null-contract-tools | error | 本節無 Java 範例且尚未選定空值標註套件；需專案選定 NullAway／Checker Framework 或 SpotBugs 可理解的契約後另立規則與測試，不能把普通 javac 視為非空檢查器；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 7 筆（JV-NO-010）。 |
| 第三方空值行為 | rules/stacks/java/common/null-and-optional.md#java-third-party-optional | error | 第三方 load 的非空契約只存在範例註解，Optional.ofNullable 本身合法；必須核對第三方文件及契約測試；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 8 筆（JV-NO-011）。 |
| 空值契約變更 | rules/stacks/java/common/null-and-optional.md#java-null-contract-evolution | error | 無獨立 Java 範例；須比較契約歷史及呼叫端影響，單一版本 AST 無法證明相容性；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 9 筆（JV-NO-012）。 |
| 預設非空與明確語意 | rules/stacks/java/common/null-and-optional.md#java-nonnull-default | error | 需先定義專案可空標註及範圍；不能將所有 null 比較視為違規，非空預設為 warn，可空位置須明訂語意為 error；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 10 筆（JV-NO-013）。 |
| 建立專屬型別的條件 | rules/stacks/java/common/value-objects.md#java-dedicated-value-types | error | 業務識別概念不同需要專屬型別，普通資料則不需包裝；javac 能阻止已建模型別混用，不能判斷是否應建模，原違反範例可編譯；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 12 筆（JV-VO-001）。 |
| 運算責任 | rules/stacks/java/common/value-objects.md#java-value-operations | error | 值物件與領域元件責任及外部政策由架構決定；未提供領域套件或註解範圍，不能捏造 ArchUnit 分層規則；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 17 筆（JV-VO-009）。 |
| 一般類別與 record | rules/stacks/java/common/value-objects.md#java-value-implementation | error | 需敏感資料分類才能判定 record 自動 toString 是否洩漏；全面禁止 record 或要求所有 record 遮罩會改變條文；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 19 筆（JV-VO-011）。 |
| 診斷字串與交換格式 | rules/stacks/java/common/value-objects.md#java-diagnostic-representation | error | toString 是否成為穩定交換格式需呼叫端及契約證據；方法名 encode 不是可靠界線，須審查格式版本與揭露範圍；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 20 筆（JV-VO-012）。 |
| 明確的狀態型別 | rules/stacks/java/common/states-and-results.md#java-explicit-state-types | error | 多個 boolean 可能是獨立業務面向，無法一般化為違規；需確認互斥狀態及不合法組合；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 22 筆（JV-SR-001）。 |
| 各狀態的必要資料 | rules/stacks/java/common/states-and-results.md#java-required-state-data | error | 必要資料由每一狀態的契約決定；enum 與 nullable 欄位搭配未必違反，應審查是否可建立缺資料狀態；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 23 筆（JV-SR-002）。 |
| 業務操作控制轉換 | rules/stacks/java/common/states-and-results.md#java-business-state-transitions | error | 公開 setter 是否繞過業務操作依模型與驗證內容而定；全面禁止 setState 或 public setter 會誤報且容易改名繞過；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 24 筆（JV-SR-003）。 |
| 具型別的業務失敗 | rules/stacks/java/common/states-and-results.md#java-typed-business-failures | error | IOException 在此契約是技術故障，但其他介面可依法轉成外部結果；須審查故障分類與責任，不機械禁止 catch 回傳；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 25 筆（JV-SR-004）。 |
| 處理完整性 | rules/stacks/java/common/states-and-results.md#java-exhaustive-result-handling | error | default 是否把未知狀態當成功屬業務語意；窮盡檢查只能補強分支結構，自訂候選規則無法辨認允許的未知狀態拒絕；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 26 筆（JV-SR-009）。 |
| 穩定的外部代碼 | rules/stacks/java/common/states-and-results.md#java-stable-external-codes | error | ordinal 的外部使用可在已核定邊界範圍掃描；名稱穩定性、代碼相容性及未知值映射仍需審查與測試；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 27 筆（JV-SR-011）。 |
| 封閉或允許擴充 | rules/stacks/java/common/states-and-results.md#java-model-extensibility | error | 封閉或開放是契約決策；不能要求所有介面 sealed，javac 只在已宣告 sealed 後檢查 permits，原違反範例不會報錯；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 28 筆（JV-SR-012）。 |
| 明確控制欄位及來源 | rules/stacks/java/common/boundary-mapping.md#java-mapping-fields | error | 租戶可信來源及允許傳遞欄位需契約與信任邊界；僅靠 tenantId 等名稱無法可靠區分可信資料；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 30 筆（JV-BM-001）。 |
| 各方向分別定義 | rules/stacks/java/common/boundary-mapping.md#java-directional-mapping | error | 輸入及輸出契約的遮罩與可更新欄位不同；工具反向生成是否合法需核對方向規則，不能一般禁止成對映射；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 34 筆（JV-BM-007）。 |
| 明確維護責任 | rules/stacks/java/common/boundary-mapping.md#java-mapping-ownership | error | Mapper 介面及包裝層有無實際責任或共用需求依系統脈絡決定；不能全面禁止一行方法或介面；人工／測試責任不是已實作自動規則；不計入工具涵蓋率。 來源：inventory-inv-codex-a.yml 第 35 筆（JV-BM-008）。 |
| 明確定義修改權與參考關係 | rules/stacks/java/common/collections-and-ownership.md#java-collection-ownership | error | 違反與符合範例的程式碼完全相同，只差 Javadoc 所宣稱的契約；只能由人審查契約與實作是否一致；實測 SpotBugs EI_EXPOSE_REP／EI_EXPOSE_REP2（4.10.5）對 List 欄位的回傳不報，PMD MethodReturnsInternalArray 只看陣列；Error Prone ImmutableMemberCollection 反而對 Java 21 符合範例報「prefer Immutable types」，屬誤報，不採用；；實證版本：17、21。 來源：inventory-inv-claude-b.yml 第 1 筆（JV-CO-001）。 |
| 區分不可修改與不可變快照 | rules/stacks/java/common/collections-and-ownership.md#java-snapshots-and-views | error | 違反範例 List.copyOf(source)／source.reversed() 是否算隔離快照，取決於元素型別是否可變與契約宣稱；PMD／SpotBugs／Error Prone 對違反範例皆無報；可借用 Error Prone Java8ApiChecker 擋住 Java 8 目標使用 copyOf／toList()（屬版本政策文件範圍，非本節語意）；；實證版本：17、8、11、21。 來源：inventory-inv-claude-b.yml 第 2 筆（JV-CO-002）。 |
| 順序與重複資料 | rules/stacks/java/common/collections-and-ownership.md#java-order-and-duplicates | error | 選用 List／Set／Map 是否符合契約的順序與重複語意、Java 11 的 Set.of／Map.of 不承載順序契約、Java 21 SequencedCollection 的重複值契約，皆需對照契約人工審查；；實證版本：17、21。 來源：inventory-inv-claude-b.yml 第 4 筆（JV-CO-004）。 |
| 複合操作的原子性 | rules/stacks/java/common/collections-and-ownership.md#java-compound-atomicity | error | 跨鍵、多集合或多步驟操作是否需要原子性，取決於契約；工具只能抓單一 Map 的 check-then-act 樣式；；實證版本：17。 來源：inventory-inv-claude-b.yml 第 10 筆（JV-CO-010）。 |
| 限制資料累積 | rules/stacks/java/common/collections-and-ownership.md#java-bounded-accumulation | error | Iterator 或非 Stream 來源是否有界、分組／去重的保留資料成本是否可接受，需依資料規模契約人工核對；；實證版本：17、8、11。 來源：inventory-inv-claude-b.yml 第 13 筆（JV-CO-013）。 |
| 批次修改的失敗保證 | rules/stacks/java/common/collections-and-ownership.md#java-batch-failure-state | error | 違反與符合都呼叫 replaceAll，差別只在是否先複製；「約定失敗時值不變」寫在 Javadoc，工具無法得知契約；PMD ImmutableField 對違反範例報 values 可為 final，屬無關雜訊；；實證版本：17、8。 來源：inventory-inv-claude-b.yml 第 16 筆（JV-CO-016）。 |
| 明確的故障分類 | rules/stacks/java/common/exceptions-and-resources.md#java-exception-classification | error | 「既有標準例外足以表達時不強制自訂」「不將預期業務失敗改用例外表示」「不改變故障語意」屬契約判斷；；實證版本：17、8。 來源：inventory-inv-claude-b.yml 第 25 筆（JV-ER-006）。 |
| Checked 與 Unchecked 的選擇 | rules/stacks/java/common/exceptions-and-resources.md#java-checked-unchecked | error | 違反範例（包成 UncheckedIOException 再 getCause 處理）語法與慣用寫法皆合法，是否「只為省略宣告」只能由契約判斷；PMD／Checkstyle／SpotBugs／Error Prone（含全部關閉檢查）對違反範例皆無相關報告（僅 SystemPrintln／Varifier 等雜訊）；；實證版本：17、8。 來源：inventory-inv-claude-b.yml 第 26 筆（JV-ER-007）。 |
| 捕捉範圍與處置相符 | rules/stacks/java/common/exceptions-and-resources.md#java-catch-scope | error | 「不得將不同來源的故障一律轉成同一業務結果」「不得假裝恢復成功」「縮小 try 範圍」需對照處置責任人工審查；工具只能抓捕捉型別太廣；；實證版本：17、8。 來源：inventory-inv-claude-b.yml 第 32 筆（JV-ER-012）。 |
| 保留中斷意圖 | rules/stacks/java/common/exceptions-and-resources.md#java-interruption | error | 「不得自動重試」「必要清理不得掩蓋中斷意圖」「依明確取消契約處理」需人工核對；；實證版本：17。 來源：inventory-inv-claude-b.yml 第 37 筆（JV-ER-017）。 |
| 優先使用語言資源管理機制 | rules/stacks/java/common/exceptions-and-resources.md#java-resource-management | error | 「借用或框架管理的資源不得擅自關閉」「其他生命週期須明訂釋放方式」「Java 21 共享 ExecutorService／HttpClient 不得在單次請求結束時關閉」屬所有權契約，工具無法判斷誰擁有資源；；實證版本：17、8、11、21。 來源：inventory-inv-claude-b.yml 第 41 筆（JV-ER-021）。 |
| 保留操作與清理失敗 | rules/stacks/java/common/exceptions-and-resources.md#java-suppressed-failures | error | 自行清理時是否維持故障關係（addSuppressed）、單獨清理失敗的完成判定與回報方式，需依資源契約人工審查；；實證版本：17、8、11。 來源：inventory-inv-claude-b.yml 第 47 筆（JV-ER-027）。 |
| 有效期與關閉契約 | rules/stacks/java/common/exceptions-and-resources.md#java-resource-close-contract | error | 「不無依據假設 close() 可重複呼叫」、Java 8／11 的 shutdown／awaitTermination 契約、Java 21 close() 無逾時等版本差異為執行期語意，規範亦註明範例不驗證；；實證版本：17。 來源：inventory-inv-claude-b.yml 第 49 筆（JV-ER-029）。 |
| 明訂比較語意 | rules/stacks/java/common/equality-hashing-ordering.md#java-comparison-semantics | error | 哪些欄位屬於約定的識別語意無法由程式碼得知；所有工具對違反範例只有無關雜訊（PMD UnusedPrivateField、SpotBugs URF_UNREAD_FIELD 反而出現在符合範例）；；實證版本：17、8。 來源：inventory-inv-claude-b.yml 第 53 筆（JV-EH-001）。 |
| 雜湊集合中的穩定性 | rules/stacks/java/common/equality-hashing-ordering.md#java-hash-collection-stability | error | 違反範例在 add 之後 key.set(0, 2)，需跨敘述追蹤「此物件目前是雜湊集合成員」，PMD／SpotBugs／Error Prone 皆無此分析（實測僅 UC_USELESS_OBJECT 雜訊，且同時出現於符合範例）；Error Prone ImmutableMemberCollection 對 Java 17 符合範例（record Key 已防禦複製）報建議改用 Guava Immutable 型別，屬誤報；；實證版本：17、8、11。 來源：inventory-inv-claude-b.yml 第 59 筆（JV-EH-007）。 |
| Entity 識別碼的生命週期 | rules/stacks/java/common/equality-hashing-ordering.md#java-entity-identity-lifecycle | error | 是否有跨實例相等需求、識別碼配發時機與集合使用期間是否重疊，需人工對照 ORM／領域設計；；實證版本：17。 來源：inventory-inv-claude-b.yml 第 61 筆（JV-EH-009）。 |
| 跨型別相等範圍 | rules/stacks/java/common/equality-hashing-ordering.md#java-cross-type-equality | error | 依契約決定哪些具體型別可相等、新增子型別或欄位時是否仍對稱遞移，需人工審查與測試（acceptance-java-cross-type-equality）；；實證版本：17、8。 來源：inventory-inv-claude-b.yml 第 66 筆（JV-EH-014）。 |
| 自然順序與情境排序 | rules/stacks/java/common/equality-hashing-ordering.md#java-ordering-choice | error | 自然順序是否「明確且普遍適用」屬領域判斷；違反範例在語法與契約形式上與一般 Comparable 實作無異，所有工具無報；；實證版本：17、8。 來源：inventory-inv-claude-b.yml 第 67 筆（JV-EH-015）。 |
| 比較關係一致 | rules/stacks/java/common/equality-hashing-ordering.md#java-comparator-relations | error | 方向一致、遞移性、同次排序不依賴持續變動的時間／設定／外部查詢，需測試與審查（acceptance-java-comparator-relations）；；實證版本：17。 來源：inventory-inv-claude-b.yml 第 70 筆（JV-EH-018）。 |
| 比較為零與相等性 | rules/stacks/java/common/equality-hashing-ordering.md#java-sorted-key-equivalence | error | TreeSet／TreeMap 的比較器是否該加入次要識別依據，取決於「集合是否須保留不同訂單」的契約；違反與符合只差 thenComparingLong，工具無法判定；；實證版本：17、8。 來源：inventory-inv-claude-b.yml 第 72 筆（JV-EH-020）。 |
| 排序集合中的穩定性 | rules/stacks/java/common/equality-hashing-ordering.md#java-sorted-collection-stability | error | 同 java-hash-collection-stability：需跨敘述追蹤物件是否為排序集合成員；所有工具無報；；實證版本：17。 來源：inventory-inv-claude-b.yml 第 73 筆（JV-EH-021）。 |
| 依語意選擇數值型別 | rules/stacks/java/common/numbers-dates-text.md#java-numeric-representation | error | record Amount(double value) 是否違反，取決於契約是否要求精確十進位；以欄位／型別名稱（amount、price、money）配 double 的名稱啟發式可寫成 XPath，但誤報高且會被繞過，不建議列為工具規則；所有工具對違反範例無報；；實證版本：17、8。 來源：inventory-inv-claude-b.yml 第 77 筆（JV-ND-001）。 |
| 從精確來源建立 | rules/stacks/java/common/numbers-dates-text.md#java-exact-numeric-sources | error | 「建立後仍須驗證業務限制」需對照契約；；實證版本：17。 來源：inventory-inv-claude-b.yml 第 81 筆（JV-ND-005）。 |
| 明訂捨入規則 | rules/stacks/java/common/numbers-dates-text.md#java-rounding-policy | error | 捨入時機與由哪個元件負責屬設計契約；；實證版本：17。 來源：inventory-inv-claude-b.yml 第 83 筆（JV-ND-007）。 |
| 範圍與轉換檢查 | rules/stacks/java/common/numbers-dates-text.md#java-numeric-range-checks | error | Java 21 Math.clamp 是否掩蓋超限、小數捨棄是否可接受，依契約判斷；；實證版本：17、21。 來源：inventory-inv-claude-b.yml 第 87 筆（JV-ND-011）。 |
| BigDecimal 判同語意 | rules/stacks/java/common/numbers-dates-text.md#java-decimal-equivalence | error | 1.0 與 1.00 是否相同屬契約；工具只能抓「排序與相等明顯不一致」的樣式；；實證版本：17、8。 來源：inventory-inv-claude-b.yml 第 91 筆（JV-ND-015）。 |
| 依業務語意選擇時間型別 | rules/stacks/java/common/numbers-dates-text.md#java-temporal-representation | error | LocalDateTime 是否被當成唯一時點只能由業務語意判斷；以欄位名稱（*At、timestamp）配 LocalDateTime 的啟發式誤報高，不建議；；實證版本：17、8。 來源：inventory-inv-claude-b.yml 第 94 筆（JV-ND-018）。 |
| 區分時間長度與日曆規則 | rules/stacks/java/common/numbers-dates-text.md#java-durations-calendar-periods | error | 營業日、時區缺口／重疊處理等業務日曆規則需人工審查；；實證版本：17。 來源：inventory-inv-claude-b.yml 第 97 筆（JV-ND-021）。 |
| 可控制的時間基準 | rules/stacks/java/common/numbers-dates-text.md#java-clock-source | error | 耗時與等待期限是否使用單調來源、Clock 是否真的從外部注入到實際取時路徑，需審查與測試（acceptance-java-clock-injection）；；實證版本：17。 來源：inventory-inv-claude-b.yml 第 101 筆（JV-ND-025）。 |
| 解析與輸出契約 | rules/stacks/java/common/numbers-dates-text.md#java-temporal-parsing-formatting | error | 時區／偏移與精度是否符合契約、Java 9+ CLDR 地區資料造成的輸出差異（規範註明執行期差異，範例不驗證）需人工核對既有資料；；實證版本：17。 來源：inventory-inv-claude-b.yml 第 106 筆（JV-ND-030）。 |
| 長度與截取單位 | rules/stacks/java/common/numbers-dates-text.md#java-text-length-units | error | substring／length() 是否作用於使用者可見的 Unicode 文字屬語意；全面禁用 String.substring／length 誤報極高；所有工具對違反範例無報；；實證版本：17。 來源：inventory-inv-claude-b.yml 第 107 筆（JV-ND-031）。 |
| 統一管理執行資源 | rules/stacks/java/common/concurrency-and-async.md#java-execution-resources | error | 資源擁有者、框架容許建立點及下游容量須依架構審查；語法僅能找出直接建立 Thread；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 1 筆（JV-CA-003）。 |
| 可見性與共享資料 | rules/stacks/java/common/concurrency-and-async.md#java-visibility-sharing | error | 跨執行緒交付、整體物件不變條件與原子範圍需設計審查；volatile 遞增只是可辨識子模式；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 2 筆（JV-CA-005）。 |
| `Future` 與 `CompletableFuture` 的結果鏈 | rules/stacks/java/common/concurrency-and-async.md#java-result-reception | error | exceptionally 的常數替代值是否是核准降級取決於契約；禁止整個 API 會誤報合法恢復；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 5 筆（JV-CA-008）。 |
| 鎖定範圍與取得策略 | rules/stacks/java/common/concurrency-and-async.md#java-lock-scope | error | SpotBugs 僅涵蓋漏解鎖；必要檢查是否位於正確原子範圍及鎖取得策略仍須依不變條件審查；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 9 筆（JV-CA-013）。 |
| 可控制的併發驗收 | rules/stacks/java/common/concurrency-and-async.md#java-controlled-verification | error | 測試是否控制交錯且驗證實際結果須審查；禁測試中的固定 sleep 只能涵蓋一個常見錯誤模式；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 11 筆（JV-CA-016）。 |
| 明確需求與型別契約 | rules/stacks/java/common/reflection-and-suppression.md#java-dynamic-type-contract | error | 必要性、責任元件及業務邊界沒有通用可推導定義；全面禁止反射不符合允許受控整合的條文；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 14 筆（JV-RS-001）。 |
| 維持封裝與不變條件 | rules/stacks/java/common/reflection-and-suppression.md#java-reflective-encapsulation | error | Field 寫入是否繞過建立不變條件、特殊存取是否獲准，須依領域驗證及例外紀錄審查；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 15 筆（JV-RS-003）。 |
| 區分故障與執行結果 | rules/stacks/java/common/reflection-and-suppression.md#java-reflection-failure | error | 保留原因鏈可局部檢查；反射存取故障、目標業務結果與失敗分類仍須依契約審查；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 17 筆（JV-RS-006）。 |
| 限定檢查抑制 | rules/stacks/java/common/reflection-and-suppression.md#java-warning-suppression | error | 核准原因、具體規則與最小必要範圍需審查；自訂規則只抓非 Serializable 類別上的 serial 抑制；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 18 筆（JV-RS-009）。 |
| 產生碼不擴大豁免 | rules/stacks/java/common/reflection-and-suppression.md#java-generated-code | error | 來源可重建性、產生碼與手寫銜接邊界、排除範圍及真實型別契約須審查並重建驗證；一般受檢查轉型不會產生 unchecked 警告；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 19 筆（JV-RS-010）。 |
| 分別記錄版本資訊 | rules/stacks/java/common/version-policy.md#java-version-declarations | error | 建置／目標／API／執行承諾的文件完整性及函式庫使用端契約，不能由 requireJavaVersion 一項推斷；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 23 筆（JV-VP-002）。 |
| 建置設定落實限制 | rules/stacks/java/common/version-policy.md#java-build-compatibility | error | 須審查受控建置設定、本機與 CI 一致性及 compiler 實際參數；--release 的負向案例另附補充實驗；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 24 筆（JV-VP-005）。 |
| 版本宣告與相容性補充說明 | rules/stacks/java/common/version-policy.md#java-group-notes-version-declarations | error | 此為前述要求的情境說明，沒有新增可獨立檢查的 Java 語法規則；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 27 筆（JV-VP-008）。 |
| 依賴版本要求 | rules/stacks/java/common/version-policy.md#java-dependency-versions | error | 依賴版本上限／最低 JDK 及超出承諾時的處置需依套件資料審查；版本收斂本身不保證 Java 相容；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 28 筆（JV-VP-012）。 |
| 建置升級與支援範圍變更 | rules/stacks/java/common/version-policy.md#java-build-upgrade | error | 使用端影響、回退需求、通知及支援範圍決策是變更治理資料，不存在通用程式語法規則；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 29 筆（JV-VP-013）。 |
| Preview 功能 | rules/stacks/java/common/version-policy.md#java-preview-features | error | 核准、用途、維護責任及部署配套需審查；不加 --enable-preview 可阻擋語法/API，但不能判定是否獲准；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 30 筆（JV-VP-015）。 |
| JDK 內部實作與存取限制 | rules/stacks/java/common/version-policy.md#java-jdk-internals | error | 需核對例外核准、依賴、--add-opens／--add-exports 及升級重驗；靜態依賴分析不看見字串反射；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 31 筆（JV-VP-018）。 |
| 棄用 API | rules/stacks/java/common/version-policy.md#java-deprecated-api | error | 工具僅辨識棄用／移除狀態；相容替代方案、既有遷移安排與核准適用範圍仍需審查；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 32 筆（JV-VP-022）。 |
| 依賴、升級與特殊功能補充說明 | rules/stacks/java/common/version-policy.md#java-group-notes-dependency-versions | error | 此為例外治理與漸進導入引用，須核對治理紀錄，不是新的程式規則；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 33 筆（JV-VP-023）。 |
| JDK 發行商與完整版本 | rules/stacks/java/common/version-policy.md#java-jdk-distribution | error | 須保留發行商、完整修補版本及設定，並核對變更測試紀錄；版本數字檢查不涵蓋行為；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 35 筆（JV-VP-025）。 |
| 產物與執行環境追溯 | rules/stacks/java/common/version-policy.md#java-artifact-traceability | error | 發布產物識別、建置來源與實際部署環境關聯需發布流程紀錄；本次未指定任何專案發布系統；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 36 筆（JV-VP-026）。 |
| 支援版本與主範例基線 | rules/stacks/java/common/version-policy.md#java-example-baseline | error | 版本差異不得改變要求是規範語意審查；範例 --release 可驗證語法/API 但不驗證需求等價；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 37 筆（JV-VP-027）。 |
| 新版本納入與版本退場 | rules/stacks/java/common/version-policy.md#java-version-lifecycle | error | 納入與退場是影響盤點、工具鏈驗證及支援決策，不能僅依 JDK 最新版自動更新；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 38 筆（JV-VP-028）。 |
| 版本差異索引 | rules/stacks/java/common/version-policy.md#java-version-differences-index | warn | 此為版本差異索引，需核對連結與摘要語意；不是新增 Java 靜態規則；未宣稱執行完整驗收；verified 為不適用。 來源：inventory-inv-codex-b.yml 第 39 筆（JV-VP-029）。 |
