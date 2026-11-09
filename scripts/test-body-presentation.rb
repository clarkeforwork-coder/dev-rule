# frozen_string_literal: true
require_relative 'body-presentation'
ROOT=File.expand_path('..',__dir__)
ENV['BODY_GIT_DIR']=File.expand_path(Open3.capture2('git','rev-parse','--git-common-dir',chdir:ROOT).first.strip,ROOT)
P=BodyPresentation
CONFIG={'start'=>P::START,'aliases'=>true,'layout'=>true,'index'=>true}.freeze
cases=[
 ['全部合法轉換',nil,lambda{}],
 ['起點不得後移','設定或起點不符',lambda{r=JSON.parse(File.read(P::CONFIG));r['start']='HEAD';File.write(P::CONFIG,JSON.generate(r))}],
 ['別名漏列','別名清冊',lambda{r=JSON.parse(File.read(P::ALIASES));r.pop;File.write(P::ALIASES,JSON.generate(r))}],
 ['舊錨點不可刪','非核准連結／版面',lambda{p=P.aliases.first['path'];File.write(p,File.read(p).sub('<a id="bm-03"></a>',''))}],
 ['共通正文不可改','非核准連結／版面',lambda{p=P.aliases.first['path'];File.open(p,'a'){|f|f.puts '新增要求。'}}],
 ['舊連結不能回流','期待值',lambda{p='rules/stacks/java/common/boundary-mapping.md';File.write(p,File.read(p).sub('#mapping-responsibility','#bm-03'))}],
 ['非空分組缺指路','期待值',lambda{p='rules/stacks/java/common/classes-and-construction.md';File.write(p,File.read(p).lines.reject{|l|l.start_with?('本組下列')}.join)}],
 ['指路標籤不得使用代碼','期待值',lambda{p='rules/stacks/java/common/classes-and-construction.md';t=File.read(p);line=t.lines.find{|l|l.start_with?('本組下列')};File.write(p,t.sub(line,line.sub(/\[[^\]]+\]/,'[cl-02]')))}],
 ['指路不得夾帶義務','非核准連結／版面',lambda{p='rules/stacks/java/common/classes-and-construction.md';File.write(p,File.read(p).sub(/(本組下列[^\n]+)/,'\1不得略過。'))}],
 ['指路紀錄來源不符','去向／版面紀錄',lambda{p='docs/body-restructuring/java/classes-and-construction.json';r=JSON.parse(File.read(p));r['group_routes'][0]['targets'].pop;File.write(p,JSON.generate(r))}],
 ['分組尾段不可改字','非核准連結／版面',lambda{p='rules/stacks/java/common/version-policy.md';File.write(p,File.read(p).sub('例如，建置 JDK','例如，建置工具'))}],
 ['補充標題不可任意改名','非核准連結／版面',lambda{p='rules/stacks/java/common/version-policy.md';File.write(p,File.read(p).sub('### 本組補充說明','### 補充政策'))}],
 ['Java 原句不可刪','非核准連結／版面',lambda{p='rules/stacks/java/common/concurrency-and-async.md';File.write(p,File.read(p).sub('虛擬執行緒也須遵守下游容量',''))}],
 ['驗收不能改寫','非核准連結／版面',lambda{p='rules/stacks/java/common/concurrency-and-async.md';File.write(p,File.read(p).sub('沿 Java `Future`','僅沿 Java `Future`'))}],
 ['第五節不能少列','第五節別名清冊',lambda{p='docs/pending-decisions.md';File.write(p,File.read(p).lines.reject{|l|l.start_with?('| [architecture/data-mapping.md#bm-03]')}.join)}],
 ['前階段追溯不可改','前階段共通追溯',lambda{p='docs/body-restructuring/common/ca-06.json';File.write(p,File.read(p)+' ')}],
 ['新句即使重複也拒絕','非核准連結／版面',lambda{p='rules/stacks/java/common/concurrency-and-async.md';File.open(p,'a'){|f|f.puts File.read(p).lines[4]}}]
]
results=[]
cases.each do |name,diagnostic,mutate|
 Dir.mktmpdir('body-presentation-test-') do |dir|
  %w[rules docs scripts].each{|p|FileUtils.cp_r(File.join(ROOT,p),dir)}
  Dir.chdir(dir) do
   P.prepare_legacy(dir)
   File.write(P::CONFIG,JSON.pretty_generate(CONFIG)+"\n");File.write(P::ALIASES,JSON.pretty_generate(P.aliases)+"\n")
   files,records=P.render(CONFIG);files.each{|p,t|File.write(p,t)};records.each{|p,r|File.write(p,JSON.pretty_generate(r)+"\n")}
   mutate.call
   begin
    P.validate(JSON.parse(File.read(P::CONFIG)))
    results<<{test:name,matched:diagnostic.nil?,diagnostic:'現行別名、版面、句子與追溯通過'}
   rescue => e
    results<<{test:name,matched:!diagnostic.nil?&&e.message.include?(diagnostic),diagnostic:e.message.lines.first.strip[0,250]}
   end
  end
 end
end
puts JSON.pretty_generate(results)
exit(results.all?{|r|r[:matched]} ? 0 : 1)
