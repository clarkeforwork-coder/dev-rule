#!/bin/sh
# POSIX shell；快取以原始碼及編譯器識別，先在私有目錄編譯再原子發布。
set -eu
base=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
java_bin=${JAVA_HOME:+$JAVA_HOME/bin/}java
javac_bin=${JAVA_HOME:+$JAVA_HOME/bin/}javac
cache=${DEV_RULE_BASELINE_CACHE:-${HOME}/.cache/dev-rule-baseline}
umask 077
mkdir -p "$cache"
key=$({ cat "$base/Baseline.java"; "$javac_bin" -version 2>&1; printf '%s' "${JAVA_HOME:-PATH}"; } | cksum | awk '{print $1 "-" $2}')
classes=$cache/$key
if [ ! -f "$classes/Baseline.class" ]; then
    work=$(mktemp -d "$cache/.compile.XXXXXX")
    trap 'rm -rf "$work"' 0
    trap 'exit 2' 1 2 15
    "$javac_bin" -encoding UTF-8 -source 8 -target 8 -d "$work" "$base/Baseline.java" || exit 2
    # 同時編譯的另一程序已發布時，沿用其完整產物。
    if [ ! -d "$classes" ]; then mv "$work" "$classes" 2>/dev/null || test -f "$classes/Baseline.class"; fi
fi
"$java_bin" -Dfile.encoding=UTF-8 -cp "$classes" Baseline "$@"
