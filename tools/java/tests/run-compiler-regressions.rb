#!/usr/bin/env ruby
# 測試正式編譯入口的診斷、特殊路徑及大量參數；Ruby 僅用於本庫。
require 'tmpdir'
require 'fileutils'
require 'open3'
require 'shellwords'
base = File.expand_path('..', __dir__)
jdk = ENV.fetch('JAVA_HOME')
Dir.mktmpdir('compiler-regressions-') do |work|
  classes = File.join(work, 'runner')
  FileUtils.mkdir_p(classes)
  output, status = Open3.capture2e("#{jdk}/bin/javac", '-encoding', 'UTF-8', '-d', classes, "#{base}/ci/compiler/PolicyCompiler.java")
  abort output unless status.success?
  source_dir = File.join(work, '空白 "引號')
  FileUtils.mkdir_p(source_dir)
  source = File.join(source_dir, 'Probe.java')
  File.write(source, "class Probe {\n java.util.List first;\n java.util.List second;\n java.util.List third;\n}\n")
  output_classes = File.join(work, 'output')
  FileUtils.mkdir_p(output_classes)
  argfile = File.join(work, 'input.args')
  quote = ->(arg) { '"' + arg.gsub(/[\\"]/) { |c| '\\' + c } + '"' }
  File.write(argfile, ['-encoding', 'UTF-8', '-d', output_classes, source].map(&quote).join("\n"))
  output, status = Open3.capture2e("#{base}/ci/compiler/javac.sh", "@#{argfile}")
  diagnostics = output.lines.grep(/\[rawtypes\]/)
  abort "每行診斷或特殊路徑失敗：#{output}" unless status.exitstatus == 1 && diagnostics.size == 3 && diagnostics.all? { |s| s.include?('[JV-TG-024]') && s.include?(' → rules/') }
  puts 'PASS 正式編譯入口：空白／引號／中文路徑，三筆 raw type 各帶 ID 與錨點'
  abort '政策失敗後殘留 class' unless Dir["#{output_classes}/**/*.class"].empty?
  output, status = Open3.capture2e("#{base}/ci/compiler/javac.sh", "@#{argfile}")
  abort "重編未再次阻擋：#{output}" unless status.exitstatus == 1 && output.include?('[JV-TG-024]')
  puts 'PASS 政策失敗清除 class，第二次編譯仍阻擋'
  File.write(source, "class Probe {\n" + (1..150).map { |i| "sun.misc.Unsafe value#{i};\n" }.join + "java.util.List raw;\n}\n")
  output, status = Open3.capture2e("#{base}/ci/compiler/javac.sh", '-Xmaxwarns', '1', '-d', output_classes, source)
  abort "大量 Attr 警告截斷政策診斷：#{output}" unless status.exitstatus == 1 && output.lines.any? { |l| l.include?('[rawtypes]') && l.include?('[JV-TG-024]') }
  puts 'PASS 150 筆 Attr 未映射警告後的 rawtypes 仍帶 ID 並阻擋（覆寫消費端上限）'
  processor_dir = File.join(work, 'processor')
  FileUtils.mkdir_p("#{processor_dir}/META-INF/services")
  processor_source = File.join(work, 'ProbeProcessor.java')
  File.write(processor_source, <<~JAVA)
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
          catch (java.io.IOException e) { throw new RuntimeException(e); }
        }
        return false;
      }
    }
  JAVA
  output, status = Open3.capture2e("#{jdk}/bin/javac", '-d', processor_dir, processor_source)
  abort output unless status.success?
  File.write("#{processor_dir}/META-INF/services/javax.annotation.processing.Processor", "ProbeProcessor\n")
  File.write(source, 'class Probe {}')
  output, status = Open3.capture2e("#{base}/ci/compiler/javac.sh", '-classpath', processor_dir, '-d', output_classes, source)
  abort "classpath processor 未執行：#{output}" unless status.success? && File.exist?("#{output_classes}/processor-ran")
  puts 'PASS 未指定 processorpath 時保留 classpath annotation processor 探索'
  fake = File.join(work, 'fake-jdk')

  FileUtils.mkdir_p("#{fake}/bin")
  recorded = File.join(work, 'recorded.args')
  File.write("#{fake}/bin/javac", <<~SH)
    #!/bin/sh
    set -eu
    count=0
    for arg do
      case "$arg" in
        -J*) ;;
        @*) count=$((count + 1)); cp "${arg#@}" #{Shellwords.escape(recorded)} ;;
        *) echo '非 JVM 參數未寫入 argfile' >&2; exit 2 ;;
      esac
    done
    test "$count" = 1
  SH
  File.chmod(0755, "#{fake}/bin/javac")
  arguments = Array.new(30_000) { |i| File.join(source_dir, 'x' * 100, "Source#{i}.java") }
  File.write(argfile, arguments.map(&quote).join("\n"))
  output, status = Open3.capture2e({'JAVA_HOME'=>fake}, "#{jdk}/bin/java", '-cp', classes, 'PolicyCompiler', base, "@#{argfile}")
  abort "大量參數失敗：#{output}" unless status.success? && File.size(recorded) > 3_000_000
  recorded_text = File.read(recorded)
  abort '來源檔參數遺失' unless arguments.all? { |a| recorded_text.include?(quote.call(a)) }
  puts 'PASS 最終 javac argv 僅保留 JVM 選項及一個 argfile；30,000 個來源參數（超過 3 MB）完整保留'
  # 隔離政策測試診斷映射及原始 javac 非零退出碼，不依賴特定 JDK 的 check 集合。
  policy = File.join(work, 'policy')
  FileUtils.mkdir_p(policy)
  %w[profiles javac errorprone].each { |dir| FileUtils.cp_r("#{base}/#{dir}", policy) }
  File.write("#{policy}/rule-map.yml", <<~YAML)
    - id: JV-TEST-001
      tool: javac
      check: -Xlint:fixturewarn
      title: 警告測試
      rule: rules/test.md#warn
      level: warn
      status: partial
    - id: JV-TEST-002
      tool: errorprone
      check: FixtureCandidate
      title: 候選測試
      rule: rules/test.md#candidate
      level: error
      status: candidate
  YAML
  File.write("#{fake}/bin/javac", "#!/bin/sh\nprintf '%s\n' 'Probe.java:1: warning: [fixturewarn] warning' 'Probe.java:2: warning: [FixtureCandidate] candidate'\nexit 0\n")
  output, status = Open3.capture2e({'JAVA_HOME'=>fake}, "#{jdk}/bin/java", '-cp', classes, 'PolicyCompiler', policy)
  abort "warn/candidate 映射失敗：#{output}" unless status.success? && output.include?('[JV-TEST-001]') && !output.include?('[JV-TEST-002]')
  File.write("#{fake}/bin/javac", "#!/bin/sh\necho 'error: invalid flag: --invalid-option'\nexit 2\n")
  output, status = Open3.capture2e({'JAVA_HOME'=>fake}, "#{jdk}/bin/java", '-cp', classes, 'PolicyCompiler', policy)
  abort "javac 退出碼遺失：#{output}" unless status.exitstatus == 2 && output.include?('invalid flag')
  File.write(source, 'class Probe { missing syntax }')
  output, status = Open3.capture2e("#{base}/ci/compiler/javac.sh", '-d', output_classes, source)
  abort "一般編譯錯誤退出碼錯誤：#{output}" unless status.exitstatus == 1
  puts 'PASS 已映射 warn 標註且退出 0、candidate 不標註、javac 編譯錯誤／參數錯誤退出碼保留'
  File.write(source, 'class Probe {}')
  output, status = Open3.capture2e("#{jdk}/bin/javac", '-d', output_classes, source)
  abort output unless status.success?
  output, status = Open3.capture2e({'JAVA_TOOL_OPTIONS'=>'-Dfoo=bar'}, "#{base}/build/jdeps.sh", output_classes)
  abort "JAVA_TOOL_OPTIONS 干擾 jdeps：#{output}" unless status.success?
  if File.executable?("#{jdk}/bin/jdeprscan")
    File.write(source, 'class Probe { @Override protected void finalize() {} }')
    output, status = Open3.capture2e("#{jdk}/bin/javac", '-d', output_classes, source)
    abort output unless status.success?
    version = Open3.capture2e("#{jdk}/bin/javac", '-version').first[/javac (?:1\.)?(\d+)/, 1]
    output, status = Open3.capture2e({'JAVA_TOOL_OPTIONS'=>'-Dfoo=bar'}, "#{base}/build/jdeprscan.sh", '--release', version, output_classes)
    abort "overrides 未辨識：#{output}" unless status.exitstatus == 1 && output.include?('overrides deprecated') && output.include?('[JV-VP-021]')
    puts 'PASS JAVA_TOOL_OPTIONS 不干擾 jdeps／jdeprscan；overrides deprecated 以 JV-VP-021 阻擋'
  else
    puts 'PASS JAVA_TOOL_OPTIONS 不干擾 jdeps；SKIP JDK 8 無 jdeprscan'
  end
  # verify.sh 使用真實 JDK 版本解析，替身掃描器記錄收到的 API 資料庫版本。
  verify_base = File.join(work, 'verify')
  FileUtils.mkdir_p(["#{verify_base}/ci/github", "#{verify_base}/build", "#{verify_base}/tests"])
  FileUtils.cp("#{base}/ci/verify.sh", "#{verify_base}/ci/verify.sh")
  FileUtils.cp("#{base}/ci/github/SpotbugsSummary.java", "#{verify_base}/ci/github/SpotbugsSummary.java")
  File.write("#{verify_base}/tests/RulesTemplateTest.class", '')
  File.write("#{verify_base}/cp", '')
  %w[jdeps jdeprscan].each do |tool|
    File.write("#{verify_base}/build/#{tool}.sh", "#!/bin/sh\nprintf '%s\n' \"$*\" >> '#{verify_base}/scan-args'\n")
    File.chmod(0755, "#{verify_base}/build/#{tool}.sh")
  end
  output, status = Open3.capture2e({'JAVA_TOOL_OPTIONS'=>'-Dfoo=bar'}, 'sh', "#{verify_base}/ci/verify.sh", output_classes, "#{verify_base}/tests", "#{verify_base}/cp")
  abort "JAVA_TOOL_OPTIONS 干擾 verify：#{output}" unless status.success?
  if File.executable?("#{jdk}/bin/jdeprscan")
    abort 'verify API 版本解析錯誤' unless File.read("#{verify_base}/scan-args").include?("--release #{version}")
  end
  puts 'PASS verify 在 JAVA_TOOL_OPTIONS 下保留正確執行 JDK 版本'
  runner_base = File.join(work, 'missing-policy')

  FileUtils.mkdir_p(["#{runner_base}/ci/github", "#{runner_base}/javac", "#{runner_base}/errorprone"])
  runner = "#{runner_base}/ci/github/run.sh"
  FileUtils.cp("#{base}/ci/github/run.sh", runner)
  %w[javac/lint-jdk17.txt errorprone/flags-jdk17.txt].each do |present|
    File.write("#{runner_base}/#{present}", '# available')
    output, status = Open3.capture2e({'JAVA_VERSION'=>'17', 'BUILD_TOOL'=>'maven'}, 'sh', runner, chdir: work)
    abort "缺少政策未以 2 拒絕：#{output}" unless status.exitstatus == 2
    File.delete("#{runner_base}/#{present}")
  end
  puts 'PASS workflow runner 任一政策檔缺少時以 2 拒絕'
  if ENV['MVN_BIN']
    project = File.join(work, 'maven')
    FileUtils.mkdir_p("#{project}/src/main/java")
    File.write("#{project}/src/main/java/Probe.java", 'class Probe { java.util.List raw; }')
    require 'cgi'
    File.write("#{project}/pom.xml", <<~XML)
      <project><modelVersion>4.0.0</modelVersion><groupId>example</groupId><artifactId>compiler-regression</artifactId><version>1</version>
      <properties><maven.compiler.source>8</maven.compiler.source><maven.compiler.target>8</maven.compiler.target></properties>
      <build><plugins><plugin><groupId>org.apache.maven.plugins</groupId><artifactId>maven-compiler-plugin</artifactId><version>3.13.0</version>
      <configuration><fork>true</fork><executable>#{CGI.escapeHTML(base)}/ci/compiler/javac.sh</executable></configuration>
      </plugin></plugins></build></project>
    XML
    2.times do |attempt|
      output, status = Open3.capture2e(ENV.fetch('MVN_BIN'), '-B', 'compile', chdir: project)
      abort "Maven 第 #{attempt + 1} 次未拒絕：#{output}" unless !status.success? && output.include?('[JV-TG-024]') && Dir["#{project}/target/classes/**/*.class"].empty?
    end
    puts 'PASS Maven 連續兩次 compile（不 clean）均拒絕 rawtypes，沒有 class 殘留'
  else
    puts 'SKIP Maven 連續編譯整合：未提供 MVN_BIN'
  end
end
