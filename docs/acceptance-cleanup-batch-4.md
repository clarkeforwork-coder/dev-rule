# 驗收整理第 4 批

基準提交：`15ee488028e09a00b05d8f1276ee83bfffc68050`。僅在目前分支提交，不推送。

## 範圍與完成標準

- [value-objects](../rules/stacks/java/common/value-objects.md)
- [states-and-results](../rules/stacks/java/common/states-and-results.md)
- [boundary-mapping](../rules/stacks/java/common/boundary-mapping.md)

規則正文逐字保留；共同驗收引用唯一主要來源，Java 僅保留語言機制增量。原驗收每列分句依原順序串回須與基準一致，每片段只有一個目的地。沒有已核准共通規則依據的要求保留於 Java，不新增跨語言義務。

## 拆分與人工核對

- VO 3、5、6、7 依既有不可變性、正規化、運算與還原規則引用共同驗收；VO 1、2 本次撤回與既有模型驗證摘要重疊的新共通列，完整原驗收留 Java；final 的限制及 equals／hashCode、record 產生方法、toString 交換格式留 Java。
- ST 1、2 原拆成互斥狀態／必要資料與「不同業務面向分別建模」。本次撤回與基準模型驗證段落重疊的新共通列，ST 1、2 及 ST 3 完整原驗收保留 Java，待確認摘要段落的效力，不以摘要為提升依據；ST 7 的 ordinal 與 enum 名稱相容性留 Java。
- BM 1、2、6、8 的驗收依既有邊界拆分、欄位控制、不可變性與責任配置補入主要來源。BM 3、7、9 直接引用已有驗收。BM 4 的半成品與內部缺陷情境暫留 Java，部分成功的項目對應引用既有共同驗收；不使用未列管摘要新增共通要求。
- BM 5 的共同部分逐字補入既有 BM 9 映射驗收列（依既有 bm-09 更新意圖與空值語意規則），不再新增空值正文驗收句；Java 欄位、預設值及反序列化不得合併更新意圖，另留 Java 驗收列。各目的地逐片核對其斷言，未將合併列整列移入不相關規則。

## 原驗收逐句追溯

下表是歷史原文，執行時只依現行主要來源。

| 片段 ID | 基準原文 | 現行唯一主要來源 |
| --- | --- | --- |
| VO-1、2-1 | 審查專屬型別能否阻止業務概念混用，相關介面有無退回一般字串或數字。驗證合法值、邊界值及不合法值，確認建立成功後符合自身規則，且未將格式有效誤當成存在性或授權成立。 | [主要驗收](../rules/stacks/java/common/value-objects.md#acceptance-java-value-validity) |
| VO-3-1 | 對含可變資料的型別，修改傳入或取出的資料，確認原值物件未受影響。檢查封裝與必要的複製， | [主要驗收](../rules/coding/domain-modeling.md#acceptance-value-immutability) |
| VO-3-2 | 不能只檢查欄位是否為 `final`。 | [主要驗收](../rules/stacks/java/common/value-objects.md#acceptance-java-final-references) |
| VO-4-1 | 驗證不同實例的相等值及具代表性的不相等值，相等物件的雜湊值須相同。適用時確認作為集合元素或映射鍵的行為符合契約，不要求不相等物件一定具有不同雜湊值。 | [主要驗收](../rules/stacks/java/common/value-objects.md#acceptance-java-value-equality) |
| VO-8、9-1 | 核對實作形式符合支援版本，產生的方法與手寫方法均遵循相等性、不可變性及揭露契約。確認診斷字串未被默認當成交換格式，對外映射符合約定且未洩漏敏感值。 | [主要驗收](../rules/stacks/java/common/value-objects.md#acceptance-java-generated-representation) |
| VO-5-1 | 以不同合法表示及不合法輸入驗證正規化、驗證順序與相等性符合契約，所有建立入口結果一致，沒有未授權的修剪或數值修正。 | [主要驗收](../rules/coding/domain-modeling.md#acceptance-value-normalization) |
| VO-6-1 | 驗證適用運算的結果、單位與有效性限制，原物件維持不變。確認不相容的值依契約拒絕或處理，使用端未各自拆值繞過規則。 | [主要驗收](../rules/coding/domain-modeling.md#acceptance-value-operations) |
| VO-7-1 | 經實際採用的反序列化、持久化或框架映射路徑驗證合法與不合法資料。涉及歷史資料時，確認按明訂版本或遷移規則還原，不產出違反契約的物件。 | [主要驗收](../rules/coding/domain-modeling.md#acceptance-value-restoration) |
| VO-10-1 | 核對測試涵蓋受影響的業務保證與失效邊界，不以只有建立成功的案例代替驗收， | [主要驗收](../rules/stacks/java/common/value-objects.md#acceptance-java-value-method-coverage) |
| VO-10-2 | 也不要求無業務邏輯的存取方法逐一測試。 | [主要驗收](../rules/stacks/java/common/value-objects.md#acceptance-java-value-method-coverage) |
| ST-1、2-1 | 審查互斥狀態 | [主要驗收](../rules/stacks/java/common/states-and-results.md#acceptance-java-independent-state-models) |
| ST-1、2-2 | 與獨立業務面向是否正確分開， | [主要驗收](../rules/stacks/java/common/states-and-results.md#acceptance-java-independent-state-models) |
| ST-1、2-3 | 必要資料是否由對應型別保護。確認不能建立契約禁止的狀態與資料組合，不以僅存在狀態碼作為符合依據。 | [主要驗收](../rules/stacks/java/common/states-and-results.md#acceptance-java-independent-state-models) |
| ST-3-1 | 驗證允許與不允許的來源狀態、前置條件及轉換後資料。確認公開介面沒有可繞過規則的任意設定路徑，拒絕時未產生不應發生的副作用。 | [主要驗收](../rules/stacks/java/common/states-and-results.md#acceptance-java-state-transition) |
| ST-4、5-1 | 驗證成功、重複操作、拒絕及未完成等適用結果。核對必要原因與資料可由型別判斷，業務完成與已受理有所區別，技術故障未被轉成一般拒絕。 | [主要驗收](../rules/coding/domain-modeling.md#acceptance-operation-results) |
| ST-6、8-1 | 核對模型的封閉或擴充契約與實作限制，審查受影響的使用端分支。模型新增情況時確認適用檢查能發現未處理處，工具未涵蓋者由測試與審查補足；未知或擴充結果不得落入假成功。 | [主要驗收](../rules/coding/domain-modeling.md#acceptance-model-extensibility) |
| ST-9-1 | 在結果產生後改變來源業務物件或其他可變資料，確認結果仍保留當時事實；核對結果只含必要資訊，最新狀態透過獨立查詢取得。 | [主要驗收](../rules/coding/domain-modeling.md#acceptance-result-facts) |
| ST-10-1 | 核對測試涵蓋變更影響的轉換、拒絕、重複操作、資料及分支；以實際狀態與必要副作用驗證結果，而不只檢查回傳型別或成功標記。 | [主要驗收](../rules/coding/domain-modeling.md#acceptance-model-coverage) |
| ST-7-1 | 經適用的傳輸或持久化路徑驗證外部代碼與狀態對應，未知代碼依契約處理。確認未使用 `ordinal()` 作為業務代碼，採用列舉名稱時已評估重新命名的相容性影響。 | [主要驗收](../rules/stacks/java/common/states-and-results.md#acceptance-java-enum-codes) |
| BM-1-1 | 審查邊界物件的契約責任與隔離依據，確認未因欄位相同而不當共用，也未僅因分層而重複建立 DTO。確認公開資料未直接暴露持久化或模組內部模型。 | [主要驗收](../rules/architecture/boundary-objects.md#acceptance-boundary-separation) |
| BM-2-1 | 核對允許欄位及來源，以含管理欄位的外部輸入驗證其無法覆寫可信資料，並確認內部敏感欄位未輸出。映射設定或契約變更時，確認新增來源或目標欄位不會自動擴大允許範圍。 | [主要驗收](../rules/architecture/data-mapping.md#acceptance-mapping-fields) |
| BM-6-1 | 修改來源或目標的可變集合及適用的可變元素，確認另一方保持所需隔離；共用不可變值時核對其不可變性與共用契約，不以全面複製作為唯一合格方式。 | [主要驗收](../rules/architecture/boundary-objects.md#acceptance-boundary-isolation) |
| BM-8-1 | 核對映射所有權、位置與依賴方向，相同契約沒有散落的不一致轉換，不同責任也未被不當集中。 | [主要驗收](../rules/architecture/data-mapping.md#acceptance-mapping-owner) |
| BM-3-1 | 審查映射及其呼叫路徑，確認外部資料取得、業務決策與副作用由負責元件明確協調，沒有藏在單純轉換的方法中。 | [主要驗收](../rules/architecture/data-mapping.md#acceptance-mapping-responsibility) |
| BM-7-1 | 分別核對輸入與輸出欄位及轉換；驗證唯讀、衍生與遮罩資料不會被直接寫回。採用反向映射時，須有允許依據並確認可逆性。 | [主要驗收](../rules/architecture/data-mapping.md#acceptance-directional-mapping) |
| BM-9-1 | 確認測試執行實際採用的映射實作或工具產出，必要時涵蓋序列化與反序列化邊界；斷言須涵蓋欄位值、拒絕結果與禁止傳遞的資料，不僅確認物件非空。 | [主要驗收](../rules/architecture/data-mapping.md#acceptance-mapping-paths) |
| BM-4-1 | 驗證適用的不合法輸入、內部必要資料缺失及轉換失敗，確認沒有預設值或半成品掩蓋問題。 | [主要驗收](../rules/stacks/java/common/boundary-mapping.md#acceptance-java-mapping-failure) |
| BM-4-2 | 批次允許部分成功時，核對每筆結果及對應關係，沒有遺漏失敗項目。 | [主要驗收](../rules/coding/error-handling.md#acceptance-partial-operation) |
| BM-5-1 | 對需要區分更新意圖的契約，從實際接收入口分別提供省略、明確清空及設定值，確認意圖傳遞到業務操作並產生約定效果。 | [主要驗收](../rules/architecture/data-mapping.md#acceptance-mapping-paths) |

## 驗證方式

執行 `ruby scripts/verify-acceptance.rb`、`ruby scripts/verify-acceptance.rb --batch 4 --baseline 15ee488028e09a00b05d8f1276ee83bfffc68050` 及 `git diff --check`。重現歷史差異時加上 `--target` 指定本批完成提交；常駐檢查不使用歷史範圍限制。

後續人工複核：VO 10 的完整覆蓋來源涉及尚未列管的共通摘要，因此覆蓋片段與存取方法測試範圍均保留 Java 主要驗收，未利用該摘要新增共同驗收。追溯表保留基準原文；目的地曾改寫且縮小範圍，本次已還原完整斷言，Java 機制僅作補充。

## 獨立審閱後的重現方式

上文保留當批執行紀錄；舊提交沒有逐句差異與已改寫清單，不能用修正後檢查器回報通過。現行追溯檢查：`ruby scripts/verify-acceptance.rb --batch 4`；基準自本文讀取。常駐檢查預設同時執行五批追溯與全檔保護；`--target` 的全部讀取及統計皆來自指定提交，不混入工作區。精確差異與改寫理由見 [檢查差異清單](acceptance-check-policy.json)、[已改寫片段清單](acceptance-rewritten-fragments.json)及[審閱修正紀錄](review-remediation.md)。
