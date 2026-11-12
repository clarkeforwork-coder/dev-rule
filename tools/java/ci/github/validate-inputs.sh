#!/bin/sh
set -eu
case "${JAVA_VERSION:-}" in 8|11|17|21) ;; *) echo "java-version 無效：${JAVA_VERSION:-}；可接受值：8、11、17、21" >&2; exit 2;; esac
case "${BUILD_TOOL:-}" in maven|gradle) ;; *) echo "build-tool 無效：${BUILD_TOOL:-}；可接受值：maven、gradle" >&2; exit 2;; esac
case "${PROJECT_DIRECTORY:-.}" in /*|*..*|'') echo "project-directory 無效：${PROJECT_DIRECTORY:-}；須為不含 .. 的相對路徑" >&2; exit 2;; esac
