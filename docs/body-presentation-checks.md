# 階段 C 連結與版面檢查

固定起點為 `3f68be483882d8dbfb6611bd58c40ec7446414af`，正文基準仍為 `350668eb14ede247af22c782323beebf940c2a5f`。這階段不得改寫正文，故採固定起點到現行文件的精確轉換檢查，不擴充前階段的刪句或改寫豁免。

`body-presentation.rb` 從起點第五節讀取 74 筆核准對照，計算別名、全部連結目標、分組指路、引言剩餘連結、三段中間尾段及索引摘要的完整期待值。主檢查逐檔、逐份 JSON 相等比對，並直接檢查現行連結、驗收追溯、句子集合及第五節清冊。指路錯誤印出完整期待句。錨點別名正規化不改連結文字。

15 份 JSON 新增 `presentation_version: 1` 與 `group_endings`（heading、anchor、text）；`group_routes` 現在包含每個有整條移除的分組；`link_retention` 只列正文、分組指路及其他既有位置仍未涵蓋的基準目標。各欄位由工具重算，不接受人工額外文字。`source` 及差異區塊來源使用基準連結經核准別名正規化的拼法，其他文字逐字不變；`edits` 也對同樣正規化的正文基準計算。歷史原文仍從固定基準提交取得。

原 153 條的語意去向、斷言承接與驗收保證由階段 B 起點的原檢查繼續驗證；主檢查先證明現行內容與該起點只有核准呈現差異，再在暫存快照執行原檢查。輸出區分現行連結數與歷史快照連結數，沒有把快照數量說成現行數量。前階段共通改動紀錄保留原文，另由本階段清冊與精確轉換檢查保護錨點變更。

`test-body-restructuring.rb`、`test-body-policy.rb` 在階段 C 啟用後使用階段 B 起點的 rules／docs 暫存資料配合目前腳本，保留原測試的故障診斷；演練仍使用其原固定分派快照。`test-body-presentation.rb` 另外直接對完整階段 C 呈現執行正負向測試。全部測試都不修改真實規範。

固定格式：

```text
分組指路：本組下列要求由共通規範承接：[共通標題](相對路徑#語意錨點)、[共通標題](相對路徑#語意錨點)。
引言保留：本文件另依[共通標題或文件標題](相對路徑)辦理。
```

- 分組結尾：`### 本組補充說明`，錨點為 `java-group-notes-` 加該組第一條原有 Java 語意錨點去掉 `java-` 的部分；原有 Java 條文錨點不改。最後一組之後的尾段仍在 `## 補充要求`。

連結依完整目標路徑的字元順序排列、去重；連結文字從承接錨點的小標題取得，段落錨點取其最近上層標題，整份文件取一級標題。指路不列拆分條文。工具只有這些固定句式，不能藉指路增添義務。

執行：`ruby scripts/verify-body-restructuring.rb`、`ruby scripts/verify-body-sentences.rb`、`ruby scripts/test-body-presentation.rb`；完整命令集由 `ruby scripts/record-body-verification.rb` 擷取。`apply-body-presentation.rb` 按 `--aliases`、`--layout`、`--index` 順序執行，已啟用時先核對現況，避免覆蓋未登錄修改。
