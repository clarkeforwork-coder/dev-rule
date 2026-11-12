#!/usr/bin/env ruby
# 僅本庫回歸；消費端不需要 Ruby。
require 'open3'
require 'fileutils'
base=File.expand_path('../../..', __dir__)
require 'tmpdir'
Dir.mktmpdir('enforcer-regressions-') do |work|
  mvn=ENV.fetch('MVN_BIN', 'mvn')
  version=Open3.capture2e(File.join(ENV.fetch('JAVA_HOME'), 'bin/java'), '-version').first[/version "(?:1\.)?(\d+)/, 1].to_i
  plugin=File.read(File.join(base, 'tools/java/build/maven-enforcer.xml'))
  [['allowed','<dev-rule.banned>commons-logging:commons-logging</dev-rule.banned><dev-rule.boundary.banned>junit:junit</dev-rule.boundary.banned>',0],['missing','',1],['empty','<dev-rule.banned></dev-rule.banned><dev-rule.boundary.banned/>',1],['banned','<dev-rule.banned>org.slf4j:slf4j-api</dev-rule.banned>',1],['boundary','<dev-rule.banned>example:forbidden</dev-rule.banned><dev-rule.boundary.banned>org.slf4j:slf4j-api</dev-rule.boundary.banned>',1]].each do |name,properties,expected|
   File.write("#{work}/pom.xml", "<project><modelVersion>4.0.0</modelVersion><groupId>example</groupId><artifactId>probe</artifactId><version>1</version><properties><dev-rule.java.range>[#{version},#{version + 1})</dev-rule.java.range>#{properties}</properties><dependencies><dependency><groupId>org.slf4j</groupId><artifactId>slf4j-api</artifactId><version>2.0.17</version></dependency></dependencies><build><plugins>#{plugin}</plugins></build></project>")
   log,st=Open3.capture2e(mvn,'-B','validate',chdir:work)
   abort log unless st.exitstatus == expected && (expected == 0 || log.include?(%w[missing empty].include?(name) ? 'dev-rule.banned' : (name == 'boundary' ? '[JV-NP-028]' : '[JV-VP-010]')))
   puts "PASS Maven Enforcer #{name} exit=#{st.exitstatus}"
  end
  gradle=ENV.fetch('GRADLE_BIN', 'gradle')
  gdir="#{work}/gradle"
  FileUtils.mkdir_p(gdir)
  File.write("#{gdir}/settings.gradle.kts", 'rootProject.name = "probe"')
  File.write("#{gdir}/build.gradle.kts", "plugins { java }\napply(from = \"#{base}/tools/java/build/gradle-enforcer.gradle.kts\")\n")
  [false,true].each do |present|
   File.write("#{gdir}/gradle.properties", "devRuleCompiler=#{version}\ndevRuleRelease=8\n"+(present ? "devRuleBanned=   \n" : ''))
   log,st=Open3.capture2e(gradle,'--no-daemon','help',chdir:gdir)
   abort log unless present ? st.success? : (!st.success? && log.include?('缺少 devRuleBanned'))
   puts "PASS Gradle devRuleBanned #{present ? '空白允許' : '缺少具名錯誤'} exit=#{st.exitstatus}"
  end
end
