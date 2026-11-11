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
  argfile = File.join(work, 'input.args')
  quote = ->(arg) { '"' + arg.gsub(/[\\"]/) { |c| '\\' + c } + '"' }
  File.write(argfile, ['-encoding', 'UTF-8', '-d', classes, source].map(&quote).join("\n"))
  output, status = Open3.capture2e("#{base}/ci/compiler/javac.sh", "@#{argfile}")
  diagnostics = output.lines.grep(/\[rawtypes\]/)
  abort "每行診斷或特殊路徑失敗：#{output}" unless status.exitstatus == 1 && diagnostics.size == 3 && diagnostics.all? { |s| s.include?('[JV-TG-024]') && s.include?(' → rules/') }
  puts 'PASS 正式編譯入口：空白／引號／中文路徑，三筆 raw type 各帶 ID 與錨點'
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
end
