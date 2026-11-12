#!/bin/sh
# 退出碼：0 無靜態內部依賴、1 違規、2 工具或輸入錯誤。
set -eu
[ "$#" -ge 1 ] || { echo '用法：jdeps.sh [jdeps 選項] classes-or-jar' >&2; exit 2; }
java=${JAVA_HOME:+$JAVA_HOME/bin/}java
tool=${JAVA_HOME:+$JAVA_HOME/bin/}jdeps
flag=--jdk-internals
version=$("$java" -XshowSettings:properties -version 2>&1 | sed -n 's/^[[:space:]]*java.specification.version = //p')
case "$version" in 1.8|8) flag=-jdkinternals ;; esac
out=$(mktemp)
trap 'rm -f "$out"' EXIT HUP INT TERM
if ! LC_ALL=C "$tool" "$flag" "$@" >"$out" 2>&1; then cat "$out" >&2; exit 2; fi
if grep -q 'JDK internal API' "$out"; then
    printf '%s\n' '[JV-VP-016] JDK 內部實作與存取限制 → rules/stacks/java/common/version-policy.md#java-jdk-internals'
    cat "$out"
    exit 1
fi
# 未知診斷不能被當作乾淨結果（包括找不到輸入）。
if grep -v '^Picked up ' "$out" | grep -q .; then cat "$out" >&2; exit 2; fi
