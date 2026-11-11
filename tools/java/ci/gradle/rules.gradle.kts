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

// 明確啟用：./gradlew -PdevRuleBaseline check；每個子專案各自維護基準。
if (providers.gradleProperty("devRuleBaseline").isPresent) {
    tasks.withType<Pmd>().configureEach { ignoreFailures = true }
    tasks.withType<Checkstyle>().configureEach {
        isIgnoreFailures = true
        reports { xml.required.set(true) }
    }
    val baselineCheck = tasks.register("devRuleBaselineCheck") {
        dependsOn(tasks.withType<Pmd>(), tasks.withType<Checkstyle>())
        doLast {
            val arguments = mutableListOf("sh", devRuleRoot.resolve("tools/java/baseline/run.sh").absolutePath,
                "check", "--baseline", project.file("dev-rule-baseline.tsv").absolutePath)
            // NO-SOURCE 明確轉為空報告；禁止讀取上次建置遺留的報告。
            fun addReport(tool: String, task: org.gradle.api.Task, report: java.io.File) {
                check(task.state.executed) { "基準必要工作被排除：${task.path}" }
                val actual = if (task.state.noSource) {
                    val empty = layout.buildDirectory.file("dev-rule-baseline/${task.name}.xml").get().asFile
                    empty.parentFile.mkdirs()
                    empty.writeText("<$tool/>")
                    empty
                } else {
                    check(!task.state.skipped || task.state.upToDate) { "基準必要工作未執行：${task.path}" }
                    check(report.isFile) { "缺少基準必要報告：$report" }
                    report
                }
                arguments.add("--$tool"); arguments.add(actual.absolutePath)
            }
            tasks.withType<Pmd>().forEach { addReport("pmd", it, it.reports.xml.outputLocation.get().asFile) }
            tasks.withType<Checkstyle>().forEach { addReport("checkstyle", it, it.reports.xml.outputLocation.get().asFile) }
            project.exec {
                workingDir(project.projectDir)
                environment("JAVA_HOME", toolLauncher.get().metadata.installationPath.asFile.absolutePath)
                commandLine(arguments)
            }
        }
    }
    tasks.named("check") { dependsOn(baselineCheck) }
}
