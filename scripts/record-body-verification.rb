# frozen_string_literal: true
require 'open3'
require_relative 'body-restructuring-lib'
Dir.chdir(File.expand_path('..',__dir__))
commands=[
 ['ruby','scripts/verify-body-restructuring.rb'],
 ['ruby','scripts/verify-body-sentences.rb'],
 ['ruby','scripts/verify-final-acceptance.rb'],
 ['ruby','scripts/test-final-acceptance.rb'],
 ['ruby','scripts/test-body-presentation.rb'],
 ['ruby','scripts/test-verify-acceptance.rb'],
 ['ruby','scripts/test-body-restructuring.rb'],
 ['ruby','scripts/test-body-policy.rb'],
 ['ruby','scripts/test-body-worker-scope.rb'],
 ['ruby','scripts/test-body-rehearsals.rb'],
 ['ruby','scripts/test-body-reverts.rb'],
 ['ruby','scripts/verify-acceptance.rb','--target',BodyRestructuring::BASELINE],
 ['git','diff','--check'],
 ['git','diff','--cached','--check'],
 ['git','diff','--check',BodyRestructuring::BASELINE+'..HEAD']
]
text="# 正文整理：實際驗證紀錄\n\n由 `ruby scripts/record-body-verification.rb` 擷取實際命令輸出與結束狀態，未手寫結果。負向、移入格式、工作者範圍及撤回測試皆在暫存複本執行；撤回複本會納入目前 rules／docs／scripts，提交後內容即為 HEAD。常駐輸出的人工清單列出本次每個改寫或移除句子及種類、移入、指路、引用與驗收變更，機器不能證明語意相關或完整等價。\n"
failed=[]
commands.each do |command|
 out,status=Open3.capture2e(*command)
 out=out.gsub(%r{/private/var/folders/[^\s"]+/body-[^/\s"]+},'<暫存複本>').gsub(%r{/tmp/body-[^/\s"]+},'<暫存複本>')
 text+="\n## `#{command.join(' ')}`\n\n```text\n#{out}exit=#{status.exitstatus}\n```\n"
 failed<<command.join(' ') unless status.success?
end
File.write('docs/body-restructuring-verification-results.md',text)
abort("驗證失敗：#{failed.join(', ')}") unless failed.empty?
puts "已擷取 #{commands.size} 個命令的實際輸出，全部 exit=0。"
