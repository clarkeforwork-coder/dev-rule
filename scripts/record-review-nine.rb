# frozen_string_literal: true
require_relative 'body-presentation'
Dir.chdir(File.expand_path('..',__dir__))
out,status=Open3.capture2e('ruby','scripts/verify-review-nine.rb');abort out unless status.success?
plan=FinalAcceptance.steps.find{|s|s['id']=='review-nine'}
text=<<~DOC
# 合併前第九次審閱修正

起點 `#{ReviewNine::START}`；正文基準 `#{BodyRestructuring::BASELINE}`。規則修正提交 `0c4b39b`。本檔由 `scripts/record-review-nine.rb` 產生，以下每筆原文與改後文字直接取核准清單，包含四句分工、三處連結文字、驗收第一欄、兩條還原、指路句、三處驗收入口、規範驗證兩處、標題別名及索引說明。

JN-02 與 JN-06 因涵蓋不夠直接改整條保留；JN-06 原分組不再有整條移除的條文，因此原 19 句分組指路剩 18 句。固定格式為「本組由共通規範承接的要求：…。」；順序依基準原條文，同條依承接來源登錄順序去重。新增的標題別名只有資料映射一筆；規範驗證既有標題別名一併補登清冊，不重複新增錨點。

## 逐筆前後文字

DOC
plan['ops'].each_with_index do |op,i|
 text+="### #{i+1}. `#{op['path']}`\n\n#{op['reason']}\n\n原文：\n\n```markdown\n#{op['before']}\n```\n\n改後：\n\n```markdown\n#{op['after']}\n```\n\n"
end
text+=<<~DOC
## 紀錄與產生器

階段 B 產生器保留開頭既有歷史狀態說明及 `<!-- 人工補記 -->` 之後的手寫內容；人工複核數量取產生當下的工具輸出，不冒充歷史數量。階段 C 第一部分保留第二部分；第二部分由自己的產生器維護，並補登規範驗證入口描述的歷史前後文。可重生部分不再混入產生器外的手改結果。

總結、別名清冊及本紀錄各有產生器；修改應改產生器。封存驗收紀錄以明列 `--target` 的舊基準執行，現行結果另由正文驗證紀錄承接。核准清單不是不可修改的鎖；保護來自審查核准清單的差異。

未處理項目依派工：L13 其餘建議、L12 待決清單各節就地標示，以及審閱報告去留。沒有自行刪除任何審閱報告。語意充分性、指代是否準確與核准清單本身仍須協調者人工複核。

## 可重跑逐句差異實際輸出

```sh
ruby scripts/verify-review-nine.rb
```

```json
#{out.strip}
```
DOC
File.write('docs/body-restructuring-review-9.md',text)
puts "已產生第九次審閱 #{plan['ops'].size} 筆前後文字與實際逐句差異。"
