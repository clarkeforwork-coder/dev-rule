# 規範驗證

各主題的必測情境由對應規範維護，入口見[驗收入口](#acceptance-index)；本文件維護跨主題驗收。選擇測試層級、安排執行門檻及維護案例時，依[共通測試策略](testing.md)辦理。

<a id="verification-coverage"></a>
<a id="au-01"></a>
## 共同把關

- 可由工具判斷的要求，必須使用適用的編譯器、靜態分析、Lint 或架構檢查執行，例如明確型別宣告、不安全轉型與依賴限制。
- 型別與其他已配置的強制檢查納入 CI，違規時阻擋合併；核准例外與既有違規依[規範治理](../workflow/rule-governance.md#exception-approval)精確管理。
- 行為測試驗證錯誤輸入拒絕、資料轉換、空值語意、業務條件，以及 Response 不含敏感欄位等實際行為。
- 需要理解業務語意的要求，必須人工審查，例如物件拆分是否合理、專屬型別是否表達正確概念。
- 工具尚未涵蓋的要求必須列入審查清單，不能因 CI 通過就視為全部符合。

<a id="review-checklist"></a>
## 審查清單

依[命名與可讀性](../coding/naming.md#domain-vocabulary-and-context)及[程式碼設計與公開介面](../coding/code-design.md#function-responsibilities)，在實際呼叫處檢查：

- 名稱與參數能否表達領域語意、操作效果與單位？布林名稱是否準確說明成立條件，字面值是否由對應規則管理？
- 函式是否保留清楚的流程入口，並將各自變動的規則交給所屬元件？參數型別是否排除無效組合？
- 可見性與修改權是否限於必要範圍？呼叫端能否經由唯讀介面取得可修改的內部資料？
- 註解的理由與依據是否仍有效？呼叫者能否從公開契約得知適用的前置條件、完成效果、失敗與重試保證？

其他共通要求：

- 邊界、物件拆分與轉換責任是否符合專案架構？
- 是否只傳遞必要欄位，且未暴露內部模型或第三方契約型別？
- 型別是否明確，專屬型別與泛型是否有實際保障？
- 未知輸入、缺值、清空與狀態是否得到正確驗證與表達？
- 契約變更是否評估所有使用端，並安排必要的相容措施？
- API 是否表達明確業務意圖與成功保證，更新、刪除及不存在語意是否清楚？
- API 命名、可信欄位、傳輸格式與多入口行為是否一致，是否有可驗證且同步維護的範例？
- 共用型別是否有管理責任，依賴方向是否正確？
- 模組公開入口是否符合團隊慣例，業務規則與資料是否有明確歸屬？
- 跨模組流程、查詢與交易是否遵守責任邊界，各入口是否均執行必要業務檢查？
- 依賴是否明確組裝，核心規則是否能獨立驗證？
- 架構約束變更是否經確認，並同步更新文件與檢查？
- 錯誤分類、捕捉與記錄責任是否明確，降級、未知結果、取消與部分成功是否依契約處理？
- 清理或補償失敗是否保留原始原因與後續責任，適用失敗路徑是否完成驗證？
- 重試是否有單一管理位置、安全依據與整體期限，冪等是否涵蓋併發及保留期限？
- 事件發布、消費確認、隔離與重播是否可恢復，並維持順序與副作用安全？
- 非同步完成依據、逾期核對、來源驗證與積壓處理是否有明確機制及責任？
- 新增與修改部分是否符合規範，偏離是否已有有效核准？
- 併發更新、隔離、鎖定與資料庫約束是否能保障業務條件，衝突及重試是否安全？
- 查詢是否有界，副本與快取是否符合讀取一致性需求，效能改善是否保留授權與隔離？
- 遷移是否版本化且維持所需相容性，大量操作是否可恢復並核對結果？

<a id="dynamic-controls-and-documents"></a>
<a id="動態限制與文件驗證"></a>
## 動態限制驗證

<a id="dynamic-control-verification"></a>
<a id="rf-08"></a>
### 驗證限制實際有效

動態能力、特殊存取或檢查抑制新增及變更時，須驗證允許與拒絕路徑、故障分類、必要不變條件及檢查範圍。涉及工具產出時，須驗證實際重新產生的結果，不僅測試成功案例或確認警告消失。

<a id="reproducible-check-configuration"></a>
<a id="au-02"></a>
## 檢查配置可重現

必要檢查的工具版本、規則及設定須受版本控制。本機與 CI 使用一致規則，提供可重現的執行方式，不只依賴 IDE 個人設定。具體工具由專案選擇；語言規範補充必要能力。

<a id="actual-check-scope"></a>
<a id="au-03"></a>
## 實際執行範圍

必要檢查須核對實際執行範圍與結果，包含適用的模組、程式碼及測試範圍。未執行、被略過或未涵蓋必要內容不得視為通過；無適用內容須有明確依據，不能僅以零問題或成功退出判定有效。

<a id="check-configuration-validation"></a>
<a id="au-04"></a>
## 檢查設定本身的有效性

新增或變更檢查規則、範圍及配置時，須以代表性的符合與違反案例確認可以正確放行及拒絕。不能只確認工具啟動、報告產生或警告消失，也不要求每個 PR 重測全部檢查工具。

<a id="evidence-version-validity"></a>
<a id="au-06"></a>
## 證據版本與快取有效性

檢查與測試證據須對應實際受驗版本、環境及規則設定。使用快取或增量結果時，須確認相關輸入、依賴及必要涵蓋範圍仍有效；無法確認時重新執行受影響檢查，不把舊結果直接套用到新內容。合併前另核對與目標分支整合後的適用性。

<a id="diagnostic-classification"></a>
<a id="au-08"></a>
## 結果分類與安全診斷

檢查及測試結果須可定位、可重現並追溯受驗版本，區分程式違規、行為失敗與工具故障。工具無法執行或解析不代表程式通過；診斷資訊遵守安全及日誌規範，不輸出秘密或不必要的敏感資料。

<a id="effective-merge-gates"></a>
<a id="au-09"></a>
## 合併門檻實際有效

必要檢查的合併阻擋須實際生效。檢查配置或合併保護新增及變更時，確認失敗、未完成或應執行卻被略過的變更無法直接合併，不能以只產生報告取代門檻。可使用測試分支、測試儲存庫或平台檢查能力，不要求每個 PR 故意製造失敗。核准例外依既有流程追溯。

違規基準依[精確違規基準](../workflow/rule-governance.md#precise-violation-baseline)，自動修正依[自動修正的審查](../workflow/git-pr-review.md#automated-fix-review)。檢查抑制與產生碼依[規範治理](../workflow/rule-governance.md#檢查抑制與產生碼治理)，診斷遵守[安全](security.md#secrets-and-credentials)及[可觀測性](observability.md#diagnostic-logging-and-tracing)。

<a id="acceptance"></a>
## 驗收

驗收案例的選擇與維護依[驗收共同原則](testing.md#acceptance-principles)。

<a id="acceptance-index"></a>
<a id="語言與新增共通主題驗收入口"></a>
<a id="驗收入口"></a>
### 驗收入口

| 主題 | 驗收位置 |
| --- | --- |
| <a id="架構檢查與可測試性"></a>架構檢查與可測試性 | [架構分層與依賴方向](../architecture/layering.md#acceptance)、[框架與依賴組裝](../architecture/dependency-composition.md#acceptance) |
| <a id="錯誤處理驗證與驗收"></a>錯誤處理驗證與驗收 | [錯誤處理](../coding/error-handling.md#acceptance) |
| <a id="補償流程驗收"></a>補償流程驗收 | [跨步驟失敗與業務補償](../workflow/compensation.md#acceptance) |
| <a id="外部整合與事件故障恢復驗證"></a>外部整合與事件故障恢復驗證 | [外部整合可靠性](../interfaces/external-services.md#acceptance)、[事件可靠性](../interfaces/events.md#acceptance) |
| <a id="資料庫行為與遷移驗證"></a>資料庫行為與遷移驗證 | [資料存取與完整性](../data/persistence.md#acceptance)、[交易邊界與併發控制](../data/transactions.md#acceptance)、[資料遷移與大量操作](../data/migrations.md#acceptance) |
| <a id="api-契約與操作驗證"></a>API 契約與操作驗證 | [API 操作語意與介面設計](../interfaces/api-contracts.md#acceptance) |
| <a id="api-版本相容性與遷移驗收"></a>API 版本相容性與遷移驗收 | [API 版本管理、淘汰與使用端遷移](../interfaces/api-versioning.md#acceptance) |
| <a id="列表查詢組合驗證"></a>列表查詢組合驗證 | [列表 API 的分頁、篩選與排序](../interfaces/list-queries.md#acceptance) |
| <a id="公開事件的契約驗證"></a>公開事件的契約驗證 | [事件命名與內容設計](../interfaces/event-contracts.md#acceptance) |
| <a id="安全驗收"></a>安全驗收 | [安全共通規範](../quality/security.md#acceptance) |
| <a id="可觀測性驗收"></a>可觀測性驗收 | [日誌、稽核與可觀測性](../quality/observability.md#acceptance) |
| <a id="效能與資源驗收"></a>效能與資源驗收 | [效能與資源使用](../quality/performance.md#acceptance) |
| <a id="設定管理驗收"></a>設定管理驗收 | [設定管理與環境差異](../workflow/configuration.md#acceptance) |
| <a id="依賴管理驗收"></a>依賴管理驗收 | [第三方套件與依賴管理](../workflow/dependencies.md#acceptance) |
| <a id="git-與-pr-驗收"></a>Git 與 PR 驗收 | [Git、PR 與程式碼審查](../workflow/git-pr-review.md#acceptance) |
| <a id="測試程式碼"></a>測試程式碼 | [型別安全](../coding/type-safety.md#acceptance) |
| Java 語言 | [Java 語言](../stacks/java/README.md#驗收入口) |
| 集合與資料所有權 | [集合與資料所有權](../coding/collections-and-ownership.md#驗收要求) |
| 資源生命週期 | [資源生命週期](../coding/resource-lifecycle.md#驗收要求) |
| 併發與非同步 | [併發與非同步](../coding/concurrency-and-async.md#驗收要求) |
| 數值、日期時間與文字 | [數值、日期時間與文字](../coding/numbers-dates-text.md#驗收要求) |
| 領域建模補充契約 | [領域建模補充契約](../coding/domain-modeling.md#supplementary-contract-acceptance) |
| 資料映射補充契約 | [資料映射補充契約](../architecture/data-mapping.md#supplementary-acceptance) |
| 空值語意補充契約 | [空值語意補充契約](../coding/nullability.md#supplementary-contract-acceptance) |
| 介面用途 | [介面用途](../architecture/dependency-composition.md#acceptance-interface-purpose) |
| 多步驟與部分成功 | [多步驟與部分成功](../coding/error-handling.md#acceptance-partial-operation) |
| 程式碼設計補充契約 | [程式碼設計補充契約](../coding/code-design.md#supplementary-contract-acceptance) |
| 共通測試策略補充契約 | [共通測試策略補充契約](../quality/testing.md#acceptance) |
| 規範治理補充契約 | [規範治理補充契約](../workflow/rule-governance.md#supplementary-contract-acceptance) |

其他語言依其適用規範補足；共同要求的效力依[規範索引](../README.md#規範效力)。跨主題驗收（共同把關、審查清單、動態限制與文件驗證、檢查配置與門檻）仍由本文件維護，不在本文件重複維護各主題摘要。

<a id="document-verification"></a>
<a id="nd-07"></a>
### 形式與語意分別驗收

命名與文件變更須以自動檢查維持可判定的形式要求，並由人工審查語意、責任及契約一致性。相關連結、參照與範例須依影響驗證；具有可執行意義的範例須確認能在適用環境下使用。不以格式通過或文件成功產生代替內容正確性，也不強制所有方法填寫相同文件內容。

<a id="cross-topic-acceptance"></a>
### 跨主題檢查驗收

驗收時須逐項核對必要規範與自動檢查、行為測試或人工審查的對應；工具未覆蓋的必要內容有明確清單及處置，不以 CI 成功代替完整性確認。

<a id="acceptance-check-configuration"></a>
### 檢查配置重現驗收

驗收：在依專案文件建立的環境執行同一入口，核對版本、規則及設定一致；確認不是只有 IDE 能執行。

<a id="acceptance-check-execution"></a>
### 檢查執行範圍驗收

驗收：以實際執行紀錄核對必要範圍，辨識略過、未收集測試及排除內容；無適用內容的判斷可追查。

<a id="acceptance-check-validation"></a>
### 檢查設定有效性驗收

驗收：代表性正例通過、反例被適用規則拒絕，並確認排除或抑制沒有擴大到其他必要範圍。

<a id="acceptance-evidence-validity"></a>
### 證據版本與快取驗收

驗收：從結果追溯程式版本、工具／規則設定及環境；改變受影響輸入或依賴時，確認快取失效或有可核對的有效性依據。

<a id="acceptance-diagnostics"></a>
### 結果分類與診斷驗收

驗收：分別核對違規、測試失敗與工具故障的結果及處置；確認定位與重現資料足夠且經安全檢查。

<a id="acceptance-merge-gates"></a>
### 合併門檻驗收

驗收：以受控方式確認不符合條件會阻擋，符合條件可依程序合併，涵蓋人工與自動化操作；例外具核准及紀錄。

<a id="supplemental-contract-acceptance"></a>
### 補充契約驗收

| 契約 | 驗收內容 |
| --- | --- |
| <a id="acceptance-dynamic-controls"></a>[驗證限制實際有效](#dynamic-control-verification) | 確認驗收包含成功與拒絕、故障及限制生效的證據，不以警告消失或合法目標成功作為全部符合的依據。 |
| <a id="acceptance-document-verification"></a>[形式與語意分別驗收](#document-verification) | 驗證受影響的連結、文件參照與適用範例，確認在適用環境下可用。保留語意與契約審查，不把格式或文件產生成功當成全部符合。 |
