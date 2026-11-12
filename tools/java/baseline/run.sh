#!/bin/sh
# POSIX shell；每次在私有暫存目錄編譯，不使用快取。
set -eu
base=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
java_bin=${JAVA_HOME:+$JAVA_HOME/bin/}java
javac_bin=${JAVA_HOME:+$JAVA_HOME/bin/}javac
umask 077
work=$(mktemp -d)
trap 'rm -rf "$work"' 0
trap 'exit 2' 1 2 15
"$javac_bin" -encoding UTF-8 -source 8 -target 8 -d "$work" "$base/Baseline.java" || exit 2
"$java_bin" -Dfile.encoding=UTF-8 -cp "$work" Baseline "$@"
