# frozen_string_literal: true
require 'open3'
require 'optparse'
require 'json'
options={}
OptionParser.new do |p|
 p.on('--topic TOPIC'){|v|options[:topic]=v}
 p.on('--start COMMIT'){|v|options[:start]=v}
 p.on('--expected-start COMMIT'){|v|options[:expected_start]=v}
 p.on('--root DIR'){|v|options[:root]=v}
end.parse!
abort('範圍檢查需要 --topic 主題及 --start 起點提交') unless options[:topic].to_s.match?(/\A[a-z-]+\z/) && options[:start]
Dir.chdir(options[:root]) if options[:root]
root,_,status=Open3.capture3('git','rev-parse','--show-toplevel');abort('無法取得儲存庫根目錄') unless status.success?
Dir.chdir(root.strip)
manifest=JSON.parse(File.read(File.join(__dir__,'acceptance-batches.json')))
topics=manifest.values.flat_map{|b|b['files'].values}.uniq
abort('未知的工作者主題') unless topics.include?(options[:topic])
ref,err,status=Open3.capture3('git','rev-parse','--verify',options[:start]+'^{commit}');abort("無效的工作者起點：#{err.strip}") unless status.success?
if options[:expected_start]
 expected,_,status=Open3.capture3('git','rev-parse','--verify',options[:expected_start]+'^{commit}')
 abort('工作者起點與協調者記錄不符') unless status.success? && expected.strip==ref.strip
end
paths=[]
[['diff',ref.strip,'HEAD'],['diff','--cached',ref.strip],['diff',ref.strip]].each do |args|
 out,status=Open3.capture2('git',*args,'--no-renames','--name-only','-z','--');abort('無法取得工作者差異') unless status.success?
 paths.concat(out.split("\0"))
end
untracked,status=Open3.capture2('git','ls-files','--others','--exclude-standard','-z');abort('無法取得未追蹤檔案') unless status.success?
allowed=["rules/stacks/java/common/#{options[:topic]}.md","docs/body-restructuring/java/#{options[:topic]}.json"]
changed=(paths+untracked.split("\0")).uniq.sort
outside=changed-allowed
abort("工作者超出允許範圍：#{outside.join(', ')}") unless outside.empty?
puts JSON.pretty_generate({topic:options[:topic],start:ref.strip,allowed:allowed,changed:changed,result:'工作者範圍通過',authority:'起點由協調者提供，合併前使用協調者保留的起點重驗；工具無法推定授權起點。'})
