# GitHub Actions 可重用檢查

正式 workflow 位於 [`.github/workflows/java-rules.yml`](../../../../.github/workflows/java-rules.yml)，不能從 `tools/` 路徑直接呼叫（[GitHub 官方要求](https://docs.github.com/en/actions/how-tos/reuse-automations/reuse-workflows)）。完成下列一次性專案設定後，caller 五行即可：

```yaml
on: [push, pull_request]
jobs:
  java-rules:
    uses: clarkeforwork-coder/dev-rule/.github/workflows/java-rules.yml@<40字元SHA>
    with: {java-version: '17', build-tool: maven, dev-rule-ref: '<相同40字元SHA>'}
```

以真實已發布 SHA 取代佔位值；`dev-rule-ref` 也接受 `refs/tags/<tag>`，不接受浮動 branch。caller 的 workflow SHA 與工具 checkout SHA 應相同，升級須一起審查。Actions 固定完整 SHA；`java-version` 限 8／11／17／21，使用 Temurin 最新對應修補版本，輸出由 setup-java 記錄，若需完整發行包 SHA 請由專案另外鎖定。

## 一次性接入

目前適用單 Java 模組、標準輸出目錄且包含測試原始碼的 Maven／Gradle 專案。多模組須逐模組採用或擴充 runner 的產物與報告清單；不可只掃根專案報告宣稱全量。消費端不用 Ruby／Python；測試工具 Ruby 僅在本庫使用。

Maven：合併 `ci/maven/pom-fragment.xml` 的 properties、profiles、plugins（保留 includeTests），再合併 `build/maven-enforcer.xml` 與本目錄 `maven-fragment.xml` 的 plugins；填寫 JDK 範圍、禁用依賴、compiler release（JDK 8 使用 source/target 8）、`dev-rule.root`。本機以 `lint-argument.sh tools/java/javac/lint-jdkN.txt` 取得 `dev-rule.lint` 屬性值；workflow 自動讀取版本旗標檔並合併 Xlint 類別，compilerArgs 傳入單一類別參數，移除會壓掉指定警告的 -Xlint:none，避免 javac 巢狀 @argfile 的限制。SpotBugs 4.8.6.6 外掛讀取正式 include／exclude，不採用預設全規則。Maven 3.9.9 已用於建置層實測；GitHub runner 的 Maven 版本由 image 管理。

Gradle：固定 wrapper 8.14.3 及 distributionSha256Sum；主 `build.gradle.kts` 先宣告 `java` 與 `id("com.github.spotbugs") version "6.0.26"`，依序套用 `ci/gradle/rules.gradle.kts`、`build/gradle-enforcer.gradle.kts` 及本目錄 `gradle-fragment.gradle.kts`。設定 devRuleCompiler／devRuleRelease／devRuleBanned；測試務必使用實際 JDK 對應設定。片段提供 `devRuleDependencies`、`devRuleClasspath`，輸出 SpotBugs main/test XML。PMD／Checkstyle 報告產生階段容許違規，由 baseline 統一阻擋新增 error；分析錯誤與缺失報告仍會失敗。

兩者均需依 `archunit/README.md` 放入專案化 `RulesTemplate` 及 `RulesTemplateTest`，並依 baseline README 審查建立 `dev-rule-baseline.tsv`。CI 不會自動建立或刷新基準。不適用的架構層次應審查調整測試，而非讓空匹配通過。掃描器將依建置解析的 runtime classpath 分析；只掃專案 classes，第三方 JAR 本身與 MR-JAR 部署矩陣仍需另行掃描。

## 門檻與摘要

runner 依序編譯、全量 Checkstyle／PMD、Enforcer、指定架構測試、SpotBugs、jdeps／jdeprscan 及 baseline，任何階段工具錯誤不被 baseline 吞掉。Java 8 明列沒有 jdeprscan；其餘版本以相同 `--release` 分析。SpotBugs 與建置／架構門檻不納入 PMD／Checkstyle 基準。

`.java-rules/` 保存各階段輸出與摘要，再上傳 artifact；摘要列出 ID／錨點診斷及 coverage 的人工審查清單。SpotBugs `pattern-map.properties` 必須是 `pattern=診斷` 的 UTF-8 properties；診斷須含 `[JV-…]` 與規範錨點。未知 pattern、缺失或錯誤 XML 都拒絕通過。建議將 `.java-rules/`、`.java-rules-classpath` 加入專案 ignore。

本機以 `ruby -ryaml` 載入 workflow，並讀審輸入、權限、固定 revision、always 摘要與失敗傳遞；本機無 act，尚未在 GitHub 遠端執行完整 workflow。建置層本機回歸不能代替消費端接入驗證。
