# 正文整理階段 A：實際驗證紀錄

由 `ruby scripts/record-body-verification.rb` 擷取實際命令輸出與結束狀態，未手寫結果。負向、移入格式、工作者範圍及撤回測試皆在暫存複本執行；撤回複本會納入目前 rules／docs／scripts，提交後內容即為 HEAD。常駐輸出的人工清單列出本次每個改寫或移除句子，機器不能證明語意相關或完整等價。

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
  "local_links": 2033,
  "manual_review_count": 19,
  "manual_review_sentences": [
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 1,
      "history_id": null,
      "action": "改寫",
      "source": "本文件承接[空值語意](../../../coding/nullability.md)、[型別安全](../../../coding/type-safety.md)與[錯誤處理](../../../coding/error-handling.md)，適用於自行撰寫的 Java 程式碼，包含測試與整合元件。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-null-與-optional",
          "text": "本文件承接[空值語意](../../../coding/nullability.md)、[型別安全](../../../coding/type-safety.md)、[錯誤處理](../../../coding/error-handling.md)、[資料驗證](../../../coding/validation.md)與[領域建模](../../../coding/domain-modeling.md)，適用於自行撰寫的 Java 程式碼，包含測試與整合元件。"
        }
      ],
      "removed_assertions": [

      ],
      "reason": "檔頭原有承接、適用範圍與版本／型別要求未刪；加入整份資料驗證與領域建模入口承接 JN-06，沒有以精確小節縮小整份文件引用。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 4,
      "history_id": "JN-01",
      "action": "改寫",
      "source": "依業務要求必須存在卻不存在時，表達明確的業務失敗；查詢技術故障另依錯誤處理規範傳遞，不得混為正常缺值。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-query-absence",
          "text": "依業務要求必須存在卻不存在時，表達明確的業務失敗；查詢技術故障依[錯誤處理](../../../coding/error-handling.md)傳遞，不得混為正常缺值。"
        }
      ],
      "removed_assertions": [

      ],
      "reason": "本句保留必須存在卻不存在的業務失敗條件及不得混為正常缺值；只把錯誤處理規範文字改成整份文件連結，原因保留與捕捉責任仍適用。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 6,
      "history_id": "JN-02",
      "action": "改寫",
      "source": "空的 `Optional` 只能表示契約允許的正常缺值，不得掩蓋業務失敗、技術故障或尚未確認的結果。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-optional-nonnull",
          "text": "空的 `Optional` 只能表示契約允許的正常缺值；業務失敗、技術故障及尚未確認結果的處置依[失敗分類](../../../coding/error-handling.md#失敗分類與表達)及[結果未知](../../../coding/error-handling.md#結果未知)。"
        }
      ],
      "removed_assertions": [
        {
          "text": "不得掩蓋業務失敗、技術故障或尚未確認的結果",
          "source_uri": "rules/coding/error-handling.md#失敗分類與表達",
          "source_text": "呼叫端必須處理結果，不解析錯誤文字，也不得以空值或單純 `false` 隱藏原因。"
        },
        {
          "text": "不得掩蓋業務失敗、技術故障或尚未確認的結果",
          "source_uri": "rules/coding/error-handling.md#捕捉與處置責任",
          "source_text": "不得捕捉後忽略錯誤、假裝成功，或無依據地回傳空值與預設值。"
        },
        {
          "text": "不得掩蓋業務失敗、技術故障或尚未確認的結果",
          "source_uri": "rules/coding/error-handling.md#結果未知",
          "source_text": "逾時或連線中斷只表示未取得結果，不代表對方未執行；必須區分確定失敗與結果未知，不得直接當作成功或業務失敗。"
        }
      ],
      "reason": "本句的 Optional 正常缺值限制保留；刪除的失敗掩蓋列舉由失敗分類、捕捉處置與結果未知的三段原文分別承接，已逐一登錄原文。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 8,
      "history_id": "JN-03",
      "action": "改寫",
      "source": "替代值、缺值分支與失敗處理須符合業務語意，不得掩蓋缺值或違反錯誤分類。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-optional-access",
          "text": "替代值、缺值分支與失敗處理須符合業務語意，不得掩蓋缺值；替代結果與錯誤分類依[降級與替代結果](../../../coding/error-handling.md#降級與替代結果)及[失敗分類](../../../coding/error-handling.md#失敗分類與表達)。"
        }
      ],
      "removed_assertions": [
        {
          "text": "或違反錯誤分類",
          "source_uri": "rules/coding/error-handling.md#失敗分類與表達",
          "source_text": "非預期的技術故障透過例外機制傳遞，不得偽裝成一般業務失敗。"
        }
      ],
      "reason": "本句保留替代值與缺值分支須符合業務語意，並還原不得掩蓋缺值；只將違反錯誤分類改引用共同失敗分類，沒有以掩蓋故障取代掩蓋缺值。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 9,
      "history_id": "JN-03",
      "action": "改寫",
      "source": "選用取值或拋出例外的方法本身不代表符合規範；若依已成立的不變條件必定有值，違反時須按程式缺陷處理。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-optional-access",
          "text": "選用取值或拋出例外的方法本身不代表符合規範；若依已成立的不變條件必定有值，違反時須按[程式缺陷](../../../coding/error-handling.md#程式缺陷與不變條件)處理。"
        }
      ],
      "removed_assertions": [

      ],
      "reason": "本句沒有刪除操作限制：方法名稱不足以證明合規、必定有值卻違約須當缺陷均保留；僅為程式缺陷字詞增加既有條文連結。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 12,
      "history_id": "JN-04",
      "action": "改寫",
      "source": "需要區分未提供、清空與設定值等多種狀態時，須使用能完整表達狀態的明確型別，不得以 `Optional` 混合表示。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-optional-positions",
          "text": "需要區分多種狀態時，依[空值語意](../../../coding/nullability.md#空值語意)使用能完整表達狀態的明確型別，不得以 `Optional` 混合表示。"
        }
      ],
      "removed_assertions": [
        {
          "text": "未提供、清空與設定值等",
          "source_uri": "rules/coding/nullability.md#空值語意",
          "source_text": "契約與型別必須明確表達業務需要區分的狀態，不得把未提供、明確清空與有值全部表示為同一個空值。"
        }
      ],
      "reason": "本句只移除未提供、清空與設定值的列舉，三種意圖由空值語意原文承接；完整狀態型別與不得以 Optional 混合表示仍在 Java。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 16,
      "history_id": "JN-06",
      "action": "移除",
      "source": "依[資料驗證](../../../coding/validation.md)、[錯誤處理](../../../coding/error-handling.md)、[領域建模](../../../coding/domain-modeling.md)執行。",
      "targets": [
        {
          "uri": "rules/coding/validation.md#責任分工"
        },
        {
          "uri": "rules/coding/error-handling.md#程式缺陷與不變條件"
        },
        {
          "uri": "rules/coding/domain-modeling.md#專屬型別"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[資料驗證](../../../coding/validation.md)、[錯誤處理](../../../coding/error-handling.md)、[領域建模](../../../coding/domain-modeling.md)執行。",
          "source_uri": "rules/coding/validation.md#責任分工",
          "source_text": "接收邊界負責結構與格式驗證，例如必填欄位、資料型別、日期格式與支援的狀態值。"
        },
        {
          "text": "依[資料驗證](../../../coding/validation.md)、[錯誤處理](../../../coding/error-handling.md)、[領域建模](../../../coding/domain-modeling.md)執行。",
          "source_uri": "rules/coding/error-handling.md#程式缺陷與不變條件",
          "source_text": "發現程式缺陷或內部不變條件遭破壞時，必須停止受影響操作，不得以預設值修補後繼續。"
        },
        {
          "text": "依[資料驗證](../../../coding/validation.md)、[錯誤處理](../../../coding/error-handling.md)、[領域建模](../../../coding/domain-modeling.md)執行。",
          "source_uri": "rules/coding/domain-modeling.md#專屬型別",
          "source_text": "建立時必須驗證該值的格式與適用限制，建立後不得透過任意修改破壞有效性。"
        }
      ],
      "reason": "本句的三個整份規範引用移到檔頭，沒有縮小為單一小節；承接證據分別列接收驗證、缺陷處置及建立有效的既有原文。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 17,
      "history_id": "JN-06",
      "action": "移除",
      "source": "Java 接收、建立及狀態變更位置依上述非空保證驗證；內部可靠契約已成立時不逐層重複檢查。",
      "targets": [
        {
          "uri": "rules/coding/validation.md#責任分工"
        },
        {
          "uri": "rules/coding/code-design.md#cl-06"
        },
        {
          "uri": "rules/coding/domain-modeling.md#狀態建模"
        },
        {
          "uri": "rules/coding/domain-modeling.md#專屬型別"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 接收、建立及狀態變更位置依上述非空保證驗證",
          "source_uri": "rules/coding/validation.md#責任分工",
          "source_text": "接收邊界負責結構與格式驗證，例如必填欄位、資料型別、日期格式與支援的狀態值。"
        },
        {
          "text": "Java 接收、建立及狀態變更位置依上述非空保證驗證",
          "source_uri": "rules/coding/code-design.md#cl-06",
          "source_text": "所有建立入口須一致保護必要條件，避免各自維護不一致的驗證。"
        },
        {
          "text": "Java 接收、建立及狀態變更位置依上述非空保證驗證",
          "source_uri": "rules/coding/domain-modeling.md#狀態建模",
          "source_text": "狀態轉換必須透過明確業務操作，執行必要檢查，不得任意修改狀態欄位繞過規則。"
        },
        {
          "text": "Java 接收、建立及狀態變更位置依上述非空保證驗證",
          "source_uri": "rules/coding/domain-modeling.md#專屬型別",
          "source_text": "建立時必須驗證該值的格式與適用限制，建立後不得透過任意修改破壞有效性。"
        },
        {
          "text": "內部可靠契約已成立時不逐層重複檢查",
          "source_uri": "rules/coding/validation.md#責任分工",
          "source_text": "已驗證的資料在可信內部流程傳遞時，不必每層重複檢查相同格式；業務操作仍須確認當下條件。"
        }
      ],
      "reason": "本句的接收、一般建立、專屬型別建立與狀態變更逐項登錄來源；可信內部免重查由資料驗證原句承接，未用專屬型別代替全部建立入口。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 18,
      "history_id": "JN-07",
      "action": "改寫",
      "source": "專案須統一可由工具辨識的空值契約表達方式，明訂非空預設、可空位置與適用範圍，將可自動判斷的違規納入檢查。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-null-contract-tools",
          "text": "專案須統一可由工具辨識的空值契約表達方式，明訂非空預設、可空位置與適用範圍。"
        },
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-null-contract-tools",
          "text": "可自動判斷的違規及工具缺口依[共同把關](../../../quality/rule-verification.md#au-01)納入檢查、驗證與審查。"
        }
      ],
      "removed_assertions": [
        {
          "text": "，將可自動判斷的違規納入檢查",
          "source_uri": "rules/quality/rule-verification.md#au-01",
          "source_text": "可由工具判斷的要求，必須使用適用的編譯器、靜態分析、Lint 或架構檢查執行，例如明確型別宣告、不安全轉型與依賴限制。"
        }
      ],
      "reason": "本句的工具辨識方式、非空預設、可空位置及範圍保留；可自動判斷違規納入檢查改連共同把關的工具執行原句，目的兩句合起來承接原句。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 19,
      "history_id": "JN-07",
      "action": "改寫",
      "source": "標註、文件與實際行為須一致；工具無法涵蓋的部分仍須驗證與審查，標註不能取代外部輸入的執行期驗證。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-null-contract-tools",
          "text": "可自動判斷的違規及工具缺口依[共同把關](../../../quality/rule-verification.md#au-01)納入檢查、驗證與審查。"
        },
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-null-contract-tools",
          "text": "標註、文件與實際行為須一致；標註不能取代外部輸入的執行期驗證。"
        }
      ],
      "removed_assertions": [
        {
          "text": "工具無法涵蓋的部分仍須驗證與審查，",
          "source_uri": "rules/quality/rule-verification.md#au-01",
          "source_text": "工具尚未涵蓋的要求必須列入審查清單，不能因 CI 通過就視為全部符合。"
        },
        {
          "text": "工具無法涵蓋的部分仍須驗證與審查，",
          "source_uri": "rules/quality/rule-verification.md#au-01",
          "source_text": "行為測試驗證錯誤輸入拒絕、資料轉換、空值語意、業務條件，以及 Response 不含敏感欄位等實際行為。"
        }
      ],
      "reason": "本句的標註文件行為一致及標註不能替代執行期驗證保留；工具缺口的驗證與審查移入前一句並引用共同把關，分別登錄行為測試與人工清單原文。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 21,
      "history_id": "JN-08",
      "action": "改寫",
      "source": "依[第三方空值行為的共通要求](../../../coding/nullability.md#jn-08)執行。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-third-party-optional",
          "text": "依[第三方空值行為](../../../coding/nullability.md#jn-08)確認契約；第三方明訂 `null` 是正常查無資料時，才轉成空的 `Optional`。"
        }
      ],
      "removed_assertions": [

      ],
      "reason": "本句只調整共同要求的連結文字及執行敘述，第三方空值的 jn-08 目的地未變；不把另一句的 Optional 轉換當作此句被刪政策。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 22,
      "history_id": "JN-08",
      "action": "改寫",
      "source": "第三方明訂 `null` 是正常查無資料時，才轉成空的 `Optional`；契約不明或違約的 `null` 不得擅自視為正常缺值。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-third-party-optional",
          "text": "依[第三方空值行為](../../../coding/nullability.md#jn-08)確認契約；第三方明訂 `null` 是正常查無資料時，才轉成空的 `Optional`。"
        }
      ],
      "removed_assertions": [
        {
          "text": "契約不明或違約的 `null` 不得擅自視為正常缺值",
          "source_uri": "rules/coding/nullability.md#jn-08",
          "source_text": "對方明訂 `null` 表示正常查無資料時，才轉成內部正常缺值；保證不明或違反契約的 `null`，不得直接當成非空使用，也不得擅自解讀為正常缺值。"
        }
      ],
      "reason": "本句保留正常查無資料才轉空 Optional；只刪契約不明或違約不得推測的後半，逐字承接依據為 jn-08 的保證不明或違反契約條款。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 23,
      "history_id": "JN-09",
      "action": "改寫",
      "source": "依[空值契約變更的共通要求](../../../coding/nullability.md#jn-09)執行。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-null-contract-evolution",
          "text": "依[空值契約變更](../../../coding/nullability.md#jn-09)評估相容性與使用端影響；Java 空值標註、`Optional` 使用及缺值處置須同步更新。"
        }
      ],
      "removed_assertions": [

      ],
      "reason": "本句只調整同一 jn-09 連結的顯示文字，並明說評估相容性與使用端影響，沒有將下一句的同步更新義務省略。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 24,
      "history_id": "JN-09",
      "action": "改寫",
      "source": "Java 空值標註、`Optional` 使用及缺值處置須同步更新，不因 Java 方法簽章未變就視為相容。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-null-contract-evolution",
          "text": "依[空值契約變更](../../../coding/nullability.md#jn-09)評估相容性與使用端影響；Java 空值標註、`Optional` 使用及缺值處置須同步更新。"
        }
      ],
      "removed_assertions": [
        {
          "text": "不因 Java 方法簽章未變就視為相容",
          "source_uri": "rules/coding/nullability.md#jn-09",
          "source_text": "空值契約變更須評估參數、回傳值及欄位對使用端的影響，涵蓋是否允許缺值、缺值語意、標註及實際處置；即使型別或方法簽章未變，也不得直接視為相容。"
        }
      ],
      "reason": "本句保留標註、Optional 及缺值處置同步更新；刪除的簽章未變不能視為相容，由 jn-09 即使型別或方法簽章未變的明文承接。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 25,
      "history_id": "JN-10",
      "action": "改寫",
      "source": "依[規範驗證](../../../quality/rule-verification.md)、[共通測試策略](../../../quality/testing.md)、[型別安全](../../../coding/type-safety.md)執行。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#驗收要求",
          "text": "依受影響的契約、呼叫端與邊界選擇案例；自動檢查、行為測試與人工審查共同把關，測試層級、證據及其餘事項另依[規範驗證](../../../quality/rule-verification.md)及[共通測試策略](../../../quality/testing.md)辦理。"
        },
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#驗收要求",
          "text": "不合法資料從允許承接它的邊界輸入；型別要求依[型別安全](../../../coding/type-safety.md)。"
        }
      ],
      "removed_assertions": [

      ],
      "reason": "本句的規範驗證、共通測試策略及型別安全三個引用搬至驗收引言，目的兩句分別含前兩份及型別安全，未將引用範圍縮成單一小節。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 26,
      "history_id": "JN-10",
      "action": "改寫",
      "source": "保留本文件驗收表中的 `Optional`、非空標註及實際 API 路徑案例；不合法資料從允許承接它的邊界輸入。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#驗收要求",
          "text": "不合法資料從允許承接它的邊界輸入；型別要求依[型別安全](../../../coding/type-safety.md)。"
        },
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#acceptance-java-optional-coverage",
          "text": "Optional、非空標註與實際 API 路徑均納入適用案例。"
        }
      ],
      "removed_assertions": [

      ],
      "reason": "本句的 Optional、非空標註及 API 案例由覆蓋驗收最後一句承接；非法資料從允許邊界輸入搬至引言，不隨正文入口刪除。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 29,
      "history_id": "JN-12",
      "action": "改寫",
      "source": "依[API 邊界的缺值轉換的共通要求](../../../interfaces/api-contracts.md#jn-12)執行。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-api-absence",
          "text": "Java 的 `Optional` 與內部 `null` 在 API 邊界轉換，依[API 邊界的缺值轉換](../../../interfaces/api-contracts.md#jn-12)落實對外契約。"
        }
      ],
      "removed_assertions": [

      ],
      "reason": "本句的 API jn-12 引用保留於對外契約一句，連結目的地不變；它承接共同缺值轉換規範，而非另設 Java 對外表示政策。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 30,
      "history_id": "JN-12",
      "action": "改寫",
      "source": "Java 的 `Optional` 與內部 `null` 在 API 邊界轉換；不要求對外暴露 `Optional`。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-api-absence",
          "text": "Java 的 `Optional` 與內部 `null` 在 API 邊界轉換，依[API 邊界的缺值轉換](../../../interfaces/api-contracts.md#jn-12)落實對外契約。"
        }
      ],
      "removed_assertions": [
        {
          "text": "不要求對外暴露 `Optional`",
          "source_uri": "rules/interfaces/api-contracts.md#jn-12",
          "source_text": "內部缺值型別須在 API 邊界依公開契約轉換，不直接暴露語言的缺值包裝型別，也不得由框架預設序列化行為決定對外語意。"
        }
      ],
      "reason": "本句保留 Java Optional 與內部 null 的 API 邊界轉換；不要求外露 Optional 由共同原文不直接暴露語言缺值包裝型別承接，後者較強且未放寬。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "sentence": 31,
      "history_id": "JN-12",
      "action": "改寫",
      "source": "具體序列化配置由 Framework 規範落實，不能用預設輸出代替契約。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-api-absence",
          "text": "具體序列化配置由 Framework 規範落實。"
        }
      ],
      "removed_assertions": [
        {
          "text": "不能用預設輸出代替契約",
          "source_uri": "rules/interfaces/api-contracts.md#jn-12",
          "source_text": "內部缺值型別須在 API 邊界依公開契約轉換，不直接暴露語言的缺值包裝型別，也不得由框架預設序列化行為決定對外語意。"
        }
      ],
      "reason": "本句保留 Framework 規範落實配置；不得以預設輸出代替契約由 API jn-12 不得由框架預設序列化決定對外語意的原文承接。"
    }
  ],
  "manual_limitations": [
    "即使承接原文逐字存在，是否與被刪斷言相關仍須逐項人工複核",
    "語意等價、理由充分性與語意重複無法機械證明"
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
    "expected_diagnostic": null,
    "matched": true,
    "diagnostic": "通過"
  },
  {
    "test": "N02c 刪共同驗收連結",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收非表格內容未依基準保留",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-3p4jfp/scripts/body-structure-checks.rb:12:in `check': 驗收非表格內容未依基準保留 (RuntimeError)"
  },
  {
    "test": "N02d 刪例外治理尾句",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收非表格內容未依基準保留",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-kyxtr0/scripts/body-structure-checks.rb:12:in `check': 驗收非表格內容未依基準保留 (RuntimeError)"
  },
  {
    "test": "N02f 改引言並同步目的文字",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收非表格內容未依基準保留",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-hys88x/scripts/body-structure-checks.rb:12:in `check': 驗收非表格內容未依基準保留 (RuntimeError)"
  },
  {
    "test": "N08c 整條保留改寫",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "整條保留必須逐句保留",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-128orvj/scripts/body-structure-checks.rb:12:in `check': 整條保留必須逐句保留 (RuntimeError)"
  },
  {
    "test": "N13 假整條移除",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "整條移除必須逐句移除",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-oh733e/scripts/body-structure-checks.rb:12:in `check': 整條移除必須逐句移除 (RuntimeError)"
  },
  {
    "test": "N14 ID 指錯小節",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "歷史 ID 去向與句子小節不一致",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-1m3cz1y/scripts/body-structure-checks.rb:12:in `check': 歷史 ID 去向與句子小節不一致 (RuntimeError)"
  },
  {
    "test": "N12b 保留小節新增義務",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "整條保留小節含刪改或新增句子",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-qisz9g/scripts/body-structure-checks.rb:12:in `check': 整條保留小節含刪改或新增句子 (RuntimeError)"
  },
  {
    "test": "N06b 自行新增共通清單",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "未核准的共通紀錄檔名",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 未核准的共通紀錄檔名 (RuntimeError)"
  },
  {
    "test": "N16 假完成",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "已完成紀錄仍有尚未整理去向",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-2m3igl/scripts/body-structure-checks.rb:12:in `check': 已完成紀錄仍有尚未整理去向 (RuntimeError)"
  },
  {
    "test": "N17 改寫僅貼兩字",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "改寫 text 必須為目的地完整一句",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-uv0yxo/scripts/body-structure-checks.rb:12:in `check': 改寫 text 必須為目的地完整一句 (RuntimeError)"
  },
  {
    "test": "N04 無關錨點未同步證據",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移除去向與承接證據不一致",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-1bcdr9m/scripts/body-structure-checks.rb:12:in `check': 移除去向與承接證據不一致 (RuntimeError)"
  },
  {
    "test": "未整理文件異動（動態基準夾具）",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "未整理文件改動",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 未整理文件改動 rules/stacks/java/common/version-policy.md (RuntimeError)"
  },
  {
    "test": "行尾變更（動態基準夾具）",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "未整理文件改動",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 未整理文件改動 rules/stacks/java/common/version-policy.md (RuntimeError)"
  },
  {
    "test": "未登錄共通改動",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "未登錄改動 rules/coding/nullability.md",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 未登錄改動 rules/coding/nullability.md (RuntimeError)"
  },
  {
    "test": "歷史 ID 遺漏",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "歷史 ID 集合不完整或重複",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 歷史 ID 集合不完整或重複 (RuntimeError)"
  },
  {
    "test": "去向種類無效",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "去向種類無效",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 去向種類無效 (RuntimeError)"
  },
  {
    "test": "Java 基準移動",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "Java 基準不符",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': Java 基準不符 (RuntimeError)"
  },
  {
    "test": "句子遺漏",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "基準逐句去向不完整",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 基準逐句去向不完整 rules/stacks/java/common/null-and-optional.md (RuntimeError)"
  },
  {
    "test": "去向文字不存在",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "去向文字不存在",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 去向文字不存在 (RuntimeError)"
  },
  {
    "test": "去向錨點不存在",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "去向錨點無效",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 去向錨點無效 rules/stacks/java/common/null-and-optional.md#java-query-absence-不存在 (RuntimeError)"
  },
  {
    "test": "改寫理由不足",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "句子改寫／移除理由不足",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 句子改寫／移除理由不足 (RuntimeError)"
  },
  {
    "test": "共通來源指向 Java",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "共通來源指向 Java",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 共通來源指向 Java (RuntimeError)"
  },
  {
    "test": "共通基準不符",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "共通基準不符",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 共通基準不符 (RuntimeError)"
  },
  {
    "test": "共通修改 Java",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "共通清單不得修改 Java 文件",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 共通清單不得修改 Java 文件 (RuntimeError)"
  },
  {
    "test": "共通決策缺漏",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "共通差異缺決策列",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 共通差異缺決策列 (RuntimeError)"
  },
  {
    "test": "共通來源刪文不符",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "差異區塊重疊或來源不符",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-mnszan/scripts/body-restructuring-lib.rb:43:in `block in apply': 差異區塊重疊或來源不符 (RuntimeError)"
  },
  {
    "test": "共通理由不足",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "差異理由不足",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-1kc36w/scripts/body-restructuring-lib.rb:44:in `block in apply': 差異理由不足 (RuntimeError)"
  },
  {
    "test": "狀態無效",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "整理狀態無效",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 整理狀態無效 (RuntimeError)"
  },
  {
    "test": "隱藏檔",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "rules 檔案清單變更未登錄",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': rules 檔案清單變更未登錄為整份併入 (RuntimeError)"
  },
  {
    "test": "連結檔案不存在",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "連結檔案不存在",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 連結檔案不存在 docs/negative-link.md: 不存在.md (RuntimeError)"
  },
  {
    "test": "連結錨點不存在",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "連結錨點不存在",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 連結錨點不存在 docs/negative-link.md: ../rules/coding/nullability.md#不存在 (RuntimeError)"
  },
  {
    "test": "重複錨點",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "錨點重複",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 錨點重複 docs/negative-anchor.md (RuntimeError)"
  },
  {
    "test": "移除目的地是 Java",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移除須指向共通條文",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 移除須指向共通條文 (RuntimeError)"
  },
  {
    "test": "驗收變更理由不足",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收變更來源／理由無效",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 驗收變更來源／理由無效 (RuntimeError)"
  },
  {
    "test": "驗收重複登錄",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收變更重複",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 驗收變更重複 (RuntimeError)"
  },
  {
    "test": "驗收第二欄改動",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收內容不得以條號調整之名改寫",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 驗收內容不得以條號調整之名改寫 (RuntimeError)"
  },
  {
    "test": "L13 任意表頭名稱",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收表頭不允許任意改名",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 驗收表頭不允許任意改名 (RuntimeError)"
  },
  {
    "test": "待決 153 ID 清冊缺列",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "Pending decision ID inventory changed",
    "matched": true,
    "diagnostic": "Pending decision ID inventory changed"
  },
  {
    "test": "待決 19 ID 清冊缺列",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "Pending reference ID inventory changed",
    "matched": true,
    "diagnostic": "Pending reference ID inventory changed"
  },
  {
    "test": "L2 空驗收列",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "Empty acceptance",
    "matched": true,
    "diagnostic": "Empty acceptance rules/coding/nullability.md"
  },
  {
    "test": "追溯片段遺漏",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "Missing/changed original fragments",
    "matched": true,
    "diagnostic": "Missing/changed original fragments CL-1、8"
  },
  {
    "test": "句子所屬 ID 錯誤",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "句子所屬歷史 ID 不符",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-e5iz5f/scripts/body-structure-checks.rb:12:in `check': 句子所屬歷史 ID 不符 (RuntimeError)"
  },
  {
    "test": "被刪子句不存在",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "被刪子句不在基準原句",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-twf9rv/scripts/body-structure-checks.rb:12:in `check': 被刪子句不在基準原句 (RuntimeError)"
  },
  {
    "test": "刪除子句仍在",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "被刪子句仍在現行文件",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-1n4sra3/scripts/body-structure-checks.rb:12:in `check': 被刪子句仍在現行文件 (RuntimeError)"
  },
  {
    "test": "共通承接原文不存在",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "承接原文不在共通小節",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-iac6vn/scripts/body-structure-checks.rb:12:in `check': 承接原文不在共通小節 (RuntimeError)"
  },
  {
    "test": "移除缺承接證據",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移除句缺少子句承接證據",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-1l3u3dv/scripts/body-structure-checks.rb:12:in `check': 移除句缺少子句承接證據 (RuntimeError)"
  },
  {
    "test": "未登錄新句",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "現行正文句子未登錄",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-wro5hm/scripts/body-structure-checks.rb:12:in `check': 現行正文句子未登錄 rules/stacks/java/common/null-and-optional.md: 所有查詢另須建立稽核紀錄。 (RuntimeError)"
  },
  {
    "test": "驗收任意增文",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收增文未列白名單",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-x3s7g6/scripts/body-structure-checks.rb:12:in `check': 驗收增文未列白名單 (RuntimeError)"
  },
  {
    "test": "非表格改動不是條號",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收非表格只准改條號引用",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-1kpn1qy/scripts/body-structure-checks.rb:12:in `check': 驗收非表格只准改條號引用 (RuntimeError)"
  },
  {
    "test": "整份併入種類不一致",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "整份併入種類不一致",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 整份併入種類不一致 (RuntimeError)"
  },
  {
    "test": "整份併入沒有接收檔",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "整份併入檔案狀態不符",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 整份併入檔案狀態不符 (RuntimeError)"
  },
  {
    "test": "整份併入漏完整刪文",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "整份併入未登錄完整刪文",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 整份併入未登錄完整刪文 (RuntimeError)"
  },
  {
    "test": "移入格式合法（暫存樣板承載）",
    "expected_exit": 0,
    "actual_exit": 0,
    "expected_diagnostic": null,
    "matched": true,
    "diagnostic": "通過"
  },
  {
    "test": "移入來源非共通",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移入來源必須為共通檔",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-n4g1bd/scripts/body-structure-checks.rb:12:in `check': 移入來源必須為共通檔 (RuntimeError)"
  },
  {
    "test": "移入原文不在基準",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移入原文不在固定基準",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-1ksqxah/scripts/body-structure-checks.rb:12:in `check': 移入原文不在固定基準 (RuntimeError)"
  },
  {
    "test": "移入原文未寫入",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移入原文不在 Java 目的小節",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-knnh1m/scripts/body-structure-checks.rb:12:in `check': 移入原文不在 Java 目的小節 (RuntimeError)"
  },
  {
    "test": "移入 ID 不符",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移入句所屬 ID 或小節不符",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-1oyzwng/scripts/body-structure-checks.rb:12:in `check': 移入句所屬 ID 或小節不符 (RuntimeError)"
  },
  {
    "test": "移入理由不足",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移入句理由不足",
    "matched": true,
    "diagnostic": "/private/var/folders/87/mflyspxn0lb_l1tkcmtz4qs80000gp/T/body-negative-20261109-40996-49qz6k/scripts/body-structure-checks.rb:12:in `check': 移入句理由不足 (RuntimeError)"
  },
  {
    "test": "歷史去向理由不足",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "歷史去向理由不足",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 歷史去向理由不足 (RuntimeError)"
  },
  {
    "test": "歷史去向清空",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "歷史 ID 沒有現行去向",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 歷史 ID 沒有現行去向 (RuntimeError)"
  },
  {
    "test": "句子處置無效",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "句子處置無效",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 句子處置無效 (RuntimeError)"
  },
  {
    "test": "句子去向清空",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "句子沒有去向",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 句子沒有去向 (RuntimeError)"
  },
  {
    "test": "去向不在同一小節",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "去向文字不存在",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 去向文字不存在 (RuntimeError)"
  },
  {
    "test": "非分類 Java 檔案",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "Java 文件不在原分類範圍",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': Java 文件不在原分類範圍 (RuntimeError)"
  },
  {
    "test": "隱藏共通清單",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "未核准的共通紀錄檔名",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 未核准的共通紀錄檔名 (RuntimeError)"
  },
  {
    "test": "非 JSON 共通檔",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "未核准的共通紀錄檔名",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 未核准的共通紀錄檔名 (RuntimeError)"
  },
  {
    "test": "工作者只改兩檔",
    "expected_exit": 0,
    "actual_exit": 0,
    "expected_diagnostic": "工作者範圍通過",
    "matched": true,
    "diagnostic": "{\n  \"topic\": \"null-and-optional\",\n  \"start\": \"1ff6d36239aafed05db9650265148738371123d4\",\n  \"allowed\": [\n    \"rules/stacks/java/common/null-and-optional.md\",\n    \"docs/body-restructuring/java/null-and-optional.json\"\n  ],\n  \"changed\": [\n    \"docs/body-restructuring/java/null-and-optional.json\",\n    \"rules/stacks/java/common/null-and-optional.md\"\n  ],\n  \"result\": \"工作者範圍通過\"\n}"
  },
  {
    "test": "工作者越界",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "工作者超出允許範圍：docs/java-rule-migration.md",
    "matched": true,
    "diagnostic": "工作者超出允許範圍：docs/java-rule-migration.md"
  }
]
exit=0
```

## `ruby scripts/test-body-reverts.rb`

```text
[
  {
    "commit": "b1d2f33",
    "revert_exit": 0,
    "revert_output": "[docs/java-common-separation 1f81cfb] Revert \"正式列管 CA-06 結果接收與故障保留\"\n Date: Mon Nov 9 13:46:36 2026 +0800\n 2 files changed, 2 insertions(+), 67 deletions(-)\n delete mode 100644 docs/body-restructuring/common/ca-06.json\n",
    "verification_exit": 0,
    "verification_summary": {
      "historical_ids": 153,
      "completed": 1,
      "pending": 14
    },
    "matched": true
  },
  {
    "commit": "5a16124",
    "revert_exit": 0,
    "revert_output": "[docs/java-common-separation 1bf0fe2] Revert \"正式列管 CO-08 批次失敗後狀態與適用邊界\"\n Date: Mon Nov 9 13:46:38 2026 +0800\n 3 files changed, 1 insertion(+), 54 deletions(-)\n delete mode 100644 docs/body-restructuring/common/co-08.json\n",
    "verification_exit": 0,
    "verification_summary": {
      "historical_ids": 153,
      "completed": 1,
      "pending": 14
    },
    "matched": true
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

## `git diff --cached --check`

```text
exit=0
```

## `git diff --check 350668eb14ede247af22c782323beebf940c2a5f..HEAD`

```text
exit=0
```
