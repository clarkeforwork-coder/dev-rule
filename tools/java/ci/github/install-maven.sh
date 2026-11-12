#!/bin/sh
set -eu
base=$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)
# 版本與 SHA-256 共同取自 lock，避免兩個 workflow 各自維護。
entry=$(awk '$2 ~ /\/apache-maven-[0-9.]+-bin.tar.gz$/ {print}' "$base/build/tool-artifacts.lock")
[ "$(printf '%s\n' "$entry" | wc -l | tr -d ' ')" = 1 ] && [ -n "$entry" ] || { echo 'Maven lock 必須恰有一筆' >&2; exit 2; }
sha=${entry%% *}; url=${entry#* }
name=${url##*/}; name=${name%-bin.tar.gz}
archive="$RUNNER_TEMP/maven.tar.gz"
curl -fsSL "$url" -o "$archive"
printf '%s  %s\n' "$sha" "$archive" | sha256sum -c -
tar -xzf "$archive" -C "$RUNNER_TEMP"
printf '%s/bin\n' "$RUNNER_TEMP/$name" >> "$GITHUB_PATH"
