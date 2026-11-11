#!/usr/bin/env bash
# 固定版本與 SHA-256；不執行下載來源提供的 shell 啟動器。
set -euo pipefail
base=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
fail() { printf 'dev-rule: %s\n' "$*" >&2; exit 2; }
java_bin=${JAVA_HOME:+$JAVA_HOME/bin/}java
version=$("$java_bin" -version 2>&1) || fail "無法執行 $java_bin"
major=$(printf '%s\n' "$version" | sed -n 's/.*version "\([0-9][0-9]*\)\..*/\1/p' | head -1)
if [ "$major" = 1 ]; then
    major=$(printf '%s\n' "$version" | sed -n 's/.*version "1\.\([0-9][0-9]*\).*/\1/p' | head -1)
fi
case "$major" in 8|11|17|21) ;; *) fail "不支援的 JDK：${version}；請設定 JAVA_HOME 為 JDK 8、11、17 或 21" ;; esac
# shellcheck source=/dev/null
. "$base/profiles/jdk$major.env"
cache=${XDG_CACHE_HOME:-$HOME/.cache}/dev-rule/java
case "$cache" in *:*) fail '工具快取路徑不可包含 Java classpath 分隔符「:」' ;; esac
checksum() {
    if command -v sha256sum >/dev/null 2>&1; then sha256sum "$1"; else shasum -a 256 "$1"; fi | awk '{print $1}'
}
fetch() {
    local file=$1 url=$2 sha=$3 tmp
    if [ -f "$file" ] && [ "$(checksum "$file")" = "$sha" ]; then return; fi
    [ "${DEV_RULE_OFFLINE:-0}" != 1 ] || fail "離線快取缺少檔案或校驗失敗：$file"
    mkdir -p "$(dirname "$file")"
    tmp=$(mktemp "${file}.XXXXXX")
    if ! curl --fail --location --silent --show-error --connect-timeout 15 --max-time 600 --retry 2 "$url" -o "$tmp"; then
        rm -f "$tmp"; fail "下載失敗且無有效快取：$url"
    fi
    if [ "$(checksum "$tmp")" != "$sha" ]; then
        rm -f "$tmp"; fail "SHA-256 校驗失敗：$url"
    fi
    mv -f "$tmp" "$file"
}
case "${1:-}" in
    checkstyle)
        shift
        file=$cache/checkstyle-$CHECKSTYLE_VERSION/checkstyle.jar
        fetch "$file" "$CHECKSTYLE_URL" "$CHECKSTYLE_SHA256"
        suppressions=$base/checkstyle/suppressions.xml
        if [ -n "${DEV_RULE_ROOT:-}" ]; then suppressions=$DEV_RULE_ROOT/tools/java/checkstyle/suppressions.xml; fi
        exec "$java_bin" -Dfile.encoding=UTF-8 -Dcheckstyle.suppressions.file="$suppressions" -jar "$file" "$@"
        ;;
    pmd|pmd-cli)
        mode=$1
        shift
        dir=$cache/pmd-$PMD_VERSION
        # 直接取得固定的 JAR，執行時不需要 unzip、jar、Maven 或 Python。
        fetch "$dir/pmd-cli-$PMD_VERSION.jar" "$PMD_URL" "$PMD_SHA256"
        classpath=
        while read -r sha url; do
            case "$sha" in ''|\#*) continue ;; esac
            file=$dir/${url##*/}
            fetch "$file" "$url" "$sha"
            classpath=${classpath:+$classpath:}$file
        done < "$base/profiles/$PMD_LOCK"
        if [ "$mode" = pmd ]; then set -- check --use-version "$PMD_LANGUAGE" "$@"; fi
        exec "$java_bin" -Dfile.encoding=UTF-8 -cp "$classpath" net.sourceforge.pmd.cli.PmdCli "$@"
        ;;
    *) fail '用法：toolbox.sh {pmd|pmd-cli|checkstyle} [工具參數…]' ;;
esac
