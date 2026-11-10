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
load File.expand_path('record-anchor-aliases.rb',__dir__)
puts "已套用 #{mode}；#{P.aliases.size} 筆錨點、#{records.size} 份 Java 去向紀錄。"
