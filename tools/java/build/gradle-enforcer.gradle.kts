import org.gradle.api.plugins.JavaPluginExtension
import org.gradle.api.tasks.compile.JavaCompile
import org.gradle.jvm.toolchain.JavaLanguageVersion

// Gradle 8.14.3。每個 Java 子專案都必須 apply 此片段。
val compilerVersion = providers.gradleProperty("devRuleCompiler").get().toInt()
val releaseVersion = providers.gradleProperty("devRuleRelease").get().toInt()
val banned = (providers.gradleProperty("devRuleBanned").orNull
    ?: throw GradleException("缺少 devRuleBanned；請明訂禁用依賴，空白表示無禁用依賴"))
    .split(",").map { it.trim() }.filter { it.isNotEmpty() }
// JV-VP-003：toolchain 必須實際安裝；不默默回退到 daemon JDK。
configure<JavaPluginExtension> {
    toolchain.languageVersion.set(JavaLanguageVersion.of(compilerVersion))
}
tasks.withType<JavaCompile>().configureEach {
    if (compilerVersion >= 9) options.release.set(releaseVersion)
    else {
        require(releaseVersion == 8) { "[JV-VP-003] 建置設定落實限制 → rules/stacks/java/common/version-policy.md#java-build-compatibility" }
        sourceCompatibility = "1.8"
        targetCompatibility = "1.8"
    }
}
configurations.matching { it.name.endsWith("Classpath") || it.name.endsWith("AnnotationProcessor") || it.name == "annotationProcessor" }.configureEach {
    // JV-VP-009：不推斷第三方最低 JDK；仍需核對版本宣告。
    resolutionStrategy.failOnVersionConflict()
    resolutionStrategy.eachDependency {
        if (banned.contains("${requested.group}:${requested.name}")) {
            throw GradleException("[JV-VP-009] 依賴版本要求 → rules/stacks/java/common/version-policy.md#java-dependency-versions：禁止 ${requested}")
        }
    }
}
