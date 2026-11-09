# 驗收驗證實際輸出

本檔由 `ruby scripts/record-acceptance-verification.rb` 擷取工作區的實際標準輸出、錯誤輸出及結束碼。執行方式與人工檢查邊界見 `docs/review-remediation.md`；數字不代表語意零重複。

## `ruby scripts/verify-acceptance.rb`

```text
{
  "source": "working-tree",
  "rules_baseline": "6a1634959d922b2df5f1259cb176a731a5b5f488",
  "protected_rule_files": 55,
  "matched_approved_rule_lines": 3018,
  "explicit_change_blocks": 94,
  "completed_java_files": 15,
  "duplicate_java_acceptance_rows": 0,
  "checked_local_links": 1973,
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

## `ruby scripts/verify-acceptance.rb --batch 1`

```text
{
  "source": "working-tree",
  "rules_baseline": "6a1634959d922b2df5f1259cb176a731a5b5f488",
  "protected_rule_files": 55,
  "matched_approved_rule_lines": 3018,
  "explicit_change_blocks": 94,
  "completed_java_files": 15,
  "duplicate_java_acceptance_rows": 0,
  "checked_local_links": 1973,
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

## `ruby scripts/verify-acceptance.rb --batch 2`

```text
{
  "source": "working-tree",
  "rules_baseline": "6a1634959d922b2df5f1259cb176a731a5b5f488",
  "protected_rule_files": 55,
  "matched_approved_rule_lines": 3018,
  "explicit_change_blocks": 94,
  "completed_java_files": 15,
  "duplicate_java_acceptance_rows": 0,
  "checked_local_links": 1973,
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

## `ruby scripts/verify-acceptance.rb --batch 3`

```text
{
  "source": "working-tree",
  "rules_baseline": "6a1634959d922b2df5f1259cb176a731a5b5f488",
  "protected_rule_files": 55,
  "matched_approved_rule_lines": 3018,
  "explicit_change_blocks": 94,
  "completed_java_files": 15,
  "duplicate_java_acceptance_rows": 0,
  "checked_local_links": 1973,
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

## `ruby scripts/verify-acceptance.rb --batch 4`

```text
{
  "source": "working-tree",
  "rules_baseline": "6a1634959d922b2df5f1259cb176a731a5b5f488",
  "protected_rule_files": 55,
  "matched_approved_rule_lines": 3018,
  "explicit_change_blocks": 94,
  "completed_java_files": 15,
  "duplicate_java_acceptance_rows": 0,
  "checked_local_links": 1973,
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

## `ruby scripts/verify-acceptance.rb --batch 5`

```text
{
  "source": "working-tree",
  "rules_baseline": "6a1634959d922b2df5f1259cb176a731a5b5f488",
  "protected_rule_files": 55,
  "matched_approved_rule_lines": 3018,
  "explicit_change_blocks": 94,
  "completed_java_files": 15,
  "duplicate_java_acceptance_rows": 0,
  "checked_local_links": 1973,
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
[
  {
    "test": "T1",
    "description": "失效錨點",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Missing fragment rules/stacks/java/common/types-and-generics.md: ../../../coding/type-safety.md#acceptance-missing"
  },
  {
    "test": "T2",
    "description": "逐字重複",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Scoped duplicate acceptance: [[\"rules/stacks/java/common/types-and-generics.md\", \"核對固定結構資料是否使用明確物件；動態資料的型別、結構與驗證是否有契約，並以受影響的合法及非法輸入確認驗證有效。\"]]"
  },
  {
    "test": "T3",
    "description": "換句話說重複：僅人工可判斷",
    "expected_exit": 0,
    "actual_exit": 0,
    "matched_expectation": true,
    "diagnostic": "已在暫存清單登錄 T3；換句話說重複與理由內容仍為人工檢查項目"
  },
  {
    "test": "T4",
    "description": "追溯指錯現存列",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Trace fragment absent from destination NT-9-2: ../rules/coding/domain-modeling.md#acceptance-identity-lifecycle"
  },
  {
    "test": "T5",
    "description": "刪除核心業務政策",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Protected rule text changed rules/quality/rule-verification.md:22: - 純計算、狀態判斷與業務限制可直接建立物件測試；外部能力透過明確依賴提供測試替身，不因此強制每個類別建立介面。"
  },
  {
    "test": "T6a",
    "description": "刪除驗收尾段治理句",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Protected rule text missing rules/stacks/java/common/null-and-optional.md: 既有程式碼、工具限制與個別例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行放寬要求。"
  },
  {
    "test": "T6b",
    "description": "掏空 Java 驗收列",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Protected rule text changed rules/stacks/java/common/types-and-generics.md:47: | <a id=\"acceptance-java-explicit-types\"></a>1、9 | 略。 |"
  },
  {
    "test": "T7",
    "description": "README 政策改寫",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Protected rule text changed rules/README.md:8: - 通用規範定義共同底線，語言規範負責語法與型別使用，Framework 規範負責框架機制的落實方式。各專案自行管理實際架構、技術組合、配置與核准例外。各層可以具體化或加嚴要求，得自行降低標準。"
  },
  {
    "test": "T8",
    "description": "刪除受保護章節文字",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Protected rule text changed rules/quality/rule-verification.md:45:"
  },
  {
    "test": "T9",
    "description": "共通驗收列刪除後半斷言",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Protected rule text changed rules/quality/rule-verification.md:43: | <a id=\"acceptance-partial-operation\"></a>[多步驟與部分成功](../coding/error-handling.md#多步驟與部分成功) | 在處理中途製造適用的失敗，核對實際狀態是否符合全部成功或部分成功保證；允許部分成功時，結果須能對應已完成、未完成或結果未知的項目，集合批次修改適用同一驗收。 |"
  },
  {
    "test": "T10",
    "description": "重複錨點",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Duplicate/colliding anchor rules/stacks/java/common/types-and-generics.md"
  },
  {
    "test": "N1",
    "description": "未登錄的共通新義務",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Protected rule text changed rules/coding/type-safety.md:48: | <a id=\"acceptance-negative\"></a>新義務 | 所有語言的公開方法一律須以靜態分析工具證明參數型別完整，否則不得合併。 |"
  },
  {
    "test": "N1b",
    "description": "未登錄且沒有錨點的 Java 放寬句",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Protected rule text changed rules/stacks/java/common/types-and-generics.md:47: | 放寬 | 上列 acceptance-java 各項可由團隊自行決定是否執行，不必留存證據。 |"
  },
  {
    "test": "N7",
    "description": "目的列刪大半並以子字串登錄改寫",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Trace fragment absent from destination CL-4-1: ../rules/stacks/java/common/classes-and-construction.md#acceptance-java-construction-safety"
  },
  {
    "test": "N8",
    "description": "刪政策並登錄過短理由 x",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Invalid approved edit rules/quality/rule-verification.md:22: reason too short or blank"
  },
  {
    "test": "N8b",
    "description": "驗收分類不得刪除政策段",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Acceptance edit outside acceptance section rules/quality/rule-verification.md:22"
  },
  {
    "test": "N9",
    "description": "移動基準並清空清單",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "固定正文基準為 6a16349，清單 baseline 不得移動"
  },
  {
    "test": "N18",
    "description": "改寫理由只含空白",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Trace fragment absent from destination CL-1、8-2: ../rules/coding/code-design.md#acceptance-interface-capabilities"
  },
  {
    "test": "N19",
    "description": "任意 kind 與空白理由",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Invalid approved edit rules/README.md:11: reason too short or blank"
  },
  {
    "test": "N19b",
    "description": "充分理由仍拒絕任意 kind",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Invalid edit kind rules/README.md:11"
  },
  {
    "test": "N19c",
    "description": "editorial 不得碰表格列",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Editorial edit touches table rules/architecture/boundary-objects.md:33"
  },
  {
    "test": "R3-reason19",
    "description": "差異理由只有 19 個非空白字元",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Invalid approved edit rules/README.md:11: reason too short or blank"
  },
  {
    "test": "R3-reason-spaces",
    "description": "改寫理由 19 字加大量空白",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Invalid rewritten fragment CL-1、8-2: full destination and meaningful-length reason required"
  },
  {
    "test": "R3-body-rewrite",
    "description": "非混排 Java 正文登錄為 acceptance",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Acceptance edit outside acceptance section rules/stacks/java/common/types-and-generics.md:9"
  },
  {
    "test": "R3-body-insert",
    "description": "正文純插入登錄為 acceptance",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Acceptance edit outside acceptance section rules/stacks/java/common/types-and-generics.md:9"
  },
  {
    "test": "R3-self-heading",
    "description": "增文自帶驗收標題不得取得資格",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Acceptance edit outside acceptance section rules/stacks/java/common/types-and-generics.md:9"
  },
  {
    "test": "R3-self-subheading",
    "description": "增文自帶小標題不得取得資格",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Acceptance edit outside acceptance section rules/stacks/java/common/types-and-generics.md:9"
  },
  {
    "test": "R3-table-no-leading-pipe",
    "description": "editorial 插入無前導直線的表格列",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Editorial edit touches table rules/stacks/java/common/types-and-generics.md:43"
  },
  {
    "test": "R3-hidden-file",
    "description": "隱藏規範檔須納入檔案清單",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Rules file inventory changed: added=rules/.extra.md; removed="
  },
  {
    "test": "R3-new-file",
    "description": "新增規範檔應明確回報清單差異",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Rules file inventory changed: added=rules/coding/extra.md; removed="
  },
  {
    "test": "R3-crlf",
    "description": "CRLF 不得被逐行 chomp 忽略",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Rule line endings changed rules/stacks/java/common/types-and-generics.md"
  },
  {
    "test": "R3-final-newline",
    "description": "檔尾換行不可被忽略",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Rule final newline changed rules/stacks/java/common/types-and-generics.md"
  },
  {
    "test": "R3-pending-ids",
    "description": "待決評估不得少 NT-04",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Pending decision ID inventory changed"
  },
  {
    "test": "R3-trace-rows",
    "description": "追溯表不得少原片段",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "Missing/changed original fragments VO-1、2"
  },
  {
    "test": "R3-removed-scope",
    "description": "移除無法使用的範圍模式",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/acceptance-negative-20261109-89795-gacw33/scripts/verify-acceptance.rb:18:in `<main>': invalid option: --check-scope (OptionParser::InvalidOption)"
  },
  {
    "test": "R3-removed-trace-only",
    "description": "移除名實不符的 trace-only",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/acceptance-negative-20261109-89795-gacw33/scripts/verify-acceptance.rb:18:in `<main>': invalid option: --trace-only (OptionParser::InvalidOption)"
  },
  {
    "test": "R3-missing-baseline-file",
    "description": "git show 失敗須明確報錯",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "無法讀取基準檔 nonexistent-test-ref:rules/stacks/java/common/classes-and-construction.md：fatal: invalid object name 'nonexistent-test-ref'."
  },
  {
    "test": "R3-ambiguous-ref",
    "description": "短參照遮蔽不得移動完整基準",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched_expectation": true,
    "diagnostic": "固定正文基準為 6a16349，清單 baseline 不得移動"
  },
  {
    "test": "R3-record-diff",
    "description": "紀錄器的提交範圍檢查須拒絕已提交空白錯誤",
    "expected_exit": 2,
    "actual_exit": 2,
    "matched_expectation": true,
    "diagnostic": "negative-whitespace.txt:1: trailing whitespace."
  }
]
exit=0
```

## `git diff --check 6a16349..HEAD`

```text
exit=0
```
