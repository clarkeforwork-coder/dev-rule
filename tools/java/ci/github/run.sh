#!/bin/sh
# 消費端只需要 Java、建置工具、git、curl 與 POSIX shell。
set -eu
base=$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)
mkdir -p .java-rules
summary=.java-rules/summary.md
printf '# Java 規範檢查\n\n' > "$summary"
result=0
run() {
    name=$1; shift
    code=0
    "$@" >".java-rules/$name.log" 2>&1 || code=$?
    cat ".java-rules/$name.log"
    printf '* %s：退出碼 %s\n' "$name" "$code" >> "$summary"
    grep '\[JV-' ".java-rules/$name.log" >> "$summary" || :
    if [ "$code" -ne 0 ]; then
        result=1
        if grep -Eq "Dependency convergence error|RequireUpperBoundDeps" ".java-rules/$name.log"; then
            printf '%s\n' '[JV-VP-011] 依賴版本要求 → rules/stacks/java/common/version-policy.md#java-dependency-versions（依賴收斂／上界失敗，詳見原始診斷）' | tee -a "$summary"
        fi
    fi
}
# 每行一個 javac 旗標；排除空行與註解，不以 eval 執行設定內容。
lint="$base/javac/lint-jdk${JAVA_VERSION}.txt"
[ -s "$lint" ] || { echo '缺少版本專用 javac 旗標檔' >&2; exit 2; }
case "$BUILD_TOOL" in
maven)
    # compilerArgs 由接入 POM 讀取旗標檔；參見 README。
    lint_argument=$(sh "$base/ci/github/lint-argument.sh" "$lint")
    mvn() { command mvn -Ddev-rule.lint="$lint_argument" "$@"; }
    run compile mvn -B -Ddev-rule.lint="$lint_argument" clean test-compile
    run checkstyle mvn -B checkstyle:checkstyle
    run pmd mvn -B pmd:pmd
    run enforcer mvn -B enforcer:enforce@dev-rule-enforce enforcer:enforce@dev-rule-boundaries
    run archunit mvn -B -Ddev-rule.lint="$lint_argument" -Dtest=RulesTemplateTest -DfailIfNoTests=true test
    run spotbugs mvn -B -Ddev-rule.lint="$lint_argument" com.github.spotbugs:spotbugs-maven-plugin:4.8.6.6:spotbugs
    run classpath mvn -B org.apache.maven.plugins:maven-dependency-plugin:3.8.1:build-classpath -Dmdep.outputFile=.java-rules-classpath
    testclasses=target/test-classes
    classes=target/classes
    pmd=target/pmd.xml
    checkstyle=target/checkstyle-result.xml
    spotbugs=target/spotbugsXml.xml
    ;;
gradle)
    # wrapper 版本與 SHA 由專案固定；所有工作須由接入設定註冊。
    run compile ./gradlew --no-daemon -PdevRuleLintFile="$lint" clean classes testClasses
    run checkstyle ./gradlew --no-daemon checkstyleMain checkstyleTest
    run pmd ./gradlew --no-daemon pmdMain pmdTest
    run enforcer ./gradlew --no-daemon devRuleDependencies
    run archunit ./gradlew --no-daemon test --tests '*RulesTemplateTest'
    run spotbugs ./gradlew --no-daemon spotbugsMain spotbugsTest
    run classpath ./gradlew --no-daemon devRuleClasspath
    testclasses=build/classes/java/test
    classes=build/classes/java/main
    pmd=build/reports/pmd/main.xml
    checkstyle=build/reports/checkstyle/main.xml
    spotbugs=build/reports/spotbugs/main.xml
    ;;
*) echo '不支援的 build-tool' >&2; exit 2;;
esac
for scanclasses in "$classes" "$testclasses"; do
if [ -d "$scanclasses" ] && [ -n "$(find "$scanclasses" -name '*.class' -print -quit)" ]; then
if [ "$JAVA_VERSION" = 8 ]; then
        run "jdeps-$(basename "$scanclasses")" "$base/build/jdeps.sh" -cp "$(cat .java-rules-classpath):$classes:$testclasses" "$scanclasses"
    else
        run "jdeps-$(basename "$scanclasses")" "$base/build/jdeps.sh" --multi-release "$JAVA_VERSION" -cp "$(cat .java-rules-classpath):$classes:$testclasses" "$scanclasses"
    fi
    if [ "$JAVA_VERSION" != 8 ]; then
        run "jdeprscan-$(basename "$scanclasses")" "$base/build/jdeprscan.sh" --release "$JAVA_VERSION" --class-path "$(cat .java-rules-classpath):$classes:$testclasses" "$scanclasses"
    else printf '* jdeprscan：JDK 8 不提供，須人工審查棄用 API\n' >> "$summary"; fi
else echo '沒有可掃描的 class，拒絕空分析' >&2; result=1; fi
done
# 報告缺失或解析錯誤不能被視為零違規。
run summary-compile javac -encoding UTF-8 -d .java-rules "$base/ci/github/SpotbugsSummary.java" "$base/ci/github/LintSummary.java"
run lint-summary java -cp .java-rules LintSummary .java-rules/compile.log "$base/rule-map.yml"
run spotbugs-summary java -cp .java-rules SpotbugsSummary "$spotbugs" "$base/spotbugs/pattern-map.properties"
if [ "$BUILD_TOOL" = gradle ]; then
    run baseline "$base/baseline/run.sh" check --baseline dev-rule-baseline.tsv --pmd "$pmd" --checkstyle "$checkstyle" --pmd build/reports/pmd/test.xml --checkstyle build/reports/checkstyle/test.xml
    run spotbugs-test-summary java -cp .java-rules SpotbugsSummary build/reports/spotbugs/test.xml "$base/spotbugs/pattern-map.properties"
else
    run baseline "$base/baseline/run.sh" check --baseline dev-rule-baseline.tsv --pmd "$pmd" --checkstyle "$checkstyle"
fi
for report in "$pmd" "$checkstyle" "$spotbugs"; do
    if [ -f "$report" ]; then
        # 父目錄名避免 Gradle main.xml／test.xml 互相覆蓋。
        target=$(printf '%s' "$report" | tr '/' '_')
        cp "$report" ".java-rules/$target"
    fi
done
if [ "$BUILD_TOOL" = gradle ]; then
    for report in build/reports/pmd/test.xml build/reports/checkstyle/test.xml build/reports/spotbugs/test.xml; do
        if [ -f "$report" ]; then target=$(printf '%s' "$report" | tr '/' '_'); cp "$report" ".java-rules/$target"; fi
    done
fi
exit "$result"
