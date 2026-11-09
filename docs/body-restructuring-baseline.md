# 正文整理基準與檢查責任

新基準：`350668eb14ede247af22c782323beebf940c2a5f`。此提交已完成 R4-L1、R4-L2，舊驗收檢查在該提交通過。歷史驗收階段的政策、五批追溯及改寫紀錄全部保留。

現行入口為 `ruby scripts/verify-body-restructuring.rb`，負向測試為 `ruby scripts/test-body-restructuring.rb`。驗收階段入口已封存，直接執行會明確拒絕；歷史重現用 `ruby scripts/verify-acceptance.rb --target 350668eb14ede247af22c782323beebf940c2a5f`。舊負向測試與驗證產生器只適用歷史階段，不作現行提交把關。

新檢查承接全部 rules 檔案與位元組保護、本地連結與錨點、15 份 Java 與共通驗收逐字去重、五批原文片段串接及目的列逐字／改寫對應；原驗收章節的每列另以新基準保護。正文准許變更的範圍由新去向紀錄明列，不再以舊驗收差異清單禁止已核准的正文整理。

每份 Java 的 `docs/body-restructuring/java/<主題>.json` 同時記錄 153 條歷史 ID 的現行去向、基準每句的去向及全文差異。`pending` 必須整檔逐字不變；`completed` 必須逐句保留、改寫或移除並指認共通來源。`merged` 供後續整份併入他檔使用，必須列出接收檔案及全部句子、驗收列的新位置。共通差異獨立存於 `docs/body-restructuring/common/`，每塊包含決策列、逐字刪增與理由。

原句切分以正文每個非空、非標題行為單位，再按句號切句，保留標點；條號與粗體小標題由全文差異保護。這避免語法範例或分號內容被漏掉；不是自然語言的語意分析。移除的來源涵蓋程度、改寫是否保留所有斷言、決策適用及理由充分性仍須人工確認。

## 第五次審閱補強

固定基準未變。每句新增 history_id 與 removed_assertions（被刪子句、共通錨點、共通原文），另有 imports、acceptance_text_changes、acceptance_additions。完整格式及責任界線以現行作業說明為準。

新工具亦承接待決清單第三／四節 153 ID 與第六節 19 ID 清冊、空驗收列檢查。已完成文件的驗收章節整體逐字保護，僅允許登錄的第一欄、條號引用及工具明列增文；整條保留不得改字，現行新增句必須有去向。共通紀錄只准 ca-06.json、co-08.json、existing-sources.json。

`ruby scripts/record-body-verification.rb` 為現行驗證紀錄產生器；`ruby scripts/test-body-reverts.rb` 在暫存複本實際撤回兩個獨立提交。工作者另用 `verify-body-worker-scope.rb --topic 主題 --start 起點提交` 驗證只改兩個獲分派檔案。
