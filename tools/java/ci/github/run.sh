#!/bin/sh
# 正式片段即是本機與 Actions 的共同門檻；消費端不用 Ruby／Python。
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
    if [ "$code" -ne 0 ]; then result=1; fi
}
case "$JAVA_VERSION" in 8|11|17|21) ;; *) echo '不支援的 Java 版本' >&2; exit 2;; esac
[ -s "$base/javac/lint-jdk${JAVA_VERSION}.txt" ] && [ -s "$base/errorprone/flags-jdk${JAVA_VERSION}.txt" ]
case "$BUILD_TOOL" in
maven)
    run verify mvn -B -Pdev-rule-baseline clean verify
    # 必須真的執行專案化架構測試，不能以其他單元測試取代。
    run architecture mvn -B -Dtest=RulesTemplateTest -DfailIfNoTests=true test
    reports='target/pmd.xml target/checkstyle-result.xml target/spotbugsXml.xml'
    ;;
gradle)
    run verify ./gradlew --no-daemon -PdevRuleBaseline clean check
    run architecture ./gradlew --no-daemon test --tests '*RulesTemplateTest'
    reports='build/reports/pmd/main.xml build/reports/pmd/test.xml build/reports/checkstyle/main.xml build/reports/checkstyle/test.xml build/reports/spotbugs/main.xml build/reports/spotbugs/test.xml'
    ;;
*) echo '不支援的 build-tool' >&2; exit 2;;
esac
for report in $reports; do
    if [ -f "$report" ]; then
        target=$(printf '%s' "$report" | tr '/' '_')
        cp "$report" ".java-rules/$target"
    fi
done
exit "$result"
