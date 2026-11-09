# frozen_string_literal: true
# 階段 C 僅允許固定起點的連結及版面轉換；不開放正文改寫。
require_relative 'body-restructuring-lib'
require 'tmpdir'
require 'fileutils'
require_relative 'final-acceptance'
module BodyPresentation
  START='3f68be483882d8dbfb6611bd58c40ec7446414af'.freeze
  CONFIG='docs/body-presentation.json'.freeze
  ALIASES='docs/common-anchor-aliases.json'.freeze
  B=BodyRestructuring
  def self.old(path); (@old ||= {})[path] ||= B.original(path,START); end
  def self.check(ok,message);raise message unless ok;end
  def self.aliases
    return @aliases if @aliases
    section=old('docs/pending-decisions.md').split(/^## 五、/,2).last.split(/^## 六、/,2).first
    @aliases=section.scan(/^\| \[[^\]]+\]\(\.\.\/(rules\/[^)#]+)#([^)]*)\) \| `([^`]+)` \|/).map{|p,a,n|{'path'=>p,'old'=>a,'new'=>n}}
  end
  def self.rename(text,path,reverse=false)
    text.gsub(/\]\(([^)]+)\)/) do |match|
      u=$1;f,a=u.split('#',2);next match unless a
      full=f.empty? ? path : Pathname.new(File.join(File.dirname(path),f)).cleanpath.to_s
      entry=aliases.find{|e|e['path']==full&&e[reverse ? 'new' : 'old']==a}
      entry ? "](#{f}##{entry[reverse ? 'old' : 'new']})" : match
    end
  end
  def self.canonical(value,path)
    case value
    when Array;value.map{|v|canonical(v,path)}
    when Hash;context=value['path']||path;value.map{|k,v|[k,canonical(v,k=='source_text' && value['source_uri'] ? value['source_uri'].split('#').first : context)]}.to_h
    when String
      text=rename(value,path)
      aliases.each{|e|text=text.gsub(/#{Regexp.escape(e['path']+'#'+e['old'])}(?![\w-])/,e['path']+'#'+e['new'])}
      text
    else;value
    end
  end
  def self.common(path)
    text=rename(old(path),path)
    aliases.select{|e|e['path']==path}.each do |e|
      check(!text.include?(%(<a id="#{e['new']}">)),"語意錨點碰撞 #{path}##{e['new']}")
      oldanchor=%(<a id="#{e['old']}"></a>)
      check(text.include?(oldanchor),"舊錨點不存在 #{path}##{e['old']}")
      text=text.sub(oldanchor,%(<a id="#{e['new']}"></a>\n#{oldanchor}))
    end
    text
  end
  def self.title(uri)
    path,a=uri.split('#',2);text=old(path)
    a=aliases.find{|e|e['path']==path&&e['new']==a}&.fetch('old')||a
    return text.lines.first.sub(/^# /,'').strip unless a
    lines=text.lines;index=lines.index{|l|l.include?(%(<a id="#{a}">))}
    if index
      following=lines[(index+1)..].find{|l|!l.strip.empty?&&!l.start_with?('<a ')}
      return following.sub(/^#+ /,'').strip if following&.start_with?('#')
      # 段落錨點沿用其所屬的最近標題。
      return lines[0..index].reverse.find{|l|l.start_with?('#')}.sub(/^#+ /,'').strip
    end
    heading=lines.find{|l|l.match?(/^#+ /)&&slug(l.sub(/^#+ /,''))==a}
    check(heading,"找不到承接標題 #{uri}");heading.sub(/^#+ /,'').strip
  end
  def self.slug(s);s.strip.downcase.gsub(/[\p{P}\p{S}&&[^_-]]/,'').gsub(/\s/,'-');end
  def self.links(uris,path)
    uris.sort.map{|u|p,a=u.split('#',2);relative=Pathname.new(p).relative_path_from(Pathname.new(File.dirname(path)));"[#{title(u)}](#{relative}#{a ? '#'+a : ''})"}.join('、')
  end
  def self.groups(base)
    B.body(base).split(/^## /).drop(1).map{|s|[s.lines.first.strip,s.lines.drop(1)]}
  end
  def self.tails(path)
    gs=groups(B.original(path));gs[0...-1].map do |heading,lines|
      last=lines.rindex{|l|l.match?(/^\d+\. \*\*/)};next unless last
      tail=lines[(last+1)..].join.strip;next if tail.empty?
      {'heading'=>heading,'anchor'=>'java-group-notes-'+slug_ascii(heading,path),'text'=>tail}
    end.compact
  end
  def self.slug_ascii(heading,path)
    # 分組原有第一條的現行語意錨點，避免數字及中文錨點。
    r=JSON.parse(old("docs/body-restructuring/java/#{File.basename(path,'.md')}.json"))
    group=groups(B.original(path)).find{|h,_|h==heading};n=B.rules(group[1].join).first[0]
    rule=r['rules'].find{|e|e['id'].split('-').last.to_i==n};u=rule['targets'].find{|u|u.start_with?(path+'#java-')}
    check(u,"分組尾段無可用語意名稱 #{path}: #{heading}");u.split('#java-').last
  end
  def self.java(path,layout)
    jp="docs/body-restructuring/java/#{File.basename(path,'.md')}.json"
    r=canonical(JSON.parse(old(jp)),path);text=rename(old(path),path)
    if layout
      (r.fetch('group_routes',[])+r.fetch('link_retention',[])).each{|g|text=text.sub(g['text']+"\n\n",'')}
      r['group_routes']=[];r['link_retention']=[];r['group_endings']=[]
      groups(B.original(path)).each do |heading,lines|
        numbers=B.rules(lines.join).map(&:first)
        removed=r['rules'].select{|e|numbers.include?(e['id'].split('-').last.to_i)&&e['kind']=='整條移除'}
        next if removed.empty?
        uris=removed.flat_map{|e|e['targets']}.uniq.sort
        route={'heading'=>heading,'targets'=>uris,'text'=>"本組下列要求由共通規範承接：#{links(uris,path)}。"}
        r['group_routes']<<route;text=text.sub("## #{heading}\n\n","## #{heading}\n\n#{route['text']}\n\n")
      end
      # 引言保留原基準共通目標中，未出現在條文、分組指路或其他既有段落者。
      missing=common_links(rename(B.original(path),path),path).uniq-common_links(text,path).uniq
      unless missing.empty?
        item={'targets'=>missing.sort,'text'=>"本文件另依#{links(missing,path)}辦理。"}
        r['link_retention']=[item];text=text.sub(/^## /,item['text']+"\n\n## ")
      end
      tails(path).each do |tail|
        tail=canonical(tail,path);check(text.include?(tail['text']),"分組尾段原文不存在 #{path}")
        text=text.sub(tail['text']+"\n\n",'')
        heading=tail['heading'];start=text.index("## #{heading}\n");next_group=text.index(/^## /,start+4)
        # 下一個分組可能有固定 closing 錨點，須連錨點一起留在後面。
        insertion=next_group||text.index('## 驗收要求')
        if text[0...insertion].end_with?("<a id=\"java-closing-requirements\"></a>\n\n");insertion-=%(<a id="java-closing-requirements"></a>\n\n).size;end
        block="<a id=\"#{tail['anchor']}\"></a>\n\n### 本組補充說明\n\n#{tail['text']}\n\n"
        text.insert(insertion,block);r['group_endings']<<tail
        r['sentences'].each{|s|s['targets'].each{|t|t['uri']=path+'#'+tail['anchor'] if !s['history_id']&&tail['text'].include?(s['source'])}}
      end
      text=text.sub(%(<a id="java-closing-requirements"></a>\n\n## 補充要求\n\n## 驗收要求),'## 驗收要求')
      r['presentation_version']=1
    end
    # 原始基準按相同別名表正規化後再記錄差異；句子文字只變連結目的地。
    r['edits']=B.edits(rename(B.original(path),path),text).map{|e|e.merge('reason'=>'階段 C 僅正規化共通錨點、重生指路文字並移回分組尾段；條文與驗收句子逐字保留。')}
    [text,r]
  end
  def self.common_links(text,path)
    text.scan(/\]\(([^)]+)\)/).flatten.map do |u|
      f,a=u.split('#',2);next if u.start_with?('#','http','mailto:')
      p=Pathname.new(File.join(File.dirname(path),f)).cleanpath.to_s
      [p,a].compact.join('#') if p.start_with?('rules/')&&!p.include?('/stacks/')
    end.compact
  end
  def self.index
    p='rules/stacks/java/README.md';text=rename(old(p),p)
    text.lines.map do |l|
      topic=l[/\]\(common\/([^)]+)\.md\)/,1];next l unless topic
      r=JSON.parse(old("docs/body-restructuring/java/#{topic}.json"));base=B.original(r['path'])
      titles=r['rules'].select{|e|e['targets'].any?{|u|u.start_with?(r['path']+'#java-')}}.map{|e|B.rules(base).find{|n,_,_|n==e['id'].split('-').last.to_i}[1]}
      l.split(' | ').first+' | '+titles.join('、')+" |\n"
    end.join
  end
  def self.paths
    args=['git'];args<<"--git-dir=#{ENV['BODY_GIT_DIR']}" if ENV['BODY_GIT_DIR']
    out,status=Open3.capture2(*args,'ls-tree','-r','--name-only',START,'rules');check(status.success?,'無法取得階段 C 起點');out.lines.map(&:strip)
  end
  def self.render_base(config)
    key=JSON.generate(config);@render_cache ||= {}
    return Marshal.load(@render_cache[key]) if @render_cache[key]
    files={};records={}
    paths.each do |p|
      if p.start_with?('rules/stacks/java/common/')
        files[p],r=java(p,config['layout']);records["docs/body-restructuring/java/#{File.basename(p,'.md')}.json"]=r
      elsif p=='rules/stacks/java/README.md'&&config['index'];files[p]=index
      else;files[p]=common(p)
      end
    end
    @render_cache[key]=Marshal.dump([files,records])
    [files,records]
  end
  def self.render(config)
    files,records=render_base(config)
    FinalAcceptance.active? ? FinalAcceptance.render(files,records) : [files,records]
  end
  def self.validate(config)
    check(config=={'start'=>START,'aliases'=>true,'layout'=>config['layout'],'index'=>config['index']}&&[true,false].include?(config['layout'])&&[true,false].include?(config['index']),'階段 C 設定或起點不符')
    check(JSON.parse(File.read(ALIASES))==aliases,'別名清冊與核准第五節不符')
    expected,records=render(config)
    java_records=Dir.glob('docs/body-restructuring/java/**/*',File::FNM_DOTMATCH).select{|p|File.file?(p)}
    check(java_records.sort==records.keys.sort,'階段 C Java 紀錄檔案清冊不符')
    common_records=Dir.glob('docs/body-restructuring/common/**/*',File::FNM_DOTMATCH).select{|p|File.file?(p)}
    check(common_records.sort==%w[ca-06 co-08 existing-sources].map{|n|"docs/body-restructuring/common/#{n}.json"}.sort,'階段 C 共通紀錄檔案清冊不符')
    actual=Dir.glob('rules/**/*',File::FNM_DOTMATCH).select{|p|File.file?(p)}
    check(actual.sort==expected.keys.sort,'階段 C rules 檔案清冊不符')
    expected.each do |p,text|
      if p.start_with?('rules/stacks/java/common/')&&config['layout']
        r=records.fetch("docs/body-restructuring/java/#{File.basename(p,'.md')}.json")
        (r['group_routes']+r['link_retention']).each{|g|check(File.read(p).include?(g['text']),"指路句不符 #{p}；期待值：#{g['text']}")}
      end
      check(File.binread(p)==text.b,"階段 C 非核准連結／版面改動 #{p}")
    end
    records.each do |p,r|
      check(JSON.parse(File.read(p))==r,"階段 C 去向／版面紀錄不符 #{p}；期待值：#{JSON.generate(r)}")
    end
    # 每個別名同一位置相鄰，精確全文比對也禁止只留下空別名。
    aliases.each{|e|check(File.read(e['path']).include?(%(<a id="#{e['new']}"></a>\n<a id="#{e['old']}"></a>)),"別名位置不符 #{e['old']}")}
    section=File.read('docs/pending-decisions.md').split(/^## 五、/,2).last.split(/^## 六、/,2).first
    listed=section.scan(/^\| \[([^\]]+)\]/).flatten
    check(listed.sort==aliases.map{|e|e['path'].delete_prefix('rules/')+'#'+e['old']}.sort,'第五節別名清冊不完整')
    pairs=section.scan(/^\| \[([^\]]+)\]\(([^)]+)\) \| `([^`]+)` \|/)
    expected_pairs=aliases.map{|e|[e['path'].delete_prefix('rules/')+'#'+e['old'],'../'+e['path']+'#'+e['new'],e['new']]}
    check(pairs.map{|a,u,n|[a,n]}.sort==expected_pairs.map{|a,u,n|[a,n]}.sort,'第五節實際名稱不符')
    %w[三 四 六].each do |part|
      extract=lambda{|t|t.split(/^## #{part}、/,2).last.to_s.split(/^## /,2).first.scan(/^\| \[([A-Z]{2}-\d{2}) 第/).flatten.sort}
      check(extract.call(File.read('docs/pending-decisions.md'))==extract.call(old('docs/pending-decisions.md')),'待決清冊 ID 不符')
    end
    %w[ca-06 co-08 existing-sources].each do |name|
      p="docs/body-restructuring/common/#{name}.json"
      expected_common=FinalAcceptance.active? ? FinalAcceptance.common_record(p,old(p)) : old(p)
      check(File.read(p)==expected_common,'前階段共通追溯紀錄改動')
    end
    out,status=Open3.capture2e('ruby',File.expand_path('verify-body-acceptance.rb',__dir__))
    check(status.success?,"現行驗收追溯失敗：#{out}")
    out,status=Open3.capture2e('ruby',File.expand_path('verify-body-sentences.rb',__dir__))
    check(status.success?,"現行句子集合不符：#{out}")
    verify_links

  end
  def self.visible(text)
    fence=false;text.lines.map{|l|if l.match?(/^\s*(`{3,}|~{3,})/);fence=!fence;"\n";else;fence ? "\n" : l;end}.join
  end
  def self.verify_links
    paths=(Dir.glob('{rules,docs}/**/*.md',File::FNM_DOTMATCH)+['README.md']).select{|p|File.file?(p)};ids={};count=0
    paths.each do |p|
      t=visible(File.read(p));counts=Hash.new(0)
      ids[p]=t.scan(/<a id="([^"]+)"/).flatten+t.scan(/^#+ (.+)$/).flatten.map{|h|a=slug(h);n=counts[a];counts[a]+=1;n==0 ? a : "#{a}-#{n}"}
      check(ids[p].uniq==ids[p],"錨點重複 #{p}")
    end
    paths.each do |p|
      visible(File.read(p)).scan(/\]\(([^)\s]+)\)/).flatten.each do |u|
        next if u.start_with?('http:','https:','mailto:');f,a=u.split('#',2);target=f.empty? ? p : Pathname.new(File.join(File.dirname(p),f)).cleanpath.to_s
        check(File.file?(target),"連結檔案不存在 #{p}: #{u}");check(ids.fetch(target,[]).include?(a),"連結錨點不存在 #{p}: #{u}") if a&&ids.key?(target)
        check(!aliases.any?{|e|e['path']==target&&e['old']==a},"rules 仍引用舊錨點 #{p}: #{u}") if p.start_with?('rules/')
        count+=1
      end
    end
    count
  end
  def self.prepare_legacy(dir)
    check(File.realpath(dir)!=File.realpath(File.expand_path('..',__dir__)),'不得覆寫真實工作區')
    %w[rules docs].each{|p|FileUtils.rm_rf(File.join(dir,p))}
    args=['git'];args<<"--git-dir=#{ENV['BODY_GIT_DIR']}" if ENV['BODY_GIT_DIR']
    data,status=Open3.capture2(*args,'archive',START,'rules','docs',binmode:true);check(status.success?,'階段 B 快照失敗')
    _,err,status=Open3.capture3('tar','-xf','-','-C',dir,stdin_data:data,binmode:true);check(status.success?,err)
  end
  def self.run
    config=JSON.parse(File.read(CONFIG));links=validate(config)
    root=Dir.pwd;git=ENV['BODY_GIT_DIR']||File.expand_path(Open3.capture2('git','rev-parse','--git-common-dir').first.strip,root)
    result=nil
    Dir.mktmpdir('body-presentation-') do |dir|
      FileUtils.cp_r(File.join(root,'scripts'),dir)
      original_git=ENV['BODY_GIT_DIR'];ENV['BODY_GIT_DIR']=git;prepare_legacy(dir);ENV['BODY_GIT_DIR']=original_git
      out,status=Open3.capture2e({'BODY_ROOT'=>dir,'BODY_GIT_DIR'=>git},'ruby',File.join(dir,'scripts/verify-body-restructuring.rb'))
      check(status.success?,"階段 B 語意與驗收保證失敗：#{out}");result=JSON.parse(out)
    end
    result=canonical(result,'docs/body-restructuring-verification-results.md')
    result['manual_review_sentences'].reject!{|e|%w[group_routes link_retention].include?(e['type'])}
    render(config).last.each_value do |r|
      %w[group_routes link_retention group_endings].each{|k|r.fetch(k,[]).each{|e|result['manual_review_sentences']<<{'path'=>r['path'],'type'=>k,'record'=>e}}}
    end
    if FinalAcceptance.active?
      FinalAcceptance.ops.each{|o|result['manual_review_sentences']<<{'type'=>'final_acceptance_change','record'=>o}}
      result['final_acceptance']={'start'=>FinalAcceptance::START,'steps'=>FinalAcceptance.steps.map{|s|s['id']}}
    end
    result['manual_review_count']=result['manual_review_sentences'].size
    result['legacy_snapshot_local_links']=result.delete('local_links')
    result['current_local_links']=links
    result['presentation']={'start'=>START,'aliases'=>aliases.size,'layout'=>config['layout'],'index'=>config['index'],'semantic_snapshot'=>START,'guarantee'=>'現行全文與紀錄逐字等於起點的核准連結及版面轉換；逐句語意／驗收仍由起點檢查承接'}
    puts JSON.pretty_generate(result)
  end
end
