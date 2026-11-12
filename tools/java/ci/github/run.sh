#!/bin/sh
# 正式片段即是本機與 Actions 的共同門檻；消費端不用 Ruby／Python。
set -eu
base=$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)
root=$(CDPATH= cd -- "$base/../.." && pwd)
[ -f "$base/ci/github/validate-inputs.sh" ] || { echo '缺少 workflow 輸入驗證腳本' >&2; exit 2; }
sh "$base/ci/github/validate-inputs.sh"
if [ -e vendor/dev-rule/.git ]; then
    vendored=$(git -C vendor/dev-rule rev-parse HEAD 2>/dev/null || :)
    selected=$(git -C "$root" rev-parse HEAD 2>/dev/null || :)
    if [ "$vendored" != "$selected" ]; then
        echo "警告：vendor/dev-rule revision $vendored 與 workflow 工具 $selected 不同；本次使用 $root" >&2
    fi
fi
mkdir -p java-rules-reports
summary=java-rules-reports/summary.md
printf '# Java 規範檢查\n\n' > "$summary"
result=0
run() {
    name=$1; shift
    code=0
    "$@" >"java-rules-reports/$name.log" 2>&1 || code=$?
    cat "java-rules-reports/$name.log"
    printf '* %s：退出碼 %s\n' "$name" "$code" >> "$summary"
    grep '\[JV-' "java-rules-reports/$name.log" >> "$summary" || :
    if [ "$code" -ne 0 ]; then result=1; fi
}
[ -s "$base/javac/lint-jdk${JAVA_VERSION}.txt" ] || exit 2
[ -s "$base/errorprone/flags-jdk${JAVA_VERSION}.txt" ] || exit 2
case "$BUILD_TOOL" in
maven)
    export DEV_RULE_TOOLS_DIR=target/dev-rule-tools
    run verify "${MVN_BIN:-mvn}" -B -C "-Ddev-rule.root=$root" -Pdev-rule-baseline clean verify
    set -- target/surefire-reports/TEST-*RulesTemplateTest.xml
    reports='target/pmd.xml target/checkstyle-result.xml target/spotbugsXml.xml'
    ;;
gradle)
    export DEV_RULE_TOOLS_DIR=build/dev-rule-tools
    run verify ./gradlew --no-daemon "-PdevRuleRoot=$root" -PdevRuleCompilerReplacement=on -PdevRuleBaseline clean check
    set -- build/test-results/*/TEST-*RulesTemplateTest.xml
    reports='build/reports/pmd/main.xml build/reports/pmd/test.xml build/reports/checkstyle/main.xml build/reports/checkstyle/test.xml build/reports/spotbugs/main.xml build/reports/spotbugs/test.xml'
    ;;
*) echo '不支援的 build-tool' >&2; exit 2;;
esac
. "$base/ci/helper-cache.sh"
java_bin=${JAVA_HOME:+$JAVA_HOME/bin/}java
work=$(helper_classes "$base/ci/github/ArchitectureReports.java" "$DEV_RULE_TOOLS_DIR")
run architecture "$java_bin" -cp "$work" ArchitectureReports "$@"
for report in $reports; do
    if [ -f "$report" ]; then
        target=$(printf '%s' "$report" | tr '/' '_')
        cp "$report" "java-rules-reports/$target"
    fi
done
exit "$result"
