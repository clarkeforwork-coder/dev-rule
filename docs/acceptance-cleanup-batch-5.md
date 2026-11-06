# 驗收整理第 5 批

基準提交：`0186c6adfce282cbf180207d9ec60833e5c66ce7`。僅在目前分支提交，不推送。

## 範圍與完成標準

- [numbers-dates-text](../rules/stacks/java/common/numbers-dates-text.md)
- [lambda-and-stream](../rules/stacks/java/common/lambda-and-stream.md)
- [naming-packages-docs](../rules/stacks/java/common/naming-packages-docs.md)

規則正文逐字保留；共同驗收引用唯一主要來源，Java 僅保留語言機制增量。原驗收每列分句依原順序串回須與基準一致，每片段只有一個目的地。沒有已核准共通規則依據的要求保留於 Java，不新增跨語言義務。

## 拆分與人工核對

- NT 的精度、捨入、日期、時區、編碼與文字案例均已有完整共同驗收，直接引用。NT 5 保留 BigDecimal 小數位數判同；NT 9 分開 Clock 取時路徑與共同時間基準／單調時間要求。
- LS 1、2 分開流程責任審查與 Lambda 標註；LS 8 分開函式介面例外限制與部分成功項目對應；LS 9 分開 Stream 單次消費／重新取得與資源有效期／關閉。平行 Stream、短路、歸約及中間副作用仍屬原有 Java 執行模型。
- ND 1、2 的命名語意引用共同審查，Java 保留識別字形式、縮寫及 final 判斷。ND 4、5 的整列文件／註解要求引用已有共同驗收；ND 7 保留 Javadoc 與支援 Java 版本範例，共同語意審查改引用。

## 原驗收逐句追溯

下表是歷史原文，執行時只依現行主要來源。

| 片段 ID | 基準原文 | 現行唯一主要來源 |
| --- | --- | --- |
| NT-1、2-1 | 核對型別、來源、單位與精度要求，驗證合法及非法格式、範圍與小數位數。確認精確數值未先經浮點數轉換；近似計算有明確容許誤差。 | [主要驗收](../rules/coding/numbers-dates-text.md#acceptance-numeric-sources) |
| NT-3、4-1 | 驗證捨入邊界、套用階段及適用的極端值，核對累加、乘法、除法與縮小型別的結果，超限或不允許的精度損失須明確回報，不默默截斷或回繞。 | [主要驗收](../rules/coding/numbers-dates-text.md#acceptance-numeric-range-rounding) |
| NT-6、7、8-1 | 核對時間型別與業務意義，驗證適用的月底、閏日、時區切換、不存在或重複當地時間，以及日曆間隔與固定時間長度的差異。業務日期涉及假日時另驗證其規則。 | [主要驗收](../rules/coding/numbers-dates-text.md#acceptance-temporal-semantics) |
| NT-10-1 | 驗證合法格式、不合法日期、多餘尾端內容與精度縮減；核對適用的地區、時區及偏移設定，不以環境預設決定結果。 | [主要驗收](../rules/coding/numbers-dates-text.md#acceptance-temporal-format) |
| NT-11、12、13-1 | 以適用的多位元組字元、表情符號、組合字元、無效編碼及地區差異驗證編解碼、長度、截取與比較。確認未切斷必要字元單位，也未透過未授權正規化改寫或合併識別值。 | [主要驗收](../rules/coding/numbers-dates-text.md#acceptance-text-semantics) |
| NT-14-1 | 檢查案例涵蓋變更影響的邊界與環境條件，並經實際儲存、傳輸或格式化路徑確認值與語意仍符合契約，不僅測試工具函式的一般輸入。 | [主要驗收](../rules/coding/numbers-dates-text.md#acceptance-data-boundaries) |
| NT-5-1 | 以數值相同但小數位數不同及其他代表性資料，確認比較、正規化、雜湊與集合判同符合契約。 | [主要驗收](../rules/stacks/java/common/numbers-dates-text.md#acceptance-java-decimal-equivalence) |
| NT-9-1 | 以可控制的 `Clock` 驗證邊界前、當下與之後， | [主要驗收](../rules/stacks/java/common/numbers-dates-text.md#acceptance-java-clock-injection) |
| NT-9-2 | 確認需要一致判斷的流程共用基準。核對耗時與等待期限使用單調時間來源，沒有以系統日期時間差代替。 | [主要驗收](../rules/coding/numbers-dates-text.md#acceptance-time-source) |
| LS-1、2-1 | 審查流程意圖與責任是否清楚，複雜邏輯有合適表達； | [主要驗收](../rules/stacks/java/common/lambda-and-stream.md#acceptance-java-lambda-types) |
| LS-1、2-2 | 檢查 Lambda 參數明確標註、泛型資訊完整，方法參考可辨識目標與用途，不以縮短行數作為採用依據。 | [主要驗收](../rules/stacks/java/common/lambda-and-stream.md#acceptance-java-lambda-types) |
| LS-3、4-1 | 審查中間操作及呼叫方法，確認沒有隱藏業務副作用或修改外部狀態。必要執行步驟的順序、失敗及部分完成有明確契約，跨元素狀態有管理責任。 | [主要驗收](../rules/stacks/java/common/lambda-and-stream.md#acceptance-java-stream-side-effects) |
| LS-5-1 | 以空資料、單筆、多筆及會短路的案例核對實際處理範圍，確認完整驗證或必要工作沒有因延遲與短路而遺漏，不把建立流程視為完成。 | [主要驗收](../rules/stacks/java/common/lambda-and-stream.md#acceptance-java-stream-short-circuit) |
| LS-6-1 | 採平行處理時，以代表性資料與負載確認結果、順序、隔離及失敗語意，評估阻塞與資源競爭影響，保留量測收益的依據。 | [主要驗收](../rules/stacks/java/common/lambda-and-stream.md#acceptance-java-parallel-stream) |
| LS-7-1 | 驗證初始值、累積與合併結果；適用時以不同分段方式核對契約一致性。順序敏感運算保留約定順序，可變收集結果不受其他分段或執行污染。 | [主要驗收](../rules/stacks/java/common/lambda-and-stream.md#acceptance-java-stream-reduction) |
| LS-10-1 | 確認案例涵蓋受影響的執行語意與資源保證，平行處理有額外隔離及效能證據，不僅比對一般成功案例的最終元素內容。 | [主要驗收](../rules/stacks/java/common/lambda-and-stream.md#acceptance-java-stream-coverage) |
| LS-8-1 | 在適用的處理階段觸發失敗，確認分類與原始原因保留，沒有以空值、替代值或篩除項目掩蓋問題。 | [主要驗收](../rules/stacks/java/common/lambda-and-stream.md#acceptance-java-functional-exceptions) |
| LS-8-2 | 部分成功結果可對應原始項目，副作用符合契約。 | [主要驗收](../rules/quality/rule-verification.md#acceptance-partial-operation) |
| LS-9-1 | 核對 Stream 的建立與消費路徑，沒有重用或共用消費；重複取得資料時依契約驗證快照或最新資料語意。 | [主要驗收](../rules/stacks/java/common/lambda-and-stream.md#acceptance-java-stream-consumption) |
| LS-9-2 | 外部資源在實際使用期間有效，完成、提前停止及失敗後正確釋放。 | [主要驗收](../rules/coding/resource-lifecycle.md#acceptance-lazy-resource-lifetime) |
| ND-1、2-1 | 自動檢查適用的命名形式與團隊縮寫慣例， | [主要驗收](../rules/stacks/java/common/naming-packages-docs.md#acceptance-java-naming-form) |
| ND-1、2-2 | 人工從使用處核對名稱與實際責任一致。 | [主要驗收](../rules/stacks/java/common/naming-packages-docs.md#acceptance-java-naming-form) |
| ND-1、2-3 | 確認未將所有 `final` 欄位機械式視為常數， | [主要驗收](../rules/stacks/java/common/naming-packages-docs.md#acceptance-java-naming-form) |
| ND-1、2-4 | 也未用籠統後綴掩蓋不同用途。 | [主要驗收](../rules/stacks/java/common/naming-packages-docs.md#acceptance-java-naming-form) |
| ND-3-1 | 審查套件責任、公開與內部界線，以及共用套件依賴方向；以適用的可見性與依賴檢查確認邊界有效，不僅核對目錄名稱。 | [主要驗收](../rules/stacks/java/common/naming-packages-docs.md#acceptance-java-package-boundaries) |
| ND-6-1 | 重新命名或搬移後，核對直接引用、設定、動態登錄、序列化或持久化引用及外部使用端等適用路徑。確認相容性與必要遷移已有處置，文件與範例同步更新。 | [主要驗收](../rules/stacks/java/common/naming-packages-docs.md#acceptance-java-rename-paths) |
| ND-4、5-1 | 比對文件、註解與實際行為，確認使用端所需契約完整，理由與限制仍有效，暫時性處理有可追蹤事項。移除過時說明，避免僅重述名稱或複製多份契約。 | [主要驗收](../rules/coding/code-design.md#acceptance-document-contract) |
| ND-7-1 | 驗證受影響的連結、Javadoc 參照與適用範例，確認在支援版本下可用。 | [主要驗收](../rules/stacks/java/common/naming-packages-docs.md#acceptance-java-javadoc-examples) |
| ND-7-2 | 保留語意與契約審查，不把格式或文件產生成功當成全部符合。 | [主要驗收](../rules/quality/rule-verification.md#acceptance-document-verification) |

## 驗證方式

執行 `ruby scripts/verify-acceptance.rb`、`ruby scripts/verify-acceptance.rb --batch 5 --baseline 0186c6adfce282cbf180207d9ec60833e5c66ce7` 及 `git diff --check`。重現歷史差異時加上 `--target` 指定本批完成提交；常駐檢查不使用歷史範圍限制。

## 獨立審閱後的重現方式

上文保留當批執行紀錄；舊提交沒有逐句差異與已改寫清單，不能用修正後檢查器回報通過。現行追溯檢查：`ruby scripts/verify-acceptance.rb --batch 5 --trace-only`；基準自本文讀取。常駐檢查預設同時執行五批追溯與全檔保護；`--target` 的全部讀取及統計皆來自指定提交，不混入工作區。精確差異與改寫理由見 [檢查差異清單](acceptance-check-policy.json)、[已改寫片段清單](acceptance-rewritten-fragments.json)及[審閱修正紀錄](review-remediation.md)。
