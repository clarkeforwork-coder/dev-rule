# 正文結構掃描（第六次修正）

固定基準 `350668eb14ede247af22c782323beebf940c2a5f`；掃描全部 15 份，包含未整理 14 份。下表只計驗收前正文；不將驗收表格當正文表格。

| 文件 | 編號／粗體標題 | 二級分組 | 未編號非空行 | 程式碼圍欄 | 清單 | 表格 | 巢狀標題 |
| --- | --- | --- | --- | --- | --- | --- | --- |
| boundary-mapping.md | 9／9 | 3 | 3 | 0 | 0 | 0 | 0 |
| classes-and-construction.md | 10／10 | 3 | 3 | 0 | 0 | 0 | 0 |
| collections-and-ownership.md | 9／9 | 3 | 3 | 0 | 0 | 0 | 0 |
| concurrency-and-async.md | 12／12 | 4 | 3 | 0 | 0 | 0 | 0 |
| equality-hashing-ordering.md | 10／10 | 2 | 2 | 0 | 0 | 0 | 0 |
| exceptions-and-resources.md | 9／9 | 2 | 3 | 0 | 0 | 0 | 0 |
| lambda-and-stream.md | 10／10 | 3 | 9 | 2 | 0 | 0 | 0 |
| naming-packages-docs.md | 7／7 | 2 | 3 | 0 | 0 | 0 | 0 |
| null-and-optional.md | 12／12 | 3 | 3 | 0 | 0 | 0 | 0 |
| numbers-dates-text.md | 14／14 | 3 | 3 | 0 | 0 | 0 | 0 |
| reflection-and-suppression.md | 8／8 | 2 | 3 | 0 | 0 | 0 | 0 |
| states-and-results.md | 10／10 | 3 | 3 | 0 | 0 | 0 | 0 |
| types-and-generics.md | 11／11 | 2 | 9 | 2 | 0 | 0 | 0 |
| value-objects.md | 10／10 | 3 | 3 | 0 | 0 | 0 | 0 |
| version-policy.md | 12／12 | 3 | 4 | 0 | 0 | 0 | 0 |

所有 153 條均有基準粗體標題，沒有無標題條文。所有文件有檔頭與跨條文尾段；型別文件有中間分組尾段及程式碼範例，其他文件無額外正文清單、表格或巢狀標題。分組尾段統一依原順序移入 `補充要求`；型別範例的圍欄、程式碼行與解說一起逐字保留。分組外的引言保留原位置與引用。

清空分組保留二級標題與已登錄指路句；最後一條移除不影響結尾小節。原有 Markdown 標題與連結有外部或共用索引引用，工作者不能刪分組或擴大標題適用範圍。完整規則與範例見[作業說明](body-restructuring-guide.md)。
