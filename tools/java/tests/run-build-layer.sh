#!/usr/bin/env bash
set -euo pipefail
base=$(cd "$(dirname "$0")/.." && pwd)
root=$(cd "$base/../.." && pwd)
export JAVA_HOME=${JAVA_HOME:-$(/usr/libexec/java_home -v 17)}
[ -x "$JAVA_HOME/bin/javac" ] || { echo "無效 JAVA_HOME: $JAVA_HOME" >&2; exit 2; }
export PATH="$JAVA_HOME/bin:$PATH"
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
mvn_bin=${MVN_BIN:-mvn}
if ! command -v "$mvn_bin" >/dev/null; then mvn_bin=/private/tmp/dev-rule-hook-assets/apache-maven-3.9.9/bin/mvn; fi
expect() {
    local expected=$1 name=$2 code=0; shift 2
    "$@" >"$work/result" 2>&1 || code=$?
    if [ "$code" != "$expected" ]; then cat "$work/result"; echo "FAIL $name: $code != $expected"; exit 1; fi
    echo "PASS $name (exit=$code)"
}
mkdir -p "$work/bad" "$work/good"
echo 'class Internal { sun.misc.Unsafe value; }' > "$work/bad/Internal.java"
echo 'class Internal { String value; }' > "$work/good/Internal.java"
javac -d "$work/bad" "$work/bad/Internal.java" 2>"$work/compile"
javac -d "$work/good" "$work/good/Internal.java"
expect 1 'jdeps Unsafe 負例' "$base/build/jdeps.sh" "$work/bad"
grep -q '\[JV-VP-016\]' "$work/result"
expect 0 'jdeps 公開 API 正例' "$base/build/jdeps.sh" "$work/good"
expect 2 'jdeps 不存在路徑拒絕' "$base/build/jdeps.sh" "$work/missing"
# 從正式規範抽取棄用與反射正反例，不另抄一份測試資料。
ruby - "$root" "$work" <<'RUBY'
root, work = ARGV
text = File.read("#{root}/rules/stacks/java/common/version-policy.md")
%w[java-deprecated-api java-jdk-internals].each do |anchor|
  section = text.split(%(<a id="#{anchor}"></a>), 2)[1].split('<a id=', 2)[0]
  section.scan(/```java\n(.*?)```/m).first(2).each_with_index do |source, index|
    dir = "#{work}/#{anchor}-#{index}"; Dir.mkdir(dir)
    File.write("#{dir}/Example.java", source.first)
  end
end
RUBY
for kind in java-deprecated-api java-jdk-internals; do
    for index in 0 1; do javac -d "$work/$kind-$index" "$work/$kind-$index/Example.java" 2>"$work/compile"; done
done
expect 0 'jdeps 規範反射負例漏報（維持 partial）' "$base/build/jdeps.sh" "$work/java-jdk-internals-0"
expect 0 'jdeps 規範反射正例' "$base/build/jdeps.sh" "$work/java-jdk-internals-1"
if [ -x "$JAVA_HOME/bin/jdeprscan" ]; then
    release=$(java -version 2>&1 | sed -n '1s/.*version "\([0-9]*\).*/\1/p')
    expect 1 'jdeprscan 規範棄用負例' "$base/build/jdeprscan.sh" --release "$release" "$work/java-deprecated-api-0"
    grep -q '\[JV-VP-021\]' "$work/result"
    expect 0 'jdeprscan 規範棄用正例' "$base/build/jdeprscan.sh" --release "$release" "$work/java-deprecated-api-1"
    if [ "$release" -ge 17 ]; then expect 1 'jdeprscan 預定移除負例' "$base/build/jdeprscan.sh" --release "$release" --for-removal "$work/java-deprecated-api-0"; fi
    expect 2 'jdeprscan 錯誤 release 拒絕' "$base/build/jdeprscan.sh" --release invalid "$work/good"
else echo 'SKIP jdeprscan：JDK 8 無此工具'; fi
# 使用真正 Enforcer 外掛與完整正反 POM。
ruby - "$base" "$work" <<'RUBY'
base, work = ARGV
plugin = File.read("#{base}/build/maven-enforcer.xml")
[['good', '[1.8,)', 'no.such:artifact'], ['jdk', '[99,)', 'no.such:artifact'], ['banned', '[1.8,)', 'junit:junit']].each do |name, range, banned|
  File.write("#{work}/#{name}.xml", %(<project><modelVersion>4.0.0</modelVersion><groupId>example</groupId><artifactId>fixture</artifactId><version>1</version><properties><dev-rule.java.range>#{range}</dev-rule.java.range><dev-rule.banned>#{banned}</dev-rule.banned><dev-rule.boundary.banned>no.such:artifact</dev-rule.boundary.banned></properties><dependencies><dependency><groupId>junit</groupId><artifactId>junit</artifactId><version>4.13.2</version></dependency></dependencies><build><plugins>#{plugin}</plugins></build></project>))
end
xml = File.read("#{work}/good.xml").sub('</dependencies>', '<dependency><groupId>org.hamcrest</groupId><artifactId>hamcrest-core</artifactId><version>1.1</version></dependency></dependencies>')
File.write("#{work}/conflict.xml", xml)
RUBY
expect 0 'Enforcer 正例' "$mvn_bin" -B -q -f "$work/good.xml" validate
expect 1 'Enforcer JDK 不符' "$mvn_bin" -B -q -f "$work/jdk.xml" validate
grep -q '\[JV-VP-001\]' "$work/result"
expect 1 'Enforcer 禁用依賴' "$mvn_bin" -B -q -f "$work/banned.xml" validate
grep -q '\[JV-VP-010\]' "$work/result"
expect 1 'Enforcer 架構禁用依賴' "$mvn_bin" -B -q -f "$work/good.xml" -Ddev-rule.boundary.banned=junit:junit validate
grep -q '\[JV-NP-028\]' "$work/result"
expect 1 'Enforcer 依賴衝突' "$mvn_bin" -B -q -f "$work/conflict.xml" validate
grep -q 'Dependency convergence error' "$work/result" || { cat "$work/result"; exit 1; }
. "$base/profiles/jdk17.env"
curl -fsSL "$ARCHUNIT_URL" -o "$work/archunit.jar"
printf '%s  %s\n' "$ARCHUNIT_SHA256" "$work/archunit.jar" | shasum -a 256 -c -
curl -fsSL https://repo.maven.apache.org/maven2/org/slf4j/slf4j-api/2.0.17/slf4j-api-2.0.17.jar -o "$work/slf4j.jar"
# ArchUnit 的必要 runtime，固定版本及 SHA。
printf '%s  %s\n' '7b751d952061954d5abfed7181c1f645d336091b679891591d63329c622eb832' "$work/slf4j.jar" | shasum -a 256 -c -
cp="$work/archunit.jar:$work/slf4j.jar"
mkdir -p "$work/runner"
javac -cp "$cp" -d "$work/runner" "$base/archunit/RulesTemplate.java"
# 合成明確套件邊界；空套件不能讓規則假通過。
ruby - "$work" <<'RUBY'
require 'fileutils'
work = ARGV[0]
%w[arch-good arch-layer arch-internal arch-storage arch-shared arch-core arch-cycle].each do |mode|
  classes = {
    'internal/Hidden' => 'class Hidden {}',
    'domain/Model' => 'public class Model {}',
    'web/Endpoint' => 'public class Endpoint {}',
    'infrastructure/Database' => 'public class Database {}',
    'order/Order' => 'public class Order {}',
    'shared/Utility' => 'public class Utility { static class Storage {} }'
  }
  classes['domain/Model'] = 'public class Model { com.example.web.Endpoint endpoint; }' if mode == 'arch-layer'
  classes['internal/Hidden'] = 'public class Hidden {}' if mode == 'arch-internal'
  classes['shared/Utility'] = 'public class Utility { public static class Storage {} }' if mode == 'arch-storage'
  classes['shared/Utility'] = 'public class Utility { com.example.order.Order order; static class Storage {} }' if mode == 'arch-shared'
  classes['domain/Model'] = 'public class Model { com.example.infrastructure.Database db; }' if mode == 'arch-core'
  if mode == 'arch-cycle'
    classes['order/Order'] = 'public class Order { com.example.shared.Utility u; }'
    classes['shared/Utility'] = 'public class Utility { com.example.order.Order o; static class Storage {} }'
  end
  classes.each do |path, source|
    file = "#{work}/#{mode}/com/example/#{path}.java"
    FileUtils.mkdir_p(File.dirname(file)); File.write(file, "package com.example.#{path.split('/')[0]}; #{source}")
  end
end
RUBY
for mode in arch-good arch-layer arch-internal arch-storage arch-shared arch-core arch-cycle; do
    javac -d "$work/$mode" "$work/$mode"/com/example/*/*.java
    expected=1; [ "$mode" != arch-good ] || expected=0
    expect "$expected" "ArchUnit $mode" java -cp "$work/runner:$cp" RulesTemplate "$work/$mode"
    if [ "$expected" = 1 ]; then grep -q '\[JV-NP-' "$work/result"; fi
done
ruby - "$root" "$work" <<'RUBY_INNER'
require 'fileutils'
root, work = ARGV
text = File.read("#{root}/rules/stacks/java/common/naming-packages-docs.md")
section = text.split('<a id="java-package-boundaries"></a>', 2)[1].split('<a id=', 2)[0]
section.scan(/```java\n(.*?)```/m).first(2).each_with_index do |source, index|
  dir = "#{work}/storage-#{index}"; FileUtils.mkdir_p(dir)
  File.write("#{dir}/OrderService.java", "package com.example.order;\nimport java.util.Map;\nimport java.util.HashMap;\n" + source.first)
end
RUBY_INNER
cat > "$work/StorageCheck.java" <<'JAVA'
import com.tngtech.archunit.core.importer.ClassFileImporter;
class StorageCheck {
    public static void main(String[] args) {
        RulesTemplate.STORAGE.check(new ClassFileImporter().importPaths(args));
    }
}
JAVA
javac -cp "$work/runner:$cp" -d "$work/runner" "$work/StorageCheck.java"
for index in 0 1; do javac -d "$work/storage-$index" "$work/storage-$index/OrderService.java"; done
expect 1 'ArchUnit 規範 OrderStorage 負例' java -cp "$work/runner:$cp" StorageCheck "$work/storage-0"
grep -q '\[JV-NP-024\]' "$work/result"
expect 0 'ArchUnit 規範 OrderStorage 正例' java -cp "$work/runner:$cp" StorageCheck "$work/storage-1"
# Gradle 8.14.3 與片段實測；JDK 17 跑跨編譯目標 8，JDK 8 用平台類別。
gradle_bin=${GRADLE_BIN:-gradle}
if ! command -v "$gradle_bin" >/dev/null; then gradle_bin=/private/tmp/dev-rule-hook-assets/gradle-8.14.3/bin/gradle; fi
compiler=$(javac -version 2>&1 | sed 's/^javac //;s/^1\.//;s/\..*//')
mkdir -p "$work/gradle/src/main/java"
printf 'rootProject.name = "fixture"\n' > "$work/gradle/settings.gradle.kts"
cat > "$work/gradle/build.gradle.kts" <<KOTLIN
plugins { java }
repositories { mavenCentral() }
apply(from = "$base/build/gradle-enforcer.gradle.kts")
KOTLIN
printf 'devRuleCompiler=%s\ndevRuleRelease=8\ndevRuleBanned=junit:junit\n' "$compiler" > "$work/gradle/gradle.properties"
echo 'class Example { String text; }' > "$work/gradle/src/main/java/Example.java"
expect 0 'Gradle toolchain 正例' "$gradle_bin" --no-daemon -q -p "$work/gradle" compileJava
echo 'class Example { Object value = java.util.List.of("x"); }' > "$work/gradle/src/main/java/Example.java"
expect 1 'Gradle Java 8 API 限制負例' "$gradle_bin" --no-daemon -q -p "$work/gradle" compileJava
grep -q 'cannot find symbol' "$work/result"
echo 'class Example { String text; }' > "$work/gradle/src/main/java/Example.java"
printf '\ndependencies { implementation("junit:junit:4.13.2") }\n' >> "$work/gradle/build.gradle.kts"
expect 1 'Gradle 禁用依賴負例' "$gradle_bin" --no-daemon -q -p "$work/gradle" compileJava
grep -q '\[JV-VP-009\]' "$work/result"
printf 'devRuleCompiler=%s\ndevRuleRelease=8\ndevRuleBanned=no.such:artifact\n' "$compiler" > "$work/gradle/gradle.properties"
expect 0 'Gradle 允許依賴正例' "$gradle_bin" --no-daemon -q -p "$work/gradle" compileJava
printf '\ndependencies { implementation("org.hamcrest:hamcrest-core:1.1") }\n' >> "$work/gradle/build.gradle.kts"
expect 1 'Gradle 版本衝突負例' "$gradle_bin" --no-daemon -q -p "$work/gradle" compileJava
grep -qi 'conflict' "$work/result"
# CI 摘要器：正例、實際 pattern 映射、壞報告都必須可區分。
javac -encoding UTF-8 -d "$work/runner" "$base/ci/github/SpotbugsSummary.java" "$base/ci/github/LintSummary.java"
printf 'TEST=[JV-VP-021] 棄用 API → rules/stacks/java/common/version-policy.md#java-deprecated-api\n' > "$work/patterns.properties"
printf '<BugCollection/>\n' > "$work/spot-good.xml"
printf '<BugCollection><BugInstance type="TEST"/></BugCollection>\n' > "$work/spot-bad.xml"
printf '<BugCollection><MissingClass>missing.Type</MissingClass></BugCollection>\n' > "$work/spot-incomplete.xml"
expect 0 'SpotBugs 摘要乾淨報告' java -cp "$work/runner" SpotbugsSummary "$work/spot-good.xml" "$work/patterns.properties"
expect 1 'SpotBugs 摘要違規報告' java -cp "$work/runner" SpotbugsSummary "$work/spot-bad.xml" "$work/patterns.properties"
grep -q '\[JV-VP-021\]' "$work/result"
expect 1 'SpotBugs 摘要不完整報告拒絕' java -cp "$work/runner" SpotbugsSummary "$work/spot-incomplete.xml" "$work/patterns.properties"
printf 'warning: [rawtypes] found raw type\n' > "$work/lint.log"
expect 0 'javac 診斷映射' java -cp "$work/runner" LintSummary "$work/lint.log" "$base/rule-map.yml"
grep -q '\[JV-' "$work/result"
printf '# test\n-Xlint:none\n-Xlint:rawtypes\n-Xlint:unchecked\n' > "$work/lint.txt"
test "$(sh "$base/ci/github/lint-argument.sh" "$work/lint.txt")" = '-Xlint:rawtypes,unchecked'
echo 'PASS Maven lint 類別轉換（不含 -Xlint:none）'
ruby -ryaml -e 'YAML.load_file(ARGV[0]); puts "PASS workflow YAML"' "$root/.github/workflows/java-rules.yml"
echo '建置層全部情境通過'
