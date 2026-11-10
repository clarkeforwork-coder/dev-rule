# frozen_string_literal: true
require_relative 'body-presentation'
Dir.chdir(File.expand_path('..',__dir__))
entries=BodyPresentation.alias_manifest
File.write(BodyPresentation::ALIASES,JSON.pretty_generate(entries)+"\n")
text="# 共通規則錨點相容別名\n\n本檔由 `scripts/record-anchor-aliases.rb` 產生。74 筆歷史規則錨點逐一採用待決清單第五節建議，無名稱調整；另集中登錄兩筆標題別名。新舊錨點在同一位置，正文不複製。現行引用使用新名。別名維持保留，待儲存庫外引用確認清除後一次移除；屆時依本清冊逐筆處理，不能僅按代號樣式刪除。機器清冊為 `docs/common-anchor-aliases.json`。\n\n## 歷史規則錨點（74 筆）\n\n"
[entries.reject{|e|e['kind']=='heading'},entries.select{|e|e['kind']=='heading'}].each_with_index do |set,i|
 text+="\n## 標題相容別名（2 筆）\n\n資料映射的舊標題別名在第九次審閱後補入；規範驗證的別名原已存在，這次補登集中清冊。\n\n" if i==1
 text+="| 檔案 | 舊錨點（相容） | 新錨點（現行） |\n| --- | --- | --- |\n"
 set.each{|e|text+="| #{e['path']} | `#{e['old']}` | [#{e['new']}](../#{e['path'] }##{e['new']}) |\n"}
end
File.write('docs/common-anchor-aliases.md',text)
puts "已產生 #{entries.size} 筆相容別名：74 筆規則、2 筆標題。"
