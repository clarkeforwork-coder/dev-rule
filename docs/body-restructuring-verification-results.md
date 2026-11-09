# 正文整理階段 A：實際驗證紀錄

由 `ruby scripts/record-body-verification.rb` 擷取實際命令輸出與結束狀態，未手寫結果。負向、移入格式、工作者範圍及撤回測試皆在暫存複本執行；撤回複本會納入目前 rules／docs／scripts，提交後內容即為 HEAD。常駐輸出的人工清單列出本次每個改寫或移除句子及種類、移入、指路、引用與驗收變更，機器不能證明語意相關或完整等價。

## `ruby scripts/verify-body-restructuring.rb`

```text
{
  "rule_dispositions": [
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "status": "completed",
      "id": "JN-01",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "status": "completed",
      "id": "JN-02",
      "decision": "保留條文／否",
      "kind": "拆分"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "status": "completed",
      "id": "JN-03",
      "decision": "保留條文／否",
      "kind": "拆分"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "status": "completed",
      "id": "JN-04",
      "decision": "保留條文／否",
      "kind": "拆分"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "status": "completed",
      "id": "JN-05",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "status": "completed",
      "id": "JN-06",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "status": "completed",
      "id": "JN-07",
      "decision": "保留條文／否",
      "kind": "拆分"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "status": "completed",
      "id": "JN-08",
      "decision": "增量",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "status": "completed",
      "id": "JN-09",
      "decision": "混合",
      "kind": "拆分"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "status": "completed",
      "id": "JN-10",
      "decision": "驗收入口",
      "kind": "轉為驗收入口"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "status": "completed",
      "id": "JN-11",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "status": "completed",
      "id": "JN-12",
      "decision": "混合",
      "kind": "拆分"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "pending",
      "id": "JV-01",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "pending",
      "id": "JV-02",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "pending",
      "id": "JV-03",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "pending",
      "id": "JV-04",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "pending",
      "id": "JV-05",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "pending",
      "id": "JV-06",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "pending",
      "id": "JV-07",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "pending",
      "id": "JV-08",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "pending",
      "id": "JV-09",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "pending",
      "id": "JV-10",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "pending",
      "id": "JV-11",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "pending",
      "id": "JV-12",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "pending",
      "id": "LS-01",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "pending",
      "id": "LS-02",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "pending",
      "id": "LS-03",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "pending",
      "id": "LS-04",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "pending",
      "id": "LS-05",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "pending",
      "id": "LS-06",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "pending",
      "id": "LS-07",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "pending",
      "id": "LS-08",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "pending",
      "id": "LS-09",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "pending",
      "id": "LS-10",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "pending",
      "id": "CL-01",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "pending",
      "id": "CL-02",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "pending",
      "id": "CL-03",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "pending",
      "id": "CL-04",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "pending",
      "id": "CL-05",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "pending",
      "id": "CL-06",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "pending",
      "id": "CL-07",
      "decision": "保留條文／可能",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "pending",
      "id": "CL-08",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "pending",
      "id": "CL-09",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "pending",
      "id": "CL-10",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "pending",
      "id": "NT-01",
      "decision": "增量",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "pending",
      "id": "NT-02",
      "decision": "增量",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "pending",
      "id": "NT-03",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "pending",
      "id": "NT-04",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "pending",
      "id": "NT-05",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "pending",
      "id": "NT-06",
      "decision": "增量",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "pending",
      "id": "NT-07",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "pending",
      "id": "NT-08",
      "decision": "增量",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "pending",
      "id": "NT-09",
      "decision": "增量",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "pending",
      "id": "NT-10",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "pending",
      "id": "NT-11",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "pending",
      "id": "NT-12",
      "decision": "增量",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "pending",
      "id": "NT-13",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "pending",
      "id": "NT-14",
      "decision": "驗收入口",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "pending",
      "id": "EX-01",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "pending",
      "id": "EX-02",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "pending",
      "id": "EX-03",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "pending",
      "id": "EX-04",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "pending",
      "id": "EX-05",
      "decision": "保留條文／可能",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "pending",
      "id": "EX-06",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "pending",
      "id": "EX-07",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "pending",
      "id": "EX-08",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "pending",
      "id": "EX-09",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "pending",
      "id": "ST-01",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "pending",
      "id": "ST-02",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "pending",
      "id": "ST-03",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "pending",
      "id": "ST-04",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "pending",
      "id": "ST-05",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "pending",
      "id": "ST-06",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "pending",
      "id": "ST-07",
      "decision": "保留條文／可能",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "pending",
      "id": "ST-08",
      "decision": "增量",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "pending",
      "id": "ST-09",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "pending",
      "id": "ST-10",
      "decision": "驗收入口",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "pending",
      "id": "CA-01",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "pending",
      "id": "CA-02",
      "decision": "混合",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "pending",
      "id": "CA-03",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "pending",
      "id": "CA-04",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "pending",
      "id": "CA-05",
      "decision": "增量",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "pending",
      "id": "CA-06",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "pending",
      "id": "CA-07",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "pending",
      "id": "CA-08",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "pending",
      "id": "CA-09",
      "decision": "增量",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "pending",
      "id": "CA-10",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "pending",
      "id": "CA-11",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "pending",
      "id": "CA-12",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "pending",
      "id": "CO-01",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "pending",
      "id": "CO-02",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "pending",
      "id": "CO-03",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "pending",
      "id": "CO-04",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "pending",
      "id": "CO-05",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "pending",
      "id": "CO-06",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "pending",
      "id": "CO-07",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "pending",
      "id": "CO-08",
      "decision": "待確認",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "pending",
      "id": "CO-09",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "pending",
      "id": "BM-01",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "pending",
      "id": "BM-02",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "pending",
      "id": "BM-03",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "pending",
      "id": "BM-04",
      "decision": "待確認",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "pending",
      "id": "BM-05",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "pending",
      "id": "BM-06",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "pending",
      "id": "BM-07",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "pending",
      "id": "BM-08",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "pending",
      "id": "BM-09",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "pending",
      "id": "VO-01",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "pending",
      "id": "VO-02",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "pending",
      "id": "VO-03",
      "decision": "增量",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "pending",
      "id": "VO-04",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "pending",
      "id": "VO-05",
      "decision": "混合",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "pending",
      "id": "VO-06",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "pending",
      "id": "VO-07",
      "decision": "混合",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "pending",
      "id": "VO-08",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "pending",
      "id": "VO-09",
      "decision": "保留條文／可能",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "pending",
      "id": "VO-10",
      "decision": "驗收入口",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "pending",
      "id": "EQ-01",
      "decision": "增量",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "pending",
      "id": "EQ-02",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "pending",
      "id": "EQ-03",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "pending",
      "id": "EQ-04",
      "decision": "混合",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "pending",
      "id": "EQ-05",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "pending",
      "id": "EQ-06",
      "decision": "保留條文／可能",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "pending",
      "id": "EQ-07",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "pending",
      "id": "EQ-08",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "pending",
      "id": "EQ-09",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "pending",
      "id": "EQ-10",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "status": "pending",
      "id": "ND-01",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "status": "pending",
      "id": "ND-02",
      "decision": "待補證",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "status": "pending",
      "id": "ND-03",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "status": "pending",
      "id": "ND-04",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "status": "pending",
      "id": "ND-05",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "status": "pending",
      "id": "ND-06",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "status": "pending",
      "id": "ND-07",
      "decision": "增量",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "pending",
      "id": "JT-01",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "pending",
      "id": "JT-02",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "pending",
      "id": "JT-03",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "pending",
      "id": "JT-04",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "pending",
      "id": "JT-05",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "pending",
      "id": "JT-06",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "pending",
      "id": "JT-07",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "pending",
      "id": "JT-08",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "pending",
      "id": "JT-09",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "pending",
      "id": "JT-10",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "pending",
      "id": "JT-11",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "pending",
      "id": "RF-01",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "pending",
      "id": "RF-02",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "pending",
      "id": "RF-03",
      "decision": "保留條文／否",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "pending",
      "id": "RF-04",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "pending",
      "id": "RF-05",
      "decision": "混合",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "pending",
      "id": "RF-06",
      "decision": "混合",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "pending",
      "id": "RF-07",
      "decision": "驗收入口",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "pending",
      "id": "RF-08",
      "decision": "驗收入口",
      "kind": "整條保留"
    }
  ],
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
  "local_links": 2042,
  "manual_review_count": 55,
  "manual_review_sentences": [
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "去向種類",
      "history_id": "JN-01",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/null-and-optional.md#java-query-absence"
      ],
      "reason": "JN-01：；本句保留必須存在卻不存在的業務失敗條件及不得混為正常缺值；只把錯誤處理規範文字改成整份文件連結，原因保留與捕捉責任仍適用。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "去向種類",
      "history_id": "JN-02",
      "decision": "保留條文／否",
      "expected": "拆分",
      "actual": "拆分",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/null-and-optional.md#java-optional-nonnull"
      ],
      "reason": "JN-02：；本句的 Optional 正常缺值限制保留；刪除的失敗掩蓋列舉由失敗分類、捕捉處置與結果未知的三段原文分別承接，已逐一登錄原文。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "去向種類",
      "history_id": "JN-03",
      "decision": "保留條文／否",
      "expected": "拆分",
      "actual": "拆分",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/null-and-optional.md#java-optional-access"
      ],
      "reason": "JN-03：；本句保留替代值與缺值分支須符合業務語意，並還原不得掩蓋缺值；只將違反錯誤分類改引用共同失敗分類，沒有以掩蓋故障取代掩蓋缺值。；本句沒有刪除操作限制：方法名稱不足以證明合規、必定有值卻違約須當缺陷均保留；僅為程式缺陷字詞增加既有條文連結。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "去向種類",
      "history_id": "JN-04",
      "decision": "保留條文／否",
      "expected": "拆分",
      "actual": "拆分",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/null-and-optional.md#java-optional-positions"
      ],
      "reason": "JN-04：；本句只移除未提供、清空與設定值的列舉，三種意圖由空值語意原文承接；完整狀態型別與不得以 Optional 混合表示仍在 Java。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "去向種類",
      "history_id": "JN-05",
      "decision": "保留條文／是",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/null-and-optional.md#java-container-nulls"
      ],
      "reason": "JN-05 依第四節新義務判斷整條保留；基準全部句子逐字留在各自 Java 小節，不抽取共同背景。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "去向種類",
      "history_id": "JN-06",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/validation.md#責任分工",
        "rules/coding/error-handling.md#程式缺陷與不變條件",
        "rules/coding/domain-modeling.md#專屬型別",
        "rules/coding/code-design.md#cl-06",
        "rules/coding/domain-modeling.md#狀態建模"
      ],
      "reason": "JN-06：本句的三個整份規範引用移到檔頭，沒有縮小為單一小節；承接證據分別列接收驗證、缺陷處置及建立有效的既有原文。整理前原文未提交，無法證明完整覆蓋。；本句的接收、一般建立、專屬型別建立與狀態變更逐項登錄來源；可信內部免重查由資料驗證原句承接，未用專屬型別代替全部建立入口。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "去向種類",
      "history_id": "JN-07",
      "decision": "保留條文／否",
      "expected": "拆分",
      "actual": "拆分",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/null-and-optional.md#java-null-contract-tools"
      ],
      "reason": "JN-07：本句的工具辨識方式、非空預設、可空位置及範圍保留；可自動判斷違規納入檢查改連共同把關的工具執行原句，目的兩句合起來承接原句。；本句的標註文件行為一致及標註不能替代執行期驗證保留；工具缺口的驗證與審查移入前一句並引用共同把關，分別登錄行為測試與人工清單原文。；"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "去向種類",
      "history_id": "JN-08",
      "decision": "增量",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/null-and-optional.md#java-third-party-optional"
      ],
      "reason": "JN-08：本句只調整共同要求的連結文字及執行敘述，第三方空值的 jn-08 目的地未變；不把另一句的 Optional 轉換當作此句被刪政策。；本句保留正常查無資料才轉空 Optional；只刪契約不明或違約不得推測的後半，逐字承接依據為 jn-08 的保證不明或違反契約條款。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "去向種類",
      "history_id": "JN-09",
      "decision": "混合",
      "expected": "拆分",
      "actual": "拆分",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/null-and-optional.md#java-null-contract-evolution"
      ],
      "reason": "JN-09：本句只調整同一 jn-09 連結的顯示文字，並明說評估相容性與使用端影響，沒有將下一句的同步更新義務省略。；本句保留標註、Optional 及缺值處置同步更新；刪除的簽章未變不能視為相容，由 jn-09 即使型別或方法簽章未變的明文承接。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "去向種類",
      "history_id": "JN-10",
      "decision": "驗收入口",
      "expected": "轉為驗收入口",
      "actual": "轉為驗收入口",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/null-and-optional.md#驗收要求"
      ],
      "reason": "JN-10：本句的規範驗證、共通測試策略及型別安全三個引用搬至驗收引言，目的兩句分別含前兩份及型別安全，未將引用範圍縮成單一小節。整理前原文未提交，無法證明完整覆蓋。；本句的 Optional、非空標註及 API 案例由覆蓋驗收最後一句承接；非法資料從允許邊界輸入搬至引言，不隨正文入口刪除。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "去向種類",
      "history_id": "JN-11",
      "decision": "保留條文／是",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/null-and-optional.md#java-nonnull-default"
      ],
      "reason": "JN-11 依第四節新義務判斷整條保留；基準全部句子逐字留在各自 Java 小節，不抽取共同背景。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "去向種類",
      "history_id": "JN-12",
      "decision": "混合",
      "expected": "拆分",
      "actual": "拆分",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/null-and-optional.md#java-api-absence"
      ],
      "reason": "JN-12：本句的 API jn-12 引用保留於對外契約一句，連結目的地不變；它承接共同缺值轉換規範，而非另設 Java 對外表示政策。；本句保留 Java Optional 與內部 null 的 API 邊界轉換；不要求外露 Optional 由共同原文不直接暴露語言缺值包裝型別承接，後者較強且未放寬。；本句保留 Framework 規範落實配置；不得以預設輸出代替契約由 API jn-12 不得由框架預設序列化決定對外語意的原文承接。"
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": null,
      "source": "本文件承接[空值語意](../../../coding/nullability.md)、[型別安全](../../../coding/type-safety.md)與[錯誤處理](../../../coding/error-handling.md)，適用於自行撰寫的 Java 程式碼，包含測試與整合元件。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-01",
      "source": "依業務要求必須存在卻不存在時，表達明確的業務失敗；查詢技術故障另依錯誤處理規範傳遞，不得混為正常缺值。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-02",
      "source": "空的 `Optional` 只能表示契約允許的正常缺值，不得掩蓋業務失敗、技術故障或尚未確認的結果。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-03",
      "source": "替代值、缺值分支與失敗處理須符合業務語意，不得掩蓋缺值或違反錯誤分類。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-03",
      "source": "選用取值或拋出例外的方法本身不代表符合規範；若依已成立的不變條件必定有值，違反時須按程式缺陷處理。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-04",
      "source": "需要區分未提供、清空與設定值等多種狀態時，須使用能完整表達狀態的明確型別，不得以 `Optional` 混合表示。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-07",
      "source": "專案須統一可由工具辨識的空值契約表達方式，明訂非空預設、可空位置與適用範圍，將可自動判斷的違規納入檢查。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-07",
      "source": "標註、文件與實際行為須一致；工具無法涵蓋的部分仍須驗證與審查，標註不能取代外部輸入的執行期驗證。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-08",
      "source": "依[第三方空值行為的共通要求](../../../coding/nullability.md#jn-08)執行。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-08",
      "source": "第三方明訂 `null` 是正常查無資料時，才轉成空的 `Optional`；契約不明或違約的 `null` 不得擅自視為正常缺值。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-09",
      "source": "依[空值契約變更的共通要求](../../../coding/nullability.md#jn-09)執行。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-09",
      "source": "Java 空值標註、`Optional` 使用及缺值處置須同步更新，不因 Java 方法簽章未變就視為相容。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-10",
      "source": "依[規範驗證](../../../quality/rule-verification.md)、[共通測試策略](../../../quality/testing.md)、[型別安全](../../../coding/type-safety.md)執行。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-10",
      "source": "保留本文件驗收表中的 `Optional`、非空標註及實際 API 路徑案例；不合法資料從允許承接它的邊界輸入。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-12",
      "source": "依[API 邊界的缺值轉換的共通要求](../../../interfaces/api-contracts.md#jn-12)執行。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-12",
      "source": "Java 的 `Optional` 與內部 `null` 在 API 邊界轉換；不要求對外暴露 `Optional`。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "刪除完整性",
      "history_id": "JN-12",
      "source": "具體序列化配置由 Framework 規範落實，不能用預設輸出代替契約。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| Java 條文 | 語言增量驗收 |\n",
        "after": "| 對應要求 | 語言增量驗收 |\n",
        "reason": "統一第一欄為對應要求；已移除條文指向共通來源，轉驗收入口使用固定文字，原有第二欄驗收斷言完全不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-optional-results\"></a>1、2、3 | 驗證有值、單筆正常查無資料、多筆空結果，以及適用的必須存在卻不存在、查詢故障與結果未知。確認 `Optional` 本身非空，呼叫端的缺值分支、替代值與失敗分類符合契約。 |\n",
        "after": "| <a id=\"acceptance-java-optional-results\"></a>[查詢](#java-query-absence)、[Optional 非空](#java-optional-nonnull)、[取值](#java-optional-access) | 驗證有值、單筆正常查無資料、多筆空結果，以及適用的必須存在卻不存在、查詢故障與結果未知。確認 `Optional` 本身非空，呼叫端的缺值分支、替代值與失敗分類符合契約。 |\n",
        "reason": "統一第一欄為對應要求；已移除條文指向共通來源，轉驗收入口使用固定文字，原有第二欄驗收斷言完全不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-optional-positions\"></a>4、5 | 審查參數與欄位採用 `Optional` 的必要性及配套。需要多狀態時分別驗證未提供、清空與設定值；集合等輸入含不允許的空值時，確認依契約處理，沒有默默丟棄或替換資料。 |\n",
        "after": "| <a id=\"acceptance-java-optional-positions\"></a>[使用位置](#java-optional-positions)、[集合空值](#java-container-nulls) | 審查參數與欄位採用 `Optional` 的必要性及配套。需要多狀態時分別驗證未提供、清空與設定值；集合等輸入含不允許的空值時，確認依契約處理，沒有默默丟棄或替換資料。 |\n",
        "reason": "統一第一欄為對應要求；已移除條文指向共通來源，轉驗收入口使用固定文字，原有第二欄驗收斷言完全不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-null-contract\"></a>6、7、11 | 核對非空預設、可空標註、檢查範圍及實際驗證位置。確認適用工具能偵測違反契約的使用方式；必填外部輸入缺值時依契約拒絕，且未產生不應發生的副作用。 |\n",
        "after": "| <a id=\"acceptance-java-null-contract\"></a>[驗證責任](../../../coding/validation.md#責任分工)、[工具契約](#java-null-contract-tools)、[非空預設](#java-nonnull-default) | 核對非空預設、可空標註、檢查範圍及實際驗證位置。確認適用工具能偵測違反契約的使用方式；必填外部輸入缺值時依契約拒絕，且未產生不應發生的副作用。 |\n",
        "reason": "統一第一欄為對應要求；已移除條文指向共通來源，轉驗收入口使用固定文字，原有第二欄驗收斷言完全不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-optional-adaptation\"></a>8 | 檢查第三方回傳值轉成 `Optional` 的路徑，只有契約允許的正常缺值才能使用空的 `Optional`。 |\n",
        "after": "| <a id=\"acceptance-java-optional-adaptation\"></a>[第三方轉換](#java-third-party-optional) | 檢查第三方回傳值轉成 `Optional` 的路徑，只有契約允許的正常缺值才能使用空的 `Optional`。 |\n",
        "reason": "統一第一欄為對應要求；已移除條文指向共通來源，轉驗收入口使用固定文字，原有第二欄驗收斷言完全不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-optional-coverage\"></a>10 | 核對案例覆蓋受影響的有值與缺值分類，測試資料及替身遵守型別契約，未為製造案例而關閉檢查或使用不安全轉型。Optional、非空標註與實際 API 路徑均納入適用案例。 |\n",
        "after": "| <a id=\"acceptance-java-optional-coverage\"></a>覆蓋要求（原驗收入口） | 核對案例覆蓋受影響的有值與缺值分類，測試資料及替身遵守型別契約，未為製造案例而關閉檢查或使用不安全轉型。Optional、非空標註與實際 API 路徑均納入適用案例。 |\n",
        "reason": "統一第一欄為對應要求；已移除條文指向共通來源，轉驗收入口使用固定文字，原有第二欄驗收斷言完全不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "acceptance_additions",
      "record": "不合法資料從允許承接它的邊界輸入；型別要求依[型別安全](../../../coding/type-safety.md)。\n\n"
    },
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
    "expected_diagnostic": "基準共通連結遺漏",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 基準共通連結遺漏 rules/quality/rule-verification.md#測試程式碼 (RuntimeError)"
  },
  {
    "test": "N02d 刪例外治理尾句",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "基準共通連結遺漏",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 基準共通連結遺漏 rules/workflow/rule-governance.md (RuntimeError)"
  },
  {
    "test": "N02f 改引言並同步目的文字",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收非表格內容未依基準保留",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 驗收非表格內容未依基準保留 (RuntimeError)"
  },
  {
    "test": "N08c 整條保留改寫",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "整條保留必須逐句保留",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 整條保留必須逐句保留 (RuntimeError)"
  },
  {
    "test": "N13 假整條移除",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "整條移除必須逐句移除",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 整條移除必須逐句移除 (RuntimeError)"
  },
  {
    "test": "N14 ID 指錯小節",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "歷史 ID 去向與句子小節不一致",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 歷史 ID 去向與句子小節不一致 (RuntimeError)"
  },
  {
    "test": "N12b 保留小節新增義務",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "整條保留小節含刪改或新增句子",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 整條保留小節含刪改或新增句子 (RuntimeError)"
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
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 已完成紀錄仍有尚未整理去向 (RuntimeError)"
  },
  {
    "test": "N17 改寫僅貼兩字",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "改寫 text 必須為目的地完整一句",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 改寫 text 必須為目的地完整一句 (RuntimeError)"
  },
  {
    "test": "N04 無關錨點未同步證據",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移除去向與承接證據不一致",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 移除去向與承接證據不一致 (RuntimeError)"
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
    "diagnostic": "<暫存複本> `block in apply': 差異區塊重疊或來源不符 (RuntimeError)"
  },
  {
    "test": "共通理由不足",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "差異理由不足",
    "matched": true,
    "diagnostic": "<暫存複本> `block in apply': 差異理由不足 (RuntimeError)"
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
    "diagnostic": "<暫存複本> `check': 句子所屬歷史 ID 不符 (RuntimeError)"
  },
  {
    "test": "被刪子句不存在",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "被刪子句不在基準原句",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 被刪子句不在基準原句 (RuntimeError)"
  },
  {
    "test": "刪除子句仍在",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "被刪子句仍在現行文件",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 被刪子句仍在現行文件 (RuntimeError)"
  },
  {
    "test": "共通承接原文不存在",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "承接原文不在共通小節",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 承接原文不在共通小節 (RuntimeError)"
  },
  {
    "test": "移除缺承接證據",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移除句缺少子句承接證據",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 移除句缺少子句承接證據 (RuntimeError)"
  },
  {
    "test": "未登錄新句",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "現行正文句子未登錄",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 現行正文句子未登錄 rules/stacks/java/common/null-and-optional.md: 所有查詢另須建立稽核紀錄。 (RuntimeError)"
  },
  {
    "test": "驗收任意增文",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收增文未列白名單",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 驗收增文未列白名單 (RuntimeError)"
  },
  {
    "test": "非表格改動不是條號",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收非表格只准改條號引用",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 驗收非表格只准改條號引用 (RuntimeError)"
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
    "test": "未核准樣板移入遭拒",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移入句不在核准清單",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 移入句不在核准清單或並非完整原句 (RuntimeError)"
  },
  {
    "test": "移入來源非共通",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移入來源必須為共通檔",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 移入來源必須為共通檔 (RuntimeError)"
  },
  {
    "test": "移入原文不在基準",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移入原文不在固定基準",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 移入原文不在固定基準 (RuntimeError)"
  },
  {
    "test": "移入原文未寫入",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移入原文不在 Java 目的小節",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 移入原文不在 Java 目的小節 (RuntimeError)"
  },
  {
    "test": "移入 ID 不符",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移入句所屬 ID 或小節不符",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 移入句所屬 ID 或小節不符 (RuntimeError)"
  },
  {
    "test": "未核准移入且理由不足",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移入句不在核准清單",
    "matched": true,
    "diagnostic": "<暫存複本> `check': 移入句不在核准清單或並非完整原句 (RuntimeError)"
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
    "test": "追溯格式破損",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "Malformed trace rows",
    "matched": true,
    "diagnostic": "Malformed trace rows batch 1"
  },
  {
    "test": "追溯 ID 重複",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "Duplicate trace IDs",
    "matched": true,
    "diagnostic": "Duplicate trace IDs batch 1"
  },
  {
    "test": "追溯多餘片段",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "Unexpected trace fragments",
    "matched": true,
    "diagnostic": "Unexpected trace fragments batch 1"
  },
  {
    "test": "追溯目的地改寫不符",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "Invalid rewritten fragment",
    "matched": true,
    "diagnostic": "Invalid rewritten fragment CL-1、8-2: full destination and meaningful-length reason required"
  },
  {
    "test": "追溯缺承接文字",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "Trace fragment absent from destination",
    "matched": true,
    "diagnostic": "Trace fragment absent from destination CL-1、8-1: ../rules/coding/nullability.md#acceptance-third-party-null"
  },
  {
    "test": "主入口拒絕追溯改寫",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收追溯失敗",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 驗收追溯失敗： (RuntimeError)"
  },
  {
    "test": "共通 Java 驗收重複",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "Scoped duplicate acceptance",
    "matched": true,
    "diagnostic": "Scoped duplicate acceptance: [[\"rules/stacks/java/common/null-and-optional.md\", \"驗證有值、單筆正常查無資料、多筆空結果，以及適用的必須存在卻不存在、查詢故障與結果未知。確認 `Optional` 本身非空，呼叫端的缺值分支、替代值與失敗分類符合契約。\"]]"
  },
  {
    "test": "工作者只改兩檔",
    "expected_exit": 0,
    "actual_exit": 0,
    "expected_diagnostic": "工作者範圍通過",
    "matched": true,
    "diagnostic": "{\n  \"topic\": \"null-and-optional\",\n  \"start\": \"<暫存起點>\",\n  \"allowed\": [\n    \"rules/stacks/java/common/null-and-optional.md\",\n    \"docs/body-restructuring/java/null-and-optional.json\"\n  ],\n  \"changed\": [\n    \"docs/body-restructuring/java/null-and-optional.json\",\n    \"rules/stacks/java/common/null-and-optional.md\"\n  ],\n  \"result\": \"工作者範圍通過\",\n  \"authority\": \"起點由協調者提供，合併前使用協調者保留的起點重驗；工具無法推定授權起點。\"\n}"
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

## `ruby scripts/test-body-policy.rb`

```text
[
  {
    "test": "X02 一級來源擴大範圍",
    "expected": "承接原文不在共通小節",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 承接原文不在共通小節 (RuntimeError)"
  },
  {
    "test": "X05 未申報缺值禁止刪除",
    "expected": "未申報的刪除片段",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 未申報的刪除片段 JN-03: [\"不得掩蓋缺值\"] (RuntimeError)"
  },
  {
    "test": "X06 任意子句碎片",
    "expected": "未申報的刪除片段",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 未申報的刪除片段 JN-03: [\"或違\"] (RuntimeError)"
  },
  {
    "test": "X08 未核准移入",
    "expected": "移入句不在核准清單",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 移入句不在核准清單或並非完整原句 (RuntimeError)"
  },
  {
    "test": "X09 移入不完整",
    "expected": "移入句不在核准清單",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 移入句不在核准清單或並非完整原句 (RuntimeError)"
  },
  {
    "test": "X10 條文改指一級",
    "expected": "條文小標題不符基準",
    "exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 條文小標題不符基準：不接受一級標題去向 (RuntimeError)"
  },
  {
    "test": "X11 保留清單改種類",
    "expected": "必須整條保留 JN-11",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 必須整條保留 JN-11 (RuntimeError)"
  },
  {
    "test": "X12 重複理由",
    "expected": "同條改寫／移除理由重複",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 同條改寫／移除理由重複 JN-12 (RuntimeError)"
  },
  {
    "test": "X13 第一欄夾帶限定",
    "expected": "驗收第一欄不符固定格式",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 驗收第一欄不符固定格式 (RuntimeError)"
  },
  {
    "test": "X15 改小標題",
    "expected": "條文小標題不符基準",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 條文小標題不符基準 JN-05 (RuntimeError)"
  },
  {
    "test": "X16b 插入標題",
    "expected": "條文小節含額外標題",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 條文小節含額外標題或錨點 JN-05 (RuntimeError)"
  },
  {
    "test": "X16c 錨點行藏義務",
    "expected": "正文錨點行含未核准內容",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 正文錨點行含未核准內容 (RuntimeError)"
  },
  {
    "test": "X17d 未併入卻標種類",
    "expected": "整份併入種類只允許 merged",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 整份併入種類只允許 merged (RuntimeError)"
  },
  {
    "test": "X17e 任意驗收入口",
    "expected": "必須整條保留 JN-05",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 必須整條保留 JN-05 (RuntimeError)"
  },
  {
    "test": "X25 漏報刪除子句",
    "expected": "未申報的刪除片段",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 未申報的刪除片段 JN-08: [\"不\",\"或違約的\",\"不得擅自視為\",\"缺值\"] (RuntimeError)"
  },
  {
    "test": "X26 承接碎片",
    "expected": "承接原文不在共通小節",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 承接原文不在共通小節 (RuntimeError)"
  },
  {
    "test": "X27 承接碎片",
    "expected": "承接原文不在共通小節",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 承接原文不在共通小節 (RuntimeError)"
  },
  {
    "test": "承接子句誤指 Java",
    "expected": "承接子句必須指向共通",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 承接子句必須指向共通 (RuntimeError)"
  },
  {
    "test": "驗收非表格來源錯誤",
    "expected": "驗收非表格變更來源／理由無效",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 驗收非表格變更來源／理由無效 (RuntimeError)"
  },
  {
    "test": "驗收非表格改了非條號",
    "expected": "驗收非表格包含非條號改動",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 驗收非表格包含非條號改動 (RuntimeError)"
  },
  {
    "test": "清空分組漏指路",
    "expected": "清空分組缺少指路文字",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 清空分組缺少指路文字 (RuntimeError)"
  },
  {
    "test": "指路文字夾義務",
    "expected": "指路文字不符固定格式",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 指路文字不符固定格式 (RuntimeError)"
  },
  {
    "test": "漏基準共同連結",
    "expected": "基準共通連結遺漏",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 基準共通連結遺漏 rules/quality/rule-verification.md#測試程式碼 (RuntimeError)"
  },
  {
    "test": "尾段無獨立小節",
    "expected": "分組尾段必須指向獨立結尾小節",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 分組尾段必須指向獨立結尾小節 (RuntimeError)"
  },
  {
    "test": "BM 未移入",
    "expected": "BM-04 缺少完整核准移入句",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': BM-04 缺少完整核准移入句 (RuntimeError)"
  },
  {
    "test": "CA 未增驗收",
    "expected": "缺少必要共同驗收增文",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 缺少必要共同驗收增文 (RuntimeError)"
  },
  {
    "test": "重複文件紀錄",
    "expected": "重複文件紀錄",
    "exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 重複文件紀錄 (RuntimeError)"
  },
  {
    "test": "文件 ID 順序錯誤",
    "expected": "文件歷史 ID 不符合基準條文",
    "exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 文件歷史 ID 不符合基準條文 (RuntimeError)"
  },
  {
    "test": "差異清單未知檔案",
    "expected": "差異清單包含未知檔案",
    "exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 差異清單包含未知檔案 (RuntimeError)"
  },
  {
    "test": "新增一般規則檔",
    "expected": "rules 檔案清單變更未登錄",
    "exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': rules 檔案清單變更未登錄為整份併入 (RuntimeError)"
  },
  {
    "test": "保留句文字改寫",
    "expected": "保留句子不是逐字保留",
    "exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 保留句子不是逐字保留 (RuntimeError)"
  },
  {
    "test": "驗收列遺失且同步刪列紀錄",
    "expected": "去向錨點無效",
    "exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:8:in `require_check': 去向錨點無效 rules/stacks/java/common/null-and-optional.md#acceptance-java-optional-coverage (RuntimeError)"
  },
  {
    "test": "核准移入理由不足",
    "expected": "移入句理由不足",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 移入句理由不足 (RuntimeError)"
  },
  {
    "test": "完整轉換卻留數字第一欄",
    "expected": "驗收第一欄不符固定格式",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 驗收第一欄不符固定格式 (RuntimeError)"
  }
]
exit=0
```

## `ruby scripts/test-body-worker-scope.rb`

```text
[
  {
    "test": "W05",
    "expected": 1,
    "exit": 1,
    "diagnostic": "工作者超出允許範圍",
    "matched": true
  },
  {
    "test": "W06",
    "expected": 1,
    "exit": 1,
    "diagnostic": "工作者超出允許範圍",
    "matched": true
  },
  {
    "test": "W09",
    "expected": 1,
    "exit": 1,
    "diagnostic": "工作者超出允許範圍",
    "matched": true
  },
  {
    "test": "W10",
    "expected": 1,
    "exit": 1,
    "diagnostic": "工作者起點與協調者記錄不符",
    "matched": true
  },
  {
    "test": "W19",
    "expected": 1,
    "exit": 1,
    "diagnostic": "未知的工作者主題",
    "matched": true
  },
  {
    "test": "W20",
    "expected": 0,
    "exit": 0,
    "diagnostic": "工作者範圍通過",
    "matched": true
  }
]
exit=0
```

## `ruby scripts/test-body-rehearsals.rb`

```text
[
  {
    "test": "分組清空與最後條文移除",
    "exit": 0,
    "matched": true,
    "diagnostic": "主檢查通過"
  },
  {
    "test": "重述保留一句",
    "exit": 0,
    "matched": true,
    "diagnostic": "主檢查通過"
  },
  {
    "test": "EX 條號改錨點",
    "exit": 0,
    "matched": true,
    "diagnostic": "主檢查通過"
  },
  {
    "test": "EQ 條號改錨點",
    "exit": 0,
    "matched": true,
    "diagnostic": "主檢查通過"
  },
  {
    "test": "CA 清單正常增文",
    "exit": 0,
    "matched": true,
    "diagnostic": "主檢查通過"
  },
  {
    "test": "CO 清單正常增文",
    "exit": 0,
    "matched": true,
    "diagnostic": "主檢查通過"
  },
  {
    "test": "BM 移入及協調者刪共通",
    "exit": 0,
    "matched": true,
    "diagnostic": "主檢查通過"
  },
  {
    "test": "JT 重複引用僅移除一條",
    "exit": 0,
    "matched": true,
    "diagnostic": "主檢查通過"
  },
  {
    "test": "另一份完整整理 ND-01 至 ND-07",
    "exit": 0,
    "matched": true,
    "diagnostic": "主檢查通過"
  },
  {
    "test": "三工作者 boundary-mapping 範圍",
    "exit": 0,
    "matched": true,
    "diagnostic": "工作者範圍通過"
  },
  {
    "test": "三工作者 exceptions-and-resources 範圍",
    "exit": 0,
    "matched": true,
    "diagnostic": "工作者範圍通過"
  },
  {
    "test": "三工作者 collections-and-ownership 範圍",
    "exit": 0,
    "matched": true,
    "diagnostic": "工作者範圍通過"
  },
  {
    "test": "合併 worker 0",
    "exit": 0,
    "matched": true,
    "diagnostic": "無衝突合併"
  },
  {
    "test": "合併 worker 1",
    "exit": 0,
    "matched": true,
    "diagnostic": "無衝突合併"
  },
  {
    "test": "合併 worker 2",
    "exit": 0,
    "matched": true,
    "diagnostic": "無衝突合併"
  },
  {
    "test": "三工作者合併主檢查",
    "exit": 0,
    "matched": true,
    "diagnostic": "主檢查通過"
  },
  {
    "test": "集合完成後撤回適用性",
    "exit": 0,
    "matched": true,
    "diagnostic": "明確略過已整理集合的獨立撤回；併發仍測試"
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
    "revert_output": "[暫存撤回提交] Revert \"正式列管 CA-06 結果接收與故障保留\"\n Date: <暫存提交時間>\n 2 files changed, 2 insertions(+), 67 deletions(-)\n delete mode 100644 docs/body-restructuring/common/ca-06.json\n",
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
    "revert_output": "[暫存撤回提交] Revert \"正式列管 CO-08 批次失敗後狀態與適用邊界\"\n Date: <暫存提交時間>\n 3 files changed, 1 insertion(+), 54 deletions(-)\n delete mode 100644 docs/body-restructuring/common/co-08.json\n",
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
