# 建置層

消費端需要 JDK、Maven／Gradle、POSIX shell，無須 Ruby 或 Python。掃描完整編譯產物，不能以零退出碼推斷所有規範已符合。

```sh
JAVA_HOME=/path/to/jdk sh vendor/dev-rule/tools/java/build/jdeps.sh -cp target/dependencies/* target/classes
JAVA_HOME=/path/to/jdk17 sh vendor/dev-rule/tools/java/build/jdeprscan.sh --release 17 --class-path target/classes target/classes
# 只檢查標示預定移除者：
sh vendor/dev-rule/tools/java/build/jdeprscan.sh --release 17 --for-removal target/classes
```

classpath 請換成實際解析的完整依賴路徑並加引號。退出碼 0＝無工具可見違規、1＝違規、2＝輸入或分析錯誤。jdeps 使用執行 JDK 的工具（8 自動改用 `-jdkinternals`）；jdeprscan 須 JDK 9+，本庫測試 17，8 明確跳過。`--release` 選 API 資料庫，不能取代 javac release。第三方 API 棄用與字串反射皆非本工具範圍；規範反射負例漏報由測試固定保存，JV-VP-016 保持 partial。MR-JAR 須傳 `--multi-release` 並按實際部署路徑另驗證；JPMS `--check` 尚未實作自動門檻，JV-NP-026 保持 candidate。

將 `maven-enforcer.xml` 的 plugin 合併至專案 `build/plugins`，Maven 3.9.9 實測，外掛固定 3.5.0。定義 `dev-rule.java.range`（例如 `[17,18)`）與 `dev-rule.banned`（例如 `group:artifact` 或版本區間）。禁用清單必須依專案評估；不可保留示意 GAV 當作完整治理。另以 `dev-rule.boundary.banned` 設定架構禁用依賴；獨立 execution 使用 JV-NP-028 與套件邊界錨點。`requireJavaVersion` 只核對 Maven JVM，不證明 compiler toolchain、部署版本或版本文件完整。convergence／upper-bound 原生錯誤不保證列出自訂 message，CI runner 會補上 JV-VP-011 標頭。

Gradle 8.14.3 專案先套用 java plugin，再 `apply(from = "vendor/dev-rule/tools/java/build/gradle-enforcer.gradle.kts")`；每個 Java 子專案均需套用。`gradle.properties` 明訂：

```properties
devRuleCompiler=17
devRuleRelease=8
devRuleBanned=example:forbidden,example:legacy
```

compiler 8 時只容許 release 8，使用實際 JDK 8 平台；compiler 9+ 使用 `options.release`。禁止依賴目前以精確 group:artifact 比對；版本範圍與 dependency locking 由專案補上。衝突與禁用檢查僅套用專案編譯／執行／annotation processor classpath，不修改 Checkstyle／PMD 等工具的內部依賴解析。`failOnVersionConflict` 不代表第三方最低 JDK 相容性已驗證。

本庫 `tests/run-build-layer.sh` 執行 JDK、Enforcer、ArchUnit 與 Gradle 正反例；`MVN_BIN`／`GRADLE_BIN` 可指定工具執行檔。正式規範無 POM／Gradle 範例的檢查只提升 partial；合成建置正反例不冒充規範涵蓋。

來源：[jdeps](https://docs.oracle.com/en/java/javase/17/docs/specs/man/jdeps.html)、[jdeprscan](https://docs.oracle.com/en/java/javase/17/docs/specs/man/jdeprscan.html)、[Maven Enforcer](https://maven.apache.org/enforcer/enforcer-rules/)、[Gradle toolchain](https://docs.gradle.org/8.14.3/userguide/toolchains.html)。版本與下載雜湊記於 `tool-artifacts.lock`；JDK 工具隨執行 JDK 發行，CI setup-java 依 major 取得修補版本，並非固定 JDK binary SHA。
