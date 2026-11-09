# 正文整理階段 A：實際驗證紀錄

下列區塊由 Open3 擷取實際命令輸出與結束狀態，未手寫結果；測試變異在暫存複本執行。共通來源是否充分、改寫是否保留全部斷言及語意重複仍須人工審查。

## `ruby scripts/verify-body-restructuring.rb`

```text
{
  "baseline": "350668eb14ede247af22c782323beebf940c2a5f",
  "acceptance": {
    "duplicate_java_acceptance_rows": 0,
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
    ]
  },
  "historical_ids": 153,
  "java_files": 15,
  "completed": 1,
  "pending": 14,
  "body_sentences": 437,
  "preserved_acceptance_rows": 86,
  "common_change_blocks": 13,
  "local_links": 2030,
  "manual_checks": [
    "移除／改寫是否完整承接每個斷言",
    "共通來源是否足以涵蓋原要求",
    "理由與決策列是否相符",
    "語意重複與不降低要求"
  ]
}
exit=0
```

## `ruby scripts/test-body-restructuring.rb`

```text
[
  {
    "test": "乾淨複本",
    "expected_exit": 0,
    "actual_exit": 0,
    "matched": true,
    "diagnostic": "通過"
  },
  {
    "test": "未整理正文改動",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 未整理文件改動 rules/stacks/java/common/value-objects.md (RuntimeError)"
  },
  {
    "test": "共通改動未登錄",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 未登錄改動 rules/coding/nullability.md (RuntimeError)"
  },
  {
    "test": "歷史ID遺漏",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 歷史 ID 集合不完整或重複 (RuntimeError)"
  },
  {
    "test": "去向種類無效",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 去向種類無效 (RuntimeError)"
  },
  {
    "test": "基準移動",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': Java 基準不符 (RuntimeError)"
  },
  {
    "test": "逐句去向遺漏",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 基準逐句去向不完整 rules/stacks/java/common/null-and-optional.md (RuntimeError)"
  },
  {
    "test": "保留文字不在目的地",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 去向文字不存在 (RuntimeError)"
  },
  {
    "test": "錨點不存在",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 去向錨點無效 rules/stacks/java/common/null-and-optional.md#java-query-absence-不存在 (RuntimeError)"
  },
  {
    "test": "驗收列消失",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 驗收列消失 rules/stacks/java/common/null-and-optional.md (RuntimeError)"
  },
  {
    "test": "隱藏新檔",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': rules 檔案清單變更未登錄為整份併入 (RuntimeError)"
  },
  {
    "test": "追溯片段遺漏",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 驗收追溯失敗： (RuntimeError)"
  },
  {
    "test": "缺值清單白紙理由",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 句子改寫／移除理由不足 (RuntimeError)"
  },
  {
    "test": "行尾變更",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 未整理文件改動 rules/stacks/java/common/value-objects.md (RuntimeError)"
  },
  {
    "test": "同檔錯誤小節",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 去向文字不存在 (RuntimeError)"
  },
  {
    "test": "共通來源錨點錯誤",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 去向錨點無效 rules/coding/nullability.md#不存在 (RuntimeError)"
  },
  {
    "test": "分類ID換檔",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 歷史 ID 集合不完整或重複 (RuntimeError)"
  },
  {
    "test": "共通差異刪文遭竄改",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-97228-19hvz29/scripts/body-restructuring-lib.rb:43:in `block in apply': 差異區塊重疊或來源不符 (RuntimeError)"
  },
  {
    "test": "共通差異理由不足",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-97228-ehkud6/scripts/body-restructuring-lib.rb:44:in `block in apply': 差異理由不足 (RuntimeError)"
  },
  {
    "test": "共通差異沒有決策",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 共通差異缺決策列 (RuntimeError)"
  },
  {
    "test": "驗收內容偽裝條號調整",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 驗收內容不得以條號調整之名改寫 (RuntimeError)"
  },
  {
    "test": "整份併入沒有接收檔",
    "expected_exit": 1,
    "actual_exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:7:in `require_check': 整份併入種類不一致 (RuntimeError)"
  }
]
exit=0
```

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

## `git diff --check`

```text
exit=0
```

## `git diff --check 350668eb14ede247af22c782323beebf940c2a5f..HEAD`

```text
exit=0
```
