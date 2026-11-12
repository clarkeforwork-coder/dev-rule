#!/bin/sh
# POSIX shell；建置內使用專案快取，獨立呼叫使用私有暫存目錄。
set -eu
base=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
java_bin=${JAVA_HOME:+$JAVA_HOME/bin/}java
javac_bin=${JAVA_HOME:+$JAVA_HOME/bin/}javac
if [ -n "${DEV_RULE_TOOLS_DIR:-}" ]; then
    . "$base/../ci/helper-cache.sh"
    work=$(helper_classes "$base/Baseline.java" "$DEV_RULE_TOOLS_DIR")
else
    umask 077
    work=$(mktemp -d)
    trap 'rm -rf "$work"' 0
    trap 'exit 2' 1 2 15
    "$javac_bin" -encoding UTF-8 -source 8 -target 8 -d "$work" "$base/Baseline.java" || exit 2
fi

"$java_bin" -Dfile.encoding=UTF-8 -cp "$work" Baseline "$@"
