import org.gradle.api.plugins.quality.Checkstyle
import org.gradle.api.plugins.quality.Pmd
import org.gradle.api.tasks.compile.JavaCompile
import com.github.spotbugs.snom.SpotBugsExtension
import com.github.spotbugs.snom.SpotBugsTask

// 專案 plugins 必須先宣告 id("com.github.spotbugs") version "6.0.26"。
// 另 apply ci/gradle/rules.gradle.kts、build/gradle-enforcer.kts。
buildscript {
    repositories { gradlePluginPortal() }
    dependencies { classpath("com.github.spotbugs.snom:spotbugs-gradle-plugin:6.0.26") }
}

val rulesRoot = rootProject.file("vendor/dev-rule")
configure<SpotBugsExtension> {
    toolVersion.set("4.8.6")
    includeFilter.set(rulesRoot.resolve("tools/java/spotbugs/include.xml"))
    excludeFilter.set(rulesRoot.resolve("tools/java/spotbugs/exclude.xml"))
    // 統一由摘要器判定；工具執行錯誤仍不可忽略。
    ignoreFailures.set(false)
}
tasks.withType<SpotBugsTask>().configureEach {
    val reportName = name.removePrefix("spotbugs").replaceFirstChar { it.lowercase() }
    reports.create("xml") { required.set(true); outputLocation.set(layout.buildDirectory.file("reports/spotbugs/$reportName.xml")) }
}
tasks.withType<JavaCompile>().configureEach {
    val lint = providers.gradleProperty("devRuleLintFile").orElse(rulesRoot.resolve("tools/java/javac/lint-jdk${JavaVersion.current().majorVersion}.txt").absolutePath)
    options.compilerArgs.addAll(file(lint.get()).readLines().map { it.trim() }.filter { it.isNotEmpty() && !it.startsWith("#") && it != "-Xlint:none" })
}
// XML 報告仍包含所有問題，門檻由 baseline 統一判定。
tasks.withType<Checkstyle>().configureEach { isIgnoreFailures = true }
tasks.withType<Pmd>().configureEach { ignoreFailures = true }
tasks.register("devRuleDependencies") {
    doLast { configurations.filter { it.isCanBeResolved && (it.name.endsWith("Classpath") || it.name.endsWith("AnnotationProcessor") || it.name == "annotationProcessor") }.forEach { it.resolve() } }
}
tasks.register("devRuleClasspath") {
    doLast { file(".java-rules-classpath").writeText(configurations.getByName("testRuntimeClasspath").asPath) }
}
