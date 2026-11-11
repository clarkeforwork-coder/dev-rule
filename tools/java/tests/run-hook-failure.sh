#!/usr/bin/env bash
# 用真正工具驗證失敗不能被 EXIT trap／UTF-8 變數解析放行。
set -euo pipefail
base=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
work=$(mktemp -d "${TMPDIR:-/tmp}/java-hook-failure.XXXXXX")
trap 'rc=$?; rm -rf "${work}"; exit ${rc}' EXIT
export LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8
unset DEV_RULE_CHECKSTYLE_CONFIG DEV_RULE_PMD_RULESET
export DEV_RULE_ROOT=$(cd "${base}/../.." && pwd)
original_cache=${XDG_CACHE_HOME:-${HOME}/.cache}
# 先補齊當前執行期的工具快取；失敗案例只修改獨立副本。
"${base}/hooks/toolbox.sh" checkstyle -V >/dev/null
"${base}/hooks/toolbox.sh" pmd-cli --version >/dev/null
mkdir -p "${work}/cache/dev-rule" "${work}/repo"
cp -R "${original_cache}/dev-rule/java" "${work}/cache/dev-rule/java"
cd "${work}/repo"
git init -q
git config user.name 'Hook Failure Test'
git config user.email 'hook-failure@example.invalid'
git config core.hooksPath "${work}/no-hooks"
printf '%s\n' 'class Probe { }' > Probe.java
git add Probe.java
expect_failure() {
    local label=${1} marker=${2} rc=0
    /bin/bash "${base}/hooks/pre-commit" > "${work}/output" 2>&1 || rc=$?
    cat "${work}/output"
    [ "${rc}" = 2 ] || { printf '失敗：%s exit=%s（預期 2）\n' "${label}" "${rc}"; exit 1; }
    grep -q "${marker}" "${work}/output" || { printf '失敗原因不符：%s\n' "${label}"; exit 1; }
    if grep -q 'unbound variable' "${work}/output"; then exit 1; fi
    printf '通過：%s exit=%s（/bin/bash、UTF-8）\n' "${label}" "${rc}"
}
export XDG_CACHE_HOME=${work}/cache DEV_RULE_OFFLINE=1
jar=${XDG_CACHE_HOME}/dev-rule/java/pmd-7.29.0/pmd-java-7.29.0.jar
printf 'tampered\n' > "${jar}"
expect_failure '離線 PMD jar 竄改' 'PMD 執行失敗'
rm "${jar}"
expect_failure '離線 PMD jar 缺少' 'PMD 執行失敗'
export XDG_CACHE_HOME=${original_cache}
unset DEV_RULE_OFFLINE
# macOS 實跑 JDK 17；Linux CI 若無 17，以當前 JDK 啟動工具、17 profile 解析。
java17=${JAVA17_HOME:-}
if [ -z "${java17}" ] && [ -x /usr/libexec/java_home ]; then java17=$(/usr/libexec/java_home -F -v 17 2>/dev/null || true); fi
if [ -n "${java17}" ]; then export JAVA_HOME=${java17}; fi
runtime=${JAVA_HOME:+${JAVA_HOME}/bin/}java
runtime_version=$("${runtime}" -version 2>&1)
case "${runtime_version}" in
    *'version "21'*)
        mkdir -p "${work}/jdk/bin"
        export DEV_RULE_TEST_REAL_JAVA=${runtime}
        cat > "${work}/jdk/bin/java" <<'WRAPPER'
#!/usr/bin/env bash
if [ "${1:-}" = -version ]; then printf 'openjdk version "17.0.19"\n' >&2; else exec "${DEV_RULE_TEST_REAL_JAVA}" "$@"; fi
WRAPPER
        chmod +x "${work}/jdk/bin/java"
        export JAVA_HOME=${work}/jdk
        ;;
esac
cat > Probe.java <<'JAVA'
class Probe {
    String render(Object value) {
        return switch (value) { case String text -> text; default -> ""; };
    }
}
JAVA
git add Probe.java

expect_failure 'Java 21 語法以舊語言 profile 解析' 'PMD 執行失敗'
