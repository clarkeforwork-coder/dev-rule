#!/usr/bin/env ruby
# 正式片段的整合回歸；輸出只保存在呼叫端指定的暫存目錄。
$stdout.sync = true
require 'tmpdir'
require 'fileutils'
require 'open3'
require 'shellwords'
ROOT = File.expand_path('../../..', __dir__)
OUT = File.expand_path(ARGV.fetch(0))
FileUtils.mkdir_p(OUT)
JDK = ENV.fetch('JAVA_HOME')
major = Open3.capture2e("#{JDK}/bin/java", '-version').first[/version "(?:1\.)?(\d+)/, 1].to_i
mvn = ENV.fetch('MAVEN_BIN', 'mvn')
gradle = ENV.fetch('GRADLE_BIN', 'gradle')
def run(dir, name, command, expected: 0, id: nil)
  output, status = Open3.capture2e(*command, chdir: dir)
  File.write("#{OUT}/#{name}.log", output)
  valid = expected == 0 ? status.success? : !status.success?
  valid &&= output.include?("[#{id}]") && output.include?(' → rules/') if id
  puts "#{valid ? 'PASS' : 'FAIL'} #{name} exit=#{status.exitstatus}#{id ? " #{id}" : ''}"
  puts output.lines.grep(/\[JV-|BUILD SUCCESS|BUILD FAILED|新增|基準/).uniq
  puts output unless valid
  raise "#{name} 失敗：#{OUT}/#{name}.log" unless valid
end
Dir.mktmpdir('java-ci-integration-') do |dir|
  FileUtils.mkdir_p("#{dir}/vendor")
  File.symlink(ROOT, "#{dir}/vendor/dev-rule")
  src = "#{dir}/src/main/java/com/example/internal"
  FileUtils.mkdir_p(src)
  good = "package com.example.internal;\nfinal class Hidden {}\n"
  File.write("#{src}/Hidden.java", good)
  FileUtils.mkdir_p("#{dir}/src/test/java/com/example")
  File.write("#{dir}/src/test/java/com/example/RulesTemplateTest.java", <<~JAVA)
    package com.example;
    import com.tngtech.archunit.core.importer.ClassFileImporter;
    import com.tngtech.archunit.lang.ArchRule;
    import org.junit.Test;
    import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.classes;
    public final class RulesTemplateTest {
        /** 驗證已核准的內部套件可見性。 */
        @Test public void architecture() {
            ArchRule internal = classes().that().resideInAPackage("..internal..")
                .should().notBePublic().because("[JV-NP-023] 套件與架構邊界 → rules/stacks/java/common/naming-packages-docs.md#java-package-boundaries");
            internal.check(new ClassFileImporter().importPackages("com.example.internal"));
        }
    }
  JAVA
  test_file = "#{dir}/src/test/java/com/example/RulesTemplateTest.java"
  test_source = File.read(test_file)
  File.write("#{dir}/gradlew", "#!/bin/sh\nexec #{Shellwords.escape(gradle)} \"$@\"\n")
  File.chmod(0755, "#{dir}/gradlew")
  pom = File.read("#{ROOT}/tools/java/ci/maven/pom-fragment.xml")
    .gsub(/(<maven.compiler.(?:source|target)>)[[:space:]]*17[[:space:]]*(<\/maven.compiler.(?:source|target)>)/) { "#{$1}#{major}#{$2}" }
    .sub('[17,18)', "[#{major},#{major + 1})")
  File.write("#{dir}/pom.xml", pom)
  File.write("#{dir}/settings.gradle.kts", 'rootProject.name = "fixture"')
  File.write("#{dir}/build.gradle.kts", "plugins { java }\nrepositories { mavenCentral() }\napply(from = \"vendor/dev-rule/tools/java/ci/gradle/rules.gradle.kts\")\n")
  File.write("#{dir}/gradle.properties", "devRuleCompiler=#{major}\ndevRuleRelease=#{major}\ndevRuleBanned=no.such:artifact\norg.gradle.workers.max=2\n")
  {'maven'=>[mvn, '-B'], 'gradle'=>[gradle, '--no-daemon', '--console=plain']}.each do |tool, cmd|
    File.write("#{src}/Hidden.java", good)
    full = tool == 'maven' ? %w[clean verify] : %w[clean check]
    compile = tool == 'maven' ? %w[clean test-compile] : %w[clean testClasses]
    run(dir, "#{tool}-good", cmd + full)
    {
      'javac'=>['final class Hidden { java.util.List raw; }', 'JV-TG-024'],
      'errorprone'=>['final class Hidden { void probe(String text) { text.trim(); } }', 'JV-LS-006']
    }.each do |name, (code, id)|
      File.write("#{src}/Hidden.java", "package com.example.internal;\n#{code}\n")
      run(dir, "#{tool}-#{name}", cmd + compile, expected: 1, id: id)
    end
    File.write("#{src}/Hidden.java", good.sub('final class', 'public final class'))
    test = tool == 'maven' ? %w[clean test -Dtest=RulesTemplateTest] : %w[clean test --tests *RulesTemplateTest]
    run(dir, "#{tool}-archunit", cmd + test, expected: 1, id: 'JV-NP-023')
    File.write("#{src}/Hidden.java", good)
    enforcer = tool == 'maven' ? %w[validate -Ddev-rule.banned=junit:junit] : %w[devRuleDependencies -PdevRuleBanned=junit:junit]
    run(dir, "#{tool}-enforcer", cmd + enforcer, expected: 1, id: tool == 'maven' ? 'JV-VP-010' : 'JV-VP-009')
    File.write("#{src}/Hidden.java", "package com.example.internal;\nfinal class Hidden { private volatile int value; void increment() { value++; } }\n")
    spot = tool == 'maven' ? %w[clean test-compile dependency:build-classpath -Dmdep.outputFile=target/dev-rule-classpath spotbugs:spotbugs exec:exec@dev-rule-bytecode] : %w[clean devRuleBytecode]
    run(dir, "#{tool}-spotbugs", cmd + spot, expected: 1, id: 'JV-CA-004')
    File.write(test_file, test_source.sub("    /** 驗證已核准的內部套件可見性。 */\n", ''))
    run(dir, "#{tool}-checkstyle", cmd + (tool == 'maven' ? %w[checkstyle:check] : %w[checkstyleTest]), expected: 1, id: 'JV-NP-031')
    File.write(test_file, test_source)
    # 原生編譯建立合法 bytecode，使掃描器獨立負例不被前面的 javac 門檻先攔截。
    File.write("#{src}/Hidden.java", good)
    run(dir, "#{tool}-restore", cmd + full)
    classes = tool == 'maven' ? 'target/classes' : 'build/classes/java/main'
    tests = tool == 'maven' ? 'target/test-classes' : 'build/classes/java/test'
    cp = tool == 'maven' ? 'target/dev-rule-classpath' : '.java-rules-classpath'
    reports = tool == 'maven' ? ['target/spotbugsXml.xml'] : ['build/reports/spotbugs/main.xml', 'build/reports/spotbugs/test.xml']
    {'jdeps'=>['sun.misc.Unsafe value;', 'JV-VP-016'], 'jdeprscan'=>['int year(java.util.Date value) { return value.getYear(); }', 'JV-VP-021']}.each do |name, (body, id)|
      next if name == 'jdeprscan' && major == 8
      File.write("#{dir}/Injected.java", "final class Injected { #{body} }\n")
      run(dir, "#{tool}-#{name}-compile", ["#{JDK}/bin/javac", '-d', classes, 'Injected.java'])
      run(dir, "#{tool}-#{name}", ['sh', "#{ROOT}/tools/java/ci/verify.sh", classes, tests, cp] + reports, expected: 1, id: id)
      File.delete("#{dir}/#{classes}/Injected.class")
    end
    # 先產生完整報告，再建立既有違規基準；新增同型違規仍須被擋。
    File.write("#{src}/Hidden.java", "package com.example.internal;\nfinal class Hidden { java.util.List<?> existing() { return java.util.Collections.emptyList(); } }\n")
    report_tasks = tool == 'maven' ? %w[checkstyle:checkstyle pmd:pmd] : %w[-PdevRuleBaseline checkstyleMain checkstyleTest pmdMain pmdTest]
    run(dir, "#{tool}-baseline-reports", cmd + report_tasks)
    reports = tool == 'maven' ? %w[--pmd target/pmd.xml --checkstyle target/checkstyle-result.xml] : %w[--pmd build/reports/pmd/main.xml --pmd build/reports/pmd/test.xml --checkstyle build/reports/checkstyle/main.xml --checkstyle build/reports/checkstyle/test.xml]
    FileUtils.rm_f("#{dir}/dev-rule-baseline.tsv")
    baseline = ['sh', "#{ROOT}/tools/java/baseline/run.sh"]
    run(dir, "#{tool}-baseline-create", baseline + %w[create --baseline dev-rule-baseline.tsv --owner integration --due 2027-01-01] + reports)
    run(dir, "#{tool}-baseline-existing", baseline + %w[check --baseline dev-rule-baseline.tsv] + reports)
    run(dir, "#{tool}-baseline-build", cmd + (tool == 'maven' ? %w[-Pdev-rule-baseline clean verify] : %w[-PdevRuleBaseline clean check]))
    run(dir, "#{tool}-workflow-runner", ['env', "PATH=#{File.dirname(mvn)}:#{ENV.fetch('PATH')}",
      "JAVA_VERSION=#{major}", "BUILD_TOOL=#{tool}", 'sh', "#{ROOT}/tools/java/ci/github/run.sh"])
    File.open("#{src}/Hidden.java", 'a') { |file| file.puts('final class Added { java.util.List<?> added() { return java.util.Collections.emptyList(); } }') }
    run(dir, "#{tool}-baseline-new-reports", cmd + report_tasks)
    run(dir, "#{tool}-baseline-new", baseline + %w[check --baseline dev-rule-baseline.tsv] + reports, expected: 1, id: 'JV-TG-026')
  end
end
