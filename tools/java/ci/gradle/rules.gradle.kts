import org.gradle.api.plugins.quality.CheckstyleExtension
import org.gradle.api.plugins.quality.Checkstyle
import org.gradle.api.plugins.quality.Pmd
import org.gradle.api.plugins.quality.PmdExtension
import org.gradle.jvm.toolchain.JavaLanguageVersion
import org.gradle.jvm.toolchain.JavaToolchainService

// 在 build.gradle.kts：
// apply(from = file(providers.gradleProperty("devRuleRoot").getOrElse("vendor/dev-rule")).resolve("tools/java/ci/gradle/rules.gradle.kts"))
// 使用 Gradle 8.14.3；執行 Gradle 的 JDK 須為 8/11/17/21。
// Checkstyle／PMD 使用執行 Gradle 的 JDK，避免 Java 8 toolchain 意外啟動 Checkstyle 10。
apply(plugin = "checkstyle")
apply(plugin = "pmd")
val devRuleRoot = file(providers.gradleProperty("devRuleRoot").getOrElse("vendor/dev-rule"))
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

// CI 編譯、依賴、位元碼與架構測試共用正式政策。
apply(from = devRuleRoot.resolve("tools/java/build/gradle-enforcer.gradle.kts"))
val compilerVersion = providers.gradleProperty("devRuleCompiler").get().toInt()
val compilerLauncher = extensions.getByType<JavaToolchainService>().launcherFor {
    languageVersion.set(JavaLanguageVersion.of(compilerVersion))
}
val compilerReplacement = providers.gradleProperty("devRuleCompilerReplacement").getOrElse("on")
require(compilerReplacement in listOf("on", "off")) { "devRuleCompilerReplacement 只接受 on／off" }
if (compilerReplacement == "on") {
    tasks.withType<org.gradle.api.tasks.compile.JavaCompile>().configureEach {
        // Gradle 會把 fork executable 當成 JDK/bin/javac 探測，不能直接指定 shell wrapper。
        // 保留 JavaCompile 的來源／輸出／classpath 宣告，以共用入口替換編譯 action。
        setActions(emptyList())
        inputs.files(devRuleRoot.resolve("tools/java/ci/compiler"), devRuleRoot.resolve("tools/java/profiles"),
            devRuleRoot.resolve("tools/java/errorprone"), devRuleRoot.resolve("tools/java/javac"), devRuleRoot.resolve("tools/java/rule-map.yml"))
        doLast {
            project.delete(destinationDirectory.get().asFile)
            destinationDirectory.get().asFile.mkdirs()
            val arguments = mutableListOf("sh", devRuleRoot.resolve("tools/java/ci/compiler/javac.sh").absolutePath,
                "-encoding", options.encoding ?: "UTF-8", "-d", destinationDirectory.get().asFile.absolutePath,
                "-classpath", classpath.asPath)
            if (options.release.isPresent) arguments.addAll(listOf("--release", options.release.get().toString()))
            else arguments.addAll(listOf("-source", sourceCompatibility, "-target", targetCompatibility))
            // 空值也須明確傳入，避免政策編譯器回退至 compile classpath 探索。
            arguments.addAll(listOf("-processorpath", options.annotationProcessorPath?.asPath ?: ""))
            arguments.addAll(options.compilerArgs)
            arguments.addAll(source.files.map { it.absolutePath })
            val argfile = temporaryDir.resolve("javac.args")
            argfile.writeText(arguments.drop(2).joinToString("\n") {
                "\"" + it.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r") + "\""
            }, Charsets.UTF_8)
            try {
                project.exec {
                    environment("JAVA_HOME", compilerLauncher.get().metadata.installationPath.asFile.absolutePath)
                    commandLine(arguments.take(2) + "@${argfile.absolutePath}")
                }
            }
            finally { argfile.delete() }
        }
    }
}
val spotbugsRuntime = configurations.create("devRuleSpotbugs")
dependencies.add(spotbugsRuntime.name, "com.github.spotbugs:spotbugs:4.8.6")
// 測試依賴與框架由消費專案選擇，座標及版本對齊見 archunit/README.md。
val javaSources = extensions.getByType<org.gradle.api.tasks.SourceSetContainer>()
val spotbugsTasks = mutableListOf<org.gradle.api.tasks.TaskProvider<JavaExec>>()
javaSources.all {
    val sources = this
    spotbugsTasks.add(tasks.register<JavaExec>("spotbugs" + sources.name.replaceFirstChar { it.uppercase() }) {
        dependsOn(tasks.named(sources.classesTaskName))
        javaLauncher.set(compilerLauncher)
        classpath = spotbugsRuntime
        mainClass.set("edu.umd.cs.findbugs.FindBugs2")
        val report = layout.buildDirectory.file("reports/spotbugs/${sources.name}.xml")
        outputs.file(report)
        inputs.files(sources.output.classesDirs, sources.runtimeClasspath,
            devRuleRoot.resolve("tools/java/spotbugs/include.xml"), devRuleRoot.resolve("tools/java/spotbugs/exclude.xml"))
        doFirst {
            report.get().asFile.parentFile.mkdirs()
            args("-effort:default", "-low", "-xml:withMessages", "-output", report.get().asFile.absolutePath,
                "-include", devRuleRoot.resolve("tools/java/spotbugs/include.xml").absolutePath,
                "-exclude", devRuleRoot.resolve("tools/java/spotbugs/exclude.xml").absolutePath,
                "-auxclasspath", sources.runtimeClasspath.asPath)
            args(sources.output.classesDirs.files.map { it.absolutePath })
        }
    })
}
val dependencyCheck = tasks.register("devRuleDependencies") {
    doLast { configurations.filter { it.isCanBeResolved && it.name.endsWith("Classpath") }.forEach { it.resolve() } }
}
val classpathFile = tasks.register("devRuleClasspath") {
    doLast {
        file(".java-rules-classpath").writeText(files(javaSources.map { it.runtimeClasspath }).asPath)
    }
}
val bytecodeCheck = tasks.register("devRuleBytecode") {
    dependsOn(provider { spotbugsTasks.toList() }, classpathFile)
    doLast {
        val testDirectories = javaSources.getByName("test").output.classesDirs.files.filter { it.isDirectory }
        check(testDirectories.isNotEmpty()) { "缺少 test classesDirs" }
        val architectureDirectory = testDirectories.firstOrNull { directory ->
            directory.walkTopDown().any { it.name == "RulesTemplateTest.class" }
        } ?: error("缺少專案化 RulesTemplateTest.class")
        val directories = javaSources.flatMap { it.output.classesDirs.files }.filter { directory ->
            directory.isDirectory && directory.walkTopDown().any { it.extension == "class" }
        }.distinct()
        check(directories.isNotEmpty()) { "沒有可分析的 classesDirs" }
        val reports = javaSources.map {
            layout.buildDirectory.file("reports/spotbugs/${it.name}.xml").get().asFile.absolutePath
        }
        // verify.sh 的前兩個參數各接受一個目錄；逐目錄呼叫，所有報告只彙總一次。
        directories.forEachIndexed { index, directory ->
            project.exec {
                workingDir(project.projectDir)
                environment("JAVA_HOME", compilerLauncher.get().metadata.installationPath.asFile.absolutePath)
                commandLine(listOf("sh", devRuleRoot.resolve("tools/java/ci/verify.sh").absolutePath,
                    directory.absolutePath, architectureDirectory.absolutePath,
                    file(".java-rules-classpath").absolutePath) + if (index == 0) reports else emptyList())
            }
        }
    }
}
tasks.withType<Test>().configureEach {
    testLogging { exceptionFormat = org.gradle.api.tasks.testing.logging.TestExceptionFormat.FULL }
}
tasks.named("check") { dependsOn(dependencyCheck, bytecodeCheck) }
