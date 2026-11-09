# frozen_string_literal: true
require 'tmpdir'
require 'fileutils'
require 'open3'
require 'json'
root=File.expand_path('..',__dir__)
results=[]
%w[b1d2f33 5a16124].each do |commit|
 topic=commit=='b1d2f33' ? 'concurrency-and-async' : 'collections-and-ownership'
 record=JSON.parse(File.read(File.join(root,"docs/body-restructuring/java/#{topic}.json")))
 if record['status']!='pending'
  results<<{commit:commit,applicable:false,reason:'對應 Java 文件已整理；必須連同 Java 來源與連結重新規劃撤回，不再單獨套用此測試。',matched:true}
  next
 end
 Dir.mktmpdir('body-revert-') do |dir|
  repo=File.join(dir,'repo')
  _,err,status=Open3.capture3('git','clone','--quiet','--shared',root,repo)
  abort(err) unless status.success?
  # 同時可驗證尚未提交的修正；不複製根目錄未追蹤的審閱報告。
  %w[rules docs scripts].each{|p|FileUtils.cp_r(File.join(root,p),repo)}
  out,err,status=Open3.capture3('git','-c','user.name=Verification','-c','user.email=verification@example.invalid','revert','--no-edit',commit,chdir:repo)
  check_out,check_status=Open3.capture2e({'BODY_ROOT'=>nil,'BODY_GIT_DIR'=>nil},'ruby','scripts/verify-body-restructuring.rb',chdir:repo)
  results<<{commit:commit,revert_exit:status.exitstatus,revert_output:(out+err).gsub(/\[[^\]]+\]/,'[暫存撤回提交]'),verification_exit:check_status.exitstatus,verification_summary:check_status.success? ? JSON.parse(check_out).slice('historical_ids','completed','pending') : check_out,matched:status.success?&&check_status.success?}
 end
end
puts JSON.pretty_generate(results)
exit(results.all?{|r|r[:matched]} ? 0 : 1)
