#!/usr/bin/env bash
# 各階段均執行並彙總結束碼；任何失敗均使 CI 失敗。
set -uo pipefail
base=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
result=0
run() {
    printf '\n執行：'; printf '%s ' "$@"; printf '\n'
    local code=0
    "$@" || code=$?
    printf '階段結束碼：%s\n' "${code}"
    if [ "${code}" -ne 0 ]; then result=1; fi
}
if [ -z "${JAVA_HOME:-}" ] && [ -x /usr/libexec/java_home ]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v 17)
fi
java_bin=${JAVA_HOME:+${JAVA_HOME}/bin/}java
version=$("${java_bin}" -version 2>&1)
printf '%s\n' "${version}"
case "${version}" in *'version "1.8.'*) cs=9.3 ;; *) cs=10.26.1 ;; esac
work=$(mktemp -d "${TMPDIR:-/tmp}/java-tests.XXXXXX")
trap 'rc=$?; rm -rf "${work}"; exit ${rc}' EXIT
export JAVA_EXAMPLES_DIR=${work}/examples
export PMD_BIN=${PMD_BIN:-${base}/tests/pmd-cli.sh}
run ruby -r "${base}/tests/extract-examples.rb" -e 'm = JavaExamples.extract(ARGV.fetch(0)); puts "抽取：#{m.size} 個範例"' "${JAVA_EXAMPLES_DIR}"
run ruby "${base}/coverage/build-coverage.rb" --check
run ruby "${base}/tests/check-consistency.rb"
run ruby "${base}/tests/run-pmd.rb" --output "${work}/pmd"
run ruby "${base}/tests/run-checkstyle.rb" "${cs}"
run ruby "${base}/tests/run-synthetic.rb"
run /bin/bash "${base}/tests/run-version-parser.sh"
run /bin/bash "${base}/tests/run-hook-failure.sh"
run ruby "${base}/tests/run-ci-tools.rb"
printf '\n全部階段彙總結束碼：%s\n' "${result}"
exit "${result}"
