#!/bin/sh
# classes test-classes classpath-file spotbugs-report...
set -eu
base=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
classes=$1; tests=$2; cpfile=$3; shift 3
[ -n "$(find "$tests" -name RulesTemplateTest.class -print 2>/dev/null)" ] || {
    echo '缺少專案化 RulesTemplateTest.class，拒絕省略架構測試' >&2; exit 2;
}
version=$("$JAVA_HOME/bin/java" -version 2>&1 | sed -n '1s/.*version "\([0-9]*\).*/\1/p')
cp=$(cat "$cpfile"):$classes:$tests
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT HUP INT TERM
"${JAVA_HOME:?}/bin/javac" -encoding UTF-8 -d "$work" "$base/ci/github/SpotbugsSummary.java"
result=0
for report do
    "$JAVA_HOME/bin/java" -cp "$work" SpotbugsSummary "$report" "$base/spotbugs/pattern-map.properties" || result=1
done
for directory in "$classes" "$tests"; do
    [ -d "$directory" ] || { echo "缺少 class 目錄：$directory" >&2; exit 2; }
    [ -n "$(find "$directory" -name '*.class' -print)" ] || { echo "沒有可分析的 class：$directory" >&2; exit 2; }
    if [ -x "$JAVA_HOME/bin/jdeprscan" ]; then
        "$base/build/jdeps.sh" --multi-release "$version" "$directory" || result=1
        "$base/build/jdeprscan.sh" --release "$version" --class-path "$cp" "$directory" || result=1
    else
        "$base/build/jdeps.sh" "$directory" || result=1
        echo 'SKIP jdeprscan：JDK 8 無此工具'
    fi
done
exit "$result"
