#!/usr/bin/env ruby
# frozen_string_literal: true
require 'json'
require 'fileutils'
require 'tmpdir'

# 與 scripts/check-rules.rb 的 examples 使用相同標記、基線與 import。
module JavaExamples
  ROOT = File.expand_path('../../..', __dir__)
  IMPORTS = <<~JAVA
    import java.util.*; import java.util.concurrent.*; import java.util.concurrent.atomic.*;
    import java.util.concurrent.locks.*; import java.util.function.*; import java.util.stream.*;
    import java.time.*; import java.time.format.*; import java.math.*; import java.io.*;
    import java.nio.file.*; import java.nio.charset.*; import java.util.regex.*; import java.text.*;
  JAVA
  MARKER = /^\*\*(違反|符合)(?:（Java (8|11|17|21)）)?\*\*$/

  def self.extract(destination)
    manifest = []
    Dir[File.join(ROOT, 'rules/stacks/java/common/*.md')].sort.each do |file|
      lines = File.readlines(file, chomp: true)
      anchor = nil
      counters = Hash.new(0)
      in_fence = false
      lines.each_with_index do |line, index|
        if line.start_with?('```')
          in_fence = !in_fence
          next
        end
        next if in_fence
        anchor = Regexp.last_match(1) if line =~ /^<a id="([^"]+)"><\/a>/
        marker = line.match(MARKER)
        next unless marker
        raise "#{file}:#{index + 1} 缺少錨點" unless anchor
        start = index + 1
        start += 1 while lines[start]&.strip == ''
        raise "#{file}:#{start + 1} 缺少 Java 圍欄" unless lines[start] == '```java'
        ending = start + 1
        ending += 1 while ending < lines.length && lines[ending] != '```'
        raise "#{file}:#{start + 1} 圍欄未結束" if ending == lines.length
        kind = marker[1] == '違反' ? 'violation' : 'compliant'
        version = (marker[2] || '17').to_i
        counters[[anchor, kind, version]] += 1
        dir = File.join(File.expand_path(destination), File.basename(file, '.md'), anchor)
        FileUtils.mkdir_p(dir)
        path = File.join(dir, "#{kind}-#{counters[[anchor, kind, version]]}-java#{version}.java")
        File.write(path, IMPORTS + lines[(start + 1)...ending].join("\n") + "\n")
        manifest << { 'file' => file.delete_prefix(ROOT + '/'), 'anchor' => anchor,
                      'kind' => kind, 'version' => version, 'path' => path, 'line' => start + 2 }
      end
    end
    File.write(File.join(destination, 'manifest.json'), JSON.pretty_generate(manifest) + "\n")
    manifest
  end
end

if $PROGRAM_NAME == __FILE__
  destination = ARGV.shift || Dir.mktmpdir('java-examples-')
  abort '用法：ruby extract-examples.rb [輸出目錄]' unless ARGV.empty?
  puts JSON.pretty_generate(JavaExamples.extract(destination))
end
