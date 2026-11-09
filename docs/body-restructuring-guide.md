# Java 正文整理作業說明

固定基準：`350668eb14ede247af22c782323beebf940c2a5f`，不得改工具或紀錄的基準值。決策依[待決清單](pending-decisions.md)及本文件列出的核准例外；共通側現況見[共通決策](body-restructuring-common-decisions.md)。Ruby 最低版本為 **2.6**，本輪以 Ruby 2.6.10 執行；不需要額外 gem。

## 唯一可修改範圍

每位工作者只准修改被指派主題的兩個實際路徑：

1. `rules/stacks/java/common/<主題>.md`
2. `docs/body-restructuring/java/<主題>.json`

例如分派 `value-objects`，只准改 `rules/stacks/java/common/value-objects.md` 與 `docs/body-restructuring/java/value-objects.json`。**除此之外一律不能碰**，包括：

- `docs/java-rule-migration.md`、`docs/pending-decisions.md`、`docs/body-restructuring-verification-results.md`。
- `docs/body-restructuring/common/` 下所有檔案、`docs/java-rule-classification.md`、`docs/acceptance-cleanup-batch-*.md`、`docs/acceptance-rewritten-fragments.json`。
- `scripts/` 下所有工具，以及本作業說明與其他 docs 文件。
- `rules/` 內的共通檔、`rules/README.md`、`rules/stacks/java/README.md`，以及其他主題的 Java 文件。
- 其他人的 JSON 紀錄、任何 `review-report*.md`、main、遠端分支。

不建立「自己的說明文件」。疑義寫在本份 JSON 的句子 `reason`；需要跨檔更新的連結、未決問題與測試輸出，在工作完成回報中交給協調者。樣板提交曾修改共用對照檔，那是協調者的工作，不能仿照其提交範圍。

使用隔離且乾淨的工作分支，記下協調者指定的起點提交。範圍檢查包含該起點以後的提交、暫存區、工作區與未追蹤檔案；原本就有未追蹤審閱報告的 checkout 不適合作工作者範圍測試，應由協調者建立乾淨 checkout，不能自行刪報告。

```sh
ruby scripts/verify-body-worker-scope.rb --topic value-objects --start 起點提交
```

## 作業順序

1. 讀本主題基準全文、待決清單第三／四／六節對應列及下方特別注意事項；比對要引用的共通原文。
2. 只把本份紀錄的 `status` 改為 `completed`；其他紀錄保留 `pending`。完成時不得仍有「尚未整理」的理由。
3. 先填歷史 ID 的預定去向、逐句 `history_id`、保留／改寫／移除判斷及被刪子句承接證據，再修改規則檔並逐句核對。發現無法直接涵蓋的要求，改回保留並記理由。
4. 整理小標題、語意錨點、驗收第一欄及非表格條號引用；驗收內容與既有共同連結均保留。
5. `text` 填實際完成後的承接句，更新本份 `edits`，逐筆核對差異；輔助工具不會替你核准句子去向。
6. 跑常駐檢查、負向測試、範圍檢查及 diff 檢查；逐句人工確認條件、禁止事項與適用邊界未降低，再獨立提交本份兩個檔案。

## 小標題、連結與段落歸屬

正式正文不用流水號，保留二級主題分組；每條使用三級小標題及獨立顯式錨點，例如：

```markdown
<a id="java-optional-nonnull"></a>

### Optional 本身非空

宣告使用 `Optional` 的位置，`Optional` 本身不得為 `null`。
```

錨點用 `java-` 加小寫英文語意，以 `-` 分隔，不含歷史 ID 或條號。同檔唯一，避免和隱含標題錨點相撞。共通來源先用現行 `#jn-08` 等錨點，74 個歷史規則錨點由後續協調者統一改名及保留別名。

**原句引用整份文件，整理後仍須保留整份連結；精確錨點只能額外補充，不能取代。** 移除純引用條文時，原整份引用須在引言或相應驗收入口繼續存在；去向證據另列最直接的條文錨點。JN-06 的整份資料驗證／錯誤處理／領域建模引用移至檔頭，接收、建立、狀態變更的證據分別列在 JSON，兩者責任不同。

分組標題有入站連結時保留，不由工作者修改共用對照檔。分組尾段若只適用最後一個小節，可原文留在該小節並以 `history_id: null` 記錄原本沒有條號的來源；JN 的對外缺值尾段即如此。若尾段涵蓋整個分組，保留在獨立的同級「共同要求」小節，登錄移位及新錨點，不讓排版把適用範圍縮成最後一條。

## 判斷欄與六種去向的對照

以下順序有優先性，先套明確核准例外，再套原分類：

| 原判斷 | 去向種類與處理 |
| --- | --- |
| 選 B 的 CA-03、ST-01、BM-04 | 整條保留；BM-04 再登錄移入禁止句。 |
| CA-06、CO-08 已核准提升 | 拆分，逐句對照新共通條文；具體 API、執行模型與 Java 限制保留，涵蓋不直接的也保留。 |
| 第三節「重述」 | 整條移除；每句均登錄移除與共通承接證據，例如 JN-06。 |
| 第三節「增量」 | 保留增量；共同政策引用、Java 操作限制留下，例如 JN-08。 |
| 第三節「混合」 | 拆分，逐一列出被刪子句及共通原文，例如 JN-09／12。 |
| 第三節「驗收入口」 | 轉為驗收入口；所有獨立要求搬到有效驗收位置，不能隨入口一起刪，例如 JN-10。VO-10 另依下方特別注意事項。 |
| 第三節「待確認」 | BM-04 套選 B；CO-08 套已提升的拆分規則，不再留給工作者猜。 |
| 第三節「待補證」ND-02 | 整條保留，不因名稱看似共通就刪除。 |
| 第四節「是／可能」 | 整條保留、不抽背景；只有已核准 CA-06／CO-08 適用上列例外。 |
| 第四節「否」 | 有被刪的共同斷言或列舉（`removed_assertions` 非空）列為「拆分」；只有補引用、字面改寫且沒有刪斷言列「保留增量」。因此樣板 JN-01 為保留增量，JN-02／03／04／07 統一為拆分。 |
| 全份合併 | 整份併入他檔，只由協調者在全部合併後判斷；工作者不得刪檔或合併檔案。 |

「整條保留」只換條號／小標題／錨點，原文字逐字保留；其所有句子 `action` 必須是保留。獲准的移入句單獨列 imports，不可混在未登錄增文裡。「整條移除」的所有句子必須是移除，不能正文仍在卻把種類填移除。

遇到來源不直接或無法判斷，保留 Java 原句，在該句 `reason` 指出未涵蓋的具體條件，回報協調者；不要擴寫共通、不自行降級驗收。19 條遺失原文的規則，每條理由須保留「整理前原文未提交，無法證明完整覆蓋」。

## 逐句與子句紀錄格式

每份 JSON 的 `rules` 是歷史 ID 到現行錨點的對照。全部文件合計必須恰為 153 條；`ruby scripts/show-body-map.rb` 可輸出對照，不需要工作者改共用表。

- `baseline` 與 `path` 不變；`status` 為 pending／completed（merged 僅協調者使用）。
- 每筆 `sentences` 保留原 `source` 及順序，`history_id` 為所屬歷史條號；檔頭、分組尾段或未編號內容填 `null`，不能借用上一條。
- 切句與基準完全相同：逐行去條號及粗體小標題，再按中文句號切分；標點保留。非空、非標題行皆納入，包括程式碼圍欄、程式碼行、清單與表格行；沒有句號的行作一個完整單位。這是文字切分，不是語意剖析，不要自行合併／省略這些來源。
- 保留：`targets[].text` 等於原句且在指定小節逐字存在。
- 改寫：`text` 必須是目的地的**完整一句**，不能填兩字、半句或整個小節。原句拆成兩句時列兩個 target；兩個原句共同由一句承接時可以引用同一句，但 reason 必須各說各的斷言。驗收表的 target 填第二欄實際承接的完整一句，不貼整列。
- 改寫或移除的 reason 至少 20 個非空白字元，說明這一句哪些條件留下、哪些改引用、為何來源直接涵蓋；不能同一條多句套同一段理由。
- 被刪子句逐筆列於 `removed_assertions`；純加連結、文法調整而沒刪斷言可填空陣列。移除句不得空白，targets 必須和所有 source_uri 的集合一致。

```json
{
  "history_id": "JN-09",
  "removed_assertions": [{
    "text": "不因 Java 方法簽章未變就視為相容",
    "source_uri": "rules/coding/nullability.md#jn-09",
    "source_text": "空值契約變更須評估參數、回傳值及欄位對使用端的影響，涵蓋是否允許缺值、缺值語意、標註及實際處置；即使型別或方法簽章未變，也不得直接視為相容。"
  }]
}
```

工具驗證被刪子句在基準原句內、已不在現行文件；承接原文逐字存在於共通錨點的小節。**機器仍不能證明兩句語意相關**；輸出會逐句列出實際需人工複核的 source、targets、removed_assertions、reason，不能只看 exit 0。

現行正文的每個新句子也須被保留／改寫 target 或 imports 涵蓋；不能只重生 edits 就加入新義務。若切句讓程式碼／清單的目的內容無法準確表示，保留原文並回報，不改工具繞過。

## 選 B 移入句

目前核准移入的只有 BM-04。使用本份紀錄的 `imports`，不改基準的 `sentences.source`：

```json
{
  "source_path": "rules/architecture/data-mapping.md",
  "source_text": "不得略過欄位或產生不完整物件掩蓋失敗",
  "target_uri": "rules/stacks/java/common/boundary-mapping.md#java-mapping-integrity",
  "history_id": "BM-04",
  "reason": "依已核准選 B 將基準共通禁止句逐字移入 Java，保留欄位與物件完整性要求，刪除共通摘要由協調者另行處理。"
}
```

target_uri 使用該工作者實際建立的小節錨點。工具核對固定基準共通檔有原文、現行 Java 小節也有原文、ID 與小節相符；補句號可以，但不改原文字。工作者**不得**刪除共通摘要；協調者須等全部合併並確認 Java 承接後再刪。

## 驗收欄位及非表格內容

完成整理的表頭統一為 `| 對應要求 | 語言增量驗收 |`，並登錄於 acceptance_changes。第一欄依下列固定規則填寫，混合多條時按原次序以「、」分隔：

- 有 Java 正文：連到現行 Java 語意小標題。
- 整條移除：連到實際承接的共通規則，以其標題作連結文字；不得連回本文件驗收章節。
- 轉為驗收入口：填純文字 **覆蓋要求（原驗收入口）**，不做指向本節自己的連結。樣板 JN-10 已採此格式。

`acceptance_changes` 每筆列 before／after（含換行）及至少 20 字理由；第二欄逐字不變。固定表頭可由舊名稱變成「對應要求」，不准任意改名。

驗收章節**所有非表格文字**依基準保護，包括引言、共同驗收連結與治理尾句。只允許條號引用改錨點，使用 `acceptance_text_changes` 的 before／after、reason 及 references：

```json
{
  "references": [{"before": "第 9 條", "after": "[錯誤處理](#java-error-handling)"}]
}
```

references 以實際文字為準；對 before 套用這些替換必須恰好等於 after，其他字一概不變。「各條 Java 使用限制仍適用」沒有數字條號，不改它。新增驗收內容另由協調者在工具明列白名單；目前只允許 JN 已搬入引言及下列兩個已核准共同驗收連結，以 `acceptance_additions` 登錄：

concurrency（後接換行）：

```markdown
- [結果接收與故障處置](../../../coding/concurrency-and-async.md#acceptance-result-reception)。
```
collections（後接換行）：

```markdown
- [失敗後狀態](../../../coding/error-handling.md#acceptance-failure-state)。
```

兩個連結插在「### Java 語言增量驗收」之前、共同清單的末尾；不得用白名單加入其他句子。

## 各文件的特別注意事項

| 文件 | 必須遵循的決策 |
| --- | --- |
| `boundary-mapping.md` | BM-04 整條保留，逐字加入上述 imports 禁止句；共通摘要留給協調者最後刪。 |
| `concurrency-and-async.md` | 第 6 條比照混合，逐句對照 `concurrency-and-async.md#async-result-reception`；Future／CompletableFuture、結果鏈及 Java 失效情境留下。CA-03 可見性依選 B 整條留 Java；共同驗收補 reception 連結。 |
| `collections-and-ownership.md` | 第 8 條比照混合，對照 `error-handling.md#failure-state-guarantee` 及多步驟保證；Java 專屬限制或涵蓋不直接者留下。補 failure-state 驗收連結；工作者不合併檔案。 |
| `states-and-results.md` | ST-01 不同業務面向依選 B 整條留 Java，不因共通已刪摘要就縮成互斥狀態。 |
| `value-objects.md` | VO-10 共通摘要首句維持原狀；相關覆蓋要求不得因這份未列管摘要而刪除，沒有其他直接依據時保留 Java 原文並回報。 |
| `exceptions-and-resources.md` | 驗收非表格「依第 9 條」改為實際語意錨點，使用 acceptance_text_changes；該段其他文字不動。 |
| `equality-hashing-ordering.md` | 驗收非表格「依第 10 條」同上；不得因條文改名刪掉核對要求。 |
| `naming-packages-docs.md` | ND-02 待補證整條保留；其他 Javadoc 增量與已確認驗收不能消失。 |

CA-06 與 CO-08 的核准提升優先於原第四節「是」的分類；這個例外不擴及其他新義務。

## 重生差異與提交前驗證

```sh
ruby scripts/update-body-diff.rb value-objects '本主題依逐句去向改為語意小標題，驗收內容保持原文並只更新條號定位。'
ruby scripts/verify-body-restructuring.rb
ruby scripts/test-body-restructuring.rb
ruby scripts/verify-body-worker-scope.rb --topic value-objects --start 起點提交
git diff --check
git diff --check 350668eb14ede247af22c782323beebf940c2a5f..HEAD
```

不要重生共用驗證紀錄。負向測試使用暫存複本且比對預期診斷；檢查失敗應修正實際問題，不能刪測試、擴白名單或把別份標 completed。

## 協調者合併後的收尾清單

1. 合併各工作者的兩個檔案，逐一驗證範圍與句子承接；不合併工作者對共用檔的修改。
2. 統一更新 `docs/java-rule-migration.md`、`docs/pending-decisions.md` 的現行連結及完成狀態，保留歷史文字與原文缺失限制。
3. 確認併發與集合的共同驗收連結已補入；確認 exceptions／equality 非表格條號已更新且其他字未動。
4. 確認 BM-04 禁止句已逐字移入 Java，再獨立登錄並刪除共通摘要；VO-10 首句不動。
5. 全部合併後才決定集合是否併入例外；同步全部正文、驗收列、索引、入站連結、追溯目的地及改寫清單，不由單檔工作者做。
6. 執行常駐、負向與 diff 檢查，使用 `ruby scripts/record-body-verification.rb` 重生共用驗證紀錄；重算完成數及人工待複核清單。
7. 74 個錨點改名、M4 驗收整合、CA-06／CO-08 重疊分工仍為後續獨立批次，不能夾在平行合併中。
