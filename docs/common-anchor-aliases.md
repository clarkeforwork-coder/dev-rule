# 共通規則錨點相容別名

本檔由 `scripts/record-anchor-aliases.rb` 產生。74 筆歷史規則錨點逐一採用待決清單第五節建議，無名稱調整；另集中登錄兩筆標題別名。新舊錨點在同一位置，正文不複製。現行引用使用新名。別名維持保留，待儲存庫外引用確認清除後一次移除；屆時依本清冊逐筆處理，不能僅按代號樣式刪除。機器清冊為 `docs/common-anchor-aliases.json`。

## 歷史規則錨點（74 筆）

| 檔案 | 舊錨點（相容） | 新錨點（現行） |
| --- | --- | --- |
| rules/architecture/data-mapping.md | `bm-03` | [mapping-responsibility](../rules/architecture/data-mapping.md#mapping-responsibility) |
| rules/architecture/data-mapping.md | `bm-07` | [directional-mapping](../rules/architecture/data-mapping.md#directional-mapping) |
| rules/architecture/data-mapping.md | `bm-09` | [mapping-path-verification](../rules/architecture/data-mapping.md#mapping-path-verification) |
| rules/architecture/dependency-composition.md | `cl-05` | [explicit-dependencies](../rules/architecture/dependency-composition.md#explicit-dependencies) |
| rules/coding/code-design.md | `cl-02` | [substitutability](../rules/coding/code-design.md#substitutability) |
| rules/coding/code-design.md | `cl-06` | [construction-entrypoints](../rules/coding/code-design.md#construction-entrypoints) |
| rules/coding/code-design.md | `cl-08` | [interface-capabilities](../rules/coding/code-design.md#interface-capabilities) |
| rules/coding/code-design.md | `nd-05` | [implementation-notes](../rules/coding/code-design.md#implementation-notes) |
| rules/coding/collections-and-ownership.md | `co-01` | [collection-ownership](../rules/coding/collections-and-ownership.md#collection-ownership) |
| rules/coding/collections-and-ownership.md | `co-02` | [snapshots-and-views](../rules/coding/collections-and-ownership.md#snapshots-and-views) |
| rules/coding/collections-and-ownership.md | `co-03` | [order-and-duplicates](../rules/coding/collections-and-ownership.md#order-and-duplicates) |
| rules/coding/collections-and-ownership.md | `co-04` | [traversal-mutation](../rules/coding/collections-and-ownership.md#traversal-mutation) |
| rules/coding/collections-and-ownership.md | `co-09` | [collection-verification](../rules/coding/collections-and-ownership.md#collection-verification) |
| rules/coding/concurrency-and-async.md | `co-05` | [compound-atomicity](../rules/coding/concurrency-and-async.md#compound-atomicity) |
| rules/coding/concurrency-and-async.md | `ca-01` | [task-ownership](../rules/coding/concurrency-and-async.md#task-ownership) |
| rules/coding/concurrency-and-async.md | `ca-02` | [execution-resources](../rules/coding/concurrency-and-async.md#execution-resources) |
| rules/coding/concurrency-and-async.md | `ca-04` | [deadline-budget](../rules/coding/concurrency-and-async.md#deadline-budget) |
| rules/coding/concurrency-and-async.md | `ca-05` | [cancellation-and-termination](../rules/coding/concurrency-and-async.md#cancellation-and-termination) |
| rules/coding/concurrency-and-async.md | `ca-07` | [task-completion-contract](../rules/coding/concurrency-and-async.md#task-completion-contract) |
| rules/coding/concurrency-and-async.md | `ca-08` | [execution-and-blocking](../rules/coding/concurrency-and-async.md#execution-and-blocking) |
| rules/coding/concurrency-and-async.md | `ca-09` | [context-propagation](../rules/coding/concurrency-and-async.md#context-propagation) |
| rules/coding/concurrency-and-async.md | `ca-10` | [lock-scope](../rules/coding/concurrency-and-async.md#lock-scope) |
| rules/coding/domain-modeling.md | `vo-03` | [value-immutability](../rules/coding/domain-modeling.md#value-immutability) |
| rules/coding/domain-modeling.md | `vo-05` | [value-normalization](../rules/coding/domain-modeling.md#value-normalization) |
| rules/coding/domain-modeling.md | `vo-06` | [value-operations](../rules/coding/domain-modeling.md#value-operations) |
| rules/coding/domain-modeling.md | `vo-07` | [value-restoration](../rules/coding/domain-modeling.md#value-restoration) |
| rules/coding/domain-modeling.md | `st-04` | [operation-results](../rules/coding/domain-modeling.md#operation-results) |
| rules/coding/domain-modeling.md | `st-06` | [exhaustive-result-handling](../rules/coding/domain-modeling.md#exhaustive-result-handling) |
| rules/coding/domain-modeling.md | `st-08` | [model-extensibility](../rules/coding/domain-modeling.md#model-extensibility) |
| rules/coding/domain-modeling.md | `st-09` | [result-facts](../rules/coding/domain-modeling.md#result-facts) |
| rules/coding/domain-modeling.md | `st-10` | [model-verification](../rules/coding/domain-modeling.md#model-verification) |
| rules/coding/domain-modeling.md | `eq-01` | [identity-semantics](../rules/coding/domain-modeling.md#identity-semantics) |
| rules/coding/domain-modeling.md | `eq-04` | [identity-lifecycle](../rules/coding/domain-modeling.md#identity-lifecycle) |
| rules/coding/error-handling.md | `rf-05` | [dynamic-failure-classification](../rules/coding/error-handling.md#dynamic-failure-classification) |
| rules/coding/nullability.md | `jn-08` | [third-party-null-contract](../rules/coding/nullability.md#third-party-null-contract) |
| rules/coding/nullability.md | `jn-09` | [null-contract-evolution](../rules/coding/nullability.md#null-contract-evolution) |
| rules/coding/numbers-dates-text.md | `nt-01` | [numeric-representation](../rules/coding/numbers-dates-text.md#numeric-representation) |
| rules/coding/numbers-dates-text.md | `nt-02` | [exact-numeric-sources](../rules/coding/numbers-dates-text.md#exact-numeric-sources) |
| rules/coding/numbers-dates-text.md | `nt-03` | [rounding-policy](../rules/coding/numbers-dates-text.md#rounding-policy) |
| rules/coding/numbers-dates-text.md | `nt-04` | [numeric-range-checks](../rules/coding/numbers-dates-text.md#numeric-range-checks) |
| rules/coding/numbers-dates-text.md | `nt-06` | [temporal-representation](../rules/coding/numbers-dates-text.md#temporal-representation) |
| rules/coding/numbers-dates-text.md | `nt-07` | [timezone-conversion](../rules/coding/numbers-dates-text.md#timezone-conversion) |
| rules/coding/numbers-dates-text.md | `nt-08` | [durations-and-calendar-periods](../rules/coding/numbers-dates-text.md#durations-and-calendar-periods) |
| rules/coding/numbers-dates-text.md | `nt-09` | [time-source](../rules/coding/numbers-dates-text.md#time-source) |
| rules/coding/numbers-dates-text.md | `nt-10` | [temporal-parsing-formatting](../rules/coding/numbers-dates-text.md#temporal-parsing-formatting) |
| rules/coding/numbers-dates-text.md | `nt-11` | [character-encoding](../rules/coding/numbers-dates-text.md#character-encoding) |
| rules/coding/numbers-dates-text.md | `nt-12` | [text-length-units](../rules/coding/numbers-dates-text.md#text-length-units) |
| rules/coding/numbers-dates-text.md | `nt-13` | [text-transformations](../rules/coding/numbers-dates-text.md#text-transformations) |
| rules/coding/numbers-dates-text.md | `nt-14` | [data-boundary-verification](../rules/coding/numbers-dates-text.md#data-boundary-verification) |
| rules/coding/resource-lifecycle.md | `cl-03` | [initialization-readiness](../rules/coding/resource-lifecycle.md#initialization-readiness) |
| rules/coding/resource-lifecycle.md | `cl-09` | [shared-lifecycle](../rules/coding/resource-lifecycle.md#shared-lifecycle) |
| rules/coding/resource-lifecycle.md | `cl-10` | [lifecycle-verification](../rules/coding/resource-lifecycle.md#lifecycle-verification) |
| rules/coding/resource-lifecycle.md | `co-07` | [lazy-resource-lifetime](../rules/coding/resource-lifecycle.md#lazy-resource-lifetime) |
| rules/coding/resource-lifecycle.md | `ex-07` | [partial-acquisition](../rules/coding/resource-lifecycle.md#partial-acquisition) |
| rules/coding/resource-lifecycle.md | `ex-08` | [resource-close-contract](../rules/coding/resource-lifecycle.md#resource-close-contract) |
| rules/coding/resource-lifecycle.md | `ca-11` | [controlled-shutdown](../rules/coding/resource-lifecycle.md#controlled-shutdown) |
| rules/coding/type-safety.md | `rf-04` | [dynamic-contract-validation](../rules/coding/type-safety.md#dynamic-contract-validation) |
| rules/interfaces/api-contracts.md | `jn-12` | [api-absence-representation](../rules/interfaces/api-contracts.md#api-absence-representation) |
| rules/quality/performance.md | `co-06` | [bounded-accumulation](../rules/quality/performance.md#bounded-accumulation) |
| rules/quality/rule-verification.md | `au-01` | [verification-coverage](../rules/quality/rule-verification.md#verification-coverage) |
| rules/quality/rule-verification.md | `rf-08` | [dynamic-control-verification](../rules/quality/rule-verification.md#dynamic-control-verification) |
| rules/quality/rule-verification.md | `nd-07` | [document-verification](../rules/quality/rule-verification.md#document-verification) |
| rules/quality/rule-verification.md | `au-02` | [reproducible-check-configuration](../rules/quality/rule-verification.md#reproducible-check-configuration) |
| rules/quality/rule-verification.md | `au-03` | [actual-check-scope](../rules/quality/rule-verification.md#actual-check-scope) |
| rules/quality/rule-verification.md | `au-04` | [check-configuration-validation](../rules/quality/rule-verification.md#check-configuration-validation) |
| rules/quality/rule-verification.md | `au-06` | [evidence-version-validity](../rules/quality/rule-verification.md#evidence-version-validity) |
| rules/quality/rule-verification.md | `au-08` | [diagnostic-classification](../rules/quality/rule-verification.md#diagnostic-classification) |
| rules/quality/rule-verification.md | `au-09` | [effective-merge-gates](../rules/quality/rule-verification.md#effective-merge-gates) |
| rules/quality/security.md | `rf-02` | [dynamic-target-authorization](../rules/quality/security.md#dynamic-target-authorization) |
| rules/quality/testing.md | `ca-12` | [controlled-interleaving](../rules/quality/testing.md#controlled-interleaving) |
| rules/workflow/git-pr-review.md | `au-07` | [automated-fix-review](../rules/workflow/git-pr-review.md#automated-fix-review) |
| rules/workflow/rule-governance.md | `rf-06` | [suppression-scope](../rules/workflow/rule-governance.md#suppression-scope) |
| rules/workflow/rule-governance.md | `rf-07` | [generated-code-exceptions](../rules/workflow/rule-governance.md#generated-code-exceptions) |
| rules/workflow/rule-governance.md | `au-05` | [precise-violation-baseline](../rules/workflow/rule-governance.md#precise-violation-baseline) |

## 標題相容別名（2 筆）

資料映射的舊標題別名在第九次審閱後補入；規範驗證的別名原已存在，這次補登集中清冊。

| 檔案 | 舊錨點（相容） | 新錨點（現行） |
| --- | --- | --- |
| rules/architecture/data-mapping.md | `既有共同保證的落實` | [相關共通契約](../rules/architecture/data-mapping.md#相關共通契約) |
| rules/quality/rule-verification.md | `語言與新增共通主題驗收入口` | [語言與共通主題驗收入口](../rules/quality/rule-verification.md#語言與共通主題驗收入口) |
