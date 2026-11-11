# Java 自動檢查工具

pre-commit 與 CI 層已實作，共用 [rule-map.yml](rule-map.yml) 的條文 ID、等級與錨點。IDE 可載入相同 PMD／Checkstyle 設定取得回饋；本庫不安裝 IDE 外掛，也不宣稱所有 IDE 具有相同診斷能力。CI 是合併門檻，不能以可略過的 hook 取代。

## 三層接入

先把已審查 commit 固定在 `vendor/dev-rule`；升級規範與工具時一併檢視 CHANGELOG、映射及基準差異。消費端 CI 使用 JDK、Maven／Gradle、git、curl 與 POSIX shell，不需要 Ruby／Python；hook 另需要 Bash 3.2+、SHA-256 工具。Ruby 僅供本庫的產生器與測試。

### IDE

在支援自訂規則的 IDE PMD／Checkstyle 外掛，分別載入 `pmd/ruleset.xml` 與 `checkstyle/checkstyle.xml`，設定 `checkstyle.suppressions.file` 為 `checkstyle/suppressions.xml` 絕對路徑，並對齊下表版本。IDE 無法提供完整 classpath 或不支援指定版本時，以建置結果為準；不要載入 candidates。Error Prone 隨正式建置編譯，SpotBugs 與 ArchUnit 隨 CI 執行。

### pre-commit

```sh
bash vendor/dev-rule/tools/java/hooks/install.sh --hooks-path
# 或 --copy：在 Git hooks 目錄安裝啟動器
```

安裝器不覆寫其他 hook。也可採 `.pre-commit-config.yaml`：

```yaml
repos:
  - repo: https://github.com/clarkeforwork-coder/dev-rule
    rev: '<已審查的完整 commit SHA>'
    hooks:
      - id: dev-rule-java
```

hook 讀取 index 快照，只阻擋 HEAD／index diff 的新增或修改行 error；warning 不擋，沒有 Java 變更就不啟動 JVM。`DEV_RULE_FULL_FILE=1` 檢查 staged 整檔。框架 `--all-files` 仍採 staged 語意；工具、解析、下載校驗失敗一律拒絕。詳見 [hook 說明](hooks/README.md)。

### CI：Maven／Gradle

Maven 合併 [正式 POM 片段](ci/maven/pom-fragment.xml) 的 properties、profiles、dependencies、build；勿再重複合併舊 github 額外片段。填寫：

- `dev-rule.root`、專案 source／target（JDK 9+ 專案應另設 `maven.compiler.release` 為 API 基線）。
- `dev-rule.java.range`：Maven 執行 JDK 的核准範圍，範例為 `[17,18)`。
- `dev-rule.banned` 與 `dev-rule.boundary.banned`：評估後的禁用 GAV；範例 `no.such:artifact` 只表示尚無禁用項，不能當成完成相容性評估。

`JAVA_HOME` 設為實際編譯 JDK，執行 `mvn clean verify`。正式片段整合 PMD、Checkstyle、javac、Error Prone、SpotBugs、Enforcer、ArchUnit 測試依賴及 jdeps／jdeprscan。自行保留既有 annotation processors、外掛與測試設定。

Gradle 以固定 8.14.3 wrapper 接入，保留 distributionSha256Sum；`build.gradle.kts`：

```kotlin
plugins { java }
repositories { mavenCentral() }
apply(from = "vendor/dev-rule/tools/java/ci/gradle/rules.gradle.kts")
```

`gradle.properties` 必填以下設定；`JAVA_HOME`／Gradle 執行 JDK 須等於 `devRuleCompiler`，`devRuleRelease` 可較舊：

```properties
devRuleCompiler=17
devRuleRelease=17
devRuleBanned=no.such:artifact
```

執行 `./gradlew clean check`。片段提供 `devRuleDependencies`、`devRuleClasspath`、`spotbugsMain`／`spotbugsTest` 及 `devRuleBytecode`，不需額外 SpotBugs Gradle 外掛。共用編譯入口讀取版本旗標及已校驗 Error Prone JAR；Gradle 保留 JavaCompile 的來源／輸出／classpath 宣告，以正式入口替換編譯 action，目前針對標準 Java source sets，不適用 Kotlin／Android／JPMS 模組或自訂編譯 action。首次接入須實測專案 annotation processors。

兩者均須依 [ArchUnit 說明](archunit/README.md) 建立專案化 `RulesTemplateTest`，明確選擇架構根套件與規則。不可因不適用而讓空匹配假通過。本機片段檢查整檔與完整 bytecode，不做 staged 行過濾。專案採用建置工具的 dependency verification／鎖檔；Error Prone 主 JAR 與 JDK 8 javac bridge 由共用入口依 profile SHA-256 校驗，快取每次重驗。

### GitHub Actions 五行 caller

一次性設定正式片段、架構測試及已審查的基準檔後，新增：

```yaml
on: [push, pull_request]
jobs:
  java-rules:
    uses: clarkeforwork-coder/dev-rule/.github/workflows/java-rules.yml@<40字元SHA>
    with: {java-version: '17', build-tool: maven, dev-rule-ref: '<相同40字元SHA>'}
```

把佔位值換成實際已發布 SHA；Gradle 改 `build-tool: gradle`。workflow 只讀 contents、固定 Actions SHA，輸出 `java-rules-reports/` 報告與規範摘要。支援標準目錄、單 Java 模組且含測試的專案；多模組必須逐模組設定，不可只掃根目錄。詳細契約見 [workflow 說明](ci/github/README.md)。

## 工具版本與 JDK

| 工具 | JDK 8 | JDK 11 | JDK 17 | JDK 21 |
| --- | --- | --- | --- | --- |
| PMD | 7.29.0 | 7.29.0 | 7.29.0 | 7.29.0 |
| Checkstyle | 9.3 | 10.26.1 | 10.26.1 | 10.26.1 |
| Error Prone | 2.10.0 | 2.10.0 | 2.42.0 | 2.52.0 |
| SpotBugs | 4.8.6 | 4.8.6 | 4.8.6 | 4.8.6 |
| ArchUnit | 1.4.1 | 1.4.1 | 1.4.1 | 1.4.1 |
| javac／jdeps | 隨 JDK | 隨 JDK | 隨 JDK | 隨 JDK |
| jdeprscan | 不提供 | 隨 JDK | 隨 JDK | 隨 JDK |

Maven 驗收 3.9.9、Gradle 8.14.3；Maven compiler 3.13.0、Checkstyle 3.6.0、PMD 3.28.0、SpotBugs 4.8.6.6、Enforcer 3.5.0、Surefire 3.5.2、JUnit 4.13.2。URL／SHA-256 見 [profiles](profiles)、[建置工具鎖檔](build/tool-artifacts.lock) 與 PMD lock。JDK 8 Error Prone 另需已固定的 javac `9+181-r4173-1` bridge。工具執行 JDK 與產物 API 基線不同；不要只改 source／target 就宣稱跨版本 API 安全。

## 診斷與精確基準

```text
[JV-NP-013] 一致的命名形式 → rules/stacks/java/common/naming-packages-docs.md#java-naming-form
```

編譯入口將原生 javac／Error Prone 診斷映射回全部相關 ID，保留來源位置；已登錄的 error 診斷阻擋、warn 只報告，不以全域 `-Werror` 把所有警告升級。SpotBugs 依 pattern-map 輸出相同格式；解析或缺少報告失敗不能算成零違規。

CI 基準只涵蓋 PMD／Checkstyle。先產生完整報告並審查既有違規，建立基準：

```sh
mvn checkstyle:checkstyle pmd:pmd
sh vendor/dev-rule/tools/java/baseline/run.sh create \
  --baseline dev-rule-baseline.tsv --owner team --due 2027-01-01 \
  --pmd target/pmd.xml --checkstyle target/checkstyle-result.xml
mvn -Pdev-rule-baseline clean verify
```

Gradle 首次報告用 `./gradlew -PdevRuleBaseline checkstyleMain checkstyleTest pmdMain pmdTest`，create 必須傳入 main/test 四份報告；之後 `./gradlew -PdevRuleBaseline clean check`。`check` 預設嚴格：阻擋新增 error，也阻擋尚未 prune 的已清償項目；新增 warn 只警告。`--allow-stale` 僅暫時容許已清償項目，CI 預設不加。`prune` 僅刪除已清償項目，不吸收新增問題。v2 基準是工具＋ID＋檔名＋上下文 SHA-256＋等級，以 count 記錄次數；指紋取診斷行內容及前後各一個非空行，各行 trim 後以換行連接，保留行內空白，不是總數相減。CI 不自動 create／刷新基準；編譯、測試與其他分析器不受此基準豁免。完整流程與指紋限制見 [baseline](baseline/README.md)。

碰到既有違規相鄰行時，先重新產生完整報告，再執行 `check`，依輸出的新舊指紋審查來源 diff，確認僅為上下文位移後執行：

```sh
sh vendor/dev-rule/tools/java/baseline/run.sh rekey \
  --baseline dev-rule-baseline.tsv \
  --pmd target/pmd.xml --checkstyle target/checkstyle-result.xml
```

再跑 `check`，將基準 diff 與來源一起提交。`rekey` 只接受同工具、同檔、同規則下唯一完整已清償鍵與唯一新增鍵，且等級、count 相同；保留負責人與期限。配對不成立就整批拒絕、不修改基準，不會吸收額外的真正新違規；不能拿它替代審查。v2 未保存舊行原文，工具無法區分「恰好一修一增」與上下文位移，必須人工確認違規行沒有改變。詳見 [相鄰行處理](baseline/README.md#碰到既有違規相鄰行時的處理)。

抑制須遵循[例外核准](../../rules/workflow/rule-governance.md#exception-approval)，記錄核准人、ID、原因、精確範圍、補償驗證與重驗條件；不得全面排除測試或產生碼。參考 [PMD](pmd/suppressions.md) 與 [Checkstyle](checkstyle/suppressions.md)。

## 涵蓋率與驗證

15 份文件、143 個小節、308 筆映射：verified 78、partial 55、candidate 35、manual 140。本庫可重跑的 pre-commit 與 CI 工具 verified 小節合計 **48／143＝33.57%**，同小節不重複計數。CI 共 57 筆，其中 16 筆 verified、41 筆未 verified；manual 包含 test 34 筆與人工審查 106 筆。verified 必須原規範違反被抓、符合不誤報；合成啟動測試不提升涵蓋率，實證平台與限制保留於 note。完整[涵蓋率總表](coverage/coverage.md)由 rule-map 產生。

```sh
ruby tools/java/pmd/build-rulesets.rb
ruby tools/java/coverage/build-coverage.rb
JAVA_HOME=/path/to/jdk tools/java/tests/run-all.sh
JAVA_HOME=/path/to/jdk17 ruby tools/java/tests/run-ci-integration.rb /tmp/java-ci-output
PATH=/path/to/jdk21/bin:$PATH ruby scripts/check-rules.rb
```

測試需要 Ruby（含 REXML）、各版 JDK、Maven／Gradle、curl 與 SHA-256 工具；可用 `MAVEN_BIN`、`MVN_BIN`、`GRADLE_BIN` 指定執行檔。run-all 執行範例抽取、coverage、一致性、PMD、Checkstyle、66 個合成樣本、版本解析、hook、baseline、編譯入口回歸、編譯工具與建置層；JDK 17 另跑正式片段端到端。各階段保留結束碼並彙總，任何失敗均非零。驗證輸出放暫存目錄，不入庫。

## 已知限制

partial 只涵蓋部分模式，candidate 預設停用；verified 不代表整個小節、所有版本與例外皆已自動化。JDK 11 有 profile 與編譯工具研究，尚無完整片段端到端驗收。JDK 8 沒有 jdeprscan，須另審棄用 API。jdeps 只掃專案 class 的直接靜態內部 API 使用，第三方 JAR、反射字串、JPMS 存取與部署矩陣另行審查。ArchUnit 不能推論執行期注入；併發、序列化、業務契約仍需測試與人工審查。

本庫的 [demo-maven](tests/demo-maven) 是零違規最小專案，使用正式 Maven 片段與專案化 ArchUnit 測試；`.github/workflows/rules-check.yml` 的 `java-demo` job 以本次 commit 呼叫可重用 workflow，實際建置 demo 並上傳 `java-rules-reports`。2026-11-11 複核已確認 [GitHub run 43016989520](https://github.com/clarkeforwork-coder/dev-rule/actions/runs/43016989520) 的 `java-demo / rules` 成功且產生報告 artifact；此遠端實跑證據涵蓋 Maven demo，Gradle workflow 尚無遠端實跑證據。另以 Ruby YAML parser 驗證 workflow 與 caller 契約，並以同一 shell runner 做本機驗證。IDE 外掛安裝與專案特定架構規則仍由採用端選定。
