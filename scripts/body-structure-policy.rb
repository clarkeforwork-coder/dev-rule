# frozen_string_literal: true
module BodyStructure
  RETAIN = %w[JN-05 JN-11 VO-09 ST-01 ST-07 CL-04 CL-07 EQ-02 EQ-03 EQ-05 EQ-06 EQ-07 EQ-09 EX-05 LS-04 LS-07 CA-03 BM-04 ND-02].freeze
  BM='rules/stacks/java/common/boundary-mapping.md'.freeze
  APPROVED_IMPORTS=[{'source_path'=>'rules/architecture/data-mapping.md','history_id'=>'BM-04','source_text'=>'不得略過欄位或產生不完整物件掩蓋失敗'}].freeze
  def self.slug(s);s.strip.downcase.gsub(/[\p{P}\p{S}&&[^_-]]/,'').gsub(/\s/,'-');end
  def self.excerpt(uri)
    path,id=uri.split('#',2);lines=File.readlines(path);counts=Hash.new(0);index=nil;level=nil
    lines.each_with_index do |line,i|
      if line.include?(%(<a id="#{id}">));index=i;break;end
      if h=line.match(/^(\#{1,6})\s+(.+)$/)
        key=slug(h[2]);n=counts[key];counts[key]+=1;key="#{key}-#{n}" if n>0
        if key==id;index=i;level=h[1].size;break;end
      end
    end
    return '' unless index
    return lines[index] if lines[index].start_with?('|')
    unless level
      index+=1 while index+1<lines.size && lines[index+1].strip.empty?
      if h=lines[index+1].to_s.match(/^(\#{1,6})\s/);index+=1;level=h[1].size
      else
        return lines[(index+1)..].take_while{|l|!l.strip.empty?&&!l.start_with?('#','<a ')}.join
      end
    end
    # 一級標題只代表引言；獨立段落錨點只代表該段。
    limit=level==1 ? 2 : level
    tail=lines[(index+1)..].take_while{|l|!l.start_with?('<a ') && (!(h=l.match(/^(\#{1,6}) /)) || h[1].size>limit)}
    ([lines[index]]+tail).join
  end
  def self.common_links(text,path)
    text.scan(/\]\(([^)]+)\)/).flatten.map do |u|
      next if u.match?(/\A(?:https?:|mailto:|#)/)
      p,a=u.split('#',2);full=Pathname.new(File.join(File.dirname(path),p)).cleanpath.to_s
      [full,a].compact.join('#') if full.start_with?('rules/')&&!full.include?('/stacks/')
    end.compact
  end
  def self.decisions
    text=File.read('docs/pending-decisions.md');third=text.split(/^## 三、/,2).last.split(/^## 四、/,2).first
    fourth=text.split(/^## 四、/,2).last.split(/^## 五、/,2).first
    result={}
    third.lines.each{|l|c=l.split(' | ');id=l[/^\| \[([A-Z]{2}-\d{2}) /,1];result[id]=c[2] if id}
    fourth.lines.each{|l|id=l[/^\| \[([A-Z]{2}-\d{2}) /,1];result[id]='保留條文／'+l.split(' | ')[3].to_s.split('：')[0] if id}
    result
  end
  # 樣板既有的呈現改寫，僅限完整來源匹配；新的工作者無法新增豁免。
  SAMPLE_WORDING = {
    1 => {'與'=>'、'},
    4 => {'另依錯誤處理規範'=>'依[錯誤處理](../../../coding/error-handling.md)'},
    12 => {'須使用'=>'依[空值語意](../../../coding/nullability.md#空值語意)使用'},
    21 => {'執行'=>'確認契約'},
    23 => {'執行'=>'評估相容性與使用端影響'},
    25 => {'、[型別安全](../../../coding/type-safety.md)執行'=>'辦理。型別要求依[型別安全](../../../coding/type-safety.md)'},
    26 => {'保留本文件驗收表中的 `Optional`、非空標註及實際 API 路徑案例'=>'Optional、非空標註與實際 API 路徑均納入適用案例'},
    29 => {'執行'=>'落實對外契約'}
  }.freeze
  def self.normal(text)

    # 連結名稱是呈現文字，承接比較保留 URI；標點不作義務斷言。
    text.gsub(/\[[^\]]+\]\(([^)]+)\)/,'\1').gsub(/[\s\p{P}\p{S}]/,'')
  end
  def self.residual(source,dest)
    # LCS 留下原句中無法依順序在目的句找到的字；輸出連續片段供複核。
    a=source.chars;b=dest.chars;n=a.size;m=b.size;d=Array.new(n+1){Array.new(m+1,0)}
    (n-1).downto(0){|i|(m-1).downto(0){|j|d[i][j]=a[i]==b[j] ? d[i+1][j+1]+1 : [d[i+1][j],d[i][j+1]].max}}
    i=0;j=0;parts=[];part=''
    while i<n
      if j<m && a[i]==b[j];parts<<part unless part.empty?;part='';i+=1;j+=1
      elsif j<m && d[i][j+1]>d[i+1][j];j+=1
      else;part+=a[i];i+=1;end
    end
    parts<<part unless part.empty?;parts
  end
  def self.policy(r,base,prefix,excerpt,check_uri)
    path=r['path'];current=File.read(path);manual=[];decision=decisions
    fourth=File.read('docs/pending-decisions.md').split(/^## 四、/,2).last.split(/^## 五、/,2).first
    retained=fourth.lines.select{|l|l.match?(/\| (是|可能)：/)}.map{|l|l[/[A-Z]{2}-\d{2}/]}-['CA-06']+%w[BM-04 ND-02]
    check(retained.sort==RETAIN.sort,'整條保留清單與核准判斷不符')
    r['rules'].each do |e|
      id=e['id'];kind=e['kind'];ss=r['sentences'].select{|s|s['history_id']==id}
      check(kind!='整份併入他檔'||r['status']=='merged','整份併入種類只允許 merged')
      check(kind=='整條保留',"必須整條保留 #{id}") if RETAIN.include?(id)
      if kind=='轉為驗收入口'
        check(decision[id]=='驗收入口' && ss.all?{|s|s['targets'].all?{|t|excerpt.call(t['uri']).include?(t['text'].to_s) && (t['uri'].include?('#acceptance-')||t['uri'].end_with?('#驗收要求'))}},'轉為驗收入口種類不符')
      end
      expected=case decision[id]
      when '重述';'整條移除'
      when '混合','待確認';'拆分'
      when '增量';'保留增量'
      when '驗收入口';'轉為驗收入口'
      when '待補證';'整條保留'
      else;ss.any?{|s|!s.fetch('removed_assertions',[]).empty?} ? '拆分' : '保留增量'
      end
      expected='整條保留' if RETAIN.include?(id)
      expected='拆分' if %w[CA-06 CO-08].include?(id)
      allowed=[expected,'整條保留'];allowed<<'拆分' if expected=='整條移除'
      check(allowed.include?(kind),"去向種類比判斷寬鬆 #{id}: #{decision[id]} -> #{kind}")
      local=e['targets'].select{|u|u.start_with?(path+'#')&&!u.include?('#acceptance-')&&!u.end_with?('#驗收要求')}
      local.each do |uri|
        check(uri.split('#',2).last.match?(/\Ajava-[a-z]+(?:-[a-z]+)*\z/),'Java 錨點須為英文語意名稱')
        section=excerpt.call(uri);title=BodyRestructuring.rules(base).find{|n,_,_|n==id.split('-').last.to_i}[1]
        check(section.lines.first=="### #{title}\n","條文小標題不符基準 #{id}")
        check(section.lines.count{|l|l.start_with?('#','<a ')}==1,"條文小節含額外標題或錨點 #{id}")
      end
      manual<<{path:path,type:'去向種類',history_id:id,decision:decision[id],expected:expected,actual:kind,conservative:kind!=expected,targets:e['targets'],reason:e['reason']}
      reasons=ss.reject{|s|s['action']=='保留'}.map{|s|s['reason'].gsub(/\s/,'')}
      check(reasons.uniq==reasons,"同條改寫／移除理由重複 #{id}")
    end
    if r['rules'].any?{|e|e['id']=='BM-04'}
      check(r['imports'].any?{|i|APPROVED_IMPORTS.first.all?{|k,v|i[k]==v}},'BM-04 缺少完整核准移入句')
    end
    r['sentences'].each_with_index do |s,index|
      next unless s['action']=='改寫'
      source=s['source'].dup;s['removed_assertions'].each{|a|source=source.sub(a['text'],'')}
      if path==JN && SAMPLE_WORDING[index]
        SAMPLE_WORDING[index].each{|before,after|source=source.sub(before,after)}
      end
      # 按子句分別比對，允許目的句的順序調整，不能消失任何子句字元。
      destination=normal(s['targets'].map{|t|t['text']}.join)
      remaining=source.split(/[；。]/).flat_map{|part|residual(normal(part),destination)}
      check(remaining.empty?,"未申報的刪除片段 #{s['history_id']}: #{remaining.to_json}")
      manual<<{path:path,type:'刪除完整性',history_id:s['history_id'],source:s['source'],unreported_fragments:remaining}
    end
    expected_headings=BodyRestructuring.body(base).lines.select{|l|l.start_with?('#')}
    r['rules'].each do |e|
      next unless e['targets'].any?{|u|u.start_with?(path+'#java-')}
      title=BodyRestructuring.rules(base).find{|n,_,_|n==e['id'].split('-').last.to_i}[1]
      expected_headings<<"### #{title}\n"
    end
    expected_headings<<"## 補充要求\n" if current.include?('<a id="java-closing-requirements">')
    actual_headings=BodyRestructuring.body(current).lines.select{|l|l.start_with?('#')}
    check(actual_headings.sort==expected_headings.sort,'正文標題新增、遺漏或改名')
    valid_anchors=r['rules'].flat_map{|e|e['targets']}.select{|u|u.start_with?(path+'#')}.map{|u|u.split('#',2).last}+['java-closing-requirements']
    BodyRestructuring.body(current).lines.select{|l|l.start_with?('<a ')}.each do |line|
      check(line.match?(/\A<a id="[^"]+"><\/a>\n\z/)&&valid_anchors.include?(line[/id="([^"]+)"/,1]),'正文錨點行含未核准內容')
    end
    base_links=common_links(base,path).uniq
    now_links=common_links(current,path).uniq
    exceptions=r.fetch('link_exceptions',[])
    exceptions.each{|e|check(base_links.include?(e['uri'])&&e.fetch('reason','').gsub(/\s/,'').size>=20,'共通連結例外無效')}
    check((base_links-now_links-exceptions.map{|e|e['uri']}).empty?,"基準共通連結遺漏 #{(base_links-now_links).join(', ')}")
    r.fetch('group_routes',[]).each do |g|
      heading=g.fetch('heading');section=BodyRestructuring.body(base).split("## #{heading}\n",2).last.to_s.split(/^## /,2).first
      ids=BodyRestructuring.rules(section).map{|n,_,_|format('%s-%02d',prefix,n)}
      entries=r['rules'].select{|e|ids.include?(e['id'])}
      check(!ids.empty?&&entries.all?{|e|e['kind']=='整條移除'},'指路分組並非全部移除')
      uris=entries.flat_map{|e|e['targets']}.uniq.sort
      check(g['targets'].sort==uris,'指路文字來源不符已移除條文')
      links=uris.map{|u|p,a=u.split('#',2);"[#{a}](#{Pathname.new(p).relative_path_from(Pathname.new(File.dirname(path)))}##{a})"}
      check(g['text']=="本組要求依#{links.join('、')}辦理。",'指路文字不符固定格式')
      check(excerpt.call(path+'#'+slug(heading)).include?(g['text']),'指路文字未放在原分組')
    end
    r.fetch('link_retention',[]).each do |e|
      check(e['targets'].all?{|u|base_links.include?(u)},'保留連結不是基準共通連結')
      links=e['targets'].map{|u|p,a=u.split('#',2);rel=Pathname.new(p).relative_path_from(Pathname.new(File.dirname(path))).to_s;"[#{a||File.basename(p,'.md')}](#{rel}#{a ? '#'+a : ''})"}
      check(e['text']=="本文件另依#{links.join('、')}辦理。" && excerpt.call(path+'#'+slug(current.lines.first.sub(/^# /,''))).include?(e['text']),'引言保留連結格式／位置不符')
    end
    # 所有分組保留；非條文尾段用獨立固定小節，不借用最後條文。
    BodyRestructuring.body(base).split(/^## /).drop(1).each do |group|
      ids=BodyRestructuring.rules(group).map{|n,_,_|format('%s-%02d',prefix,n)}
      next if ids.empty?
      if r['rules'].select{|e|ids.include?(e['id'])}.all?{|e|e['kind']=='整條移除'}
        check(r.fetch('group_routes',[]).any?{|g|g['heading']==group.lines.first.strip},'清空分組缺少指路文字')
      end
    end
    base_groups=BodyRestructuring.body(base).scan(/^## (.+)$/).flatten
    check(base_groups.all?{|h|current.include?("## #{h}\n")},'基準分組標題遺漏')
    r['sentences'].select{|s|!s['history_id']}.each do |s|
      next if BodyRestructuring.body(base).split(/^## /,2).first.include?(s['source'])
      check(s['targets'].all?{|t|t['uri']==path+'#java-closing-requirements'},'分組尾段必須指向獨立結尾小節')
    end
    if current.include?('<a id="java-closing-requirements">')
      check(excerpt.call(path+'#java-closing-requirements').lines.first=="## 補充要求\n",'結尾小節標題不符')
    end
    current.split('## 驗收要求',2).last.lines.select{|line|line.start_with?('|')&&line.include?('<a id=')}.each do |line|
      first=line.split(' | ',3).first.sub(/^\| /,'').gsub(/<a id="[^"]+"><\/a>/,'')
      parts=first.split('、')
      check(parts.all? do |part|
        next true if part=='覆蓋要求（原驗收入口）'
        m=part.match(/\A\[([^\]]+)\]\(([^)]+)\)\z/);next false unless m
        target=m[2];next r['rules'].any?{|rule|rule['targets'].include?(path+target)} if target.start_with?('#java-')
        common_links(part,path).any?
      end,'驗收第一欄不符固定格式')
    end
    %w[imports group_routes link_retention link_exceptions acceptance_changes acceptance_text_changes acceptance_additions].each do |key|
      r.fetch(key,[]).each{|value|manual<<{path:path,type:key,record:value}}
    end
    manual
  end
end
