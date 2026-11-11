#!/usr/bin/env ruby
# frozen_string_literal: true

require 'uri'
require 'set'
require 'tmpdir'
require 'open3'

class RulesCheck
  SUPPORTED_JAVA = %w[8 11 17 21].freeze
  BASELINE_JAVA = '17'
  EXAMPLE_MARKER = /^\*\*(違反|符合)(?:（Java (8|11|17|21)）)?\*\*$/
  COMMANDS = %w[links skeleton headings template examples versions].freeze
  TEMPLATE = '依變更影響及實際採用能力驗證，測試層級與案例維護依'
  JAVA_PREFIX = '共同驗收與 Java 語言增量'
  IMPORTS = <<~JAVA
    import java.util.*; import java.util.concurrent.*; import java.util.concurrent.atomic.*;
    import java.util.concurrent.locks.*; import java.util.function.*; import java.util.stream.*;
    import java.time.*; import java.time.format.*; import java.math.*; import java.io.*;
    import java.nio.file.*; import java.nio.charset.*; import java.util.regex.*; import java.text.*;
  JAVA

  def initialize(root = File.expand_path('..', __dir__))
    @root = root
    @files = Dir[File.join(root, 'rules/**/*.md')].sort
    @common = @files.reject { |f| f.include?('/stacks/') }
    @java = Dir[File.join(root, 'rules/stacks/java/common/*.md')].sort
    @lines = @files.to_h { |f| [f, File.readlines(f, chomp: true)] }
    @errors = Hash.new(0)
    @notes = {}
    @skipped = []
  end

  def report(file, line, rule, message, failure: true)
    @errors[@command] += 1 if failure
    puts "#{file.delete_prefix(@root + '/')}:#{line + 1} [#{rule}] #{message}"
  end

  # 保留行號；忽略 fenced code 內的 Markdown 示範。
  def prose(file)
    fence = nil
    @lines.fetch(file).each_with_index.map do |line, i|
      if fence
        fence = nil if line.match?(/^\s{0,3}#{Regexp.escape(fence[0])}{#{fence.size},}\s*$/)
        next
      end
      opening = line.match(/^\s{0,3}(`{3,}|~{3,})/)
      if opening
        fence = opening[1]
        next
      end
      [line, i]
    end.compact
  end

  def titles(file)
    prose(file).map do |line, i|
      m = line.match(/^\s{0,3}(\#{1,6})\s+(.+?)\s*#*\s*$/)
      [m[1].size, m[2], i] if m
    end.compact
  end

  def ids(line)
    line.scan(/<a\s+id=["']([^"']+)["'][^>]*>/).flatten
  end

  def slug(title)
    title.gsub(/<[^>]+>/, '').gsub(/\[([^\]]+)\]\([^)]*\)/, '\1')
         .delete('`').downcase.gsub(/[^\p{L}\p{N} _-]/u, '').tr(' ', '-')
  end

  def anchors(file)
    return Set.new unless @lines.key?(file)
    result = prose(file).flat_map { |line, _| ids(line) }.to_set
    used = Set.new
    titles(file).each do |_, title, _|
      base = slug(title)
      candidate = base
      n = 0
      while used.include?(candidate)
        n += 1
        candidate = "#{base}-#{n}"
      end
      used << candidate
      result << candidate
    end
    result
  end

  # 支援目前文件的行內連結，以及完整／縮寫 reference links。
  def local_links(file)
    rows = prose(file)
    definitions = {}
    rows.each do |line, _|
      m = line.match(/^\s{0,3}\[([^\]]+)\]:\s*<?([^\s>]+)>?/)
      definitions[m[1].downcase] = m[2] if m
    end
    rows.flat_map do |line, i|
      next [] if line.match?(/^\s{0,3}\[[^\]]+\]:/)
      targets = line.scan(/\]\(\s*(?:<([^>]+)>|([^\s)]+))(?:\s+["'][^\n]*?["'])?\s*\)/).map { |a, b| a || b }
      line.scan(/\[([^\]]+)\]\[([^\]]*)\]/) do |label, ref|
        key = (ref.empty? ? label : ref).downcase
        targets << definitions.fetch(key, "__undefined_reference__:#{key}")
      end
      targets.map do |target|
        next if target.match?(/\A(?:[a-z][a-z0-9+.-]*:|\/\/)/i) && !target.start_with?('__undefined_reference__:')
        [target, i]
      end.compact
    end
  end

  def destination(file, target)
    path, fragment = target.split('#', 2)
    decode = ->(value) { URI::DEFAULT_PARSER.unescape(value) }
    [path.empty? ? file : File.expand_path(decode.call(path), File.dirname(file)), fragment && decode.call(fragment)]
  end

  def links
    broken = whole = total = 0
    cache = @files.to_h { |f| [f, anchors(f)] }
    @files.each do |file|
      local_links(file).each do |target, i|
        total += 1
        dest, fragment = destination(file, target)
        if !File.file?(dest) || (fragment && !cache.fetch(dest, anchors(dest)).include?(fragment))
          broken += 1
          report(file, i, 'links', "失效連結 #{target}（#{File.file?(dest) ? '錨點不存在' : '檔案不存在'}）")
        end
        if file.include?('/stacks/java/') && @common.include?(dest) && (fragment.nil? || fragment.empty?)
          whole += 1
          report(file, i, 'links', "警告：Java → 共通整檔連結未帶錨點：#{target}", failure: false)
        end
      end
    end
    @notes[@command] = "#{total} 個連結，失效 #{broken}、Java → 共通整檔警告 #{whole}"
  end

  def duplicate_headings(file, rule)
    seen_titles = {}
    seen_ids = {}
    titles(file).each do |_, title, i|
      report(file, i, rule, "標題重複：#{title}（首次於 #{seen_titles[title] + 1} 行）") if seen_titles.key?(title)
      seen_titles[title] ||= i
    end
    prose(file).each do |line, i|
      ids(line).each do |id|
        report(file, i, rule, "錨點重複：#{id}（首次於 #{seen_ids[id] + 1} 行）") if seen_ids.key?(id)
        seen_ids[id] ||= i
      end
    end
  end

  def headings
    @files.each { |file| duplicate_headings(file, 'headings') }
    @notes[@command] = "#{@files.size} 份文件"
  end

  def skeleton
    @common.each do |file|
      lines = @lines[file]
      hs = titles(file)
      report(file, 0, 'S1', '第一行不是一級標題') unless lines.first&.match?(/^# \S/)
      hs.select { |level, _, i| level == 1 && i > 0 }.each { |_, _, i| report(file, i, 'S1', '多餘的一級標題') }
      previous = 1
      hs.each do |level, title, i|
        report(file, i, 'S2', '標題層級超過三級或跳級') if level > 3 || level > previous + 1
        previous = level
        next if level == 1
        j = i - 1
        preceding = []
        while j >= 0 && (lines[j].strip.empty? || lines[j].match?(/^<a id=["'][^"']+["']><\/a>\s*$/))
          preceding = ids(lines[j]) + preceding
          j -= 1
        end
        first = preceding.first
        if first.nil?
          report(file, i, 'S3', "標題前沒有錨點：#{title}")
        else
          report(file, i, 'S3', "第一個錨點不是語意名稱：#{first}") unless first.match?(/\A[a-z][a-z0-9-]*\z/) && !first.match?(/\A[a-z]{2}-\d{2}\z/)
          report(file, i, 'S3', '## 驗收 的語意錨點必須是 acceptance') if level == 2 && title == '驗收' && first != 'acceptance'
        end
      end
      h2s = hs.select { |level, _, _| level == 2 }
      first_h2 = h2s.first&.last || lines.size
      lines.first(first_h2).each_with_index do |line, i|
        report(file, i, 'S4', '第一個 ## 之前出現條列／表格／程式碼') if line.match?(/^\s*(?:[-*+] |\d+[.)] |\||`{3,}|~{3,})/)
      end
      # 沿用原骨架檢查器的索引頁例外：README 與跨主題驗收索引。
      index = %w[rules/README.md rules/quality/rule-verification.md].include?(file.delete_prefix(@root + '/'))
      has_acceptance = hs.any? { |_, title, _| title.include?('驗收') } || prose(file).any? { |line, _| line.match?(/^\| 契約 \| 驗收內容 \|/) }
      unless index
        h2s.each { |_, title, i| report(file, i, 'S5', "含「驗收」的 ## 標題只能是「驗收」：#{title}") if title.include?('驗收') && title != '驗收' }
        report(file, h2s.last&.last || 0, 'S5', '檔案含驗收內容，但最後一個 ## 不是「驗收」') if has_acceptance && h2s.last&.[](1) != '驗收'
      end
      prose(file).each { |line, i| report(file, i, 'S6', '驗收樣板句只允許於 quality/testing.md') if line.include?(TEMPLATE) && file != File.join(@root, 'rules/quality/testing.md') }
      duplicate_headings(file, 'S7')
      next if file == File.join(@root, 'rules/README.md')
      acceptance = h2s.find { |_, title, _| title == '驗收' }&.last
      paragraph_end = acceptance && acceptance + 1
      if paragraph_end
        paragraph_end += 1 while paragraph_end < lines.size && lines[paragraph_end].strip.empty?
        paragraph_end += 1 while paragraph_end < lines.size && !lines[paragraph_end].strip.empty?
      end
      local_links(file).each do |target, i|
        dest, fragment = destination(file, target)
        next unless fragment.nil? && @common.include?(dest)
        next if i < first_h2 || (acceptance && i > acceptance && i < paragraph_end)
        report(file, i, 'S8', "整檔連結須帶錨點：#{target}")
      end
    end
    @notes[@command] = "#{@common.size} 份共通文件"
  end

  def template
    @files.each do |file|
      prose(file).each do |line, i|
        report(file, i, 'template', '共通驗收樣板句只允許於 quality/testing.md') if line.include?(TEMPLATE) && file != File.join(@root, 'rules/quality/testing.md')
      end
    end
    # 只比較驗收導言第一句；後續案例選擇依主題不同。
    paragraphs = @java.to_h do |file|
      rows = prose(file)
      matches = rows.map do |line, i|
        next unless line.include?(JAVA_PREFIX)
        ending = i + 1
        ending += 1 while ending < @lines[file].size && !@lines[file][ending].strip.empty?
        [@lines[file][i...ending].map(&:strip).join.split(/(?<=。)/, 2).first, i]
      end.compact
      [file, matches]
    end
    counts = paragraphs.values.flatten(1).each_with_object(Hash.new(0)) { |(text, _), counts| counts[text] += 1 }
    canonical = counts.keys.max_by { |text| counts[text] }
    report('rules/stacks/java/common', 0, 'template', "預期 15 份 Java 主題文件，實際 #{@java.size} 份") unless @java.size == 15
    paragraphs.each do |file, matches|
      if matches.size != 1
        report(file, matches.first&.last || 0, 'template', "Java 驗收樣板段落須恰有一份，目前 #{matches.size} 份")
      elsif matches.first.first != canonical
        report(file, matches.first.last, 'template', 'Java 驗收樣板第一句與其他文件的最多數版本不同')
      end
    end
    @notes[@command] = "#{@java.size} 份 Java 文件，樣板 #{counts.size} 種（比較導言第一句）"
  end

  # 以三級標題及其前置錨點識別小節；程式碼內的 Markdown 不參與結構判定。
  def java_sections(file)
    rows = prose(file)
    sections = []
    pending = []
    current = nil
    rows.each do |line, i|
      heading = line.match(/^\s{0,3}(\#{1,6})\s+(.+)/)
      if heading
        current[:end] = i if current
        current = nil
        if heading[1].size == 3
          current = { file: file, start: i, end: @lines[file].size, ids: pending.dup, blocks: [] }
          sections << current
        end
        pending = []
      elsif !ids(line).empty?
        pending.concat(ids(line))
      elsif !line.strip.empty?
        pending = []
      end
    end
    sections
  end

  def versions
    sections = @java.flat_map { |file| java_sections(file) }
    labels = { '8' => [8], '8／11' => [8, 11], '11' => [11], '17 起' => [17, 21], '21 起' => [21] }
    @java.each do |file|
      rows = prose(file)
      local = sections.select { |s| s[:file] == file }
      rows.each do |line, i|
        if line.match?(/^\s*\*\*(?:違反|符合)/) && !line.match?(EXAMPLE_MARKER)
          report(file, i, 'V1', '範例標記須用全形括號及支援版本 8、11、17、21')
        end
        next unless line.match?(/^\s*\*\*版本差異/)
        report(file, i, 'V2', '版本差異標記整行須恰為 **版本差異**') unless line == '**版本差異**'
        section = local.find { |s| i > s[:start] && i < s[:end] }
        unless section
          report(file, i, 'V2', '版本差異須位於三級小節內')
          next
        end
        report(file, i, 'V2', '每小節最多一個版本差異區塊') unless section[:blocks].empty?
        # 有主範例的小節，區塊須在全部主範例之後；沒有主範例（設定、流程類小節）則直接接在條文之後。
        main = rows.select { |text, n| n > section[:start] && n < section[:end] && text.match?(/^\*\*(違反|符合)\*\*$/) }
        unless main.all? { |_, n| n < i }
          report(file, i, 'V2', '版本差異須在主範例違反／符合之後')
        end
        boundary = rows.find do |text, n|
          n > i && (text.match?(/^\s{0,3}\#{1,6}\s/) ||
            (!ids(text).empty? && text.match?(/^\s*<a\s/)) ||
            text.match?(/^\*\*(違反|符合)[（(]Java /))
        end
        ending = boundary&.last || @lines[file].size
        # 下一個同級／上級標題才結束小節；較深標題仍是區塊後的非法結構。
        section_end = titles(file).find { |level, _, n| n > i && level <= 3 }&.last || @lines[file].size
        # 緊貼下一個標題前的錨點行屬於下一小節，不算區塊後的新錨點。
        lead = section_end
        lead -= 1 while lead - 1 > i && (@lines[file][lead - 1].strip.empty? || @lines[file][lead - 1].match?(/\A<a\s+id="[^"]+"><\/a>\s*\z/))
        rows.each do |text, n|
          next unless n >= ending && n < lead
          if text.match?(/<a\s+id\b|^\s{0,3}\#{1,6}\s/)
            report(file, n, 'V5', '版本差異區塊後至下一個同級／上級標題前不得有錨點或標題')
          end
        end
        block = { line: i, versions: Set.new }
        section[:blocks] << block
        previous = 0
        seen = Set.new
        entries = 0
        @lines[file][(i + 1)...ending].each_with_index do |text, offset|
          n = i + 1 + offset
          next if text.strip.empty?
          if text.match?(/不適用|豁免|免除|可不|不再需要|得省略|<a\s+id|\A\s*\#{1,6}\s|驗收/)
            report(file, n, 'V4', '版本差異不得放寬要求或含錨點、標題、驗收')
          end
          match = text.match(/\A- Java (8|8／11|11|17 起|21 起)：\S/)
          unless match
            report(file, n, 'V3', '版本差異只允許以指定版本標籤起頭的條列')
            next
          end
          entries += 1
          label = match[1]
          # 「起」涵蓋較新版本供 V5 使用，但排序／重複只計明列的版本。
          explicit = label.scan(/\d+/).map(&:to_i)
          if explicit.first <= previous || explicit.any? { |v| seen.include?(v) }
            report(file, n, 'V3', '版本標籤須遞增且不得重複')
          end
          previous = explicit.last
          seen.merge(explicit)
          block[:versions].merge(labels.fetch(label).map(&:to_s))
        end
        report(file, i, 'V3', '版本差異至少須有一個版本條列') if entries.zero?
      end
      rows.each do |line, i|
        marker = line.match(EXAMPLE_MARKER)
        next unless marker && marker[2]
        section = local.find { |s| i > s[:start] && i < s[:end] }
        block = section && section[:blocks].find { |b| b[:line] < i }
        unless block && block[:versions].include?(marker[2])
          report(file, i, 'V5', '版本範例須在同小節版本差異之後，且版本須由條列涵蓋')
        end
      end
    end
    @common.each do |file|
      prose(file).each do |line, i|
        if line.include?('**版本差異**') || line.match?(/\*\*(違反|符合)[（(]Java /)
          report(file, i, 'V7', '共通文件不得含版本差異或版本範例標記')
        end
      end
    end
    policy = File.join(@root, 'rules/stacks/java/common/version-policy.md')
    indexed = Set.new
    if @lines.key?(policy)
      heading = titles(policy).find { |_, title, _| title == '版本差異索引' }
      if heading
        ending = titles(policy).find { |_, _, n| n > heading[2] }&.last || @lines[policy].size
        prose(policy).each do |line, i|
          next unless i > heading[2] && i < ending && line.start_with?('|')
          cells = line.split('|').map(&:strip)
          next if cells[1] == '主題檔' || cells[1]&.match?(/\A:?-+:?\z/)
          target = cells[2]&.match(/\A\[[^\]]+\]\(([^)]+)\)\z/)&.[](1)
          dest, fragment = target ? destination(policy, target) : [nil, nil]
          section = sections.find { |s| s[:file] == dest && s[:ids].include?(fragment) }
          if section && !section[:blocks].empty? && anchors(dest).include?(fragment)
            indexed << section
            covered = section[:blocks].flat_map { |block| block[:versions].to_a }.uniq.sort_by(&:to_i).join('、')
            unless cells[3] == covered
              report(policy, i, 'V6', "索引版本欄須與區塊涵蓋版本一致（應為 #{covered}）")
            end
          else
            report(policy, i, 'V6', '索引小節須連到存在且含版本差異的語意錨點')
          end
        end
      end
    end
    sections.select { |s| !s[:blocks].empty? }.each do |section|
      report(section[:file], section[:start], 'V6', '含版本差異的小節未列於版本差異索引') unless indexed.include?(section)
    end
    @notes[@command] = "#{@java.size} 份 Java 文件，#{sections.sum { |s| s[:blocks].size }} 個版本差異區塊"
  end

  def examples
    begin
      version, status = Open3.capture2e('javac', '-version')
    rescue Errno::ENOENT
      version = ''
      status = nil
    end
    unless status&.success?
      @skipped << @command
      report('scripts/check-rules.rb', 0, 'examples', '跳過：找不到可用 javac，請安裝 JDK 21', failure: false)
      return
    end
    minimum = SUPPORTED_JAVA.map(&:to_i).max
    major = version[/javac (\d+)(?:\.|\s|$)/, 1].to_i
    unless major >= minimum
      report('scripts/check-rules.rb', 0, 'examples', "需要 javac #{minimum}，實際 #{version.strip}")
      return
    end
    total = 0
    counts = Hash.new(0)
    @java.each do |file|
      lines = @lines[file]
      prose(file).each do |line, i|
        marker = line.match(EXAMPLE_MARKER)
        next unless marker
        release = marker[2] || BASELINE_JAVA
        j = i + 1
        j += 1 while j < lines.size && lines[j].strip.empty?
        unless lines[j]&.strip == '```java'
          report(file, i, 'examples', '範例標記後須接 Java 程式碼圍欄')
          next
        end
        ending = j + 1
        ending += 1 while ending < lines.size && lines[ending].strip != '```'
        total += 1
        counts[release] += 1
        if ending == lines.size
          report(file, j, 'examples', 'Java 範例沒有結束圍欄')
          next
        end
        code = lines[(j + 1)...ending].join("\n")
        if code.match?(/--enable-preview|StructuredTaskScope|ScopedValue|StringTemplate/)
          report(file, j, 'examples', '範例不得含 Preview 功能或啟用參數')
          next
        end
        Dir.mktmpdir('rules-example-') do |dir|
          name = code[/public\s+(?:(?:final|abstract|sealed|non-sealed)\s+)*(?:class|record|interface|enum)\s+(\w+)/, 1] || 'Snippet'
          src = File.join(dir, "#{name}.java")
          File.write(src, IMPORTS + code + "\n")
          output, result = Open3.capture2e('javac', '--release', release, '-encoding', 'UTF-8', '-proc:none', '-Xlint:none', '-Xlint:-options', '-d', dir, src)
          unless result.success?
            diagnostic = output.gsub(dir + '/', '').lines.first(6).map(&:strip).join(' | ')
            report(file, j, 'examples', "#{line.delete('*')}範例編譯失敗：#{diagnostic}")
          end
        end
      end
    end
    report('rules/stacks/java/common', 0, 'examples', '沒有找到違反／符合 Java 範例') if total.zero?
    distribution = ([BASELINE_JAVA] + (SUPPORTED_JAVA - [BASELINE_JAVA])).map { |v| "Java #{v}=#{counts[v]}" if counts[v].positive? }.compact
    @notes[@command] = "#{total} 個範例（#{distribution.join('、')}）"
  end

  def run(commands)
    commands = COMMANDS if commands.empty? || commands == ['all']
    if (commands - COMMANDS).any?
      warn "scripts/check-rules.rb:1 [usage] 用法：ruby scripts/check-rules.rb [all|#{COMMANDS.join('|')}]"
      return 2
    end
    commands.uniq.each do |command|
      @command = command
      send(command)
    end
    puts '摘要：' + commands.uniq.map { |command|
      state = @skipped.include?(command) ? '跳過' : (@errors[command].zero? ? '通過' : '失敗')
      "#{command}=#{state}（#{@errors[command]} 項問題#{@notes[command] ? '；' + @notes[command] : ''}）"
    }.join('；')
    return 1 if @errors.values.any?(&:positive?)
    @skipped.empty? ? 0 : 2
  end
end

exit RulesCheck.new.run(ARGV) if $PROGRAM_NAME == __FILE__
