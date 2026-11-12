#!/bin/sh
# 由入口 source；快取只放呼叫端建置目錄，SHA-256 由 Java 計算。
helper_classes() (
    source=$1
    cache=$2
    java_home=${JAVA_HOME:?請設定 JAVA_HOME}
    mkdir -p "$cache"
    cache=$(CDPATH= cd -- "$cache" && pwd)
    # bootstrap 以完整來源查找 SHA-256 目錄，Java 8 bytecode 可跨 JDK 重用。
    helper_source=$base/ci/HelperCache.java
    [ -f "$helper_source" ] || helper_source=$base/../ci/HelperCache.java
    find_bootstrap() {
        bootstrap=
        for candidate in "$cache"/bootstrap-*; do
            if [ -f "$candidate/HelperCache.class" ] && cmp -s "$helper_source" "$candidate/HelperCache.java"; then
                bootstrap=$candidate
                break
            fi
        done
    }
    find_bootstrap
    if [ -z "$bootstrap" ]; then
        lock=$cache/bootstrap.lock
        attempts=0
        until mkdir "$lock" 2>/dev/null; do
            attempts=$((attempts + 1))
            [ "$attempts" -lt 60 ] || { echo "helper 快取鎖逾時：$lock" >&2; exit 2; }
            sleep 1
        done
        work=
        trap 'test -z "$work" || rm -rf "$work"; rmdir "$lock"' 0
        trap 'exit 2' 1 2 15
        find_bootstrap
        if [ -z "$bootstrap" ]; then
            work=$(mktemp -d "$cache/.bootstrap.XXXXXX")
            cp "$helper_source" "$work/HelperCache.java"
            "$java_home/bin/javac" -encoding UTF-8 -source 8 -target 8 -d "$work" "$work/HelperCache.java" || exit 2
            bootstrap=$cache/bootstrap-$("$java_home/bin/java" -cp "$work" HelperCache --sha256 "$work/HelperCache.java")
            mv "$work" "$bootstrap"
            work=
        fi
    fi
    "$java_home/bin/java" -cp "$bootstrap" HelperCache "$source" "$cache"
)
