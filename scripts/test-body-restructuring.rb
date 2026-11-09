# frozen_string_literal: true
require 'tmpdir'
require 'fileutils'
require 'open3'
require 'json'
ROOT=File.expand_path('..',__dir__)
GIT_DIR=File.expand_path(Open3.capture2('git','rev-parse','--git-common-dir',chdir:ROOT).first.strip,ROOT)
cases={
 '未整理正文改動'=>proc{File.open('rules/stacks/java/common/value-objects.md','a'){|f|f.puts '未登錄變更'}},
 '共通改動未登錄'=>proc{File.open('rules/coding/nullability.md','a'){|f|f.puts '未登錄變更'}},
 '歷史ID遺漏'=>proc{|r|r['rules'].pop},
 '去向種類無效'=>proc{|r|r['rules'][0]['kind']='隨意'},
 '基準移動'=>proc{|r|r['baseline']='HEAD'},
 '逐句去向遺漏'=>proc{|r|r['sentences'].pop},
 '保留文字不在目的地'=>proc{|r|r['sentences'][0]['targets'][0]['text']='不存在的完整句子'},
 '錨點不存在'=>proc{|r|r['rules'][0]['targets'][0]+='-不存在'},
 '驗收列消失'=>proc{p='rules/stacks/java/common/null-and-optional.md';File.write(p,File.read(p).lines.reject{|l|l.include?('acceptance-java-optional-results')}.join)},
 '隱藏新檔'=>proc{File.write('rules/.unregistered','x')},
 '追溯片段遺漏'=>proc{p='docs/acceptance-cleanup-batch-1.md';s=File.read(p);File.write(p,s.lines.reject{|l|l.start_with?('| CL-')}.join)},
 '缺值清單白紙理由'=>proc{|r|r['sentences'][0]['action']='改寫';r['sentences'][0]['reason']=' '},
 '行尾變更'=>proc{p='rules/stacks/java/common/value-objects.md';File.binwrite(p,File.binread(p).gsub("\n","\r\n"))}
}
cases['同檔錯誤小節']=proc{|r|e=r['sentences'].find{|x|x['action']=='改寫'};e['targets'][0]['uri']='rules/stacks/java/common/null-and-optional.md#java-container-nulls'}
cases['共通來源錨點錯誤']=proc{|r|e=r['sentences'].find{|x|x['common_sources']};e['common_sources']=['rules/coding/nullability.md#不存在']}
cases['分類ID換檔']=proc{|r|r['rules'].each{|e|e['id']=e['id'].sub('JN-','CA-')}}
cases['共通差異刪文遭竄改']=proc{p='docs/body-restructuring/common/ca-06.json';r=JSON.parse(File.read(p));r['changes'][0]['remove']=['假的來源'];File.write(p,JSON.generate(r))}
cases['共通差異理由不足']=proc{p='docs/body-restructuring/common/ca-06.json';r=JSON.parse(File.read(p));r['changes'][0]['reason']='x';File.write(p,JSON.generate(r))}
cases['共通差異沒有決策']=proc{p='docs/body-restructuring/common/ca-06.json';r=JSON.parse(File.read(p));r['changes'][0].delete('decision');File.write(p,JSON.generate(r))}
cases['驗收內容偽裝條號調整']=proc{|r|r['acceptance_changes'][0]['after']=r['acceptance_changes'][0]['after'].sub('驗證有值','忽略有值')}
cases['整份併入沒有接收檔']=proc{|r|r['status']='merged';r['merged_target']='rules/不存在.md'}
results=[]

(['乾淨複本']+cases.keys).each do |name|
 Dir.mktmpdir('body-negative-') do |dir|
  %w[rules docs scripts README.md].each{|p|FileUtils.cp_r(File.join(ROOT,p),dir) if File.exist?(File.join(ROOT,p))}
  Dir.chdir(dir) do
   p='docs/body-restructuring/java/null-and-optional.json';r=JSON.parse(File.read(p))
   cases[name].call(r) if cases[name]
   File.write(p,JSON.pretty_generate(r)+"\n")
   out,status=Open3.capture2e({'BODY_ROOT'=>dir,'BODY_GIT_DIR'=>GIT_DIR},'ruby','scripts/verify-body-restructuring.rb')
   expected=name=='乾淨複本' ? 0 : 1
   results<<{test:name,expected_exit:expected,actual_exit:status.exitstatus,matched:status.exitstatus==expected,diagnostic:status.success? ? '通過' : out.lines.first.to_s.strip}
  end
 end
end
puts JSON.pretty_generate(results)
exit(results.all?{|r|r[:matched]} ? 0 : 1)
