# 專案架構測試範本

固定使用 ArchUnit 1.4.1（JDK 8／11／17／21 bytecode）。純核心 JAR 與 slf4j-api 2.0.17 的下載 URL、SHA-256 在 `profiles/jdk*.env`；測試腳本校驗雜湊。Maven／Gradle 專案須保留自身 dependency verification／鎖檔策略。

## 選擇測試框架

把 `RulesTemplate.java` 與以下**其中一份** `RulesTemplateTest.java` 放進 `src/test/java`，兩檔加上相同的專案測試套件宣告：

- JUnit 5 專案：`junit5/RulesTemplateTest.java`，test scope 加入 `com.tngtech.archunit:archunit-junit5:1.4.1` 與 `org.junit.jupiter:junit-jupiter:5.12.2`。Maven 正式片段預設提供這組依賴；Surefire 3.5.2 自動選用 JUnit Platform。
- JUnit 4 專案：`junit4/RulesTemplateTest.java`，test scope 加入 `com.tngtech.archunit:archunit-junit4:1.4.1` 與 `junit:junit:4.13.2`，取代 Maven 片段的 JUnit 5 依賴。
- JUnit Platform 混跑 JUnit 4／5：另加入 test runtime `org.junit.vintage:junit-vintage-engine:5.12.2`；沒有 Vintage 時，JUnit 4 測試不會執行。版本應與專案的 JUnit BOM 對齊。

Gradle 片段不注入任何測試依賴、不設定測試框架。JUnit 5 消費端範例：

```kotlin
plugins { java }
repositories { mavenCentral() }
dependencies {
    testImplementation(platform("org.junit:junit-bom:5.12.2"))
    testImplementation("org.junit.jupiter:junit-jupiter")
    testImplementation("com.tngtech.archunit:archunit-junit5:1.4.1")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}
tasks.test { useJUnitPlatform() }
apply(from = file(providers.gradleProperty("devRuleRoot").getOrElse("vendor/dev-rule")).resolve("tools/java/ci/gradle/rules.gradle.kts"))
```

`useJUnitPlatform()` 在 apply 前後皆可。JUnit 4 專案改用上述 JUnit 4 座標與 `tasks.test { useJUnit() }`。`devRuleRoot` 相對於套用片段的專案目錄解析；專案在子目錄或工具在別處時，建議傳絕對路徑，例如 `-PdevRuleRoot=/workspace/dev-rule`。仍須設定 `devRuleCompiler`、`devRuleRelease`、`devRuleBanned`。

## 專案化規則

將 `com.example`、`order`、`business`、`shared`、`domain`、`application`、`web`、`infrastructure` 換成核准架構；測試中的 `importPackages` 同步調整。外層可依賴 domain，domain 不得反向依賴 application／web 或技術實作；共用套件不可依賴業務；頂層模組禁止循環。Storage／internal 規則檢查實際可見性，所有規則 `because` 保留 ID 與錨點。

範本是設定起點，不假設所有專案都採相同分層。規則預設拒絕空匹配：專案沒有某種層次時，須經審查移除該條，而非全面 `allowEmptyShould(true)`。選定完整業務根套件並排除測試類別，避免把缺漏 import 當通過。完整範本的最小正例應包含非 public 的 internal 類別、非 public 的巢狀 `OrderStorage`、shared 與 domain 類別，且沒有跨層反向依賴。

執行 `mvn verify` 或 `./gradlew check`，確認 Surefire／`build/test-results/test` 的 XML 同時包含一般測試與 `RulesTemplateTest`，且架構測試數量大於零、不是全部 skipped；class 存在不代表測試已執行。本庫測試直接執行同一規則範本，不依賴 JUnit runner；另從正式規範抽取 OrderService／OrderStorage 正反例驗證 JV-NP-024。其餘規則使用合成套件，不提升為完整規範 verified。反射、設定字串與執行期注入仍需人工審查。

## Gradle 版本衝突與編譯行為

Enforcer 的 `failOnVersionConflict` 保留在所有受管 classpath；專案自行加入 ArchUnit 時，若既有 SLF4J 1.x 或 JUnit 4 舊版造成衝突，須依核准版本對齊。例如專案原有 `slf4j-api:1.7.36`、`junit:4.12`，可在 test classpath 明確選用：

```kotlin
configurations.matching { it.name.startsWith("test") && it.name.endsWith("Classpath") }.configureEach {
    resolutionStrategy.force("org.slf4j:slf4j-api:2.0.17", "junit:junit:4.13.2")
}
```

這也包含 PMD 的 `testPmdAuxClasspath`；正式 runtime 的 logging binding 仍須由專案管理，使用 SLF4J 2 時應同步選擇相容的測試 binding。其他 source set 也加入 ArchUnit 時，應對齊該 source set 的 classpath。Maven Enforcer 3.5.0 的 dependency convergence／upper bound 檢查不包含 test scope，與 Gradle 不同。

片段預設以共用政策編譯器替換 `JavaCompile` action；Gradle 的 up-to-date 判定仍有效，輸入變動後會刪除該 task 輸出並全量重編，不保留 javac 增量編譯。開發機可用 `-PdevRuleCompilerReplacement=off` 暫時保留原生 Gradle 編譯；`devRuleCompiler` 仍是數字 JDK 版本，toolchain／release 限制照常生效。CI 不得關閉替換，CI 入口須拒絕 `off` 或明確覆寫為 `on`。編譯及 bytecode 驗證的 `JAVA_HOME` 取自 `devRuleCompiler` toolchain，不依賴外部 shell 的同名環境變數。

所有 source set（包括 apply 後註冊者）都有 `spotbugs<SourceSet>`，SpotBugs 使用編譯 toolchain 的 JDK，避免較舊的 Gradle 執行 JDK 缺少被分析程式使用的 JDK 類別。`devRuleBytecode` 收集所有報告與非空 `classesDirs`，透過既有 `verify.sh` 逐目錄檢查；各次共用架構測試目錄，報告只彙總一次。額外 source set 的 SpotBugs 違規同樣阻擋 `check`。

## Maven／Gradle Enforcer 差異

| 能力 | Maven | Gradle |
| --- | --- | --- |
| 禁用依賴版本 | JV-VP-010 | JV-VP-009 |
| 架構依賴 boundary | JV-NP-028 獨立禁止清單 | 尚未提供，下一期補齊 |
| 版本衝突 | dependencyConvergence／requireUpperBoundDeps（不含 test scope） | failOnVersionConflict（含 test classpath） |

來源：[ArchUnit 使用手冊](https://www.archunit.org/userguide/html/000_Index.html)、[Maven Central 1.4.1](https://repo.maven.apache.org/maven2/com/tngtech/archunit/archunit/1.4.1/)。
