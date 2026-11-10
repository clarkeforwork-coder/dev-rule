#!/usr/bin/env ruby
# frozen_string_literal: true
require 'open3'
Dir.chdir(File.expand_path('..',__dir__))
target='350668eb14ede247af22c782323beebf940c2a5f'
commands = [['ruby','scripts/verify-acceptance.rb','--target',target]]
(1..5).each { |n| commands << ['ruby','scripts/verify-acceptance.rb','--batch',n.to_s,'--target',target] }
commands << ['ruby','scripts/test-verify-acceptance.rb']
commands << ['git','diff','--check','6a16349..HEAD']
report = +"# 驗收驗證實際輸出\n\n本檔由 `ruby scripts/record-acceptance-verification.rb` 擷取封存提交 `350668eb14ede247af22c782323beebf940c2a5f` 的驗收檢查與五批追溯實際輸出；舊測試亦在該封存複本執行，diff 檢查則讀目前分支。這不是現行規範的驗證結果；現行結果見 `docs/body-restructuring-verification-results.md`。執行方式與人工檢查邊界見 `docs/review-remediation.md`；數字不代表語意零重複。\n"
commands.each do |args|
 output,status=Open3.capture2e(*args)
 abort("檢查失敗，未更新紀錄：#{args.join(' ')}\n#{output}") unless status.success?
 report << "\n## `#{args.join(' ')}`\n\n```text\n#{output}exit=#{status.exitstatus}\n```\n"
end
File.write('docs/acceptance-verification-results.md',report)
puts '已由 8 個實際執行結果更新 docs/acceptance-verification-results.md；全部 exit=0。'
