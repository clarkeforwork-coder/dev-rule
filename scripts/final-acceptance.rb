# frozen_string_literal: true
# 核准清單是逐筆字面轉換；不放寬整條保留或任意改寫。
require 'json'
require 'pathname'
require 'digest'
module FinalAcceptance
  START='53c26dcbecbdd31c6082ffd91f608660a2d38b0d'.freeze
  CONFIG='docs/final-acceptance.json'.freeze
  PLAN=File.expand_path('final-acceptance-plan.json',__dir__).freeze
  PLAN_SHA='bd8ba4bd4e77fcea70a682cdc48224f26eabfffa0a6d4cbcb0a23ed3afa8c2de'.freeze
  def self.active?;File.file?(CONFIG);end
  def self.plan
    raw=File.read(PLAN);raise '最後驗收核准清單內容變動' unless Digest::SHA256.hexdigest(raw)==PLAN_SHA
    JSON.parse(raw)
  end
  def self.steps
    c=JSON.parse(File.read(CONFIG));raise '最後驗收起點不符' unless c['start']==START
    ids=plan['steps'].map{|s|s['id']};raise '最後驗收步驟不符' unless c.keys.sort==%w[start steps] && c['steps'].is_a?(Array) && c['steps'].uniq==c['steps'] && (c['steps']-ids).empty?
    plan['steps'].select{|s|c['steps'].include?(s['id'])}
  end
  def self.moves;steps.flat_map{|s|s['moves']};end
  def self.ops;steps.flat_map{|s|s['ops']};end
  def self.links(text,path,reverse=false)
    text.gsub(/\]\(([^)]+)\)/) do |m|
      uri=$1;next m if uri.match?(/\A(?:https?:|mailto:)/)
      f,a=uri.split('#',2);next m unless a
      full=(f.empty? ? path : Pathname.new(File.join(File.dirname(path),f)).cleanpath.to_s)+'#'+a
      e=moves.find{|e|e[reverse ? 'to' : 'from']==full};next m unless e
      p,n=e[reverse ? 'from' : 'to'].split('#',2)
      relative=p==path ? '' : Pathname.new(p).relative_path_from(Pathname.new(File.dirname(path))).to_s
      "](#{relative}##{n})"
    end
  end
  def self.value(v,path)
    case v
    when Hash;v.map{|k,x|[k,value(x,v['path']||path)]}.to_h
    when Array;v.map{|x|value(x,path)}
    when String
      t=links(v,path);moves.each{|e|t=t.gsub(e['from'],e['to'])};t
    else;v
    end
  end
  def self.transform(files)
    result=files.transform_values(&:dup)
    ops.each do |o|
      t=result.fetch(o['path']);b=o['before'];raise "核准原文不存在 #{o['path']}: #{b}" unless t.scan(Regexp.new(Regexp.escape(b))).size==1
      result[o['path']]=t.sub(b,o['after'])
    end
    result.transform_keys{|p|p}.map{|p,t|[p,links(t,p)]}.to_h
  end
  def self.undo(files)
    result=files.map{|p,t|[p,links(t,p,true)]}.to_h
    # 轉回連結後，操作中的新連結也須採相同正規化，再倒序還原。
    ops.reverse_each do |o|
      p=o['path'];a=links(o['after'],p,true);b=links(o['before'],p,true)
      raise "核准修正缺失 #{p}" unless result[p].include?(a)
      result[p]=result[p].sub(a,b)
    end
    result
  end
  def self.render(files,records)
    prior_files=files
    files=transform(files)
    records=records.map do |p,r|
      prior_record=r
      r=value(r,r['path']);changes=ops.select{|o|o['path']==r['path']}
      r['final_reference_changes']=changes unless changes.empty?
      r['edits']=BodyRestructuring.edits(BodyPresentation.rename(BodyRestructuring.original(r['path']),r['path']),files[r['path']]).map{|e|e.merge('reason'=>'階段 C 核准連結與版面轉換，以及 final_reference_changes 明列的指代修正；未放寬其他正文。')}
      r['edits']=prior_record['edits'] if files[r['path']]==prior_files[r['path']] && r==prior_record.merge('edits'=>r['edits'])
      [p,r]
    end.to_h
    [files,records]
  end
  def self.common_record(path,base)
    return base unless path.end_with?('/existing-sources.json')
    r=JSON.parse(base)
    r['final_acceptance_changes']={'start'=>START,'steps'=>steps.map do |s|
      {'id'=>s['id'],'blocks'=>s['ops'].reject{|o|o['path'].include?('/stacks/')},'link_moves'=>s['moves']}
    end}
    JSON.pretty_generate(r)+"\n"
  end
  def self.trace_text(text,path)
    ops.select{|o|o['path']==path&&o['before'].start_with?('|')&&o['before'].lines.size==1&&o['after'].lines.size==1}.reverse_each do |o|
      text=text.sub(links(o['after'],path),links(o['before'],path))
    end
    # BM-04 增補位於表格內的一個片段，保留舊追溯的完整目的列比較。
    if steps.any?{|s|s['id']=='references'}&&path=='rules/stacks/java/common/boundary-mapping.md'
      o=ops.last;text=text.sub(o['after'],o['before'])
    end
    text
  end
end
