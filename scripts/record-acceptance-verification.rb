#!/usr/bin/env ruby
# frozen_string_literal: true
require 'open3'
Dir.chdir(File.expand_path('..',__dir__))
commands = [['ruby','scripts/verify-acceptance.rb']]
(1..5).each { |n| commands << ['ruby','scripts/verify-acceptance.rb','--batch',n.to_s,'--trace-only'] }
commands << ['ruby','scripts/test-verify-acceptance.rb']
commands << ['git','diff','--check']
report = +"# 驗收驗證實際輸出\n\n本檔由 `ruby scripts/record-acceptance-verification.rb` 擷取工作區的實際標準輸出、錯誤輸出及結束碼。執行方式與人工檢查邊界見 `docs/review-remediation.md`；數字不代表語意零重複。\n"
commands.each do |args|
 output,status=Open3.capture2e(*args)
 abort("檢查失敗，未更新紀錄：#{args.join(' ')}\n#{output}") unless status.success?
 report << "\n## `#{args.join(' ')}`\n\n```text\n#{output}exit=#{status.exitstatus}\n```\n"
end
File.write('docs/acceptance-verification-results.md',report)
puts '已由 8 個實際執行結果更新 docs/acceptance-verification-results.md；全部 exit=0。'
