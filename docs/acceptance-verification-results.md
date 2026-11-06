# 驗收整理最終驗證紀錄

日期：2026-11-06。以下為實際執行輸出，非預期值。所有命令均在儲存庫根目錄執行。

常駐檢查無基準參數，僅檢查本地連結／錨點、已完成文件零逐字重複並回報全站剩餘量。`scripts/acceptance-batches.json` 只記錄完成範圍，不寫死提交。

批次差異檢查使用 `--batch N --baseline COMMIT --target COMMIT`；省略 target 時檢查工作區。後續批次可合法變更其他文件，因此歷史範圍檢查應指定歷史受驗提交。

`--trace-only` 只核對指定基準與現行追溯片段，仍執行常駐檢查，但不宣稱歷史範圍及正文未變。`--rules-baseline` 額外核對全部規則正文；明確排除驗收區與複核紀錄列管的整理敘述。索引由人工核對。

最終現行追溯共 107 列原驗收、171 個片段；所有片段依序串回原句。連結／錨點與文字重組不能證明目的地語意正確，目的地內容另逐片核對。

## 保守判斷

- ST 1、2：獨立業務面向分開建模留 Java，未採未列管摘要當提升依據。
- BM 4：半成品與內部缺陷處理留 Java；部分成功項目對應引用共通。
- VO 10：完整覆蓋要求及存取方法測試範圍留 Java；不以未列管摘要新增共同覆蓋列。
- JN 4、5／6、7、11：Java Optional 使用位置、容器非空預設及標註工具契約留 Java；更新意圖引用共通。
- NT 9：Clock 取時路徑留 Java，整體時間基準及單調時間要求引用共通。
- LS 8／9：函式介面例外限制與 Stream 消費機制留 Java，部分成功及外部資源有效期引用共通。

19 條改引用的整理前全文無法由儲存庫還原，未補造原文；逐條覆蓋疑點記於 pending-decisions。待確認的正文變更均未執行。

## 常駐與正文基準


`ruby scripts/verify-acceptance.rb`

```json
{
  "completed_java_files": 15,
  "completed_duplicate_rows": 0,
  "checked_local_links": 1924,
  "remaining_global_duplicate_common_rows": 0
}
```

`ruby scripts/verify-acceptance.rb --rules-baseline 6a16349`

```json
{
  "completed_java_files": 15,
  "completed_duplicate_rows": 0,
  "checked_local_links": 1924,
  "remaining_global_duplicate_common_rows": 0,
  "rules_baseline": "6a16349",
  "rule_body_unchanged": true
}
```

`ruby scripts/verify-acceptance.rb --batch 1 --baseline 6f7ae5d --target e8d32e7`

```json
{
  "completed_java_files": 15,
  "completed_duplicate_rows": 0,
  "checked_local_links": 1924,
  "remaining_global_duplicate_common_rows": 0,
  "batch": 1,
  "baseline": "6f7ae5d",
  "target": "e8d32e7",
  "original_acceptance_rows": 20,
  "traced_fragments": 44,
  "trace_only": false,
  "rule_body_unchanged": true
}
```

`ruby scripts/verify-acceptance.rb --batch 2 --baseline e8d32e7 --target 6a16349`

```json
{
  "completed_java_files": 15,
  "completed_duplicate_rows": 0,
  "checked_local_links": 1924,
  "remaining_global_duplicate_common_rows": 0,
  "batch": 2,
  "baseline": "e8d32e7",
  "target": "6a16349",
  "original_acceptance_rows": 23,
  "traced_fragments": 44,
  "trace_only": false,
  "rule_body_unchanged": true
}
```

`ruby scripts/verify-acceptance.rb --batch 3 --baseline 163af59 --target 15ee488`

```json
{
  "completed_java_files": 15,
  "completed_duplicate_rows": 0,
  "checked_local_links": 1924,
  "remaining_global_duplicate_common_rows": 0,
  "batch": 3,
  "baseline": "163af59",
  "target": "15ee488",
  "original_acceptance_rows": 19,
  "traced_fragments": 25,
  "trace_only": false,
  "rule_body_unchanged": true
}
```

`ruby scripts/verify-acceptance.rb --batch 4 --baseline 15ee488 --target 0186c6a`

```json
{
  "completed_java_files": 15,
  "completed_duplicate_rows": 0,
  "checked_local_links": 1924,
  "remaining_global_duplicate_common_rows": 0,
  "batch": 4,
  "baseline": "15ee488",
  "target": "0186c6a",
  "original_acceptance_rows": 24,
  "traced_fragments": 29,
  "trace_only": false,
  "rule_body_unchanged": true
}
```

`ruby scripts/verify-acceptance.rb --batch 5 --baseline 0186c6a --target 782fcdf`

```json
{
  "completed_java_files": 15,
  "completed_duplicate_rows": 0,
  "checked_local_links": 1924,
  "remaining_global_duplicate_common_rows": 0,
  "batch": 5,
  "baseline": "0186c6a",
  "target": "782fcdf",
  "original_acceptance_rows": 21,
  "traced_fragments": 29,
  "trace_only": false,
  "rule_body_unchanged": true
}
```

`ruby scripts/verify-acceptance.rb --batch 1 --baseline 6f7ae5d --trace-only`

```json
{
  "completed_java_files": 15,
  "completed_duplicate_rows": 0,
  "checked_local_links": 1924,
  "remaining_global_duplicate_common_rows": 0,
  "batch": 1,
  "baseline": "6f7ae5d",
  "target": "working-tree",
  "original_acceptance_rows": 20,
  "traced_fragments": 44,
  "trace_only": true
}
```

`ruby scripts/verify-acceptance.rb --batch 2 --baseline e8d32e7 --trace-only`

```json
{
  "completed_java_files": 15,
  "completed_duplicate_rows": 0,
  "checked_local_links": 1924,
  "remaining_global_duplicate_common_rows": 0,
  "batch": 2,
  "baseline": "e8d32e7",
  "target": "working-tree",
  "original_acceptance_rows": 23,
  "traced_fragments": 44,
  "trace_only": true
}
```

`ruby scripts/verify-acceptance.rb --batch 3 --baseline 163af59 --trace-only`

```json
{
  "completed_java_files": 15,
  "completed_duplicate_rows": 0,
  "checked_local_links": 1924,
  "remaining_global_duplicate_common_rows": 0,
  "batch": 3,
  "baseline": "163af59",
  "target": "working-tree",
  "original_acceptance_rows": 19,
  "traced_fragments": 25,
  "trace_only": true
}
```

`ruby scripts/verify-acceptance.rb --batch 4 --baseline 15ee488 --trace-only`

```json
{
  "completed_java_files": 15,
  "completed_duplicate_rows": 0,
  "checked_local_links": 1924,
  "remaining_global_duplicate_common_rows": 0,
  "batch": 4,
  "baseline": "15ee488",
  "target": "working-tree",
  "original_acceptance_rows": 24,
  "traced_fragments": 29,
  "trace_only": true
}
```

`ruby scripts/verify-acceptance.rb --batch 5 --baseline 0186c6a --trace-only`

```json
{
  "completed_java_files": 15,
  "completed_duplicate_rows": 0,
  "checked_local_links": 1924,
  "remaining_global_duplicate_common_rows": 0,
  "batch": 5,
  "baseline": "0186c6a",
  "target": "working-tree",
  "original_acceptance_rows": 21,
  "traced_fragments": 29,
  "trace_only": true
}
```

## 格式與負向檢查

`git diff --check`：結束碼 0，無輸出。

在臨時複本植入反例後執行同一常駐腳本，四項均正確拒絕；臨時檔案已移除。

```text
失效連結：正確拒絕
重複錨點：正確拒絕
標題與錨點衝突：正確拒絕
已完成文件重複驗收：正確拒絕
```
