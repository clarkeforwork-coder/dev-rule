#!/usr/bin/env ruby
# frozen_string_literal: true
# 所有變異均在暫存複本，原分支與工作區不變。
require 'tmpdir'
require 'fileutils'
require 'open3'
require 'json'
ROOT=File.expand_path('..',__dir__)
GIT_DIR=File.expand_path(Open3.capture2('git','-C',ROOT,'rev-parse','--git-common-dir').first.strip,ROOT)
def change(path)
  source=File.read(path); result=yield(source)
  raise "測試未改到預期內容：#{path}" if result==source
  File.write(path,result)
end
java='rules/stacks/java/common/types-and-generics.md'
quality='rules/quality/rule-verification.md'
cases={
 'T1'=>['失效錨點',false,lambda{change(java){|s|s.sub('#acceptance-data-shape','#acceptance-missing')}}],
 'T2'=>['逐字重複',false,lambda{
   row=File.readlines('rules/coding/type-safety.md').find{|l|l.include?('id="acceptance-data-shape"')}.sub('id="acceptance-data-shape"','id="acceptance-java-negative"')
   row=row.gsub('](#','](../../../coding/type-safety.md#')
   change(java){|s|s.sub("| --- | --- |\n","| --- | --- |\n"+row)}
 }],
 'T3'=>['換句話說重複：僅人工可判斷',true,lambda{
   row=File.readlines('rules/coding/type-safety.md').find{|l|l.include?('id="acceptance-data-shape"')}.sub('id="acceptance-data-shape"','id="acceptance-java-negative"').sub('使用明確物件','採用明確物件')
   # 外部檔的規則連結在 Java 位置必須仍有效，否則測到的是壞連結。
   row=row.gsub('](#','](../../../coding/type-safety.md#')
   change(java){|s|s.sub("| --- | --- |\n","| --- | --- |\n"+row)}
 }],
 'T4'=>['追溯指錯現存列',false,lambda{change('docs/acceptance-cleanup-batch-5.md'){|s|s.sub('../rules/coding/numbers-dates-text.md#acceptance-time-source','../rules/coding/domain-modeling.md#acceptance-identity-lifecycle')}}],
 'T5'=>['刪除核心業務政策',false,lambda{change(quality){|s|s.lines.reject{|l|l.include?('核心業務規則必須能')}.join}}],
 'T6a'=>['刪除驗收尾段治理句',false,lambda{change('rules/stacks/java/common/null-and-optional.md'){|s|s.lines.reject{|l|l.include?('既有程式碼、工具限制與個別例外')}.join}}],
 'T6b'=>['掏空 Java 驗收列',false,lambda{change(java){|s|s.sub(/(\| <a id="acceptance-java-[^"]+"><\/a>[^|]+\| ).+ \|/,'\1略。 |')}}],
 'T7'=>['README 政策改寫',false,lambda{change('rules/README.md'){|s|s.sub('不得自行降低標準','得自行降低標準')}}],
 'T8'=>['刪除受保護章節文字',false,lambda{change(quality){|s|s.lines.reject{|l|l.include?('測試程式碼同樣遵守')}.join}}],
 'T9'=>['共通驗收列刪除後半斷言',false,lambda{change(quality){|s|s.sub('不隱藏項目失敗或未完成事項。','')}}],
 'T10'=>['重複錨點',false,lambda{change(java){|s|s+"\n<a id=\"acceptance-java-local-types\"></a>\n<a id=\"acceptance-java-local-types\"></a>\n"}}]
}
results=[]
Dir.mktmpdir('acceptance-negative-') do |dir|
 FileUtils.cp_r(["#{ROOT}/rules","#{ROOT}/docs","#{ROOT}/scripts"],dir)
 FileUtils.cp("#{ROOT}/README.md",dir) if File.file?("#{ROOT}/README.md")
 env={'ACCEPTANCE_GIT_DIR'=>GIT_DIR}
 out,status=Open3.capture2e(env,'ruby',"#{dir}/scripts/verify-acceptance.rb")
 abort("乾淨暫存複本未通過：\n#{out}") unless status.success?
 cases.each do |id,(description,expected_pass,mutate)|
  saved=Dir.glob("#{dir}/{rules,docs}/**/*").select{|p|File.file?(p)}.to_h{|p|[p,File.binread(p)]}
  Dir.chdir(dir){mutate.call}
  out,status=Open3.capture2e(env,'ruby',"#{dir}/scripts/verify-acceptance.rb")
  pattern = case id
            when 'T1' then /Missing fragment/
            when 'T2' then /Scoped duplicate acceptance/
            when 'T4' then /Trace fragment absent from destination NT-9-2/
            when 'T10' then /Duplicate\/colliding anchor/
            else /Protected rule text (changed|missing)/
            end
  diagnostic = out.lines.find { |line| line.match?(pattern) }
  matched = status.success? == expected_pass && (expected_pass || !diagnostic.nil?)
  results << {test:id,description:description,expected_exit:expected_pass ? 0 : 1,actual_exit:status.exitstatus,matched_expectation:matched,diagnostic:status.success? ? '人工檢查：腳本不判斷換句話說的重複' : (diagnostic || out.lines.first).to_s.strip}
  saved.each{|p,body|File.binwrite(p,body)}
 end
end
puts JSON.pretty_generate(results)
exit(results.all?{|r|r[:matched_expectation]} ? 0 : 1)
