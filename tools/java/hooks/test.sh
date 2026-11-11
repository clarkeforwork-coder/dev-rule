#!/usr/bin/env bash
# 真正呼叫 Checkstyle／PMD 的整合測試；設定僅存在暫存目錄。
set -euo pipefail
hook_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
tmp=$(mktemp -d "${TMPDIR:-/tmp}/dev-rule-hook-test.XXXXXX")
trap 'rc=$?; rm -rf "${tmp}"; exit ${rc}' EXIT
export DEV_RULE_CHECKSTYLE_CONFIG=${tmp}/checkstyle.xml DEV_RULE_PMD_RULESET=${tmp}/pmd.xml
unset DEV_RULE_FULL_FILE
cat > "${DEV_RULE_CHECKSTYLE_CONFIG}" <<'XML'
<?xml version="1.0"?>
<!DOCTYPE module PUBLIC "-//Checkstyle//DTD Checkstyle Configuration 1.3//EN" "https://checkstyle.org/dtds/configuration_1_3.dtd">
<module name="Checker"><module name="TreeWalker"><module name="TypeName">
<message key="name.invalidPattern" value="[JV-NM-001] 一致的命名形式 → rules/stacks/java/common/naming-packages-docs.md#java-naming-form"/>
</module></module></module>
XML
cat > "${DEV_RULE_PMD_RULESET}" <<'XML'
<?xml version="1.0"?>
<ruleset name="測試" xmlns="http://pmd.sourceforge.net/ruleset/2.0.0">
<description>接入測試，不代表正式規則範圍</description>
<rule name="BadMethodName" language="java" class="net.sourceforge.pmd.lang.rule.xpath.XPathRule"
 message="[JV-NM-001] 一致的命名形式 → rules/stacks/java/common/naming-packages-docs.md#java-naming-form">
<priority>1</priority><properties><property name="xpath"><value>//MethodDeclaration[@Name = 'Accepts']</value></property></properties></rule>
<rule name="WarnField" language="java" class="net.sourceforge.pmd.lang.rule.xpath.XPathRule"
 message="[JV-NM-001] 一致的命名形式 → rules/stacks/java/common/naming-packages-docs.md#java-naming-form">
<priority>3</priority><properties><property name="xpath"><value>//FieldDeclaration[.//VariableId[@Name = 'maxOrders']]</value></property></properties></rule>
</ruleset>
XML
mkdir "${tmp}/project"
cd "${tmp}/project"
git init -q
git config user.name 'Hook Test'
git config user.email 'hook-test@example.invalid'
git config core.hooksPath "${tmp}/disabled-hooks"
run() {
    local name=$1 expected=$2 actual=0
    shift 2
    printf '\n案例：%s（預期 %s）\n' "${name}" "${expected}"
    /usr/bin/time -p env "$@" "${hook_dir}/pre-commit" > "${tmp}/output" 2> "${tmp}/stderr" || actual=$?
    cat "${tmp}/output" "${tmp}/stderr"
    [ "${actual}" = "${expected}" ] || { printf '失敗：實際 %s\n' "${actual}"; exit 1; }
    printf 'PASS exit=%s\n' "${actual}"
}
run '無 Java，尚無 HEAD' 0
# 取自命名規範的違反範例。
cat > OrderLimit.java <<'JAVA'
class order_limit {
    static final int maxOrders = 10;
    boolean Accepts(int orderCount) { return orderCount <= maxOrders; }
}
JAVA
git add OrderLimit.java
run '新增違反（Checkstyle、PMD error、PMD warn）' 1
cat > OrderLimit.java <<'JAVA'
class OrderLimit {
    static final int MAX_ORDERS = 10;
    boolean accepts(int orderCount) { return orderCount <= MAX_ORDERS; }
}
JAVA
run 'staged 違反、工作目錄符合仍擋' 1
git add OrderLimit.java
printf 'class wrong_name {}\n' > OrderLimit.java
run 'staged 符合、工作目錄違反仍通過' 0
git checkout -- OrderLimit.java
git commit -qm '符合基準'
printf 'class old_name {\n    int amount = 1;\n}\n' > Old.java
git add Old.java
git commit -qm '既有違規基準'
printf 'class old_name {\n    int amount = 2;\n}\n' > Old.java
git add Old.java
run '未變更行既有違規不擋' 0
run '整檔模式會擋既有違規' 1 DEV_RULE_FULL_FILE=1
git commit -qm '修改其他行'
git mv Old.java 'Renamed space.java'
run '純重新命名不新增違規' 0
git commit -qm '重新命名'
printf 'class WarningOnly { int maxOrders = 10; }\n' > WarningOnly.java
git add WarningOnly.java
run 'warn 只列出' 0
git commit -qm '警告案例'
rm 'Renamed space.java'; git add -u
run '刪除 Java 不檢查' 0
git commit -qm '刪除舊檔'
printf '# 文件\n' > README.md; git add README.md
run '只有非 Java' 0
git commit -qm '文件'
for i in 1 2 3 4 5 6 7 8 9 10; do printf 'class Good%s {}\n' "${i}" > "Good${i}.java"; done
git add '*.java'
run '十個符合檔案、離線快取' 0 DEV_RULE_OFFLINE=1
printf 'class {\n' > Broken.java; git add Broken.java
run '語法錯誤不可被忽略' 2
git reset -q HEAD -- Broken.java
# 路徑含 &、冒號、空格時，XML entity 必須正確解碼並匹配 diff。
printf 'class bad_name {}\n' > 'Space & colon:File.java'; git add 'Space & colon:File.java'
run '特殊字元路徑違反被擋' 1
{ printf '// 起始\nclass bad_long_name {\n'; for i in 1 2 3 4 5 6 7 8; do printf '    // 保留行\n'; done; printf '    boolean Accepts(int count) { return count > 0; }\n}\n'; } > Long.java
git add Long.java
run '超過十行的 hunk 必須以數值比較行號' 1
grep -q '^Long.java:2 ' "${tmp}/output"
grep -q '^Long.java:11 ' "${tmp}/output"
git config color.ui always
git config diff.interHunkContext 20
run 'Git 顏色與 hunk 使用者設定不可繞過檢查' 1
run '離線缺少快取必須阻擋' 2 DEV_RULE_OFFLINE=1 XDG_CACHE_HOME="${tmp}/empty-cache"
mkdir -p "${tmp}/broken-cache/dev-rule/java/checkstyle-9.3" "${tmp}/broken-cache/dev-rule/java/checkstyle-10.26.1"
printf '損壞' > "${tmp}/broken-cache/dev-rule/java/checkstyle-9.3/checkstyle.jar"
printf '損壞' > "${tmp}/broken-cache/dev-rule/java/checkstyle-10.26.1/checkstyle.jar"
run '離線快取校驗失敗必須阻擋' 2 DEV_RULE_OFFLINE=1 XDG_CACHE_HOME="${tmp}/broken-cache"
git config --unset core.hooksPath
"${hook_dir}/install.sh" --copy
"${hook_dir}/install.sh" --copy
grep -q '^# dev-rule Java hook launcher$' .git/hooks/pre-commit
actual=0
.git/hooks/pre-commit > "${tmp}/installed.out" 2>&1 || actual=$?
[ "${actual}" = 1 ] || { cat "${tmp}/installed.out"; exit 1; }
"${hook_dir}/install.sh" --hooks-path
"${hook_dir}/install.sh" --hooks-path
[ "$(git config core.hooksPath)" = "${hook_dir}" ]
printf 'PASS 兩種安裝方式可重複執行，複製啟動器確實阻擋違規\n'
printf '\n所有案例通過。\n'
