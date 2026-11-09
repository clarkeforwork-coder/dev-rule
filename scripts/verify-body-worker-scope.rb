# frozen_string_literal: true
require 'open3'
require 'optparse'
require 'json'
options={}
OptionParser.new do |p|
 p.on('--topic TOPIC'){|v|options[:topic]=v}
 p.on('--start COMMIT'){|v|options[:start]=v}
 p.on('--root DIR'){|v|options[:root]=v}
end.parse!
abort('範圍檢查需要 --topic 主題及 --start 起點提交') unless options[:topic].to_s.match?(/\A[a-z-]+\z/) && options[:start]
Dir.chdir(options[:root]) if options[:root]
ref,err,status=Open3.capture3('git','rev-parse','--verify',options[:start]+'^{commit}');abort("無效的工作者起點：#{err.strip}") unless status.success?
paths,status=Open3.capture2('git','diff','--no-renames','--name-only','-z',ref.strip,'--');abort('無法取得工作者差異') unless status.success?
untracked,status=Open3.capture2('git','ls-files','--others','-z');abort('無法取得未追蹤檔案') unless status.success?
allowed=["rules/stacks/java/common/#{options[:topic]}.md","docs/body-restructuring/java/#{options[:topic]}.json"]
changed=(paths.split("\0")+untracked.split("\0")).uniq.sort
outside=changed-allowed
abort("工作者超出允許範圍：#{outside.join(', ')}") unless outside.empty?
puts JSON.pretty_generate({topic:options[:topic],start:ref.strip,allowed:allowed,changed:changed,result:'工作者範圍通過'})
