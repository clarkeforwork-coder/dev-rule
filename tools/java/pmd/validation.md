# PMD 7.29.0 驗收紀錄

日期：2026-11-11。來源／SHA-256 見 [README](README.md)。實測執行期為 `<TMP>/java-versions-phase0/jdk-21.0.13+9/Contents/Home` 的 JDK 21.0.13+9；PMD 解壓於 `<TMP>/dev-rule-pmd/pmd-bin-7.29.0`。依範例標記以 `--use-version` 分組解析 Java 8、11、17、21，沒有宣稱完成四個 JDK 執行期矩陣。

抽取 15 份文件的 319 個範例：Java 8＝57、11＝15、17＝232、21＝15；原始規範程式與 import 未改寫，XPath 與 rule-map 逐字一致。75 筆映射的訊息前綴、URL、優先序及所有自訂 XPath 已以 REXML／YAML 核對。預設集合的 4 次 PMD 執行皆無 processingErrors／configurationErrors；候選集合另以一個 Java 17 範例做載入檢查，兩種錯誤亦皆為空，這不是候選語意驗收。

相同規則的多筆映射以規範 ID 後綴分開，以免 PMD 覆蓋同名設定；各筆優先序獨立保存，`UseTryWithResources` 的 warn／error 沒有合併成同一等級。候選檔沒有預設引用；相同內建規則若另有 verified 映射（例如 OverrideBothEqualsAndHashcode），只啟用該非候選映射。

嚴格驗收結束碼 **1**。待協調者裁決的兩筆：

- `JV-LS-013 ParallelStreamUsage`：對照表列 verified，但原小節沒有正反規範範例；note 明記證據來自合成範例。沒有把缺少案例當作通過，也沒有新增／修改規範範例。
- `JV-ND-009 NarrowingPrimitiveCast`：Java 17 違反命中、符合乾淨；Java 21 違反使用 Math.clamp，沒有縮窄轉型，所以原 XPath 不命中。note 已記載此限制，嚴格逐例驗收下應由協調者決定調整映射狀態或驗收政策，不能僅為綠燈將所有 Math.clamp 判為違規。

其餘 verified 47 筆通過，partial 16 筆按要求僅報告。未改 rule-map，未調整任何 XPath。沒有其他待決技術選擇；專案採用時的精確來源集、例外白名單與核准仍依 suppressions.md 處理。

負向控制：傳入 `--pmd /usr/bin/true`（無 PMD 版本字串）會以結束碼 1 拒絕，不會把空輸出視為成功。重建規則集後的檔案內容一致。

重現命令：

```sh
JAVA_HOME=<TMP>/java-versions-phase0/jdk-21.0.13+9/Contents/Home \
  ruby tools/java/tests/run-pmd.rb \
  --pmd <TMP>/dev-rule-pmd/pmd-bin-7.29.0/bin/pmd \
  --output <TMP>/dev-rule-pmd/run-final
```

完整標準輸出如下（原始 PMD JSON／log 位於列出的暫存目錄）：

```text
工具：PMD 7.29.0 (47b3135b2cdd4afa0b4447da91786497b58bc10b, 2026-10-30T08:20:47Z)
範例與原始報告：<TMP>/dev-rule-pmd/run-final
抽取：319 個範例，15 份文件
通過 JV-TG-002 UseExplicitTypes：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0
部分（僅報告） JV-TG-005 RawGenericType_JV_TG_005：violation-1-java17=0、compliant-1-java17=0、compliant-1-java8=0
  violation-1-java17 預期命中，實際 0
通過 JV-TG-007 GenericMethodReturnsObject：violation-1-java17=1、compliant-1-java17=0
通過 JV-TG-009 DowncastFromObject：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0、violation-2-java17=1
通過 JV-TG-014 NoSuppressTypeSafetyWarnings：violation-1-java17=2、compliant-1-java17=0
通過 JV-TG-017 ObjectValuedDataShape：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0
通過 JV-TG-022 LooseCoupling：violation-1-java17=1、compliant-1-java17=0、compliant-1-java21=0
通過 JV-TG-025 RawGenericType_JV_TG_025：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0、compliant-1-java11=0
通過 JV-TG-026 UnboundedWildcardReturnType：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0、compliant-1-java11=0
通過 JV-LS-004 NoInferredLambdaParameterType：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0、violation-1-java11=1
通過 JV-LS-007 StreamPeekUsage：violation-1-java17=1、compliant-1-java17=0
通過 JV-LS-009 ForEachAccumulatesExternalState：violation-1-java17=1、compliant-1-java17=0、compliant-2-java17=0
失敗 JV-LS-013 ParallelStreamUsage：
  缺少 violation 規範範例
  缺少 compliant 規範範例
通過 JV-LS-016 LambdaCatchWithoutRethrow：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0
通過 JV-LS-018 StreamVariableReused：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0
通過 JV-NP-015 ClassNamingConventions：violation-1-java17=1、compliant-1-java17=0
通過 JV-NP-016 FieldNamingConventions：violation-1-java17=1、compliant-1-java17=0
通過 JV-NP-019 MethodNamingConventions：violation-1-java17=1、compliant-1-java17=0
通過 JV-CC-003 ConstructorCallsOverridableMethod：violation-1-java17=1、compliant-1-java17=0
部分（僅報告） JV-CC-006 MutableStaticState：violation-1-java17=1、compliant-1-java17=0
通過 JV-NO-001 ReturnEmptyCollectionRatherThanNull：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0
部分（僅報告） JV-NO-003 OptionalReturnNull：violation-1-java17=1、compliant-1-java17=0
部分（僅報告） JV-SR-008 EnumDefaultHidesCases：violation-1-java17=1、compliant-1-java17=0、compliant-1-java11=0、compliant-1-java21=0
部分（僅報告） JV-SR-010 EnumOrdinalAtBoundary：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0
通過 JV-CO-003 ListFromHashSetLosesOrder：violation-1-java17=1、compliant-1-java17=0、compliant-1-java21=0
部分（僅報告） JV-CO-006 CatchConcurrentModification：violation-1-java17=0、compliant-1-java17=0
  violation-1-java17 預期命中，實際 0
通過 JV-CO-007 ModifyCollectionInForeach：violation-1-java17=1、compliant-1-java17=0
通過 JV-CO-008 ConcurrentMapCheckThenAct：violation-1-java17=1、compliant-1-java17=0
通過 JV-CO-011 SortedBeforeLimit：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0、compliant-1-java11=0
通過 JV-CO-012 UnboundedStreamStatefulOp：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0、compliant-1-java11=0
通過 JV-CO-015 LazyStreamReturnedFromTryWithResources：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0
部分（僅報告） JV-ER-002 PreserveStackTrace_JV_ER_002：violation-1-java17=0、compliant-1-java17=0、compliant-1-java8=0
  violation-1-java17 預期命中，實際 0
部分（僅報告） JV-ER-003 AvoidThrowingRawExceptionTypes：violation-1-java17=0、compliant-1-java17=0、compliant-1-java8=0
  violation-1-java17 預期命中，實際 0
通過 JV-ER-004 SignatureDeclareThrowsException：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0
通過 JV-ER-009 AvoidCatchingGenericException：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0
通過 JV-ER-015 EmptyCatchBlock：violation-1-java17=1、compliant-1-java17=0
通過 JV-ER-016 SwallowedInterruptedException：violation-1-java17=1、compliant-1-java17=0
部分（僅報告） JV-ER-018 UseTryWithResources_JV_ER_018：violation-1-java17=0、compliant-1-java17=0、compliant-1-java8=0、compliant-1-java11=0、compliant-1-java21=0
  violation-1-java17 預期命中，實際 0
通過 JV-ER-019 CloseResource：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0、compliant-1-java11=0、compliant-1-java21=0
通過 JV-ER-024 UseTryWithResources_JV_ER_024：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0、compliant-1-java11=0
部分（僅報告） JV-ER-025 DoNotThrowExceptionInFinally：violation-1-java17=0、compliant-1-java17=0、compliant-1-java8=0、compliant-1-java11=0
  violation-1-java17 預期命中，實際 0
部分（僅報告） JV-ER-026 ReturnFromFinallyBlock：violation-1-java17=0、compliant-1-java17=0、compliant-1-java8=0、compliant-1-java11=0
  violation-1-java17 預期命中，實際 0
通過 JV-ER-028 ResourceCapturedByAsyncTask：violation-1-java17=1、compliant-1-java17=0
部分（僅報告） JV-EH-004 OverrideBothEqualsAndHashcode_JV_EH_004：violation-1-java17=0、compliant-1-java17=0、compliant-1-java8=0、compliant-2-java17=0
  violation-1-java17 預期命中，實際 0
通過 JV-EH-008 IdentityEqualsWithStateHashCode：violation-1-java17=1、compliant-1-java17=0
通過 JV-EH-012 OverrideBothEqualsAndHashcode_JV_EH_012：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0、compliant-2-java17=0
通過 JV-EH-017 ComparatorBySubtraction：violation-1-java17=1、compliant-1-java17=0
部分（僅報告） JV-EH-019 OverrideBothEqualsAndHashCodeOnComparable：violation-1-java17=0、compliant-1-java17=0、compliant-1-java8=0
  violation-1-java17 預期命中，實際 0
通過 JV-ND-003 AvoidDecimalLiteralsInBigDecimalConstructor：violation-1-java17=1、compliant-1-java17=0
通過 JV-ND-004 BigDecimalFromFloatingPoint：violation-1-java17=1、compliant-1-java17=0
部分（僅報告） JV-ND-006 BigDecimalWithoutRoundingMode：violation-1-java17=0、compliant-1-java17=0
  violation-1-java17 預期命中，實際 0
失敗 JV-ND-009 NarrowingPrimitiveCast：violation-1-java17=1、compliant-1-java17=0、violation-1-java21=0
  violation-1-java21 預期命中，實際 0
通過 JV-ND-014 ComparableBigDecimalRecordEqualsMismatch：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0
部分（僅報告） JV-ND-017 ReplaceJavaUtilDate：violation-1-java17=0、compliant-1-java17=0、compliant-1-java8=0
  violation-1-java17 預期命中，實際 0
通過 JV-ND-020 DurationUsedForCalendarDay：violation-1-java17=1、compliant-1-java17=0
通過 JV-ND-024 NowWithoutClock：violation-1-java17=1、compliant-1-java17=0、compliant-2-java17=0
部分（僅報告） JV-ND-027 SimpleDateFormatNeedsLocale：violation-1-java17=0、compliant-1-java17=0
  violation-1-java17 預期命中，實際 0
通過 JV-ND-028 DateTimeFormatterPatternNotStrict：violation-1-java17=1、compliant-1-java17=0
通過 JV-ND-029 LenientDateTimeResolver：violation-1-java17=1、compliant-1-java17=0
通過 JV-CA-002 NoUnmanagedThread：violation-1-java17=1、compliant-1-java17=0、compliant-1-java21=0
通過 JV-CA-015 NoFixedSleepInConcurrencyTest：violation-1-java17=1、compliant-1-java17=0、compliant-1-java21=0
通過 JV-RS-002 ReviewReflectiveFieldWrite：violation-1-java17=1、compliant-1-java17=0
通過 JV-RS-005 PreserveStackTrace_JV_RS_005：violation-1-java17=1、compliant-1-java17=0
通過 JV-RS-008 MisplacedSerialSuppression：violation-1-java17=1、compliant-1-java17=0、compliant-1-java8=0、compliant-1-java11=0
通過 JV-VP-017 AvoidAccessibilityAlteration：violation-1-java17=1、compliant-1-java17=0
總結：verified 通過 47／失敗 2；partial 16 筆（不計失敗）；工具錯誤 0

```
