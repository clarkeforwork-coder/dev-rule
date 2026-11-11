#!/usr/bin/env bash
# 使用正式全集，驗證新增行基準與 index 快照。
set -euo pipefail
base=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
unset DEV_RULE_CHECKSTYLE_CONFIG DEV_RULE_PMD_RULESET DEV_RULE_FULL_FILE
export DEV_RULE_ROOT=$(cd "${base}/../.." && pwd)
work=$(mktemp -d "${TMPDIR:-/tmp}/java-hook-official.XXXXXX")
trap 'rc=$?; rm -rf "${work}"; exit ${rc}' EXIT
cd "${work}"
git init -q
git config user.name 'Java hook test'
git config user.email 'test@example.invalid'
git config core.hooksPath "${work}/disabled"
run() {
    local label=$1 expected=$2 actual=0
    shift 2
    printf '\n案例：%s；預期結束碼 %s\n' "${label}" "${expected}"
    /usr/bin/time -p env "$@" "${base}/hooks/pre-commit" || actual=$?
    [ "${expected}" = "${actual}" ] || { printf '失敗：實際 %s\n' "${actual}"; exit 1; }
    printf '通過：結束碼 %s\n' "${actual}"
}
run '沒有 Java' 0
printf 'class bad_name {}\n' > Bad.java
git add Bad.java
run '新增違規阻擋' 1
printf 'class Good {}\n' > Bad.java
run 'staged 違反、工作目錄符合仍擋' 1
git add Bad.java
printf 'class bad_name {}\n' > Bad.java
run 'staged 符合、工作目錄違反仍通過' 0
git checkout -- Bad.java
git commit -qm '符合基準'
printf 'class old_name {\n    // 舊註解\n}\n' > Old.java
git add Old.java
git commit -qm '既有違規基準'
printf 'class old_name {\n    // 新註解\n}\n' > Old.java
git add Old.java
run '既有違規不擋新增乾淨行' 0
run '整檔模式仍擋既有違規' 1 DEV_RULE_FULL_FILE=1
git commit -qm '變更註解'
printf '# 文件\n' > README.md
git add README.md
run '只有非 Java 檔' 0
printf '\n正式設定 hook 案例全部通過。\n'
