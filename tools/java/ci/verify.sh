#!/bin/sh
# classes test-classes classpath-file spotbugs-report...
set -eu
base=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
classes=$1; tests=$2; cpfile=$3; shift 3
[ -n "$(find "$tests" -name RulesTemplateTest.class -print 2>/dev/null)" ] || {
    echo '缺少專案化 RulesTemplateTest.class，拒絕省略架構測試' >&2; exit 2;
}
version=$("$JAVA_HOME/bin/java" -XshowSettings:properties -version 2>&1 | sed -n 's/^[[:space:]]*java.specification.version = //p' | sed 's/^1\.//')
# --release 沿用執行 JDK 的 API 資料庫，才能發現目前平台的棄用；不代表編譯目標。
cp=$(cat "$cpfile"):$classes:$tests
. "$base/ci/helper-cache.sh"
work=$(helper_classes "$base/ci/github/SpotbugsSummary.java" "${DEV_RULE_TOOLS_DIR:-target/dev-rule-tools}")
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
