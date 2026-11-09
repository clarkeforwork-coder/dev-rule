# frozen_string_literal: true
require_relative 'body-restructuring-lib'
require_relative 'final-acceptance'
Dir.chdir(ENV.fetch('BODY_ROOT',File.expand_path('..',__dir__)))
def original(ref,path); BodyRestructuring.original(path,ref); end
MIN_REASON_LENGTH=20
def normalize(text)
  text.gsub(/<[^>]*>/, '').gsub(/\[([^\]]+)\]\([^)]+\)/, '\1').delete('`*_').gsub(/\s+/, '')
end
def sufficient_reason?(reason)
  reason.is_a?(String) && reason.gsub(/[[:space:]]/, '').length >= MIN_REASON_LENGTH
end
def destination_content(text)
  text.to_s.gsub(/<a\s+id="[^"]+"><\/a>/, '').strip
end
def row_content(line)
  m = line.match(/^\| (.+) \| (.*) \|\s*$/)
  m && !m[1].start_with?('---') ? m[2] : nil
end
def acceptance_rows(body)
  active = false
  body.lines.map do |line|
    if line.match?(/^\| (?:契約|對應決策|Java 條文|對應要求) \| (?:驗收內容|語言增量驗收) \|/)
      active = true; next
    end
    active = false unless line.start_with?('|')
    row_content(line) if active
  end.compact
end
def destination(uri)
  path, anchor = uri.split('#',2)
  path = Pathname.new(File.join('docs',path)).cleanpath.to_s
  return nil unless anchor && File.file?(path)
  text = File.read(path)
  text = FinalAcceptance.trace_text(text,path) if FinalAcceptance.active?
  record_path = "docs/body-restructuring/java/#{File.basename(path,'.md')}.json"
  if File.file?(record_path)
    JSON.parse(File.read(record_path)).fetch('acceptance_text_changes',[]).each do |change|
      text = text.sub(change.fetch('after'), change.fetch('before'))
    end
  end
  lines = text.lines
  idx = lines.index { |l| l.include?(%(<a id="#{anchor}"></a>)) }
  return nil unless idx
  return row_content(lines[idx]) if lines[idx].start_with?('|')
  # 獨立錨點只對應緊接的一段，不能用整節掩蓋指錯位置。
  tail = lines[idx].sub(/.*?<\/a>/,'').strip
  return tail unless tail.empty?
  rest = lines[(idx+1)..].drop_while { |l| l.strip.empty? }
  rest.take_while { |l| !l.strip.empty? }.join.strip
end
errors=[]
manifest=JSON.parse(File.read('scripts/acceptance-batches.json'))
paths=Dir.glob('rules/**/*.md')
common=paths.reject{|p| p.include?('/stacks/')}
scope=manifest.values.flat_map{|b|b.fetch('files').values}.uniq.map{|s|"rules/stacks/java/common/#{s}.md"}
# 整份併入時，以接收檔承接原文件驗收；歷史來源仍從原提交讀取。
merges=Dir.glob('docs/body-restructuring/java/*.json').map{|p|JSON.parse(File.read(p))}.select{|r|r['status']=='merged'}.map{|r|[r['path'],r.fetch('merged_target')]}.to_h
scope=scope.map{|p|merges.fetch(p,p)}.uniq
paths.each{|p|acceptance_rows(File.read(p)).each{|t|errors << "Empty acceptance #{p}" if t.strip.size<9}}
common_tests=common.flat_map{|p| acceptance_rows(File.read(p)).map{|t|normalize(t)}}
duplicates=scope.flat_map{|p| acceptance_rows(File.read(p)).select{|t|common_tests.include?(normalize(t))}.map{|t|[p,t]}}
errors << "Scoped duplicate acceptance: #{duplicates}" unless duplicates.empty?
rewrites=JSON.parse(File.read('docs/acceptance-rewritten-fragments.json'))
rewrites.each do |entry|
  content = destination(entry['target'])
  unless content && destination_content(content) == destination_content(entry['replacement']) && sufficient_reason?(entry['reason'])
    errors << "Invalid rewritten fragment #{entry['id']}: full destination and meaningful-length reason required"
  end
end
batches=manifest.keys
stats=[]
batches.each do |n|
  report="docs/acceptance-cleanup-batch-#{n}.md"
  body=File.read(report)
  baseline=body[/基準提交：`([^`]+)`/,1]
  traces=body.lines.map{|l| l.match(/^\| ([A-Z]+-[\d、]+-\d+) \| (.+) \| \[主要驗收\]\(([^)]+)\) \|\s*$/)}.compact
  malformed=body.lines.select{|l|l.match?(/^\| [A-Z]+-/) && !traces.any?{|m|m[0]==l}}
  errors << "Malformed trace rows batch #{n}" unless malformed.empty?
  errors << "Duplicate trace IDs batch #{n}" unless traces.map{|m|m[1]}.uniq.size==traces.size
  expected_ids=[];rows=0;verbatim=0;rewritten=0
  manifest.fetch(n).fetch('files').each do |prefix,slug|
    original(baseline,"rules/stacks/java/common/#{slug}.md").lines.each do |line|
      m=line.match(/^\| ([\d、]+) \| (.+) \|\s*$/);next unless m
      rows+=1
      pieces=traces.select{|r|r[1].match?(/\A#{prefix}-#{Regexp.escape(m[1])}-\d+\z/)}
      expected_ids.concat(pieces.map{|r|r[1]})
      errors << "Missing/changed original fragments #{prefix}-#{m[1]}" unless pieces.map{|r|r[2]}.join==m[2] && pieces.map{|r|r[1].split('-').last.to_i}==(1..pieces.size).to_a
    end
  end
  errors << "Unexpected trace fragments batch #{n}" unless expected_ids.sort==traces.map{|r|r[1]}.sort
  traces.each do |m|
    text=destination(m[3])
    if text && text.include?(m[2]);verbatim+=1;next;end
    entry=rewrites.find{|r|r['batch']==n && r['id']==m[1]}
    if entry && entry['original']==m[2] && entry['target']==m[3] && text && destination_content(text) == destination_content(entry['replacement']) && !destination_content(entry['replacement']).empty? && sufficient_reason?(entry['reason'])
      rewritten+=1
    else
      errors << "Trace fragment absent from destination #{m[1]}: #{m[3]}"
    end
  end
  stats << {batch:n.to_i,baseline:baseline,original_rows:rows,verbatim_fragments:verbatim,listed_rewritten_fragments:rewritten}
end
abort(errors.uniq.join("\n")) unless errors.empty?
puts JSON.pretty_generate({duplicate_java_acceptance_rows:duplicates.size,trace_checks:stats})
