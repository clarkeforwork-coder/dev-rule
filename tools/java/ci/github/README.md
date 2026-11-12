# GitHub Actions 可重用檢查

正式 workflow 位於 [`.github/workflows/java-rules.yml`](../../../../.github/workflows/java-rules.yml)。先依 [Java 接入說明](../../README.md) 合併正式 Maven 或 Gradle 片段、專案化 ArchUnit 測試並建立已審查基準，再使用 [caller](caller.yml)。只需在 `uses:` 固定已發布的 commit SHA；不再提供 `dev-rule-ref`。工具來源取自 step 層的 `job.workflow_repository` 與 `job.workflow_sha`，任一為空立即失敗。

checkout 不允許 workspace 以外的目的地，因此工具先 checkout 到 workspace 的保留暫存目錄 `.dev-rule-workflow`，再移到 `$RUNNER_TEMP/dev-rule`。消費端請勿使用該保留目錄。兩次 checkout 都停用 `persist-credentials`。`run.sh` 明確傳入 Maven `-Ddev-rule.root`／Gradle `-PdevRuleRoot`，專案中的 `vendor/dev-rule` 不會決定本次工具版本；若其 `.git` revision 不同，會印警告。

Gradle 消費端套用片段的入口也必須讀取此屬性（本機未傳入時仍可用 vendored 副本）：

```kotlin
val devRuleRoot = providers.gradleProperty("devRuleRoot").getOrElse("vendor/dev-rule")
apply(from = "$devRuleRoot/tools/java/ci/gradle/rules.gradle.kts")
```

`run.sh` 只執行一次 `mvn -Pdev-rule-baseline clean verify` 或 `./gradlew -PdevRuleCompilerReplacement=on -PdevRuleBaseline clean check`，接著以 Java XML parser 驗證首次建置的 `RulesTemplateTest` JUnit XML，須 `tests > 0` 且 `skipped < tests`。Maven 讀 `target/surefire-reports/TEST-*RulesTemplateTest.xml`；Gradle 讀 `build/test-results/*/TEST-*RulesTemplateTest.xml`。缺少報告、零測試或全部略過均失敗，不再用第二次建置補跑。JUnit 5 專案需提供可實際執行架構測試的 engine／測試版本。

Maven 一律使用 workflow 安裝的 3.9.9，不使用專案 `mvnw`；版本與 SHA-256 由 `build/tool-artifacts.lock` 供共用 `install-maven.sh` 讀取。Gradle 使用消費端 `./gradlew`，專案須提交 wrapper。setup-java 依建置工具快取依賴，另快取 `~/.cache/dev-rule`。

消費端不依賴 Ruby／Python。支援標準目錄的單 Java 模組，包含 main 與 test 原始碼；多模組／自訂 source sets 須擴充產物清單並逐模組驗證。JDK 8 無 jdeprscan；jdeps 限專案 class，jdeprscan 使用完整相依 classpath。

`java-version` 接受 8、11、17、21，`build-tool` 接受 maven、gradle；`project-directory` 預設 `.`，拒絕絕對路徑與任何 `..`。`artifact-name` 預設由專案目錄與 JDK 組成，非英數、`.`、`_`、`-` 的字元替換成 `-`；同目錄同版本的平行工作、或淨化後同名的目錄須指定不同名稱。

各階段退出碼及 ID／錨點寫入 `java-rules-reports/summary.md`，摘要用動態長度 code fence 防止內容反引號改變 Markdown 結構。報告及原始輸出上傳 artifact（包含隱藏檔）。將 `java-rules-reports/` 與 `.java-rules-classpath` 加到專案 ignore。CI 不會自動建立、刷新或裁剪基準。

本庫測試可透過 `MVN_BIN`、`GRADLE_BIN` 指定工具，未指定則查 PATH；額外 JDK 8 基準情境由 `JAVA8_HOME` 提供，缺少工具會逐項列為 SKIP，並在 `run-all.sh` 尾端彙總，不算通過。CI 提供四版 JDK 8／11／17／21、Maven 3.9.9 與 Gradle 8.14.3。

語法驗證以 `ruby -ryaml` 載入 workflow 與 caller，本機端到端使用同一 runner。YAML 可解析不代表 GitHub 平台驗收；`job.workflow_*` 與 checkout／artifact 實際行為仍須遠端執行確認。
