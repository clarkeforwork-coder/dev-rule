# GitHub Actions 可重用檢查

正式 workflow 位於 [`.github/workflows/java-rules.yml`](../../../../.github/workflows/java-rules.yml)。先依 [Java 接入說明](../../README.md) 合併正式 Maven 或 Gradle 片段、專案化 ArchUnit 測試並建立已審查基準，再使用 [五行 caller](caller.yml)。兩處 revision 應固定相同已發布 SHA；工具 checkout 亦接受明確 `refs/tags/`，不接受 branch。

`run.sh` 直接執行正式片段的 `mvn -Pdev-rule-baseline clean verify` 或 `./gradlew -PdevRuleBaseline clean check`，再指定執行 `RulesTemplateTest`，避免以其他測試取代架構測試。正式片段負責 javac／Error Prone、PMD／Checkstyle、SpotBugs、依賴限制、架構測試、jdeps／jdeprscan 與基準；不用再合併額外 plugins。舊 `maven-fragment.xml` 為空相容提示，`gradle-fragment.gradle.kts` 只轉到正式入口，勿重複套用。

消費端不依賴 Ruby／Python。支援標準目錄的單 Java 模組，包含 main 與 test 原始碼；多模組／自訂 source sets 須擴充產物清單並逐模組驗證。JDK 8 無 jdeprscan；jdeps 限專案 class，不將 ArchUnit 等相依 JAR 的實作混入專案門檻。jdeprscan 仍使用完整相依 classpath。

各階段退出碼及 ID／錨點寫入 `.java-rules/summary.md`，報告、原始輸出上傳 artifact。加入 `.java-rules/` 與 `.java-rules-classpath` 到專案 ignore。CI 不會自動建立、刷新或裁剪基準。

語法驗證：`ruby -ryaml` 載入 workflow 與 caller，核對 `workflow_call.inputs` 和 caller 的 `with`；本機端到端使用相同 runner。沒有遠端 GitHub 執行證據，不將 YAML 載入當成完整 Actions 平台驗收。
