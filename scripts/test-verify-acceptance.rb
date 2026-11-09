#!/usr/bin/env ruby
# frozen_string_literal: true
# 所有變異均在暫存複本，原分支與工作區不變。
require 'tmpdir'
require 'fileutils'
require 'open3'
require 'json'
# 階段 C 起明確在封存提交執行這組舊測試，不把封存測試當現行規範驗證。
if File.exist?(File.expand_path('../docs/body-presentation.json',__dir__))
  require_relative 'body-restructuring-lib'
  root=File.expand_path('..',__dir__)
  result=nil;passed=false
  Dir.mktmpdir('body-archived-acceptance-') do |dir|
    _,err,status=Open3.capture3('git','clone','--quiet','--shared',root,dir+'/repo');raise err unless status.success?
    _,err,status=Open3.capture3('git','checkout','--quiet','--detach',BodyRestructuring::BASELINE,chdir:dir+'/repo');raise err unless status.success?
    out,status=Open3.capture2e('ruby','scripts/test-verify-acceptance.rb',chdir:dir+'/repo')
    out=out.gsub(%r{(?:/private)?/var/folders/[^\s"]+/acceptance-negative-[^/\s"]+},'<驗收暫存複本>').gsub(%r{/tmp/acceptance-negative-[^/\s"]+},'<驗收暫存複本>')
    passed=status.success?;result={'archived_at'=>BodyRestructuring::BASELINE,'scope'=>'封存驗收階段；現行內容另由正文及版面檢查驗證','exit'=>status.exitstatus,'output'=>out}
  end
  puts JSON.pretty_generate(result);exit(passed ? 0 : 1)
end
ROOT=File.expand_path('..',__dir__)
GIT_DIR=File.expand_path(Open3.capture2('git','-C',ROOT,'rev-parse','--git-common-dir').first.strip,ROOT)
def change(path)
  source=File.read(path); result=yield(source)
  raise "測試未改到預期內容：#{path}" if result==source
  File.write(path,result)
end
def edit_policy
  path='docs/acceptance-check-policy.json'
  data=JSON.parse(File.read(path));yield(data);File.write(path,JSON.pretty_generate(data)+"\n")
end
def register_test_row(path,row)
  old=Open3.capture2('git',"--git-dir=#{GIT_DIR}",'show',"6a16349:#{path}").first.lines.map(&:chomp)
  start=old.index('## 驗收要求')
  pos=old.each_index.find{|i|i>start && old[i]=='| --- | --- |'}+2
  edit_policy do |data|
    edit=data['changes'].find{|e|e['path']==path && e['baseline_line']==pos}
    if edit
      edit['insert'].unshift(row.chomp)
    else
      data['changes'] << {'path'=>path,'baseline_line'=>pos,'remove'=>[],'insert'=>[row.chomp],'kind'=>'acceptance','reason'=>'僅供 T3 暫存複本明確登錄換句話說重複列，以隔離語意檢查的限制。'}
    end
  end
end
def registered_change(path,pos,remove,insert,kind='acceptance')
  baseline=Open3.capture2('git',"--git-dir=#{GIT_DIR}",'show',"6a1634959d922b2df5f1259cb176a731a5b5f488:#{path}").first.lines.map(&:chomp)
  change(path) do |text|
    lines=text.lines.map(&:chomp);at=lines.index(baseline[pos-1]);raise '找不到測試位置' unless at
    lines[at,remove.size]=insert;lines.join("\n")+"\n"
  end
  edit_policy{|d|d['changes']<<{'path'=>path,'baseline_line'=>pos,'remove'=>remove,'insert'=>insert,'kind'=>kind,'reason'=>'負向測試專用的充分長度理由；此內容只寫在暫存複本，不是核准的規範變更。'}}
end
java='rules/stacks/java/common/types-and-generics.md'
quality='rules/quality/rule-verification.md'
cases={
 'T1'=>['失效錨點',false,lambda{change(java){|s|s.sub('#acceptance-data-shape','#acceptance-missing')}}],
 'T2'=>['逐字重複',false,lambda{
   row=File.readlines('rules/coding/type-safety.md').find{|l|l.include?('id="acceptance-data-shape"')}.sub('id="acceptance-data-shape"','id="acceptance-java-negative"')
   row=row.gsub('](#','](../../../coding/type-safety.md#')
   change(java){|s|s.sub("| --- | --- |\n","| --- | --- |\n"+row)}
 }],
 'T3'=>['換句話說重複：僅人工可判斷',true,lambda{
   row=File.readlines('rules/coding/type-safety.md').find{|l|l.include?('id="acceptance-data-shape"')}.sub('id="acceptance-data-shape"','id="acceptance-java-negative"').sub('使用明確物件','採用明確物件')
   # 外部檔的規則連結在 Java 位置必須仍有效，否則測到的是壞連結。
   row=row.gsub('](#','](../../../coding/type-safety.md#')
   change(java){|s|s.sub("| --- | --- |\n","| --- | --- |\n"+row)}
   register_test_row(java,row)
 }],
 'T4'=>['追溯指錯現存列',false,lambda{change('docs/acceptance-cleanup-batch-5.md'){|s|s.sub('../rules/coding/numbers-dates-text.md#acceptance-time-source','../rules/coding/domain-modeling.md#acceptance-identity-lifecycle')}}],
 'T5'=>['刪除核心業務政策',false,lambda{change(quality){|s|s.lines.reject{|l|l.include?('核心業務規則必須能')}.join}}],
 'T6a'=>['刪除驗收尾段治理句',false,lambda{change('rules/stacks/java/common/null-and-optional.md'){|s|s.lines.reject{|l|l.include?('既有程式碼、工具限制與個別例外')}.join}}],
 'T6b'=>['掏空 Java 驗收列',false,lambda{change(java){|s|s.sub(/(\| <a id="acceptance-java-[^"]+"><\/a>[^|]+\| ).+ \|/,'\1略。 |')}}],
 'T7'=>['README 政策改寫',false,lambda{change('rules/README.md'){|s|s.sub('不得自行降低標準','得自行降低標準')}}],
 'T8'=>['刪除受保護章節文字',false,lambda{change(quality){|s|s.lines.reject{|l|l.include?('測試程式碼同樣遵守')}.join}}],
 'T9'=>['共通驗收列刪除後半斷言',false,lambda{change(quality){|s|s.sub('不隱藏項目失敗或未完成事項。','')}}],
 'T10'=>['重複錨點',false,lambda{change(java){|s|s+"\n<a id=\"acceptance-java-local-types\"></a>\n<a id=\"acceptance-java-local-types\"></a>\n"}}]
}
cases.merge!({
 'N1'=>['未登錄的共通新義務',false,lambda{change('rules/coding/type-safety.md'){|s|s.sub("| --- | --- |\n","| --- | --- |\n| <a id=\"acceptance-negative\"></a>新義務 | 所有語言的公開方法一律須以靜態分析工具證明參數型別完整，否則不得合併。 |\n")}}],
 'N1b'=>['未登錄且沒有錨點的 Java 放寬句',false,lambda{change(java){|s|s.sub("| --- | --- |\n","| --- | --- |\n| 放寬 | 上列 acceptance-java 各項可由團隊自行決定是否執行，不必留存證據。 |\n")}}],
 'N7'=>['目的列刪大半並以子字串登錄改寫',false,lambda{
  path='rules/stacks/java/common/classes-and-construction.md'
  row=File.readlines(path).find{|l|l.include?('id="acceptance-java-construction-safety"')}
  raise '找不到建構驗收列' unless row
  altered=row.sub(/ \| [^|]+ \|\s*$/, ' | 驗證建構路徑中的部分行為是否符合預期。 |' + "\n")
  change(path){|s|s.sub(row,altered)}
  edit_policy{|d|d['changes'].each{|e|e['insert'].map!{|l|l==row.chomp ? altered.chomp : l}}}
  change('docs/acceptance-rewritten-fragments.json') do |s|
   d=JSON.parse(s);d.select{|e|e['target'].include?('#acceptance-java-construction-safety')}.each{|e|e['replacement']='驗證';e['reason']='測試使用充分長度理由，確認不能只憑目的列中的短子字串取得放行。'};JSON.pretty_generate(d)
  end
 }],
 'N8'=>['刪政策並登錄過短理由 x',false,lambda{
  line=File.readlines(quality).find{|l|l.include?('核心業務規則必須能')};change(quality){|s|s.sub(line,'')}
  old=Open3.capture2('git',"--git-dir=#{GIT_DIR}",'show',"6a16349:#{quality}").first.lines.map(&:chomp)
  edit_policy{|d|d['changes']<<{'path'=>quality,'baseline_line'=>old.index(line.chomp)+1,'remove'=>[line.chomp],'insert'=>[],'kind'=>'editorial','reason'=>'x'}}
 }],
 'N8b'=>['驗收分類不得刪除政策段',false,lambda{
  line=File.readlines(quality).find{|l|l.include?('核心業務規則必須能')};change(quality){|s|s.sub(line,'')}
  old=Open3.capture2('git',"--git-dir=#{GIT_DIR}",'show',"6a16349:#{quality}").first.lines.map(&:chomp)
  edit_policy{|d|d['changes']<<{'path'=>quality,'baseline_line'=>old.index(line.chomp)+1,'remove'=>[line.chomp],'insert'=>[],'kind'=>'acceptance','reason'=>'測試使用充分長度理由，確認驗收分類不能用來刪除同節的規則政策句。'}}
 }],
 'N9'=>['移動基準並清空清單',false,lambda{edit_policy{|d|d['baseline']='fffd115';d['changes']=[]}}],
 'N18'=>['改寫理由只含空白',false,lambda{change('docs/acceptance-rewritten-fragments.json'){|s|d=JSON.parse(s);d.first['reason']=' ';JSON.pretty_generate(d)}}],
 'N19'=>['任意 kind 與空白理由',false,lambda{edit_policy{|d|d['changes'].first['kind']='arbitrary';d['changes'].first['reason']=' '}}],
 'N19b'=>['充分理由仍拒絕任意 kind',false,lambda{edit_policy{|d|d['changes'].first['kind']='arbitrary'}}],
 'N19c'=>['editorial 不得碰表格列',false,lambda{edit_policy{|d|d['changes'].find{|e|e['insert'].any?{|l|l.start_with?('|')}}['kind']='editorial'}}]
})
cases.merge!({
 'R3-reason19'=>['差異理由只有 19 個非空白字元',false,lambda{edit_policy{|d|d['changes'].first['reason']='甲'*19}}],
 'R3-reason-spaces'=>['改寫理由 19 字加大量空白',false,lambda{change('docs/acceptance-rewritten-fragments.json'){|s|d=JSON.parse(s);d.first['reason']='甲'*19+' '*100;JSON.pretty_generate(d)}}],
 'R3-body-rewrite'=>['非混排 Java 正文登錄為 acceptance',false,lambda{
  old=Open3.capture2('git',"--git-dir=#{GIT_DIR}",'show',"6a16349:#{java}").first.lines[8].chomp
  registered_change(java,9,[old],[old.sub('須','宜')])
 }],
 'R3-body-insert'=>['正文純插入登錄為 acceptance',false,lambda{registered_change(java,9,[],['所有檢查均可由實作者自行免除。'])}],
 'R3-self-heading'=>['增文自帶驗收標題不得取得資格',false,lambda{registered_change(java,9,[],['## 驗收要求','','所有公開方法都須使用新的跨語言框架。',''])}],
 'R3-self-subheading'=>['增文自帶小標題不得取得資格',false,lambda{registered_change(java,9,[],['### 契約驗收','','所有公開方法都須使用新的跨語言框架。',''])}],
 'R3-table-no-leading-pipe'=>['editorial 插入無前導直線的表格列',false,lambda{
  row="放寬 | 上述所有驗收均可無需留存證據而免除。\n"
  change(java){|s|s.sub("| --- | --- |\n","| --- | --- |\n"+row)}
  register_test_row(java,row)
  edit_policy{|d|d['changes'].find{|e|e['insert'].include?(row.chomp)}['kind']='editorial'}
 }],
 'R3-hidden-file'=>['隱藏規範檔須納入檔案清單',false,lambda{File.write('rules/.extra.md',"# 額外規範\n")}],
 'R3-new-file'=>['新增規範檔應明確回報清單差異',false,lambda{File.write('rules/coding/extra.md',"# 額外規範\n")}],
 'R3-crlf'=>['CRLF 不得被逐行 chomp 忽略',false,lambda{change(java){|s|s.gsub("\n","\r\n")}}],
 'R3-final-newline'=>['檔尾換行不可被忽略',false,lambda{change(java){|s|s.chomp}}],
 'R3-pending-ids'=>['待決評估不得少 NT-04',false,lambda{change('docs/pending-decisions.md'){|s|s.lines.reject{|l|l.include?('[NT-04 第')}.join}}],
 'R3-trace-rows'=>['追溯表不得少原片段',false,lambda{change('docs/acceptance-cleanup-batch-4.md'){|s|s.lines.reject{|l|l.start_with?('| VO-1、2-1 |')}.join}}],
 'R3-removed-scope'=>['移除無法使用的範圍模式',false,lambda{@test_args=['--batch','3','--check-scope']}],
 'R3-removed-trace-only'=>['移除名實不符的 trace-only',false,lambda{@test_args=['--batch','3','--trace-only']}],
 'R3-missing-baseline-file'=>['git show 失敗須明確報錯',false,lambda{@test_args=['--batch','1','--baseline','nonexistent-test-ref']}],
 'R3-ambiguous-ref'=>['短參照遮蔽不得移動完整基準',false,lambda{
  raise '無法建立隔離 git 複本' unless system('git','clone','--quiet','--shared','--no-checkout',ROOT,'isolated-git')
  raise '無法新增測試標籤' unless system('git','-C','isolated-git','tag','6a16349','HEAD')
  system('git','-C','isolated-git','config','core.warnAmbiguousRefs','false')
  @test_git_dir=File.expand_path('isolated-git/.git')
  edit_policy{|d|d['baseline']='6a16349';d['changes']=[]}
 }]
})
cases['R3-record-diff']=['紀錄器的提交範圍檢查須拒絕已提交空白錯誤',false,lambda{
  raise '無法建立隔離複本' unless system('git','clone','--quiet','--shared',ROOT,'isolated-git')
  File.write('isolated-git/negative-whitespace.txt',"trailing whitespace \n")
  raise '無法準備空白錯誤' unless system('git','-C','isolated-git','add','negative-whitespace.txt')
  raise '無法提交測試資料' unless system('git','-C','isolated-git','-c','user.name=Acceptance test','-c','user.email=acceptance@example.invalid','commit','--quiet','-m','negative whitespace fixture')
  line=File.readlines('scripts/record-acceptance-verification.rb').find{|l|l.start_with?("commands << ['git'")}
  raise '找不到紀錄器 git 命令' unless line
  args=line.scan(/'([^']+)'/).flatten
  @test_command=['git','-C',File.expand_path('isolated-git'),*args.drop(1)]
  @expected_exit=2
}]
results=[]
Dir.mktmpdir('acceptance-negative-') do |dir|
 FileUtils.cp_r(["#{ROOT}/rules","#{ROOT}/docs","#{ROOT}/scripts"],dir)
 FileUtils.cp("#{ROOT}/README.md",dir) if File.file?("#{ROOT}/README.md")
 env={'ACCEPTANCE_GIT_DIR'=>GIT_DIR}
 out,status=Open3.capture2e(env,'ruby',"#{dir}/scripts/verify-acceptance.rb")
 abort("乾淨暫存複本未通過：\n#{out}") unless status.success?
 cases.each do |id,(description,expected_pass,mutate)|
  @test_args=[];@test_git_dir=GIT_DIR;@test_command=nil;@expected_exit=expected_pass ? 0 : 1
  saved=Dir.glob("#{dir}/{rules,docs}/**/*",File::FNM_DOTMATCH).select{|p|File.file?(p)}.to_h{|p|[p,File.binread(p)]}
  Dir.chdir(dir){mutate.call}
  command=@test_command || ['ruby',"#{dir}/scripts/verify-acceptance.rb",*@test_args]
  out,status=Open3.capture2e(env.merge('ACCEPTANCE_GIT_DIR'=>@test_git_dir),*command)
  pattern = case id
            when 'R3-record-diff' then /trailing whitespace/
            when 'R3-reason19' then /Invalid approved edit/
            when 'R3-reason-spaces' then /Invalid rewritten fragment/
            when 'R3-body-rewrite', 'R3-body-insert', 'R3-self-heading', 'R3-self-subheading' then /Acceptance edit outside acceptance section/
            when 'R3-table-no-leading-pipe' then /Editorial edit touches table/
            when 'R3-hidden-file', 'R3-new-file' then /Rules file inventory changed: added=/
            when 'R3-crlf' then /Rule line endings changed/
            when 'R3-final-newline' then /Rule final newline changed/
            when 'R3-pending-ids' then /Pending decision ID inventory changed/
            when 'R3-trace-rows' then /Missing\/changed original fragments/
            when 'R3-removed-scope', 'R3-removed-trace-only' then /invalid option/
            when 'R3-missing-baseline-file' then /無法讀取基準檔/
            when 'R3-ambiguous-ref' then /固定正文基準/
            when 'T1' then /Missing fragment/
            when 'T2' then /Scoped duplicate acceptance/
            when 'T4' then /Trace fragment absent from destination NT-9-2/
            when 'N7', 'N18' then /Trace fragment absent/
            when 'N8', 'N19' then /Invalid approved edit/
            when 'N8b' then /Acceptance edit outside acceptance section/
            when 'N9' then /固定正文基準/
            when 'N19b' then /Invalid edit kind/
            when 'N19c' then /Editorial edit touches table/
            when 'T10' then /Duplicate\/colliding anchor/
            else /Protected rule text (changed|missing)/
            end
  diagnostic = out.lines.find { |line| line.match?(pattern) }
  matched = status.exitstatus == @expected_exit && (expected_pass || !diagnostic.nil?)
  results << {test:id,description:description,expected_exit:@expected_exit,actual_exit:status.exitstatus,matched_expectation:matched,diagnostic:status.success? ? '已在暫存清單登錄 T3；換句話說重複與理由內容仍為人工檢查項目' : (diagnostic || out.lines.first).to_s.strip}
  (Dir.glob("#{dir}/{rules,docs}/**/*",File::FNM_DOTMATCH).select{|p|File.file?(p)}-saved.keys).each{|p|File.delete(p)}
  saved.each{|p,body|File.binwrite(p,body)}
  FileUtils.rm_rf(File.join(dir,'isolated-git'))
 end
end
puts JSON.pretty_generate(results)
exit(results.all?{|r|r[:matched_expectation]} ? 0 : 1)
