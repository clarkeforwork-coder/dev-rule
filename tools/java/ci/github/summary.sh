#!/bin/sh
set -eu
# 以比內容所有反引號連續長度都長的 fence 包覆，保留原始診斷。
for file in "$@"; do
    [ -f "$file" ] || continue
    fence=$(awk 'BEGIN { n=3 } { s=$0; while (match(s, /`+/)) { if (RLENGTH>=n) n=RLENGTH+1; s=substr(s,RSTART+RLENGTH) } } END { for(i=0;i<n;i++) printf "`"; print "" }' "$file")
    printf '\n%stext\n' "$fence"
    cat "$file"
    printf '\n%s\n' "$fence"
done
