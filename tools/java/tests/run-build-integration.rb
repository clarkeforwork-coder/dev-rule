#!/usr/bin/env ruby
# 最小專案直接使用正式片段與正式 ruleset；需 Maven 3.9／Gradle 8。
require 'tmpdir'
require 'fileutils'
require 'open3'
root = File.expand_path('../../..', __dir__)
out = File.expand_path(ARGV.fetch(0))
FileUtils.mkdir_p(out)
java = ENV.fetch('JAVA_HOME')
version, status = Open3.capture2e(File.join(java, 'bin/java'), '-version')
raise version unless status.success?
major = version[/version "(?:1\.)?(\d+)/, 1].to_i
raise '需要 JDK 8／11／17／21' unless [8, 11, 17, 21].include?(major)
puts version
Dir.mktmpdir('java-build-integration-') do |dir|
  FileUtils.mkdir_p(File.join(dir, 'vendor'))
  File.symlink(root, File.join(dir, 'vendor/dev-rule'))
  src = File.join(dir, 'src/main/java')
  FileUtils.mkdir_p(src)
  pom = File.read(File.join(root, 'tools/java/ci/maven/pom-fragment.xml'))
  # 片段預設 source 17；JDK 8 驗證只改消費端編譯版本，不改任何檢查設定。
  pom = pom.gsub('>17</maven.compiler.', ">#{major}</maven.compiler.")
  File.write(File.join(dir, 'pom.xml'), pom)
  File.write(File.join(dir, 'settings.gradle.kts'), "rootProject.name = \"dev-rule-integration\"\n")
  File.write(File.join(dir, 'build.gradle.kts'), <<~KTS)
    plugins { java }
    repositories { mavenCentral() }
    apply(from = "vendor/dev-rule/tools/java/ci/gradle/rules.gradle.kts")
  KTS
  {'maven'=>[ENV.fetch('MAVEN_BIN', 'mvn'), '-B', 'clean', 'verify'],
   'gradle'=>[ENV.fetch('GRADLE_BIN', 'gradle'), 'clean', 'check', '--no-daemon', '--console=plain']}.each do |tool, command|
    {'good'=>'final class Probe {}',
     'bad'=>'final class Probe { void consume(java.util.List values) {} }'}.each do |kind, source|
      File.write(File.join(src, 'Probe.java'), source+"\n")
      output, result = Open3.capture2e(*command, chdir: dir)
      log = File.join(out, "#{tool}-jdk#{major}-#{kind}.log")
      File.write(log, output+"\nexit=#{result.exitstatus}\n")
      ok = kind=='good' ? result.success? : (!result.success? && output.include?('RawGenericType'))
      puts "#{ok ? '通過' : '失敗'} #{tool} JDK #{major} #{kind} exit=#{result.exitstatus}，#{File.basename(log)}"
      raise "#{tool} #{kind} 驗證失敗，詳 #{log}" unless ok
    end
  end
end
