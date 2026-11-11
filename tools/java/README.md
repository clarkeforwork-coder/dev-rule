# Java 自動檢查工具

已實作 pre-commit 層：PMD 7.29.0 與 Checkstyle 共用 [rule-map.yml](rule-map.yml) 的條文 ID，hook 只阻擋 staged 新增／修改行的 error，warn 列出但不阻擋。候選規則獨立存放，不啟用。IDE 與完整 CI 層仍待後續實作。

## 專案接入

先把包含本目錄的已審查 revision 固定在 `vendor/dev-rule`，不要追蹤浮動分支。需要 Bash 3.2+（已在 macOS Bash 3.2／UTF-8 語系驗證）、Git、curl、SHA-256 工具及 JDK；首次下載後可使用已校驗的離線快取。

### 安裝 Git hook

在使用端專案根目錄執行其中一項：

```sh
bash vendor/dev-rule/tools/java/hooks/install.sh --hooks-path
# 或在 Git hooks 目錄安裝啟動器（仍須保留 vendor checkout）：
bash vendor/dev-rule/tools/java/hooks/install.sh --copy
```

安裝器不覆寫非本工具的既有 hook；已有 hook 時由維護者整合。詳見 [hook 接入與快取](hooks/README.md)。

### pre-commit 框架

在 `.pre-commit-config.yaml` 加入：

```yaml
repos:
  - repo: https://github.com/clarkeforwork-coder/dev-rule
    rev: '<包含本次工具設定的已審查 commit SHA>'
    hooks:
      - id: dev-rule-java
```

把佔位值換成實際已發布 commit 後執行 `pre-commit install`；rev 使用 commit SHA；本層納入正式版本後改用 tag。hook 使用 `language: script`，忽略框架傳入的檔名、統一讀取 index；`pre-commit run --all-files` 也仍只檢查 staged Java。

### Maven／Gradle 外掛

正式 PMD 自訂規則已全部內嵌到 `pmd/ruleset.xml`，hook、Maven、Gradle 與測試使用同一檔；不再依賴相對的 `pmd/rules/`。Maven 請將 [完整 POM 片段](ci/maven/pom-fragment.xml) 的 properties、profiles、build 合併到專案 POM。核心設定如下；完整片段另鎖定各 PMD 模組版本、Checkstyle dependency 與 JDK 8 profile，不可省略：

```xml
<properties>
  <dev-rule.root>${maven.multiModuleProjectDirectory}/vendor/dev-rule</dev-rule.root>
  <checkstyle.version>10.26.1</checkstyle.version>
  <pmd.version>7.29.0</pmd.version>
</properties>
<!-- build/plugins 下的兩個外掛；dependencies 與 executions 採完整片段 -->
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-checkstyle-plugin</artifactId><version>3.6.0</version>
  <configuration>
    <configLocation>${dev-rule.root}/tools/java/checkstyle/checkstyle.xml</configLocation>
    <suppressionsLocation>${dev-rule.root}/tools/java/checkstyle/suppressions.xml</suppressionsLocation>
    <suppressionsFileExpression>checkstyle.suppressions.file</suppressionsFileExpression>
    <violationSeverity>error</violationSeverity>
  </configuration>
</plugin>
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-pmd-plugin</artifactId><version>3.28.0</version>
  <configuration>
    <rulesets><ruleset>${dev-rule.root}/tools/java/pmd/ruleset.xml</ruleset></rulesets>
    <failurePriority>2</failurePriority>
  </configuration>
</plugin>
```

修改 source／target 與規則庫路徑後執行 `mvn verify`。Gradle 專案的 `build.gradle.kts`：

```kotlin
plugins { java }
repositories { mavenCentral() }
apply(from = "vendor/dev-rule/tools/java/ci/gradle/rules.gradle.kts")
```

使用已固定 wrapper（片段以 Gradle 8.14.3 驗證），執行 `./gradlew check`。兩者檢查工作目錄整檔，不作新增行過濾；Gradle PMD 僅啟用 priority 1／2，warn 由 hook 列出。測試原始碼也受檢查。

## JDK 對照

| 執行 JDK | PMD | Checkstyle | hook 語法版本 |
| --- | --- | --- | --- |
| 8 | 7.29.0 | 9.3 | Java 8 |
| 11 | 7.29.0 | 10.26.1 | Java 11 |
| 17 | 7.29.0 | 10.26.1 | Java 17 |
| 21 | 7.29.0 | 10.26.1 | Java 21 |

hook 依 `JAVA_HOME`（否則 PATH）選 profile；JDK 11+ 使用 Checkstyle 10.26.1。本次完整範例與正式 hook 實測 JDK 8／17／21，JDK 11 profile 尚未實測。回歸工具按範例標記指定 Java 8／11／17／21 語法，這不代表在每個執行期都能編譯所有版本的 API。

## 診斷與新增違規基準

```text
Bad.java:1 [JV-NP-013] 一致的命名形式 → rules/stacks/java/common/naming-packages-docs.md#java-naming-form
```

以 `[JV-…]` 查 rule-map 的工具、等級、證據及例外限制；箭頭後為本庫文件與錨點，PMD XML 另附 GitHub 條文連結。Checkstyle error 與 PMD priority 1／2 阻擋，warning 與 priority 3／4／5 加上 `(warn)`；本庫實際採 1=error、3=warn。

基準是 HEAD 與 index 的逐檔零上下文 diff：只取新增／修改行，並按診斷起始行判斷。沒有 HEAD 時採空 tree。既有未改行的違規不擋；修改違規所在行就重新納管。檢查 staged 快照，不讀尚未暫存的 Java 修改；重新命名沿用舊 blob，刪除 Java 不啟動檢查。沒有 Java 時不啟動 JVM。

`DEV_RULE_FULL_FILE=1` 可檢查 staged 整檔，仍不掃描未 staged 檔案。這不是違規數相減，也不能保證抓到起始行未變更的跨行語意問題。工具、解析、校驗及設定錯誤一律失敗，不能被基準過濾。退出碼 0=通過／只有警告，1=新增 error，2=工具或設定錯誤。

## 抑制與例外核准

依[例外核准](../../rules/workflow/rule-governance.md#exception-approval)與[限定抑制](../../rules/workflow/rule-governance.md#suppression-scope)，先記錄核准人、ID、原因、精確範圍、補償驗證與重驗條件，再採 [PMD 抑制](pmd/suppressions.md)或 [Checkstyle SuppressionFilter](checkstyle/suppressions.md)。不得全面排除測試或產生碼。Checkstyle 不啟用任意 `@SuppressWarnings` 放行；入口層 Exception 警告 JV-ER-031 以特定 id、檔案及行號核准抑制，Throwable／Error 的 JV-ER-008 另行判定。

## 映射與涵蓋率

唯一來源是 [rule-map.yml](rule-map.yml)。ID 建立後不重編，新增取文件最大流水號加一；`rule` 為文件與錨點，`check` 為模組／規則（需區別設定時附屬性），`xpath` 僅供 PMD 自訂。`versions` 是適用版本，不代表每版實測；`note` 保留證據限制與誤報風險。來源盤點指紋與穩定 ID 對照見 [來源索引](coverage/inventory-provenance.md)。

共 15 份文件、143 個小節、308 筆映射；verified 62、partial 66、candidate 40、manual 140。只有本庫可重跑的 PMD／Checkstyle verified 小節計入涵蓋率：**43／143＝30.07%**，同小節不重複計數。21 筆尚無本庫可重跑測試的 CI 工具研究證據改列 partial；CI 層候選共 57 筆，另欄列示且不計分子。

`test` 34 筆仍為 `status: manual`，表示待實作測試責任；另有人工審查 106 筆。原始 56 筆 test 中 22 筆為驗收索引，未當作獨立規範映射；逐筆裁決記在各筆的 `note`。[涵蓋率報告](coverage/coverage.md)分開列出測試驗收與人工審查。

## 重建與驗證

```sh
ruby tools/java/pmd/build-rulesets.rb
ruby tools/java/coverage/build-coverage.rb
JAVA_HOME=/path/to/jdk tools/java/tests/run-all.sh
JAVA_HOME=/path/to/jdk tools/java/tests/run-hook-official.sh
# 規範六項檢查需要 PATH 中的 javac 21：
PATH=/path/to/jdk21/bin:$PATH ruby scripts/check-rules.rb
```

驗收需要 Ruby（含 REXML；較新 Ruby 可先 `gem install rexml`）、JDK、curl 及 SHA-256 工具。`run-all.sh` 串接唯一範例抽取器、coverage 過期檢查、雙向設定一致性、PMD、當前 JDK 對應 Checkstyle 、55 個固定合成正反例、JDK 版本解析及 Bash／UTF-8 hook 失敗回歸；各階段完整執行後彙總非零結束碼。PMD 預設使用 hook 的鎖定 JAR toolbox，也可用 `PMD_BIN` 指定 7.29.0 CLI。CI 的 java-tools job 分別使用 JDK 21、8；主規範 job 不變。

驗證輸出不入庫，執行 `run-all.sh` 即可重現（含 JDK 矩陣與 hook 每案耗時）。一次性匯入器 `coverage/merge-inventories.rb` 僅供重現首版，不可用來覆蓋後續 ID／裁決。

## 已知限制與下一期

違反範例也必須可編譯，語意違反不能靠編譯錯誤冒充；編譯由既有六項規範檢查驗證。本層不驗證執行期差異、實際併發行為、序列化契約或 API 業務語意。PMD 純 hook 缺少專案完整 classpath；正則與高風險 XPath 可能誤報，Math.clamp 檢查也無法推論業務是否允許飽和截斷。candidate 僅可在評估時明確載入，預設不啟用；partial 成功載入不等於所有子句已涵蓋。

下一期 CI 層將落地 javac lint、Error Prone、SpotBugs、ArchUnit、jdeps／Enforcer，並補足專案 classpath、建置版本約束與契約測試。Git hook 可被 `--no-verify` 略過，不能替代 CI。
