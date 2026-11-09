# 正文整理：實際驗證紀錄

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
      "status": "completed",
      "id": "JV-01",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "completed",
      "id": "JV-02",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "completed",
      "id": "JV-03",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "completed",
      "id": "JV-04",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "completed",
      "id": "JV-05",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "completed",
      "id": "JV-06",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "completed",
      "id": "JV-07",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "completed",
      "id": "JV-08",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "completed",
      "id": "JV-09",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "completed",
      "id": "JV-10",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "completed",
      "id": "JV-11",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "status": "completed",
      "id": "JV-12",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "completed",
      "id": "LS-01",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "completed",
      "id": "LS-02",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "completed",
      "id": "LS-03",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "completed",
      "id": "LS-04",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "completed",
      "id": "LS-05",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "completed",
      "id": "LS-06",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "completed",
      "id": "LS-07",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "completed",
      "id": "LS-08",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "completed",
      "id": "LS-09",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "status": "completed",
      "id": "LS-10",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "completed",
      "id": "CL-01",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "completed",
      "id": "CL-02",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "completed",
      "id": "CL-03",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "completed",
      "id": "CL-04",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "completed",
      "id": "CL-05",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "completed",
      "id": "CL-06",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "completed",
      "id": "CL-07",
      "decision": "保留條文／可能",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "completed",
      "id": "CL-08",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "completed",
      "id": "CL-09",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "status": "completed",
      "id": "CL-10",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "completed",
      "id": "NT-01",
      "decision": "增量",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "completed",
      "id": "NT-02",
      "decision": "增量",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "completed",
      "id": "NT-03",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "completed",
      "id": "NT-04",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "completed",
      "id": "NT-05",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "completed",
      "id": "NT-06",
      "decision": "增量",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "completed",
      "id": "NT-07",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "completed",
      "id": "NT-08",
      "decision": "增量",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "completed",
      "id": "NT-09",
      "decision": "增量",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "completed",
      "id": "NT-10",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "completed",
      "id": "NT-11",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "completed",
      "id": "NT-12",
      "decision": "增量",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "completed",
      "id": "NT-13",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "status": "completed",
      "id": "NT-14",
      "decision": "驗收入口",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "completed",
      "id": "EX-01",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "completed",
      "id": "EX-02",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "completed",
      "id": "EX-03",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "completed",
      "id": "EX-04",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "completed",
      "id": "EX-05",
      "decision": "保留條文／可能",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "completed",
      "id": "EX-06",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "completed",
      "id": "EX-07",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "completed",
      "id": "EX-08",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "status": "completed",
      "id": "EX-09",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "completed",
      "id": "ST-01",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "completed",
      "id": "ST-02",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "completed",
      "id": "ST-03",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "completed",
      "id": "ST-04",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "completed",
      "id": "ST-05",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "completed",
      "id": "ST-06",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "completed",
      "id": "ST-07",
      "decision": "保留條文／可能",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "completed",
      "id": "ST-08",
      "decision": "增量",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "completed",
      "id": "ST-09",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "status": "completed",
      "id": "ST-10",
      "decision": "驗收入口",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "completed",
      "id": "CA-01",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "completed",
      "id": "CA-02",
      "decision": "混合",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "completed",
      "id": "CA-03",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "completed",
      "id": "CA-04",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "completed",
      "id": "CA-05",
      "decision": "增量",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "completed",
      "id": "CA-06",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "completed",
      "id": "CA-07",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "completed",
      "id": "CA-08",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "completed",
      "id": "CA-09",
      "decision": "增量",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "completed",
      "id": "CA-10",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "completed",
      "id": "CA-11",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "status": "completed",
      "id": "CA-12",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "completed",
      "id": "CO-01",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "completed",
      "id": "CO-02",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "completed",
      "id": "CO-03",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "completed",
      "id": "CO-04",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "completed",
      "id": "CO-05",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "completed",
      "id": "CO-06",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "completed",
      "id": "CO-07",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "completed",
      "id": "CO-08",
      "decision": "待確認",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "status": "completed",
      "id": "CO-09",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "completed",
      "id": "BM-01",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "completed",
      "id": "BM-02",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "completed",
      "id": "BM-03",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "completed",
      "id": "BM-04",
      "decision": "待確認",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "completed",
      "id": "BM-05",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "completed",
      "id": "BM-06",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "completed",
      "id": "BM-07",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "completed",
      "id": "BM-08",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "status": "completed",
      "id": "BM-09",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "completed",
      "id": "VO-01",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "completed",
      "id": "VO-02",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "completed",
      "id": "VO-03",
      "decision": "增量",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "completed",
      "id": "VO-04",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "completed",
      "id": "VO-05",
      "decision": "混合",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "completed",
      "id": "VO-06",
      "decision": "重述",
      "kind": "拆分"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "completed",
      "id": "VO-07",
      "decision": "混合",
      "kind": "拆分"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "completed",
      "id": "VO-08",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "completed",
      "id": "VO-09",
      "decision": "保留條文／可能",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "status": "completed",
      "id": "VO-10",
      "decision": "驗收入口",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "completed",
      "id": "EQ-01",
      "decision": "增量",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "completed",
      "id": "EQ-02",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "completed",
      "id": "EQ-03",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "completed",
      "id": "EQ-04",
      "decision": "混合",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "completed",
      "id": "EQ-05",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "completed",
      "id": "EQ-06",
      "decision": "保留條文／可能",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "completed",
      "id": "EQ-07",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "completed",
      "id": "EQ-08",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "completed",
      "id": "EQ-09",
      "decision": "保留條文／是",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "status": "completed",
      "id": "EQ-10",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "status": "completed",
      "id": "ND-01",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "status": "completed",
      "id": "ND-02",
      "decision": "待補證",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "status": "completed",
      "id": "ND-03",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "status": "completed",
      "id": "ND-04",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "status": "completed",
      "id": "ND-05",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "status": "completed",
      "id": "ND-06",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "status": "completed",
      "id": "ND-07",
      "decision": "增量",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "completed",
      "id": "JT-01",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "completed",
      "id": "JT-02",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "completed",
      "id": "JT-03",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "completed",
      "id": "JT-04",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "completed",
      "id": "JT-05",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "completed",
      "id": "JT-06",
      "decision": "重述",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "completed",
      "id": "JT-07",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "completed",
      "id": "JT-08",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "completed",
      "id": "JT-09",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "completed",
      "id": "JT-10",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "status": "completed",
      "id": "JT-11",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "completed",
      "id": "RF-01",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "completed",
      "id": "RF-02",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "completed",
      "id": "RF-03",
      "decision": "保留條文／否",
      "kind": "保留增量"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "completed",
      "id": "RF-04",
      "decision": "重述",
      "kind": "整條移除"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "completed",
      "id": "RF-05",
      "decision": "混合",
      "kind": "拆分"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "completed",
      "id": "RF-06",
      "decision": "混合",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "completed",
      "id": "RF-07",
      "decision": "驗收入口",
      "kind": "整條保留"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "status": "completed",
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
  "completed": 15,
  "pending": 0,
  "body_sentences": 437,
  "preserved_acceptance_rows": 86,
  "common_change_blocks": 13,
  "manual_review_count": 349,
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
        "rules/coding/code-design.md#construction-entrypoints",
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
      "source": "依[第三方空值行為的共通要求](../../../coding/nullability.md#third-party-null-contract)執行。",
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
      "source": "依[空值契約變更的共通要求](../../../coding/nullability.md#null-contract-evolution)執行。",
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
      "source": "依[API 邊界的缺值轉換的共通要求](../../../interfaces/api-contracts.md#api-absence-representation)執行。",
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
          "uri": "rules/coding/code-design.md#construction-entrypoints"
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
          "source_uri": "rules/coding/code-design.md#construction-entrypoints",
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
          "text": "可自動判斷的違規及工具缺口依[共同把關](../../../quality/rule-verification.md#verification-coverage)納入檢查、驗證與審查。"
        }
      ],
      "removed_assertions": [
        {
          "text": "，將可自動判斷的違規納入檢查",
          "source_uri": "rules/quality/rule-verification.md#verification-coverage",
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
          "text": "可自動判斷的違規及工具缺口依[共同把關](../../../quality/rule-verification.md#verification-coverage)納入檢查、驗證與審查。"
        },
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-null-contract-tools",
          "text": "標註、文件與實際行為須一致；標註不能取代外部輸入的執行期驗證。"
        }
      ],
      "removed_assertions": [
        {
          "text": "工具無法涵蓋的部分仍須驗證與審查，",
          "source_uri": "rules/quality/rule-verification.md#verification-coverage",
          "source_text": "工具尚未涵蓋的要求必須列入審查清單，不能因 CI 通過就視為全部符合。"
        },
        {
          "text": "工具無法涵蓋的部分仍須驗證與審查，",
          "source_uri": "rules/quality/rule-verification.md#verification-coverage",
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
      "source": "依[第三方空值行為的共通要求](../../../coding/nullability.md#third-party-null-contract)執行。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-third-party-optional",
          "text": "依[第三方空值行為](../../../coding/nullability.md#third-party-null-contract)確認契約；第三方明訂 `null` 是正常查無資料時，才轉成空的 `Optional`。"
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
          "text": "依[第三方空值行為](../../../coding/nullability.md#third-party-null-contract)確認契約；第三方明訂 `null` 是正常查無資料時，才轉成空的 `Optional`。"
        }
      ],
      "removed_assertions": [
        {
          "text": "契約不明或違約的 `null` 不得擅自視為正常缺值",
          "source_uri": "rules/coding/nullability.md#third-party-null-contract",
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
      "source": "依[空值契約變更的共通要求](../../../coding/nullability.md#null-contract-evolution)執行。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-null-contract-evolution",
          "text": "依[空值契約變更](../../../coding/nullability.md#null-contract-evolution)評估相容性與使用端影響；Java 空值標註、`Optional` 使用及缺值處置須同步更新。"
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
          "text": "依[空值契約變更](../../../coding/nullability.md#null-contract-evolution)評估相容性與使用端影響；Java 空值標註、`Optional` 使用及缺值處置須同步更新。"
        }
      ],
      "removed_assertions": [
        {
          "text": "不因 Java 方法簽章未變就視為相容",
          "source_uri": "rules/coding/nullability.md#null-contract-evolution",
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
      "source": "依[API 邊界的缺值轉換的共通要求](../../../interfaces/api-contracts.md#api-absence-representation)執行。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/null-and-optional.md#java-api-absence",
          "text": "Java 的 `Optional` 與內部 `null` 在 API 邊界轉換，依[API 邊界的缺值轉換](../../../interfaces/api-contracts.md#api-absence-representation)落實對外契約。"
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
          "text": "Java 的 `Optional` 與內部 `null` 在 API 邊界轉換，依[API 邊界的缺值轉換](../../../interfaces/api-contracts.md#api-absence-representation)落實對外契約。"
        }
      ],
      "removed_assertions": [
        {
          "text": "不要求對外暴露 `Optional`",
          "source_uri": "rules/interfaces/api-contracts.md#api-absence-representation",
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
          "source_uri": "rules/interfaces/api-contracts.md#api-absence-representation",
          "source_text": "內部缺值型別須在 API 邊界依公開契約轉換，不直接暴露語言的缺值包裝型別，也不得由框架預設序列化行為決定對外語意。"
        }
      ],
      "reason": "本句保留 Framework 規範落實配置；不得以預設輸出代替契約由 API jn-12 不得由框架預設序列化決定對外語意的原文承接。"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "去向種類",
      "history_id": "JV-01",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/version-policy.md#java-version-declarations"
      ],
      "reason": "保留建置 JDK、編譯目標、標準 API 與執行支援範圍；待決清單指出共通資料契約無法直接涵蓋 JDK 執行支援承諾。"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "去向種類",
      "history_id": "JV-02",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/version-policy.md#java-build-compatibility"
      ],
      "reason": "保留受版本控制的建置設定、本機與 CI 一致性及 Java 語言、API、位元碼限制，依第四節否的預設處理不抽背景。"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "去向種類",
      "history_id": "JV-03",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/version-policy.md#java-runtime-verification"
      ],
      "reason": "保留每個承諾執行版本、函式庫使用端載入與關鍵功能驗證，以及風險深度與 CI 或發布證據。"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "去向種類",
      "history_id": "JV-04",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/version-policy.md#java-module-versions"
      ],
      "reason": "保留逐模組編譯目標、支援範圍、依賴關係與共用模組對使用端的相容性驗證。"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "去向種類",
      "history_id": "JV-05",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/version-policy.md#java-dependency-versions"
      ],
      "reason": "保留直接與間接依賴 Java 版本核對、超出承諾範圍時先完成處置的採用條件及既有共通連結。"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "去向種類",
      "history_id": "JV-06",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/version-policy.md#java-build-upgrade"
      ],
      "reason": "保留建置 JDK 升級的既有承諾與最低執行版本變更的部署、使用端、回退、遷移驗證及公告。"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "去向種類",
      "history_id": "JV-07",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/version-policy.md#java-preview-features"
      ],
      "reason": "保留正式功能預設、Preview 負責人核准與紀錄、建置測試部署配套、維護責任及配套不足時的處置。"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "去向種類",
      "history_id": "JV-08",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/version-policy.md#java-jdk-internals"
      ],
      "reason": "保留公開受支援 JDK API 預設、內部存取個別例外程序、替代方案、後續處置及升級重新驗證。"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "去向種類",
      "history_id": "JV-09",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/version-policy.md#java-deprecated-api"
      ],
      "reason": "保留符合版本範圍的替代 API、預定移除風險與遷移、持續使用例外核准及重新評估條件。"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "去向種類",
      "history_id": "JV-10",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/version-policy.md#java-toolchain-compatibility"
      ],
      "reason": "保留 Java 版本變更對編譯、測試、分析與產物工具的評估、必要檢查實際執行與產物版本承諾。"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "去向種類",
      "history_id": "JV-11",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/version-policy.md#java-jdk-distribution"
      ],
      "reason": "保留 JDK 發行商、完整版本、多發行版本支援與更新驗證；待決清單指出第三方依賴管理不能直接代替執行環境識別。"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "去向種類",
      "history_id": "JV-12",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/version-policy.md#java-artifact-traceability"
      ],
      "reason": "保留發布產物到建置 JDK、編譯目標、依賴及驗證的追溯，以及部署識別、Java 環境與啟動設定核對。"
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| Java 條文 | 語言增量驗收 |\n",
        "after": "| 對應要求 | 語言增量驗收 |\n",
        "reason": "驗收第一欄改為對應要求與現行語意小節連結，原次序及第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-version-target\"></a>1、2 | 核對版本宣告與實際建置設定。以不符合目標版本的語法或標準 API 案例，確認適用檢查會拒絕，並核對產物格式。 |\n",
        "after": "| <a id=\"acceptance-java-version-target\"></a>[分別記錄版本資訊](#java-version-declarations)、[建置設定落實限制](#java-build-compatibility) | 核對版本宣告與實際建置設定。以不符合目標版本的語法或標準 API 案例，確認適用檢查會拒絕，並核對產物格式。 |\n",
        "reason": "驗收第一欄改為對應要求與現行語意小節連結，原次序及第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-runtime-matrix\"></a>3、4 | 查核各承諾執行版本的實際驗證結果。多模組按依賴關係核對使用端與提供端的相容範圍，不能只依單一較新環境通過推論所有版本符合。 |\n",
        "after": "| <a id=\"acceptance-java-runtime-matrix\"></a>[執行版本驗證](#java-runtime-verification)、[多模組版本要求](#java-module-versions) | 查核各承諾執行版本的實際驗證結果。多模組按依賴關係核對使用端與提供端的相容範圍，不能只依單一較新環境通過推論所有版本符合。 |\n",
        "reason": "驗收第一欄改為對應要求與現行語意小節連結，原次序及第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-version-upgrade\"></a>5、6 | 核對實際解析出的直接與間接依賴要求。提高最低版本時檢查使用端影響、遷移順序及回退安排，確認支援範圍變更已有明確決策。 |\n",
        "after": "| <a id=\"acceptance-java-version-upgrade\"></a>[依賴版本要求](#java-dependency-versions)、[建置升級與支援範圍變更](#java-build-upgrade) | 核對實際解析出的直接與間接依賴要求。提高最低版本時檢查使用端影響、遷移順序及回退安排，確認支援範圍變更已有明確決策。 |\n",
        "reason": "驗收第一欄改為對應要求與現行語意小節連結，原次序及第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-api-exceptions\"></a>7、8、9 | 依實際使用情形核對 Preview、內部 API、存取放寬與棄用 API 的紀錄。確認適用核准、環境配套、維護責任及重新評估條件，並驗證替代做法符合目標版本。 |\n",
        "after": "| <a id=\"acceptance-java-api-exceptions\"></a>[Preview 功能](#java-preview-features)、[JDK 內部實作與存取限制](#java-jdk-internals)、[棄用 API](#java-deprecated-api) | 依實際使用情形核對 Preview、內部 API、存取放寬與棄用 API 的紀錄。確認適用核准、環境配套、維護責任及重新評估條件，並驗證替代做法符合目標版本。 |\n",
        "reason": "驗收第一欄改為對應要求與現行語意小節連結，原次序及第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-toolchain-compatibility\"></a>10、11 | Java 環境或工具變更後，核對必要測試與分析確實執行，避免將被略過的檢查計為通過。確認產生碼與產物仍相容，並保留發行商及完整版本變更的驗證結果。 |\n",
        "after": "| <a id=\"acceptance-java-toolchain-compatibility\"></a>[建置與驗證工具相容性](#java-toolchain-compatibility)、[JDK 發行商與完整版本](#java-jdk-distribution) | Java 環境或工具變更後，核對必要測試與分析確實執行，避免將被略過的檢查計為通過。確認產生碼與產物仍相容，並保留發行商及完整版本變更的驗證結果。 |\n",
        "reason": "驗收第一欄改為對應要求與現行語意小節連結，原次序及第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-artifact-runtime\"></a>12 | 從指定發布產物查回建置環境、編譯目標、依賴與驗證紀錄，再核對部署環境中的實際產物及 Java 環境。 |\n",
        "after": "| <a id=\"acceptance-java-artifact-runtime\"></a>[產物與執行環境追溯](#java-artifact-traceability) | 從指定發布產物查回建置環境、編譯目標、依賴與驗證紀錄，再核對部署環境中的實際產物及 Java 環境。 |\n",
        "reason": "驗收第一欄改為對應要求與現行語意小節連結，原次序及第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "去向種類",
      "history_id": "LS-01",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/lambda-and-stream.md#java-intent-readability"
      ],
      "reason": "第三節判斷重述，但共通函式責任與命名原文未直接明訂 Stream 不強制取代迴圈、複雜邏輯採具名方法或清楚流程及不要求每個 Lambda 抽方法，故整條保守保留含原引用。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "去向種類",
      "history_id": "LS-02",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/lambda-and-stream.md#java-lambda-parameter-types"
      ],
      "reason": "第四節判斷否，逐字保留 Lambda 參數明確型別、禁止省略或 var、方法參考條件及泛型資訊要求。"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "去向種類",
      "history_id": "LS-03",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/lambda-and-stream.md#java-intermediate-side-effects"
      ],
      "reason": "第四節判斷否，逐字保留 Stream 中間操作與 peek 限制，以及外部呼叫與 forEach 的順序、失敗及部分成功保證。"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "去向種類",
      "history_id": "LS-04",
      "decision": "保留條文／是",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/lambda-and-stream.md#java-result-accumulation"
      ],
      "reason": "第四節判斷是且列於必須整條保留清單，逐字保留結果累積、外部可變狀態禁止事項與跨元素順序管理責任。"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "去向種類",
      "history_id": "LS-05",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/lambda-and-stream.md#java-lazy-short-circuit"
      ],
      "reason": "第四節判斷否，逐字保留 Stream 延遲、終端操作、短路範圍及完整驗證或逐項處理保證。"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "去向種類",
      "history_id": "LS-06",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/lambda-and-stream.md#java-parallel-stream-adoption"
      ],
      "reason": "第四節判斷否，逐字保留平行 Stream 採用需求、隔離順序歸約失敗驗證、阻塞資源評估及負載收益證據。"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "去向種類",
      "history_id": "LS-07",
      "decision": "保留條文／是",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/lambda-and-stream.md#java-reduction-collection"
      ],
      "reason": "第四節判斷是且列於必須整條保留清單，逐字保留初始值、累積合併、結合性、順序敏感運算及可變容器隔離要求。"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "去向種類",
      "history_id": "LS-08",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/lambda-and-stream.md#java-failure-classification"
      ],
      "reason": "第四節判斷否，逐字保留函式介面例外限制下的分類、原始原因、流程調整、禁止隱藏拋出及部分成功對應關係。"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "去向種類",
      "history_id": "LS-09",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/lambda-and-stream.md#java-stream-consumption"
      ],
      "reason": "第四節判斷否，逐字保留 Stream 單次消費、禁止共用消費、快照或重新取得的一致性及資源有效期與關閉責任。"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "去向種類",
      "history_id": "LS-10",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/lambda-and-stream.md#java-execution-verification"
      ],
      "reason": "第四節判斷否，逐字保留流程變更的執行語意驗證、平行隔離及實際效能，並保留不重測函式庫與簡單轉換適用範圍。"
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| Java 條文 | 語言增量驗收 |\n",
        "after": "| 對應要求 | 語言增量驗收 |\n",
        "reason": "驗收第一欄改用對應要求表頭及原條文語意錨點，保留原有驗收錨點、排列次序與第二欄所有驗收文字。"
      }
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-lambda-types\"></a>1、2 | 審查流程意圖與責任是否清楚，複雜邏輯有合適表達；檢查 Lambda 參數明確標註、泛型資訊完整，方法參考可辨識目標與用途，不以縮短行數作為採用依據。 |\n",
        "after": "| <a id=\"acceptance-java-lambda-types\"></a>[意圖與可讀性優先](#java-intent-readability)、[明確的參數型別](#java-lambda-parameter-types) | 審查流程意圖與責任是否清楚，複雜邏輯有合適表達；檢查 Lambda 參數明確標註、泛型資訊完整，方法參考可辨識目標與用途，不以縮短行數作為採用依據。 |\n",
        "reason": "驗收第一欄改用對應要求表頭及原條文語意錨點，保留原有驗收錨點、排列次序與第二欄所有驗收文字。"
      }
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-stream-side-effects\"></a>3、4 | 審查中間操作及呼叫方法，確認沒有隱藏業務副作用或修改外部狀態。必要執行步驟的順序、失敗及部分完成有明確契約，跨元素狀態有管理責任。 |\n",
        "after": "| <a id=\"acceptance-java-stream-side-effects\"></a>[中間操作不隱藏業務副作用](#java-intermediate-side-effects)、[明確累積結果](#java-result-accumulation) | 審查中間操作及呼叫方法，確認沒有隱藏業務副作用或修改外部狀態。必要執行步驟的順序、失敗及部分完成有明確契約，跨元素狀態有管理責任。 |\n",
        "reason": "驗收第一欄改用對應要求表頭及原條文語意錨點，保留原有驗收錨點、排列次序與第二欄所有驗收文字。"
      }
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-stream-short-circuit\"></a>5 | 以空資料、單筆、多筆及會短路的案例核對實際處理範圍，確認完整驗證或必要工作沒有因延遲與短路而遺漏，不把建立流程視為完成。 |\n",
        "after": "| <a id=\"acceptance-java-stream-short-circuit\"></a>[延遲與短路範圍](#java-lazy-short-circuit) | 以空資料、單筆、多筆及會短路的案例核對實際處理範圍，確認完整驗證或必要工作沒有因延遲與短路而遺漏，不把建立流程視為完成。 |\n",
        "reason": "驗收第一欄改用對應要求表頭及原條文語意錨點，保留原有驗收錨點、排列次序與第二欄所有驗收文字。"
      }
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-parallel-stream\"></a>6 | 採平行處理時，以代表性資料與負載確認結果、順序、隔離及失敗語意，評估阻塞與資源競爭影響，保留量測收益的依據。 |\n",
        "after": "| <a id=\"acceptance-java-parallel-stream\"></a>[平行處理的採用條件](#java-parallel-stream-adoption) | 採平行處理時，以代表性資料與負載確認結果、順序、隔離及失敗語意，評估阻塞與資源競爭影響，保留量測收益的依據。 |\n",
        "reason": "驗收第一欄改用對應要求表頭及原條文語意錨點，保留原有驗收錨點、排列次序與第二欄所有驗收文字。"
      }
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-stream-reduction\"></a>7 | 驗證初始值、累積與合併結果；適用時以不同分段方式核對契約一致性。順序敏感運算保留約定順序，可變收集結果不受其他分段或執行污染。 |\n",
        "after": "| <a id=\"acceptance-java-stream-reduction\"></a>[歸約與收集契約](#java-reduction-collection) | 驗證初始值、累積與合併結果；適用時以不同分段方式核對契約一致性。順序敏感運算保留約定順序，可變收集結果不受其他分段或執行污染。 |\n",
        "reason": "驗收第一欄改用對應要求表頭及原條文語意錨點，保留原有驗收錨點、排列次序與第二欄所有驗收文字。"
      }
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-functional-exceptions\"></a>8 | 在適用的處理階段觸發失敗，確認分類與原始原因保留，沒有以空值、替代值或篩除項目掩蓋問題。另核對 Lambda／Stream 函式介面的例外宣告限制與轉換路徑。 |\n",
        "after": "| <a id=\"acceptance-java-functional-exceptions\"></a>[維持錯誤分類](#java-failure-classification) | 在適用的處理階段觸發失敗，確認分類與原始原因保留，沒有以空值、替代值或篩除項目掩蓋問題。另核對 Lambda／Stream 函式介面的例外宣告限制與轉換路徑。 |\n",
        "reason": "驗收第一欄改用對應要求表頭及原條文語意錨點，保留原有驗收錨點、排列次序與第二欄所有驗收文字。"
      }
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-stream-consumption\"></a>9 | 核對 Stream 的建立與消費路徑，沒有重用或共用消費；重複取得資料時依契約驗證快照或最新資料語意。 |\n",
        "after": "| <a id=\"acceptance-java-stream-consumption\"></a>[明確消費範圍](#java-stream-consumption) | 核對 Stream 的建立與消費路徑，沒有重用或共用消費；重複取得資料時依契約驗證快照或最新資料語意。 |\n",
        "reason": "驗收第一欄改用對應要求表頭及原條文語意錨點，保留原有驗收錨點、排列次序與第二欄所有驗收文字。"
      }
    },
    {
      "path": "rules/stacks/java/common/lambda-and-stream.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-stream-coverage\"></a>10 | 確認案例涵蓋受影響的執行語意與資源保證，平行處理有額外隔離及效能證據，不僅比對一般成功案例的最終元素內容。 |\n",
        "after": "| <a id=\"acceptance-java-stream-coverage\"></a>[執行語意驗收](#java-execution-verification) | 確認案例涵蓋受影響的執行語意與資源保證，平行處理有額外隔離及效能證據，不僅比對一般成功案例的最終元素內容。 |\n",
        "reason": "驗收第一欄改用對應要求表頭及原條文語意錨點，保留原有驗收錨點、排列次序與第二欄所有驗收文字。"
      }
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "去向種類",
      "history_id": "CL-01",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/classes-and-construction.md#java-interface-purpose"
      ],
      "reason": "共通介面與抽象及模組公開入口未直接明列單一實作不構成省略必要架構隔離的理由，故整條保留。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "去向種類",
      "history_id": "CL-02",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/code-design.md#substitutability"
      ],
      "reason": "父型別輸入結果行為與組合委派優先均由共通繼承可替代性兩句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "去向種類",
      "history_id": "CL-03",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/resource-lifecycle.md#initialization-readiness"
      ],
      "reason": "必要資料依賴、分階段生命週期與不要求建構子連線或啟動背景工作均有直接原文承接。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "去向種類",
      "history_id": "CL-04",
      "decision": "保留條文／是",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/classes-and-construction.md#java-construction-safety"
      ],
      "reason": "依第四節「是」及必須整條保留清單，完整保留 this 外洩、可覆寫方法禁令及註冊回呼背景啟動時機。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "去向種類",
      "history_id": "CL-05",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/classes-and-construction.md#java-explicit-dependencies"
      ],
      "reason": "共通寫需要延後或按次建立時「可注入」工廠或提供者，未直接承接 Java 原句「使用」的要求強度，故連同明確依賴與禁止隱藏查找整條保留。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "去向種類",
      "history_id": "CL-06",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/code-design.md#construction-entrypoints"
      ],
      "reason": "建構子具名工廠及 Builder 選擇與組裝暫存及不得產出無效目標均由共通建立方式原句承接。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "去向種類",
      "history_id": "CL-07",
      "decision": "保留條文／可能",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/classes-and-construction.md#java-override-scope"
      ],
      "reason": "依第四節「可能」及必須整條保留清單，完整保留擴充範圍、super 必要檢查及 final 與框架代理相容要求。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "去向種類",
      "history_id": "CL-08",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/code-design.md#interface-capabilities"
      ],
      "reason": "不機械拆分單一方法、同責任共用契約與執行期授權不得被取代均由共通能力劃分原句承接。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "去向種類",
      "history_id": "CL-09",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/resource-lifecycle.md#shared-lifecycle"
      ],
      "reason": "共用服務實例欄位的使用者訂單隔離及框架注入不保證執行緒安全生命週期均有直接原文承接。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "去向種類",
      "history_id": "CL-10",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/classes-and-construction.md#java-lifecycle-verification"
      ],
      "reason": "共通明列建立條件、替代契約與框架實際配置，但未逐字明列 Java 繼承、覆寫均須驗證實際路徑，故連同單純值物件免啟完整框架整條保留。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| Java 條文 | 語言增量驗收 |\n",
        "after": "| 對應要求 | 語言增量驗收 |\n",
        "reason": "驗收第一欄改為對應要求及現行語意小節連結，第二欄驗收內容逐字保留，不減少任何驗收條件。"
      }
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-construction-safety\"></a>4 | 審查 Java 建構路徑是否讓 `this` 外洩或呼叫可覆寫方法；以適用的註冊、回呼及背景啟動路徑確認物件完成建構且已就緒後才被使用。 |\n",
        "after": "| <a id=\"acceptance-java-construction-safety\"></a>[建構期間的安全性](#java-construction-safety) | 審查 Java 建構路徑是否讓 `this` 外洩或呼叫可覆寫方法；以適用的註冊、回呼及背景啟動路徑確認物件完成建構且已就緒後才被使用。 |\n",
        "reason": "驗收第一欄改為對應要求及現行語意小節連結，第二欄驗收內容逐字保留，不減少任何驗收條件。"
      }
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-override-safety\"></a>7 | 核對 Java 類別與方法的擴充範圍及覆寫方式，確認必要檢查不依賴子類記得呼叫 `super`。涉及代理或繼承式框架機制時，驗證實際配置仍維持原保證，不一律以加上或移除 `final` 當作修正。 |\n",
        "after": "| <a id=\"acceptance-java-override-safety\"></a>[控制繼承與覆寫範圍](#java-override-scope) | 核對 Java 類別與方法的擴充範圍及覆寫方式，確認必要檢查不依賴子類記得呼叫 `super`。涉及代理或繼承式框架機制時，驗證實際配置仍維持原保證，不一律以加上或移除 `final` 當作修正。 |\n",
        "reason": "驗收第一欄改為對應要求及現行語意小節連結，第二欄驗收內容逐字保留，不減少任何驗收條件。"
      }
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "sentence": 5,
      "history_id": "CL-02",
      "action": "移除",
      "source": "依[繼承的可替代性的共通要求](../../../coding/code-design.md#substitutability)執行。",
      "targets": [
        {
          "uri": "rules/coding/code-design.md#substitutability"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[繼承的可替代性的共通要求](../../../coding/code-design.md#substitutability)執行。",
          "source_uri": "rules/coding/code-design.md#substitutability",
          "source_text": "繼承須具有明確的可替代關係，子型別不得破壞父型別承諾的輸入、結果與行為保證。"
        }
      ],
      "reason": "本句僅為共通條文的執行引用，原連結已搬到檔頭固定引用入口；承接小節的完整政策原句登錄於被刪斷言，下一句另逐項核對。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "sentence": 6,
      "history_id": "CL-02",
      "action": "移除",
      "source": "Java 子類別須維持父型別輸入、結果及行為保證；僅共用實作時優先組合或委派。",
      "targets": [
        {
          "uri": "rules/coding/code-design.md#substitutability"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 子類別須維持父型別輸入、結果及行為保證",
          "source_uri": "rules/coding/code-design.md#substitutability",
          "source_text": "繼承須具有明確的可替代關係，子型別不得破壞父型別承諾的輸入、結果與行為保證。"
        },
        {
          "text": "僅共用實作時優先組合或委派",
          "source_uri": "rules/coding/code-design.md#substitutability",
          "source_text": "僅為共用實作時，優先採用組合或委派，不以不成立的繼承關係換取程式碼重用；若子型別無法支援父型別承諾的操作，須重新檢視契約與能力劃分。"
        }
      ],
      "reason": "父型別輸入結果行為與組合委派優先均由共通繼承可替代性兩句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "sentence": 7,
      "history_id": "CL-03",
      "action": "移除",
      "source": "依[必要資料與依賴齊備的共通要求](../../../coding/resource-lifecycle.md#initialization-readiness)執行。",
      "targets": [
        {
          "uri": "rules/coding/resource-lifecycle.md#initialization-readiness"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[必要資料與依賴齊備的共通要求](../../../coding/resource-lifecycle.md#initialization-readiness)執行。",
          "source_uri": "rules/coding/resource-lifecycle.md#initialization-readiness",
          "source_text": "物件建立完成時，須具備維持自身有效性所需的資料與必要依賴，不依賴呼叫端事後補設才能正常使用。"
        }
      ],
      "reason": "本句僅為共通條文的執行引用，原連結已搬到檔頭固定引用入口；承接小節的完整政策原句登錄於被刪斷言，下一句另逐項核對。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "sentence": 8,
      "history_id": "CL-03",
      "action": "移除",
      "source": "Java 建構完成須具備必要資料與依賴；外部連線或背景工作不必放在建構子，依明確生命週期啟動。",
      "targets": [
        {
          "uri": "rules/coding/resource-lifecycle.md#initialization-readiness"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 建構完成須具備必要資料與依賴",
          "source_uri": "rules/coding/resource-lifecycle.md#initialization-readiness",
          "source_text": "物件建立完成時，須具備維持自身有效性所需的資料與必要依賴，不依賴呼叫端事後補設才能正常使用。"
        },
        {
          "text": "外部連線或背景工作不必放在建構子",
          "source_uri": "rules/coding/resource-lifecycle.md#initialization-readiness",
          "source_text": "不因此要求建構子完成外部連線或啟動背景工作。"
        },
        {
          "text": "依明確生命週期啟動",
          "source_uri": "rules/coding/resource-lifecycle.md#initialization-readiness",
          "source_text": "需要分階段啟動的元件，須明訂生命週期與可用條件，未就緒前不得接受不符合條件的操作。"
        }
      ],
      "reason": "必要資料依賴、分階段生命週期與不要求建構子連線或啟動背景工作均有直接原文承接。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "sentence": 13,
      "history_id": "CL-06",
      "action": "移除",
      "source": "依[依需求選擇建立方式的共通要求](../../../coding/code-design.md#construction-entrypoints)執行。",
      "targets": [
        {
          "uri": "rules/coding/code-design.md#construction-entrypoints"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[依需求選擇建立方式的共通要求](../../../coding/code-design.md#construction-entrypoints)執行。",
          "source_uri": "rules/coding/code-design.md#construction-entrypoints",
          "source_text": "建構子、具名工廠方法或 Builder 須依資料組合、建立語意與呼叫可讀性選擇，不強制每個類別使用工廠或 Builder。"
        }
      ],
      "reason": "本句僅為共通條文的執行引用，原連結已搬到檔頭固定引用入口；承接小節的完整政策原句登錄於被刪斷言，下一句另逐項核對。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "sentence": 14,
      "history_id": "CL-06",
      "action": "移除",
      "source": "Java 可選建構子、具名工廠或 Builder；Builder 可暫存組裝中資料，但 `build` 不得產出無效物件。",
      "targets": [
        {
          "uri": "rules/coding/code-design.md#construction-entrypoints"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 可選建構子、具名工廠或 Builder",
          "source_uri": "rules/coding/code-design.md#construction-entrypoints",
          "source_text": "建構子、具名工廠方法或 Builder 須依資料組合、建立語意與呼叫可讀性選擇，不強制每個類別使用工廠或 Builder。"
        },
        {
          "text": "Builder 可暫存組裝中資料，但 `build` 不得產出無效物件",
          "source_uri": "rules/coding/code-design.md#construction-entrypoints",
          "source_text": "Builder 可暫存未完成的組裝資料，但不得產出無效的目標物件。"
        }
      ],
      "reason": "建構子具名工廠及 Builder 選擇與組裝暫存及不得產出無效目標均由共通建立方式原句承接。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "sentence": 18,
      "history_id": "CL-08",
      "action": "移除",
      "source": "依[介面的能力劃分的共通要求](../../../coding/code-design.md#interface-capabilities)執行。",
      "targets": [
        {
          "uri": "rules/coding/code-design.md#interface-capabilities"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[介面的能力劃分的共通要求](../../../coding/code-design.md#interface-capabilities)執行。",
          "source_uri": "rules/coding/code-design.md#interface-capabilities",
          "source_text": "介面須依內聚的能力與使用端需求劃分，避免迫使使用端依賴無關操作，或迫使實作提供不支援的方法。"
        }
      ],
      "reason": "本句僅為共通條文的執行引用，原連結已搬到檔頭固定引用入口；承接小節的完整政策原句登錄於被刪斷言，下一句另逐項核對。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "sentence": 19,
      "history_id": "CL-08",
      "action": "移除",
      "source": "Java 介面不機械式拆成單一方法；同一責任的操作可共用契約，執行時授權仍須另外檢查。",
      "targets": [
        {
          "uri": "rules/coding/code-design.md#interface-capabilities"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 介面不機械式拆成單一方法",
          "source_uri": "rules/coding/code-design.md#interface-capabilities",
          "source_text": "不機械式拆成單一方法介面，共同服務同一責任的操作可保留於同一契約；不得以介面可見範圍取代執行期授權檢查。"
        },
        {
          "text": "同一責任的操作可共用契約",
          "source_uri": "rules/coding/code-design.md#interface-capabilities",
          "source_text": "不機械式拆成單一方法介面，共同服務同一責任的操作可保留於同一契約；不得以介面可見範圍取代執行期授權檢查。"
        },
        {
          "text": "執行時授權仍須另外檢查",
          "source_uri": "rules/coding/code-design.md#interface-capabilities",
          "source_text": "不機械式拆成單一方法介面，共同服務同一責任的操作可保留於同一契約；不得以介面可見範圍取代執行期授權檢查。"
        }
      ],
      "reason": "不機械拆分單一方法、同責任共用契約與執行期授權不得被取代均由共通能力劃分原句承接。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "sentence": 20,
      "history_id": "CL-09",
      "action": "移除",
      "source": "依[生命週期與可變狀態相容的共通要求](../../../coding/resource-lifecycle.md#shared-lifecycle)執行。",
      "targets": [
        {
          "uri": "rules/coding/resource-lifecycle.md#shared-lifecycle"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[生命週期與可變狀態相容的共通要求](../../../coding/resource-lifecycle.md#shared-lifecycle)執行。",
          "source_uri": "rules/coding/resource-lifecycle.md#shared-lifecycle",
          "source_text": "物件的共用範圍、可變狀態與依賴生命週期須相容，不得讓單次操作資料洩漏到其他操作。"
        }
      ],
      "reason": "本句僅為共通條文的執行引用，原連結已搬到檔頭固定引用入口；承接小節的完整政策原句登錄於被刪斷言，下一句另逐項核對。"
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "sentence": 21,
      "history_id": "CL-09",
      "action": "移除",
      "source": "Java 共用服務的實例欄位不得存放會跨操作互相覆蓋的使用者或訂單；框架注入不代表執行緒安全或生命週期正確。",
      "targets": [
        {
          "uri": "rules/coding/resource-lifecycle.md#shared-lifecycle"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 共用服務的實例欄位不得存放會跨操作互相覆蓋的使用者或訂單",
          "source_uri": "rules/coding/resource-lifecycle.md#shared-lifecycle",
          "source_text": "例如共用服務不得以實例欄位存放會互相覆蓋的目前使用者或訂單。"
        },
        {
          "text": "框架注入不代表執行緒安全或生命週期正確",
          "source_uri": "rules/coding/resource-lifecycle.md#shared-lifecycle",
          "source_text": "由框架建立或注入，不代表自動具備執行緒安全與生命週期正確性。"
        }
      ],
      "reason": "共用服務實例欄位的使用者訂單隔離及框架注入不保證執行緒安全生命週期均有直接原文承接。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "去向種類",
      "history_id": "NT-01",
      "decision": "增量",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/numbers-dates-text.md#java-numeric-representation"
      ],
      "reason": "保留 BigDecimal 與最小單位整數的 Java 型別選擇及原有共同引用。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "去向種類",
      "history_id": "NT-02",
      "decision": "增量",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/numbers-dates-text.md#java-exact-numeric-sources"
      ],
      "reason": "保留浮點數轉 BigDecimal 無法恢復精度的 Java 限制與建立後業務驗證。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "去向種類",
      "history_id": "NT-03",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/numbers-dates-text.md#java-rounding-policy"
      ],
      "reason": "共通 nt-03 以可能損失精度的運算為條件，Java 原句涵蓋數值運算且明禁 API 預設決定；適用範圍與禁止條件未獲同一小節直接完整承接，整條保留原文。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "去向種類",
      "history_id": "NT-04",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/numbers-dates-text.md#numeric-range-checks"
      ],
      "reason": "縮窄轉型、溢位回繞、小數捨棄的明確檢查及強制轉型不得掩蓋超限，由共通 nt-04 前兩句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "去向種類",
      "history_id": "NT-05",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/numbers-dates-text.md#java-decimal-equivalence"
      ],
      "reason": "依第四節「否」保留全部 BigDecimal 判同、位數語意、正規化與相等雜湊排序一致要求。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "去向種類",
      "history_id": "NT-06",
      "decision": "增量",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/numbers-dates-text.md#java-temporal-representation"
      ],
      "reason": "保留 java.time、LocalDate、Instant、LocalDateTime 的具體型別選擇及時區偏移限制。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "去向種類",
      "history_id": "NT-07",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/numbers-dates-text.md#timezone-conversion"
      ],
      "reason": "契約時區或偏移及不存在或重複當地時間不得交由函式庫預設決策，由共通 nt-07 兩句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "去向種類",
      "history_id": "NT-08",
      "decision": "增量",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/numbers-dates-text.md#java-durations-calendar-periods"
      ],
      "reason": "保留 Duration、Period 與業務計算的 Java 選擇及營業日規則限制。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "去向種類",
      "history_id": "NT-09",
      "decision": "增量",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/numbers-dates-text.md#java-clock-source"
      ],
      "reason": "保留明確提供 Clock 的 Java 取時方式及耗時等待期限的單調時間來源。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "去向種類",
      "history_id": "NT-10",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/numbers-dates-text.md#java-temporal-parsing-formatting"
      ],
      "reason": "共通 nt-10 明訂必要的地區設定，Java 原句未加必要限定；無法直接證明地區設定義務的適用範圍完全一致，連同完整解析限制整條保留原文。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "去向種類",
      "history_id": "NT-11",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/numbers-dates-text.md#character-encoding"
      ],
      "reason": "明確字元編碼、不得依賴系統預設與不得未授權替換掩蓋損失，由共通 nt-11 前兩句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "去向種類",
      "history_id": "NT-12",
      "decision": "增量",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/numbers-dates-text.md#java-text-length-units"
      ],
      "reason": "保留 String.length() 的 UTF-16 單位語意與代理對及字元組合的截取限制。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "去向種類",
      "history_id": "NT-13",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/numbers-dates-text.md#text-transformations"
      ],
      "reason": "比較、大小寫、正規化的地區與用途及不得無意依賴預設，由共通 nt-13 第一與第三句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "去向種類",
      "history_id": "NT-14",
      "decision": "驗收入口",
      "expected": "轉為驗收入口",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/numbers-dates-text.md#java-boundary-verification"
      ],
      "reason": "依作業說明驗收入口整條保留，保留共同引用與 BigDecimal、java.time、Clock、字串實際路徑的表格驗收要求，交協調者決定。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| Java 條文 | 語言增量驗收 |\n",
        "after": "| 對應要求 | 語言增量驗收 |\n",
        "reason": "僅更新驗收第一欄為固定表頭或對應 Java 語意小節連結，第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-decimal-equivalence\"></a>5 | 以數值相同但小數位數不同及其他代表性資料，確認比較、正規化、雜湊與集合判同符合契約。 |\n",
        "after": "| <a id=\"acceptance-java-decimal-equivalence\"></a>[BigDecimal 判同語意](#java-decimal-equivalence) | 以數值相同但小數位數不同及其他代表性資料，確認比較、正規化、雜湊與集合判同符合契約。 |\n",
        "reason": "僅更新驗收第一欄為固定表頭或對應 Java 語意小節連結，第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-clock-injection\"></a>9 | 以注入的 Clock 驗證業務時間邊界前、當下與之後，核對實際 Java 取時路徑使用該 Clock。 |\n",
        "after": "| <a id=\"acceptance-java-clock-injection\"></a>[可控制的時間基準](#java-clock-source) | 以注入的 Clock 驗證業務時間邊界前、當下與之後，核對實際 Java 取時路徑使用該 Clock。 |\n",
        "reason": "僅更新驗收第一欄為固定表頭或對應 Java 語意小節連結，第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "sentence": 9,
      "history_id": "NT-04",
      "action": "移除",
      "source": "依[範圍與轉換檢查的共通要求](../../../coding/numbers-dates-text.md#numeric-range-checks)執行。",
      "targets": [
        {
          "uri": "rules/coding/numbers-dates-text.md#numeric-range-checks"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[範圍與轉換檢查的共通要求](../../../coding/numbers-dates-text.md#numeric-range-checks)執行。",
          "source_uri": "rules/coding/numbers-dates-text.md#numeric-range-checks",
          "source_text": "數值運算與轉換須維持目標型別及業務範圍限制，對可能溢位、縮小範圍或捨棄小數的操作採取明確檢查。"
        }
      ],
      "reason": "原句為共通 nt-04 的純引用入口，引用目標移至檔頭固定引用句，完整共通義務仍具約束力。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "sentence": 10,
      "history_id": "NT-04",
      "action": "移除",
      "source": "Java 縮窄轉型、整數溢位回繞與小數捨棄須明確檢查，不能用強制轉型掩蓋超限。",
      "targets": [
        {
          "uri": "rules/coding/numbers-dates-text.md#numeric-range-checks"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 縮窄轉型、整數溢位回繞與小數捨棄須明確檢查",
          "source_uri": "rules/coding/numbers-dates-text.md#numeric-range-checks",
          "source_text": "數值運算與轉換須維持目標型別及業務範圍限制，對可能溢位、縮小範圍或捨棄小數的操作採取明確檢查。"
        },
        {
          "text": "不能用強制轉型掩蓋超限",
          "source_uri": "rules/coding/numbers-dates-text.md#numeric-range-checks",
          "source_text": "不得以強制轉型、溢位回繞或未授權截斷掩蓋超限與精度損失。"
        }
      ],
      "reason": "縮窄轉型、溢位回繞、小數捨棄的明確檢查及強制轉型不得掩蓋超限，由共通 nt-04 前兩句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "sentence": 16,
      "history_id": "NT-07",
      "action": "移除",
      "source": "依[明確的時區轉換的共通要求](../../../coding/numbers-dates-text.md#timezone-conversion)執行。",
      "targets": [
        {
          "uri": "rules/coding/numbers-dates-text.md#timezone-conversion"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[明確的時區轉換的共通要求](../../../coding/numbers-dates-text.md#timezone-conversion)執行。",
          "source_uri": "rules/coding/numbers-dates-text.md#timezone-conversion",
          "source_text": "日期時間轉換須明確指定契約要求的時區或偏移，不得無意依賴系統預設時區。"
        }
      ],
      "reason": "原句為共通 nt-07 的純引用入口，引用目標移至檔頭固定引用句，完整共通義務仍具約束力。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "sentence": 17,
      "history_id": "NT-07",
      "action": "移除",
      "source": "Java 時區轉換須明確指定契約時區或偏移，不讓函式庫預設決定不存在或重複當地時間的業務處置。",
      "targets": [
        {
          "uri": "rules/coding/numbers-dates-text.md#timezone-conversion"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 時區轉換須明確指定契約時區或偏移",
          "source_uri": "rules/coding/numbers-dates-text.md#timezone-conversion",
          "source_text": "日期時間轉換須明確指定契約要求的時區或偏移，不得無意依賴系統預設時區。"
        },
        {
          "text": "不讓函式庫預設決定不存在或重複當地時間的業務處置",
          "source_uri": "rules/coding/numbers-dates-text.md#timezone-conversion",
          "source_text": "當地時間可能不存在或對應多個時點時，須明訂拒絕、調整或補充資訊等判定與處理規則，不以函式庫預設行為取代業務決策。"
        }
      ],
      "reason": "契約時區或偏移及不存在或重複當地時間不得交由函式庫預設決策，由共通 nt-07 兩句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "sentence": 24,
      "history_id": "NT-11",
      "action": "移除",
      "source": "依[明確指定字元編碼的共通要求](../../../coding/numbers-dates-text.md#character-encoding)執行。",
      "targets": [
        {
          "uri": "rules/coding/numbers-dates-text.md#character-encoding"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[明確指定字元編碼的共通要求](../../../coding/numbers-dates-text.md#character-encoding)執行。",
          "source_uri": "rules/coding/numbers-dates-text.md#character-encoding",
          "source_text": "文字與位元組轉換須明確使用契約指定的字元編碼，不依賴系統預設。"
        }
      ],
      "reason": "原句為共通 nt-11 的純引用入口，引用目標移至檔頭固定引用句，完整共通義務仍具約束力。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "sentence": 25,
      "history_id": "NT-11",
      "action": "移除",
      "source": "Java 文字與位元組轉換明確指定字元編碼；不得靠系統預設或未授權替換掩蓋資料損失。",
      "targets": [
        {
          "uri": "rules/coding/numbers-dates-text.md#character-encoding"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 文字與位元組轉換明確指定字元編碼",
          "source_uri": "rules/coding/numbers-dates-text.md#character-encoding",
          "source_text": "文字與位元組轉換須明確使用契約指定的字元編碼，不依賴系統預設。"
        },
        {
          "text": "不得靠系統預設",
          "source_uri": "rules/coding/numbers-dates-text.md#character-encoding",
          "source_text": "文字與位元組轉換須明確使用契約指定的字元編碼，不依賴系統預設。"
        },
        {
          "text": "或未授權替換掩蓋資料損失",
          "source_uri": "rules/coding/numbers-dates-text.md#character-encoding",
          "source_text": "無效編碼或無法表示的字元須依契約拒絕或處理，不得未經允許替換而掩蓋資料損失。"
        }
      ],
      "reason": "明確字元編碼、不得依賴系統預設與不得未授權替換掩蓋損失，由共通 nt-11 前兩句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "sentence": 28,
      "history_id": "NT-13",
      "action": "移除",
      "source": "依[用途明確的文字轉換的共通要求](../../../coding/numbers-dates-text.md#text-transformations)執行。",
      "targets": [
        {
          "uri": "rules/coding/numbers-dates-text.md#text-transformations"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[用途明確的文字轉換的共通要求](../../../coding/numbers-dates-text.md#text-transformations)執行。",
          "source_uri": "rules/coding/numbers-dates-text.md#text-transformations",
          "source_text": "文字比較、大小寫轉換及正規化須明訂適用範圍、地區設定與等價規則，不無意依賴系統預設。"
        }
      ],
      "reason": "原句為共通 nt-13 的純引用入口，引用目標移至檔頭固定引用句，完整共通義務仍具約束力。"
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "sentence": 29,
      "history_id": "NT-13",
      "action": "移除",
      "source": "Java 字串比較、大小寫與正規化須使用明確地區及用途，不無意依賴環境預設。",
      "targets": [
        {
          "uri": "rules/coding/numbers-dates-text.md#text-transformations"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 字串比較、大小寫與正規化須使用明確地區及用途",
          "source_uri": "rules/coding/numbers-dates-text.md#text-transformations",
          "source_text": "文字比較、大小寫轉換及正規化須明訂適用範圍、地區設定與等價規則，不無意依賴系統預設。"
        },
        {
          "text": "Java 字串比較、大小寫與正規化須使用明確地區及用途",
          "source_uri": "rules/coding/numbers-dates-text.md#text-transformations",
          "source_text": "去除空白、Unicode 正規化及全形半形轉換均依用途決定，不將協定代碼規則直接套用到自然語言資料。"
        },
        {
          "text": "不無意依賴環境預設",
          "source_uri": "rules/coding/numbers-dates-text.md#text-transformations",
          "source_text": "文字比較、大小寫轉換及正規化須明訂適用範圍、地區設定與等價規則，不無意依賴系統預設。"
        }
      ],
      "reason": "比較、大小寫、正規化的地區與用途及不得無意依賴預設，由共通 nt-13 第一與第三句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "去向種類",
      "history_id": "EX-01",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/exceptions-and-resources.md#java-exception-classification"
      ],
      "reason": "依第四節「否」保留增量，完整保留例外型別選擇、標準或第三方例外適用條件與邊界轉換故障語意。"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "去向種類",
      "history_id": "EX-02",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/exceptions-and-resources.md#java-checked-unchecked"
      ],
      "reason": "依第四節「否」保留增量，完整保留 Checked／Unchecked 選擇、宣告捕捉責任及不得據編譯器檢查推定恢復重試。"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "去向種類",
      "history_id": "EX-03",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/exceptions-and-resources.md#java-catch-scope"
      ],
      "reason": "依第四節「否」保留增量，完整保留具體捕捉與 try 範圍、入口處置責任及 Throwable／Error 的限制。"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "去向種類",
      "history_id": "EX-04",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/exceptions-and-resources.md#java-interruption"
      ],
      "reason": "依第四節「否」保留增量，完整保留 InterruptedException 傳遞、恢復旗標、停止取消及必要清理義務。"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "去向種類",
      "history_id": "EX-05",
      "decision": "保留條文／可能",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/exceptions-and-resources.md#java-resource-management"
      ],
      "reason": "依第四節「可能」及必須整條保留清單，逐字保留 AutoCloseable、try-with-resources、所有權及不得依賴垃圾回收要求。"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "去向種類",
      "history_id": "EX-06",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/exceptions-and-resources.md#java-suppressed-failures"
      ],
      "reason": "依第四節「否」保留增量，完整保留 suppressed exceptions、try-with-resources、finally 控制流程及單獨清理失敗處置。"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "去向種類",
      "history_id": "EX-07",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/resource-lifecycle.md#partial-acquisition"
      ],
      "reason": "依第三節「重述」整條移除；共通 ex-07 逐句承接多資源或初始化失敗清理、正式移交前責任與依賴釋放順序。"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "去向種類",
      "history_id": "EX-08",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/resource-lifecycle.md#resource-close-contract"
      ],
      "reason": "依第三節「重述」整條移除；共通 ex-08 直接涵蓋非同步實際使用期間、不得提前關閉及不得假設重複關閉安全。"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "去向種類",
      "history_id": "EX-09",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/exceptions-and-resources.md#java-failure-coverage"
      ],
      "reason": "依第四節「否」保留增量，完整保留故障、中斷、部分初始化與清理失敗覆蓋、實際框架配置及不要求每方法涵蓋全部情境。"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| Java 條文 | 語言增量驗收 |\n",
        "after": "| 對應要求 | 語言增量驗收 |\n",
        "reason": "驗收表統一對應要求表頭並以語意錨點取代原條號，第二欄的所有驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-exception-contract\"></a>1、2、3 | 核對 Java 例外型別、Checked／Unchecked 宣告、邊界轉換及 `try`／捕捉範圍與處置責任一致；以適用故障來源驗證業務失敗、技術故障與程式缺陷沒有混淆，包裝後仍保留原始原因。 |\n",
        "after": "| <a id=\"acceptance-java-exception-contract\"></a>[明確的故障分類](#java-exception-classification)、[Checked 與 Unchecked 的選擇](#java-checked-unchecked)、[捕捉範圍與處置相符](#java-catch-scope) | 核對 Java 例外型別、Checked／Unchecked 宣告、邊界轉換及 `try`／捕捉範圍與處置責任一致；以適用故障來源驗證業務失敗、技術故障與程式缺陷沒有混淆，包裝後仍保留原始原因。 |\n",
        "reason": "驗收表統一對應要求表頭並以語意錨點取代原條號，第二欄的所有驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-interruption\"></a>4 | 對可中斷的 Java 操作送出中斷，確認 `InterruptedException` 依契約向上傳遞；無法傳遞時恢復中斷旗標並停止或取消。核對沒有吞掉後繼續等待、執行或重試，必要清理仍完成。 |\n",
        "after": "| <a id=\"acceptance-java-interruption\"></a>[保留中斷意圖](#java-interruption) | 對可中斷的 Java 操作送出中斷，確認 `InterruptedException` 依契約向上傳遞；無法傳遞時恢復中斷旗標並停止或取消。核對沒有吞掉後繼續等待、執行或重試，必要清理仍完成。 |\n",
        "reason": "驗收表統一對應要求表頭並以語意錨點取代原條號，第二欄的所有驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-resource-closing\"></a>5 | 以正常完成、提前退出及操作失敗路徑核對 Java 自行擁有的 `AutoCloseable`／`try-with-resources` 資源確實釋放，借用或框架管理資源未被擅自關閉；非區域生命週期有明確釋放責任，不依賴垃圾回收。 |\n",
        "after": "| <a id=\"acceptance-java-resource-closing\"></a>[優先使用語言資源管理機制](#java-resource-management) | 以正常完成、提前退出及操作失敗路徑核對 Java 自行擁有的 `AutoCloseable`／`try-with-resources` 資源確實釋放，借用或框架管理資源未被擅自關閉；非區域生命週期有明確釋放責任，不依賴垃圾回收。 |\n",
        "reason": "驗收表統一對應要求表頭並以語意錨點取代原條號，第二欄的所有驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-suppressed-failures\"></a>6 | 模擬 Java 操作與清理同時失敗，確認原始故障及 suppressed exceptions 或相應關係可追查，沒有被 `finally` 控制流程覆蓋；另驗證只有清理失敗時的完成判定與回報。 |\n",
        "after": "| <a id=\"acceptance-java-suppressed-failures\"></a>[保留操作與清理失敗](#java-suppressed-failures) | 模擬 Java 操作與清理同時失敗，確認原始故障及 suppressed exceptions 或相應關係可追查，沒有被 `finally` 控制流程覆蓋；另驗證只有清理失敗時的完成判定與回報。 |\n",
        "reason": "驗收表統一對應要求表頭並以語意錨點取代原條號，第二欄的所有驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "acceptance_text_changes",
      "record": {
        "before": "依第 9 條核對本次案例涵蓋受影響的 Java 故障、中斷、部分初始化與清理路徑；依賴框架的保證須經實際生命週期驗證，不只測替身或成功流程。\n",
        "after": "依[失敗路徑驗收](#java-failure-coverage)核對本次案例涵蓋受影響的 Java 故障、中斷、部分初始化與清理路徑；依賴框架的保證須經實際生命週期驗證，不只測替身或成功流程。\n",
        "reason": "依特別注意事項只將第九條定位替換成失敗路徑驗收語意錨點，其餘覆蓋與框架驗證文字逐字不動。",
        "references": [
          {
            "before": "第 9 條",
            "after": "[失敗路徑驗收](#java-failure-coverage)"
          }
        ]
      }
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "sentence": 20,
      "history_id": "EX-07",
      "action": "移除",
      "source": "依[部分取得與所有權移交的共通要求](../../../coding/resource-lifecycle.md#partial-acquisition)執行。",
      "targets": [
        {
          "uri": "rules/coding/resource-lifecycle.md#partial-acquisition"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[部分取得與所有權移交的共通要求](../../../coding/resource-lifecycle.md#partial-acquisition)執行。",
          "source_uri": "rules/coding/resource-lifecycle.md#partial-acquisition",
          "source_text": "多資源取得或元件初始化須涵蓋部分成功後的失敗清理。"
        },
        {
          "text": "依[部分取得與所有權移交的共通要求](../../../coding/resource-lifecycle.md#partial-acquisition)執行。",
          "source_uri": "rules/coding/resource-lifecycle.md#partial-acquisition",
          "source_text": "所有權正式移交前，由取得方負責釋放已取得資源；移交後由新的擁有者依契約管理。"
        },
        {
          "text": "依[部分取得與所有權移交的共通要求](../../../coding/resource-lifecycle.md#partial-acquisition)執行。",
          "source_uri": "rules/coding/resource-lifecycle.md#partial-acquisition",
          "source_text": "釋放順序須符合資源依賴，避免先關閉仍被其他資源使用的底層資源，不得因建立未完成或責任移交不明造成洩漏。"
        }
      ],
      "reason": "原句僅引用共通 ex-07，引用目標保留在檔頭；該小節完整原文直接承接原引用的全部要求。"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "sentence": 21,
      "history_id": "EX-07",
      "action": "移除",
      "source": "Java 多資源取得及建構失敗亦須清理；資源移交前仍由取得方負責，釋放順序遵循依賴。",
      "targets": [
        {
          "uri": "rules/coding/resource-lifecycle.md#partial-acquisition"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 多資源取得及建構失敗亦須清理",
          "source_uri": "rules/coding/resource-lifecycle.md#partial-acquisition",
          "source_text": "多資源取得或元件初始化須涵蓋部分成功後的失敗清理。"
        },
        {
          "text": "資源移交前仍由取得方負責",
          "source_uri": "rules/coding/resource-lifecycle.md#partial-acquisition",
          "source_text": "所有權正式移交前，由取得方負責釋放已取得資源；移交後由新的擁有者依契約管理。"
        },
        {
          "text": "釋放順序遵循依賴",
          "source_uri": "rules/coding/resource-lifecycle.md#partial-acquisition",
          "source_text": "釋放順序須符合資源依賴，避免先關閉仍被其他資源使用的底層資源，不得因建立未完成或責任移交不明造成洩漏。"
        }
      ],
      "reason": "多資源取得與建構失敗由部分成功後失敗清理承接，移交前取得方責任及依賴釋放順序各由共通完整原句承接。"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "sentence": 22,
      "history_id": "EX-08",
      "action": "移除",
      "source": "依[有效期與關閉契約的共通要求](../../../coding/resource-lifecycle.md#resource-close-contract)執行。",
      "targets": [
        {
          "uri": "rules/coding/resource-lifecycle.md#resource-close-contract"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[有效期與關閉契約的共通要求](../../../coding/resource-lifecycle.md#resource-close-contract)執行。",
          "source_uri": "rules/coding/resource-lifecycle.md#resource-close-contract",
          "source_text": "資源有效期須涵蓋實際使用期間，包含委派或非同步工作；關閉後不得再使用。"
        },
        {
          "text": "依[有效期與關閉契約的共通要求](../../../coding/resource-lifecycle.md#resource-close-contract)執行。",
          "source_uri": "rules/coding/resource-lifecycle.md#resource-close-contract",
          "source_text": "可關閉元件須明訂關閉後操作與重複關閉的處理方式，不得提前關閉仍在使用的資源，也不得無依據地假設關閉操作可重複執行。"
        },
        {
          "text": "依[有效期與關閉契約的共通要求](../../../coding/resource-lifecycle.md#resource-close-contract)執行。",
          "source_uri": "rules/coding/resource-lifecycle.md#resource-close-contract",
          "source_text": "將資源交給背景工作時，須調整擁有者與使用範圍，而非讓原方法結束就提前釋放。"
        }
      ],
      "reason": "原句僅引用共通 ex-08，引用目標保留在檔頭；該小節完整原文直接承接原引用的全部要求。"
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "sentence": 23,
      "history_id": "EX-08",
      "action": "移除",
      "source": "Java `AutoCloseable` 資源不可在非同步工作仍使用時提前關閉，不無依據假設所有 `close()` 都可重複呼叫。",
      "targets": [
        {
          "uri": "rules/coding/resource-lifecycle.md#resource-close-contract"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java `AutoCloseable` 資源不可在非同步工作仍使用時提前關閉",
          "source_uri": "rules/coding/resource-lifecycle.md#resource-close-contract",
          "source_text": "資源有效期須涵蓋實際使用期間，包含委派或非同步工作；關閉後不得再使用。"
        },
        {
          "text": "Java `AutoCloseable` 資源不可在非同步工作仍使用時提前關閉",
          "source_uri": "rules/coding/resource-lifecycle.md#resource-close-contract",
          "source_text": "可關閉元件須明訂關閉後操作與重複關閉的處理方式，不得提前關閉仍在使用的資源，也不得無依據地假設關閉操作可重複執行。"
        },
        {
          "text": "不無依據假設所有 `close()` 都可重複呼叫",
          "source_uri": "rules/coding/resource-lifecycle.md#resource-close-contract",
          "source_text": "可關閉元件須明訂關閉後操作與重複關閉的處理方式，不得提前關閉仍在使用的資源，也不得無依據地假設關閉操作可重複執行。"
        }
      ],
      "reason": "AutoCloseable 與 close 名稱未增加限制；非同步使用期間不得提前關閉及不得假設重複關閉各由共通明文直接承接。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "去向種類",
      "history_id": "ST-01",
      "decision": "保留條文／是",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/states-and-results.md#java-explicit-state-types"
      ],
      "reason": "依選 B 整條保留互斥型別、enum 選擇及不同業務面向分別建模與相互限制，不抽取共同背景。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "去向種類",
      "history_id": "ST-02",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/states-and-results.md#java-required-state-data"
      ],
      "reason": "共通狀態建模以不同狀態需要不同資料為條件，未直接寫出不得只用狀態碼搭配多個可空欄位讓使用端推測，故整條保留。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "去向種類",
      "history_id": "ST-03",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/states-and-results.md#java-business-state-transitions"
      ],
      "reason": "共通禁止任意修改狀態欄位可涵蓋 setter 限制，但未直接明訂修改既有物件或產生新狀態物件由模型決定，故整條保留。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "去向種類",
      "history_id": "ST-04",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/domain-modeling.md#operation-results"
      ],
      "reason": "使用端所需區別與資料及不要求複雜結果物件由共通 st-04 完整原句直接承接，移除重述並在引言保留原引用。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "去向種類",
      "history_id": "ST-05",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/states-and-results.md#java-typed-business-failures"
      ],
      "reason": "共通要求明確結果型別及可辨識原因，未直接列不同失敗型別或具型別原因代碼選擇，且例外句限定非預期技術故障，故整條保留。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "去向種類",
      "history_id": "ST-06",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/domain-modeling.md#exhaustive-result-handling"
      ],
      "reason": "編譯檢查優先、測試審查補足及不得以 default 將未知狀態當成功由共通 st-06 的編譯檢查及預設分支兩句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "去向種類",
      "history_id": "ST-07",
      "decision": "保留條文／可能",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/states-and-results.md#java-stable-external-codes"
      ],
      "reason": "依第四節可能新增義務判斷整條保留，包含 ordinal 禁止、列舉名稱相容性、未知代碼及不強制轉換類別的範圍。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "去向種類",
      "history_id": "ST-08",
      "decision": "增量",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/states-and-results.md#java-model-extensibility"
      ],
      "reason": "依增量判斷保留 sealed 版本能力與其他版本使用可見性、建立入口及檢查的落實方式，原共通引用一併保留。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "去向種類",
      "history_id": "ST-09",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/domain-modeling.md#result-facts"
      ],
      "reason": "可變業務參考不得改變當時事實及只隔離必要資料、不要求完整複製，由共通 st-09 兩句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "去向種類",
      "history_id": "ST-10",
      "decision": "驗收入口",
      "expected": "轉為驗收入口",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/states-and-results.md#java-model-acceptance"
      ],
      "reason": "依作業說明將驗收入口整條保留，Java 狀態型別、分支、enum 外部代碼、封閉模型與實際副作用均不刪，交協調者決定。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| Java 條文 | 語言增量驗收 |\n",
        "after": "| 對應要求 | 語言增量驗收 |\n",
        "reason": "驗收第一欄改為對應要求及現行 Java 語意小節連結，原有第二欄驗收條件與案例逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-independent-state-models\"></a>1、2 | 審查互斥狀態與獨立業務面向是否正確分開，必要資料是否由對應型別保護。確認不能建立契約禁止的狀態與資料組合，不以僅存在狀態碼作為符合依據。 |\n",
        "after": "| <a id=\"acceptance-java-independent-state-models\"></a>[明確的狀態型別](#java-explicit-state-types)、[各狀態的必要資料](#java-required-state-data) | 審查互斥狀態與獨立業務面向是否正確分開，必要資料是否由對應型別保護。確認不能建立契約禁止的狀態與資料組合，不以僅存在狀態碼作為符合依據。 |\n",
        "reason": "驗收第一欄改為對應要求及現行 Java 語意小節連結，原有第二欄驗收條件與案例逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-state-transition\"></a>3 | 驗證允許與不允許的來源狀態、前置條件及轉換後資料。確認公開介面沒有可繞過規則的任意設定路徑，拒絕時未產生不應發生的副作用。 |\n",
        "after": "| <a id=\"acceptance-java-state-transition\"></a>[業務操作控制轉換](#java-business-state-transitions) | 驗證允許與不允許的來源狀態、前置條件及轉換後資料。確認公開介面沒有可繞過規則的任意設定路徑，拒絕時未產生不應發生的副作用。 |\n",
        "reason": "驗收第一欄改為對應要求及現行 Java 語意小節連結，原有第二欄驗收條件與案例逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-enum-codes\"></a>7 | 經適用的傳輸或持久化路徑驗證外部代碼與狀態對應，未知代碼依契約處理。確認未使用 `ordinal()` 作為業務代碼，採用列舉名稱時已評估重新命名的相容性影響。 |\n",
        "after": "| <a id=\"acceptance-java-enum-codes\"></a>[穩定的外部代碼](#java-stable-external-codes) | 經適用的傳輸或持久化路徑驗證外部代碼與狀態對應，未知代碼依契約處理。確認未使用 `ordinal()` 作為業務代碼，採用列舉名稱時已評估重新命名的相容性影響。 |\n",
        "reason": "驗收第一欄改為對應要求及現行 Java 語意小節連結，原有第二欄驗收條件與案例逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "sentence": 10,
      "history_id": "ST-04",
      "action": "移除",
      "source": "依[結果與目前狀態分開表達的共通要求](../../../coding/domain-modeling.md#operation-results)執行。",
      "targets": [
        {
          "uri": "rules/coding/domain-modeling.md#operation-results"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[結果與目前狀態分開表達的共通要求](../../../coding/domain-modeling.md#operation-results)執行。",
          "source_uri": "rules/coding/domain-modeling.md#operation-results",
          "source_text": "結果型別只包含使用端所需的區別與資料，不要求每次操作都建立複雜結果物件。"
        }
      ],
      "reason": "本句僅引用 ST-04 的共通小節，移除引用句後以檔頭固定指路保留同一目標，實際承接依據取自該共通小節完整原句。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "sentence": 11,
      "history_id": "ST-04",
      "action": "移除",
      "source": "Java 結果型別只保留使用端需要的區別及資料，不要求每個操作建立複雜物件。",
      "targets": [
        {
          "uri": "rules/coding/domain-modeling.md#operation-results"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 結果型別只保留使用端需要的區別及資料，不要求每個操作建立複雜物件。",
          "source_uri": "rules/coding/domain-modeling.md#operation-results",
          "source_text": "結果型別只包含使用端所需的區別與資料，不要求每次操作都建立複雜結果物件。"
        }
      ],
      "reason": "使用端所需區別與資料及不要求複雜結果物件由共通 st-04 完整原句直接承接，移除重述並在引言保留原引用。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "sentence": 14,
      "history_id": "ST-06",
      "action": "移除",
      "source": "依[處理完整性的共通要求](../../../coding/domain-modeling.md#exhaustive-result-handling)執行。",
      "targets": [
        {
          "uri": "rules/coding/domain-modeling.md#exhaustive-result-handling"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[處理完整性的共通要求](../../../coding/domain-modeling.md#exhaustive-result-handling)執行。",
          "source_uri": "rules/coding/domain-modeling.md#exhaustive-result-handling",
          "source_text": "優先利用適用版本的編譯檢查，並由測試與審查補足工具無法涵蓋的部分。"
        }
      ],
      "reason": "本句僅引用 ST-06 的共通小節，移除引用句後以檔頭固定指路保留同一目標，實際承接依據取自該共通小節完整原句。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "sentence": 15,
      "history_id": "ST-06",
      "action": "移除",
      "source": "Java 優先利用適用版本的編譯檢查；工具無法涵蓋的分支由測試及審查補足，不以 `default` 將未知狀態當成功。",
      "targets": [
        {
          "uri": "rules/coding/domain-modeling.md#exhaustive-result-handling"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 優先利用適用版本的編譯檢查；工具無法涵蓋的分支由測試及審查補足",
          "source_uri": "rules/coding/domain-modeling.md#exhaustive-result-handling",
          "source_text": "優先利用適用版本的編譯檢查，並由測試與審查補足工具無法涵蓋的部分。"
        },
        {
          "text": "不以 `default` 將未知狀態當成功",
          "source_uri": "rules/coding/domain-modeling.md#exhaustive-result-handling",
          "source_text": "狀態與結果的使用端須明確處理契約要求的情況，不得以預設分支將新增、未知或未處理的情況當成成功或默默忽略。"
        }
      ],
      "reason": "編譯檢查優先、測試審查補足及不得以 default 將未知狀態當成功由共通 st-06 的編譯檢查及預設分支兩句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "sentence": 22,
      "history_id": "ST-09",
      "action": "移除",
      "source": "依[結果保留當時事實的共通要求](../../../coding/domain-modeling.md#result-facts)執行。",
      "targets": [
        {
          "uri": "rules/coding/domain-modeling.md#result-facts"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[結果保留當時事實的共通要求](../../../coding/domain-modeling.md#result-facts)執行。",
          "source_uri": "rules/coding/domain-modeling.md#result-facts",
          "source_text": "操作結果須穩定表達產生當時可確認的事實，必要資料不得因外部可變參考而改變。"
        }
      ],
      "reason": "本句僅引用 ST-09 的共通小節，移除引用句後以檔頭固定指路保留同一目標，實際承接依據取自該共通小節完整原句。"
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "sentence": 23,
      "history_id": "ST-09",
      "action": "移除",
      "source": "Java 結果不可持有會改變已確認事實的可變業務參考；只隔離必要資料，不要求複製完整物件。",
      "targets": [
        {
          "uri": "rules/coding/domain-modeling.md#result-facts"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 結果不可持有會改變已確認事實的可變業務參考",
          "source_uri": "rules/coding/domain-modeling.md#result-facts",
          "source_text": "操作結果須穩定表達產生當時可確認的事實，必要資料不得因外部可變參考而改變。"
        },
        {
          "text": "只隔離必要資料，不要求複製完整物件",
          "source_uri": "rules/coding/domain-modeling.md#result-facts",
          "source_text": "只保留契約所需資訊，不要求複製完整物件；最新狀態另行查詢，不以持有可變業務物件代替結果資料。"
        }
      ],
      "reason": "可變業務參考不得改變當時事實及只隔離必要資料、不要求完整複製，由共通 st-09 兩句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "去向種類",
      "history_id": "CA-01",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/concurrency-and-async.md#task-ownership",
        "rules/coding/concurrency-and-async.md#async-result-reception"
      ],
      "reason": "工作脫離呼叫流程的接手元件與結果處置，由 ca-01 的擁有者、責任移交及背景元件接手三句完整承接。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "去向種類",
      "history_id": "CA-02",
      "decision": "混合",
      "expected": "拆分",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/concurrency-and-async.md#java-execution-resources"
      ],
      "reason": "第八次審閱 CA-02：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "去向種類",
      "history_id": "CA-03",
      "decision": "保留條文／是",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/concurrency-and-async.md#java-visibility-sharing"
      ],
      "reason": "依選 B 與必須整條保留清單，逐字保留可見性交付、不可變資料、隔離快照、同步原子性及 volatile 限制。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "去向種類",
      "history_id": "CA-04",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/concurrency-and-async.md#deadline-budget"
      ],
      "reason": "逾時不等於底層停止及等待 API 承接整體時間預算，由 ca-04 的等待期限與不得視為工作停止兩句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "去向種類",
      "history_id": "CA-05",
      "decision": "增量",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/concurrency-and-async.md#java-cancellation-propagation"
      ],
      "reason": "保留 Java 取消訊號、中斷與最外層 Future 取消不等於全部子工作停止的特定機制，原共同取消契約引用不變。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "去向種類",
      "history_id": "CA-06",
      "decision": "保留條文／是",
      "expected": "拆分",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/concurrency-and-async.md#java-result-reception"
      ],
      "reason": "共通 async-result-reception 未直接明訂忽略回傳工作控制物件的失效情境；Future、CompletableFuture 與結果鏈亦屬 Java 增量，故保守整條保留；補連結被工具判為未申報刪字，已還原原句而不改工具。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "去向種類",
      "history_id": "CA-07",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/concurrency-and-async.md#java-task-completion"
      ],
      "reason": "共通 ca-07 正文明訂完成條件與剩餘工作處置，但未直接要求驗證完成順序；不以驗收反推正文覆蓋，保守整條保留 Java 驗證要求。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "去向種類",
      "history_id": "CA-08",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/concurrency-and-async.md#java-execution-location"
      ],
      "reason": "第八次審閱 CA-08：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "去向種類",
      "history_id": "CA-09",
      "decision": "增量",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/concurrency-and-async.md#java-context-propagation"
      ],
      "reason": "保留 ThreadLocal 與日誌脈絡不自動沿用的 Java 失效情境及共用執行緒結束時清理還原要求，既有共通引用不變。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "去向種類",
      "history_id": "CA-10",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/concurrency-and-async.md#java-lock-scope"
      ],
      "reason": "第八次審閱 CA-10：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "去向種類",
      "history_id": "CA-11",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/concurrency-and-async.md#java-controlled-shutdown"
      ],
      "reason": "共通 ca-11 明訂關閉處置及不得將開始關閉視為工作結束，但正文未直接寫出實際關閉與資源釋放依契約驗證；為保留驗證動作整條原樣留下。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "去向種類",
      "history_id": "CA-12",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/concurrency-and-async.md#java-controlled-verification"
      ],
      "reason": "共通 ca-12 要求同步設計審查，但未直接列出可見性設計審查；不能以同步概念推定可見性交付已涵蓋，故整條逐字保留。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| Java 條文 | 語言增量驗收 |\n",
        "after": "| 對應要求 | 語言增量驗收 |\n",
        "reason": "統一驗收表頭與第一欄語意小節連結，第二欄全部驗收內容逐字保留，未減少既有驗證範圍。"
      }
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-visibility\"></a>3 | 審查 Java 跨執行緒資料交付的可見性保證、共享資料的同步範圍及適用的鎖定方式；以受控交錯核對不變條件與共享狀態，不能只以單一 `volatile` 欄位或偶然成功推定整個物件安全。 |\n",
        "after": "| <a id=\"acceptance-java-visibility\"></a>[可見性與共享資料](#java-visibility-sharing) | 審查 Java 跨執行緒資料交付的可見性保證、共享資料的同步範圍及適用的鎖定方式；以受控交錯核對不變條件與共享狀態，不能只以單一 `volatile` 欄位或偶然成功推定整個物件安全。 |\n",
        "reason": "統一驗收表頭與第一欄語意小節連結，第二欄全部驗收內容逐字保留，未減少既有驗證範圍。"
      }
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-task-results\"></a>6 | 沿 Java `Future`／`CompletableFuture` 的實際接收及結果鏈路徑觸發成功、失敗與取消，核對故障可追查、原始原因與分類保留，且未以替代值把失敗變成成功。 |\n",
        "after": "| <a id=\"acceptance-java-task-results\"></a>[結果接收與故障處置](#java-result-reception) | 沿 Java `Future`／`CompletableFuture` 的實際接收及結果鏈路徑觸發成功、失敗與取消，核對故障可追查、原始原因與分類保留，且未以替代值把失敗變成成功。 |\n",
        "reason": "統一驗收表頭與第一欄語意小節連結，第二欄全部驗收內容逐字保留，未減少既有驗證範圍。"
      }
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "acceptance_additions",
      "record": "- [結果接收與故障處置](../../../coding/concurrency-and-async.md#acceptance-result-reception)。\n"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "sentence": 3,
      "history_id": "CA-01",
      "action": "移除",
      "source": "依[明確的工作擁有者的共通要求](../../../coding/concurrency-and-async.md#task-ownership)執行。",
      "targets": [
        {
          "uri": "rules/coding/concurrency-and-async.md#task-ownership"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[明確的工作擁有者的共通要求](../../../coding/concurrency-and-async.md#task-ownership)執行。",
          "source_uri": "rules/coding/concurrency-and-async.md#task-ownership",
          "source_text": "併發與非同步工作須有明確的生命週期擁有者，依[結果接收與故障處置](#async-result-reception)追蹤結果及處理失敗，並管理取消與資源。"
        }
      ],
      "reason": "此句只引用既有共通規則，要求仍由同一共通錨點承接；原連結另外保留於檔頭固定指路句，沒有改變引用範圍或增加例外。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "sentence": 4,
      "history_id": "CA-01",
      "action": "移除",
      "source": "Java 任務脫離呼叫流程時仍須有明確接手元件及結果處置路徑。",
      "targets": [
        {
          "uri": "rules/coding/concurrency-and-async.md#task-ownership"
        },
        {
          "uri": "rules/coding/concurrency-and-async.md#async-result-reception"
        }
      ],
      "removed_assertions": [
        {
          "text": "結果處置路徑",
          "source_uri": "rules/coding/concurrency-and-async.md#async-result-reception",
          "source_text": "非同步結果依[錯誤處理](error-handling.md#失敗分類與表達)區分成功、業務失敗、技術故障及取消，明訂接收路徑，不得丟棄故障。"
        },
        {
          "text": "Java 任務脫離呼叫流程時仍須有明確接手元件",
          "source_uri": "rules/coding/concurrency-and-async.md#task-ownership",
          "source_text": "工作脫離原呼叫流程時，須明確移交責任，不得產生無人追蹤的背景工作，也不得將提交成功視為業務完成。"
        },
        {
          "text": "明確接手元件",
          "source_uri": "rules/coding/concurrency-and-async.md#task-ownership",
          "source_text": "不要求原請求等待所有工作完成，但獨立工作須由負責的背景元件接手。"
        }
      ],
      "reason": "接手元件由 ca-01 的責任移交與背景元件接手承接；結果處置路徑另登 async-result-reception 的明訂接收路徑及不得丟棄故障原句。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "sentence": 9,
      "history_id": "CA-04",
      "action": "移除",
      "source": "依[等待期限與逾時處置的共通要求](../../../coding/concurrency-and-async.md#deadline-budget)執行。",
      "targets": [
        {
          "uri": "rules/coding/concurrency-and-async.md#deadline-budget"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[等待期限與逾時處置的共通要求](../../../coding/concurrency-and-async.md#deadline-budget)執行。",
          "source_uri": "rules/coding/concurrency-and-async.md#deadline-budget",
          "source_text": "等待非同步結果須有明確期限，包含程序內背景任務的結果等待，並納入整體操作時間預算，不讓每一步重新取得完整期限。"
        }
      ],
      "reason": "此句只引用既有共通規則，要求仍由同一共通錨點承接；原連結另外保留於檔頭固定指路句，沒有改變引用範圍或增加例外。"
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "sentence": 10,
      "history_id": "CA-04",
      "action": "移除",
      "source": "Java 非同步等待的逾時不代表底層工作已停止；等待 API 須承接整體時間預算。",
      "targets": [
        {
          "uri": "rules/coding/concurrency-and-async.md#deadline-budget"
        }
      ],
      "removed_assertions": [
        {
          "text": "等待 API 須承接整體時間預算",
          "source_uri": "rules/coding/concurrency-and-async.md#deadline-budget",
          "source_text": "等待非同步結果須有明確期限，包含程序內背景任務的結果等待，並納入整體操作時間預算，不讓每一步重新取得完整期限。"
        },
        {
          "text": "Java 非同步等待的逾時不代表底層工作已停止",
          "source_uri": "rules/coding/concurrency-and-async.md#deadline-budget",
          "source_text": "逾時後依契約取消、持續執行或移交結果追蹤責任，不得將等待結束視為工作已停止；未確認資源釋放前不得回收執行名額。"
        }
      ],
      "reason": "逾時不等於底層停止及等待 API 承接整體時間預算，由 ca-04 的等待期限與不得視為工作停止兩句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "type": "去向種類",
      "history_id": "CO-01",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/collections-and-ownership.md#java-collection-ownership"
      ],
      "reason": "第八次審閱 CO-01：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "type": "去向種類",
      "history_id": "CO-02",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/collections-and-ownership.md#java-snapshots-and-views"
      ],
      "reason": "第八次審閱 CO-02：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "type": "去向種類",
      "history_id": "CO-03",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/collections-and-ownership.md#order-and-duplicates"
      ],
      "reason": "順序與重複處理由共通選用轉換不得改變語意及重複鍵不得遺失資料的原句承接，未新增 List、Set、Map 特有操作限制。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "type": "去向種類",
      "history_id": "CO-04",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/collections-and-ownership.md#traversal-mutation"
      ],
      "reason": "支援操作與不得憑未拋例外判定安全、不得捕捉後直接重跑，均由共通遍歷修改的原句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "type": "去向種類",
      "history_id": "CO-05",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/concurrency-and-async.md#compound-atomicity"
      ],
      "reason": "共通禁止從集合執行緒安全推定多步驟安全，且明列跨鍵協調，直接承接單一操作不能推導複合原子性的提醒。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "type": "去向種類",
      "history_id": "CO-06",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/quality/performance.md#bounded-accumulation"
      ],
      "reason": "共通明列迭代器與串流不能推定有界，以及排序、去重與分組保留資料成本，完整承接 Java 提醒。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "type": "去向種類",
      "history_id": "CO-07",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/collections-and-ownership.md#java-lazy-resource-lifetime"
      ],
      "reason": "第八次審閱 CO-07：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "type": "去向種類",
      "history_id": "CO-08",
      "decision": "待確認",
      "expected": "拆分",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/collections-and-ownership.md#java-batch-failure-state"
      ],
      "reason": "第八次審閱 CO-08：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "type": "去向種類",
      "history_id": "CO-09",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/collections-and-ownership.md#java-collection-verification"
      ],
      "reason": "第八次審閱 CO-09：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "type": "acceptance_additions",
      "record": "- [失敗後狀態](../../../coding/error-handling.md#acceptance-failure-state)。\n"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "sentence": 8,
      "history_id": "CO-03",
      "action": "移除",
      "source": "依[順序與重複資料的共通要求](../../../coding/collections-and-ownership.md#order-and-duplicates)執行。",
      "targets": [
        {
          "uri": "rules/coding/collections-and-ownership.md#order-and-duplicates"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[順序與重複資料的共通要求](../../../coding/collections-and-ownership.md#order-and-duplicates)執行。",
          "source_uri": "rules/coding/collections-and-ownership.md#order-and-duplicates",
          "source_text": "集合契約須明訂所需的順序保證與重複資料處理方式，選用或轉換集合時不得意外改變這些語意。"
        }
      ],
      "reason": "純引用句移由既有共通條文承接，原連結另保留於引言或分組指路，順序與重複處理由共通選用轉換不得改變語意及重複鍵不得遺失資料的原句承接，未新增 List、Set、Map 特有操作限制。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "sentence": 9,
      "history_id": "CO-03",
      "action": "移除",
      "source": "Java 選用或轉換 List、Set、Map 時須維持約定順序、重複元素與重複鍵處理，不意外去重或覆蓋。",
      "targets": [
        {
          "uri": "rules/coding/collections-and-ownership.md#order-and-duplicates"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 選用或轉換 List、Set、Map 時須維持約定順序、重複元素與重複鍵處理，",
          "source_uri": "rules/coding/collections-and-ownership.md#order-and-duplicates",
          "source_text": "集合契約須明訂所需的順序保證與重複資料處理方式，選用或轉換集合時不得意外改變這些語意。"
        },
        {
          "text": "不意外去重或覆蓋。",
          "source_uri": "rules/coding/collections-and-ownership.md#order-and-duplicates",
          "source_text": "建立映射遇到重複鍵時，須依明確規則拒絕、合併或取代，不得默默遺失資料；不得僅為去重而移除契約允許的重複項目。"
        }
      ],
      "reason": "順序與重複處理由共通選用轉換不得改變語意及重複鍵不得遺失資料的原句承接，未新增 List、Set、Map 特有操作限制。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "sentence": 10,
      "history_id": "CO-04",
      "action": "移除",
      "source": "依[遍歷期間的修改的共通要求](../../../coding/collections-and-ownership.md#traversal-mutation)執行。",
      "targets": [
        {
          "uri": "rules/coding/collections-and-ownership.md#traversal-mutation"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[遍歷期間的修改的共通要求](../../../coding/collections-and-ownership.md#traversal-mutation)執行。",
          "source_uri": "rules/coding/collections-and-ownership.md#traversal-mutation",
          "source_text": "遍歷期間需要修改集合時，須使用符合集合契約的操作方式，並明確界定處理範圍。"
        }
      ],
      "reason": "純引用句移由既有共通條文承接，原連結另保留於引言或分組指路，支援操作與不得憑未拋例外判定安全、不得捕捉後直接重跑，均由共通遍歷修改的原句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "sentence": 11,
      "history_id": "CO-04",
      "action": "移除",
      "source": "Java 遍歷修改須使用集合支援的操作；未拋出遍歷修改例外不代表安全，也不得捕捉後直接重跑。",
      "targets": [
        {
          "uri": "rules/coding/collections-and-ownership.md#traversal-mutation"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 遍歷修改須使用集合支援的操作；",
          "source_uri": "rules/coding/collections-and-ownership.md#traversal-mutation",
          "source_text": "遍歷期間需要修改集合時，須使用符合集合契約的操作方式，並明確界定處理範圍。"
        },
        {
          "text": "未拋出遍歷修改例外不代表安全，也不得捕捉後直接重跑。",
          "source_uri": "rules/coding/collections-and-ownership.md#traversal-mutation",
          "source_text": "不得依賴未拋例外來推定安全，也不得以捕捉遍歷修改例外後直接重跑來掩蓋問題。"
        }
      ],
      "reason": "支援操作與不得憑未拋例外判定安全、不得捕捉後直接重跑，均由共通遍歷修改的原句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "sentence": 12,
      "history_id": "CO-05",
      "action": "移除",
      "source": "依[複合操作的原子性的共通要求](../../../coding/concurrency-and-async.md#compound-atomicity)執行。",
      "targets": [
        {
          "uri": "rules/coding/concurrency-and-async.md#compound-atomicity"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[複合操作的原子性的共通要求](../../../coding/concurrency-and-async.md#compound-atomicity)執行。",
          "source_uri": "rules/coding/concurrency-and-async.md#compound-atomicity",
          "source_text": "共享集合上的複合操作須依業務條件明訂原子性範圍，使用適當的原子操作或同步機制維持保證。"
        }
      ],
      "reason": "純引用句移由既有共通條文承接，原連結另保留於引言或分組指路，共通禁止從集合執行緒安全推定多步驟安全，且明列跨鍵協調，直接承接單一操作不能推導複合原子性的提醒。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "sentence": 13,
      "history_id": "CO-05",
      "action": "移除",
      "source": "Java concurrent collection 的單一操作保證不能推導為多步驟或跨鍵操作原子性。",
      "targets": [
        {
          "uri": "rules/coding/concurrency-and-async.md#compound-atomicity"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java concurrent collection 的單一操作保證不能推導為多步驟或跨鍵操作原子性。",
          "source_uri": "rules/coding/concurrency-and-async.md#compound-atomicity",
          "source_text": "不得因集合本身具備執行緒安全性，就推定多步驟或跨資料結構的操作也安全；跨多個鍵、集合或物件的條件，由負責該條件的範圍協調。"
        }
      ],
      "reason": "共通禁止從集合執行緒安全推定多步驟安全，且明列跨鍵協調，直接承接單一操作不能推導複合原子性的提醒。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "sentence": 14,
      "history_id": "CO-06",
      "action": "移除",
      "source": "依[限制資料累積的共通要求](../../../quality/performance.md#bounded-accumulation)執行。",
      "targets": [
        {
          "uri": "rules/quality/performance.md#bounded-accumulation"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[限制資料累積的共通要求](../../../quality/performance.md#bounded-accumulation)執行。",
          "source_uri": "rules/quality/performance.md#bounded-accumulation",
          "source_text": "可能大量或持續成長的資料，不得無限制地收集成記憶體集合。"
        }
      ],
      "reason": "純引用句移由既有共通條文承接，原連結另保留於引言或分組指路，共通明列迭代器與串流不能推定有界，以及排序、去重與分組保留資料成本，完整承接 Java 提醒。"
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "sentence": 15,
      "history_id": "CO-06",
      "action": "移除",
      "source": "Java Iterator 或 Stream 不保證實際有界；排序、去重及分組的保留資料成本仍須核對。",
      "targets": [
        {
          "uri": "rules/quality/performance.md#bounded-accumulation"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java Iterator 或 Stream 不保證實際有界；",
          "source_uri": "rules/quality/performance.md#bounded-accumulation",
          "source_text": "使用迭代器或串流 時，仍須確認來源與操作的實際資料累積及資源成本，不因採用延遲處理語法就推定有界；排序、去重與分組也須評估保留資料的成本。"
        },
        {
          "text": "排序、去重及分組的保留資料成本仍須核對。",
          "source_uri": "rules/quality/performance.md#bounded-accumulation",
          "source_text": "使用迭代器或串流 時，仍須確認來源與操作的實際資料累積及資源成本，不因採用延遲處理語法就推定有界；排序、去重與分組也須評估保留資料的成本。"
        }
      ],
      "reason": "共通明列迭代器與串流不能推定有界，以及排序、去重與分組保留資料成本，完整承接 Java 提醒。"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "type": "去向種類",
      "history_id": "BM-01",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/architecture/boundary-objects.md#隔離與拆分"
      ],
      "reason": "模組內傳遞、不強制每次轉 DTO 與對外及跨模組公開契約由隔離與拆分兩句明文承接。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "type": "去向種類",
      "history_id": "BM-02",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/boundary-mapping.md#java-mapping-fields"
      ],
      "reason": "保守保留同名欄位與新增來源不得擴大範圍及可信欄位來源的整句；共通轉換要求未直接點明同名欄位觸發情境，不拆除部分條件。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "type": "去向種類",
      "history_id": "BM-03",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/architecture/data-mapping.md#mapping-responsibility"
      ],
      "reason": "格式解析、專屬型別建立與補查資料先協調均由共通 bm-03 原句直接承接，移除純引用與後附重述。"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "type": "去向種類",
      "history_id": "BM-04",
      "decision": "待確認",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/boundary-mapping.md#java-mapping-integrity"
      ],
      "reason": "依選 B 保留拒絕、缺陷、部分成功及目標型別不代表有效的全部原文，並登錄移入完整性禁止句。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "type": "去向種類",
      "history_id": "BM-05",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/boundary-mapping.md#java-update-intent"
      ],
      "reason": "第四節判斷為否，保留 Java 欄位、預設值、反序列化及 null／Optional 不得合併更新意圖的全部原句。"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "type": "去向種類",
      "history_id": "BM-06",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/boundary-mapping.md#java-mutable-isolation"
      ],
      "reason": "保守保留複製集合外層、符合契約的不可變值共用與不要求全面深層複製；現有邊界及程式碼設計正文未直接完整承接後兩項適用範圍，不以未列管摘要代替證據。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "type": "去向種類",
      "history_id": "BM-07",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/boundary-mapping.md#java-directional-mapping"
      ],
      "reason": "共通 bm-07 承接反向產生判斷，但未直接規定具體工具配置另由 Framework 規範落實，故連同引用整句保留，避免遺失配置責任。"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "type": "去向種類",
      "history_id": "BM-08",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/boundary-mapping.md#java-mapping-ownership"
      ],
      "reason": "共通責任配置與介面原則涵蓋部分內容，但簡單映射可使用方法及不強制 Mapper 包裝層沒有同樣直接的完整原句，保守整條保留。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "type": "去向種類",
      "history_id": "BM-09",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/boundary-mapping.md#java-mapping-verification"
      ],
      "reason": "第八次審閱 BM-09：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "type": "imports",
      "record": {
        "source_path": "rules/architecture/data-mapping.md",
        "source_text": "不得略過欄位或產生不完整物件掩蓋失敗",
        "target_uri": "rules/stacks/java/common/boundary-mapping.md#java-mapping-integrity",
        "history_id": "BM-04",
        "reason": "依已核准選 B 將基準共通禁止句逐字移入 Java，保留欄位與物件完整性要求，刪除共通摘要由協調者另行處理。"
      }
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| Java 條文 | 語言增量驗收 |\n",
        "after": "| 對應要求 | 語言增量驗收 |\n",
        "reason": "第一欄以現行語意小節定位保留的 Java 要求，統一對應要求表頭，第二欄全部驗收文字逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-mapping-failure\"></a>4 | 透過 Java 實際映射路徑輸入不合法資料、內部必要資料缺失與轉換失敗，確認沒有以預設值或半成品掩蓋問題。 |\n",
        "after": "| <a id=\"acceptance-java-mapping-failure\"></a>[失敗明確回報](#java-mapping-integrity) | 透過 Java 實際映射路徑輸入不合法資料、內部必要資料缺失與轉換失敗，確認沒有以預設值或半成品掩蓋問題。 |\n",
        "reason": "第一欄以現行語意小節定位保留的 Java 要求，統一對應要求表頭，第二欄全部驗收文字逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-update-intent\"></a>5 | 核對 Java 欄位、預設值與反序列化路徑未合併省略、明確清空及設定值的不同意圖。 |\n",
        "after": "| <a id=\"acceptance-java-update-intent\"></a>[保留更新意圖](#java-update-intent) | 核對 Java 欄位、預設值與反序列化路徑未合併省略、明確清空及設定值的不同意圖。 |\n",
        "reason": "第一欄以現行語意小節定位保留的 Java 要求，統一對應要求表頭，第二欄全部驗收文字逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "sentence": 3,
      "history_id": "BM-01",
      "action": "移除",
      "source": "依[邊界物件](../../../architecture/boundary-objects.md)執行。",
      "targets": [
        {
          "uri": "rules/architecture/boundary-objects.md#隔離與拆分"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[邊界物件](../../../architecture/boundary-objects.md)執行。",
          "source_uri": "rules/architecture/boundary-objects.md#隔離與拆分",
          "source_text": "模組內部依專案架構決議決定物件傳遞範圍，不強制每次方法呼叫都轉 DTO。"
        },
        {
          "text": "依[邊界物件](../../../architecture/boundary-objects.md)執行。",
          "source_uri": "rules/architecture/boundary-objects.md#隔離與拆分",
          "source_text": "ORM Model 的內部使用仍須符合技術隔離與依賴方向；此內部彈性不豁免對外 API 及跨模組使用公開資料契約的要求。"
        }
      ],
      "reason": "本句為邊界物件整份規範引用，整份連結已保留於檔頭；隔離與拆分原句是本條後附範圍的直接承接依據。"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "sentence": 4,
      "history_id": "BM-01",
      "action": "移除",
      "source": "Java 模組內的物件傳遞依架構決議處理，不強制每次呼叫轉 DTO；對外 API 及跨模組仍使用公開資料契約。",
      "targets": [
        {
          "uri": "rules/architecture/boundary-objects.md#隔離與拆分"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 模組內的物件傳遞依架構決議處理，不強制每次呼叫轉 DTO",
          "source_uri": "rules/architecture/boundary-objects.md#隔離與拆分",
          "source_text": "模組內部依專案架構決議決定物件傳遞範圍，不強制每次方法呼叫都轉 DTO。"
        },
        {
          "text": "對外 API 及跨模組仍使用公開資料契約",
          "source_uri": "rules/architecture/boundary-objects.md#隔離與拆分",
          "source_text": "ORM Model 的內部使用仍須符合技術隔離與依賴方向；此內部彈性不豁免對外 API 及跨模組使用公開資料契約的要求。"
        }
      ],
      "reason": "模組內傳遞、不強制每次轉 DTO 與對外及跨模組公開契約由隔離與拆分兩句明文承接。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "sentence": 7,
      "history_id": "BM-03",
      "action": "移除",
      "source": "依[聚焦轉換與必要驗證的共通要求](../../../architecture/data-mapping.md#mapping-responsibility)執行。",
      "targets": [
        {
          "uri": "rules/architecture/data-mapping.md#mapping-responsibility"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[聚焦轉換與必要驗證的共通要求](../../../architecture/data-mapping.md#mapping-responsibility)執行。",
          "source_uri": "rules/architecture/data-mapping.md#mapping-responsibility",
          "source_text": "映射須聚焦契約定義的資料轉換與必要驗證，不得隱藏外部存取、業務決策或業務副作用。"
        },
        {
          "text": "依[聚焦轉換與必要驗證的共通要求](../../../architecture/data-mapping.md#mapping-responsibility)執行。",
          "source_uri": "rules/architecture/data-mapping.md#mapping-responsibility",
          "source_text": "可依契約解析格式及建立專屬型別；查詢補充資料、決定折扣、寫入資料庫或發送事件等行為，由負責元件明確協調，再進行映射。"
        }
      ],
      "reason": "本句只引用共通聚焦轉換與必要驗證，原 bm-03 目標移至檔頭保留引用，來源原句持續約束轉換與協調責任。"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "sentence": 8,
      "history_id": "BM-03",
      "action": "移除",
      "source": "Java 映射可解析格式及建立專屬型別；需要補查資料時，由負責流程的元件先協調。",
      "targets": [
        {
          "uri": "rules/architecture/data-mapping.md#mapping-responsibility"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 映射可解析格式及建立專屬型別",
          "source_uri": "rules/architecture/data-mapping.md#mapping-responsibility",
          "source_text": "可依契約解析格式及建立專屬型別；查詢補充資料、決定折扣、寫入資料庫或發送事件等行為，由負責元件明確協調，再進行映射。"
        },
        {
          "text": "需要補查資料時，由負責流程的元件先協調",
          "source_uri": "rules/architecture/data-mapping.md#mapping-responsibility",
          "source_text": "可依契約解析格式及建立專屬型別；查詢補充資料、決定折扣、寫入資料庫或發送事件等行為，由負責元件明確協調，再進行映射。"
        }
      ],
      "reason": "格式解析、專屬型別建立與補查資料先協調均由共通 bm-03 原句直接承接，移除純引用與後附重述。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "去向種類",
      "history_id": "VO-01",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/domain-modeling.md#專屬型別"
      ],
      "reason": "專屬型別的不同用途 ID 隔離與一般描述性資料不要求全部包裝逐項承接現有例子；整份領域建模引用仍在引言。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "去向種類",
      "history_id": "VO-02",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/domain-modeling.md#專屬型別",
        "rules/coding/validation.md#責任分工",
        "rules/coding/code-design.md#construction-entrypoints"
      ],
      "reason": "建立驗證由領域建模及資料驗證承接，建構子或工廠一致性另列 cl-06，型別有效不代表存在性或授權由專屬型別承接；整份引用保留。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "去向種類",
      "history_id": "VO-03",
      "decision": "增量",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/value-objects.md#java-value-immutability"
      ],
      "reason": "依增量判斷保留 final 不保證內容不可變及傳入取出隔離的 Java 失效情境，既有共同政策引用亦逐字保留。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "去向種類",
      "history_id": "VO-04",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/value-objects.md#java-value-equality"
      ],
      "reason": "依第四節否的判斷原句不動，保留 equals／hashCode 一致性、業務概念區別、不得盲用產生方法與全部相等性例子。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "去向種類",
      "history_id": "VO-05",
      "decision": "混合",
      "expected": "拆分",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/value-objects.md#java-value-normalization"
      ],
      "reason": "第八次審閱 VO-05：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "去向種類",
      "history_id": "VO-06",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "拆分",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/value-objects.md#java-value-operations"
      ],
      "reason": "專屬型別操作與邊界讀值由專屬型別及 vo-06 承接；外部政策操作原句指定領域元件，共通僅稱負責元件，責任限定未直接涵蓋故保守留下。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "去向種類",
      "history_id": "VO-07",
      "decision": "混合",
      "expected": "拆分",
      "actual": "拆分",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/value-objects.md#java-value-restoration",
        "rules/coding/domain-modeling.md#value-restoration"
      ],
      "reason": "框架配置另訂由 vo-07 的 Framework 規範與專案落實承接；共通未直接點名 Java 建構及一般類別／record 實作選擇，保留該完整失效提醒。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "去向種類",
      "history_id": "VO-08",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/value-objects.md#java-value-implementation"
      ],
      "reason": "依第四節否的判斷原句不動，保留 Java 版本與實作形式選擇、產生方法公開適合性、可變內容及敏感字串限制。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "去向種類",
      "history_id": "VO-09",
      "decision": "保留條文／可能",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/value-objects.md#java-diagnostic-representation"
      ],
      "reason": "依第四節可能及必須整條保留清單逐字保留，診斷字串與交換格式分離及 toString 禁止默認交換契約均未抽除。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "去向種類",
      "history_id": "VO-10",
      "decision": "驗收入口",
      "expected": "轉為驗收入口",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/value-objects.md#java-value-test-coverage"
      ],
      "reason": "驗收入口依作業說明整條保留，Java 產生方法與還原路徑及不機械式逐一測試全部保留交協調者決定，不以未列管摘要刪除覆蓋要求。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "刪除完整性",
      "history_id": "VO-06",
      "source": "Java 值物件操作保留專屬型別；必要邊界呈現可讀底層值，跨幣別等依賴外部政策的操作由領域元件協調。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| Java 條文 | 語言增量驗收 |\n",
        "after": "| 對應要求 | 語言增量驗收 |\n",
        "reason": "只更新驗收表頭及第一欄條號定位，改連實際 Java 語意小節或承接共通要求；第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-value-validity\"></a>1、2 | 審查專屬型別能否阻止業務概念混用，相關介面有無退回一般字串或數字。驗證合法值、邊界值及不合法值，確認建立成功後符合自身規則，且未將格式有效誤當成存在性或授權成立。 |\n",
        "after": "| <a id=\"acceptance-java-value-validity\"></a>[專屬型別](../../../coding/domain-modeling.md#專屬型別)、[建立入口](../../../coding/code-design.md#construction-entrypoints)、[驗證責任](../../../coding/validation.md#責任分工) | 審查專屬型別能否阻止業務概念混用，相關介面有無退回一般字串或數字。驗證合法值、邊界值及不合法值，確認建立成功後符合自身規則，且未將格式有效誤當成存在性或授權成立。 |\n",
        "reason": "只更新驗收表頭及第一欄條號定位，改連實際 Java 語意小節或承接共通要求；第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-final-references\"></a>3 | 檢查 final 欄位仍可能指向可變內容的路徑；不得以欄位修飾詞作為不可變性證據。 |\n",
        "after": "| <a id=\"acceptance-java-final-references\"></a>[不可變性](#java-value-immutability) | 檢查 final 欄位仍可能指向可變內容的路徑；不得以欄位修飾詞作為不可變性證據。 |\n",
        "reason": "只更新驗收表頭及第一欄條號定位，改連實際 Java 語意小節或承接共通要求；第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-value-equality\"></a>4 | 驗證不同實例的相等值及具代表性的不相等值，相等物件的雜湊值須相同。適用時確認作為集合元素或映射鍵的行為符合契約，不要求不相等物件一定具有不同雜湊值。 |\n",
        "after": "| <a id=\"acceptance-java-value-equality\"></a>[值相等的條件](#java-value-equality) | 驗證不同實例的相等值及具代表性的不相等值，相等物件的雜湊值須相同。適用時確認作為集合元素或映射鍵的行為符合契約，不要求不相等物件一定具有不同雜湊值。 |\n",
        "reason": "只更新驗收表頭及第一欄條號定位，改連實際 Java 語意小節或承接共通要求；第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-generated-representation\"></a>8、9 | 核對實作形式符合支援版本，產生的方法與手寫方法均遵循相等性、不可變性及揭露契約。確認診斷字串未被默認當成交換格式，對外映射符合約定且未洩漏敏感值。 |\n",
        "after": "| <a id=\"acceptance-java-generated-representation\"></a>[一般類別與 record](#java-value-implementation)、[診斷字串與交換格式](#java-diagnostic-representation) | 核對實作形式符合支援版本，產生的方法與手寫方法均遵循相等性、不可變性及揭露契約。確認診斷字串未被默認當成交換格式，對外映射符合約定且未洩漏敏感值。 |\n",
        "reason": "只更新驗收表頭及第一欄條號定位，改連實際 Java 語意小節或承接共通要求；第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-value-method-coverage\"></a>10 | 核對測試涵蓋受影響的業務保證與失效邊界，不以只有建立成功的案例代替驗收，也不要求無業務邏輯的存取方法逐一測試。Java 的 equals()、hashCode()、record 產生方法與還原路徑均納入適用案例。 |\n",
        "after": "| <a id=\"acceptance-java-value-method-coverage\"></a>[業務保證的測試](#java-value-test-coverage) | 核對測試涵蓋受影響的業務保證與失效邊界，不以只有建立成功的案例代替驗收，也不要求無業務邏輯的存取方法逐一測試。Java 的 equals()、hashCode()、record 產生方法與還原路徑均納入適用案例。 |\n",
        "reason": "只更新驗收表頭及第一欄條號定位，改連實際 Java 語意小節或承接共通要求；第二欄全部驗收內容逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "sentence": 4,
      "history_id": "VO-01",
      "action": "移除",
      "source": "依[領域建模](../../../coding/domain-modeling.md)執行。",
      "targets": [
        {
          "uri": "rules/coding/domain-modeling.md#專屬型別"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[領域建模](../../../coding/domain-modeling.md)執行。",
          "source_uri": "rules/coding/domain-modeling.md#專屬型別",
          "source_text": "容易混用或具有業務約束的值必須使用專屬型別，例如不同用途的 ID、包含幣別的金額、帶單位數值與受限制的日期區間。"
        }
      ],
      "reason": "領域建模整份引用仍在文件引言，專屬型別段落直接承接不同用途識別碼的隔離要求，沒有縮小引用範圍。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "sentence": 5,
      "history_id": "VO-01",
      "action": "移除",
      "source": "Java 的 `OrderId` 與 `CustomerId` 須維持不同業務型別；一般描述性資料不要求機械式包裝。",
      "targets": [
        {
          "uri": "rules/coding/domain-modeling.md#專屬型別"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 的 `OrderId` 與 `CustomerId` 須維持不同業務型別",
          "source_uri": "rules/coding/domain-modeling.md#專屬型別",
          "source_text": "容易混用或具有業務約束的值必須使用專屬型別，例如不同用途的 ID、包含幣別的金額、帶單位數值與受限制的日期區間。"
        },
        {
          "text": "Java 的 `OrderId` 與 `CustomerId` 須維持不同業務型別",
          "source_uri": "rules/coding/domain-modeling.md#專屬型別",
          "source_text": "專屬型別必須實際阻止誤用；僅為原始型別取別名、卻仍可任意互換，不符合要求。"
        },
        {
          "text": "一般描述性資料不要求機械式包裝",
          "source_uri": "rules/coding/domain-modeling.md#專屬型別",
          "source_text": "一般描述性資料，例如備註，可使用明確的原始型別，不要求全部包裝。"
        }
      ],
      "reason": "不同用途 ID 必須使用專屬型別直接涵蓋 OrderId 與 CustomerId 的區隔，一般描述性資料不要求全部包裝直接涵蓋後半例外。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "sentence": 6,
      "history_id": "VO-02",
      "action": "移除",
      "source": "依[領域建模](../../../coding/domain-modeling.md)、[資料驗證](../../../coding/validation.md)執行。",
      "targets": [
        {
          "uri": "rules/coding/domain-modeling.md#專屬型別"
        },
        {
          "uri": "rules/coding/validation.md#責任分工"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[領域建模](../../../coding/domain-modeling.md)、[資料驗證](../../../coding/validation.md)執行。",
          "source_uri": "rules/coding/domain-modeling.md#專屬型別",
          "source_text": "建立時必須驗證該值的格式與適用限制，建立後不得透過任意修改破壞有效性。"
        },
        {
          "text": "依[領域建模](../../../coding/domain-modeling.md)、[資料驗證](../../../coding/validation.md)執行。",
          "source_uri": "rules/coding/validation.md#責任分工",
          "source_text": "業務邏輯負責業務規則驗證，例如餘額是否足夠、訂單是否允許取消；專屬型別建立時維護自身不變條件。"
        }
      ],
      "reason": "領域建模整份引用仍在引言並另保留資料驗證整份入口，兩處原文直接承接值型別自身不變條件與建立時驗證。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "sentence": 7,
      "history_id": "VO-02",
      "action": "移除",
      "source": "Java 建構子或工廠維持一致驗證；合法 `OrderId` 不代表訂單存在或已取得存取權。",
      "targets": [
        {
          "uri": "rules/coding/code-design.md#construction-entrypoints"
        },
        {
          "uri": "rules/coding/domain-modeling.md#專屬型別"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 建構子或工廠維持一致驗證",
          "source_uri": "rules/coding/code-design.md#construction-entrypoints",
          "source_text": "所有建立入口須一致保護必要條件，避免各自維護不一致的驗證。"
        },
        {
          "text": "合法 `OrderId` 不代表訂單存在或已取得存取權",
          "source_uri": "rules/coding/domain-modeling.md#專屬型別",
          "source_text": "例如使用者 ID 格式正確，不表示使用者存在或操作者有權存取，這些條件仍須另行驗證。"
        }
      ],
      "reason": "建構子或工廠一致驗證由所有建立入口的一致保護承接，合法識別碼不代表存在或授權由專屬型別的格式與業務條件分離原句承接。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "sentence": 16,
      "history_id": "VO-06",
      "action": "改寫",
      "source": "Java 值物件操作保留專屬型別；必要邊界呈現可讀底層值，跨幣別等依賴外部政策的操作由領域元件協調。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/value-objects.md#java-value-operations",
          "text": "跨幣別等依賴外部政策的操作由領域元件協調。"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 值物件操作保留專屬型別",
          "source_uri": "rules/coding/domain-modeling.md#value-operations",
          "source_text": "涉及值本身語意的運算，須集中於值物件或責任明確的領域元件，保留必要的型別、單位與有效性約束。"
        },
        {
          "text": "Java 值物件操作保留專屬型別",
          "source_uri": "rules/coding/domain-modeling.md#專屬型別",
          "source_text": "相關參數、屬性與回傳值必須使用專屬型別，不得建立後又在內部介面退回一般字串或數字，失去隔離效果。"
        },
        {
          "text": "必要邊界呈現可讀底層值",
          "source_uri": "rules/coding/domain-modeling.md#value-operations",
          "source_text": "邊界映射、呈現等必要用途仍可讀取底層值；跨幣別換算等依賴外部資料或政策的操作，由負責元件協調，不要求值物件自行查詢外部資料。"
        }
      ],
      "reason": "保留專屬型別由運算約束及相關參數回傳型別原句合併承接，邊界呈現讀值已有明文；外部政策操作限定領域元件而共通僅稱負責元件，故保留後半原句。"
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "sentence": 19,
      "history_id": "VO-07",
      "action": "移除",
      "source": "具體框架配置另訂。",
      "targets": [
        {
          "uri": "rules/coding/domain-modeling.md#value-restoration"
        }
      ],
      "removed_assertions": [
        {
          "text": "具體框架配置另訂。",
          "source_uri": "rules/coding/domain-modeling.md#value-restoration",
          "source_text": "具體框架配置由 Framework 規範與專案落實。"
        }
      ],
      "reason": "框架配置另訂由共通原文指定 Framework 規範與專案落實直接承接，Java 建構及類別或 record 不得形成驗證旁路的完整句子仍保留。"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "去向種類",
      "history_id": "EQ-01",
      "decision": "增量",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/equality-hashing-ordering.md#java-comparison-semantics"
      ],
      "reason": "依第三節增量判斷，完整保留共同政策引用與 Java equals 落實比較語意、不得任意比較 Entity 全欄位的限制。"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "去向種類",
      "history_id": "EQ-02",
      "decision": "保留條文／是",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/equality-hashing-ordering.md#java-equality-hash-contract"
      ],
      "reason": "依第四節是及必須整條保留清單，逐字保留 equals 關係、null 處理及 hashCode 相容契約。"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "去向種類",
      "history_id": "EQ-03",
      "decision": "保留條文／是",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/equality-hashing-ordering.md#java-hash-collection-stability"
      ],
      "reason": "依第四節是及必須整條保留清單，逐字保留雜湊集合內比較依據穩定、穩定鍵與移出修改重加要求。"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "去向種類",
      "history_id": "EQ-04",
      "decision": "混合",
      "expected": "拆分",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/equality-hashing-ordering.md#java-entity-identity-lifecycle"
      ],
      "reason": "第八次審閱 EQ-04：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "去向種類",
      "history_id": "EQ-05",
      "decision": "保留條文／是",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/equality-hashing-ordering.md#java-cross-type-equality"
      ],
      "reason": "依第四節是及必須整條保留清單，逐字保留跨型別相等範圍、關係契約及 instanceof 或 getClass 選擇。"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "去向種類",
      "history_id": "EQ-06",
      "decision": "保留條文／可能",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/equality-hashing-ordering.md#java-ordering-choice"
      ],
      "reason": "依第四節可能及必須整條保留清單，逐字保留自然順序與情境排序的介面選擇條件及排序規則內容。"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "去向種類",
      "history_id": "EQ-07",
      "decision": "保留條文／是",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/equality-hashing-ordering.md#java-comparator-relations"
      ],
      "reason": "依第四節是及必須整條保留清單，逐字保留比較關係、同次固定資料及禁止溢位或損失精度的相減比較。"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "去向種類",
      "history_id": "EQ-08",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/equality-hashing-ordering.md#java-sorted-key-equivalence"
      ],
      "reason": "依第四節否預設保留增量，逐字保留比較為零與 equals 關係、資料不得意外合併及 TreeSet 或 TreeMap 案例。"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "去向種類",
      "history_id": "EQ-09",
      "decision": "保留條文／是",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/equality-hashing-ordering.md#java-sorted-collection-stability"
      ],
      "reason": "依第四節是及必須整條保留清單，逐字保留排序依據穩定、移出重加或重建及比較器變更後資料保留要求。"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "去向種類",
      "history_id": "EQ-10",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/equality-hashing-ordering.md#java-relationship-coverage"
      ],
      "reason": "依第四節否預設保留增量，逐字保留關係契約與集合行為驗收、適用範圍及工具產生方法不得省略驗證。"
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| Java 條文 | 語言增量驗收 |\n",
        "after": "| 對應要求 | 語言增量驗收 |\n",
        "reason": "只更新驗收第一欄的定位方式為語意錨點或統一表頭，原有驗收錨點與第二欄全部內容逐字保持不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-equality-hash-contract\"></a>2 | 對 Java `equals()` 驗證自反、對稱、遞移、一致性及 `null` 處理，並確認相等物件具有相同 `hashCode()`；不要求不同物件雜湊必不同，也不以雜湊相同判定相等。 |\n",
        "after": "| <a id=\"acceptance-java-equality-hash-contract\"></a>[相等與雜湊契約](#java-equality-hash-contract) | 對 Java `equals()` 驗證自反、對稱、遞移、一致性及 `null` 處理，並確認相等物件具有相同 `hashCode()`；不要求不同物件雜湊必不同，也不以雜湊相同判定相等。 |\n",
        "reason": "只更新驗收第一欄的定位方式為語意錨點或統一表頭，原有驗收錨點與第二欄全部內容逐字保持不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-hash-collection-stability\"></a>3 | 以實際 Java 雜湊集合核對鍵或元素的查找、去重及移除；確認在集合內比較依據保持穩定。需要變更比較依據時，驗證先移出、修改再加入的結果及重複處置。 |\n",
        "after": "| <a id=\"acceptance-java-hash-collection-stability\"></a>[雜湊集合中的穩定性](#java-hash-collection-stability) | 以實際 Java 雜湊集合核對鍵或元素的查找、去重及移除；確認在集合內比較依據保持穩定。需要變更比較依據時，驗證先移出、修改再加入的結果及重複處置。 |\n",
        "reason": "只更新驗收第一欄的定位方式為語意錨點或統一表頭，原有驗收錨點與第二欄全部內容逐字保持不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-cross-type-equality\"></a>5 | 對允許繼承的 Java 型別，以父子型別及必要的多物件組合驗證 `equals()` 的對稱、遞移與 `hashCode()` 契約；比較涉及框架代理時，經實際代理路徑驗證。 |\n",
        "after": "| <a id=\"acceptance-java-cross-type-equality\"></a>[跨型別相等範圍](#java-cross-type-equality) | 對允許繼承的 Java 型別，以父子型別及必要的多物件組合驗證 `equals()` 的對稱、遞移與 `hashCode()` 契約；比較涉及框架代理時，經實際代理路徑驗證。 |\n",
        "reason": "只更新驗收第一欄的定位方式為語意錨點或統一表頭，原有驗收錨點與第二欄全部內容逐字保持不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-ordering-choice\"></a>6 | 審查 Java 型別採 `Comparable` 或用途明確的 `Comparator` 是否符合自然順序或情境排序的契約。 |\n",
        "after": "| <a id=\"acceptance-java-ordering-choice\"></a>[自然順序與情境排序](#java-ordering-choice) | 審查 Java 型別採 `Comparable` 或用途明確的 `Comparator` 是否符合自然順序或情境排序的契約。 |\n",
        "reason": "只更新驗收第一欄的定位方式為語意錨點或統一表頭，原有驗收錨點與第二欄全部內容逐字保持不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-comparator-relations\"></a>7 | 驗證 Java 比較器的方向、同值與遞移關係，以及同次排序比較依據的穩定性；涵蓋適用的極端數值，確認不以相減造成溢位或精度損失及錯誤順序。 |\n",
        "after": "| <a id=\"acceptance-java-comparator-relations\"></a>[比較關係一致](#java-comparator-relations) | 驗證 Java 比較器的方向、同值與遞移關係，以及同次排序比較依據的穩定性；涵蓋適用的極端數值，確認不以相減造成溢位或精度損失及錯誤順序。 |\n",
        "reason": "只更新驗收第一欄的定位方式為語意錨點或統一表頭，原有驗收錨點與第二欄全部內容逐字保持不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-sorted-key-equivalence\"></a>8 | 核對比較為零與 `equals()` 的約定，將不同但排序值相同的資料放入實際採用的 Java 排序集合或映射，確認鍵判同及資料保留符合契約。 |\n",
        "after": "| <a id=\"acceptance-java-sorted-key-equivalence\"></a>[比較為零與相等性](#java-sorted-key-equivalence) | 核對比較為零與 `equals()` 的約定，將不同但排序值相同的資料放入實際採用的 Java 排序集合或映射，確認鍵判同及資料保留符合契約。 |\n",
        "reason": "只更新驗收第一欄的定位方式為語意錨點或統一表頭，原有驗收錨點與第二欄全部內容逐字保持不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-sorted-collection-stability\"></a>9 | 核對 Java 排序元素、鍵及比較器設定的變更路徑；驗證移出重加或重建後的順序、查找及資料保留，不依賴既有集合自動調整。 |\n",
        "after": "| <a id=\"acceptance-java-sorted-collection-stability\"></a>[排序集合中的穩定性](#java-sorted-collection-stability) | 核對 Java 排序元素、鍵及比較器設定的變更路徑；驗證移出重加或重建後的順序、查找及資料保留，不依賴既有集合自動調整。 |\n",
        "reason": "只更新驗收第一欄的定位方式為語意錨點或統一表頭，原有驗收錨點與第二欄全部內容逐字保持不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/equality-hashing-ordering.md",
      "type": "acceptance_text_changes",
      "record": {
        "before": "依第 10 條，核對本次驗收同時涵蓋受影響的 Java 關係契約與實際集合操作；不能只測少數成對比較，也不能因方法由工具產生就省略驗證。\n",
        "after": "依[關係與集合行為驗收](#java-relationship-coverage)，核對本次驗收同時涵蓋受影響的 Java 關係契約與實際集合操作；不能只測少數成對比較，也不能因方法由工具產生就省略驗證。\n",
        "reason": "只將第十條的條號引用改為現行語意小節連結，完整保留關係契約、實際集合操作及不得略過驗證的核對要求。",
        "references": [
          {
            "before": "第 10 條",
            "after": "[關係與集合行為驗收](#java-relationship-coverage)"
          }
        ]
      }
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "type": "去向種類",
      "history_id": "ND-01",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/naming-packages-docs.md#java-naming-form"
      ],
      "reason": "依第四節「否」保留 Java 命名形式、縮寫慣例及 final 與介面前綴限制，正文逐字不變。"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "type": "去向種類",
      "history_id": "ND-02",
      "decision": "待補證",
      "expected": "整條保留",
      "actual": "整條保留",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/naming-packages-docs.md#java-specific-responsibility"
      ],
      "reason": "整理前原文未提交，無法證明完整覆蓋；共通沒有直接涵蓋類別後綴名稱與責任一致的條文，依待補證決策整條逐字保留。"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "type": "去向種類",
      "history_id": "ND-03",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/naming-packages-docs.md#java-package-boundaries"
      ],
      "reason": "依第四節「否」保留套件組織、公開與內部界線、共用依賴方向及可見性檢查，正文逐字不變。"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "type": "去向種類",
      "history_id": "ND-04",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/naming-packages-docs.md#java-javadoc-contract"
      ],
      "reason": "依第四節「否」保留使用端所需契約資訊與適用範圍、Javadoc 就近維護及權威契約引用要求，正文逐字不變。"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "type": "去向種類",
      "history_id": "ND-05",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/code-design.md#implementation-notes"
      ],
      "reason": "依第三節重述判斷整條移除；註解維護、TODO 待處理內容與追蹤方式及禁止模糊標記由共通 nd-05 直接承接。"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "type": "去向種類",
      "history_id": "ND-06",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/naming-packages-docs.md#java-rename-impact"
      ],
      "reason": "依第四節「否」保留類別、方法與套件改名搬移的直接及動態影響、相容遷移和 IDE 重構限制，正文逐字不變。"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "type": "去向種類",
      "history_id": "ND-07",
      "decision": "增量",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/naming-packages-docs.md#java-document-verification"
      ],
      "reason": "依第三節增量判斷保留 Java 命名形式、Javadoc 參照、可執行範例與支援版本的實際驗證，以及既有共通政策引用。"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| Java 條文 | 語言增量驗收 |\n",
        "after": "| 對應要求 | 語言增量驗收 |\n",
        "reason": "驗收第一欄改為對應要求及現行 Java 語意小節連結，第二欄所有驗收內容與原有驗收錨點逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-naming-form\"></a>1、2 | 自動檢查適用的命名形式與團隊縮寫慣例，人工從使用處核對名稱與實際責任一致。確認未將所有 `final` 欄位機械式視為常數，也未用籠統後綴掩蓋不同用途。 |\n",
        "after": "| <a id=\"acceptance-java-naming-form\"></a>[一致的命名形式](#java-naming-form)、[名稱表達具體責任](#java-specific-responsibility) | 自動檢查適用的命名形式與團隊縮寫慣例，人工從使用處核對名稱與實際責任一致。確認未將所有 `final` 欄位機械式視為常數，也未用籠統後綴掩蓋不同用途。 |\n",
        "reason": "驗收第一欄改為對應要求及現行 Java 語意小節連結，第二欄所有驗收內容與原有驗收錨點逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-package-boundaries\"></a>3 | 審查套件責任、公開與內部界線，以及共用套件依賴方向；以適用的可見性與依賴檢查確認邊界有效，不僅核對目錄名稱。 |\n",
        "after": "| <a id=\"acceptance-java-package-boundaries\"></a>[套件與架構邊界](#java-package-boundaries) | 審查套件責任、公開與內部界線，以及共用套件依賴方向；以適用的可見性與依賴檢查確認邊界有效，不僅核對目錄名稱。 |\n",
        "reason": "驗收第一欄改為對應要求及現行 Java 語意小節連結，第二欄所有驗收內容與原有驗收錨點逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-javadoc-contract\"></a>4 | 核對供使用端依賴的類別與方法優先以 Javadoc 就近維護必要契約，或明確引用既有權威契約；確認 Javadoc 與實際前置條件、結果、失敗、副作用及適用生命週期一致。 |\n",
        "after": "| <a id=\"acceptance-java-javadoc-contract\"></a>[補足契約資訊](#java-javadoc-contract) | 核對供使用端依賴的類別與方法優先以 Javadoc 就近維護必要契約，或明確引用既有權威契約；確認 Javadoc 與實際前置條件、結果、失敗、副作用及適用生命週期一致。 |\n",
        "reason": "驗收第一欄改為對應要求及現行 Java 語意小節連結，第二欄所有驗收內容與原有驗收錨點逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-rename-paths\"></a>6 | 重新命名或搬移後，核對直接引用、設定、動態登錄、序列化或持久化引用及外部使用端等適用路徑。確認相容性與必要遷移已有處置，文件與範例同步更新。 |\n",
        "after": "| <a id=\"acceptance-java-rename-paths\"></a>[重新命名與搬移的影響](#java-rename-impact) | 重新命名或搬移後，核對直接引用、設定、動態登錄、序列化或持久化引用及外部使用端等適用路徑。確認相容性與必要遷移已有處置，文件與範例同步更新。 |\n",
        "reason": "驗收第一欄改為對應要求及現行 Java 語意小節連結，第二欄所有驗收內容與原有驗收錨點逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-javadoc-examples\"></a>7 | 驗證受影響的連結、Javadoc 參照與適用範例，確認在支援版本下可用。 |\n",
        "after": "| <a id=\"acceptance-java-javadoc-examples\"></a>[形式與語意分別驗收](#java-document-verification) | 驗證受影響的連結、Javadoc 參照與適用範例，確認在支援版本下可用。 |\n",
        "reason": "驗收第一欄改為對應要求及現行 Java 語意小節連結，第二欄所有驗收內容與原有驗收錨點逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "sentence": 14,
      "history_id": "ND-05",
      "action": "移除",
      "source": "依[實作註解與暫時處理的共通要求](../../../coding/code-design.md#implementation-notes)執行。",
      "targets": [
        {
          "uri": "rules/coding/code-design.md#implementation-notes"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[實作註解與暫時處理的共通要求](../../../coding/code-design.md#implementation-notes)執行。",
          "source_uri": "rules/coding/code-design.md#implementation-notes",
          "source_text": "實作註解依本文件的[註解與公開文件](#註解與公開文件)說明理由、限制與依據，變更時同步更新或移除。"
        },
        {
          "text": "依[實作註解與暫時處理的共通要求](../../../coding/code-design.md#implementation-notes)執行。",
          "source_uri": "rules/coding/code-design.md#implementation-notes",
          "source_text": "可由設計與命名改善的問題應優先修正。"
        },
        {
          "text": "依[實作註解與暫時處理的共通要求](../../../coding/code-design.md#implementation-notes)執行。",
          "source_uri": "rules/coding/code-design.md#implementation-notes",
          "source_text": "暫時性處理須有可追蹤的後續事項，`TODO` 須說明待處理內容與追蹤方式，不以模糊註解或標記代替責任管理。"
        }
      ],
      "reason": "移除純引用句並在引言保留同一共通錨點；該共通小節完整列明註解維護、設計修正及暫時處理追蹤要求。"
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "sentence": 15,
      "history_id": "ND-05",
      "action": "移除",
      "source": "Java 註解及 TODO 依共同追蹤要求維護，不以模糊標記代替負責事項。",
      "targets": [
        {
          "uri": "rules/coding/code-design.md#implementation-notes"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 註解及 TODO 依共同追蹤要求維護",
          "source_uri": "rules/coding/code-design.md#implementation-notes",
          "source_text": "暫時性處理須有可追蹤的後續事項，`TODO` 須說明待處理內容與追蹤方式，不以模糊註解或標記代替責任管理。"
        },
        {
          "text": "不以模糊標記代替負責事項",
          "source_uri": "rules/coding/code-design.md#implementation-notes",
          "source_text": "暫時性處理須有可追蹤的後續事項，`TODO` 須說明待處理內容與追蹤方式，不以模糊註解或標記代替責任管理。"
        },
        {
          "text": "Java 註解及 TODO 依共同追蹤要求維護",
          "source_uri": "rules/coding/code-design.md#implementation-notes",
          "source_text": "實作註解依本文件的[註解與公開文件](#註解與公開文件)說明理由、限制與依據，變更時同步更新或移除。"
        }
      ],
      "reason": "註解維護補登 nd-05 首句的變更時同步更新或移除；TODO 追蹤與禁止模糊標記維持第三句的承接證據，兩句分別支持原斷言。"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "去向種類",
      "history_id": "JT-01",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/types-and-generics.md#java-explicit-types"
      ],
      "reason": "依第四節否的判斷原句保留，維持各宣告位置的泛型資訊及禁止使用 var 的限制。"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "去向種類",
      "history_id": "JT-02",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/types-and-generics.md#java-generic-type-information"
      ],
      "reason": "依第四節否的判斷原句保留，維持 raw type 禁令及 Object、萬用字元與泛型抽象的使用界線。"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "去向種類",
      "history_id": "JT-03",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/types-and-generics.md#java-input-output-type-relation"
      ],
      "reason": "共通容器與泛型允許真實關係或解析驗證機制，未直接要求 Java 泛型簽章實際連結輸入輸出及特定業務操作不要求呼叫端轉型補回，故整條保留。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "去向種類",
      "history_id": "JT-04",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/types-and-generics.md#java-business-type-casts"
      ],
      "reason": "依第四節否的判斷原句保留，維持參考型別向下轉型禁令、外部邊界驗證、個別例外及數值轉換適用範圍。"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "去向種類",
      "history_id": "JT-05",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/types-and-generics.md#java-type-safety-warnings"
      ],
      "reason": "依第四節否的判斷原句保留，維持 raw type 與 unchecked 警告、不得抑制檢查及例外核准紀錄要求。"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "去向種類",
      "history_id": "JT-06",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/types-and-generics.md#java-business-data-shape"
      ],
      "reason": "共通容器與泛型禁止以任意鍵值容器替代固定結構，未直接列出 Object[] 陣列承載的禁止事項，無法確認直接涵蓋，故連同 Map 反例及動態映射明確鍵值要求整條保留。整理前原文未提交，無法證明完整覆蓋。"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "去向種類",
      "history_id": "JT-07",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/types-and-generics.md#java-generic-capabilities"
      ],
      "reason": "依第四節否的判斷原句保留，維持型別參數、上界及參數契約的能力表達與不得額外建立介面的界線。"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "去向種類",
      "history_id": "JT-08",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/types-and-generics.md#java-collection-declarations"
      ],
      "reason": "依第四節否的判斷原句保留，維持集合介面與實作類別的選擇，以及可修改性與排序須另訂契約的要求。"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "去向種類",
      "history_id": "JT-09",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/types-and-generics.md#java-diamond-construction"
      ],
      "reason": "依第四節否的判斷原句保留，維持完整宣告前提下僅建構端允許菱形運算子的界線。"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "去向種類",
      "history_id": "JT-10",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/types-and-generics.md#java-generic-return-types"
      ],
      "reason": "依第四節否的判斷原句保留，維持萬用字元回傳與上下界的必要條件，以及不得代替不可變性設計的限制。"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "去向種類",
      "history_id": "JT-11",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/types-and-generics.md#java-type-parameter-names"
      ],
      "reason": "依第四節否的判斷原句保留，維持泛型參數用途關聯可辨識、慣例短名稱及複雜角色命名與說明的界線。"
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| Java 條文 | 語言增量驗收 |\n",
        "after": "| 對應要求 | 語言增量驗收 |\n",
        "reason": "僅將表頭統一為對應要求並將舊條號定位改為語意小節連結，第二欄所有驗收條件逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-explicit-types\"></a>1、9 | 檢查參數、回傳值、欄位與區域變數的明確宣告及泛型資訊，拒絕以 `var` 代替標註。允許的 `<>` 不得被誤判為 raw type，且宣告端須保留完整型別。 |\n",
        "after": "| <a id=\"acceptance-java-explicit-types\"></a>[明確宣告型別](#java-explicit-types)、[允許建構端使用菱形運算子](#java-diamond-construction) | 檢查參數、回傳值、欄位與區域變數的明確宣告及泛型資訊，拒絕以 `var` 代替標註。允許的 `<>` 不得被誤判為 raw type，且宣告端須保留完整型別。 |\n",
        "reason": "僅將表頭統一為對應要求並將舊條號定位改為語意小節連結，第二欄所有驗收條件逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-generic-relations\"></a>2、3、7 | 從實際呼叫處確認泛型的需求、約束及輸入輸出關聯，沒有用 `Object`、萬用字元或無依據的型別參數掩蓋業務型別。以代表性不相容型別案例確認適用的編譯檢查會拒絕。 |\n",
        "after": "| <a id=\"acceptance-java-generic-relations\"></a>[禁止 raw type 與不必要的型別抽象](#java-generic-type-information)、[輸入與輸出的型別關聯](#java-input-output-type-relation)、[型別能力與約束](#java-generic-capabilities) | 從實際呼叫處確認泛型的需求、約束及輸入輸出關聯，沒有用 `Object`、萬用字元或無依據的型別參數掩蓋業務型別。以代表性不相容型別案例確認適用的編譯檢查會拒絕。 |\n",
        "reason": "僅將表頭統一為對應要求並將舊條號定位改為語意小節連結，第二欄所有驗收條件逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-unsafe-casts\"></a>4、5 | 啟用適用的 raw type 與 unchecked 警告檢查，確認新增與修改部分沒有違規，且未透過抑制或關閉檢查隱藏問題。審查向下轉型是否在補回遺失的業務型別；外部輸入以合法及不合法資料驗證邊界處理，必要例外須有核准及驗證依據。 |\n",
        "after": "| <a id=\"acceptance-java-unsafe-casts\"></a>[不得以向下轉型補回業務型別](#java-business-type-casts)、[型別安全警告](#java-type-safety-warnings) | 啟用適用的 raw type 與 unchecked 警告檢查，確認新增與修改部分沒有違規，且未透過抑制或關閉檢查隱藏問題。審查向下轉型是否在補回遺失的業務型別；外部輸入以合法及不合法資料驗證邊界處理，必要例外須有核准及驗證依據。 |\n",
        "reason": "僅將表頭統一為對應要求並將舊條號定位改為語意小節連結，第二欄所有驗收條件逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-generic-return\"></a>8、10 | 從使用端確認集合介面及回傳型別足以完成契約操作，不需要補做轉型；檢查暴露實作類別或萬用字元是否有必要，且未將其誤作不可變性保證。 |\n",
        "after": "| <a id=\"acceptance-java-generic-return\"></a>[集合與映射的宣告型別](#java-collection-declarations)、[泛型回傳值](#java-generic-return-types) | 從使用端確認集合介面及回傳型別足以完成契約操作，不需要補做轉型；檢查暴露實作類別或萬用字元是否有必要，且未將其誤作不可變性保證。 |\n",
        "reason": "僅將表頭統一為對應要求並將舊條號定位改為語意小節連結，第二欄所有驗收條件逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-type-parameter-names\"></a>11 | 審查泛型參數名稱是否足以辨識責任及關聯，複雜契約有必要說明，不僅依名稱長度判定。 |\n",
        "after": "| <a id=\"acceptance-java-type-parameter-names\"></a>[泛型參數命名](#java-type-parameter-names) | 審查泛型參數名稱是否足以辨識責任及關聯，複雜契約有必要說明，不僅依名稱長度判定。 |\n",
        "reason": "僅將表頭統一為對應要求並將舊條號定位改為語意小節連結，第二欄所有驗收條件逐字保留。"
      }
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "type": "去向種類",
      "history_id": "RF-01",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/reflection-and-suppression.md#java-dynamic-type-contract"
      ],
      "reason": "第四節判斷為否，原文保留反射需求、靜態型別契約、責任集中與動態物件不得散入業務流程的完整限制。"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "type": "去向種類",
      "history_id": "RF-02",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/quality/security.md#dynamic-target-authorization"
      ],
      "reason": "第三節判斷為重述，受控類別、方法與建構子及型別符合不能取代授權均由安全共通原句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "type": "去向種類",
      "history_id": "RF-03",
      "decision": "保留條文／否",
      "expected": "保留增量",
      "actual": "保留增量",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/reflection-and-suppression.md#java-reflective-encapsulation"
      ],
      "reason": "第四節判斷為否，原文保留特殊存取核准、受支援整合優先、不得自行豁免及私有欄位不得避開建立規則。"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "type": "去向種類",
      "history_id": "RF-04",
      "decision": "重述",
      "expected": "整條移除",
      "actual": "整條移除",
      "conservative": false,
      "targets": [
        "rules/coding/type-safety.md#dynamic-contract-validation"
      ],
      "reason": "第三節判斷為重述，能力、版本及型別驗證與不得只憑名稱或未驗證轉型由型別安全共通原句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "type": "去向種類",
      "history_id": "RF-05",
      "decision": "混合",
      "expected": "拆分",
      "actual": "拆分",
      "conservative": false,
      "targets": [
        "rules/stacks/java/common/reflection-and-suppression.md#java-reflection-failure"
      ],
      "reason": "第三節判斷為混合，保留 Java 反射外層例外及原始原因；不得推定未執行而替換或重跑由共通外層例外與重試安全性原句承接。"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "type": "去向種類",
      "history_id": "RF-06",
      "decision": "混合",
      "expected": "拆分",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/reflection-and-suppression.md#java-warning-suppression"
      ],
      "reason": "第八次審閱 RF-06：依核准還原基準完整引用與 Java 原句，避免涵蓋不直接或引用移離小節；不再登記任何移除斷言。"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "type": "去向種類",
      "history_id": "RF-07",
      "decision": "驗收入口",
      "expected": "轉為驗收入口",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/reflection-and-suppression.md#java-generated-code"
      ],
      "reason": "第三節判斷為驗收入口，依作業說明整條逐字保留來源重建、手寫銜接型別檢查及例外範圍確認，交協調者決定。"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "type": "去向種類",
      "history_id": "RF-08",
      "decision": "驗收入口",
      "expected": "轉為驗收入口",
      "actual": "整條保留",
      "conservative": true,
      "targets": [
        "rules/stacks/java/common/reflection-and-suppression.md#java-dynamic-verification"
      ],
      "reason": "第三節判斷為驗收入口，依作業說明整條逐字保留 Java 實際反射、存取、重新產生路徑及不能只確認成功的要求，交協調者決定。"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "type": "刪除完整性",
      "history_id": "RF-05",
      "source": "Java 反射或動態呼叫的外層例外須保留原始原因，不能據此推定目標未執行而替換或重跑。",
      "unreported_fragments": [

      ]
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| Java 條文 | 語言增量驗收 |\n",
        "after": "| 對應要求 | 語言增量驗收 |\n",
        "reason": "驗收第一欄改用現行語意錨點並統一表頭，第二欄原有驗收條件、適用範圍與禁止事項逐字不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-reflection-boundary\"></a>1 | 審查動態能力的必要性、管理位置與內部型別契約。反射與動態呼叫均須納入，確認對內提供明確型別契約，動態名稱及未知物件沒有散入業務流程。 |\n",
        "after": "| <a id=\"acceptance-java-reflection-boundary\"></a>[明確需求與型別契約](#java-dynamic-type-contract) | 審查動態能力的必要性、管理位置與內部型別契約。反射與動態呼叫均須納入，確認對內提供明確型別契約，動態名稱及未知物件沒有散入業務流程。 |\n",
        "reason": "驗收第一欄改用現行語意錨點並統一表頭，第二欄原有驗收條件、適用範圍與禁止事項逐字不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "type": "acceptance_changes",
      "record": {
        "before": "| <a id=\"acceptance-java-reflective-access\"></a>3 | 核對特殊存取的核准範圍，以及建立與還原不會繞過必要驗證或產出無效物件。對反射與動態能力核對特殊存取的必要性及受支援替代方式，經實際建立及還原路徑確認維持不變條件及封裝；例如私有欄位寫入或存取放寬亦不得繞過上述保證。 |\n",
        "after": "| <a id=\"acceptance-java-reflective-access\"></a>[維持封裝與不變條件](#java-reflective-encapsulation) | 核對特殊存取的核准範圍，以及建立與還原不會繞過必要驗證或產出無效物件。對反射與動態能力核對特殊存取的必要性及受支援替代方式，經實際建立及還原路徑確認維持不變條件及封裝；例如私有欄位寫入或存取放寬亦不得繞過上述保證。 |\n",
        "reason": "驗收第一欄改用現行語意錨點並統一表頭，第二欄原有驗收條件、適用範圍與禁止事項逐字不變。"
      }
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "sentence": 7,
      "history_id": "RF-02",
      "action": "移除",
      "source": "依[受控目標與授權的共通要求](../../../quality/security.md#dynamic-target-authorization)執行。",
      "targets": [
        {
          "uri": "rules/quality/security.md#dynamic-target-authorization"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[受控目標與授權的共通要求](../../../quality/security.md#dynamic-target-authorization)執行。",
          "source_uri": "rules/quality/security.md#dynamic-target-authorization",
          "source_text": "動態載入、建立或呼叫的目標須由受控登錄或允許清單限定，不得直接依未受信任輸入解析並執行任意類別、方法或建構子。"
        }
      ],
      "reason": "本句只要求依安全共通受控目標條文執行，移除純引用入口並於引言保留相同錨點，實際受控登錄與授權政策仍由該來源維護。"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "sentence": 8,
      "history_id": "RF-02",
      "action": "移除",
      "source": "Java 類別、方法及建構子的動態目標須受控，不因型別符合就略過授權。",
      "targets": [
        {
          "uri": "rules/quality/security.md#dynamic-target-authorization"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 類別、方法及建構子的動態目標須受控",
          "source_uri": "rules/quality/security.md#dynamic-target-authorization",
          "source_text": "動態載入、建立或呼叫的目標須由受控登錄或允許清單限定，不得直接依未受信任輸入解析並執行任意類別、方法或建構子。"
        },
        {
          "text": "不因型別符合就略過授權",
          "source_uri": "rules/quality/security.md#dynamic-target-authorization",
          "source_text": "未知目標須明確拒絕，目標符合型別也不能取代授權檢查。"
        }
      ],
      "reason": "第三節判斷為重述，受控類別、方法與建構子及型別符合不能取代授權均由安全共通原句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "sentence": 12,
      "history_id": "RF-04",
      "action": "移除",
      "source": "依[使用前驗證契約的共通要求](../../../coding/type-safety.md#dynamic-contract-validation)執行。",
      "targets": [
        {
          "uri": "rules/coding/type-safety.md#dynamic-contract-validation"
        }
      ],
      "removed_assertions": [
        {
          "text": "依[使用前驗證契約的共通要求](../../../coding/type-safety.md#dynamic-contract-validation)執行。",
          "source_uri": "rules/coding/type-safety.md#dynamic-contract-validation",
          "source_text": "動態元件須在適當的啟動、註冊或呼叫階段驗證能力、版本與型別契約。"
        }
      ],
      "reason": "本句只要求依型別安全共通契約驗證條文執行，移除純引用入口並於引言保留相同錨點，能力版本與型別的檢查仍由原來源維護。"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "sentence": 13,
      "history_id": "RF-04",
      "action": "移除",
      "source": "Java 動態元件須驗證能力、版本及型別，不只確認名稱存在，也不靠未驗證轉型掩蓋不相容。",
      "targets": [
        {
          "uri": "rules/coding/type-safety.md#dynamic-contract-validation"
        }
      ],
      "removed_assertions": [
        {
          "text": "Java 動態元件須驗證能力、版本及型別",
          "source_uri": "rules/coding/type-safety.md#dynamic-contract-validation",
          "source_text": "動態元件須在適當的啟動、註冊或呼叫階段驗證能力、版本與型別契約。"
        },
        {
          "text": "不只確認名稱存在，也不靠未驗證轉型掩蓋不相容",
          "source_uri": "rules/coding/type-safety.md#dynamic-contract-validation",
          "source_text": "不符合時明確拒絕，不得僅憑名稱存在就執行，也不得靠未經驗證的轉型或任意替代掩蓋不相容。"
        }
      ],
      "reason": "第三節判斷為重述，能力、版本及型別驗證與不得只憑名稱或未驗證轉型由型別安全共通原句直接承接。"
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "sentence": 15,
      "history_id": "RF-05",
      "action": "改寫",
      "source": "Java 反射或動態呼叫的外層例外須保留原始原因，不能據此推定目標未執行而替換或重跑。",
      "targets": [
        {
          "uri": "rules/stacks/java/common/reflection-and-suppression.md#java-reflection-failure",
          "text": "Java 反射或動態呼叫的外層例外須保留原始原因。"
        }
      ],
      "removed_assertions": [
        {
          "text": "不能據此推定目標未執行而替換或重跑",
          "source_uri": "rules/coding/error-handling.md#dynamic-failure-classification",
          "source_text": "不得將所有失敗統一視為目標不存在，也不得未確認執行結果與重試安全性就改用其他目標或重新執行；外層收到例外不代表目標未執行或未產生副作用。"
        }
      ],
      "reason": "第三節判斷為混合，保留 Java 反射外層例外及原始原因；不得推定未執行而替換或重跑由共通外層例外與重試安全性原句承接。"
    },
    {
      "path": "rules/stacks/java/common/boundary-mapping.md",
      "type": "group_routes",
      "record": {
        "heading": "契約與映射責任",
        "targets": [
          "rules/architecture/boundary-objects.md#隔離與拆分",
          "rules/architecture/data-mapping.md#mapping-responsibility"
        ],
        "text": "本組下列要求由共通規範承接：[隔離與拆分](../../../architecture/boundary-objects.md#隔離與拆分)、[聚焦轉換與必要驗證](../../../architecture/data-mapping.md#mapping-responsibility)。"
      }
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "group_routes",
      "record": {
        "heading": "介面、繼承與建立條件",
        "targets": [
          "rules/coding/code-design.md#substitutability",
          "rules/coding/resource-lifecycle.md#initialization-readiness"
        ],
        "text": "本組下列要求由共通規範承接：[繼承的可替代性](../../../coding/code-design.md#substitutability)、[必要資料與依賴齊備](../../../coding/resource-lifecycle.md#initialization-readiness)。"
      }
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "group_routes",
      "record": {
        "heading": "依賴、建立方式與擴充",
        "targets": [
          "rules/coding/code-design.md#construction-entrypoints",
          "rules/coding/code-design.md#interface-capabilities"
        ],
        "text": "本組下列要求由共通規範承接：[依需求選擇建立方式](../../../coding/code-design.md#construction-entrypoints)、[介面的能力劃分](../../../coding/code-design.md#interface-capabilities)。"
      }
    },
    {
      "path": "rules/stacks/java/common/classes-and-construction.md",
      "type": "group_routes",
      "record": {
        "heading": "共用範圍與驗證",
        "targets": [
          "rules/coding/resource-lifecycle.md#shared-lifecycle"
        ],
        "text": "本組下列要求由共通規範承接：[生命週期與可變狀態相容](../../../coding/resource-lifecycle.md#shared-lifecycle)。"
      }
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "type": "group_routes",
      "record": {
        "heading": "所有權與集合語意",
        "targets": [
          "rules/coding/collections-and-ownership.md#order-and-duplicates"
        ],
        "text": "本組下列要求由共通規範承接：[順序與重複資料](../../../coding/collections-and-ownership.md#order-and-duplicates)。"
      }
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "type": "group_routes",
      "record": {
        "heading": "修改與併發",
        "targets": [
          "rules/coding/collections-and-ownership.md#traversal-mutation",
          "rules/coding/concurrency-and-async.md#compound-atomicity"
        ],
        "text": "本組下列要求由共通規範承接：[遍歷期間的修改](../../../coding/collections-and-ownership.md#traversal-mutation)、[複合操作的原子性](../../../coding/concurrency-and-async.md#compound-atomicity)。"
      }
    },
    {
      "path": "rules/stacks/java/common/collections-and-ownership.md",
      "type": "group_routes",
      "record": {
        "heading": "資料規模、資源與批次結果",
        "targets": [
          "rules/quality/performance.md#bounded-accumulation"
        ],
        "text": "本組下列要求由共通規範承接：[限制資料累積](../../../quality/performance.md#bounded-accumulation)。"
      }
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "group_routes",
      "record": {
        "heading": "工作所有權與執行資源",
        "targets": [
          "rules/coding/concurrency-and-async.md#async-result-reception",
          "rules/coding/concurrency-and-async.md#task-ownership"
        ],
        "text": "本組下列要求由共通規範承接：[結果接收與故障處置](../../../coding/concurrency-and-async.md#async-result-reception)、[明確的工作擁有者](../../../coding/concurrency-and-async.md#task-ownership)。"
      }
    },
    {
      "path": "rules/stacks/java/common/concurrency-and-async.md",
      "type": "group_routes",
      "record": {
        "heading": "期限、取消與結果",
        "targets": [
          "rules/coding/concurrency-and-async.md#deadline-budget"
        ],
        "text": "本組下列要求由共通規範承接：[等待期限與逾時處置](../../../coding/concurrency-and-async.md#deadline-budget)。"
      }
    },
    {
      "path": "rules/stacks/java/common/exceptions-and-resources.md",
      "type": "group_routes",
      "record": {
        "heading": "資源所有權與失敗清理",
        "targets": [
          "rules/coding/resource-lifecycle.md#partial-acquisition",
          "rules/coding/resource-lifecycle.md#resource-close-contract"
        ],
        "text": "本組下列要求由共通規範承接：[部分取得與所有權移交](../../../coding/resource-lifecycle.md#partial-acquisition)、[有效期與關閉契約](../../../coding/resource-lifecycle.md#resource-close-contract)。"
      }
    },
    {
      "path": "rules/stacks/java/common/naming-packages-docs.md",
      "type": "group_routes",
      "record": {
        "heading": "契約文件與維護",
        "targets": [
          "rules/coding/code-design.md#implementation-notes"
        ],
        "text": "本組下列要求由共通規範承接：[實作註解與暫時處理](../../../coding/code-design.md#implementation-notes)。"
      }
    },
    {
      "path": "rules/stacks/java/common/null-and-optional.md",
      "type": "group_routes",
      "record": {
        "heading": "空值限制與整合責任",
        "targets": [
          "rules/coding/code-design.md#construction-entrypoints",
          "rules/coding/domain-modeling.md#專屬型別",
          "rules/coding/domain-modeling.md#狀態建模",
          "rules/coding/error-handling.md#程式缺陷與不變條件",
          "rules/coding/validation.md#責任分工"
        ],
        "text": "本組下列要求由共通規範承接：[依需求選擇建立方式](../../../coding/code-design.md#construction-entrypoints)、[專屬型別](../../../coding/domain-modeling.md#專屬型別)、[狀態建模](../../../coding/domain-modeling.md#狀態建模)、[程式缺陷與不變條件](../../../coding/error-handling.md#程式缺陷與不變條件)、[責任分工](../../../coding/validation.md#責任分工)。"
      }
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "group_routes",
      "record": {
        "heading": "數值表示與運算",
        "targets": [
          "rules/coding/numbers-dates-text.md#numeric-range-checks"
        ],
        "text": "本組下列要求由共通規範承接：[範圍與轉換檢查](../../../coding/numbers-dates-text.md#numeric-range-checks)。"
      }
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "group_routes",
      "record": {
        "heading": "日期時間語意與來源",
        "targets": [
          "rules/coding/numbers-dates-text.md#timezone-conversion"
        ],
        "text": "本組下列要求由共通規範承接：[明確的時區轉換](../../../coding/numbers-dates-text.md#timezone-conversion)。"
      }
    },
    {
      "path": "rules/stacks/java/common/numbers-dates-text.md",
      "type": "group_routes",
      "record": {
        "heading": "文字編碼、長度與比較",
        "targets": [
          "rules/coding/numbers-dates-text.md#character-encoding",
          "rules/coding/numbers-dates-text.md#text-transformations"
        ],
        "text": "本組下列要求由共通規範承接：[明確指定字元編碼](../../../coding/numbers-dates-text.md#character-encoding)、[用途明確的文字轉換](../../../coding/numbers-dates-text.md#text-transformations)。"
      }
    },
    {
      "path": "rules/stacks/java/common/reflection-and-suppression.md",
      "type": "group_routes",
      "record": {
        "heading": "動態能力與存取邊界",
        "targets": [
          "rules/coding/type-safety.md#dynamic-contract-validation",
          "rules/quality/security.md#dynamic-target-authorization"
        ],
        "text": "本組下列要求由共通規範承接：[使用前驗證契約](../../../coding/type-safety.md#dynamic-contract-validation)、[受控目標與授權](../../../quality/security.md#dynamic-target-authorization)。"
      }
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "group_routes",
      "record": {
        "heading": "操作結果與使用端處理",
        "targets": [
          "rules/coding/domain-modeling.md#exhaustive-result-handling",
          "rules/coding/domain-modeling.md#operation-results"
        ],
        "text": "本組下列要求由共通規範承接：[處理完整性](../../../coding/domain-modeling.md#exhaustive-result-handling)、[結果與目前狀態分開表達](../../../coding/domain-modeling.md#operation-results)。"
      }
    },
    {
      "path": "rules/stacks/java/common/states-and-results.md",
      "type": "group_routes",
      "record": {
        "heading": "外部代碼、擴充與結果資料",
        "targets": [
          "rules/coding/domain-modeling.md#result-facts"
        ],
        "text": "本組下列要求由共通規範承接：[結果保留當時事實](../../../coding/domain-modeling.md#result-facts)。"
      }
    },
    {
      "path": "rules/stacks/java/common/types-and-generics.md",
      "type": "group_endings",
      "record": {
        "heading": "明確宣告與型別關係",
        "anchor": "java-group-notes-explicit-types",
        "text": "既有程式碼的漸進導入、工具產生碼與個別例外依[規範治理](../../../workflow/rule-governance.md)辦理。測試不得透過不安全轉型偽造有效物件，另見[測試程式碼要求](../../../quality/rule-verification.md#測試程式碼)。"
      }
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "group_routes",
      "record": {
        "heading": "型別責任與有效性",
        "targets": [
          "rules/coding/code-design.md#construction-entrypoints",
          "rules/coding/domain-modeling.md#專屬型別",
          "rules/coding/validation.md#責任分工"
        ],
        "text": "本組下列要求由共通規範承接：[依需求選擇建立方式](../../../coding/code-design.md#construction-entrypoints)、[專屬型別](../../../coding/domain-modeling.md#專屬型別)、[責任分工](../../../coding/validation.md#責任分工)。"
      }
    },
    {
      "path": "rules/stacks/java/common/value-objects.md",
      "type": "link_retention",
      "record": {
        "targets": [
          "rules/coding/validation.md"
        ],
        "text": "本文件另依[資料驗證](../../../coding/validation.md)辦理。"
      }
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "group_endings",
      "record": {
        "heading": "版本宣告與相容性",
        "anchor": "java-group-notes-version-declarations",
        "text": "例如，建置 JDK 與部署環境使用 Java 21，而產物承諾相容 Java 17 時，編譯須維持 Java 17 的語言、API 及位元碼限制，並有 Java 17 與實際部署環境的驗證依據。"
      }
    },
    {
      "path": "rules/stacks/java/common/version-policy.md",
      "type": "group_endings",
      "record": {
        "heading": "依賴、升級與特殊功能",
        "anchor": "java-group-notes-dependency-versions",
        "text": "Preview 的採用紀錄及其他例外均依[規範治理](../../../workflow/rule-governance.md#例外核准)管理。既有程式碼依相同文件的漸進導入要求處理。"
      }
    }
  ],
  "manual_limitations": [
    "即使承接原文逐字存在，是否與被刪斷言相關仍須逐項人工複核",
    "語意等價、理由充分性與語意重複無法機械證明"
  ],
  "legacy_snapshot_local_links": 2587,
  "current_local_links": 2677,
  "presentation": {
    "start": "3f68be483882d8dbfb6611bd58c40ec7446414af",
    "aliases": 74,
    "layout": true,
    "index": true,
    "semantic_snapshot": "3f68be483882d8dbfb6611bd58c40ec7446414af",
    "guarantee": "現行全文與紀錄逐字等於起點的核准連結及版面轉換；逐句語意／驗收仍由起點檢查承接"
  }
}
exit=0
```

## `ruby scripts/verify-body-sentences.rb`

```text
{
  "start": "3f68be483882d8dbfb6611bd58c40ec7446414af",
  "files": 54,
  "nonblank_units": 1999,
  "sentence_multisets_equal": true,
  "method": "正規化連結別名，排除空白、錨點行、固定指路句與固定補充標題；保留重複數及程式碼行",
  "excluded": "rules/stacks/java/README.md"
}
exit=0
```

## `ruby scripts/test-body-presentation.rb`

```text
[
  {
    "test": "第五節不能改成其他名稱",
    "matched": true,
    "diagnostic": "第五節實際名稱不符"
  },
  {
    "test": "不能新增未列管 Java 紀錄",
    "matched": true,
    "diagnostic": "階段 C Java 紀錄檔案清冊不符"
  },
  {
    "test": "不能新增未列管共通紀錄",
    "matched": true,
    "diagnostic": "階段 C 共通紀錄檔案清冊不符"
  },
  {
    "test": "全部合法轉換及新舊錨點同一正文",
    "matched": true,
    "diagnostic": "現行別名、版面、句子與追溯通過"
  },
  {
    "test": "起點不得後移",
    "matched": true,
    "diagnostic": "階段 C 設定或起點不符"
  },
  {
    "test": "別名漏列",
    "matched": true,
    "diagnostic": "別名清冊與核准第五節不符"
  },
  {
    "test": "舊錨點不可刪",
    "matched": true,
    "diagnostic": "階段 C 非核准連結／版面改動 rules/architecture/data-mapping.md"
  },
  {
    "test": "共通正文不可改",
    "matched": true,
    "diagnostic": "階段 C 非核准連結／版面改動 rules/architecture/data-mapping.md"
  },
  {
    "test": "舊連結不能回流",
    "matched": true,
    "diagnostic": "指路句不符 rules/stacks/java/common/boundary-mapping.md；期待值：本組下列要求由共通規範承接：[隔離與拆分](../../../architecture/boundary-objects.md#隔離與拆分)、[聚焦轉換與必要驗證](../../../architecture/data-mapping.md#mapping-responsibility)。"
  },
  {
    "test": "非空分組缺指路",
    "matched": true,
    "diagnostic": "指路句不符 rules/stacks/java/common/classes-and-construction.md；期待值：本組下列要求由共通規範承接：[繼承的可替代性](../../../coding/code-design.md#substitutability)、[必要資料與依賴齊備](../../../coding/resource-lifecycle.md#initialization-readiness)。"
  },
  {
    "test": "指路標籤不得使用代碼",
    "matched": true,
    "diagnostic": "指路句不符 rules/stacks/java/common/classes-and-construction.md；期待值：本組下列要求由共通規範承接：[繼承的可替代性](../../../coding/code-design.md#substitutability)、[必要資料與依賴齊備](../../../coding/resource-lifecycle.md#initialization-readiness)。"
  },
  {
    "test": "指路不得夾帶義務",
    "matched": true,
    "diagnostic": "階段 C 非核准連結／版面改動 rules/stacks/java/common/classes-and-construction.md"
  },
  {
    "test": "指路紀錄來源不符",
    "matched": true,
    "diagnostic": "階段 C 去向／版面紀錄不符 docs/body-restructuring/java/classes-and-construction.json；期待值：{\"baseline\":\"350668eb14ede247af22c782323beebf940c2a5f\",\"path\":\"rules/stacks/java/common/classes-and-construction.md\",\"status\":\"completed\",\"rules\":[{\"id\":\"CL-01\",\"kind\":\"整條保"
  },
  {
    "test": "分組尾段不可改字",
    "matched": true,
    "diagnostic": "階段 C 非核准連結／版面改動 rules/stacks/java/common/version-policy.md"
  },
  {
    "test": "補充標題不可任意改名",
    "matched": true,
    "diagnostic": "階段 C 非核准連結／版面改動 rules/stacks/java/common/version-policy.md"
  },
  {
    "test": "Java 原句不可刪",
    "matched": true,
    "diagnostic": "階段 C 非核准連結／版面改動 rules/stacks/java/common/concurrency-and-async.md"
  },
  {
    "test": "驗收不能改寫",
    "matched": true,
    "diagnostic": "階段 C 非核准連結／版面改動 rules/stacks/java/common/concurrency-and-async.md"
  },
  {
    "test": "第五節不能少列",
    "matched": true,
    "diagnostic": "第五節別名清冊不完整"
  },
  {
    "test": "前階段追溯不可改",
    "matched": true,
    "diagnostic": "前階段共通追溯紀錄改動"
  },
  {
    "test": "新句即使重複也拒絕",
    "matched": true,
    "diagnostic": "階段 C 非核准連結／版面改動 rules/stacks/java/common/concurrency-and-async.md"
  }
]
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
    "diagnostic": "<暫存複本> `check': 歷史 ID 去向與句子小節不一致 JN-01：若有整句移除，請在 rules[].targets 加列該句承接的共通錨點 (RuntimeError)"
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
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 未核准的共通紀錄檔名 (RuntimeError)"
  },
  {
    "test": "N16 假完成",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "已完成紀錄仍有尚未整理去向",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 已完成紀錄仍有尚未整理去向 (RuntimeError)"
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
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 未整理文件改動 rules/stacks/java/common/version-policy.md (RuntimeError)"
  },
  {
    "test": "行尾變更（動態基準夾具）",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "未整理文件改動",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 未整理文件改動 rules/stacks/java/common/version-policy.md (RuntimeError)"
  },
  {
    "test": "未登錄共通改動",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "未登錄改動 rules/coding/nullability.md",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 未登錄改動 rules/coding/nullability.md (RuntimeError)"
  },
  {
    "test": "歷史 ID 遺漏",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "歷史 ID 集合不完整或重複",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 歷史 ID 集合不完整或重複 (RuntimeError)"
  },
  {
    "test": "去向種類無效",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "去向種類無效",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 去向種類無效 (RuntimeError)"
  },
  {
    "test": "Java 基準移動",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "Java 基準不符",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': Java 基準不符 (RuntimeError)"
  },
  {
    "test": "句子遺漏",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "基準逐句去向不完整",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 基準逐句去向不完整 rules/stacks/java/common/null-and-optional.md (RuntimeError)"
  },
  {
    "test": "去向文字不存在",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "去向文字不存在",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 去向文字不存在 (RuntimeError)"
  },
  {
    "test": "去向錨點不存在",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "去向錨點無效",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 去向錨點無效 rules/stacks/java/common/null-and-optional.md#java-query-absence-不存在 (RuntimeError)"
  },
  {
    "test": "改寫理由不足",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "句子改寫／移除理由不足",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 句子改寫／移除理由不足 (RuntimeError)"
  },
  {
    "test": "共通來源指向 Java",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "共通來源指向 Java",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 共通來源指向 Java (RuntimeError)"
  },
  {
    "test": "共通基準不符",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "共通基準不符",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 共通基準不符 (RuntimeError)"
  },
  {
    "test": "共通修改 Java",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "共通清單不得修改 Java 文件",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 共通清單不得修改 Java 文件 (RuntimeError)"
  },
  {
    "test": "共通決策缺漏",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "共通差異缺決策列",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 共通差異缺決策列 (RuntimeError)"
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
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 整理狀態無效 (RuntimeError)"
  },
  {
    "test": "隱藏檔",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "rules 檔案清單變更未登錄",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': rules 檔案清單變更未登錄為整份併入 (RuntimeError)"
  },
  {
    "test": "連結檔案不存在",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "連結檔案不存在",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 連結檔案不存在 docs/negative-link.md: 不存在.md (RuntimeError)"
  },
  {
    "test": "連結錨點不存在",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "連結錨點不存在",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 連結錨點不存在 docs/negative-link.md: ../rules/coding/nullability.md#不存在 (RuntimeError)"
  },
  {
    "test": "重複錨點",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "錨點重複",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 錨點重複 docs/negative-anchor.md (RuntimeError)"
  },
  {
    "test": "移除目的地是 Java",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "移除須指向共通條文",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 移除須指向共通條文 (RuntimeError)"
  },
  {
    "test": "驗收變更理由不足",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收變更來源／理由無效",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 驗收變更來源／理由無效 (RuntimeError)"
  },
  {
    "test": "驗收重複登錄",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收變更重複",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 驗收變更重複 (RuntimeError)"
  },
  {
    "test": "驗收第二欄改動",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收內容不得以條號調整之名改寫",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 驗收內容不得以條號調整之名改寫 (RuntimeError)"
  },
  {
    "test": "L13 任意表頭名稱",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "驗收表頭不允許任意改名",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 驗收表頭不允許任意改名 (RuntimeError)"
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
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 整份併入種類不一致 (RuntimeError)"
  },
  {
    "test": "整份併入沒有接收檔",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "整份併入檔案狀態不符",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 整份併入檔案狀態不符 (RuntimeError)"
  },
  {
    "test": "整份併入漏完整刪文",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "整份併入未登錄完整刪文",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 整份併入未登錄完整刪文 (RuntimeError)"
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
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 歷史去向理由不足 (RuntimeError)"
  },
  {
    "test": "歷史去向清空",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "歷史 ID 沒有現行去向",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 歷史 ID 沒有現行去向 (RuntimeError)"
  },
  {
    "test": "句子處置無效",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "句子處置無效",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 句子處置無效 (RuntimeError)"
  },
  {
    "test": "句子去向清空",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "句子沒有去向",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 句子沒有去向 (RuntimeError)"
  },
  {
    "test": "去向不在同一小節",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "去向文字不存在",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 去向文字不存在 (RuntimeError)"
  },
  {
    "test": "非分類 Java 檔案",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "Java 文件不在原分類範圍",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': Java 文件不在原分類範圍 (RuntimeError)"
  },
  {
    "test": "隱藏共通清單",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "未核准的共通紀錄檔名",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 未核准的共通紀錄檔名 (RuntimeError)"
  },
  {
    "test": "非 JSON 共通檔",
    "expected_exit": 1,
    "actual_exit": 1,
    "expected_diagnostic": "未核准的共通紀錄檔名",
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 未核准的共通紀錄檔名 (RuntimeError)"
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
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 驗收追溯失敗： (RuntimeError)"
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
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 條文小標題不符基準：不接受一級標題去向 (RuntimeError)"
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
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 重複文件紀錄 (RuntimeError)"
  },
  {
    "test": "文件 ID 順序錯誤",
    "expected": "文件歷史 ID 不符合基準條文",
    "exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 文件歷史 ID 不符合基準條文 (RuntimeError)"
  },
  {
    "test": "差異清單未知檔案",
    "expected": "差異清單包含未知檔案",
    "exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 差異清單包含未知檔案 (RuntimeError)"
  },
  {
    "test": "新增一般規則檔",
    "expected": "rules 檔案清單變更未登錄",
    "exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': rules 檔案清單變更未登錄為整份併入 (RuntimeError)"
  },
  {
    "test": "保留句文字改寫",
    "expected": "保留句子不是逐字保留",
    "exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 保留句子不是逐字保留 (RuntimeError)"
  },
  {
    "test": "驗收列遺失且同步刪列紀錄",
    "expected": "去向錨點無效",
    "exit": 1,
    "matched": true,
    "diagnostic": "scripts/verify-body-restructuring.rb:13:in `require_check': 去向錨點無效 rules/stacks/java/common/null-and-optional.md#acceptance-java-optional-coverage (RuntimeError)"
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
  },
  {
    "test": "R7 K01 整條刪光仍填拆分",
    "expected": "拆分或保留增量須保留本文件 Java 小節及至少一句正文 EX-02",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 拆分或保留增量須保留本文件 Java 小節及至少一句正文 EX-02 (RuntimeError)"
  },
  {
    "test": "R7 K02 整條刪光仍填保留增量",
    "expected": "拆分或保留增量須保留本文件 Java 小節及至少一句正文 ST-08",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 拆分或保留增量須保留本文件 Java 小節及至少一句正文 ST-08 (RuntimeError)"
  },
  {
    "test": "R7 K03 整條刪光仍填拆分",
    "expected": "拆分或保留增量須保留本文件 Java 小節及至少一句正文 RF-05",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 拆分或保留增量須保留本文件 Java 小節及至少一句正文 RF-05 (RuntimeError)"
  },
  {
    "test": "R7 H01 拆分漏共通去向",
    "expected": "歷史 ID 去向與句子小節不一致 BM-03：若有整句移除，請在 rules[].targets 加列該句承接的共通錨點",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 歷史 ID 去向與句子小節不一致 BM-03：若有整句移除，請在 rules[].targets 加列該句承接的共通錨點 (RuntimeError)"
  },
  {
    "test": "R7 全句移除但借用另一 Java 小節",
    "expected": "拆分或保留增量須保留本文件 Java 小節及至少一句正文 EX-02",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 拆分或保留增量須保留本文件 Java 小節及至少一句正文 EX-02 (RuntimeError)"
  },
  {
    "test": "R7 有保留句但歷史去向無 Java 小節",
    "expected": "拆分或保留增量須保留本文件 Java 小節及至少一句正文 JN-01",
    "exit": 1,
    "matched": true,
    "diagnostic": "<暫存複本> `check': 拆分或保留增量須保留本文件 Java 小節及至少一句正文 JN-01 (RuntimeError)"
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
    "test": "R7 H02 BM-03 拆分同列 Java 與共通去向",
    "exit": 0,
    "matched": true,
    "diagnostic": "主檢查通過"
  },
  {
    "test": "R7 第四節否原句不動填保留增量",
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
    "applicable": false,
    "reason": "對應 Java 文件已整理；必須連同 Java 來源與連結重新規劃撤回，不再單獨套用此測試。",
    "matched": true
  },
  {
    "commit": "5a16124",
    "applicable": false,
    "reason": "對應 Java 文件已整理；必須連同 Java 來源與連結重新規劃撤回，不再單獨套用此測試。",
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
