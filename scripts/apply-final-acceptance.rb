# frozen_string_literal: true
require_relative 'body-presentation'
Dir.chdir(File.expand_path('..',__dir__))
ids=ARGV;raise '請指定核准步驟名稱' if ids.empty?
File.write(FinalAcceptance::CONFIG,JSON.pretty_generate({'start'=>FinalAcceptance::START,'steps'=>ids})+"\n")
files,records=BodyPresentation.render(JSON.parse(File.read(BodyPresentation::CONFIG)))
File.write(BodyPresentation::ALIASES,JSON.pretty_generate(BodyPresentation.alias_manifest)+"\n")
files.each{|p,t|File.write(p,t)};records.each{|p,r|File.write(p,JSON.pretty_generate(r)+"\n")}
p='docs/body-restructuring/common/existing-sources.json'
File.write(p,FinalAcceptance.common_record(p,BodyPresentation.old(p)))
# 歷史紀錄不刪；只調整連結與 URI，保持目的錨點可解析。
Dir.glob('docs/**/*.{md,json}').each do |p|
 next if p.start_with?('docs/body-restructuring/common/')||records.key?(p)||p==FinalAcceptance::CONFIG
 t=File.read(p);n=FinalAcceptance.links(t,p)
 FinalAcceptance.moves.each{|e|n=n.gsub(e['from'],e['to'])}
 File.write(p,n) if n!=t
end
puts "已套用：#{ids.join('、')}"
