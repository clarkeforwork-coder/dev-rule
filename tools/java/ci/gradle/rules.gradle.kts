import org.gradle.api.plugins.quality.CheckstyleExtension
import org.gradle.api.plugins.quality.Checkstyle
import org.gradle.api.plugins.quality.Pmd
import org.gradle.api.plugins.quality.PmdExtension
import org.gradle.jvm.toolchain.JavaLanguageVersion
import org.gradle.jvm.toolchain.JavaToolchainService

// 在 build.gradle.kts：apply(from = "vendor/dev-rule/tools/java/ci/gradle/rules.gradle.kts")
// 使用 Gradle 8.14.3；執行 Gradle 的 JDK 須為 8/11/17/21。
// 工具使用執行 Gradle 的 JDK，避免 Java 8 編譯 toolchain 意外啟動 Checkstyle 10。
apply(plugin = "checkstyle")
apply(plugin = "pmd")
val devRuleRoot = rootProject.file(findProperty("devRuleRoot") ?: "vendor/dev-rule")
val checkstyleVersion = if (JavaVersion.current() == JavaVersion.VERSION_1_8) "9.3" else "10.26.1"
val toolLauncher = extensions.getByType<JavaToolchainService>().launcherFor {
    languageVersion.set(JavaLanguageVersion.of(JavaVersion.current().majorVersion))
}
configure<CheckstyleExtension> {
    toolVersion = checkstyleVersion
    configFile = devRuleRoot.resolve("tools/java/checkstyle/checkstyle.xml")
    configProperties = mapOf("checkstyle.suppressions.file" to devRuleRoot.resolve("tools/java/checkstyle/suppressions.xml").absolutePath)
    maxErrors = 0
    maxWarnings = Int.MAX_VALUE
}
configure<PmdExtension> {
    toolVersion = "7.29.0"
    ruleSets = emptyList()
    ruleSetFiles = files(devRuleRoot.resolve("tools/java/pmd/ruleset.xml"))
    // Gradle 不提供依 priority 分開列出／阻擋的原生開關，build 僅啟用 error。
    rulesMinimumPriority = 2
    isConsoleOutput = true
}
tasks.withType<Pmd>().configureEach {
    javaLauncher.set(toolLauncher)
    reports { xml.required.set(true); html.required.set(true) }
}
tasks.withType<Checkstyle>().configureEach { javaLauncher.set(toolLauncher) }
