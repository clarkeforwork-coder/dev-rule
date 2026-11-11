#!/bin/sh
# Maven compilerArgs 一個 arg 對一個參數；避免巢狀 @argfile 被 javac 拒絕。
set -eu
[ "$#" = 1 ] || exit 2
awk '
  /^[[:space:]]*(#|$)/ {next}
  {gsub(/^[[:space:]]+|[[:space:]]+$/, "")}
  $0 == "-Xlint:none" {next}
  /^-Xlint:[a-zA-Z0-9,-]+$/ {
    sub(/^-Xlint:/, ""); categories = categories (categories == "" ? "" : ",") $0; next
  }
  {bad=1}
  END {if (bad || categories == "") exit 2; print "-Xlint:" categories}
' "$1"
