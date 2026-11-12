# Error Prone 檢查

| 執行 JDK | 固定版本 | 備註 |
| --- | --- | --- |
| 8 | 2.10.0 | 需額外 javac 9+181-r4173-1 bootclasspath |
| 11 | 2.10.0 | 舊版規則集合，部分 check 不存在 |
| 17 | 2.42.0 | 最後以 Java 17 為基線的版本系列 |
| 21 | 2.52.0 | 本次研究固定的新版本 |

所有 JAR 的 Maven Central URL／SHA-256 位於 `../profiles/jdk*.env`；JDK 指執行編譯器的平台，`--release` 指產物／API 基線，兩者不同。版本固定，不隨遠端 latest 更新。[官方安裝說明](https://errorprone.info/docs/installation)說明新版需要 JDK 21；[2.42.0 POM](https://github.com/google/error-prone/blob/v2.42.0/pom.xml)保留 Java 17 基線。

`flags-jdk*.txt` 每條註解包含 ID／錨點；先關閉全部預設檢查，再啟用登錄的非 candidate 規則。相同 check 對多錨點時只有一個執行參數，但保留所有映射。候選或版本缺少的 check 留在註解，不傳入編譯器。EqualsGetClass 與允許 getClass 的相等契約衝突，禁止啟用。partial 只補強特定模式，無法取代人工審查。

## 正式接入

使用 [Maven 正式片段](../ci/maven/pom-fragment.xml)（compiler 3.13.0）或 [Gradle 正式片段](../ci/gradle/rules.gradle.kts)，避免重複加入 Error Prone 外掛。Maven 可使用 `annotationProcessorPaths` 明訂處理器；原始參數有 processor path 時保留它，沒有時把 `-classpath` 附加到 processor path，Error Prone JAR 固定在最前，保留原生 javac 的 classpath 處理器探索。兩者都透過 `ci/compiler/javac.sh` 校驗 JAR 並保留既有 processor path；最終編譯參數寫入暫存 argfile，避免大量來源檔超過系統 argv 上限。

`JAVA_HOME` 必須與實際編譯器相同；Gradle 的 `devRuleCompiler` 必須等於執行 Gradle 的 JDK，`devRuleRelease` 可指定較舊 API。JDK 8 bridge、其他版本 exports／opens 由共用入口管理。JDK 17 的 SuppressWarningsWithoutExplanation 未命中原範例，因此不啟用；JDK 21 仍為 partial，不代表可以靠補註解豁免條文。

## 診斷與實證

Error Prone 原生 `[CheckName]` 訊息無法改成規範 ID；CI 摘要由 flags 註解／rule-map 找回所有 `[JV-…] 標題 → rules/…#錨點`。本庫 `run-ci-tools.rb` 使用 `-XepDisableAllChecks` 加單一 check 的 WARN 做原正反例辨識；WARN 可讓編譯完成，正式等級採 flags 檔。沒有原正反配對、不存在的舊版 check、漏報與誤報均明示，只有配對通過才可計 verified。下載／校驗／編譯器崩潰不算規範漏報，會使驗收失敗。
