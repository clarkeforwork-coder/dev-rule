# 合併前第九次審閱修正

起點 `b033bed93f7d1f80cfdabada48b294544330a05a`；正文基準 `350668eb14ede247af22c782323beebf940c2a5f`。規則修正提交 `0c4b39b`。本檔由 `scripts/record-review-nine.rb` 產生，以下每筆原文與改後文字直接取核准清單，包含四句分工、三處連結文字、驗收第一欄、兩條還原、指路句、三處驗收入口、規範驗證兩處、標題別名及索引說明。

JN-02 與 JN-06 因涵蓋不夠直接改整條保留；JN-06 原分組不再有整條移除的條文，因此原 19 句分組指路剩 18 句。固定格式為「本組由共通規範承接的要求：…。」；順序依基準原條文，同條依承接來源登錄順序去重。新增的標題別名只有資料映射一筆；規範驗證既有標題別名一併補登清冊，不重複新增錨點。

## 逐筆前後文字

### 1. `rules/coding/concurrency-and-async.md`

M1／L7：只指路，不概括本列；適用範圍仍完整依原驗收列。

原文：

```markdown
本列核對工作擁有者與責任移交；結果分類與接收路徑見[結果接收驗收](#acceptance-result-reception)。
```

改後：

```markdown
結果的分類與接收路徑另見[結果接收與故障處置驗收](#acceptance-result-reception)。
```

### 2. `rules/coding/concurrency-and-async.md`

M1／L7：只指路，不概括本列；適用範圍仍完整依原驗收列。

原文：

```markdown
本列核對結果分類與接收路徑；工作擁有者與責任移交見[工作追蹤驗收](#acceptance-task-ownership)。
```

改後：

```markdown
工作擁有者與責任移交另見[明確的工作擁有者驗收](#acceptance-task-ownership)。
```

### 3. `rules/coding/error-handling.md`

M1／L7：只指路，不概括本列；適用範圍仍完整依原驗收列。

原文：

```markdown
本列核對例外後的實際狀態；全部或部分成功及項目對應見[多步驟與部分成功驗收](#acceptance-partial-operation)。
```

改後：

```markdown
全部或部分成功及項目對應另見[多步驟與部分成功驗收](#acceptance-partial-operation)。
```

### 4. `rules/coding/error-handling.md`

M1／L7：只指路，不概括本列；適用範圍仍完整依原驗收列。

原文：

```markdown
本列核對全部或部分成功及項目對應；例外後的實際狀態見[失敗後狀態驗收](#acceptance-failure-state)。
```

改後：

```markdown
批次修改拋出例外後的狀態另見[失敗後狀態驗收](#acceptance-failure-state)。
```

### 5. `rules/quality/rule-verification.md`

L7：連結文字採目標列標題加驗收。

原文：

```markdown
[介面用途驗收]
```

改後：

```markdown
[介面與抽象驗收]
```

### 6. `rules/stacks/java/common/null-and-optional.md`

L1：驗收第一欄移除過程用語，核對內容不變。

原文：

```markdown
覆蓋要求（原驗收入口）
```

改後：

```markdown
案例覆蓋
```

### 7. `rules/stacks/java/common/null-and-optional.md`

L8：逐字還原正文基準 JN-02 的明示禁止。

原文：

```markdown
空的 `Optional` 只能表示契約允許的正常缺值；業務失敗、技術故障及尚未確認結果的處置依[失敗分類](../../../coding/error-handling.md#失敗分類與表達)及[結果未知](../../../coding/error-handling.md#結果未知)。
```

改後：

```markdown
空的 `Optional` 只能表示契約允許的正常缺值，不得掩蓋業務失敗、技術故障或尚未確認的結果。
```

### 8. `rules/stacks/java/common/null-and-optional.md`

L9：JN-06 引用句及 Java 句逐字還原，放在原第 5、7 條之間。

原文：

```markdown
<a id="java-null-contract-tools"></a>
```

改後：

```markdown
<a id="java-nonnull-validation"></a>

### 非空驗證的位置

依[資料驗證](../../../coding/validation.md)、[錯誤處理](../../../coding/error-handling.md)、[領域建模](../../../coding/domain-modeling.md)執行。Java 接收、建立及狀態變更位置依上述非空保證驗證；內部可靠契約已成立時不逐層重複檢查。

<a id="java-null-contract-tools"></a>
```

### 9. `rules/stacks/java/common/value-objects.md`

L3／L13：統一指向完整驗收章節，含共同引用及 Java 列。

原文：

```markdown
[Java 業務保證驗收](#acceptance-java-value-method-coverage)與[共通資料還原驗收](../../../coding/domain-modeling.md#acceptance-value-restoration)
```

改後：

```markdown
[本文件驗收要求](#驗收要求)
```

### 10. `rules/stacks/java/common/collections-and-ownership.md`

L3／L13：統一指向完整驗收章節，含共同引用及 Java 列。

原文：

```markdown
依下方驗收
```

改後：

```markdown
依[本文件驗收要求](#驗收要求)
```

### 11. `rules/stacks/java/common/reflection-and-suppression.md`

L3／L13：統一指向完整驗收章節，含共同引用及 Java 列。

原文：

```markdown
依下方驗收
```

改後：

```markdown
依[本文件驗收要求](#驗收要求)
```

### 12. `rules/quality/rule-verification.md`

L5：同時連共通型別要求及測試專屬要求。

原文：

```markdown
測試程式碼同樣遵守[型別安全要求](../coding/type-safety.md)。
```

改後：

```markdown
測試程式碼同樣遵守[型別安全](../coding/type-safety.md)，具體要求見[測試程式碼](#測試程式碼)。
```

### 13. `rules/architecture/data-mapping.md`

L4：同位置保留舊標題相容別名，不複製正文。

原文：

```markdown
## 相關共通契約
```

改後：

```markdown
<a id="既有共同保證的落實"></a>

## 相關共通契約
```

### 14. `rules/quality/rule-verification.md`

L6：導覽不列舉主題，避免被誤讀為完整清單；連結文字與標題一致。

原文：

```markdown
[集合與資料所有權](../coding/collections-and-ownership.md#驗收要求)、[資源生命週期](../coding/resource-lifecycle.md#驗收要求)、[併發與非同步](../coding/concurrency-and-async.md#驗收要求)、[數值、日期時間與文字](../coding/numbers-dates-text.md#驗收要求)，以及領域、映射、空值等補充契約的驗收由各自主要文件維護；[介面用途](../architecture/dependency-composition.md#acceptance-interface-purpose)與[多步驟及部分成功](../coding/error-handling.md#acceptance-partial-operation)的驗收也由各自規則檔維護。本文件保留共同把關、架構檢查與可測試性、跨情境錯誤處理，以及補償、外部整合與事件、安全、資料庫、API、可觀測性、效能、設定、依賴及 Git 等主題的驗收。

```

改後：

```markdown
[集合與資料所有權](../coding/collections-and-ownership.md#驗收要求)、[資源生命週期](../coding/resource-lifecycle.md#驗收要求)、[併發與非同步](../coding/concurrency-and-async.md#驗收要求)、[數值、日期時間與文字](../coding/numbers-dates-text.md#驗收要求)，以及領域、映射、空值等補充契約的驗收由各自主要文件維護；[介面用途](../architecture/dependency-composition.md#acceptance-interface-purpose)與[多步驟與部分成功](../coding/error-handling.md#acceptance-partial-operation)的驗收也由各自規則檔維護。其餘主題的驗收仍集中於本文件。

```

### 15. `rules/stacks/java/README.md`

L10：索引描述留存小節與共通主題的查找方式，不新增義務。

原文：

```markdown
Java 8、11、17、21 的版本差異
```

改後：

```markdown
內容欄只列各文件留存的 Java 小節，由共通承接的主題見各文件分組下的指路句與共同驗收。

Java 8、11、17、21 的版本差異
```

### 16. `rules/stacks/java/common/null-and-optional.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
## 空值限制與整合責任

本組下列要求由共通規範承接：[依需求選擇建立方式](../../../coding/code-design.md#construction-entrypoints)、[專屬型別](../../../coding/domain-modeling.md#專屬型別)、[狀態建模](../../../coding/domain-modeling.md#狀態建模)、[程式缺陷與不變條件](../../../coding/error-handling.md#程式缺陷與不變條件)、[責任分工](../../../coding/validation.md#責任分工)。


```

改後：

```markdown
## 空值限制與整合責任


```

### 17. `rules/stacks/java/common/classes-and-construction.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[繼承的可替代性](../../../coding/code-design.md#substitutability)、[必要資料與依賴齊備](../../../coding/resource-lifecycle.md#initialization-readiness)。


```

改後：

```markdown
本組由共通規範承接的要求：[繼承的可替代性](../../../coding/code-design.md#substitutability)、[必要資料與依賴齊備](../../../coding/resource-lifecycle.md#initialization-readiness)。


```

### 18. `rules/stacks/java/common/classes-and-construction.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[依需求選擇建立方式](../../../coding/code-design.md#construction-entrypoints)、[介面的能力劃分](../../../coding/code-design.md#interface-capabilities)。


```

改後：

```markdown
本組由共通規範承接的要求：[依需求選擇建立方式](../../../coding/code-design.md#construction-entrypoints)、[介面的能力劃分](../../../coding/code-design.md#interface-capabilities)。


```

### 19. `rules/stacks/java/common/classes-and-construction.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[生命週期與可變狀態相容](../../../coding/resource-lifecycle.md#shared-lifecycle)。


```

改後：

```markdown
本組由共通規範承接的要求：[生命週期與可變狀態相容](../../../coding/resource-lifecycle.md#shared-lifecycle)。


```

### 20. `rules/stacks/java/common/numbers-dates-text.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[範圍與轉換檢查](../../../coding/numbers-dates-text.md#numeric-range-checks)。


```

改後：

```markdown
本組由共通規範承接的要求：[範圍與轉換檢查](../../../coding/numbers-dates-text.md#numeric-range-checks)。


```

### 21. `rules/stacks/java/common/numbers-dates-text.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[明確的時區轉換](../../../coding/numbers-dates-text.md#timezone-conversion)。


```

改後：

```markdown
本組由共通規範承接的要求：[明確的時區轉換](../../../coding/numbers-dates-text.md#timezone-conversion)。


```

### 22. `rules/stacks/java/common/numbers-dates-text.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[明確指定字元編碼](../../../coding/numbers-dates-text.md#character-encoding)、[用途明確的文字轉換](../../../coding/numbers-dates-text.md#text-transformations)。


```

改後：

```markdown
本組由共通規範承接的要求：[明確指定字元編碼](../../../coding/numbers-dates-text.md#character-encoding)、[用途明確的文字轉換](../../../coding/numbers-dates-text.md#text-transformations)。


```

### 23. `rules/stacks/java/common/exceptions-and-resources.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[部分取得與所有權移交](../../../coding/resource-lifecycle.md#partial-acquisition)、[有效期與關閉契約](../../../coding/resource-lifecycle.md#resource-close-contract)。


```

改後：

```markdown
本組由共通規範承接的要求：[部分取得與所有權移交](../../../coding/resource-lifecycle.md#partial-acquisition)、[有效期與關閉契約](../../../coding/resource-lifecycle.md#resource-close-contract)。


```

### 24. `rules/stacks/java/common/states-and-results.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[處理完整性](../../../coding/domain-modeling.md#exhaustive-result-handling)、[結果與目前狀態分開表達](../../../coding/domain-modeling.md#operation-results)。


```

改後：

```markdown
本組由共通規範承接的要求：[結果與目前狀態分開表達](../../../coding/domain-modeling.md#operation-results)、[處理完整性](../../../coding/domain-modeling.md#exhaustive-result-handling)。


```

### 25. `rules/stacks/java/common/states-and-results.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[結果保留當時事實](../../../coding/domain-modeling.md#result-facts)。


```

改後：

```markdown
本組由共通規範承接的要求：[結果保留當時事實](../../../coding/domain-modeling.md#result-facts)。


```

### 26. `rules/stacks/java/common/concurrency-and-async.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[結果接收與故障處置](../../../coding/concurrency-and-async.md#async-result-reception)、[明確的工作擁有者](../../../coding/concurrency-and-async.md#task-ownership)。


```

改後：

```markdown
本組由共通規範承接的要求：[明確的工作擁有者](../../../coding/concurrency-and-async.md#task-ownership)、[結果接收與故障處置](../../../coding/concurrency-and-async.md#async-result-reception)。


```

### 27. `rules/stacks/java/common/concurrency-and-async.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[等待期限與逾時處置](../../../coding/concurrency-and-async.md#deadline-budget)。


```

改後：

```markdown
本組由共通規範承接的要求：[等待期限與逾時處置](../../../coding/concurrency-and-async.md#deadline-budget)。


```

### 28. `rules/stacks/java/common/collections-and-ownership.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[順序與重複資料](../../../coding/collections-and-ownership.md#order-and-duplicates)。


```

改後：

```markdown
本組由共通規範承接的要求：[順序與重複資料](../../../coding/collections-and-ownership.md#order-and-duplicates)。


```

### 29. `rules/stacks/java/common/collections-and-ownership.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[遍歷期間的修改](../../../coding/collections-and-ownership.md#traversal-mutation)、[複合操作的原子性](../../../coding/concurrency-and-async.md#compound-atomicity)。


```

改後：

```markdown
本組由共通規範承接的要求：[遍歷期間的修改](../../../coding/collections-and-ownership.md#traversal-mutation)、[複合操作的原子性](../../../coding/concurrency-and-async.md#compound-atomicity)。


```

### 30. `rules/stacks/java/common/collections-and-ownership.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[限制資料累積](../../../quality/performance.md#bounded-accumulation)。


```

改後：

```markdown
本組由共通規範承接的要求：[限制資料累積](../../../quality/performance.md#bounded-accumulation)。


```

### 31. `rules/stacks/java/common/boundary-mapping.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[隔離與拆分](../../../architecture/boundary-objects.md#隔離與拆分)、[聚焦轉換與必要驗證](../../../architecture/data-mapping.md#mapping-responsibility)。


```

改後：

```markdown
本組由共通規範承接的要求：[隔離與拆分](../../../architecture/boundary-objects.md#隔離與拆分)、[聚焦轉換與必要驗證](../../../architecture/data-mapping.md#mapping-responsibility)。


```

### 32. `rules/stacks/java/common/value-objects.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[依需求選擇建立方式](../../../coding/code-design.md#construction-entrypoints)、[專屬型別](../../../coding/domain-modeling.md#專屬型別)、[責任分工](../../../coding/validation.md#責任分工)。


```

改後：

```markdown
本組由共通規範承接的要求：[專屬型別](../../../coding/domain-modeling.md#專屬型別)、[責任分工](../../../coding/validation.md#責任分工)、[依需求選擇建立方式](../../../coding/code-design.md#construction-entrypoints)。


```

### 33. `rules/stacks/java/common/naming-packages-docs.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[實作註解與暫時處理](../../../coding/code-design.md#implementation-notes)。


```

改後：

```markdown
本組由共通規範承接的要求：[實作註解與暫時處理](../../../coding/code-design.md#implementation-notes)。


```

### 34. `rules/stacks/java/common/reflection-and-suppression.md`

L2／L13：按原條文順序與每條主要來源次序重生指路；JN-06 還原後該分組不再需指路。

原文：

```markdown
本組下列要求由共通規範承接：[使用前驗證契約](../../../coding/type-safety.md#dynamic-contract-validation)、[受控目標與授權](../../../quality/security.md#dynamic-target-authorization)。


```

改後：

```markdown
本組由共通規範承接的要求：[受控目標與授權](../../../quality/security.md#dynamic-target-authorization)、[使用前驗證契約](../../../coding/type-safety.md#dynamic-contract-validation)。


```

## 紀錄與產生器

階段 B 產生器保留開頭既有歷史狀態說明及 `<!-- 人工補記 -->` 之後的手寫內容；人工複核數量取產生當下的工具輸出，不冒充歷史數量。階段 C 第一部分保留第二部分；第二部分由自己的產生器維護，並補登規範驗證入口描述的歷史前後文。可重生部分不再混入產生器外的手改結果。

總結、別名清冊及本紀錄各有產生器；修改應改產生器。封存驗收紀錄以明列 `--target` 的舊基準執行，現行結果另由正文驗證紀錄承接。核准清單不是不可修改的鎖；保護來自審查核准清單的差異。

未處理項目依派工：L13 其餘建議、L12 待決清單各節就地標示，以及審閱報告去留。沒有自行刪除任何審閱報告。語意充分性、指代是否準確與核准清單本身仍須協調者人工複核。

## 可重跑逐句差異實際輸出

```sh
ruby scripts/verify-review-nine.rb
```

```json
{
  "start": "b033bed93f7d1f80cfdabada48b294544330a05a",
  "files": 55,
  "registered_blocks": 34,
  "all_changes_registered": true,
  "restored_verbatim": [
    "空的 `Optional` 只能表示契約允許的正常缺值，不得掩蓋業務失敗、技術故障或尚未確認的結果。",
    "依[資料驗證](../../../coding/validation.md)、[錯誤處理](../../../coding/error-handling.md)、[領域建模](../../../coding/domain-modeling.md)執行。",
    "Java 接收、建立及狀態變更位置依上述非空保證驗證；內部可靠契約已成立時不逐層重複檢查。"
  ],
  "sentence_differences": [
    {
      "path": "rules/coding/concurrency-and-async.md",
      "before": [
        "本列核對工作擁有者與責任移交；結果分類與接收路徑見[結果接收驗收](連結目標)。",
        "本列核對結果分類與接收路徑；工作擁有者與責任移交見[工作追蹤驗收](連結目標)。"
      ],
      "after": [
        "結果的分類與接收路徑另見[結果接收與故障處置驗收](連結目標)。",
        "工作擁有者與責任移交另見[明確的工作擁有者驗收](連結目標)。"
      ]
    },
    {
      "path": "rules/coding/error-handling.md",
      "before": [
        "本列核對例外後的實際狀態；全部或部分成功及項目對應見[多步驟與部分成功驗收](連結目標)。",
        "本列核對全部或部分成功及項目對應；例外後的實際狀態見[失敗後狀態驗收](連結目標)。"
      ],
      "after": [
        "全部或部分成功及項目對應另見[多步驟與部分成功驗收](連結目標)。",
        "批次修改拋出例外後的狀態另見[失敗後狀態驗收](連結目標)。"
      ]
    },
    {
      "path": "rules/quality/rule-verification.md",
      "before": [
        "介面用途的驗收見[介面用途驗收](連結目標)。",
        "測試程式碼同樣遵守[型別安全要求](連結目標)。",
        "[集合與資料所有權](連結目標)、[資源生命週期](連結目標)、[併發與非同步](連結目標)、[數值、日期時間與文字](連結目標)，以及領域、映射、空值等補充契約的驗收由各自主要文件維護；[介面用途](連結目標)與[多步驟及部分成功](連結目標)的驗收也由各自規則檔維護。",
        "本文件保留共同把關、架構檢查與可測試性、跨情境錯誤處理，以及補償、外部整合與事件、安全、資料庫、API、可觀測性、效能、設定、依賴及 Git 等主題的驗收。"
      ],
      "after": [
        "介面用途的驗收見[介面與抽象驗收](連結目標)。",
        "測試程式碼同樣遵守[型別安全](連結目標)，具體要求見[測試程式碼](連結目標)。",
        "[集合與資料所有權](連結目標)、[資源生命週期](連結目標)、[併發與非同步](連結目標)、[數值、日期時間與文字](連結目標)，以及領域、映射、空值等補充契約的驗收由各自主要文件維護；[介面用途](連結目標)與[多步驟與部分成功](連結目標)的驗收也由各自規則檔維護。",
        "其餘主題的驗收仍集中於本文件。"
      ]
    },
    {
      "path": "rules/stacks/java/README.md",
      "before": [

      ],
      "after": [
        "內容欄只列各文件留存的 Java 小節，由共通承接的主題見各文件分組下的指路句與共同驗收。"
      ]
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "before": [
        "本組下列要求由共通規範承接：[隔離與拆分](連結目標)、[聚焦轉換與必要驗證](連結目標)。"
      ],
      "after": [
        "本組由共通規範承接的要求：[隔離與拆分](連結目標)、[聚焦轉換與必要驗證](連結目標)。"
      ]
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "before": [
        "本組下列要求由共通規範承接：[繼承的可替代性](連結目標)、[必要資料與依賴齊備](連結目標)。",
        "本組下列要求由共通規範承接：[依需求選擇建立方式](連結目標)、[介面的能力劃分](連結目標)。",
        "本組下列要求由共通規範承接：[生命週期與可變狀態相容](連結目標)。"
      ],
      "after": [
        "本組由共通規範承接的要求：[繼承的可替代性](連結目標)、[必要資料與依賴齊備](連結目標)。",
        "本組由共通規範承接的要求：[依需求選擇建立方式](連結目標)、[介面的能力劃分](連結目標)。",
        "本組由共通規範承接的要求：[生命週期與可變狀態相容](連結目標)。"
      ]
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "before": [
        "本組下列要求由共通規範承接：[順序與重複資料](連結目標)。",
        "本組下列要求由共通規範承接：[遍歷期間的修改](連結目標)、[複合操作的原子性](連結目標)。",
        "本組下列要求由共通規範承接：[限制資料累積](連結目標)。",
        "Java 集合的實際修改、遍歷、檢視及資源路徑依下方驗收，不重測標準函式庫本身。"
      ],
      "after": [
        "本組由共通規範承接的要求：[順序與重複資料](連結目標)。",
        "本組由共通規範承接的要求：[遍歷期間的修改](連結目標)、[複合操作的原子性](連結目標)。",
        "本組由共通規範承接的要求：[限制資料累積](連結目標)。",
        "Java 集合的實際修改、遍歷、檢視及資源路徑依[本文件驗收要求](連結目標)，不重測標準函式庫本身。"
      ]
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "before": [
        "本組下列要求由共通規範承接：[結果接收與故障處置](連結目標)、[明確的工作擁有者](連結目標)。",
        "本組下列要求由共通規範承接：[等待期限與逾時處置](連結目標)。"
      ],
      "after": [
        "本組由共通規範承接的要求：[明確的工作擁有者](連結目標)、[結果接收與故障處置](連結目標)。",
        "本組由共通規範承接的要求：[等待期限與逾時處置](連結目標)。"
      ]
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "before": [
        "本組下列要求由共通規範承接：[部分取得與所有權移交](連結目標)、[有效期與關閉契約](連結目標)。"
      ],
      "after": [
        "本組由共通規範承接的要求：[部分取得與所有權移交](連結目標)、[有效期與關閉契約](連結目標)。"
      ]
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "before": [
        "本組下列要求由共通規範承接：[實作註解與暫時處理](連結目標)。"
      ],
      "after": [
        "本組由共通規範承接的要求：[實作註解與暫時處理](連結目標)。"
      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "before": [
        "空的 `Optional` 只能表示契約允許的正常缺值；業務失敗、技術故障及尚未確認結果的處置依[失敗分類](連結目標)及[結果未知](連結目標)。",
        "本組下列要求由共通規範承接：[依需求選擇建立方式](連結目標)、[專屬型別](連結目標)、[狀態建模](連結目標)、[程式缺陷與不變條件](連結目標)、[責任分工](連結目標)。",
        "| <a id=\"acceptance-java-optional-coverage\"></a>覆蓋要求（原驗收入口） | 核對案例覆蓋受影響的有值與缺值分類，測試資料及替身遵守型別契約，未為製造案例而關閉檢查或使用不安全轉型。"
      ],
      "after": [
        "空的 `Optional` 只能表示契約允許的正常缺值，不得掩蓋業務失敗、技術故障或尚未確認的結果。",
        "### 非空驗證的位置",
        "依[資料驗證](連結目標)、[錯誤處理](連結目標)、[領域建模](連結目標)執行。",
        "Java 接收、建立及狀態變更位置依上述非空保證驗證；內部可靠契約已成立時不逐層重複檢查。",
        "| <a id=\"acceptance-java-optional-coverage\"></a>案例覆蓋 | 核對案例覆蓋受影響的有值與缺值分類，測試資料及替身遵守型別契約，未為製造案例而關閉檢查或使用不安全轉型。"
      ]
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "before": [
        "本組下列要求由共通規範承接：[範圍與轉換檢查](連結目標)。",
        "本組下列要求由共通規範承接：[明確的時區轉換](連結目標)。",
        "本組下列要求由共通規範承接：[明確指定字元編碼](連結目標)、[用途明確的文字轉換](連結目標)。"
      ],
      "after": [
        "本組由共通規範承接的要求：[範圍與轉換檢查](連結目標)。",
        "本組由共通規範承接的要求：[明確的時區轉換](連結目標)。",
        "本組由共通規範承接的要求：[明確指定字元編碼](連結目標)、[用途明確的文字轉換](連結目標)。"
      ]
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "before": [
        "本組下列要求由共通規範承接：[使用前驗證契約](連結目標)、[受控目標與授權](連結目標)。",
        "Java 實際反射、存取及重新產生路徑依下方驗收，不只確認警告消失或成功目標能執行。"
      ],
      "after": [
        "本組由共通規範承接的要求：[受控目標與授權](連結目標)、[使用前驗證契約](連結目標)。",
        "Java 實際反射、存取及重新產生路徑依[本文件驗收要求](連結目標)，不只確認警告消失或成功目標能執行。"
      ]
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "before": [
        "本組下列要求由共通規範承接：[處理完整性](連結目標)、[結果與目前狀態分開表達](連結目標)。",
        "本組下列要求由共通規範承接：[結果保留當時事實](連結目標)。"
      ],
      "after": [
        "本組由共通規範承接的要求：[結果與目前狀態分開表達](連結目標)、[處理完整性](連結目標)。",
        "本組由共通規範承接的要求：[結果保留當時事實](連結目標)。"
      ]
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "before": [
        "本組下列要求由共通規範承接：[依需求選擇建立方式](連結目標)、[專屬型別](連結目標)、[責任分工](連結目標)。",
        "Java 的 `equals()`、`hashCode()`、`record` 自動產生方法與還原路徑依[Java 業務保證驗收](連結目標)與[共通資料還原驗收](連結目標)驗證，不機械式測試每個產生的方法。"
      ],
      "after": [
        "本組由共通規範承接的要求：[專屬型別](連結目標)、[責任分工](連結目標)、[依需求選擇建立方式](連結目標)。",
        "Java 的 `equals()`、`hashCode()`、`record` 自動產生方法與還原路徑依[本文件驗收要求](連結目標)驗證，不機械式測試每個產生的方法。"
      ]
    }
  ]
}
```
