# frozen_string_literal: true
# 只供暫存複本演練；不對實際 rules 執行。
require_relative 'body-structure-checks'
module BodyRehearsal
  NAMES={
   'CO'=>%w[ownership snapshots order traversal compound-atomicity accumulation lazy-resources batch-failure ownership-verification],
   'BM'=>%w[boundary-isolation field-sources mapping-responsibility mapping-failure update-intent reference-isolation directions maintenance mapping-verification],
   'EX'=>%w[exception-contracts checked-exceptions catch-scope interruption resource-ownership cleanup-failures batch-failure retry-result exception-verification],
   'EQ'=>%w[value-identity equality-contract hash-stability value-semantics cross-type-equality ordering-role comparison-contract sorted-equality sorted-stability equality-verification],
   'CA'=>%w[task-ownership execution-resources visibility deadline cancellation result-reception completion blocking context queue-limits shared-state concurrency-verification],
   'JT'=>%w[explicit-types generic-types type-relations downcasts warnings data-shapes type-bounds collections diamond return-types parameter-names],
   'ND'=>%w[naming-forms responsibility-names packages contract-docs implementation-notes renaming documentation-verification]
  }.freeze
  B=BodyRestructuring

  def self.save(r)
    r['edits']=B.edits(B.original(r['path']),File.read(r['path'])).map{|e|e.merge('reason'=>'演練依逐句去向改為基準小標題，保留原句及驗收，差異由本主題紀錄承接。')}
    File.write("docs/body-restructuring/java/#{File.basename(r['path'],'.md')}.json",JSON.pretty_generate(r)+"\n")
  end
  def self.convert(topic)
    p="rules/stacks/java/common/#{topic}.md";r=JSON.parse(File.read("docs/body-restructuring/java/#{topic}.json"));base=B.original(p);prefix=r['rules'].first['id'].split('-').first
    r['status']='completed';r['imports']=[];r['acceptance_changes']=[];r['acceptance_text_changes']=[];r['acceptance_additions']=[];r['group_routes']=[];r['link_retention']=[];r['link_exceptions']=[]
    titles={};uris={};B.rules(base).each{|n,title,_|id=format('%s-%02d',prefix,n);titles[id]=title;uris[id]=p+'#java-'+NAMES.fetch(prefix).fetch(n-1)}
    intro=B.body(base).split(/^## /,2).first;tails=[];lines=[];seen=false
    B.body(base).lines.each do |l|
      if m=l.match(/^(\d+)\. \*\*([^*]+)\*\*。(.*)$/)
        seen=true;id=format('%s-%02d',prefix,m[1].to_i);lines<<"<a id=\"#{uris[id].split('#').last}\"></a>\n\n### #{m[2]}\n\n#{m[3]}\n\n"
      elsif seen && !l.start_with?('## ')
        tails<<l unless l.strip.empty?
      else;lines<<l
      end
    end
    closing=tails.empty? ? '' : "<a id=\"java-closing-requirements\"></a>\n\n## 補充要求\n\n#{tails.join}\n"
    r['rules'].each{|e|e['kind']='整條保留';e['targets']=[uris[e['id']]];e['reason']="#{e['id']} 演練保守保留：本案例只判斷指定條文，其餘基準原文完整保留，待正式逐項複核。"}
    owners=BodyStructure.owners(base,prefix)
    r['sentences']=B.sentences(base).each_with_index.map do |source,i|
      id=owners[i];target=id ? uris[id] : intro.include?(source) ? p+'#'+BodyStructure.slug(base.lines.first.sub(/^# /,'')) : p+'#java-closing-requirements'
      {'history_id'=>id,'source'=>source,'action'=>'保留','targets'=>[{'uri'=>target,'text'=>source}],'reason'=>'基準原句逐字保留，演練只調整條號與小節結構。','removed_assertions'=>[],'common_sources'=>[]}
    end
    accept=base.split('## 驗收要求',2).last
    accept.lines.select{|l|l.start_with?('|')}.each do |row|
      after=row.sub('| Java 條文 |','| 對應要求 |')
      if row.include?('<a id=')
        left,right=row.split(' | ',2);left=left.gsub(/(?<=<\/a>)[\d、]+/){|numbers|numbers.split('、').map{|n|id=format('%s-%02d',prefix,n.to_i);"[#{titles[id]}](##{uris[id].split('#').last})"}.join('、')};after=left+' | '+right
      end
      if after!=row;r['acceptance_changes']<<{'before'=>row,'after'=>after,'reason'=>'演練將驗收第一欄條號改為對應 Java 小節連結，驗收第二欄逐字保留。'};accept=accept.sub(row,after);end
    end
    if prefix=='EX'||prefix=='EQ'
      n=prefix=='EX' ? 9 : 10;before=accept.lines.find{|l|l.include?("第 #{n} 條")}
      if before
        after=before.sub("第 #{n} 條","[#{titles[format('%s-%02d',prefix,n)]}](##{uris[format('%s-%02d',prefix,n)].split('#').last})")
        r['acceptance_text_changes']<<{'before'=>before,'after'=>after,'references'=>[{'before'=>"第 #{n} 條",'after'=>after[/\[[^\]]+\]\(#java-[^)]+\)/]}],'reason'=>'依作業說明僅替換驗收段落的歷史條號，原有斷言及其餘標點逐字保留。'};accept=accept.sub(before,after)
      end
    end
    if %w[CA CO].include?(prefix)
      r['acceptance_additions']=BodyStructure::ACCEPTANCE_ADDITIONS.fetch(p)
      accept=accept.sub("\n\n### Java 語言增量驗收", "\n"+r['acceptance_additions'].join+"\n### Java 語言增量驗收")
    end
    File.write(p,lines.join+closing+'## 驗收要求'+accept)
    if prefix=='BM'
      i=BodyStructure::APPROVED_IMPORTS.first.merge('target_uri'=>uris['BM-04'],'reason'=>'BM-04 依核准選 B 移入固定基準共通禁止句，工作者不刪共通摘要，由協調者收尾。')
      r['imports']=[i];text=File.read(p);section=BodyStructure.excerpt(uris['BM-04']);File.write(p,text.sub(section,section.rstrip+''+i['source_text']+"。\n\n"))
    end
    save(r);r
  end
  def self.remove(r,id,source_uris,partial=false)
    p=r['path'];e=r['rules'].find{|x|x['id']==id};old=e['targets'].first;ss=r['sentences'].select{|s|s['history_id']==id};chosen=partial ? ss.take(1) : ss
    chosen.each_with_index do |s,i|
      s['action']='移除';s['targets']=source_uris.map{|u|{'uri'=>u}};s['common_sources']=source_uris
      s['removed_assertions']=source_uris.map{|u|{'text'=>s['source'],'source_uri'=>u,'source_text'=>BodyStructure.units(BodyStructure.excerpt(u)).first}}
      s['reason']="#{id} 第 #{i+1} 句移除：承接來源列於本句證據；演練核對共通涵蓋，正式整理仍須人工複核語意。"
    end
    e['kind']=partial ? '拆分' : '整條移除';e['targets']=partial ? [old]+source_uris : source_uris
    e['reason']=partial ? "#{id} 原判重述，但剩餘 Java 句子的涵蓋不夠直接，保守保留並將種類登記為拆分。" : "#{id} 兩句共同要求改由登記的共通來源維護，驗收與原有連結仍在本文件保留。"
    text=File.read(p)
    if partial;chosen.each{|s|text=text.sub(s['source'],'')}
    else;section=BodyStructure.excerpt(old);text=text.sub("<a id=\"#{old.split('#').last}\"></a>\n\n"+section,'')
    end
    # 表格條號原本指向已移除條文，改為共通連結。
    unless partial
      r['acceptance_changes'].each do |change|
        before=change['after'];after=before.gsub(/\[[^\]]+\]\(##{Regexp.escape(old.split('#').last)}\)/) do
          u=source_uris.first;f,a=u.split('#',2);"[#{a}](#{Pathname.new(f).relative_path_from(Pathname.new(File.dirname(p)))}##{a})"
        end
        text=text.sub(before,after);change['after']=after
      end
    end
    File.write(p,text);save(r)
  end
  def self.finish_links(r)
    p=r['path'];base=B.original(p);text=File.read(p)
    B.body(base).split(/^## /).drop(1).each do |section|
      heading=section.lines.first.strip;ids=B.rules(section).map{|n,_,_|format('%s-%02d',r['rules'].first['id'].split('-').first,n)}
      next if ids.empty?
      entries=r['rules'].select{|e|ids.include?(e['id'])};next unless entries.all?{|e|e['kind']=='整條移除'}
      uris=entries.flat_map{|e|e['targets']}.uniq.sort
      links=uris.map{|u|f,a=u.split('#',2);"[#{a}](#{Pathname.new(f).relative_path_from(Pathname.new(File.dirname(p)))}##{a})"}
      route={'heading'=>heading,'targets'=>uris,'text'=>"本組要求依#{links.join('、')}辦理。"};r['group_routes']<<route
      text=text.sub("## #{heading}\n","## #{heading}\n\n#{route['text']}\n")
    end
    missing=BodyStructure.common_links(base,p).uniq-BodyStructure.common_links(text,p).uniq
    unless missing.empty?
      links=missing.map{|u|f,a=u.split('#',2);"[#{a||File.basename(f,'.md')}](#{Pathname.new(f).relative_path_from(Pathname.new(File.dirname(p)))}#{a ? '#'+a : ''})"}
      item={'targets'=>missing,'text'=>"本文件另依#{links.join('、')}辦理。"};r['link_retention']<<item;text=text.sub(/^## /,item['text']+"\n\n## ")
    end
    File.write(p,text);save(r)
  end
end
