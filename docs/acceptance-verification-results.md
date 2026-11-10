# 驗收驗證實際輸出

本檔由 `ruby scripts/record-acceptance-verification.rb` 擷取封存提交 `350668eb14ede247af22c782323beebf940c2a5f` 的驗收檢查與五批追溯實際輸出；舊測試亦在該封存複本執行，diff 檢查則讀目前分支。這不是現行規範的驗證結果；現行結果見 `docs/body-restructuring-verification-results.md`。執行方式與人工檢查邊界見 `docs/review-remediation.md`；數字不代表語意零重複。

## `ruby scripts/verify-acceptance.rb --target 350668eb14ede247af22c782323beebf940c2a5f`

```text
{
  "source": "350668eb14ede247af22c782323beebf940c2a5f",
  "rules_baseline": "6a1634959d922b2df5f1259cb176a731a5b5f488",
  "protected_rule_files": 55,
  "matched_approved_rule_lines": 3018,
  "explicit_change_blocks": 94,
  "completed_java_files": 15,
  "duplicate_java_acceptance_rows": 0,
  "checked_local_links": 1974,
  "trace_checks": [
    {
      "batch": 1,
      "baseline": "6f7ae5d5250b7573a96c85f551b58878eb02c7e4",
      "original_rows": 20,
      "verbatim_fragments": 15,
      "listed_rewritten_fragments": 29
    },
    {
      "batch": 2,
      "baseline": "e8d32e7bd1b9e073f62f8092398daf7d1b57dce1",
      "original_rows": 23,
      "verbatim_fragments": 28,
      "listed_rewritten_fragments": 16
    },
    {
      "batch": 3,
      "baseline": "163af59f52ddee97b98ad2ddeac1dc918bde8010",
      "original_rows": 19,
      "verbatim_fragments": 22,
      "listed_rewritten_fragments": 3
    },
    {
      "batch": 4,
      "baseline": "15ee488028e09a00b05d8f1276ee83bfffc68050",
      "original_rows": 24,
      "verbatim_fragments": 26,
      "listed_rewritten_fragments": 3
    },
    {
      "batch": 5,
      "baseline": "0186c6adfce282cbf180207d9ec60833e5c66ce7",
      "original_rows": 21,
      "verbatim_fragments": 26,
      "listed_rewritten_fragments": 3
    }
  ],
  "line_endings_check": "逐位元組核對 LF／CRLF 與檔尾換行",
  "documentation_content_check": "待決清單與批次說明的內容正確性為人工檢查項目；機械檢查僅核對條目 ID 集合及追溯片段完整性",
  "reason_content_check": "理由內容為人工檢查項目；機械檢查僅限制分類、位置與至少 20 個非空白字元",
  "semantic_duplication_check": "人工檢查項目；換句話說的重複無法由本腳本判斷（T3）"
}
exit=0
```

## `ruby scripts/verify-acceptance.rb --batch 1 --target 350668eb14ede247af22c782323beebf940c2a5f`

```text
{
  "source": "350668eb14ede247af22c782323beebf940c2a5f",
  "rules_baseline": "6a1634959d922b2df5f1259cb176a731a5b5f488",
  "protected_rule_files": 55,
  "matched_approved_rule_lines": 3018,
  "explicit_change_blocks": 94,
  "completed_java_files": 15,
  "duplicate_java_acceptance_rows": 0,
  "checked_local_links": 1974,
  "trace_checks": [
    {
      "batch": 1,
      "baseline": "6f7ae5d5250b7573a96c85f551b58878eb02c7e4",
      "original_rows": 20,
      "verbatim_fragments": 15,
      "listed_rewritten_fragments": 29
    }
  ],
  "line_endings_check": "逐位元組核對 LF／CRLF 與檔尾換行",
  "documentation_content_check": "待決清單與批次說明的內容正確性為人工檢查項目；機械檢查僅核對條目 ID 集合及追溯片段完整性",
  "reason_content_check": "理由內容為人工檢查項目；機械檢查僅限制分類、位置與至少 20 個非空白字元",
  "semantic_duplication_check": "人工檢查項目；換句話說的重複無法由本腳本判斷（T3）"
}
exit=0
```

## `ruby scripts/verify-acceptance.rb --batch 2 --target 350668eb14ede247af22c782323beebf940c2a5f`

```text
{
  "source": "350668eb14ede247af22c782323beebf940c2a5f",
  "rules_baseline": "6a1634959d922b2df5f1259cb176a731a5b5f488",
  "protected_rule_files": 55,
  "matched_approved_rule_lines": 3018,
  "explicit_change_blocks": 94,
  "completed_java_files": 15,
  "duplicate_java_acceptance_rows": 0,
  "checked_local_links": 1974,
  "trace_checks": [
    {
      "batch": 2,
      "baseline": "e8d32e7bd1b9e073f62f8092398daf7d1b57dce1",
      "original_rows": 23,
      "verbatim_fragments": 28,
      "listed_rewritten_fragments": 16
    }
  ],
  "line_endings_check": "逐位元組核對 LF／CRLF 與檔尾換行",
  "documentation_content_check": "待決清單與批次說明的內容正確性為人工檢查項目；機械檢查僅核對條目 ID 集合及追溯片段完整性",
  "reason_content_check": "理由內容為人工檢查項目；機械檢查僅限制分類、位置與至少 20 個非空白字元",
  "semantic_duplication_check": "人工檢查項目；換句話說的重複無法由本腳本判斷（T3）"
}
exit=0
```

## `ruby scripts/verify-acceptance.rb --batch 3 --target 350668eb14ede247af22c782323beebf940c2a5f`

```text
{
  "source": "350668eb14ede247af22c782323beebf940c2a5f",
  "rules_baseline": "6a1634959d922b2df5f1259cb176a731a5b5f488",
  "protected_rule_files": 55,
  "matched_approved_rule_lines": 3018,
  "explicit_change_blocks": 94,
  "completed_java_files": 15,
  "duplicate_java_acceptance_rows": 0,
  "checked_local_links": 1974,
  "trace_checks": [
    {
      "batch": 3,
      "baseline": "163af59f52ddee97b98ad2ddeac1dc918bde8010",
      "original_rows": 19,
      "verbatim_fragments": 22,
      "listed_rewritten_fragments": 3
    }
  ],
  "line_endings_check": "逐位元組核對 LF／CRLF 與檔尾換行",
  "documentation_content_check": "待決清單與批次說明的內容正確性為人工檢查項目；機械檢查僅核對條目 ID 集合及追溯片段完整性",
  "reason_content_check": "理由內容為人工檢查項目；機械檢查僅限制分類、位置與至少 20 個非空白字元",
  "semantic_duplication_check": "人工檢查項目；換句話說的重複無法由本腳本判斷（T3）"
}
exit=0
```

## `ruby scripts/verify-acceptance.rb --batch 4 --target 350668eb14ede247af22c782323beebf940c2a5f`

```text
{
  "source": "350668eb14ede247af22c782323beebf940c2a5f",
  "rules_baseline": "6a1634959d922b2df5f1259cb176a731a5b5f488",
  "protected_rule_files": 55,
  "matched_approved_rule_lines": 3018,
  "explicit_change_blocks": 94,
  "completed_java_files": 15,
  "duplicate_java_acceptance_rows": 0,
  "checked_local_links": 1974,
  "trace_checks": [
    {
      "batch": 4,
      "baseline": "15ee488028e09a00b05d8f1276ee83bfffc68050",
      "original_rows": 24,
      "verbatim_fragments": 26,
      "listed_rewritten_fragments": 3
    }
  ],
  "line_endings_check": "逐位元組核對 LF／CRLF 與檔尾換行",
  "documentation_content_check": "待決清單與批次說明的內容正確性為人工檢查項目；機械檢查僅核對條目 ID 集合及追溯片段完整性",
  "reason_content_check": "理由內容為人工檢查項目；機械檢查僅限制分類、位置與至少 20 個非空白字元",
  "semantic_duplication_check": "人工檢查項目；換句話說的重複無法由本腳本判斷（T3）"
}
exit=0
```

## `ruby scripts/verify-acceptance.rb --batch 5 --target 350668eb14ede247af22c782323beebf940c2a5f`

```text
{
  "source": "350668eb14ede247af22c782323beebf940c2a5f",
  "rules_baseline": "6a1634959d922b2df5f1259cb176a731a5b5f488",
  "protected_rule_files": 55,
  "matched_approved_rule_lines": 3018,
  "explicit_change_blocks": 94,
  "completed_java_files": 15,
  "duplicate_java_acceptance_rows": 0,
  "checked_local_links": 1974,
  "trace_checks": [
    {
      "batch": 5,
      "baseline": "0186c6adfce282cbf180207d9ec60833e5c66ce7",
      "original_rows": 21,
      "verbatim_fragments": 26,
      "listed_rewritten_fragments": 3
    }
  ],
  "line_endings_check": "逐位元組核對 LF／CRLF 與檔尾換行",
  "documentation_content_check": "待決清單與批次說明的內容正確性為人工檢查項目；機械檢查僅核對條目 ID 集合及追溯片段完整性",
  "reason_content_check": "理由內容為人工檢查項目；機械檢查僅限制分類、位置與至少 20 個非空白字元",
  "semantic_duplication_check": "人工檢查項目；換句話說的重複無法由本腳本判斷（T3）"
}
exit=0
```

## `ruby scripts/test-verify-acceptance.rb`

```text
{
  "archived_at": "350668eb14ede247af22c782323beebf940c2a5f",
  "scope": "封存驗收階段；現行內容另由正文及版面檢查驗證",
  "exit": 0,
  "output": "Note: switching to '350668eb14ede247af22c782323beebf940c2a5f'.\n\nYou are in 'detached HEAD' state. You can look around, make experimental\nchanges and commit them, and you can discard any commits you make in this\nstate without impacting any branches by switching back to a branch.\n\nIf you want to create a new branch to retain commits you create, you may\ndo so (now or later) by using -c with the switch command. Example:\n\n  git switch -c <new-branch-name>\n\nOr undo this operation with:\n\n  git switch -\n\nTurn off this advice by setting config variable advice.detachedHead to false\n\n[\n  {\n    \"test\": \"T1\",\n    \"description\": \"失效錨點\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Missing fragment rules/stacks/java/common/types-and-generics.md: ../../../coding/type-safety.md#acceptance-missing\"\n  },\n  {\n    \"test\": \"T2\",\n    \"description\": \"逐字重複\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Scoped duplicate acceptance: [[\\\"rules/stacks/java/common/types-and-generics.md\\\", \\\"核對固定結構資料是否使用明確物件；動態資料的型別、結構與驗證是否有契約，並以受影響的合法及非法輸入確認驗證有效。\\\"]]\"\n  },\n  {\n    \"test\": \"T3\",\n    \"description\": \"換句話說重複：僅人工可判斷\",\n    \"expected_exit\": 0,\n    \"actual_exit\": 0,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"已在暫存清單登錄 T3；換句話說重複與理由內容仍為人工檢查項目\"\n  },\n  {\n    \"test\": \"T4\",\n    \"description\": \"追溯指錯現存列\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Trace fragment absent from destination NT-9-2: ../rules/coding/domain-modeling.md#acceptance-identity-lifecycle\"\n  },\n  {\n    \"test\": \"T5\",\n    \"description\": \"刪除核心業務政策\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Protected rule text changed rules/quality/rule-verification.md:22: - 純計算、狀態判斷與業務限制可直接建立物件測試；外部能力透過明確依賴提供測試替身，不因此強制每個類別建立介面。\"\n  },\n  {\n    \"test\": \"T6a\",\n    \"description\": \"刪除驗收尾段治理句\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Protected rule text missing rules/stacks/java/common/null-and-optional.md: 既有程式碼、工具限制與個別例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行放寬要求。\"\n  },\n  {\n    \"test\": \"T6b\",\n    \"description\": \"掏空 Java 驗收列\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Protected rule text changed rules/stacks/java/common/types-and-generics.md:47: | <a id=\\\"acceptance-java-explicit-types\\\"></a>1、9 | 略。 |\"\n  },\n  {\n    \"test\": \"T7\",\n    \"description\": \"README 政策改寫\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Protected rule text changed rules/README.md:8: - 通用規範定義共同底線，語言規範負責語法與型別使用，Framework 規範負責框架機制的落實方式。各專案自行管理實際架構、技術組合、配置與核准例外。各層可以具體化或加嚴要求，得自行降低標準。\"\n  },\n  {\n    \"test\": \"T8\",\n    \"description\": \"刪除受保護章節文字\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Protected rule text changed rules/quality/rule-verification.md:45:\"\n  },\n  {\n    \"test\": \"T9\",\n    \"description\": \"共通驗收列刪除後半斷言\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Protected rule text changed rules/quality/rule-verification.md:43: | <a id=\\\"acceptance-partial-operation\\\"></a>[多步驟與部分成功](../coding/error-handling.md#多步驟與部分成功) | 在處理中途製造適用的失敗，核對實際狀態是否符合全部成功或部分成功保證；允許部分成功時，結果須能對應已完成、未完成或結果未知的項目，集合批次修改適用同一驗收。 |\"\n  },\n  {\n    \"test\": \"T10\",\n    \"description\": \"重複錨點\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Duplicate/colliding anchor rules/stacks/java/common/types-and-generics.md\"\n  },\n  {\n    \"test\": \"N1\",\n    \"description\": \"未登錄的共通新義務\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Protected rule text changed rules/coding/type-safety.md:48: | <a id=\\\"acceptance-negative\\\"></a>新義務 | 所有語言的公開方法一律須以靜態分析工具證明參數型別完整，否則不得合併。 |\"\n  },\n  {\n    \"test\": \"N1b\",\n    \"description\": \"未登錄且沒有錨點的 Java 放寬句\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Protected rule text changed rules/stacks/java/common/types-and-generics.md:47: | 放寬 | 上列 acceptance-java 各項可由團隊自行決定是否執行，不必留存證據。 |\"\n  },\n  {\n    \"test\": \"N7\",\n    \"description\": \"目的列刪大半並以子字串登錄改寫\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Trace fragment absent from destination CL-4-1: ../rules/stacks/java/common/classes-and-construction.md#acceptance-java-construction-safety\"\n  },\n  {\n    \"test\": \"N8\",\n    \"description\": \"刪政策並登錄過短理由 x\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Invalid approved edit rules/quality/rule-verification.md:22: reason too short or blank\"\n  },\n  {\n    \"test\": \"N8b\",\n    \"description\": \"驗收分類不得刪除政策段\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Acceptance edit outside acceptance section rules/quality/rule-verification.md:22\"\n  },\n  {\n    \"test\": \"N9\",\n    \"description\": \"移動基準並清空清單\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"固定正文基準為 6a16349，清單 baseline 不得移動\"\n  },\n  {\n    \"test\": \"N18\",\n    \"description\": \"改寫理由只含空白\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Trace fragment absent from destination CL-1、8-2: ../rules/coding/code-design.md#acceptance-interface-capabilities\"\n  },\n  {\n    \"test\": \"N19\",\n    \"description\": \"任意 kind 與空白理由\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Invalid approved edit rules/README.md:11: reason too short or blank\"\n  },\n  {\n    \"test\": \"N19b\",\n    \"description\": \"充分理由仍拒絕任意 kind\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Invalid edit kind rules/README.md:11\"\n  },\n  {\n    \"test\": \"N19c\",\n    \"description\": \"editorial 不得碰表格列\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Editorial edit touches table rules/architecture/boundary-objects.md:33\"\n  },\n  {\n    \"test\": \"R3-reason19\",\n    \"description\": \"差異理由只有 19 個非空白字元\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Invalid approved edit rules/README.md:11: reason too short or blank\"\n  },\n  {\n    \"test\": \"R3-reason-spaces\",\n    \"description\": \"改寫理由 19 字加大量空白\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Invalid rewritten fragment CL-1、8-2: full destination and meaningful-length reason required\"\n  },\n  {\n    \"test\": \"R3-body-rewrite\",\n    \"description\": \"非混排 Java 正文登錄為 acceptance\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Acceptance edit outside acceptance section rules/stacks/java/common/types-and-generics.md:9\"\n  },\n  {\n    \"test\": \"R3-body-insert\",\n    \"description\": \"正文純插入登錄為 acceptance\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Acceptance edit outside acceptance section rules/stacks/java/common/types-and-generics.md:9\"\n  },\n  {\n    \"test\": \"R3-self-heading\",\n    \"description\": \"增文自帶驗收標題不得取得資格\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Acceptance edit outside acceptance section rules/stacks/java/common/types-and-generics.md:9\"\n  },\n  {\n    \"test\": \"R3-self-subheading\",\n    \"description\": \"增文自帶小標題不得取得資格\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Acceptance edit outside acceptance section rules/stacks/java/common/types-and-generics.md:9\"\n  },\n  {\n    \"test\": \"R3-table-no-leading-pipe\",\n    \"description\": \"editorial 插入無前導直線的表格列\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Editorial edit touches table rules/stacks/java/common/types-and-generics.md:43\"\n  },\n  {\n    \"test\": \"R3-hidden-file\",\n    \"description\": \"隱藏規範檔須納入檔案清單\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Rules file inventory changed: added=rules/.extra.md; removed=\"\n  },\n  {\n    \"test\": \"R3-new-file\",\n    \"description\": \"新增規範檔應明確回報清單差異\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Rules file inventory changed: added=rules/coding/extra.md; removed=\"\n  },\n  {\n    \"test\": \"R3-crlf\",\n    \"description\": \"CRLF 不得被逐行 chomp 忽略\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Rule line endings changed rules/stacks/java/common/types-and-generics.md\"\n  },\n  {\n    \"test\": \"R3-final-newline\",\n    \"description\": \"檔尾換行不可被忽略\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Rule final newline changed rules/stacks/java/common/types-and-generics.md\"\n  },\n  {\n    \"test\": \"R3-pending-ids\",\n    \"description\": \"待決評估不得少 NT-04\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Pending decision ID inventory changed\"\n  },\n  {\n    \"test\": \"R3-trace-rows\",\n    \"description\": \"追溯表不得少原片段\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"Missing/changed original fragments VO-1、2\"\n  },\n  {\n    \"test\": \"R3-removed-scope\",\n    \"description\": \"移除無法使用的範圍模式\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"<驗收暫存複本>/scripts/verify-acceptance.rb:18:in `<main>': invalid option: --check-scope (OptionParser::InvalidOption)\"\n  },\n  {\n    \"test\": \"R3-removed-trace-only\",\n    \"description\": \"移除名實不符的 trace-only\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"<驗收暫存複本>/scripts/verify-acceptance.rb:18:in `<main>': invalid option: --trace-only (OptionParser::InvalidOption)\"\n  },\n  {\n    \"test\": \"R3-missing-baseline-file\",\n    \"description\": \"git show 失敗須明確報錯\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"無法讀取基準檔 nonexistent-test-ref:rules/stacks/java/common/classes-and-construction.md：fatal: invalid object name 'nonexistent-test-ref'.\"\n  },\n  {\n    \"test\": \"R3-ambiguous-ref\",\n    \"description\": \"短參照遮蔽不得移動完整基準\",\n    \"expected_exit\": 1,\n    \"actual_exit\": 1,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"固定正文基準為 6a16349，清單 baseline 不得移動\"\n  },\n  {\n    \"test\": \"R3-record-diff\",\n    \"description\": \"紀錄器的提交範圍檢查須拒絕已提交空白錯誤\",\n    \"expected_exit\": 2,\n    \"actual_exit\": 2,\n    \"matched_expectation\": true,\n    \"diagnostic\": \"negative-whitespace.txt:1: trailing whitespace.\"\n  }\n]\n"
}
exit=0
```

## `git diff --check 6a16349..HEAD`

```text
exit=0
```
