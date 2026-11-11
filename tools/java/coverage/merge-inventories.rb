# frozen_string_literal: true
# 一次性匯入的可重現紀錄；來源目錄由參數指定，來源檔不修改。
require 'yaml'
require 'digest'
ROOT = File.expand_path('../../..', __dir__)
CODES = %w[TG LS NP CC NO VO SR BM CO ER EH ND CA RS VP].zip(%w[types-and-generics lambda-and-stream naming-packages-docs classes-and-construction null-and-optional value-objects states-and-results boundary-mapping collections-and-ownership exceptions-and-resources equality-hashing-ordering numbers-dates-text concurrency-and-async reflection-and-suppression version-policy]).to_h.freeze
abort '用法：ruby tools/java/coverage/merge-inventories.rb 來源目錄' unless ARGV.size == 1
sections = {}
CODES.each_value do |doc|
  File.read("#{ROOT}/rules/stacks/java/common/#{doc}.md").scan(/<a id="(java-[^"]+)"><\/a>\s*\n### ([^\n]+)/) { |a,t| sections[["#{doc}.md",a]] = t }
end
rows = []
audit = ["# 規則整併取捨紀錄", "", "來源盤點只讀；本階段不重新宣稱執行 Java 工具，實證依研究者的盤點及同名報告。", "", "## 來源指紋", ""]
changes = []
%w[claude-a codex-a claude-b codex-b].each do |who|
  path = File.join(ARGV[0], "inventory-inv-#{who}.yml")
  audit << "- `inv-#{who}`：#{YAML.load_file(path).size} 筆，SHA-256 `#{Digest::SHA256.file(path).hexdigest}`。"
  YAML.load_file(path).each_with_index do |r,i|
    next unless r['anchor'].to_s.match?(/\Ajava-[a-z-]+\z/)
    key = [r['file'],r['anchor']]
    abort "無對應小節 #{key}" unless sections.key?(key)
    check = r['rule'].sub(/\A#{Regexp.escape(r['tool'])}:/, '')
    note = r['note'].to_s.gsub(/\s+/, ' ').strip
    risk = r['false_positive_risk'].to_s
    note += "；誤報風險說明：#{risk.split(/[：]/,2)[1]}" if risk.include?('：')
    risk = risk.start_with?('high') ? 'high' : risk.start_with?('medium','low-medium') ? 'medium' : 'low'
    v = r['verified']
    status = if r['tool'] == 'none'
               'manual'
             elsif v['compliant_clean'] == false
               'candidate'
             elsif v['violation_caught'] == true && v['compliant_clean'] == true
               'verified'
             elsif v['compliant_clean'] == true && (v['violation_caught'] == false || v['sample'].to_s.include?('caught'))
               'partial'
             else
               'candidate'
             end
    # 失敗候選沒有獨立成功證據，不以「符合乾淨」推定部分實證。
    status = 'candidate' if who == 'codex-a' && i >= 49
    status = 'candidate' if who == 'codex-b' && [48,55].include?(i)
    status = 'candidate' if who == 'claude-a' && [54,78].include?(i)
    status = 'candidate' if who == 'claude-b' && i == 29
    # 已知漏報／補強反例，或盤點直接限定為審查候選。
    status = 'partial' if (who == 'claude-a' && [33,53,55,73].include?(i)) || (who == 'codex-a' && [45,47,48].include?(i))
    note += "；實證版本：#{v['versions_tested'].join('、')}" unless v['versions_tested'].empty?
    note += "；補充實證：#{v['sample']}" if v['sample']
    variants = [[r['tool'], check, status]]
    if who == 'claude-a' && [27,51,52].include?(i)
      prefix = check.include?('/') ? check[0..check.rindex('/')] : ''
      names = check.delete_prefix(prefix).split(',')
      proven = {27 => %w[InterfaceTypeParameterName],51 => %w[TypeName ConstantName MethodName],52 => %w[ClassNamingConventions FieldNamingConventions MethodNamingConventions]}[i]
      variants = names.map { |n| [r['tool'],prefix+n,proven.include?(n) ? 'verified' : 'candidate'] }
      note += '；原盤點合併多模組，未獨立證明命中的模組保守列 candidate'
      changes << "- `inv-#{who}` 第 #{i+1} 筆：拆分 #{names.join('、')}；只有可從原範例定位命中的模組列 verified。"
    elsif who == 'claude-a' && i == 58
      variants = %w[InternalPackageNotPublic SharedPackageNoBusinessDependency NestedStorageNotPublic].map { |n| ['archunit',"custom:#{n}",'verified'] }
      changes << '- ArchUnit 三個合成案例拆成 `custom:InternalPackageNotPublic`、`custom:SharedPackageNoBusinessDependency`、`custom:NestedStorageNotPublic`；沿用原實證，落地仍須按專案邊界設定。'
    elsif who == 'claude-a' && i == 59
      variants = [['jdeps','--check','candidate'],['jdeps','-jdkinternals','candidate'],['maven-enforcer','bannedDependencies','candidate']]
      changes << '- 套件邊界的 jdeps／Enforcer 複合筆拆成三筆 candidate；`--check` 僅列 11／17／21，舊拼法 `-jdkinternals` 僅列 8。'
    end
    variants.each do |tool,c,s|
      level = r['level'] == 'warn' ? 'warn' : 'error'
      # 工具預設等級及導入策略不取代條文強制詞。
      upgraded = %w[java-input-output-type-relation java-type-safety-warnings java-naming-form java-construction-safety java-explicit-dependencies java-order-and-duplicates java-bounded-accumulation java-durations-calendar-periods java-decimal-equivalence java-temporal-parsing-formatting java-group-notes-version-declarations java-group-notes-dependency-versions]
      level = 'error' if upgraded.include?(r['anchor'])
      if level != r['level']
        changes << "- `inv-#{who}` 第 #{i+1} 筆 `#{c}`：level `#{r['level'].inspect}` → `#{level}`；原文要求須／不得／不允許，工具提示門檻不改變條文等級。"
      end
      if tool == 'checkstyle'
        config = c[/\[.*\]|\(id=.*\)/]
        note2 = config ? "#{note}；設定：#{config}" : note
        c = c.sub(/\[.*\]|\(id=.*\)/,'')
      else
        note2 = note
      end
      versions = r['versions'].sort
      versions = [11,17,21] if who == 'claude-a' && i == 59 && c == '--check'
      versions = [8] if who == 'claude-a' && i == 59 && c == '-jdkinternals'
      row = {'rule'=>"rules/stacks/java/common/#{r['file']}##{r['anchor']}",'title'=>sections[key],'level'=>level,'tier'=>tool == 'none' ? 'manual' : r['tier'],'tool'=>tool,'check'=>tool == 'none' ? 'none' : c}
      row['xpath'] = r['custom_xpath'] if tool == 'pmd' && c.start_with?('custom:')
      row.merge!('versions'=>versions,'status'=>s,'false_positive_risk'=>risk,'note'=>note2.gsub(/[。]\s*/, '；').sub(/[；]+\z/,'')+'。','source'=>["inv-#{who}"])
      rows << row
    end
  end
end
# 來源以文字引用同名 XPath 時，複用原始字串，不改寫查詢。
raw_xpath = rows.find { |r| r['check'] == 'custom:RawGenericType' && r['xpath'] }['xpath']
rows.each { |r| r['xpath'] = raw_xpath if r['check'] == 'custom:RawGenericType' }
changes << '- RawGenericType 的菱形運算子映射原本只有文字引用；逐字複用同盤點 java-generic-type-information 的已實證 XPath。'
# 同小節、工具、規則合併；不同設定寫在 note 中（例如 IllegalCatch）。
rows = rows.group_by { |r| r.values_at('rule','tool','check') }.map do |key,group|
  best = group.max_by { |r| %w[manual candidate partial verified].index(r['status']) }
  if group.size > 1
    changes << "- 合併 `#{key.join(' / ')}` 的 #{group.size} 筆（#{group.flat_map { |r| r['source'] }.uniq.join('、')}）；保留設定／測試責任與全部 note。"
    best = best.merge('note'=>group.map { |r| r['note'].sub(/。\z/,'') }.uniq.join('；')+'。','source'=>group.flat_map { |r| r['source'] }.uniq,'versions'=>group.flat_map { |r| r['versions'] }.uniq.sort,'level'=>group.any? { |r| r['level']=='error' } ? 'error' : 'warn')
  end
  best
end
counts = Hash.new(0)
rows.sort_by! { |r| [CODES.values.index(File.basename(r['rule'].split('#')[0],'.md')), sections.keys.index([File.basename(r['rule'].split('#')[0]),r['rule'].split('#')[1]]),r['tool']=='none' ? 1 : 0,r['tool'],r['check']] }
rows.map! do |r|
  code = CODES.key(File.basename(r['rule'].split('#')[0],'.md'))
  counts[code] += 1
  {'id'=>format('JV-%s-%03d',code,counts[code])}.merge(r)
end
header = <<~TEXT
  # Java 規則對照表：每筆為一個小節 × 一條工具規則；人工審查每小節一筆。
  # id: JV-<文件縮寫>-<三位流水>，建立後不重編；新增採該文件最大流水號加一。
  # rule: 儲存庫相對路徑#java-錨點；title: 規範小節標題。
  # level: error / warn（條文要求，非工具預設或啟用門檻）。
  # tier: pre-commit / ci-compile / ci-bytecode / ci-arch / ci-build / test / manual。
  # tool: pmd / checkstyle / javac / errorprone / spotbugs / archunit / jdeps / jdeprscan / maven-enforcer / gradle / none。
  # check: 正式規則 ID 或 custom:<PascalCase>；設定與例外在 note；none 表示人工。
  # xpath: 僅 PMD 自訂規則；逐字保留來源 custom_xpath 的字串值。
  # versions: 適用 Java 版本，不代表逐版實證；實證版本另載於 note。
  # status: verified 正反例成功；partial 局部成功或已知漏報；candidate 未實證或失敗；manual 人工／待實作測試。
  # false_positive_risk: low / medium / high；note: 審查、例外、設定與證據限制。
  # source: 來源盤點 ID 的陣列；合併時保留全部來源。
  # 縮寫表：
TEXT
CODES.each { |code,doc| header += "# #{code}: #{doc}\n" }
File.write("#{ROOT}/tools/java/rule-map.yml",header + rows.to_yaml)
audit += ["", "## 判定原則與範圍", "", '- 四份檔案共 318 筆；排除 30 筆沒有 java- 小節錨點的驗收索引，這些引用不另增加小節分母。', '- 四份盤點的文件分工互斥，沒有跨研究者的同小節重複；var／Lambda 分屬不同錨點，依一條映射只對一個錨點保留兩筆，沒有虛構雙來源。', '- PMD 自訂名稱原本均為 PascalCase，且沒有同語意的異名，故不強行改名；寬鬆版與精確版 XPath 語意不同，保留失敗候選以免重新採用。', '- check 移除工具前綴；Checkstyle 設定移入 note，正式模組名放 check；同小節相同模組的不同配置合併，配置與誤報仍完整保留。', '- manual 與尚未實作的 test 同小節合併為一筆 manual，note 保留具體驗收；不把待寫測試當作現有工具。', '- verified 只表示該規則已證明正反例成功，並非整個小節或所有 Java 版本完整自動化；已知未命中的反例列 partial，只有失敗、未執行或另一規則的旁證列 candidate。', '- 原盤點 true/true 仍可降級：NoVar 的 Lambda 主例漏報、IdentifierName／SpotBugs 命名只抓部分、MutableStaticState 漏靜態 final 登錄、OptionalReturnNull 漏間接 null、EnumOrdinalAtBoundary 與 EnumDefaultHidesCases 的補強合法例誤報均列 partial。', '- CatchThrowableOrError 只有另一條規則的旁證，維持 candidate；CatchConcurrentModification 等具 sample caught 的補充實證保守列 partial，不把 null 自動當 true。', '- javac --release 來源明列 unverified，保留 candidate；合成成功但原條文無範例的 ArchUnit／ParallelStreamUsage／doclint 則依來源 true/true 列 verified，note 明示合成來源。', '- 拆分命名規則後，原範例只證明 TypeName／ConstantName／MethodName 與相應 PMD 三條；泛型參數原例是介面宣告，僅 InterfaceTypeParameterName 計 verified，其餘 candidate。', '- 版本政策 java-supported-versions 是章節相容錨點而非 ### 小節，不另外計數；java-example-baseline 才是對應小節。', "", "## 逐項合併、拆分與等級修正", ""]
audit.concat(changes.uniq)
File.write("#{ROOT}/tools/java/coverage/merge-decisions.md",audit.join("\n")+"\n")
puts "已產生 #{rows.size} 筆映射；#{sections.size} 個小節。"
