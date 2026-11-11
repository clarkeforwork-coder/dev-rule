#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'

# 保留原始範例，不拼接不同範例、不補寫能讓檢查通過的程式碼。
module JavaExamples
  def self.extract(root, reference)
    file, anchor = reference.split('#', 2)
    text = File.read(File.join(root, file), encoding: 'UTF-8')
    start = text.index(%(<a id="#{anchor}"></a>))
    raise "找不到錨點：#{reference}" unless start
    section = text[start...(text.index(/<a id=/, start + 1) || text.length)]
    label = nil
    result = []
    lines = section.lines
    i = 0
    while i < lines.length
      label = Regexp.last_match(1) if lines[i] =~ /^\*\*(違反[^*]*|符合[^*]*)\*\*/
      if lines[i].strip == '```java'
        raise "範例缺少分類：#{reference}" unless label
        code = +''
        i += 1
        while i < lines.length && lines[i].strip != '```'
          code << lines[i]
          i += 1
        end
        raise "範例未結束：#{reference}" if i == lines.length
        result << { 'label' => label, 'bad' => label.start_with?('違反'), 'code' => code }
      end
      i += 1
    end
    raise "缺少正反例：#{reference}" unless result.any? { |e| e['bad'] } && result.any? { |e| !e['bad'] }
    result
  end
end

if $PROGRAM_NAME == __FILE__
  abort '用法：extract-examples.rb 規範路徑#錨點' unless ARGV.length == 1
  puts JSON.pretty_generate(JavaExamples.extract(File.expand_path('../../..', __dir__), ARGV[0]))
end
