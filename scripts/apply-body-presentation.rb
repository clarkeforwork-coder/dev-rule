# frozen_string_literal: true
require_relative 'body-presentation'
Dir.chdir(File.expand_path('..',__dir__))
P=BodyPresentation
mode=ARGV.fetch(0,'');abort '使用 --aliases、--layout 或 --index' unless %w[--aliases --layout --index].include?(mode)
config=File.exist?(P::CONFIG) ? JSON.parse(File.read(P::CONFIG)) : {'start'=>P::START,'aliases'=>true,'layout'=>false,'index'=>false}
P.validate(config) if File.exist?(P::CONFIG)
config['layout']=true if %w[--layout --index].include?(mode)
config['index']=true if mode=='--index'
files,records=P.render(config)
files.each{|p,t|File.write(p,t)}
records.each{|p,r|File.write(p,JSON.pretty_generate(r)+"\n")}
File.write(P::CONFIG,JSON.pretty_generate(config)+"\n")
File.write(P::ALIASES,JSON.pretty_generate(P.aliases)+"\n")
text="# 共通規則錨點相容別名\n\n起點：`#{P::START}`。以下 74 筆逐一採用待決清單第五節建議，無名稱調整；舊錨點緊接在新錨點下一行，同一正文不複製。現行引用使用新名；將來移除別名須依本清冊逐筆處理，不能僅按歷史代號樣式搜尋刪除。機器清冊為 `docs/common-anchor-aliases.json`。\n\n| 檔案 | 舊錨點（相容） | 新錨點（現行） |\n| --- | --- | --- |\n"
P.aliases.each{|e|text+="| #{e['path']} | `#{e['old']}` | [#{e['new']}](../#{e['path']}##{e['new']}) |\n"}
File.write('docs/common-anchor-aliases.md',text)
puts "已套用 #{mode}；#{P.aliases.size} 筆錨點、#{records.size} 份 Java 去向紀錄。"
