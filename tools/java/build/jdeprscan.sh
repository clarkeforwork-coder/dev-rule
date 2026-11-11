#!/bin/sh
# JDK 9+；release 是 API 資料庫版本，不是編譯目標設定。
set -eu
[ "$#" -ge 3 ] && [ "$1" = --release ] || { echo '用法：jdeprscan.sh --release N [--for-removal] [--class-path PATH] classes-or-jar' >&2; exit 2; }
tool=${JAVA_HOME:+$JAVA_HOME/bin/}jdeprscan
out=$(mktemp)
trap 'rm -f "$out"' EXIT HUP INT TERM
if ! LC_ALL=C "$tool" "$@" >"$out" 2>&1; then cat "$out" >&2; exit 2; fi
# jdeprscan 可在缺少相依類別時回傳 0，必須優先拒絕不完整分析。
if grep -Eq '^(error:|warning:|Exception in thread |[[:alnum:]_.]+Exception:)' "$out"; then cat "$out" >&2; exit 2; fi
if grep -q 'uses deprecated' "$out"; then
    printf '%s\n' '[JV-VP-021] 棄用 API → rules/stacks/java/common/version-policy.md#java-deprecated-api'
    cat "$out"
    exit 1
fi
if grep -Ev '^(Directory |Jar file |$)' "$out" | grep -q .; then cat "$out" >&2; exit 2; fi
