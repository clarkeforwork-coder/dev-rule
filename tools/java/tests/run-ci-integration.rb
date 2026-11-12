#!/usr/bin/env ruby
# 正式片段的整合回歸；輸出只保存在呼叫端指定的暫存目錄。
$stdout.sync = true
require 'tmpdir'
require 'fileutils'
require 'open3'
require 'shellwords'
require 'rexml/document'
ROOT = File.expand_path('../../..', __dir__)
OUT = File.expand_path(ARGV.fetch(0))
FileUtils.mkdir_p(OUT)
JDK = ENV.fetch('JAVA_HOME')
major = Open3.capture2e("#{JDK}/bin/java", '-version').first[/version "(?:1\.)?(\d+)/, 1].to_i
mvn = ENV.fetch('MVN_BIN', 'mvn')
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
  output
end
validator = ['sh', "#{ROOT}/tools/java/ci/github/validate-inputs.sh"]
{'java-version'=>['JAVA_VERSION', '22'], 'build-tool'=>['BUILD_TOOL', 'ant'],
 'project-directory-absolute'=>['PROJECT_DIRECTORY', '/tmp/project'],
 'project-directory-parent'=>['PROJECT_DIRECTORY', 'app/../other']}.each do |name, (key, value)|
  env = {'JAVA_VERSION'=>'17', 'BUILD_TOOL'=>'maven', 'PROJECT_DIRECTORY'=>'.', key=>value}
  output, status = Open3.capture2e(env, *validator)
  raise "輸入拒絕失敗：#{name}" unless status.exitstatus == 2 && output.include?(name.sub(/-(absolute|parent)$/, ''))
  puts "PASS workflow 輸入拒絕 #{name} exit=#{status.exitstatus}"
end
run(ROOT, 'workflow-input-good', ['env', 'JAVA_VERSION=17', 'BUILD_TOOL=gradle', 'PROJECT_DIRECTORY=app', *validator])
Dir.mktmpdir('workflow-unit-') do |dir|
  summary = "#{dir}/summary.md"
  File.write(summary, "```\n<script>test</script>\n````\n")
  output = run(dir, 'summary-fence', ['sh', "#{ROOT}/tools/java/ci/github/summary.sh", summary])
  raise 'summary fence 不足' unless output.start_with?("\n`````text\n") && output.end_with?("\n`````\n")
  run(dir, 'architecture-checker-compile', ["#{JDK}/bin/javac", '-encoding', 'UTF-8', '-d', dir, "#{ROOT}/tools/java/ci/github/ArchitectureReports.java"])
  checker = ["#{JDK}/bin/java", '-cp', dir, 'ArchitectureReports']
  run(dir, 'architecture-missing', checker, expected: 1)
  [[0, 0, 1], [2, 2, 1], [2, 1, 0], [1, 0, 0]].each do |tests, skipped, expected|
    File.write("#{dir}/TEST-RulesTemplateTest.xml", %(<testsuite tests="#{tests}" skipped="#{skipped}"/>))
    run(dir, "architecture-tests-#{tests}-skipped-#{skipped}", checker + ["#{dir}/TEST-RulesTemplateTest.xml"], expected: expected)
  end
end
Dir.mktmpdir('helper-cache-test-') do |dir|
  source = "#{dir}/PolicyCompiler.java"
  FileUtils.cp("#{ROOT}/tools/java/ci/compiler/PolicyCompiler.java", source)
  command = ['sh', '-c', 'base=$1; . "$base/ci/helper-cache.sh"; helper_classes "$2" "$3"', 'helper-test', "#{ROOT}/tools/java", source, "#{dir}/build/dev-rule-tools"]
  first = run(dir, 'helper-first-compile', command)
  reused = run(dir, 'helper-source-unchanged', command)
  raise '來源不變卻重編' if reused.include?('dev-rule helper compile:')
  raise '首次未編譯' unless first.include?('dev-rule helper compile: PolicyCompiler')
  File.open(source, 'a') { |file| file.puts('// 回歸：來源改動必須重新編譯') }
  changed = run(dir, 'helper-source-changed', command)
  raise '來源變動未重新編譯' unless changed.include?('dev-rule helper compile: PolicyCompiler') && changed.lines.last != first.lines.last
  puts 'PASS helper-source-sha256 首次=1、重用=0、改動來源=1'
end
skips = []

available = lambda do |binary|
  binary.include?('/') ? File.executable?(binary) : ENV.fetch('PATH').split(File::PATH_SEPARATOR).any? { |path| File.executable?(File.join(path, binary)) }
end
Dir.mktmpdir('java-ci-integration-') do |dir|
  # 不提供 vendored 副本，確認兩種建置工具確實使用明確傳入的中立根目錄。
  src = "#{dir}/src/main/java/com/example/internal"
  FileUtils.mkdir_p(src)
  good = "package com.example.internal;\nfinal class Hidden {}\n"
  File.write("#{src}/Hidden.java", good)
  FileUtils.mkdir_p("#{dir}/src/test/java/com/example")
  File.write("#{dir}/src/test/java/com/example/RulesTemplateTest.java", <<~JAVA)
    package com.example;
    import com.tngtech.archunit.core.importer.ClassFileImporter;
    import com.tngtech.archunit.lang.ArchRule;
    import org.junit.jupiter.api.Test;
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
  File.write("#{dir}/build.gradle.kts", "plugins { java }\nrepositories { mavenCentral() }\ndependencies { testImplementation(platform(\"org.junit:junit-bom:5.12.2\")); testImplementation(\"org.junit.jupiter:junit-jupiter\"); testImplementation(\"com.tngtech.archunit:archunit:1.4.1\"); testRuntimeOnly(\"org.junit.platform:junit-platform-launcher\") }\ntasks.test { useJUnitPlatform() }\napply(from = \"${property(\"devRuleRoot\")}/tools/java/ci/gradle/rules.gradle.kts\")\n")
  File.write("#{dir}/gradle.properties", "devRuleCompiler=#{major}\ndevRuleRelease=#{major}\ndevRuleBanned=\norg.gradle.workers.max=2\n")
  {'maven'=>[mvn, '-B', "-Ddev-rule.root=#{ROOT}"], 'gradle'=>[gradle, '--no-daemon', '--console=plain', "-PdevRuleRoot=#{ROOT}"]}.each do |tool, cmd|
    unless available.call(cmd.first)
      skips << "#{tool} 整合：請設定 #{tool == 'maven' ? 'MVN_BIN' : 'GRADLE_BIN'} 或加入 PATH"
      next
    end
    File.write("#{src}/Hidden.java", good)
    full = tool == 'maven' ? %w[clean verify] : %w[clean check]
    compile = tool == 'maven' ? %w[clean test-compile] : %w[clean testClasses]
    trace = "#{OUT}/#{tool}-helper-compiles.txt"
    FileUtils.rm_f(trace)
    run(dir, "#{tool}-good", ['env', "DEV_RULE_HELPER_TRACE=#{trace}", *cmd, *full])
    count = File.readlines(trace).count { |line| line.start_with?('PolicyCompiler ') }
    raise "PolicyCompiler 編譯次數 #{count} 不等於 1" unless count == 1
    puts "PASS #{tool}-helper-compilation-count PolicyCompiler=#{count}（DEV_RULE_HELPER_TRACE 記錄成功編譯）"
    cache = "#{dir}/#{tool == 'maven' ? 'target' : 'build'}/dev-rule-tools"
    compiled = Dir.glob("#{cache}/PolicyCompiler-*/PolicyCompiler.class")
    raise 'PolicyCompiler 未使用單一原始碼快取' unless compiled.size == 1

    # 以兩種框架實際產生的首次建置 XML 驗證相同門檻。
    checker_dir = File.join(OUT, 'architecture-checker')
    FileUtils.mkdir_p(checker_dir)
    run(dir, "#{tool}-checker-compile", ["#{JDK}/bin/javac", '-encoding', 'UTF-8', '-d', checker_dir, "#{ROOT}/tools/java/ci/github/ArchitectureReports.java"])
    check_reports = lambda do |framework|
      pattern = tool == 'maven' ? 'target/surefire-reports/TEST-*RulesTemplateTest.xml' : 'build/test-results/*/TEST-*RulesTemplateTest.xml'
      run(dir, "#{tool}-#{framework}-xml", ["#{JDK}/bin/java", '-cp', checker_dir, 'ArchitectureReports'] + Dir.glob("#{dir}/#{pattern}"))
    end
    check_reports.call('junit5')
    build_file = "#{dir}/#{tool == 'maven' ? 'pom.xml' : 'build.gradle.kts'}"
    original_build = File.read(build_file)
    junit4_build = if tool == 'maven'
      original_build.sub('  <profiles>', '<dependencies><dependency><groupId>junit</groupId><artifactId>junit</artifactId><version>4.13.2</version><scope>test</scope></dependency></dependencies>' + "\n  <profiles>")
    else
      original_build.sub(/dependencies \{.*?\}/, 'dependencies { testImplementation("junit:junit:4.13.2"); testImplementation("com.tngtech.archunit:archunit:1.4.1") }').sub('useJUnitPlatform()', 'useJUnit()')
    end
    File.write(build_file, junit4_build)
    File.write(test_file, test_source.sub('org.junit.jupiter.api.Test', 'org.junit.Test'))
    junit4_cmd = tool == 'maven' ? cmd + ['-Ddev-rule.test-framework=junit4'] : cmd
    ordinary_test = "#{dir}/src/test/java/com/example/OrdinaryTest.java"
    File.write(ordinary_test, <<~JAVA)
      package com.example;
      public final class OrdinaryTest {
          /** 驗證專案原有的 JUnit 4 測試仍會執行。 */
          @org.junit.Test public void ordinary() { org.junit.Assert.assertTrue(true); }
      }
    JAVA
    if tool == 'maven'
      output = run(dir, 'maven-junit4-no-flag', cmd + full, expected: 1)
      raise '缺少 JUnit 4 選擇訊息' unless output.include?('JUnit 4 專案設 -Ddev-rule.test-framework=junit4') && output.include?('.mvn/maven.config') && output.include?('org.junit.vintage:junit-vintage-engine')
      puts 'PASS maven-junit4-no-flag 訊息正確'
    end
    run(dir, "#{tool}-junit4-good", junit4_cmd + full)

    ordinary_report = tool == 'maven' ? 'target/surefire-reports/TEST-com.example.OrdinaryTest.xml' : 'build/test-results/test/TEST-com.example.OrdinaryTest.xml'
    suite = REXML::Document.new(File.read("#{dir}/#{ordinary_report}")).root
    raise '專案 JUnit 4 測試未執行' unless suite.attributes['tests'] == '1' && suite.attributes['skipped'] == '0'
    puts "PASS #{tool}-junit4-original tests=1 skipped=0"
    check_reports.call('junit4')
    if tool == 'maven'
      # 合併頂層 dependencies，避免兩個同層元素。
      mixed = junit4_build.sub('</dependencies>', '<dependency><groupId>org.junit.vintage</groupId><artifactId>junit-vintage-engine</artifactId><scope>test</scope></dependency></dependencies>')
      File.write(build_file, mixed)
      File.write(test_file, test_source)
      run(dir, 'maven-junit-mixed', cmd + full)
      %w[OrdinaryTest RulesTemplateTest].each do |name|
        suite = REXML::Document.new(File.read("#{dir}/target/surefire-reports/TEST-com.example.#{name}.xml")).root
        raise "混用測試未執行：#{name}" unless suite.attributes['tests'] == '1' && suite.attributes['skipped'] == '0'
        puts "PASS maven-junit-mixed #{name} tests=1 skipped=0"
      end
      project_bom = '<dependencyManagement><dependencies><dependency><groupId>org.junit</groupId><artifactId>junit-bom</artifactId><version>5.11.4</version><type>pom</type><scope>import</scope></dependency></dependencies></dependencyManagement>'
      File.write(build_file, original_build.sub('  <profiles>', project_bom + '  <profiles>'))
      output = run(dir, 'maven-project-junit-bom', cmd + ['dependency:tree', '-Dincludes=org.junit.jupiter:*,org.junit.platform:*'])
      raise '專案 BOM 對齊回歸' unless output.include?('junit-jupiter:jar:5.12.2') && output.include?('junit-jupiter-api:jar:5.12.2') && output.include?('junit-jupiter-engine:jar:5.12.2') && output.include?('junit-platform-engine:jar:1.12.2')
      puts output.lines.grep(/org.junit.(jupiter|platform)/)
      output = run(dir, 'maven-project-junit-bom-aligned', cmd + ['-Ddev-rule.junit.version=5.11.4', 'dependency:tree', '-Dincludes=org.junit.jupiter:*,org.junit.platform:*'])
      raise '指定 BOM 未對齊' unless output.include?('junit-jupiter:jar:5.11.4') && output.include?('junit-jupiter-api:jar:5.11.4') && output.include?('junit-jupiter-engine:jar:5.11.4') && output.include?('junit-platform-engine:jar:1.11.4')
      puts output.lines.grep(/org.junit.(jupiter|platform)/)
    end
    File.delete(ordinary_test)
    File.write(build_file, original_build)
    File.write(test_file, test_source)
    if tool == 'gradle'
      processor_dir = "#{dir}/processor-classes"
      FileUtils.mkdir_p("#{processor_dir}/META-INF/services")
      File.write("#{dir}/ProbeProcessor.java", <<~JAVA)
        import java.util.Set;
        import javax.annotation.processing.*;
        import javax.lang.model.SourceVersion;
        import javax.lang.model.element.TypeElement;
        @SupportedAnnotationTypes("*")
        public class ProbeProcessor extends AbstractProcessor {
            public SourceVersion getSupportedSourceVersion() { return SourceVersion.latestSupported(); }
            public boolean process(Set<? extends TypeElement> annotations, RoundEnvironment round) {
                if (!round.processingOver()) {
                    try { processingEnv.getFiler().createResource(javax.tools.StandardLocation.CLASS_OUTPUT, "", "processor-ran").openWriter().close(); }
                    catch (java.io.IOException failure) { throw new RuntimeException(failure); }
                }
                return false;
            }
        }
      JAVA
      run(dir, 'gradle-processor-compile', ["#{JDK}/bin/javac", '-d', processor_dir, "#{dir}/ProbeProcessor.java"])
      File.write("#{processor_dir}/META-INF/services/javax.annotation.processing.Processor", "ProbeProcessor\n")
      run(dir, 'gradle-processor-jar', ["#{JDK}/bin/jar", 'cf', "#{dir}/processor.jar", '-C', processor_dir, '.'])
      %w[implementation annotationProcessor].each do |configuration|
        File.write(build_file, original_build + "\ndependencies { #{configuration}(files(\"processor.jar\")) }\n")
        %w[on off].each do |replacement|
          run(dir, "gradle-processor-#{configuration}-#{replacement}", cmd + ["-PdevRuleCompilerReplacement=#{replacement}", 'clean', 'compileJava'])
          executed = File.exist?("#{dir}/build/classes/java/main/processor-ran")
          raise "processor 探索分歧：#{configuration}/#{replacement}" unless executed == (configuration == 'annotationProcessor')
          puts "PASS gradle-processor-#{configuration}-#{replacement} executed=#{executed}"
        end
      end
      File.write(build_file, original_build)
    end
    {
      'javac'=>["final class Hidden {\n java.util.List first;\n java.util.List second;\n java.util.List third;\n}", 'JV-TG-024'],
      'errorprone'=>['final class Hidden { void probe(String text) { text.trim(); } }', 'JV-LS-006']
    }.each do |name, (code, id)|
      File.write("#{src}/Hidden.java", "package com.example.internal;\n#{code}\n")
      output = run(dir, "#{tool}-#{name}", cmd + compile, expected: 1, id: id)
      if name == 'javac'
        diagnostics = output.lines.grep(/\[rawtypes\]/).uniq
        raise '三個 raw type 診斷未各帶 ID' unless diagnostics.size >= 3 && diagnostics.all? { |line| line.include?('[JV-TG-024]') }
      end
    end
    File.write("#{src}/Hidden.java", good.sub('final class', 'public final class'))
    test = tool == 'maven' ? %w[clean test -Dtest=RulesTemplateTest] : %w[clean test --tests *RulesTemplateTest]
    run(dir, "#{tool}-archunit", cmd + test, expected: 1, id: 'JV-NP-023')
    File.write("#{src}/Hidden.java", good)
    enforcer = tool == 'maven' ? %w[validate -Ddev-rule.banned=org.junit.jupiter:junit-jupiter-api] : %w[devRuleDependencies -PdevRuleBanned=org.junit.jupiter:junit-jupiter-api]
    run(dir, "#{tool}-enforcer", cmd + enforcer, expected: 1, id: tool == 'maven' ? 'JV-VP-010' : 'JV-VP-009')
    File.write("#{src}/Hidden.java", "package com.example.internal;\nfinal class Hidden { private volatile int value; void increment() { value++; } }\n")
    spot = tool == 'maven' ? %w[clean test-compile dependency:build-classpath -Dmdep.outputFile=target/dev-rule-classpath spotbugs:spotbugs exec:exec@dev-rule-bytecode] : %w[clean devRuleBytecode]
    run(dir, "#{tool}-spotbugs", cmd + spot, expected: 1, id: 'JV-CA-004')
    File.write("#{src}/Hidden.java", "package com.example.internal;\nfinal class Hidden { void BadName() {} }\n")
    classes = tool == 'maven' ? 'target/classes' : 'build/classes/java/main'
    run(dir, "#{tool}-priority3-compile", ["#{JDK}/bin/javac", '-d', classes, "#{src}/Hidden.java"])
    scan = tool == 'maven' ? %w[spotbugs:spotbugs exec:exec@dev-rule-bytecode] : %w[devRuleBytecode -x compileJava -x compileTestJava]
    run(dir, "#{tool}-spotbugs-priority3", cmd + scan, expected: 1, id: 'JV-NP-020')
    xml = tool == 'maven' ? 'target/spotbugsXml.xml' : 'build/reports/spotbugs/main.xml'
    report = REXML::Document.new(File.read("#{dir}/#{xml}"))
    raise '未實際掃出 priority 3' unless REXML::XPath.first(report, '//BugInstance[@type="NM_METHOD_NAMING_CONVENTION"]/@priority').to_s == '3'
    File.write("#{src}/Hidden.java", "package com.example.internal;\nfinal class Hidden { java.util.Optional<Integer> read(java.nio.file.Path path) { try { return java.util.Optional.of(Integer.parseInt(new String(java.nio.file.Files.readAllBytes(path), java.nio.charset.StandardCharsets.UTF_8).trim())); } catch (Exception failure) { return java.util.Optional.empty(); } } }\n")
    run(dir, "#{tool}-warn-compile", ["#{JDK}/bin/javac", '-d', classes, "#{src}/Hidden.java"])
    run(dir, "#{tool}-spotbugs-warn", cmd + scan, id: 'JV-ER-011')
    File.write("#{src}/Hidden.java", good)
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
    output = run(dir, "#{tool}-baseline-missing-build", cmd + (tool == 'maven' ? %w[-Pdev-rule-baseline clean verify] : %w[-PdevRuleBaseline clean check]), expected: 1)
    raise '缺少基準失敗未指出基準檔' unless output.include?('dev-rule-baseline.tsv')
    run(dir, "#{tool}-baseline-create", baseline + %w[create --baseline dev-rule-baseline.tsv --owner integration --due 2027-01-01] + reports)
    run(dir, "#{tool}-baseline-existing", baseline + %w[check --baseline dev-rule-baseline.tsv] + reports)
    run(dir, "#{tool}-baseline-build", cmd + (tool == 'maven' ? %w[-Pdev-rule-baseline clean verify] : %w[-PdevRuleBaseline clean check]))
    if tool == 'gradle'
      output = run(dir, 'gradle-baseline-excluded-pmdMain', cmd + %w[-PdevRuleBaseline check -x pmdMain], expected: 1)
      raise '未拒絕必要工作排除' unless output.include?('基準必要工作被排除')
    end
    # 專案即使關閉替換，CI 入口也必須覆寫；用 rawtypes 負例確認不是只檢查參數字串。
    if tool == 'gradle'
      File.open("#{dir}/gradle.properties", 'a') { |file| file.puts('devRuleCompilerReplacement=off') }
      File.write("#{src}/Hidden.java", "package com.example.internal;\nfinal class Hidden { java.util.List value; }\n")
      run(dir, 'gradle-workflow-forces-compiler', ['env', "JAVA_VERSION=#{major}", 'BUILD_TOOL=gradle', 'sh', "#{ROOT}/tools/java/ci/github/run.sh"], expected: 1, id: 'JV-TG-024')
      File.write("#{src}/Hidden.java", "package com.example.internal;\nfinal class Hidden { java.util.List<?> existing() { return java.util.Collections.emptyList(); } }\n")
    end
    run(dir, "#{tool}-workflow-runner", ['env', "MVN_BIN=#{mvn}", "PATH=#{File.dirname(mvn)}:#{ENV.fetch('PATH')}",
      "JAVA_VERSION=#{major}", "BUILD_TOOL=#{tool}", 'sh', "#{ROOT}/tools/java/ci/github/run.sh"])
    File.open("#{src}/Hidden.java", 'a') { |file| file.puts('final class Added { java.util.List<?> added() { return java.util.Collections.emptyList(); } }') }
    run(dir, "#{tool}-workflow-runner-new", ['env', "MVN_BIN=#{mvn}", "JAVA_VERSION=#{major}", "BUILD_TOOL=#{tool}", 'sh', "#{ROOT}/tools/java/ci/github/run.sh"], expected: 1)
    raise '新增違規未寫入 summary' unless File.read("#{dir}/java-rules-reports/summary.md").include?('[JV-')
    run(dir, "#{tool}-baseline-new-reports", cmd + report_tasks)
    run(dir, "#{tool}-baseline-new", baseline + %w[check --baseline dev-rule-baseline.tsv] + reports, expected: 1, id: 'JV-TG-026')
  end
end
puts skips.map { |message| "SKIP #{message}" }
puts "整合總結：略過 #{skips.size} 個建置工具情境（不計為通過）"
