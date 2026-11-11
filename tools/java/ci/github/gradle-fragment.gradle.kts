// 相容入口；只選此檔或 ci/gradle/rules.gradle.kts 其一，勿重複套用。
val rulesRoot = rootProject.file(findProperty("devRuleRoot") ?: "vendor/dev-rule")
apply(from = rulesRoot.resolve("tools/java/ci/gradle/rules.gradle.kts"))
