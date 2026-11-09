# 驗收整理第一批：範圍、標準與逐句去向

基準提交：`6f7ae5d5250b7573a96c85f551b58878eb02c7e4`。基準是保存當時狀態，不表示先前重複或歸屬問題已通過驗收。未推送。

## 本批範圍

- 僅處理 Java 類別／建立、相等性／排序、反射／抑制三份文件及其對應共通驗收。
- 不更動規則正文、不新增跨語言義務。共通驗收中附帶的 Java 覆寫、跨型別相等、反射需求及特殊存取檢查，移回原 Java 義務下。
- 已確認：歷史 ID 保留在追溯表，正式文件可重新編號並移除純引用條目。本批尚不改正文編號；後續正文整理才能移除純引用條目並更新對應。
- 歷史規則錨點、其他十二份 Java 文件及全站重複尚待後續批次，不宣稱本批完成全部歸屬重整。

## 本批完成標準

1. 三份 Java 的驗收與所有共通驗收之間，忽略空白與 Markdown 標記後逐字重複為零；人工確認剩餘 Java 案例具有實質語言增量。
2. 每項受影響驗收斷言有規則依據；合併列按義務拆分，不能整列附帶搬入別條內容。
3. 本批原驗收文字逐句／分句保存在下表；每個片段只指向一個現行主要驗收來源。必要時把一句中的多項義務分開，但串回須等於原文。
4. 除驗收章節外，規則正文與基準逐字相同；不以補上共通規則的方式替附帶驗收找依據。
5. 共通建立入口驗收與元件就緒驗收各負責其保證，避免相同案例在兩份共通文件維護。
6. 所有本地連結、章節錨點與追溯目的地有效，格式檢查通過。

## 主要拆分

| 基準合併列 | 拆分後的主要責任 |
| --- | --- |
| CL 1、8 | 介面用途由依賴組裝驗收；能力及授權由程式碼設計驗收。 |
| CL 2、7 | 可替代性留共通；Java 覆寫與代理配置留語言層。 |
| CL 3、6 | 必要資料與就緒屬生命週期；各建立入口一致有效屬程式碼設計。 |
| EQ 1、2 | 比較語意留共通；equals／hashCode 關係留 Java。 |
| EQ 4、5 | 識別碼生命週期留共通；父子型別比較與框架代理留 Java。 |
| RF 1、2 | 反射需求與集中邊界留 Java；目標允許清單及授權留共通。 |
| RF 3、4 | 特殊反射存取與不變條件留 Java；能力、版本與型別檢查留共通。 |

## 原驗收逐句追溯

| 片段 ID | 基準原文 | 現行唯一主要來源 |
| --- | --- | --- |
| CL-1、8-1 | 審查介面的能力、多型或架構用途與依賴方向，確認沒有僅為 DI 建立無用途介面，也未省略必要隔離。 | [主要驗收](../rules/quality/rule-verification.md#acceptance-interface-purpose) |
| CL-1、8-2 | 核對實作能支援契約操作，介面拆分沒有取代授權。 | [主要驗收](../rules/coding/code-design.md#acceptance-interface-capabilities) |
| CL-2、7-1 | 以受影響的子型別或替代實作驗證共同契約，確認輸入、結果與必要檢查未被破壞。 | [主要驗收](../rules/coding/code-design.md#acceptance-substitutability) |
| CL-2、7-2 | 審查擴充範圍與覆寫方式； | [主要驗收](../rules/stacks/java/common/classes-and-construction.md#acceptance-java-override-safety) |
| CL-2、7-3 | 涉及框架代理時，驗證實際配置仍維持保證。 | [主要驗收](../rules/stacks/java/common/classes-and-construction.md#acceptance-java-override-safety) |
| CL-3、6-1 | 驗證必要資料與依賴的建立限制， | [主要驗收](../rules/coding/resource-lifecycle.md#acceptance-initialization-readiness) |
| CL-3、6-2 | 所有建構子、工廠及適用的 Builder 均維持必要條件，不產出無效目標物件。 | [主要驗收](../rules/coding/code-design.md#acceptance-construction-entrypoints) |
| CL-3、6-3 | 分階段元件未就緒時，須拒絕不允許的操作。 | [主要驗收](../rules/coding/resource-lifecycle.md#acceptance-initialization-readiness) |
| CL-4-1 | 審查建構路徑有無 `this` 外洩或可覆寫方法呼叫。 | [主要驗收](../rules/stacks/java/common/classes-and-construction.md#acceptance-java-construction-safety) |
| CL-4-2 | 適用時核對事件註冊、回呼與背景啟動時機，確認只能使用已完成建立且符合生命週期條件的物件。 | [主要驗收](../rules/stacks/java/common/classes-and-construction.md#acceptance-java-construction-safety) |
| CL-5-1 | 核對服務與外部能力可從明確依賴辨識，沒有隱藏的全域查找。 | [主要驗收](../rules/architecture/dependency-composition.md#acceptance-explicit-dependencies) |
| CL-5-2 | 工廠或提供者具有明確責任，延後或按次建立的實例符合所需生命週期。 | [主要驗收](../rules/architecture/dependency-composition.md#acceptance-explicit-dependencies) |
| CL-9-1 | 涉及共用實例或可變狀態時，依風險以多次或併發操作驗證資料隔離，確認不同使用者或請求不會互相覆蓋。 | [主要驗收](../rules/coding/resource-lifecycle.md#acceptance-shared-lifecycle) |
| CL-9-2 | 核對實際依賴生命週期與取得方式相容。 | [主要驗收](../rules/coding/resource-lifecycle.md#acceptance-shared-lifecycle) |
| CL-10-1 | 核對測試涵蓋受影響的建立、替代、必要檢查與生命週期保證； | [主要驗收](../rules/coding/resource-lifecycle.md#acceptance-lifecycle-coverage) |
| CL-10-2 | 需要框架行為才能成立的保證有實際組裝驗證，不以單純注入成功作為全部符合的證據。 | [主要驗收](../rules/coding/resource-lifecycle.md#acceptance-lifecycle-coverage) |
| EQ-1、2-1 | 核對物件身分、實體身分與值內容的區分； | [主要驗收](../rules/coding/domain-modeling.md#acceptance-identity-semantics) |
| EQ-1、2-2 | 驗證自反、對稱、遞移、一致性及 `null` 處理。 | [主要驗收](../rules/stacks/java/common/equality-hashing-ordering.md#acceptance-java-equality-hash-contract) |
| EQ-1、2-3 | 相等物件須具有相同雜湊值，不以不相等物件的雜湊值必須不同作為斷言，也不僅憑雜湊值判定相等。 | [主要驗收](../rules/stacks/java/common/equality-hashing-ordering.md#acceptance-java-equality-hash-contract) |
| EQ-3-1 | 以實際鍵或元素驗證雜湊集合的查找、去重與移除，確認在集合內比較依據保持穩定。 | [主要驗收](../rules/stacks/java/common/equality-hashing-ordering.md#acceptance-java-hash-collection-stability) |
| EQ-3-2 | 契約允許修改時，驗證先移出、修改、重新加入後的行為及重複處置。 | [主要驗收](../rules/stacks/java/common/equality-hashing-ordering.md#acceptance-java-hash-collection-stability) |
| EQ-4、5-1 | 對適用的 Entity 驗證識別碼產生前後的相等與集合行為； | [主要驗收](../rules/coding/domain-modeling.md#acceptance-identity-lifecycle) |
| EQ-4、5-2 | 對允許繼承的型別，以父子型別及必要的多物件組合確認對稱、遞移與雜湊契約。 | [主要驗收](../rules/stacks/java/common/equality-hashing-ordering.md#acceptance-java-cross-type-equality) |
| EQ-4、5-3 | 框架代理涉及比較時，依實際使用路徑驗證。 | [主要驗收](../rules/stacks/java/common/equality-hashing-ordering.md#acceptance-java-cross-type-equality) |
| EQ-6、7-1 | 核對自然順序或情境排序的選擇， | [主要驗收](../rules/stacks/java/common/equality-hashing-ordering.md#acceptance-java-ordering-choice) |
| EQ-6、7-2 | 驗證方向、同值與遞移關係。 | [主要驗收](../rules/stacks/java/common/equality-hashing-ordering.md#acceptance-java-comparator-relations) |
| EQ-6、7-3 | 數值比較涵蓋適用的極端值，確認不因溢位或精度損失產生錯誤順序，且比較依據在同次排序中穩定。 | [主要驗收](../rules/stacks/java/common/equality-hashing-ordering.md#acceptance-java-comparator-relations) |
| EQ-8-1 | 驗證比較為零與 `equals()` 的約定； | [主要驗收](../rules/stacks/java/common/equality-hashing-ordering.md#acceptance-java-sorted-key-equivalence) |
| EQ-8-2 | 將不同但排序值相同的資料放入實際採用的排序集合或映射，確認資料保留與鍵判同符合契約。 | [主要驗收](../rules/stacks/java/common/equality-hashing-ordering.md#acceptance-java-sorted-key-equivalence) |
| EQ-9-1 | 核對排序元素、鍵與比較器設定的變更路徑。 | [主要驗收](../rules/stacks/java/common/equality-hashing-ordering.md#acceptance-java-sorted-collection-stability) |
| EQ-9-2 | 需要修改時，驗證移出後重新加入或重建的順序、查找及資料保留結果，不依賴原集合自動調整。 | [主要驗收](../rules/stacks/java/common/equality-hashing-ordering.md#acceptance-java-sorted-collection-stability) |
| EQ-10-1 | 確認驗收涵蓋變更影響的關係契約與實際集合操作，沒有只測少數成對比較或以方法由工具產生作為正確依據。 | [主要驗收](../rules/stacks/java/common/equality-hashing-ordering.md#acceptance-java-relationship-coverage) |
| RF-1、2-1 | 審查動態能力的必要性、管理位置與內部型別契約。 | [主要驗收](../rules/stacks/java/common/reflection-and-suppression.md#acceptance-java-reflection-boundary) |
| RF-1、2-2 | 驗證允許目標可依權限執行，未登錄或未知目標明確拒絕； | [主要驗收](../rules/quality/security.md#acceptance-dynamic-target-authorization) |
| RF-1、2-3 | 已知且型別符合的目標仍須通過授權，拒絕時沒有不應發生的副作用。 | [主要驗收](../rules/quality/security.md#acceptance-dynamic-target-authorization) |
| RF-3、4-1 | 以合法及不相容目標驗證註冊、啟動或執行前檢查； | [主要驗收](../rules/coding/type-safety.md#acceptance-dynamic-contract) |
| RF-3、4-2 | 確認能力、版本、參數與結果型別符合所需契約。 | [主要驗收](../rules/coding/type-safety.md#acceptance-dynamic-contract) |
| RF-3、4-3 | 核對特殊存取的核准範圍，以及建立與還原不會繞過必要驗證或產出無效物件。 | [主要驗收](../rules/stacks/java/common/reflection-and-suppression.md#acceptance-java-reflective-access) |
| RF-5-1 | 分別觸發適用的解析、存取、契約及目標執行故障，確認原因與分類保留，未將已執行的故障誤當未找到目標，且未進行無安全依據的替換或重跑。 | [主要驗收](../rules/coding/error-handling.md#acceptance-dynamic-failure) |
| RF-6-1 | 核對抑制規則、最小範圍、判定依據及適用核准。 | [主要驗收](../rules/workflow/rule-governance.md#acceptance-suppression-scope) |
| RF-6-2 | 以代表性檢查案例確認範圍外仍受檢查，沒有因抑制一項問題而關閉整個類別、模組或專案的必要檢查。 | [主要驗收](../rules/workflow/rule-governance.md#acceptance-suppression-scope) |
| RF-7-1 | 依實際來源與設定重新產生，確認產出及例外範圍可重現，手寫銜接仍符合型別契約。 | [主要驗收](../rules/workflow/rule-governance.md#acceptance-generated-code) |
| RF-7-2 | 工具或產生器更新時，重新確認例外依據，未沿用已失效的抑制。 | [主要驗收](../rules/workflow/rule-governance.md#acceptance-generated-code) |
| RF-8-1 | 確認驗收包含成功與拒絕、故障及限制生效的證據，不以警告消失或合法目標成功作為全部符合的依據。 | [主要驗收](../rules/quality/rule-verification.md#acceptance-dynamic-controls) |

## 狀態說明

本表保留的是歷史驗收文字，供差異審查；不是第二份有效驗收規範。執行時只依上述連結的現行主要來源。Java 文件中的共同驗收清單只負責引用，不複製共同案例。

## 驗證結果

- 本批三份 Java 文件與共通驗收的逐字重複：0 列。
- 20 列原驗收拆為 44 個可追溯片段，逐列重新串接與基準原文完全一致；每片段只有一個主要驗收目的地。
- Java 規則正文及共通既有規則正文未修改；其餘十二份 Java 文件未修改。本批未提升可見性、結果接收或跨型別相等的新跨語言義務。
- 人工核對：共同案例透過連結引用；Java 剩餘案例對應原有建構／覆寫、equals／hashCode／集合、反射邊界及特殊存取要求。未因去重而略過原檢查。
- 全站仍有 35 列共通驗收與其他 Java 驗收逐字重複（基準為 49 列）；本批不宣稱全站去重完成。
- 本地連結與錨點檢查、`git diff --check` 通過。

重現機械檢查：在儲存庫根目錄執行 `ruby scripts/verify-acceptance.rb --batch 1 --baseline 6f7ae5d --target e8d32e7`。腳本對照上述固定基準，核對本批範圍、逐字重複、原文片段覆蓋、正文未變及本地連結；語意與範圍是否合理仍須人工審查。後續正文重整會有意改變本批「正文未變」條件，屆時應另建批次基準與檢查，不能把這份歷史批次檢查當作永久全站門檻。

常駐檢查：`ruby scripts/verify-acceptance.rb`。批次差異以 `--target` 指定歷史受驗提交；省略時檢查工作區。歷史批次的範圍限制不套用到後續提交。

## 獨立審閱後的重現方式

上文保留當批執行紀錄；舊提交沒有逐句差異與已改寫清單，不能用修正後檢查器回報通過。現行追溯檢查：`ruby scripts/verify-acceptance.rb --batch 1`；基準自本文讀取。常駐檢查預設同時執行五批追溯與全檔保護；`--target` 的全部讀取及統計皆來自指定提交，不混入工作區。精確差異與改寫理由見 [檢查差異清單](acceptance-check-policy.json)、[已改寫片段清單](acceptance-rewritten-fragments.json)及[審閱修正紀錄](review-remediation.md)。

RF-1、2-1 與 RF-3、4-3 第二輪修正：兩個原文片段均已逐字還原於原追溯目的列，動態能力包含反射與動態呼叫；私有欄位寫入及存取放寬僅作例子。表中的歷史原文與唯一目的地不變，兩筆已不需登錄為改寫。
