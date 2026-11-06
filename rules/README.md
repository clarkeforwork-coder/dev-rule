# 開發共通規範

本規範作為跨專案、跨語言的開發基準，適用於工程師與 AI 撰寫的程式碼。已制定的主題與各自的維護位置列於文件索引。

## 規範效力

- 「必須」「須」「禁止」「不得」表示強制要求。「預設」表示一般情況應遵循，偏離時須有明確決策。
- 通用規範定義共同底線，語言規範負責語法與型別使用，Framework 規範負責框架機制的落實方式。各專案自行管理實際架構、技術組合、配置與核准例外。各層可以具體化或加嚴要求，不得自行降低標準。
- 規範衝突必須釐清並修正，或依[例外核准流程](workflow/rule-governance.md)處理，不以較具體的文件自動覆蓋共同底線。
- 本規範不強制採用特定架構。三層式、整潔架構或其他架構的實際分層、依賴方向與邊界，由專案架構決策定義；各層不必與通用範例一對一對應。
- 共通原則按實際設計適用，例如物件導向、非同步及 HTTP／JSON 規則不強制所有專案採用該設計。語言專屬文件放於 `stacks/<語言>/`，共同要求與版本差異分開維護。Java 已制定的主題見語言索引。尚未制定的主題仍須遵守既有共通要求，具體語言能力限制須個別決策。

## 文件索引

| 文件 | 內容 |
| --- | --- |
| [架構分層與依賴方向](architecture/layering.md) | 架構決策、跨層呼叫、技術責任與循環限制 |
| [模組責任與公開入口](architecture/module-boundaries.md) | 業務歸屬、團隊入口慣例與跨模組流程 |
| [框架與依賴組裝](architecture/dependency-composition.md) | 框架優先、介面選擇、DI 與物件建立 |
| [共通機制與程式碼共用](architecture/shared-capabilities.md) | 技術與業務分工、共用元件的抽取條件 |
| [邊界物件](architecture/boundary-objects.md) | 邊界範圍、拆分、隔離、不可變性與最小欄位 |
| [資料映射](architecture/data-mapping.md) | 轉換責任、依賴方向與欄位控制 |
| [共用型別管理](architecture/shared-types.md) | 契約所有權、共用條件與循環依賴 |
| [命名與可讀性](coding/naming.md) | 領域詞彙、操作與判斷名稱、單位及字面值 |
| [程式碼設計與公開介面](coding/code-design.md) | 函式責任、參數、可見性、狀態所有權、註解與文件 |
| [型別安全](coding/type-safety.md) | 明確型別、禁止逃逸、容器、泛型與轉型 |
| [領域建模](coding/domain-modeling.md) | 專屬型別、有效性與狀態模型 |
| [資料驗證](coding/validation.md) | 結構驗證、業務驗證與未知欄位 |
| [空值語意](coding/nullability.md) | 未提供、清空、有值與預設值 |
| [錯誤處理](coding/error-handling.md) | 失敗分類、例外、降級、結果未知、取消與補償失敗 |
| [集合與資料所有權](coding/collections-and-ownership.md) | 修改權、參考、快照與檢視、順序及重複資料 |
| [資源與元件生命週期](coding/resource-lifecycle.md) | 有效期、建立與就緒、所有權移交、釋放及關閉 |
| [併發與非同步處理](coding/concurrency-and-async.md) | 工作擁有者、同步、期限、取消、結果組合與脈絡 |
| [數值、日期時間與文字處理](coding/numbers-dates-text.md) | 精度、捨入、時間基準、時區、編碼與文字語意 |
| [資料契約](interfaces/data-contracts.md) | 定義來源、相容性與對外錯誤契約 |
| [API 操作語意與介面設計](interfaces/api-contracts.md) | 業務操作、更新與刪除、可信欄位、傳輸語意及多入口一致性 |
| [API 版本管理、淘汰與使用端遷移](interfaces/api-versioning.md) | 版本選擇與並存維護、公告通知、遷移驗收及停用決策 |
| [列表 API 的分頁、篩選與排序](interfaces/list-queries.md) | 筆數與一致性、游標、查詢條件、續查與總數 |
| [外部整合可靠性](interfaces/external-services.md) | 逾時、重試、冪等、隔離、來源驗證與結果核對 |
| [事件可靠性](interfaces/events.md) | 可恢復發布、消費確認、順序、失敗隔離、重播與背壓 |
| [事件命名與內容設計](interfaces/event-contracts.md) | 業務事實、發布條件、公開範圍、中繼資料、歷史解讀與更正 |
| [資料存取與完整性](data/persistence.md) | 模組邊界、資料約束、查詢資源與讀取一致性 |
| [交易邊界與併發控制](data/transactions.md) | 交易歸屬、併發修改、隔離、鎖定與安全重試 |
| [資料遷移與大量操作](data/migrations.md) | 版本化遷移、新舊版本相容、分批續跑與結果核對 |
| [規範驗證](quality/rule-verification.md) | 自動檢查、行為與失敗路徑測試、人工審查及架構可測試性 |
| [共通測試策略](quality/testing.md) | 測試層級與斷言、資料與環境隔離、穩定性、驗收門檻與案例維護 |
| [安全共通規範](quality/security.md) | 授權、身分與憑據、敏感資料、輸入輸出、檔案及網路邊界 |
| [日誌、稽核與可觀測性](quality/observability.md) | 診斷追蹤、可靠稽核、指標與資料新鮮度、告警接手及恢復驗收 |
| [效能與資源使用](quality/performance.md) | 效能承諾與基準、資源上限、滿載處置、容量重估及變更驗收 |
| [跨步驟失敗與業務補償](workflow/compensation.md) | 補償責任、動作識別與順序、中斷恢復、接手及結案 |
| [設定管理與環境差異](workflow/configuration.md) | 設定契約、來源與覆寫、生效與失聯、部署驗證、版本遷移與開關清理 |
| [第三方套件與依賴管理](workflow/dependencies.md) | 採用評估、版本與來源、建置權限、漏洞處置及發布追溯 |
| [Git、PR 與程式碼審查](workflow/git-pr-review.md) | PR 範圍、審查與合併條件、分支保護、提交追溯及緊急補驗 |
| [規範治理](workflow/rule-governance.md) | 漸進導入、架構變更、產生碼與例外核准 |

## 語言規範索引

| 語言 | 已制定內容 |
| --- | --- |
| [Java](stacks/java/README.md) | 15 份語言主題及其驗收；共同原則由上述共通文件維護，Java 保留語法、標準 API 與執行模型要求 |

各主題文件是對應要求的主要維護位置，其他文件透過連結引用，避免重複定義。架構決策理由可記錄於 `docs/decisions/`，實際專案的決策則由該專案管理。

數值門檻、訊息系統、資料庫、隔離等級、遷移工具及部署流程由專案決定。其餘語言主題、Java 版本差異、Framework 規範及實際 CI 工具設定仍待制定。
