#!/bin/sh
# Maven／Gradle 共用入口；JAVA_HOME 必須是專案選定的編譯 JDK。
set -eu
base=$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)
: "${JAVA_HOME:?請設定編譯器 JAVA_HOME}"
if [ "$#" = 1 ] && [ "$1" = -version ]; then exec "$JAVA_HOME/bin/javac" -version; fi
. "$base/ci/helper-cache.sh"
work=$(helper_classes "$base/ci/compiler/PolicyCompiler.java" "${DEV_RULE_TOOLS_DIR:-target/dev-rule-tools}")
"$JAVA_HOME/bin/java" -cp "$work" PolicyCompiler "$base" "$@"
