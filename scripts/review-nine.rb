# frozen_string_literal: true
# 第九次審閱核准：只還原兩條並重生指路；語意核准仍須審查清單差異。
module ReviewNine
  START='b033bed93f7d1f80cfdabada48b294544330a05a'.freeze
  JAVA='rules/stacks/java/common/null-and-optional.md'.freeze
  ALIASES=[
    {'path'=>'rules/architecture/data-mapping.md','old'=>'既有共同保證的落實','new'=>'相關共通契約','kind'=>'heading'},
    {'path'=>'rules/quality/rule-verification.md','old'=>'語言與新增共通主題驗收入口','new'=>'語言與共通主題驗收入口','kind'=>'heading'}
  ].freeze
  def self.active?;FinalAcceptance.active?&&FinalAcceptance.steps.any?{|s|s['id']=='review-nine'};end
  def self.restore_record(r)
    return r unless r['path']==JAVA
    %w[JN-02 JN-06].each do |id|
      anchor=id=='JN-02' ? 'java-optional-nonnull' : 'java-nonnull-validation'
      rule=r['rules'].find{|e|e['id']==id};r['review_nine_previous_rules']||={};r['review_nine_previous_rules'][id]=Marshal.load(Marshal.dump(rule))
      reason="第九次審閱 #{id=='JN-02' ? 'L8' : 'L9'}：涵蓋不夠直接，依 350668e 原句逐字還原；整條保留於 Java。"
      reason+='整理前原文未提交，無法證明完整覆蓋。' if id=='JN-06'
      rule.merge!('kind'=>'整條保留','targets'=>[JAVA+'#'+anchor],'reason'=>reason)
      r['sentences'].select{|s|s['history_id']==id}.each do |s|
        s['action']='保留';s['targets']=[{'uri'=>JAVA+'#'+anchor,'text'=>s['source']}]
        s['removed_assertions']=[];s.delete('common_sources');s['reason']=reason
      end
    end
    r
  end
  def self.ordered_links(uris,path)
    uris.map{|u|BodyPresentation.links([u],path)}.join('、')
  end
  def self.routes(r)
    BodyPresentation.groups(BodyRestructuring.original(r['path'])).map do |heading,lines|
      numbers=BodyRestructuring.rules(lines.join).map(&:first)
      removed=r['rules'].select{|e|numbers.include?(e['id'].split('-').last.to_i)&&e['kind']=='整條移除'}.sort_by{|e|e['id'].split('-').last.to_i}
      next if removed.empty?
      uris=removed.flat_map{|e|e['targets']}.uniq
      {'heading'=>heading,'targets'=>uris,'text'=>"本組由共通規範承接的要求：#{ordered_links(uris,r['path'])}。"}
    end.compact
  end
  def self.regroup(text,r)
    (r.fetch('group_routes',[])+r.fetch('link_retention',[])).each{|g|text=text.sub(g['text']+"\n\n",'')}
    r['group_routes']=routes(r)
    r['group_routes'].each{|g|text=text.sub("## #{g['heading']}\n\n","## #{g['heading']}\n\n#{g['text']}\n\n")}
    p=r['path'];missing=BodyPresentation.common_links(FinalAcceptance.links(BodyPresentation.rename(BodyRestructuring.original(p),p),p),p).uniq-BodyPresentation.common_links(text,p).uniq
    r['link_retention']=[]
    unless missing.empty?
      g={'targets'=>missing.sort,'text'=>"本文件另依#{BodyPresentation.links(missing,p)}辦理。"}
      r['link_retention']=[g];text=text.sub(/^## /,g['text']+"\n\n## ")
    end
    text
  end
  def self.record(r,files)
    restore_record(r)
    if r['path'].end_with?('/collections-and-ownership.md')
      e=r['rules'].find{|e|e['id']=='CO-08'}
      e['reason']+=' 整理前原文未提交，無法證明完整覆蓋。' unless e['reason'].include?('整理前原文未提交')
    end
    # 由現行候選文件剔除舊格式／新格式指路，重新計算期待整句及順序。
    text=files.fetch(r['path'])
    r['group_routes'].each{|g|text=text.sub(g['text']+"\n\n",'')}
    text=text.lines.reject{|l|l.start_with?('本組由共通規範承接的要求：')}.join
    # 不改空白：此處只更新紀錄；全文由核准逐筆清單另行比對。
    r['group_routes']=routes(r)
    r['group_routes'].each{|g|raise "第九次審閱指路不符；期待值：#{g['text']}" unless files[r['path']].include?(g['text'])}
    r
  end
end
