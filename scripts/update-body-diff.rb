# frozen_string_literal: true
require_relative 'body-restructuring-lib'
Dir.chdir(File.expand_path('..',__dir__))
slug,reason=ARGV
abort('用法：ruby scripts/update-body-diff.rb 主題 至少20個非空白字元的具體理由；只更新全文差異，不代填句子去向或驗收變更') unless slug && reason && reason.gsub(/\s/,'').size>=20 && slug.match?(/\A[a-z-]+\z/)
p="docs/body-restructuring/java/#{slug}.json";r=JSON.parse(File.read(p))
abort('只處理已明確標記 completed／merged 的本份紀錄') unless %w[completed merged].include?(r['status'])
after=r['status']=='merged' ? '' : File.read(r['path'])
r['edits']=BodyRestructuring.edits(BodyRestructuring.original(r['path']),after).map{|e|e.merge('reason'=>reason)}
File.write(p,JSON.pretty_generate(r)+"\n")
puts "已更新 #{p} 的 #{r['edits'].size} 個差異；仍須逐句人工核對及執行檢查。"
