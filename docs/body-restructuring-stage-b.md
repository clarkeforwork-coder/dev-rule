# 正文整理階段 B：合併與收尾紀錄

本檔保留階段 B 及第八次審閱的歷史狀態；現行連結已採語意錨點，後續指路與尾段版面以[階段 C 紀錄](body-restructuring-stage-c.md)為準。歷史的一致性觀察不代表階段 C 仍未處理。

本檔由 `ruby scripts/record-body-stage-b.rb` 讀取 git 合併紀錄、15 份去向紀錄及常駐檢查輸出產生；總表不手抄。工作者原始回報原樣保存在[原始回報](body-restructuring-stage-b-worker-reports.md)。正文基準仍為 `350668eb14ede247af22c782323beebf940c2a5f`，共同分派起點為 `7b2667c72d2163a5be9e782dec13946ed7590e90`，整合收尾起點為 `2872bb1`。

## 提交對照

| 文件 | 工作者提交 | 合併提交 |
| --- | --- | --- |
| 合併 boundary-mapping 正文整理 | 592d09b4f13f5002a2be3816ab0ea49a1df2f807 | d3524b3caa2e7b3247cbfaef8b6890d2030ebc1a |
| 合併 classes-and-construction 正文整理 | b0eef5d24cbd4457d3955ad26dd105eb67953d0a | 28cbd6336550f099cea90d8c5465fd2e4209432b |
| 合併 collections-and-ownership 正文整理 | b82cfed43af102e5dc90c73b911e982efbe9700f | 3ca3e6c3a2dd329563f1005239eb93db3733c7ac |
| 合併 concurrency-and-async 正文整理 | 195eba3d9176aac96e18df2a8ee05027222d4047 | 73de9a308baecd2879834cf91f943d86994821ee |
| 合併 equality-hashing-ordering 正文整理 | 5535796e536a3889c607c455c344a4b0cb13a80c | 36a58f5554e3e4782bea36a94d09b4198443a73a |
| 合併 exceptions-and-resources 正文整理 | 3cf18fec4b36ddef0dc067549f871d2c0816f0d7 | faa90c36c0bbd78a55496a5e20ef2f45cbebd7dd |
| 合併 lambda-and-stream 正文整理 | d45d1632e219e592c2151a5935fdce40fcd9fa62 | 0520b735e8c0cabe194cebee0598e94f1beeb327 |
| 合併 naming-packages-docs 正文整理 | 8f4fad87fb9f1fc1e80009e88eb676ca61cb5b07 | ce1c605fde62354ba16f02cf8bc461abfe449626 |
| 合併 numbers-dates-text 正文整理 | 41eefe5e6a8e3bb8680de9fce277a22e60094964 | 1496a92a9dc2ef751d8bf0fb1fdf66d49a1fb7d8 |
| 合併 reflection-and-suppression 正文整理 | 01897759ef844989ac9bf43e57d1061aa3e664e1 | e5606312451f4376636dbc128b8d071883ea7ba8 |
| 合併 states-and-results 正文整理 | 76de923c2913cf2c1c6910a8a8b7bcd1aa69bb43 | ccf1bbbbcbfe177b4ad33744cebc84d81899d04e |
| 合併 types-and-generics 正文整理 | 47c65b6769a24a6f6a188954092689553f14e055 | 9bdf4d5ffaf1a1c3caa78f63b2cd83d2ca523bb4 |
| 合併 value-objects 正文整理 | cd71a677118da43f23cf315566072963820a02b3 | cbb91859ada8a187a2292535cc26643fe74f7303 |
| 合併 version-policy 正文整理 | 57afa95ca990d6619c45f2459fafbe65611a61d6 | 2872bb135250e2e8e82e332a1b46741853a8fd76 |

## 153 條最終去向

原判斷保持原文，CA-06 與 CO-08 的核准例外仍由工具處理；正文中的歷史 ID 僅在追溯保留。

| 歷史 ID | 待決清單判斷 | 實際去向種類 | 現行 Java 或共通錨點 |
| --- | --- | --- | --- |
| BM-01 | 重述 | 整條移除 | rules/architecture/boundary-objects.md#隔離與拆分 |
| BM-02 | 重述 | 整條保留 | rules/stacks/java/common/boundary-mapping.md#java-mapping-fields |
| BM-03 | 重述 | 整條移除 | rules/architecture/data-mapping.md#mapping-responsibility |
| BM-04 | 待確認 | 整條保留 | rules/stacks/java/common/boundary-mapping.md#java-mapping-integrity |
| BM-05 | 保留條文／否 | 保留增量 | rules/stacks/java/common/boundary-mapping.md#java-update-intent |
| BM-06 | 重述 | 整條保留 | rules/stacks/java/common/boundary-mapping.md#java-mutable-isolation |
| BM-07 | 重述 | 整條保留 | rules/stacks/java/common/boundary-mapping.md#java-directional-mapping |
| BM-08 | 重述 | 整條保留 | rules/stacks/java/common/boundary-mapping.md#java-mapping-ownership |
| BM-09 | 重述 | 整條保留 | rules/stacks/java/common/boundary-mapping.md#java-mapping-verification |
| CA-01 | 重述 | 整條移除 | rules/coding/concurrency-and-async.md#task-ownership、rules/coding/concurrency-and-async.md#async-result-reception |
| CA-02 | 混合 | 整條保留 | rules/stacks/java/common/concurrency-and-async.md#java-execution-resources |
| CA-03 | 保留條文／是 | 整條保留 | rules/stacks/java/common/concurrency-and-async.md#java-visibility-sharing |
| CA-04 | 重述 | 整條移除 | rules/coding/concurrency-and-async.md#deadline-budget |
| CA-05 | 增量 | 保留增量 | rules/stacks/java/common/concurrency-and-async.md#java-cancellation-propagation |
| CA-06 | 保留條文／是 | 整條保留 | rules/stacks/java/common/concurrency-and-async.md#java-result-reception |
| CA-07 | 重述 | 整條保留 | rules/stacks/java/common/concurrency-and-async.md#java-task-completion |
| CA-08 | 重述 | 整條保留 | rules/stacks/java/common/concurrency-and-async.md#java-execution-location |
| CA-09 | 增量 | 保留增量 | rules/stacks/java/common/concurrency-and-async.md#java-context-propagation |
| CA-10 | 重述 | 整條保留 | rules/stacks/java/common/concurrency-and-async.md#java-lock-scope |
| CA-11 | 重述 | 整條保留 | rules/stacks/java/common/concurrency-and-async.md#java-controlled-shutdown |
| CA-12 | 重述 | 整條保留 | rules/stacks/java/common/concurrency-and-async.md#java-controlled-verification |
| CL-01 | 重述 | 整條保留 | rules/stacks/java/common/classes-and-construction.md#java-interface-purpose |
| CL-02 | 重述 | 整條移除 | rules/coding/code-design.md#substitutability |
| CL-03 | 重述 | 整條移除 | rules/coding/resource-lifecycle.md#initialization-readiness |
| CL-04 | 保留條文／是 | 整條保留 | rules/stacks/java/common/classes-and-construction.md#java-construction-safety |
| CL-05 | 重述 | 整條保留 | rules/stacks/java/common/classes-and-construction.md#java-explicit-dependencies |
| CL-06 | 重述 | 整條移除 | rules/coding/code-design.md#construction-entrypoints |
| CL-07 | 保留條文／可能 | 整條保留 | rules/stacks/java/common/classes-and-construction.md#java-override-scope |
| CL-08 | 重述 | 整條移除 | rules/coding/code-design.md#interface-capabilities |
| CL-09 | 重述 | 整條移除 | rules/coding/resource-lifecycle.md#shared-lifecycle |
| CL-10 | 重述 | 整條保留 | rules/stacks/java/common/classes-and-construction.md#java-lifecycle-verification |
| CO-01 | 重述 | 整條保留 | rules/stacks/java/common/collections-and-ownership.md#java-collection-ownership |
| CO-02 | 重述 | 整條保留 | rules/stacks/java/common/collections-and-ownership.md#java-snapshots-and-views |
| CO-03 | 重述 | 整條移除 | rules/coding/collections-and-ownership.md#order-and-duplicates |
| CO-04 | 重述 | 整條移除 | rules/coding/collections-and-ownership.md#traversal-mutation |
| CO-05 | 重述 | 整條移除 | rules/coding/concurrency-and-async.md#compound-atomicity |
| CO-06 | 重述 | 整條移除 | rules/quality/performance.md#bounded-accumulation |
| CO-07 | 重述 | 整條保留 | rules/stacks/java/common/collections-and-ownership.md#java-lazy-resource-lifetime |
| CO-08 | 待確認 | 整條保留 | rules/stacks/java/common/collections-and-ownership.md#java-batch-failure-state |
| CO-09 | 重述 | 整條保留 | rules/stacks/java/common/collections-and-ownership.md#java-collection-verification |
| EQ-01 | 增量 | 保留增量 | rules/stacks/java/common/equality-hashing-ordering.md#java-comparison-semantics |
| EQ-02 | 保留條文／是 | 整條保留 | rules/stacks/java/common/equality-hashing-ordering.md#java-equality-hash-contract |
| EQ-03 | 保留條文／是 | 整條保留 | rules/stacks/java/common/equality-hashing-ordering.md#java-hash-collection-stability |
| EQ-04 | 混合 | 整條保留 | rules/stacks/java/common/equality-hashing-ordering.md#java-entity-identity-lifecycle |
| EQ-05 | 保留條文／是 | 整條保留 | rules/stacks/java/common/equality-hashing-ordering.md#java-cross-type-equality |
| EQ-06 | 保留條文／可能 | 整條保留 | rules/stacks/java/common/equality-hashing-ordering.md#java-ordering-choice |
| EQ-07 | 保留條文／是 | 整條保留 | rules/stacks/java/common/equality-hashing-ordering.md#java-comparator-relations |
| EQ-08 | 保留條文／否 | 保留增量 | rules/stacks/java/common/equality-hashing-ordering.md#java-sorted-key-equivalence |
| EQ-09 | 保留條文／是 | 整條保留 | rules/stacks/java/common/equality-hashing-ordering.md#java-sorted-collection-stability |
| EQ-10 | 保留條文／否 | 保留增量 | rules/stacks/java/common/equality-hashing-ordering.md#java-relationship-coverage |
| EX-01 | 保留條文／否 | 保留增量 | rules/stacks/java/common/exceptions-and-resources.md#java-exception-classification |
| EX-02 | 保留條文／否 | 保留增量 | rules/stacks/java/common/exceptions-and-resources.md#java-checked-unchecked |
| EX-03 | 保留條文／否 | 保留增量 | rules/stacks/java/common/exceptions-and-resources.md#java-catch-scope |
| EX-04 | 保留條文／否 | 保留增量 | rules/stacks/java/common/exceptions-and-resources.md#java-interruption |
| EX-05 | 保留條文／可能 | 整條保留 | rules/stacks/java/common/exceptions-and-resources.md#java-resource-management |
| EX-06 | 保留條文／否 | 保留增量 | rules/stacks/java/common/exceptions-and-resources.md#java-suppressed-failures |
| EX-07 | 重述 | 整條移除 | rules/coding/resource-lifecycle.md#partial-acquisition |
| EX-08 | 重述 | 整條移除 | rules/coding/resource-lifecycle.md#resource-close-contract |
| EX-09 | 保留條文／否 | 保留增量 | rules/stacks/java/common/exceptions-and-resources.md#java-failure-coverage |
| JN-01 | 保留條文／否 | 保留增量 | rules/stacks/java/common/null-and-optional.md#java-query-absence |
| JN-02 | 保留條文／否 | 拆分 | rules/stacks/java/common/null-and-optional.md#java-optional-nonnull |
| JN-03 | 保留條文／否 | 拆分 | rules/stacks/java/common/null-and-optional.md#java-optional-access |
| JN-04 | 保留條文／否 | 拆分 | rules/stacks/java/common/null-and-optional.md#java-optional-positions |
| JN-05 | 保留條文／是 | 整條保留 | rules/stacks/java/common/null-and-optional.md#java-container-nulls |
| JN-06 | 重述 | 整條移除 | rules/coding/validation.md#責任分工、rules/coding/error-handling.md#程式缺陷與不變條件、rules/coding/domain-modeling.md#專屬型別、rules/coding/code-design.md#construction-entrypoints、rules/coding/domain-modeling.md#狀態建模 |
| JN-07 | 保留條文／否 | 拆分 | rules/stacks/java/common/null-and-optional.md#java-null-contract-tools |
| JN-08 | 增量 | 保留增量 | rules/stacks/java/common/null-and-optional.md#java-third-party-optional |
| JN-09 | 混合 | 拆分 | rules/stacks/java/common/null-and-optional.md#java-null-contract-evolution |
| JN-10 | 驗收入口 | 轉為驗收入口 | rules/stacks/java/common/null-and-optional.md#驗收要求 |
| JN-11 | 保留條文／是 | 整條保留 | rules/stacks/java/common/null-and-optional.md#java-nonnull-default |
| JN-12 | 混合 | 拆分 | rules/stacks/java/common/null-and-optional.md#java-api-absence |
| JT-01 | 保留條文／否 | 保留增量 | rules/stacks/java/common/types-and-generics.md#java-explicit-types |
| JT-02 | 保留條文／否 | 保留增量 | rules/stacks/java/common/types-and-generics.md#java-generic-type-information |
| JT-03 | 重述 | 整條保留 | rules/stacks/java/common/types-and-generics.md#java-input-output-type-relation |
| JT-04 | 保留條文／否 | 保留增量 | rules/stacks/java/common/types-and-generics.md#java-business-type-casts |
| JT-05 | 保留條文／否 | 保留增量 | rules/stacks/java/common/types-and-generics.md#java-type-safety-warnings |
| JT-06 | 重述 | 整條保留 | rules/stacks/java/common/types-and-generics.md#java-business-data-shape |
| JT-07 | 保留條文／否 | 保留增量 | rules/stacks/java/common/types-and-generics.md#java-generic-capabilities |
| JT-08 | 保留條文／否 | 保留增量 | rules/stacks/java/common/types-and-generics.md#java-collection-declarations |
| JT-09 | 保留條文／否 | 保留增量 | rules/stacks/java/common/types-and-generics.md#java-diamond-construction |
| JT-10 | 保留條文／否 | 保留增量 | rules/stacks/java/common/types-and-generics.md#java-generic-return-types |
| JT-11 | 保留條文／否 | 保留增量 | rules/stacks/java/common/types-and-generics.md#java-type-parameter-names |
| JV-01 | 保留條文／否 | 保留增量 | rules/stacks/java/common/version-policy.md#java-version-declarations |
| JV-02 | 保留條文／否 | 保留增量 | rules/stacks/java/common/version-policy.md#java-build-compatibility |
| JV-03 | 保留條文／否 | 保留增量 | rules/stacks/java/common/version-policy.md#java-runtime-verification |
| JV-04 | 保留條文／否 | 保留增量 | rules/stacks/java/common/version-policy.md#java-module-versions |
| JV-05 | 保留條文／否 | 保留增量 | rules/stacks/java/common/version-policy.md#java-dependency-versions |
| JV-06 | 保留條文／否 | 保留增量 | rules/stacks/java/common/version-policy.md#java-build-upgrade |
| JV-07 | 保留條文／否 | 保留增量 | rules/stacks/java/common/version-policy.md#java-preview-features |
| JV-08 | 保留條文／否 | 保留增量 | rules/stacks/java/common/version-policy.md#java-jdk-internals |
| JV-09 | 保留條文／否 | 保留增量 | rules/stacks/java/common/version-policy.md#java-deprecated-api |
| JV-10 | 保留條文／否 | 保留增量 | rules/stacks/java/common/version-policy.md#java-toolchain-compatibility |
| JV-11 | 保留條文／否 | 保留增量 | rules/stacks/java/common/version-policy.md#java-jdk-distribution |
| JV-12 | 保留條文／否 | 保留增量 | rules/stacks/java/common/version-policy.md#java-artifact-traceability |
| LS-01 | 重述 | 整條保留 | rules/stacks/java/common/lambda-and-stream.md#java-intent-readability |
| LS-02 | 保留條文／否 | 保留增量 | rules/stacks/java/common/lambda-and-stream.md#java-lambda-parameter-types |
| LS-03 | 保留條文／否 | 保留增量 | rules/stacks/java/common/lambda-and-stream.md#java-intermediate-side-effects |
| LS-04 | 保留條文／是 | 整條保留 | rules/stacks/java/common/lambda-and-stream.md#java-result-accumulation |
| LS-05 | 保留條文／否 | 保留增量 | rules/stacks/java/common/lambda-and-stream.md#java-lazy-short-circuit |
| LS-06 | 保留條文／否 | 保留增量 | rules/stacks/java/common/lambda-and-stream.md#java-parallel-stream-adoption |
| LS-07 | 保留條文／是 | 整條保留 | rules/stacks/java/common/lambda-and-stream.md#java-reduction-collection |
| LS-08 | 保留條文／否 | 保留增量 | rules/stacks/java/common/lambda-and-stream.md#java-failure-classification |
| LS-09 | 保留條文／否 | 保留增量 | rules/stacks/java/common/lambda-and-stream.md#java-stream-consumption |
| LS-10 | 保留條文／否 | 保留增量 | rules/stacks/java/common/lambda-and-stream.md#java-execution-verification |
| ND-01 | 保留條文／否 | 保留增量 | rules/stacks/java/common/naming-packages-docs.md#java-naming-form |
| ND-02 | 待補證 | 整條保留 | rules/stacks/java/common/naming-packages-docs.md#java-specific-responsibility |
| ND-03 | 保留條文／否 | 保留增量 | rules/stacks/java/common/naming-packages-docs.md#java-package-boundaries |
| ND-04 | 保留條文／否 | 保留增量 | rules/stacks/java/common/naming-packages-docs.md#java-javadoc-contract |
| ND-05 | 重述 | 整條移除 | rules/coding/code-design.md#implementation-notes |
| ND-06 | 保留條文／否 | 保留增量 | rules/stacks/java/common/naming-packages-docs.md#java-rename-impact |
| ND-07 | 增量 | 保留增量 | rules/stacks/java/common/naming-packages-docs.md#java-document-verification |
| NT-01 | 增量 | 保留增量 | rules/stacks/java/common/numbers-dates-text.md#java-numeric-representation |
| NT-02 | 增量 | 保留增量 | rules/stacks/java/common/numbers-dates-text.md#java-exact-numeric-sources |
| NT-03 | 重述 | 整條保留 | rules/stacks/java/common/numbers-dates-text.md#java-rounding-policy |
| NT-04 | 重述 | 整條移除 | rules/coding/numbers-dates-text.md#numeric-range-checks |
| NT-05 | 保留條文／否 | 保留增量 | rules/stacks/java/common/numbers-dates-text.md#java-decimal-equivalence |
| NT-06 | 增量 | 保留增量 | rules/stacks/java/common/numbers-dates-text.md#java-temporal-representation |
| NT-07 | 重述 | 整條移除 | rules/coding/numbers-dates-text.md#timezone-conversion |
| NT-08 | 增量 | 保留增量 | rules/stacks/java/common/numbers-dates-text.md#java-durations-calendar-periods |
| NT-09 | 增量 | 保留增量 | rules/stacks/java/common/numbers-dates-text.md#java-clock-source |
| NT-10 | 重述 | 整條保留 | rules/stacks/java/common/numbers-dates-text.md#java-temporal-parsing-formatting |
| NT-11 | 重述 | 整條移除 | rules/coding/numbers-dates-text.md#character-encoding |
| NT-12 | 增量 | 保留增量 | rules/stacks/java/common/numbers-dates-text.md#java-text-length-units |
| NT-13 | 重述 | 整條移除 | rules/coding/numbers-dates-text.md#text-transformations |
| NT-14 | 驗收入口 | 整條保留 | rules/stacks/java/common/numbers-dates-text.md#java-boundary-verification |
| RF-01 | 保留條文／否 | 保留增量 | rules/stacks/java/common/reflection-and-suppression.md#java-dynamic-type-contract |
| RF-02 | 重述 | 整條移除 | rules/quality/security.md#dynamic-target-authorization |
| RF-03 | 保留條文／否 | 保留增量 | rules/stacks/java/common/reflection-and-suppression.md#java-reflective-encapsulation |
| RF-04 | 重述 | 整條移除 | rules/coding/type-safety.md#dynamic-contract-validation |
| RF-05 | 混合 | 拆分 | rules/stacks/java/common/reflection-and-suppression.md#java-reflection-failure |
| RF-06 | 混合 | 整條保留 | rules/stacks/java/common/reflection-and-suppression.md#java-warning-suppression |
| RF-07 | 驗收入口 | 整條保留 | rules/stacks/java/common/reflection-and-suppression.md#java-generated-code |
| RF-08 | 驗收入口 | 整條保留 | rules/stacks/java/common/reflection-and-suppression.md#java-dynamic-verification |
| ST-01 | 保留條文／是 | 整條保留 | rules/stacks/java/common/states-and-results.md#java-explicit-state-types |
| ST-02 | 重述 | 整條保留 | rules/stacks/java/common/states-and-results.md#java-required-state-data |
| ST-03 | 重述 | 整條保留 | rules/stacks/java/common/states-and-results.md#java-business-state-transitions |
| ST-04 | 重述 | 整條移除 | rules/coding/domain-modeling.md#operation-results |
| ST-05 | 重述 | 整條保留 | rules/stacks/java/common/states-and-results.md#java-typed-business-failures |
| ST-06 | 重述 | 整條移除 | rules/coding/domain-modeling.md#exhaustive-result-handling |
| ST-07 | 保留條文／可能 | 整條保留 | rules/stacks/java/common/states-and-results.md#java-stable-external-codes |
| ST-08 | 增量 | 保留增量 | rules/stacks/java/common/states-and-results.md#java-model-extensibility |
| ST-09 | 重述 | 整條移除 | rules/coding/domain-modeling.md#result-facts |
| ST-10 | 驗收入口 | 整條保留 | rules/stacks/java/common/states-and-results.md#java-model-acceptance |
| VO-01 | 重述 | 整條移除 | rules/coding/domain-modeling.md#專屬型別 |
| VO-02 | 重述 | 整條移除 | rules/coding/domain-modeling.md#專屬型別、rules/coding/validation.md#責任分工、rules/coding/code-design.md#construction-entrypoints |
| VO-03 | 增量 | 保留增量 | rules/stacks/java/common/value-objects.md#java-value-immutability |
| VO-04 | 保留條文／否 | 保留增量 | rules/stacks/java/common/value-objects.md#java-value-equality |
| VO-05 | 混合 | 整條保留 | rules/stacks/java/common/value-objects.md#java-value-normalization |
| VO-06 | 重述 | 拆分 | rules/stacks/java/common/value-objects.md#java-value-operations |
| VO-07 | 混合 | 拆分 | rules/stacks/java/common/value-objects.md#java-value-restoration、rules/coding/domain-modeling.md#value-restoration |
| VO-08 | 保留條文／否 | 保留增量 | rules/stacks/java/common/value-objects.md#java-value-implementation |
| VO-09 | 保留條文／可能 | 整條保留 | rules/stacks/java/common/value-objects.md#java-diagnostic-representation |
| VO-10 | 驗收入口 | 整條保留 | rules/stacks/java/common/value-objects.md#java-value-test-coverage |

## 與原判斷不同的保守處置

工具列 37 條保守去向，其中五條是已核准整條保留的驗收入口；其餘 32 條如下，理由直接取目前去向 JSON（含第八次審閱還原理由）。全部依本輪決策維持，不重新刪改。

| 歷史 ID | 原判斷 | 實際去向 | 工作者理由 |
| --- | --- | --- | --- |
| BM-02 | 重述 | 整條保留 | 保守保留同名欄位與新增來源不得擴大範圍及可信欄位來源的整句；共通轉換要求未直接點明同名欄位觸發情境，不拆除部分條件。整理前原文未提交，無法證明完整覆蓋。 |
| BM-06 | 重述 | 整條保留 | 保守保留複製集合外層、符合契約的不可變值共用與不要求全面深層複製；現有邊界及程式碼設計正文未直接完整承接後兩項適用範圍，不以未列管摘要代替證據。整理前原文未提交，無法證明完整覆蓋。 |
| BM-07 | 重述 | 整條保留 | 共通 bm-07 承接反向產生判斷，但未直接規定具體工具配置另由 Framework 規範落實，故連同引用整句保留，避免遺失配置責任。 |
| BM-08 | 重述 | 整條保留 | 共通責任配置與介面原則涵蓋部分內容，但簡單映射可使用方法及不強制 Mapper 包裝層沒有同樣直接的完整原句，保守整條保留。整理前原文未提交，無法證明完整覆蓋。 |
| BM-09 | 重述 | 整條保留 | 第八次審閱 BM-09：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。 |
| CA-02 | 混合 | 整條保留 | 第八次審閱 CA-02：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。 |
| CA-06 | 保留條文／是 | 整條保留 | 共通 async-result-reception 未直接明訂忽略回傳工作控制物件的失效情境；Future、CompletableFuture 與結果鏈亦屬 Java 增量，故保守整條保留；補連結被工具判為未申報刪字，已還原原句而不改工具。 |
| CA-07 | 重述 | 整條保留 | 共通 ca-07 正文明訂完成條件與剩餘工作處置，但未直接要求驗證完成順序；不以驗收反推正文覆蓋，保守整條保留 Java 驗證要求。 |
| CA-08 | 重述 | 整條保留 | 第八次審閱 CA-08：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。 |
| CA-10 | 重述 | 整條保留 | 第八次審閱 CA-10：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。 |
| CA-11 | 重述 | 整條保留 | 共通 ca-11 明訂關閉處置及不得將開始關閉視為工作結束，但正文未直接寫出實際關閉與資源釋放依契約驗證；為保留驗證動作整條原樣留下。 |
| CA-12 | 重述 | 整條保留 | 共通 ca-12 要求同步設計審查，但未直接列出可見性設計審查；不能以同步概念推定可見性交付已涵蓋，故整條逐字保留。 |
| CL-01 | 重述 | 整條保留 | 共通介面與抽象及模組公開入口未直接明列單一實作不構成省略必要架構隔離的理由，故整條保留。整理前原文未提交，無法證明完整覆蓋。 |
| CL-05 | 重述 | 整條保留 | 共通寫需要延後或按次建立時「可注入」工廠或提供者，未直接承接 Java 原句「使用」的要求強度，故連同明確依賴與禁止隱藏查找整條保留。 |
| CL-10 | 重述 | 整條保留 | 共通明列建立條件、替代契約與框架實際配置，但未逐字明列 Java 繼承、覆寫均須驗證實際路徑，故連同單純值物件免啟完整框架整條保留。 |
| CO-01 | 重述 | 整條保留 | 第八次審閱 CO-01：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。 |
| CO-02 | 重述 | 整條保留 | 第八次審閱 CO-02：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。 |
| CO-07 | 重述 | 整條保留 | 第八次審閱 CO-07：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。 |
| CO-08 | 待確認 | 整條保留 | 第八次審閱 CO-08：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。 |
| CO-09 | 重述 | 整條保留 | 第八次審閱 CO-09：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。 |
| EQ-04 | 混合 | 整條保留 | 第八次審閱 EQ-04：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。 |
| JT-03 | 重述 | 整條保留 | 共通容器與泛型允許真實關係或解析驗證機制，未直接要求 Java 泛型簽章實際連結輸入輸出及特定業務操作不要求呼叫端轉型補回，故整條保留。整理前原文未提交，無法證明完整覆蓋。 |
| JT-06 | 重述 | 整條保留 | 共通容器與泛型禁止以任意鍵值容器替代固定結構，未直接列出 Object[] 陣列承載的禁止事項，無法確認直接涵蓋，故連同 Map 反例及動態映射明確鍵值要求整條保留。整理前原文未提交，無法證明完整覆蓋。 |
| LS-01 | 重述 | 整條保留 | 第三節判斷重述，但共通函式責任與命名原文未直接明訂 Stream 不強制取代迴圈、複雜邏輯採具名方法或清楚流程及不要求每個 Lambda 抽方法，故整條保守保留含原引用。整理前原文未提交，無法證明完整覆蓋。 |
| NT-03 | 重述 | 整條保留 | 共通 nt-03 以可能損失精度的運算為條件，Java 原句涵蓋數值運算且明禁 API 預設決定；適用範圍與禁止條件未獲同一小節直接完整承接，整條保留原文。 |
| NT-10 | 重述 | 整條保留 | 共通 nt-10 明訂必要的地區設定，Java 原句未加必要限定；無法直接證明地區設定義務的適用範圍完全一致，連同完整解析限制整條保留原文。 |
| RF-06 | 混合 | 整條保留 | 第八次審閱 RF-06：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。 |
| ST-02 | 重述 | 整條保留 | 共通狀態建模以不同狀態需要不同資料為條件，未直接寫出不得只用狀態碼搭配多個可空欄位讓使用端推測，故整條保留。整理前原文未提交，無法證明完整覆蓋。 |
| ST-03 | 重述 | 整條保留 | 共通禁止任意修改狀態欄位可涵蓋 setter 限制，但未直接明訂修改既有物件或產生新狀態物件由模型決定，故整條保留。整理前原文未提交，無法證明完整覆蓋。 |
| ST-05 | 重述 | 整條保留 | 共通要求明確結果型別及可辨識原因，未直接列不同失敗型別或具型別原因代碼選擇，且例外句限定非預期技術故障，故整條保留。整理前原文未提交，無法證明完整覆蓋。 |
| VO-05 | 混合 | 整條保留 | 第八次審閱 VO-05：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。 |
| VO-06 | 重述 | 拆分 | 專屬型別操作與邊界讀值由專屬型別及 vo-06 承接；外部政策操作原句指定領域元件，共通僅稱負責元件，責任限定未直接涵蓋故保守留下。 |

原階段 B 的 CO-08、RF-06、VO-07 皆採混合處理並保守保留 Java 句；第八次審閱後 CO-08、RF-06 的引用句亦還原，改整條保留。VO-07 未改。原始工作者理由保留於回報，最新種類以本表及 JSON 為準。

## 人工複核數量

常駐輸出共 337 項（不同類別可能涉及同一句，不是獨立義務數）。

| 類別 | 項數 |
| --- | --- |
| acceptance_additions | 3 |
| acceptance_changes | 72 |
| acceptance_text_changes | 2 |
| group_routes | 1 |
| imports | 1 |
| link_retention | 10 |
| 刪除完整性 | 19 |
| 去向種類 | 153 |
| 改寫 | 19 |
| 移除 | 57 |

機器核對原文、清冊、位置及結構；共通承接是否充分、增減限定是否改變要求、保守理由是否成立仍須人工逐句複核。已核准保留不代表已證明與共通完全等價。

## 收尾確認與 BM-04

共用遷移表及待決清單第三、四、六、七、八節的現行連結已更新；原判斷、歷史條號、歷史建議及整理前原文未提交的限制保留，第九節追加執行狀態。

- `concurrency-and-async`：- [結果接收與故障處置](../rules/coding/concurrency-and-async.md#acceptance-result-reception)。
- `collections-and-ownership`：- [失敗後狀態](../rules/coding/error-handling.md#acceptance-failure-state)。

`exceptions-and-resources` 非表格變更：

```text
原文：依第 9 條核對本次案例涵蓋受影響的 Java 故障、中斷、部分初始化與清理路徑；依賴框架的保證須經實際生命週期驗證，不只測替身或成功流程。

現文：依[失敗路徑驗收](#java-failure-coverage)核對本次案例涵蓋受影響的 Java 故障、中斷、部分初始化與清理路徑；依賴框架的保證須經實際生命週期驗證，不只測替身或成功流程。

```

`equality-hashing-ordering` 非表格變更：

```text
原文：依第 10 條，核對本次驗收同時涵蓋受影響的 Java 關係契約與實際集合操作；不能只測少數成對比較，也不能因方法由工具產生就省略驗證。

現文：依[關係與集合行為驗收](#java-relationship-coverage)，核對本次驗收同時涵蓋受影響的 Java 關係契約與實際集合操作；不能只測少數成對比較，也不能因方法由工具產生就省略驗證。

```

主檢查核對上述非表格段落只有登錄的條號替換，其餘文字逐字一致；EX 的失敗路徑驗收連向 `java-failure-coverage`（歷史 EX-09），EQ 的關係與集合驗收連向 `java-relationship-coverage`（歷史 EQ-10）。

BM-04 的 `java-mapping-integrity` 小節已逐字包含「不得略過欄位或產生不完整物件掩蓋失敗」。共通改動只刪除分號及該禁止子句：

```text
前：映射失敗依[錯誤處理](../coding/error-handling.md)及[資料驗證](../coding/validation.md)區分外部不合法資料與內部缺陷；不得略過欄位或產生不完整物件掩蓋失敗。
後：映射失敗依[錯誤處理](../coding/error-handling.md)及[資料驗證](../coding/validation.md)區分外部不合法資料與內部缺陷。
```

登錄於 `docs/body-restructuring/common/existing-sources.json` 的一／BM-04 決策，摘要後續各句未動；原 b0f13eb 收尾時 15 份 Java 文件及其 JSON 全未改，後續第八次審閱的還原另列下節。

## 第八次審閱還原

在 `1623990` 逐字還原 CA-08、CA-10、BM-09 整條；CA-02 恢復虛擬執行緒與下游容量、VO-05 恢復完整正規化句、EQ-04 恢復雜湊或排序集合契約。CO-01、CO-02、CO-07、CO-08、CO-09、RF-06 引用句移回各小節句首，這十二條均改整條保留。原因分別為共通涵蓋不夠直接、保留 Java 具名提示、恢復完整語意及就近引用。CA-01 的結果處置補登 async-result-reception；ND-05 註解維護補登 nd-05 首句。已還原句的移除斷言全部清空，引言只刪除已回到小節的多餘入口。

檢查規則與固定格式未調整；僅同步本紀錄產生器的歷史敘述。逐處位置、基準原文與前後差異見[修正紀錄](body-restructuring-review-8.md)。任務逐條點名實際涵蓋六份 Java 文件（不是驗收標準概稱的五份）；另只修改 naming-packages-docs 的 JSON 證據，該規範檔不動。L5 維持現狀，L7、L14 僅記錄，L9 至 L13、L15 留待後續。

## 工具收尾與未執行事項


R7-M4：演練使用固定分派前提交的完整 rules／docs 暫存快照與目前 scripts，自身連結與夾具一致；HEAD 的完成文件另由主檢查與負向測試驗證。R7-L12：演練起點提交使用 `--allow-empty`，乾淨 checkout 不會輸出 nothing to commit 污染 JSON。R7-L13：收尾指南要求先 checkout 工作者分支最新提交，再用協調者固定起點執行範圍檢查，不在整合分支或起點冒充工作者最終結果。

五條驗收入口 VO-10、ST-10、RF-07、RF-08、NT-14 全部已核准整條保留，不轉換。集合併檔、74 個共通歷史錨點改名、指路文字可讀性、驗收整合、CA-06／CO-08 驗收重疊與分工，全留下一階段。原合併收尾不修改 Java 文件；第八次審閱只作下節明列的還原。

併發與集合皆已完成，原提升提交的獨立撤回驗證不再適用，工具明列 applicable=false；不能據此宣稱日後可單獨撤回，必須同步處理 Java 來源與引用。原始回報的「交協調者決定」保留為歷史，五條入口與保守處置現已依本輪決策確認。

## 一致性掃描（只列出，不修改）

| 文件 | 去向分布 | 空分組指路筆數 | 引言保留連結筆數 | 結尾小節 | 三級標題數 | 引言行數 |
| --- | --- | --- | --- | --- | --- | --- |
| boundary-mapping | 整條移除 2、整條保留 6、保留增量 1 | 0 | 1 | 有 | 9 | 8 |
| classes-and-construction | 整條保留 5、整條移除 5 | 0 | 1 | 有 | 7 | 8 |
| collections-and-ownership | 整條保留 5、整條移除 4 | 1 | 1 | 有 | 7 | 8 |
| concurrency-and-async | 整條移除 2、整條保留 8、保留增量 2 | 0 | 1 | 有 | 12 | 8 |
| equality-hashing-ordering | 保留增量 3、整條保留 7 | 0 | 0 | 無 | 12 | 6 |
| exceptions-and-resources | 保留增量 6、整條保留 1、整條移除 2 | 0 | 1 | 有 | 9 | 8 |
| lambda-and-stream | 整條保留 3、保留增量 7 | 0 | 0 | 有 | 12 | 6 |
| naming-packages-docs | 保留增量 5、整條保留 1、整條移除 1 | 0 | 1 | 有 | 8 | 8 |
| null-and-optional | 保留增量 2、拆分 6、整條保留 2、整條移除 1、轉為驗收入口 1 | 0 | 0 | 有 | 12 | 6 |
| numbers-dates-text | 保留增量 7、整條保留 3、整條移除 4 | 0 | 1 | 有 | 12 | 8 |
| reflection-and-suppression | 保留增量 2、整條移除 2、拆分 1、整條保留 3 | 0 | 1 | 有 | 8 | 8 |
| states-and-results | 整條保留 6、整條移除 3、保留增量 1 | 0 | 1 | 有 | 9 | 8 |
| types-and-generics | 保留增量 9、整條保留 2 | 0 | 0 | 有 | 13 | 6 |
| value-objects | 整條移除 2、保留增量 3、整條保留 3、拆分 2 | 0 | 1 | 有 | 10 | 8 |
| version-policy | 保留增量 12 | 0 | 0 | 有 | 14 | 6 |

- 錨點皆採 `java-` 加語意字串，細粒度命名仍不同：版本以 declarations／verification 等行為命名，型別以 type-relation／shape 等概念命名，映射混合 fields／integrity／ownership；不統一或新增別名。
- 同為「重述」有整條移除、拆分、整條保留三種結果，差異由上表與保守理由說明；第四節「否」大多保留增量而原文不動，樣板部分拆分。種類名稱不能單獨代表實際刪改幅度。
- 只有集合的空分組使用固定指路文字；其餘保留的分組仍含正文。引言保留連結用共通歷史錨點或英文檔名作標籤，可讀性與原有中文引用不一致，依決策留待後續。
- 驗收第一欄仍有差異：樣板移除入口使用「覆蓋要求（原驗收入口）」，其他五條入口保留 Java 錨點；整條移除者使用共通錨點。集合無獨立 Java 驗收表，沿用共同驗收清單。
- 14 份有尾段的文件採「補充要求」及 `java-closing-requirements`；equality-hashing-ordering 基準沒有分組尾段，因此沒有另立結尾小節。基準分組中間的尾段與程式碼示例亦集中移到結尾。version-policy 範例因此離第一組較遠，屬 R7-M5 尚未處理的可讀性議題。
- 工作者指出 CA-06／CO-08 僅加連結仍遭未申報刪除診斷，已還原原句並保守處置；本輪不修改工具的正文轉換規則。
- ST-10、NT-14 等「依下方表格」的適用案例有部分實際位於共同引用；歷史 L2 問題維持原文，未因入口已核准保留而默認定位完全準確。BM-04 的部分成功入口亦留待驗收整合。
- 以上掃描是寫法及已知定位問題清單，不替代獨立審閱對 153 條斷言承接的判定。

實際命令與完整輸出見[驗證紀錄](body-restructuring-verification-results.md)。本報告及驗證紀錄均可用各自產生器重生；驗證結果採連續兩次逐位元組比對。
