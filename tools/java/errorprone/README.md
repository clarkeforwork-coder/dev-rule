# Error Prone 檢查

| 執行 JDK | 固定版本 | 備註 |
| --- | --- | --- |
| 8 | 2.10.0 | 需額外 javac 9+181-r4173-1 bootclasspath |
| 11 | 2.10.0 | 舊版規則集合，部分 check 不存在 |
| 17 | 2.42.0 | 最後以 Java 17 為基線的版本系列 |
| 21 | 2.52.0 | 本次研究固定的新版本 |

所有 JAR 的 Maven Central URL／SHA-256 位於 `../profiles/jdk*.env`；JDK 指執行編譯器的平台，`--release` 指產物／API 基線，兩者不同。版本固定，不隨遠端 latest 更新。[官方安裝說明](https://errorprone.info/docs/installation)說明新版需要 JDK 21；[2.42.0 POM](https://github.com/google/error-prone/blob/v2.42.0/pom.xml)保留 Java 17 基線。

`flags-jdk*.txt` 每條註解包含 ID／錨點；先關閉全部預設檢查，再啟用登錄的非 candidate 規則。相同 check 對多錨點時只有一個執行參數，但保留所有映射。候選或版本缺少的 check 留在註解，不傳入編譯器。EqualsGetClass 與允許 getClass 的相等契約衝突，禁止啟用。partial 只補強特定模式，無法取代人工審查。

## Maven

將設定合併到消費專案的 maven-compiler-plugin（固定 3.14.1），依**執行 JDK**選上表版本；不要修改專案原本的 annotation processors。以下為 JDK 17／21 的接法：

```xml
<configuration>
  <fork>true</fork>
  <release>17</release>
  <annotationProcessorPaths>
    <path>
      <groupId>com.google.errorprone</groupId>
      <artifactId>error_prone_core</artifactId>
      <version>${errorprone.version}</version>
    </path>
  </annotationProcessorPaths>
  <compilerArgs>
    <arg>-XDcompilePolicy=simple</arg>
    <arg>--should-stop=ifError=FLOW</arg>
    <arg>-XDaddTypeAnnotationsToSymbol=true</arg>
    <!-- 同一 arg：把 flags-jdkN.txt 的非註解內容以空白接在 ErrorProne 後面 -->
    <arg>-Xplugin:ErrorProne -XepDisableAllChecks -Xep:NonApiType:WARN</arg>
  </compilerArgs>
</configuration>
```

上例只示範一條檢查；完整政策必須使用該 JDK flags 的全部非註解行。fork 模式另將下列每個 JVM 參數作為 compilerArgs 的獨立 `<arg>`（非 fork 則去掉 `-J` 放入 `.mvn/jvm.config`）：

```text
-J--add-exports=jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED
-J--add-exports=jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED
-J--add-exports=jdk.compiler/com.sun.tools.javac.main=ALL-UNNAMED
-J--add-exports=jdk.compiler/com.sun.tools.javac.model=ALL-UNNAMED
-J--add-exports=jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED
-J--add-exports=jdk.compiler/com.sun.tools.javac.processing=ALL-UNNAMED
-J--add-exports=jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED
-J--add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED
-J--add-exports=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED
-J--add-exports=jdk.compiler/com.sun.tools.javac.comp=ALL-UNNAMED
-J--add-opens=jdk.compiler/com.sun.tools.javac.code=ALL-UNNAMED
-J--add-opens=jdk.compiler/com.sun.tools.javac.comp=ALL-UNNAMED
```

JDK 11 使用 2.10.0、同樣 exports／opens，省略 FLOW 與 addTypeAnnotationsToSymbol。JDK 8 使用 2.10.0、`source/target=8`，移除 release／exports／opens／FLOW／addTypeAnnotationsToSymbol；以 `-J-Xbootclasspath/p:/絕對路徑/javac-9+181-r4173-1.jar` 載入 profiles 鎖定的 javac。JAR 須先按固定 URL 取得並校驗，不能只放一般 classpath。此舊版組合只為維持既有專案，非新版規則支援承諾。

## Gradle

可使用原生 JavaCompile 的 fork／annotationProcessorPath，無須額外 Error Prone Gradle 外掛。建置 Gradle 的 JDK 與 fork 編譯器 JDK 分開設定；舊 JDK 專案可由新版 Gradle 執行，再 fork 對應編譯器。

```kotlin
val errorprone by configurations.creating
val compilerJdk = 17 // 必須與實際 fork compiler 一致
val epVersion = "2.42.0"
dependencies { errorprone("com.google.errorprone:error_prone_core:$epVersion") }
tasks.withType<JavaCompile>().configureEach {
    javaCompiler.set(javaToolchains.compilerFor { languageVersion.set(JavaLanguageVersion.of(compilerJdk)) })
    options.isFork = true
    options.annotationProcessorPath = configurations.annotationProcessor.get() + errorprone
    val policy = file("vendor/dev-rule/tools/java/errorprone/flags-jdk$compilerJdk.txt")
        .readLines().map { it.trim() }.filter { it.isNotEmpty() && !it.startsWith("#") }
    options.compilerArgs.addAll(listOf("-XDcompilePolicy=simple", "--should-stop=ifError=FLOW",
        "-XDaddTypeAnnotationsToSymbol=true", "-Xplugin:ErrorProne " + policy.joinToString(" ")))
    options.forkOptions.jvmArgs =
        listOf("api", "file", "main", "model", "parser", "processing", "tree", "util", "code", "comp")
            .map { "--add-exports=jdk.compiler/com.sun.tools.javac.$it=ALL-UNNAMED" } +
        listOf("code", "comp").map { "--add-opens=jdk.compiler/com.sun.tools.javac.$it=ALL-UNNAMED" }
}
```

JDK 8／11 按 Maven 段相同版本差異調整；8 的 forkOptions.jvmArgs 改成 `-Xbootclasspath/p:...`。既有處理器應合併，不可覆蓋遺失。以上是整合片段，專案須用自身完整 classpath 執行建置驗證。

## 診斷與實證

Error Prone 原生 `[CheckName]` 訊息無法改成規範 ID；CI 摘要由 flags 註解／rule-map 找回所有 `[JV-…] 標題 → rules/…#錨點`。本庫 `run-ci-tools.rb` 使用 `-XepDisableAllChecks` 加單一 check 的 WARN 做原正反例辨識；WARN 可讓編譯完成，正式等級採 flags 檔。沒有原正反配對、不存在的舊版 check、漏報與誤報均明示，只有配對通過才可計 verified。下載／校驗／編譯器崩潰不算規範漏報，會使驗收失敗。
