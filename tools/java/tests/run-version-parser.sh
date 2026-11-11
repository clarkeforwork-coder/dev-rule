#!/usr/bin/env bash
set -euo pipefail
base=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
work=$(mktemp -d "${TMPDIR:-/tmp}/java-version-test.XXXXXX")
trap 'rc=$?; rm -rf "${work}"; exit ${rc}' EXIT
mkdir -p "${work}/bin"
cat > "${work}/bin/java" <<'JAVA'
#!/usr/bin/env bash
printf 'openjdk version "%s"\n' "${TEST_JAVA_VERSION}" >&2
JAVA
chmod +x "${work}/bin/java"
for version in 21 17.0.19 1.8.0_512; do
    rc=0
    TEST_JAVA_VERSION=${version} JAVA_HOME=${work} XDG_CACHE_HOME=${work}/empty DEV_RULE_OFFLINE=1 /bin/bash "${base}/hooks/toolbox.sh" pmd-cli --version > "${work}/output" 2>&1 || rc=$?
    [ "${rc}" = 2 ] && grep -q '離線快取缺少' "${work}/output" || { cat "${work}/output"; exit 1; }
    printf '通過：JDK "%s" 解析成功、進入工具快取驗證\n' "${version}"
done
