#!/usr/bin/env bash
set -euo pipefail
hook_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
mode=${1:---hooks-path}
case "$mode" in --hooks-path|--copy) ;; *) printf '用法：install.sh [--hooks-path|--copy] [專案目錄]\n' >&2; exit 2 ;; esac
cd "${2:-.}"
root=$(git rev-parse --show-toplevel)
cd "$root"
current=$(git config --get core.hooksPath || :)
if [ -n "$current" ] && [ "$current" != "$hook_dir" ]; then
    printf 'dev-rule: 已有 core.hooksPath=%s；請先由專案維護者整合既有 hooks。\n' "$current" >&2
    exit 2
fi
if [ "$mode" = --hooks-path ]; then
    git config --local core.hooksPath "$hook_dir"
    printf '已接入：%s\n模式：core.hooksPath\n路徑：%s\n' "$root" "$hook_dir"
else
    if [ -n "$current" ]; then
        printf 'dev-rule: core.hooksPath 已啟用；請先 git config --local --unset core.hooksPath 再使用複製模式。\n' >&2
        exit 2
    fi
    destination=$(git rev-parse --git-path hooks)/pre-commit
    mkdir -p "$(dirname "$destination")"
    if [ -e "$destination" ] && ! grep -q '^# dev-rule Java hook launcher$' "$destination"; then
        printf 'dev-rule: 保留既有 hook：%s；請手動整合。\n' "$destination" >&2
        exit 2
    fi
    # 複製啟動器，工具與設定仍由固定 checkout 提供；可重複安裝更新位置。
    { printf '#!/usr/bin/env bash\n# dev-rule Java hook launcher\nexec '; printf '%q ' "$hook_dir/pre-commit"; printf '"$@"\n'; } > "$destination"
    chmod +x "$destination"
    printf '已接入：%s\n模式：複製啟動器\n路徑：%s\n來源：%s\n' "$root" "$destination" "$hook_dir"
fi
