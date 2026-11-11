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
java -jar /path/to/spotbugs-4.8.6/lib/spotbugs.jar -textui -effort:max -low \
  -include vendor/dev-rule/tools/java/spotbugs/include.xml \
  -exclude vendor/dev-rule/tools/java/spotbugs/exclude.xml \
  -auxclasspath "$DEPENDENCY_CLASSPATH" -xml:withMessages -output spotbugs.xml target/classes
```

`-low` 必須保留，否則 REC／THROWS 等低優先模式可能不輸出。不要只用退出碼判斷沒有違規：未加 `-exitcode` 時成功產出報告可仍有 BugInstance。CI 應讀取 XML，檢查 Errors／MissingClass，依 rule-map 的 error／warn 決定阻擋；若使用 `-exitcode`，其 bitmask 同時包含違規、缺失類別與分析錯誤，不能把非零一律視為業務違規。

Maven 可透過 SpotBugs plugin 的 `includeFilterFile`／`excludeFilterFile` 接入，並明確鎖定 core 4.8.6；Gradle 透過既有 SpotBugs plugin 的 `toolVersion`、`includeFilter`、`excludeFilter` 接入。外掛本身版本須由專案固定並驗證，不讓外掛預設版本悄悄覆蓋上述 core。ZIP 可用 JDK `jar xf` 展開；消費端不需要 Ruby／Python。

## 規範診斷

SpotBugs 原生訊息不能覆寫。`pattern-map.properties` 將 pattern 對應到 `[JV-…] 標題 → rules/…#錨點`，可由 Java `Properties.load(InputStream)` 直接載入；非 ASCII 字元使用標準 Unicode escape。XML 每個 BugInstance 的 `type` 作為 key；同 pattern 對多錨點以「；」保留全部，避免重複 properties key 覆蓋資料。對照表包含候選，但預設 include 不啟用候選；摘要須同時參照 rule-map 狀態與等級。

## 實證界線

本庫 `ruby tools/java/tests/run-ci-tools.rb` 逐例先以 javac 編譯，再以已校驗 ZIP 中的 SpotBugs 分析；只計指定 pattern，缺失類別／工具錯誤非零退出。候選在此驗收明確載入，目的是記錄漏報與誤報，不表示正式啟用。partial 的 zero findings 不能當成條文已通過，尤其深層不可變性、複合原子操作及數值縮窄需要其他驗證。
