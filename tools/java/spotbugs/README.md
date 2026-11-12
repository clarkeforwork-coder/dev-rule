# SpotBugs 檢查

固定 SpotBugs 4.8.6；`../profiles/jdk*.env` 記錄 Maven Central ZIP 的 URL 與 SHA-256。[4.8.6 官方 README](https://github.com/spotbugs/spotbugs/blob/4.8.6/README.md)要求執行 JDK 8 以上，本庫分別驗證 8／11／17／21 啟動與分析，主規範範例以 17／21 完整重跑。執行期支援不等於每個條文在每個來源版本都有原正反例。

`include.xml` 僅啟用 rule-map 的 verified／partial bug pattern；`include-candidates.xml` 是明確隔離的失敗候選，消費端不載入。`exclude.xml` 預設為空，避免測試或產生碼擴大豁免；核准人、原因、ID、精確位置與重驗條件須先依治理流程記錄，再加入例如：

```xml
<FindBugsFilter>
  <!-- 僅示範；替換成已核准的完整類別與方法，禁止直接套用整個 test package。 -->
  <Match>
    <Class name="example.ApprovedFixture"/>
    <Method name="intentionalLeak"/>
    <Bug pattern="OS_OPEN_STREAM_EXCEPTION_PATH"/>
  </Match>
</FindBugsFilter>
```

建置後對 class 目錄執行（完整 dependency classpath 以 `-auxclasspath` 提供）：

```sh
java -jar /path/to/spotbugs-4.8.6/lib/spotbugs.jar -textui -effort:default -low \
  -include vendor/dev-rule/tools/java/spotbugs/include.xml \
  -exclude vendor/dev-rule/tools/java/spotbugs/exclude.xml \
  -auxclasspath "$DEPENDENCY_CLASSPATH" -xml:withMessages -output spotbugs.xml target/classes
```

`-low` 必須保留，否則 REC／THROWS 等低優先模式可能不輸出。不要只用退出碼判斷沒有違規：未加 `-exitcode` 時成功產出報告可仍有 BugInstance。CI 應讀取 XML，檢查 Errors／MissingClass，依 rule-map 的 error／warn 決定阻擋；若使用 `-exitcode`，其 bitmask 同時包含違規、缺失類別與分析錯誤，不能把非零一律視為業務違規。

使用 [Maven 正式片段](../ci/maven/pom-fragment.xml) 的 threshold=Low／effort=Max，或 [Gradle 正式片段](../ci/gradle/rules.gradle.kts) 的 JavaExec（-low／-effort:max）；Gradle 不使用額外 SpotBugs plugin。兩者固定 core 4.8.6，經 SpotbugsSummary 依 pattern-map 的 `.level` 判定：warn 只列出，error 才阻擋。消費端不需要 Ruby／Python。

## 規範診斷

SpotBugs 原生訊息不能覆寫。`pattern-map.properties` 將 pattern 對應到 `[JV-…] 標題 → rules/…#錨點`，可由 Java `Properties.load(InputStream)` 直接載入；非 ASCII 字元使用標準 Unicode escape。XML 每個 BugInstance 的 `type` 作為 key；同 pattern 對多錨點以「；」保留全部，避免重複 properties key 覆蓋資料。對照表包含候選，但預設 include 不啟用候選；`.level` 保存規範等級並由一致性檢查與 rule-map 比對。

## 實證界線

本庫 `ruby tools/java/tests/run-ci-tools.rb` 逐例先以 javac 編譯，再以已校驗 ZIP 中的 SpotBugs 分析；只計指定 pattern，缺失類別／工具錯誤非零退出。候選在此驗收明確載入，目的是記錄漏報與誤報，不表示正式啟用。partial 的 zero findings 不能當成條文已通過，尤其深層不可變性、複合原子操作及數值縮窄需要其他驗證。

## effort 比較

以 JDK 17.0.19、SpotBugs 4.8.6 重跑 `tests/run-ci-tools.rb` 的 16 筆 SpotBugs 映射（包含 candidate），只變更 effort：default 與 max 的逐例命中結果完全相同，皆為 8 筆正反例通過、0 筆工具錯誤／verified 回歸。建議新接入使用 default；目前正式 Maven／Gradle 片段仍保留 Max，收尾時可同步調整。

| default 與 max 皆命中違反例，且符合例無誤報 | 兩者皆未命中原違反例 |
| --- | --- |
| NM_METHOD_NAMING_CONVENTION | EI_EXPOSE_REP（2 筆映射） |
| MC_OVERRIDABLE_METHOD_CALL_IN_CONSTRUCTOR | EI_EXPOSE_REP2（2 筆映射） |
| NP_OPTIONAL_RETURN_NULL | AT_OPERATION_SEQUENCE_ON_CONCURRENT_ABSTRACTION |
| REC_CATCH_EXCEPTION | THROWS_METHOD_THROWS_CLAUSE_BASIC_EXCEPTION |
| OS_OPEN_STREAM_EXCEPTION_PATH | HE_EQUALS_NO_HASHCODE |
| EQ_OVERRIDING_EQUALS_NOT_SYMMETRIC | ICAST_INTEGER_MULTIPLY_CAST_TO_LONG |
| VO_VOLATILE_INCREMENT | |
| UL_UNRELEASED_LOCK | |

本組範例沒有需要 max 才命中的 pattern；未命中的 partial／candidate 並未因 max 改善，不能宣稱所有映射都可命中，也不能外推到其他專案程式形狀。`-low` 仍須保留。
