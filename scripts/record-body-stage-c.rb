# frozen_string_literal: true
require_relative 'body-presentation'
Dir.chdir(File.expand_path('..',__dir__))
P=BodyPresentation
config=JSON.parse(File.read(P::CONFIG));P.validate(config)
records=Dir['docs/body-restructuring/java/*.json'].sort.map{|p|JSON.parse(File.read(p))}
out,status=Open3.capture2e('ruby','scripts/verify-body-sentences.rb');raise out unless status.success?
text=<<DOC
# 正文整理階段 C：第一部分

起點：`#{P::START}`。正文基準仍為 `#{BodyRestructuring::BASELINE}`。本部分只處理連結與版面，不改正文義務、不搬驗收、不合併檔案。

## 提交與範圍

- `06569c2`：先新增版面轉換、別名比對、句子集合與正負向測試。
- `c8f7f5b`：74 個共通歷史錨點改用語意名稱，同位置保留舊別名；Java 連結與 JSON 同步。
- `f5d4f0a`：15 份文件重生分組與引言指路，三段中間尾段回原分組；version-policy 搬空的「補充要求」標題與錨點移除。
- `62f0342`：Java 索引僅列仍有 Java 正文的小節標題，不新增規則。
- 文件與驗證收尾提交接在以上提交之後，包含本紀錄、共用對照、指南、實際驗證輸出及封存測試的明確執行入口。

## 錨點與相容性

第五節全部 74 筆已執行，調整建議名稱的筆數為 **0**。新錨點後緊接舊錨點，兩者指向同一段正文。集中清冊見[相容別名](common-anchor-aliases.md)及 `docs/common-anchor-aliases.json`。rules 不再連到舊代號；15 份 JSON 的來源、承接及差異記錄以同一別名表正規化，沒有舊代號的連結目標。歷史原文仍可從基準還原，前階段共通改動紀錄與工作者原始回報保留歷史原文。

## 固定格式與實例

以下例子逐字取自現行 Java 去向紀錄；路徑相對於該 Java 文件。

DOC
route=records.find{|r|r['path'].include?('classes-and-construction')}['group_routes'].first
intro=records.flat_map{|r|r['link_retention']}.first
tail=records.find{|r|r['path'].include?('version-policy')}['group_endings'].first
text+="分組指路：\n\n```markdown\n#{route['text']}\n```\n\n引言保留：\n\n```markdown\n#{intro['text']}\n```\n\n分組尾段：\n\n```markdown\n<a id=\"#{tail['anchor']}\"></a>\n\n### 本組補充說明\n\n#{tail['text']}\n```\n"
text+="\n分組指路只列該組整條移除的條文，依基準原條文順序排列，同條依承接來源登錄順序去重；已拆分或保留的條文不列。引言只保留未在正文、指路或其他段落出現的基準共通目標。全站現有 #{records.sum{|r|r['group_routes'].size}} 個分組指路、#{records.sum{|r|r['link_retention'].size}} 個引言保留句；唯一引言保留句是 value-objects 的整份資料驗證入口，不能用分組內較窄的責任分工錨點取代。\n\n## 回原分組的段落\n\n"
records.each do |r|
 r.fetch('group_endings',[]).each{|e|text+="- `#{r['path']}` →「#{e['heading']}」，錨點 `#{e['anchor']}`：\n\n```text\n#{e['text']}\n```\n\n"}
end
text+="已掃描全部 15 份基準：只有以上三段屬非最後分組尾段。types-and-generics 與 lambda-and-stream 的程式碼示例原本位於最後分組之後，保持在補充要求；沒有將它們誤搬到前組。\n\n## 句子集合比對實際輸出\n\n```json\n#{out}```\n"
text+=<<'DOC'

比對保留每一非空單位及其出現次數，包含程式碼；正規化連結目標、排除錨點與固定指路／補充標題。它單獨不能判斷正文所屬小節，因此主檢查另逐檔比對工具計算的完整期待文件，防止任意搬段、改標題或夾帶內容。Java 索引只有摘要例外，主檢查也逐列計算期待標題清單，其他文字不開例外。

## 工具與測試

- 新 `body-presentation.rb`：74 筆清冊及相鄰別名、分組與引言期待整句（診斷含期待值）、中間尾段與錨點、全部連結、第五節與歷史 ID 清冊、現行驗收追溯、句子集合、Java JSON 與完整 rules 內容皆核對。
- 新 `verify-body-sentences.rb` 可獨立重跑以上比對；`apply-body-presentation.rb` 按 aliases／layout／index 執行，只產生既定轉換，已啟用時先檢查現況。
- 新 `test-body-presentation.rb` 20 案：一個完整正向案例涵蓋全部 15 份、非空與空分組、引言與三段尾段；19 個負向案例涵蓋起點、含隱藏檔的 Java／共通紀錄清冊、別名清冊、舊別名、正文、舊連結、缺指路、代碼標籤、夾帶義務、錯誤去向、尾段文字與標題、驗收、第五節清冊與名稱、前階段追溯及重複句。
- 原正文／政策測試使用階段 B 起點暫存資料，演練使用原固定分派資料；沒有讓舊格式測試放寬成接受任意新格式。現行階段 C 有獨立直接檢查。
- 原封存 `test-verify-acceptance.rb` 在階段 C 直接執行時，明確建立封存基準暫存 checkout 執行舊測試，輸出 archived_at 與範圍；不再把「已封存」當成不明失敗，也不將封存測試當現行測試。
- 語意承接保證仍由固定階段 B 快照的完整檢查承接。現行版先證明是該快照的核准精確轉換，並直接重跑現行驗收追溯。輸出分開 `legacy_snapshot_local_links` 與 `current_local_links`，明列 presentation 狀態。

完整實際輸出見[驗證紀錄](body-restructuring-verification-results.md)。本紀錄可用 `ruby scripts/record-body-stage-c.rb` 重生，驗證紀錄使用 `ruby scripts/record-body-verification.rb`。

## 未處理事項

Java 小節錨點未改，包含先前指出的 `java-specific-responsibility`、`java-mapping-integrity` 及驗收類英文字差異。驗收整合、殘留整理敘述、原有「下方表格」定位、CA-06／CO-08 驗收重疊、集合是否併入他檔均未處理，留最後階段第二部分。此部分沒有新增或刪除規範義務。
DOC
path='docs/body-restructuring-stage-c.md'
continuation=File.read(path).split(/^## 第二部分：/,2)[1] if File.file?(path)
text+="\n## 第二部分："+continuation if continuation
File.write(path,text)
puts "階段 C 紀錄已產生：74 別名、#{records.sum{|r|r['group_routes'].size}} 分組指路、3 段尾段。"
