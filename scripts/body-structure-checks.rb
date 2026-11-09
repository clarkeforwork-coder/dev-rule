# frozen_string_literal: true
require_relative 'body-restructuring-lib'
require_relative 'body-structure-policy'
module BodyStructure
  COMMON_FILES = %w[ca-06.json co-08.json existing-sources.json].freeze
  JN = 'rules/stacks/java/common/null-and-optional.md'.freeze
  # 協調者明列的既有驗收增文，工作者不得自行擴充。
  ACCEPTANCE_ADDITIONS = {
    JN => ["不合法資料從允許承接它的邊界輸入；型別要求依[型別安全](../../../coding/type-safety.md)。\n\n"],
    'rules/stacks/java/common/concurrency-and-async.md' => ["- [結果接收與故障處置](../../../coding/concurrency-and-async.md#acceptance-result-reception)。\n"],
    'rules/stacks/java/common/collections-and-ownership.md' => ["- [失敗後狀態](../../../coding/error-handling.md#acceptance-failure-state)。\n"]
  }.freeze
  def self.check(ok,message);raise message unless ok;end
  def self.units(text)
    text.lines.reject{|l|l.strip.empty? || l.start_with?('#','<a ')}.flat_map do |l|
      l=l.split(' | ',3)[1].to_s.sub(/ \|\s*$/,'') if l.start_with?('|')
      l.strip.sub(/\A- /,'').scan(/[^。]+。|[^。]+\z/)
    end
  end
  def self.owners(base,prefix)
    BodyRestructuring.body(base).lines.reject{|l|l.strip.empty? || l.start_with?('#','<a ')}.flat_map do |l|
      n=l[/^(\d+)\. /,1];id=n ? format('%s-%02d',prefix,n.to_i) : nil
      BodyRestructuring.sentences(l).map{|_|id}
    end
  end
  def self.imports(r,excerpt)
    r.fetch('imports').each do |i|
      check(i['source_path'].to_s.start_with?('rules/')&&!i['source_path'].include?('/stacks/'),'移入來源必須為共通檔')
      check(i['source_text'].is_a?(String)&&i['source_text'].strip.size>=8&&BodyRestructuring.original(i['source_path']).include?(i['source_text']),'移入原文不在固定基準')
      check(i['target_uri'].to_s.start_with?(r['path']+'#')&&excerpt.call(i['target_uri']).include?(i['source_text']),'移入原文不在 Java 目的小節')
      check(r['rules'].any?{|e|e['id']==i['history_id']&&e['targets'].include?(i['target_uri'])},'移入句所屬 ID 或小節不符')
      check(APPROVED_IMPORTS.any?{|a|a.all?{|k,v|i[k]==v}} && i['target_uri'].start_with?(BM+'#'),'移入句不在核准清單或並非完整原句')
      check(i.fetch('reason','').gsub(/\s/,'').size>=20,'移入句理由不足')
    end
  end
  def self.verify(r,base,prefix,excerpt,check_uri)
    path=r['path'];current=File.read(r['status']=='merged' ? r['merged_target'] : path)
    check(r['sentences'].map{|s|s['history_id']}==owners(base,prefix),'句子所屬歷史 ID 不符')
    imports(r,excerpt)
    return [] if r['status']=='pending'
    check(r['rules'].none?{|e|e['reason'].include?('尚未整理')},'已完成紀錄仍有尚未整理去向')
    r['rules'].each do |e|
      sentences=r['sentences'].select{|s|s['history_id']==e['id']}
      if %w[拆分 保留增量].include?(e['kind'])
        check(e['targets'].any?{|u|u.start_with?(path+'#java-')&&excerpt.call(u).start_with?('### ')} && sentences.any?{|s|s['action']!='移除'},"拆分或保留增量須保留本文件 Java 小節及至少一句正文 #{e['id']}")
      end
      if e['kind']=='整條保留'
        check(sentences.all?{|s|s['action']=='保留'},'整條保留必須逐句保留')
        original=BodyRestructuring.rules(base).find{|n,_,_|n==e['id'].split('-').last.to_i}[2]
        text=excerpt.call(e['targets'].first).lines.reject{|l|l.strip.empty?||l.start_with?('#','<a ')}.join.strip
        # 明確移入的句子另由基準共通原文驗證。
        r['imports'].select{|i|i['history_id']==e['id']}.each{|i|text=text.sub(i['source_text']+'。','').sub(i['source_text'],'').strip}
        check(text==original,'整條保留小節含刪改或新增句子')
      elsif e['kind']=='整條移除'
        check(sentences.all?{|s|s['action']=='移除'},'整條移除必須逐句移除')
      end
      check(sentences.all?{|s|(s['targets'].map{|t|t['uri']}&e['targets']).any?},"歷史 ID 去向與句子小節不一致 #{e['id']}：若有整句移除，請在 rules[].targets 加列該句承接的共通錨點")
    end
    r['sentences'].select{|s|s['action']=='改寫'}.each{|s|s['targets'].each{|t|check(units(excerpt.call(t['uri'])).include?(t['text']),'改寫 text 必須為目的地完整一句')}}
    manual=policy(r,base,prefix,excerpt,check_uri)
    r['sentences'].each_with_index do |s,index|
      assertions=s.fetch('removed_assertions')
      check(!assertions.empty?,'移除句缺少子句承接證據') if s['action']=='移除'
      assertions.each do |a|
        check(a['text'].is_a?(String)&&!a['text'].empty?&&s['source'].include?(a['text']),'被刪子句不在基準原句')
        owned=r['rules'].find{|e|e['id']==s['history_id']}
        scope=owned ? owned['targets'].select{|u|u.start_with?(path+'#')}.map{|u|excerpt.call(u)}.join : current
        check(!scope.include?(a['text']),'被刪子句仍在現行文件')
        check_uri.call(a['source_uri'])
        check(!a['source_uri'].split('#').first.include?('/stacks/'),'承接子句必須指向共通')
        check(a['source_text'].is_a?(String)&&a['source_text'].strip.size>=8&&units(excerpt.call(a['source_uri'])).include?(a['source_text']),'承接原文不在共通小節')
      end
      if s['action']=='移除'
        check(s['targets'].map{|t|t['uri']}.uniq.sort==assertions.map{|a|a['source_uri']}.uniq.sort,'移除去向與承接證據不一致')
      elsif s['action']=='改寫'
        s['targets'].each{|t|check(units(excerpt.call(t['uri'])).include?(t['text']),'改寫 text 必須為目的地完整一句')}
      end
      unless s['action']=='保留'
        manual<<{path:path,sentence:index,history_id:s['history_id'],action:s['action'],source:s['source'],targets:s['targets'],removed_assertions:assertions,reason:s['reason']}
      end
    end
    # 現行正文每個句子必須由一筆保留／改寫或移入紀錄承接。
    covered=r['sentences'].reject{|s|s['action']=='移除'}.flat_map{|s|s['targets'].select{|t|t['uri'].split('#').first==path}.map{|t|t['text']}}
    covered += r.fetch('group_routes',[]).map{|g|g['text']}
    covered += r.fetch('link_retention',[]).map{|g|g['text']}
    added=r['imports'].map{|i|i['source_text'].sub(/。\z/,'')}
    units(BodyRestructuring.body(current)).each do |u|
      check(covered.include?(u)||added.include?(u.sub(/。\z/,'')),"現行正文句子未登錄 #{path}: #{u}")
    end
    original=base.split('## 驗收要求',2).last
    expected=original.dup
    r['acceptance_changes'].each{|e|expected=expected.sub(e['before'],e['after'])}
    r.fetch('acceptance_text_changes').each do |e|
      check(e.fetch('reason','').gsub(/\s/,'').size>=20&&original.include?(e['before']),'驗收非表格變更來源／理由無效')
      replacement=e['before'].dup
      e.fetch('references').each do |ref|
        check(ref['before'].match?(/\A第\s*\d+\s*條\z/)&&ref['after'].match?(/\A\[[^\]]+\]\(#[^)]+\)\z/),'驗收非表格只准改條號引用')
        replacement=replacement.sub(ref['before'],ref['after'])
      end
      check(replacement==e['after'],'驗收非表格包含非條號改動')
      expected=expected.sub(e['before'],e['after'])
    end
    r.fetch('acceptance_additions').each do |add|
      check(ACCEPTANCE_ADDITIONS.fetch(path,[]).include?(add),'驗收增文未列白名單')
      marker=path==JN ? '### 共同驗收' : '### Java 語言增量驗收'
      expected=path==JN ? expected.sub(marker,add+marker) : expected.sub("\n\n"+marker,"\n"+add+"\n"+marker)
    end
    required=path==JN ? [] : ACCEPTANCE_ADDITIONS.fetch(path,[])
    check((required-r['acceptance_additions']).empty?,'缺少必要共同驗收增文')
    check(current.split('## 驗收要求',2).last==expected,'驗收非表格內容未依基準保留')
    manual
  end
end
