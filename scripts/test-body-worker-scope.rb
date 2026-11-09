# frozen_string_literal: true
require 'tmpdir'
require 'fileutils'
require 'open3'
require 'json'
ROOT=File.expand_path('..',__dir__)
results=[]
%w[W05 W06 W09 W10 W19 W20].each do |name|
 Dir.mktmpdir('body-scope-') do |dir|
  Dir.chdir(dir) do
   system('git','init','-q');FileUtils.mkdir_p('docs');FileUtils.mkdir_p('rules');File.write('docs/java-rule-migration.md','base');File.write('.gitignore',".DS_Store\n");system('git','add','.');system('git','-c','user.name=Test','-c','user.email=t@example.invalid','commit','-qm','base')
   start=Open3.capture2('git','rev-parse','HEAD').first.strip;actual=start;topic='null-and-optional';cwd=dir
   case name
   when 'W05','W06','W10'
    File.write('docs/java-rule-migration.md','outside');system('git','add','docs')
    system('git','-c','user.name=Test','-c','user.email=t@example.invalid','commit','-qm','outside') if name!='W05'
    File.write('docs/java-rule-migration.md','base')
    actual=Open3.capture2('git','rev-parse','HEAD').first.strip if name=='W10'
   when 'W09';File.write('docs/untracked.md','outside');cwd=File.join(dir,'rules')
   when 'W19';topic='typo'
   when 'W20';File.write('.DS_Store','ignored')
   end
   out,status=Open3.capture2e('ruby',File.join(ROOT,'scripts/verify-body-worker-scope.rb'),'--topic',topic,'--start',actual,'--expected-start',start,chdir:cwd)
   expected=name=='W20' ? 0 : 1
   diagnostic=case name;when 'W10';'工作者起點與協調者記錄不符';when 'W19';'未知的工作者主題';when 'W20';'工作者範圍通過';else;'工作者超出允許範圍';end
   results<<{test:name,expected:expected,exit:status.exitstatus,diagnostic:diagnostic,matched:status.exitstatus==expected&&out.include?(diagnostic)}
  end
 end
end
puts JSON.pretty_generate(results);exit(results.all?{|r|r[:matched]} ? 0 : 1)
