# frozen_string_literal: true
require 'json'
Dir.chdir(File.expand_path('..',__dir__))
puts '| 歷史 ID | 文件狀態 | 去向種類 | 現行位置 |'
puts '| --- | --- | --- | --- |'
Dir.glob('docs/body-restructuring/java/*.json').flat_map{|p|r=JSON.parse(File.read(p));r['rules'].map{|e|[e['id'],r['status'],e['kind'],e['targets'].join('、')]}}.sort.each{|row|puts '| '+row.join(' | ')+' |'}
