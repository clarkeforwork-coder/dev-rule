# Java 規範逐條歸屬清單（整理前快照）

> 後續狀態：使用者已確認適用範圍與寫入，本清單已於 2026-11-06 落實。下文保留當時的分類建議、原行號及雜湊；其中「待確認／未修改」描述的是整理前狀態。現行去向與驗收核對見[調整紀錄](java-rule-migration.md)。

建立日期：2026-11-06。範圍：15 份已寫入 Java 規範的 153 條編號決策，以及本輪自動檢查的 8 條已確認未寫入決策；另列 1 條未確認提案。

**本文件是儲存庫整理計畫，不是 Rule，不變更現行規範效力。所有分類都是建議；「提升共通」不代表已獲准擴大適用範圍。** 本次不修改 `rules/`、索引或驗收。

來源為本機工作區，而非只看已提交版本；目前基底提交為 `718be9263d5a03d4745f9ea2d647d395e3a78f1c`。文末記錄各來源 SHA-256，包含尚未提交的 Java 文件。每列保留原條號與原行號，後續修改前須重新核對來源。

## 處置定義與閱讀方式

| 標記 | 建議處理 |
| --- | --- |
| 保留 | Java 確有語法、型別、標準 API 或執行模型的增量要求。共通背景可縮成引用；不代表整條文字原封不動。 |
| 改引用 | 既有共通要求已能承接主要義務。Java 可留例子、注意事項及具體驗收，不另立同義規則；引用指向主要來源。 |
| 提升共通 | 共同義務目前缺漏、較概括或只在特定場景出現，建議補入或明訂適用條件。既有部分只引用，不重複抄入；同條 Java 細節仍保留。 |

- 每條只有一個主要處置；混合內容在「Java 後續保留／處置」欄拆明，不用整條搬移。
- 共通對應的第一個代碼是建議主要維護位置，其餘是輔助引用。保留項的主要規則仍在原 Java 文件。
- 「提升共通」列所述缺口是相對目前共通文件的審查判斷，不宣稱原條款完全沒有任何共通依據。
- 不因概念也存在於其他語言，就刪除必要的 Java API 契約。例如 equals/hashCode、Comparable 及 Stream 消費語意仍保留。
- 候選共通新主題不等於核准新增檔案；可在確認後改用既有文件章節。此次未建立任何候選 Rule。
- 各檔驗收表依原條號追蹤；「驗收行」是同一來源檔內對應列。原則提升時，共通案例隨主要來源維護，Java 具體案例留在語言層，不能一起刪掉。

## 共通對應位置

<a id="target-type"></a>

- **TYPE：[型別安全](../rules/coding/type-safety.md)**。既有：嚴格宣告、禁止繞過檢查、容器與泛型、型別轉換。

<a id="target-null"></a>

- **NULL：[空值語意](../rules/coding/nullability.md)**。既有；候選補充：空值契約的變更與第三方語意。

<a id="target-domain"></a>

- **DOMAIN：[領域建模](../rules/coding/domain-modeling.md)**。既有；候選補充：值相等、正規化、操作結果與模型擴充。

<a id="target-design"></a>

- **DESIGN：[程式碼設計與公開介面](../rules/coding/code-design.md)**。既有；候選補充：適用物件導向的替代契約、建立與擴充要求。

<a id="target-error"></a>

- **ERROR：[錯誤處理](../rules/coding/error-handling.md)**。既有：分類、原因、缺陷、取消、部分成功與清理失敗。

<a id="target-valid"></a>

- **VALID：[資料驗證](../rules/coding/validation.md)**。既有：邊界驗證與內部保證。

<a id="target-name"></a>

- **NAME：[命名與可讀性](../rules/coding/naming.md)**。既有：領域詞彙、責任與上下文。

<a id="target-bound"></a>

- **BOUND：[邊界物件](../rules/architecture/boundary-objects.md)**。既有：隔離、拆分、不可變性與最小資料。

<a id="target-map"></a>

- **MAP：[資料映射](../rules/architecture/data-mapping.md)**。既有；候選補充：無隱藏副作用、雙向契約與實際路徑驗收。

<a id="target-di"></a>

- **DI：[框架與依賴組裝](../rules/architecture/dependency-composition.md)**。既有；候選補充：生命週期相容與工廠／提供者的取得責任。

<a id="target-module"></a>

- **MODULE：[模組責任與公開入口](../rules/architecture/module-boundaries.md)**。既有：公開入口與責任邊界。

<a id="target-shared"></a>

- **SHARED：[共用能力](../rules/architecture/shared-capabilities.md)**。既有：共用依責任及變更原因。

<a id="target-api"></a>

- **API：[API 操作語意與介面設計](../rules/interfaces/api-contracts.md)**。既有；候選補充：HTTP／JSON 缺值的條件式說明。

<a id="target-contract"></a>

- **CONTRACT：[資料契約](../rules/interfaces/data-contracts.md)**。既有：唯一主要來源、相容性與對外錯誤。

<a id="target-external"></a>

- **EXTERNAL：[外部整合可靠性](../rules/interfaces/external-services.md)**。既有：期限、結果未知及完成程度；不把適用範圍自動擴成所有本機工作。

<a id="target-migrate"></a>

- **MIGRATE：[資料遷移](../rules/data/migrations.md)**。既有：歷史資料與相容遷移。

<a id="target-verify"></a>

- **VERIFY：[規範驗證](../rules/quality/rule-verification.md)**。既有；候選補充：檢查本身的可重現性、覆蓋與證據有效性。

<a id="target-test"></a>

- **TEST：[共通測試策略](../rules/quality/testing.md)**。既有；候選補充：受控併發交錯與文件範例驗證。

<a id="target-sec"></a>

- **SEC：[安全](../rules/quality/security.md)**。既有；候選補充：一般動態載入／呼叫目標的受控登錄。

<a id="target-obs"></a>

- **OBS：[日誌、稽核與可觀測性](../rules/quality/observability.md)**。既有：診斷、追蹤與敏感資料限制。

<a id="target-perf"></a>

- **PERF：[效能與資源使用](../rules/quality/performance.md)**。既有：容量、排隊、停止及資源回收；候選補充：延遲操作實際累積成本。

<a id="target-gov"></a>

- **GOV：[規範治理](../rules/workflow/rule-governance.md)**。既有；候選補充：最小抑制、誤報重審與精確違規基準。

<a id="target-pr"></a>

- **PR：[Git、PR 與程式碼審查](../rules/workflow/git-pr-review.md)**。既有：審查、工具產出責任與合併門檻。

<a id="target-dep"></a>

- **DEP：[第三方套件與依賴管理](../rules/workflow/dependencies.md)**。既有：版本、升級及發布產物追溯。

<a id="target-coll"></a>

- **COLL：集合與資料所有權（候選共通主題）**。尚無專責文件；候選 coding/collections-and-ownership.md。先確認主題及範圍，不建立檔案。

<a id="target-life"></a>

- **LIFE：資源與元件生命週期（候選共通主題）**。尚無專責文件；候選 coding/resource-lifecycle.md。錯誤分類仍引用 ERROR。

<a id="target-async"></a>

- **ASYNC：併發與非同步（候選共通主題）**。尚無專責文件；候選 coding/concurrency-and-async.md。只適用實際採用併發／非同步的流程。

<a id="target-data"></a>

- **DATA：數值、日期時間與文字（候選共通主題）**。尚無完整內部處理文件；候選 coding/numbers-dates-text.md。對外格式仍引用 API。

## 1. Java 適用範圍與版本判定（JV，12 條）

原文件：[version-policy.md](../rules/stacks/java/common/version-policy.md)。以下行號均指此檔。

| 追蹤 ID／原條目 | 原行／驗收行 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| JV-01：分別記錄版本資訊 | 7／36 | **保留** | [TYPE](#target-type)、[DEP](#target-dep) | JDK、語言功能、標準 API、位元碼與執行版本是 Java 的不同相容維度。 | 保留完整版本宣告要求；不指定各專案必須採用的版本。 |
| JV-02：建置設定落實限制 | 8／36 | **保留** | [VERIFY](#target-verify) | 共通層管設定可重現；限制 Java 語法、API 與位元碼是語言落實。 | 保留編譯限制，受控設定與本機／CI 一致改引用共通要求。 |
| JV-03：執行版本驗證 | 9／37 | **保留** | [TEST](#target-test) | 承諾的 Java runtime 需實際載入與執行驗證，僅編譯不足。 | 保留 Java 執行版本矩陣與函式庫使用端驗證。 |
| JV-04：多模組版本要求 | 10／37 | **保留** | [CONTRACT](#target-contract) | 多模組編譯目標與 Java runtime 相容關係具有語言特性。 | 保留逐模組版本及依賴相容範圍。 |
| JV-05：依賴版本要求 | 16／38 | **保留** | [DEP](#target-dep) | 一般依賴治理已存在，需補上 Java 最低執行版本核對。 | 保留直接及間接依賴的 Java 相容要求；升級治理引用 DEP。 |
| JV-06：建置升級與支援範圍變更 | 17／38 | **保留** | [CONTRACT](#target-contract) | 建置 JDK 升級與提高最低 Java 執行版本是不同變更。 | 保留兩者的區別與使用端驗證；遷移治理引用 CONTRACT。 |
| JV-07：Preview 功能 | 18／39 | **保留** | [GOV](#target-gov) | Preview 的建置、執行與後續升級配套屬 Java。 | 保留正式功能預設及 Preview 適用條件；核准紀錄引用 GOV。 |
| JV-08：JDK 內部實作與存取限制 | 19／39 | **保留** | [GOV](#target-gov) | JDK 內部 API 及存取放寬屬 Java 平台限制。 | 保留受支援 API 與升級重驗；例外程序不重寫。 |
| JV-09：棄用 API | 20／39 | **保留** | [DEP](#target-dep)、[GOV](#target-gov) | 本條處理 Java API 棄用及預定移除，不需另建立一份通用升級制度。 | 保留符合版本範圍的替代 API 選擇與移除風險；共通治理改引用。 |
| JV-10：建置與驗證工具相容性 | 26／40 | **保留** | [VERIFY](#target-verify)、[DEP](#target-dep) | 註解處理器、編譯外掛與位元碼工具有 Java 版本相容需求。 | 保留工具類型與產物相容驗證；未執行不得算通過引用 VERIFY。 |
| JV-11：JDK 發行商與完整版本 | 27／40 | **保留** | [DEP](#target-dep) | JDK 發行商與完整修補版本是 Java 環境識別。 | 保留發行商、完整版本及變更相容性驗證。 |
| JV-12：產物與執行環境追溯 | 28／41 | **保留** | [DEP](#target-dep)、[VERIFY](#target-verify) | 追溯原則共通，這裡指定 Java 發布證據的必要內容。 | 保留建置 JDK、編譯目標、部署 runtime 與啟動設定；引用共同證據制度。 |

## 2. Java 型別宣告與泛型（JT，11 條）

原文件：[types-and-generics.md](../rules/stacks/java/common/types-and-generics.md)。以下行號均指此檔。

| 追蹤 ID／原條目 | 原行／驗收行 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| JT-01：明確宣告型別 | 7／39 | **保留** | [TYPE](#target-type) | 共通已要求明確宣告，本條將要求落實為 Java 禁用 var 及保留泛型。 | 保留各宣告位置與 var 限制，不將 Java 語法規則提升至其他語言。 |
| JT-02：禁止 raw type 與不必要的型別抽象 | 8／40 | **保留** | [TYPE](#target-type) | raw type、Object 與萬用字元具有不同的 Java 型別效果。 | 保留 raw type 禁令、已知業務型別與合理萬用字元界線。 |
| JT-03：輸入與輸出的型別關聯 | 9／40 | **改引用** | [TYPE](#target-type) | 既有「容器與泛型」已要求真實輸入輸出關聯及禁止無保證的泛型結果。 | 保留 Java 泛型簽章範例，不重訂相同原則。 |
| JT-04：不得以向下轉型補回業務型別 | 10／41 | **保留** | [TYPE](#target-type)、[GOV](#target-gov) | 本條明確限制 Java 參考型別向下轉型，與數值轉換不同。 | 保留業務型別不得遺失後強轉補回；例外與未知資料治理引用共通。 |
| JT-05：型別安全警告 | 11／41 | **保留** | [TYPE](#target-type)、[GOV](#target-gov) | raw type／unchecked 診斷及 SuppressWarnings 是 Java 具體檢查。 | 保留必須消除的警告種類；抑制核准流程引用 GOV。 |
| JT-06：業務資料結構 | 17／42 | **改引用** | [TYPE](#target-type) | 固定結構物件與動態鍵值資料已有完整共通要求。 | 保留 Map<String, Object>、Object[] 的違規範例。 |
| JT-07：型別能力與約束 | 18／40 | **保留** | [TYPE](#target-type)、[DI](#target-di) | 型別能力原則共通，上界及型別參數是 Java 的實作限制。 | 保留上界、泛型關聯及不得猜測或轉型；不重複介面設計原則。 |
| JT-08：集合與映射的宣告型別 | 19／43 | **保留** | [TYPE](#target-type)、[DI](#target-di) | Java 集合介面與實作類別的宣告選擇，是具體型別契約落實。 | 保留宣告型別須完整表達操作；所有權另引用 COLL 的候選整理。 |
| JT-09：允許建構端使用菱形運算子 | 20／39 | **保留** | [TYPE](#target-type) | 菱形運算子是 Java 特定語法，且是已確認的省略範圍。 | 保留允許建構端 <>、宣告端仍明確的界線。 |
| JT-10：泛型回傳值 | 21／43 | **保留** | [TYPE](#target-type) | 萬用字元回傳與上下界會直接影響 Java 使用端能力。 | 保留採用條件及不得用萬用字元代替不可變性。 |
| JT-11：泛型參數命名 | 22／44 | **保留** | [NAME](#target-name) | T、K、V 與角色型別參數是 Java 泛型命名慣例的落實。 | 保留簡單與複雜情境的命名選擇；可讀性原則引用 NAME。 |

## 3. Java null 與 Optional（JN，12 條）

原文件：[null-and-optional.md](../rules/stacks/java/common/null-and-optional.md)。以下行號均指此檔。

| 追蹤 ID／原條目 | 原行／驗收行 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| JN-01：查詢的正常缺值 | 7／34 | **保留** | [NULL](#target-null)、[ERROR](#target-error)、[API](#target-api) | 正常缺值語意共通，但 Optional 與非 null 空集合是 Java 表示選擇。 | 保留單筆 Optional、多筆空集合；故障分類引用 ERROR。 |
| JN-02：Optional 本身非空 | 8／34 | **保留** | [NULL](#target-null)、[ERROR](#target-error) | Optional 物件本身仍可能為 null，需要 Java 的額外使用約束。 | 保留 Optional 非空與空 Optional 的正常缺值限制。 |
| JN-03：取值與缺值處置 | 9／34 | **保留** | [NULL](#target-null)、[ERROR](#target-error) | Optional 取值 API 的使用須遵守既有失敗語意。 | 保留取值前處置與不變條件已成立時的用法；不重寫失敗分類。 |
| JN-04：使用位置與狀態表達 | 10／35 | **保留** | [NULL](#target-null) | Optional 的回傳、參數及欄位使用位置屬 Java 型別設計。 | 保留不全面包裝或禁止的界線；三種更新意圖引用 NULL。 |
| JN-05：集合內容的空值 | 14／35 | **保留** | [NULL](#target-null)、[VALID](#target-valid) | Java 集合與陣列可容納 null；預設禁止是本語言已確認的額外限制。 | 保留元素、鍵和值的非空預設，不直接擴大成所有語言的容器政策。 |
| JN-06：非空驗證的位置 | 15／36 | **改引用** | [VALID](#target-valid)、[ERROR](#target-error)、[DOMAIN](#target-domain) | 邊界驗證、內部可靠保證免重複檢查與缺陷分類已由共通規範管理。 | 保留 Java 非空驗證位置範例，不新增相同政策副本。 |
| JN-07：工具可辨識的契約 | 16／36 | **保留** | [TYPE](#target-type)、[VERIFY](#target-verify) | Java 需要統一可由工具辨識的空值表示；具體標註與工具尚由專案選擇。 | 保留可空／非空標註範圍及實際行為一致；檢查治理引用 VERIFY。 |
| JN-08：第三方空值行為 | 17／37 | **提升共通** | [NULL](#target-null)、[VALID](#target-valid)、[MAP](#target-map) | 共通已有邊界驗證，但未完整說明第三方不明缺值不可推測成正常無資料。 | 保留 null 轉 Optional 的例子；提升僅限第三方缺值轉換契約。 |
| JN-09：空值契約變更 | 21／38 | **提升共通** | [NULL](#target-null)、[CONTRACT](#target-contract) | 公開契約相容性已存在；所有內部空值契約也不能只以簽章判定相容，需明訂範圍。 | 保留 Java 標註／簽章不變但行為改變的例子；內部適用範圍待確認。 |
| JN-10：空值情境驗收 | 22／39 | **改引用** | [VERIFY](#target-verify)、[TEST](#target-test)、[TYPE](#target-type) | 共通已有空值案例、錯誤分類及測試不得繞過型別的要求。 | 保留 Java Optional 實際路徑的驗收表，引用共通測試原則。 |
| JN-11：預設非空與明確語意 | 23／36 | **保留** | [NULL](#target-null)、[TYPE](#target-type) | Java 參考型別的預設非 null 是語言規範的具體選擇。 | 保留參數、回傳值與欄位預設，以及明確標示的例外位置。 |
| JN-12：API 邊界的缺值轉換 | 24／40 | **提升共通** | [API](#target-api)、[NULL](#target-null)、[CONTRACT](#target-contract) | 共通已定義無結果與更新意圖；HTTP／JSON 的省略、null 與內部表示分離需條件式補充。 | 保留 Optional 不直接作為外部契約的 Java 說明；不規定框架序列化設定。 |

## 4. Java 專屬值型別與領域值物件（VO，10 條）

原文件：[value-objects.md](../rules/stacks/java/common/value-objects.md)。以下行號均指此檔。

| 追蹤 ID／原條目 | 原行／驗收行 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| VO-01：建立專屬型別的條件 | 7／32 | **改引用** | [DOMAIN](#target-domain) | 專屬型別採用條件、概念隔離及不包裝所有原始值已由共通定義。 | 保留 OrderId／CustomerId 的 Java 範例。 |
| VO-02：建立時保護不變條件 | 8／32 | **改引用** | [DOMAIN](#target-domain)、[VALID](#target-valid) | 建立時有效與外部存在性、授權分離已有共通依據。 | 保留 Java 建構子／工廠驗證例子。 |
| VO-03：不可變性 | 9／33 | **提升共通** | [DOMAIN](#target-domain)、[DESIGN](#target-design) | 共通只要求維持有效性及預設不可變；值物件一律不可變、變更產生新值是更明確的義務。 | 保留 final 不保證深層不可變及防禦性複製做法；不擴及所有 Entity。 |
| VO-04：值相等的條件 | 13／34 | **保留** | [DOMAIN](#target-domain) | Java equals／hashCode 的實作須落實業務值相等；通用比較語意由 EQ-01 提升。 | 保留 Java 相等與雜湊落實，引用 EQ 主題；共通值相等不另建副本。 |
| VO-05：正規化規則 | 14／35 | **提升共通** | [DOMAIN](#target-domain) | 共通未完整明訂正規化、驗證及相等性之間的順序與關係。 | 保留 Java 建立入口例子；主要正規化政策移至 DOMAIN。 |
| VO-06：運算責任 | 15／36 | **提升共通** | [DOMAIN](#target-domain) | 既有專屬型別要求尚未完整限定運算責任與禁止拆值繞過。 | 保留 Java 專屬型別操作範例；邊界讀取底層值仍允許。 |
| VO-07：資料還原 | 19／37 | **提升共通** | [DOMAIN](#target-domain)、[MIGRATE](#target-migrate)、[MAP](#target-map) | 還原入口維持有效性與歷史規則相容是跨語言的模型責任。 | 保留建構及 record 還原的語言說明；特定 ORM／序列化配置留 Framework。 |
| VO-08：一般類別與 record | 20／38 | **保留** | [DOMAIN](#target-domain)、[SEC](#target-sec) | 一般類別與 record 的選擇、自動產生方法及可變成員問題屬 Java。 | 保留 record 版本條件、深層不可變與診斷洩漏檢查。 |
| VO-09：診斷字串與交換格式 | 21／38 | **保留** | [CONTRACT](#target-contract)、[OBS](#target-obs) | 不把診斷字串當交換格式是共同契約原則，本條具體限制 Java toString。 | 保留 toString 非穩定交換格式；對外格式與敏感資料引用共通。 |
| VO-10：業務保證的測試 | 22／39 | **改引用** | [DOMAIN](#target-domain)、[TEST](#target-test) | 共通已有型別誤用、建立驗證及依風險測試；新增模型保證隨 VO-03／05／06／07 的共通歸屬驗收。 | 保留 Java record、equals、還原等適用案例，不再重訂一般測試政策。 |

## 5. Java 狀態與結果建模（ST，10 條）

原文件：[states-and-results.md](../rules/stacks/java/common/states-and-results.md)。以下行號均指此檔。

| 追蹤 ID／原條目 | 原行／驗收行 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| ST-01：明確的狀態型別 | 7／32 | **保留** | [DOMAIN](#target-domain) | 互斥狀態已屬共通，enum 的採用是 Java 實作。 | 保留固定狀態名稱的 enum 選擇；不同業務面向的模型說明仍作共通原則例子。 |
| ST-02：各狀態的必要資料 | 8／32 | **改引用** | [DOMAIN](#target-domain) | 不同狀態須以型別表達必要資料，已由共通「狀態建模」定義。 | 保留 Java 狀態型別範例；不重寫另一份義務。 |
| ST-03：業務操作控制轉換 | 9／33 | **改引用** | [DOMAIN](#target-domain) | 明確業務轉換、必要檢查及不得任意改狀態已有共通依據。 | 保留 Java setter 違規例子與合法轉換驗收。 |
| ST-04：結果與目前狀態分開表達 | 13／34 | **提升共通** | [DOMAIN](#target-domain)、[ERROR](#target-error)、[API](#target-api) | 已受理與完成已有共通定義；「本次結果不同於目前狀態」需在內部模型層補明。 | 保留 Java 結果型別例子；不要要求每次操作產生複雜結果物件。 |
| ST-05：具型別的業務失敗 | 14／34 | **改引用** | [ERROR](#target-error) | 具型別業務失敗、保留原因、不依布林或文字判斷已有明確共通規定。 | 保留 Java 結果型別表示，技術故障不重訂分類。 |
| ST-06：處理完整性 | 15／35 | **提升共通** | [DOMAIN](#target-domain)、[ERROR](#target-error) | 未知狀態不得假成功及使用端處理完整性，應適用所有狀態／結果模型。 | 保留 Java 版本可用的編譯檢查；不假定所有版本都可窮盡檢查。 |
| ST-07：穩定的外部代碼 | 19／36 | **保留** | [API](#target-api)、[CONTRACT](#target-contract) | 穩定外部代碼已有共通依據，ordinal 與列舉名稱是 Java 的具體風險。 | 保留 ordinal 禁令與 enum 名稱相容性；跨語言穩定代碼改引用。 |
| ST-08：封閉或允許擴充 | 20／35 | **提升共通** | [DOMAIN](#target-domain) | 模型封閉或開放及未知實作處理是共同契約，現行共通尚未完整定義。 | 保留 sealed／可見性／建立入口的版本落實；不要求其他語言支援 sealed。 |
| ST-09：結果保留當時事實 | 21／37 | **提升共通** | [DOMAIN](#target-domain)、[DESIGN](#target-design) | 共通有資料隔離，但「結果保留當時事實、最新狀態另查」尚需明確定義。 | 保留 Java 可變參考隔離例子，不要求完整深複製。 |
| ST-10：模型驗收 | 22／38 | **提升共通** | [DOMAIN](#target-domain)、[TEST](#target-test) | 現有共通只簡述狀態轉換測試；拒絕、重複、分支與結果副作用一致的驗收需補齊。 | 保留 Java enum／sealed／代碼的實作案例；共通驗收承接 ST-04／06／08／09。 |

## 6. Java 邊界物件與資料映射（BM，9 條）

原文件：[boundary-mapping.md](../rules/stacks/java/common/boundary-mapping.md)。以下行號均指此檔。

| 追蹤 ID／原條目 | 原行／驗收行 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| BM-01：依隔離需求拆分 | 7／31 | **改引用** | [BOUND](#target-bound) | 邊界隔離、Entity／ORM 不對外回傳及跨模組資料契約已由共通定義。 | 不需獨立 Java 義務；維持原禁止事項的邊界範圍，不能擴成持久化元件也不能回傳自身模型。 |
| BM-02：明確控制欄位及來源 | 8／32 | **改引用** | [MAP](#target-map)、[API](#target-api)、[SEC](#target-sec) | 欄位允許清單、避免自動帶入與可信欄位來源已有共通依據。 | 可保留 Java DTO 範例；特定映射工具配置另歸 Framework。 |
| BM-03：聚焦轉換與必要驗證 | 9／33 | **提升共通** | [MAP](#target-map) | 共通只有轉換責任，尚未明確禁止 mapper 隱藏查詢、業務決策與副作用。 | 沒有必要保留 Java 獨立政策；建立 Java 專屬型別可保留例子。 |
| BM-04：失敗明確回報 | 13／34 | **改引用** | [ERROR](#target-error)、[VALID](#target-valid)、[MAP](#target-map) | 失敗分類、不用預設值掩蓋及各筆部分結果的對應，既有共通已涵蓋。 | 映射頁引用共同政策並保留情境驗收，不新增同義規則。 |
| BM-05：保留更新意圖 | 14／35 | **保留** | [NULL](#target-null)、[MAP](#target-map) | 三種更新意圖已共通；Java null／Optional 無法自行表達三種意圖是語言落實。 | 保留明確更新型別與反序列化後不得合併意圖的 Java 說明。 |
| BM-06：可變參考隔離 | 15／36 | **改引用** | [BOUND](#target-bound)、[DESIGN](#target-design) | 共通已有巢狀可變參考隔離；快照細節由 CO-01／02 的共通候選承接。 | 可保留 Java 集合複製例子，不把此項當 Java 專屬。 |
| BM-07：各方向分別定義 | 16／37 | **提升共通** | [MAP](#target-map) | 共通尚未明訂輸入輸出各方向獨立、遮罩／衍生資料不可直接逆向寫回。 | 工具反向映射僅作情境例子，具體工具設定另歸 Framework。 |
| BM-08：明確維護責任 | 20／38 | **改引用** | [MAP](#target-map)、[SHARED](#target-shared)、[DI](#target-di) | 負責邊界元件維護、簡單方法及按需要抽 Mapper、介面非強制已有共同依據。 | 無必要額外維持 Java 獨立條款。 |
| BM-09：驗證實際映射路徑 | 21／39 | **提升共通** | [MAP](#target-map)、[VERIFY](#target-verify)、[TEST](#target-test) | 共同測試已要求實際整合；映射的各方向、資料隔離及實際序列化路徑驗收需補齊。 | Java 頁只保留語言實作案例；特定工具的驗證步驟歸 Framework。 |

## 7. Java 類別、介面與物件建立（CL，10 條）

原文件：[classes-and-construction.md](../rules/stacks/java/common/classes-and-construction.md)。以下行號均指此檔。

| 追蹤 ID／原條目 | 原行／驗收行 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| CL-01：介面的用途 | 7／32 | **改引用** | [DI](#target-di)、[MODULE](#target-module) | 介面依隔離、多型與能力需求建立，不為 DI 強加介面已有共通定義。 | 可保留 Java 介面／具體類別範例。 |
| CL-02：繼承的可替代性 | 8／33 | **提升共通** | [DESIGN](#target-design) | 可替代性與僅為共用實作時優先組合，是物件導向共同原則，現行共通未明訂。 | 保留 Java 繼承範例；適用範圍限具有子型別替代關係的設計。 |
| CL-03：必要資料與依賴齊備 | 9／34 | **提升共通** | [LIFE](#target-life)、[DESIGN](#target-design)、[DI](#target-di) | 值型別建立有效已有規定；一般元件必要資料與分階段就緒條件尚缺完整共通要求。 | 保留 Java 建構完成與啟動分離的例子，不要求建構子做外部連線。 |
| CL-04：建構期間的安全性 | 10／35 | **保留** | [DESIGN](#target-design)、[LIFE](#target-life) | this 外洩與建構期間動態派送是 Java 的明確建構風險。 | 保留禁止外洩與呼叫可覆寫方法；生命週期完成後才發布引用 LIFE 候選。 |
| CL-05：明確取得依賴 | 14／36 | **提升共通** | [DI](#target-di) | 既有共通已禁查容器，但靜態服務登錄及延後建立的明確工廠／提供者需補述。 | 保留 Java 建構子依賴及 Supplier 類用途的概念，不預先指定實作 API。 |
| CL-06：依需求選擇建立方式 | 15／34 | **提升共通** | [DESIGN](#target-design)、[DOMAIN](#target-domain) | 按需求選建構子、工廠、Builder 及所有入口一致驗證，是物件建立共同原則。 | 保留 Java 建構方式例子；不推導成一律使用 Builder。 |
| CL-07：控制繼承與覆寫範圍 | 16／33 | **保留** | [DESIGN](#target-design)、[DI](#target-di) | 最小擴充原則共通，final、super 與 Java 代理相容是具體限制。 | 保留 final 不一律強制／禁止、必要檢查不可依賴子類自律；框架細節另訂。 |
| CL-08：介面的能力劃分 | 17／32 | **提升共通** | [DESIGN](#target-design)、[SEC](#target-sec) | 能力內聚、不迫使實作不支援操作是介面設計共同原則，現行共通未完整定義。 | 保留 Java 介面例子；授權政策只引用 SEC。 |
| CL-09：生命週期與可變狀態相容 | 21／37 | **提升共通** | [LIFE](#target-life)、[DI](#target-di) | 共用範圍與依賴壽命相容不只適用 Java，現行共通僅要求集中管理生命週期。 | 保留 Java 實例欄位與共享服務例子；具體 scope 配置留 Framework。 |
| CL-10：契約與生命週期驗收 | 22／38 | **提升共通** | [LIFE](#target-life)、[TEST](#target-test)、[VERIFY](#target-verify) | 建立、替代與生命週期的新共同要求需要相應驗收，不能只留在 Java。 | 保留 Java 建構／覆寫的驗收；框架實際配置驗證依具體 Framework 補充。 |

## 8. Java 相等性、雜湊與排序（EQ，10 條）

原文件：[equality-hashing-ordering.md](../rules/stacks/java/common/equality-hashing-ordering.md)。以下行號均指此檔。

| 追蹤 ID／原條目 | 原行／驗收行 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| EQ-01：明訂比較語意 | 7／27 | **提升共通** | [DOMAIN](#target-domain) | 物件身分、業務實體身分、值內容及版本一致性是模型語意，現行共通未明訂。 | 保留 equals 如何落實選定語意的 Java 說明。 |
| EQ-02：相等與雜湊契約 | 8／27 | **保留** | [DOMAIN](#target-domain) | equals 與 hashCode 的具體方法契約是 Java 規範必要內容。 | 保留自反、對稱、遞移、一致、null 與相等雜湊關係。 |
| EQ-03：雜湊集合中的穩定性 | 9／28 | **保留** | [COLL](#target-coll)、[DOMAIN](#target-domain) | 此處具體約束 Java 雜湊集合使用 equals／hashCode 時的穩定性。 | 保留鍵穩定與移出再加入的處理，不因共通所有權已有而刪掉 API 保證。 |
| EQ-04：Entity 識別碼的生命週期 | 10／29 | **提升共通** | [DOMAIN](#target-domain) | Entity 識別前後相等及缺值不判同是跨語言領域問題，現行共通欠缺。 | 保留 Java equals 不強制覆寫及集合限制；不引入特定 ORM 識別策略。 |
| EQ-05：跨型別相等範圍 | 11／29 | **保留** | [DOMAIN](#target-domain)、[DESIGN](#target-design) | Java instanceof／getClass 與繼承的 equals 相容是語言落實。 | 保留跨型別範圍、對稱與遞移限制；一般可替代性引用 CL-02 共通候選。 |
| EQ-06：自然順序與情境排序 | 15／30 | **保留** | [DOMAIN](#target-domain) | Comparable／Comparator 分別承載自然與情境順序，是 Java 介面選擇。 | 保留介面採用條件、比較欄位方向與同值處理。 |
| EQ-07：比較關係一致 | 16／30 | **保留** | [DATA](#target-data) | 比較器關係契約及避免相減比較，是 Java Comparable／Comparator 的使用約束。 | 保留比較關係與同次比較資料穩定；數值範圍原則引用 DATA 候選。 |
| EQ-08：比較為零與相等性 | 17／31 | **保留** | [COLL](#target-coll) | compare 為零與 equals 在 TreeSet／TreeMap 中的互動有明確 Java API 語意。 | 保留判同與資料不被意外合併的驗收。 |
| EQ-09：排序集合中的穩定性 | 18／32 | **保留** | [COLL](#target-coll) | 此處處理排序集合索引與比較器變更，屬 Java 集合使用的具體保證。 | 保留移出重加／重建與比較器設定變更後資料檢查。 |
| EQ-10：關係與集合行為驗收 | 19／33 | **保留** | [TEST](#target-test)、[VERIFY](#target-verify) | 一般風險測試引用共通，Java 相等、排序及實際集合驗收仍有獨立價值。 | 保留關係性案例及實際雜湊／排序集合驗收。 |

## 9. Java 集合與資料所有權（CO，9 條）

原文件：[collections-and-ownership.md](../rules/stacks/java/common/collections-and-ownership.md)。以下行號均指此檔。

| 追蹤 ID／原條目 | 原行／驗收行 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| CO-01：明確定義修改權與參考關係 | 7／31 | **提升共通** | [COLL](#target-coll)、[DESIGN](#target-design) | 共通已有狀態擁有者，尚未完整約定傳入參考保留、回傳檢視與元素修改權。 | Java 只保留集合 API 如何實現契約的說明；不要求全面複製。 |
| CO-02：區分不可修改與不可變快照 | 8／31 | **提升共通** | [COLL](#target-coll)、[DESIGN](#target-design) | 不可修改、不可變快照與來源可見的檢視是跨語言契約，現行共通未完整區分。 | 保留 Java 唯讀包裝及淺複製反例；不把唯讀等同深層不可變。 |
| CO-03：順序與重複資料 | 9／32 | **提升共通** | [COLL](#target-coll) | 順序、重複元素及重複鍵處理應由集合契約統一，不限 Java 或列表 API。 | 保留 Java 集合選擇及轉換例子，不能默認所有集合都需有序。 |
| CO-04：遍歷期間的修改 | 13／33 | **提升共通** | [COLL](#target-coll)、[ASYNC](#target-async) | 遍歷修改的範圍、不可依未拋錯判安全及不可直接重跑，是通用集合使用保證。 | 保留 Java Iterator／遍歷修改行為的實作說明；不假定所有集合 fail-fast。 |
| CO-05：複合操作的原子性 | 14／34 | **提升共通** | [ASYNC](#target-async)、[COLL](#target-coll) | 執行緒安全容器不保證複合操作原子性是通用併發問題；資料庫交易規則不能代替。 | 保留 Java concurrent collection 的使用情境；不重寫共同同步政策。 |
| CO-06：限制資料累積 | 18／35 | **提升共通** | [PERF](#target-perf)、[COLL](#target-coll) | 共通已有資源上限，但延遲語法不保證有界、排序去重實際累積需明確補充。 | 保留 Iterator／Stream 的 Java 成本例子；不提升特定實作的記憶體推測。 |
| CO-07：延遲讀取的資源責任 | 19／36 | **提升共通** | [LIFE](#target-life)、[COLL](#target-coll) | 延遲資料流程的擁有者、有效期與提前停止清理是跨語言資源契約。 | 保留 Java 依賴資源的 Iterator／Stream 說明；配合 EX-05 關閉方式。 |
| CO-08：批次修改的失敗保證 | 20／37 | **改引用** | [ERROR](#target-error) | 共通「多步驟與部分成功」已明訂失敗後狀態、各筆對應及不能宣稱全部撤銷。 | 保留 Java 批次集合修改範例，不假設拋例外即無修改。 |
| CO-09：所有權與行為驗收 | 21／38 | **提升共通** | [COLL](#target-coll)、[TEST](#target-test) | 新增的所有權、快照與遍歷共通契約須附驗收；既有測試策略僅提供方法。 | 保留 Java 實際集合使用案例，不重測標準函式庫。 |

## 10. Java 例外與資源管理（EX，9 條）

原文件：[exceptions-and-resources.md](../rules/stacks/java/common/exceptions-and-resources.md)。以下行號均指此檔。

| 追蹤 ID／原條目 | 原行／驗收行 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| EX-01：明確的故障分類 | 7／28 | **保留** | [ERROR](#target-error) | 分類政策已共通，本條補上 throws Exception／RuntimeException 的 Java 表達限制。 | 保留具體例外型別與不強制自訂例外；分類與原因保留改引用。 |
| EX-02：Checked 與 Unchecked 的選擇 | 8／28 | **保留** | [ERROR](#target-error) | Checked 與 Unchecked 的宣告與呼叫端責任是 Java 型別機制。 | 保留選擇依據及不能用它判定恢復／重試。 |
| EX-03：捕捉範圍與處置相符 | 9／28 | **保留** | [ERROR](#target-error) | 捕捉責任已共通，Throwable／Error 與 try 範圍是 Java 具體操作。 | 保留具體捕捉與廣泛捕捉限制，避免重複整套錯誤政策。 |
| EX-04：保留中斷意圖 | 10／29 | **保留** | [ERROR](#target-error) | InterruptedException 的傳遞及恢復中斷旗標是 Java 特有機制。 | 保留中斷處理及不得吞掉後重試。 |
| EX-05：優先使用語言資源管理機制 | 14／30 | **保留** | [LIFE](#target-life)、[ERROR](#target-error) | AutoCloseable 與 try-with-resources 是 Java 資源管理落實。 | 保留機制優先使用與借用資源不可擅關；所有權政策引用 LIFE 候選。 |
| EX-06：保留操作與清理失敗 | 15／31 | **保留** | [ERROR](#target-error) | 共通已要求同時保留操作與清理故障；suppressed exceptions 與 finally 控制流程是 Java 落實。 | 保留 suppressed 關係、try-with-resources 及 finally 不覆蓋結果。 |
| EX-07：部分取得與所有權移交 | 16／32 | **提升共通** | [LIFE](#target-life)、[ERROR](#target-error) | 部分取得清理、正式移交前後責任及依賴釋放順序尚無完整共通定義。 | 保留 Java 初始化案例；失敗分類與清理故障仍引用 ERROR。 |
| EX-08：有效期與關閉契約 | 17／33 | **提升共通** | [LIFE](#target-life) | 跨委派／非同步的有效期、關閉後及重複關閉契約是通用資源責任。 | 保留 Java AutoCloseable 使用情境，不假定所有 close 都冪等。 |
| EX-09：失敗路徑驗收 | 18／34 | **保留** | [TEST](#target-test)、[VERIFY](#target-verify)、[LIFE](#target-life) | Java 中斷、suppressed 與語言關閉路徑需具體驗收；一般生命週期案例隨 EX-07／08 提升。 | 保留 Java 特有故障路徑的驗收；不重訂一般測試政策。 |

## 11. Java 數值、日期時間與文字處理（NT，14 條）

原文件：[numbers-dates-text.md](../rules/stacks/java/common/numbers-dates-text.md)。以下行號均指此檔。

| 追蹤 ID／原條目 | 原行／驗收行 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| NT-01：依語意選擇數值型別 | 7／36 | **提升共通** | [DATA](#target-data)、[DOMAIN](#target-domain) | 精確／近似數值、單位與範圍涉及內部運算，不能只靠現有 API 傳輸格式規則。 | 保留 BigDecimal 或最小單位整數的 Java 選擇。 |
| NT-02：從精確來源建立 | 8／36 | **提升共通** | [DATA](#target-data)、[TYPE](#target-type) | 避免先經近似來源失真及解析後業務限制，應作為共通精確數值要求。 | 保留浮點再轉 BigDecimal 無法恢復原值的 Java 反例。 |
| NT-03：明訂捨入規則 | 9／37 | **提升共通** | [DATA](#target-data)、[API](#target-api) | API 已有捨入契約；運算階段、逐筆／彙總順序及不可精確時回報須覆蓋內部計算。 | Java 保留具體精度與捨入實作；不替專案選定模式或位數。 |
| NT-04：範圍與轉換檢查 | 10／37 | **提升共通** | [DATA](#target-data)、[TYPE](#target-type) | 轉換檢查已共通，但運算本身溢位及輸入合法不保證結果合法需補入。 | 保留 Java 縮窄轉型及整數回繞情境，不規定其他語言相同行為。 |
| NT-05：BigDecimal 判同語意 | 11／38 | **保留** | [DATA](#target-data)、[DOMAIN](#target-domain) | BigDecimal scale 與 equals／compareTo 的關係是具體 Java 型別語意。 | 保留 1.0／1.00、雜湊及排序判同要求；業務等價規則引用共通候選。 |
| NT-06：依業務語意選擇時間型別 | 15／39 | **提升共通** | [DATA](#target-data)、[API](#target-api) | 對外時間語意已有規定；內部也需區分日期、當地時間及確切時點。 | 保留 java.time、LocalDate、Instant、LocalDateTime 的具體選擇。 |
| NT-07：明確的時區轉換 | 16／39 | **提升共通** | [DATA](#target-data) | 缺失／重複當地時間及明確時區轉換尚無完整共通內部處理要求。 | 保留 Java 時區 API 的情境說明；不以預設解析政策取代業務契約。 |
| NT-08：區分時間長度與日曆規則 | 17／39 | **提升共通** | [DATA](#target-data) | 固定時間長度、日曆間隔與營業日是跨語言業務語意。 | 保留 Duration／Period 的 Java 對應，不假設兩者涵蓋營業日。 |
| NT-09：可控制的時間基準 | 18／40 | **提升共通** | [DATA](#target-data)、[TEST](#target-test) | 測試已有可控制時鐘，生產流程共用判斷基準及單調耗時計時仍需明訂。 | 保留 Clock 與 Java 單調時間來源的落實；不把 Clock 當耗時計時器。 |
| NT-10：解析與輸出契約 | 19／41 | **提升共通** | [DATA](#target-data)、[TYPE](#target-type) | 完整解析、地區／時區及精度政策不只適用 Java，現有共通轉換要求尚較概括。 | 保留 Java 格式化／解析實作說明；避免環境預設。 |
| NT-11：明確指定字元編碼 | 23／42 | **提升共通** | [DATA](#target-data)、[CONTRACT](#target-contract) | 編碼、無效位元組與不可表示字元的資料損失處理應跨語言一致。 | Java 保留字元集 API 使用說明，不一律強制對外系統相同編碼。 |
| NT-12：長度與截取單位 | 24／42 | **提升共通** | [DATA](#target-data) | 位元組、碼點與可見字元的單位選擇是共通契約；現行共通未明訂。 | 保留 UTF-16、String.length 與代理對的 Java 限制。 |
| NT-13：用途明確的文字轉換 | 25／42 | **提升共通** | [DATA](#target-data)、[DOMAIN](#target-domain) | 地區、正規化及用途不同的等價規則是共同資料語意，與 VO-05 共用定義避免重複。 | 保留 Java 字串比較／轉換情境；領域值正規化引用 DOMAIN。 |
| NT-14：邊界與環境差異驗收 | 26／43 | **提升共通** | [DATA](#target-data)、[TEST](#target-test) | 新共通數值／時間／文字要求需附邊界及環境差異驗收。 | 保留 Java API 實際路徑案例，不測不適用情境或重測函式庫。 |

## 12. Java Lambda 與 Stream（LS，10 條）

原文件：[lambda-and-stream.md](../rules/stacks/java/common/lambda-and-stream.md)。以下行號均指此檔。

| 追蹤 ID／原條目 | 原行／驗收行 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| LS-01：意圖與可讀性優先 | 7／41 | **改引用** | [DESIGN](#target-design)、[NAME](#target-name) | 可讀性、按責任拆分、不訂固定行數已有共通定義。 | 保留 Java Lambda／Stream 不強制取代迴圈的情境說明。 |
| LS-02：明確的參數型別 | 8／41 | **保留** | [TYPE](#target-type) | Lambda 明確參數、禁止 var／省略及允許方法參考是 Java 語法取捨。 | 保留全部已確認的語法界線。 |
| LS-03：中間操作不隱藏業務副作用 | 9／42 | **保留** | [DESIGN](#target-design)、[ERROR](#target-error) | Stream 中間操作及 peek 的延遲／最佳化語意使必要副作用不可靠。 | 保留 peek 不承擔必要工作及明確執行步驟；副作用保證引用共通。 |
| LS-04：明確累積結果 | 10／42 | **保留** | [DESIGN](#target-design) | 明確 collect／reduce、避免捕捉外部可變累積狀態是 Java Stream 的具體使用限制。 | 保留適當收集／歸約或迴圈選擇，不提升為所有程式禁止修改外部狀態。 |
| LS-05：延遲與短路範圍 | 14／43 | **保留** | [ERROR](#target-error) | Stream 建立、終端操作及短路範圍屬 Java 執行模型。 | 保留必要工作不可依賴所有元素都執行的限制。 |
| LS-06：平行處理的採用條件 | 15／44 | **保留** | [PERF](#target-perf)、[ASYNC](#target-async) | 平行 Stream 的實際執行資源與歸約需特別驗證。 | 保留採用條件及量測要求；容量、失敗與所有權引用共同要求。 |
| LS-07：歸約與收集契約 | 16／45 | **保留** | [COLL](#target-coll)、[DATA](#target-data) | Stream reduce／collect 的初始值、結合與可變容器有具體契約。 | 保留累積、合併、順序及共用可變初始值的禁止事項。 |
| LS-08：維持錯誤分類 | 20／46 | **保留** | [ERROR](#target-error) | 共同失敗分類已存在，但 Java 函式介面對例外宣告有具體限制。 | 保留介面受限時調整流程或明確轉換，禁止隱藏拋出規避。 |
| LS-09：明確消費範圍 | 21／47 | **保留** | [LIFE](#target-life)、[COLL](#target-coll) | Stream 單次消費與不可重用是 Java API 契約；快照及重新取得則引用共同要求。 | 保留單次消費及多流程不可各自消費同一實例。 |
| LS-10：執行語意驗收 | 22／48 | **保留** | [TEST](#target-test)、[VERIFY](#target-verify) | 延遲、短路、歸約及平行 Stream 的語意須在 Java 使用處驗收。 | 保留 Java 執行路徑驗收；一般風險選案與不重測函式庫引用 TEST。 |

## 13. Java 併發與非同步處理（CA，12 條）

原文件：[concurrency-and-async.md](../rules/stacks/java/common/concurrency-and-async.md)。以下行號均指此檔。

| 追蹤 ID／原條目 | 原行／驗收行 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| CA-01：明確的工作擁有者 | 7／37 | **提升共通** | [ASYNC](#target-async)、[LIFE](#target-life)、[ERROR](#target-error) | 共通零散規定取消及背景流程；工作擁有者及責任移交尚缺統一要求。 | 保留 Java 任務追蹤實作說明，不強制原請求等待全部工作。 |
| CA-02：統一管理執行資源 | 8／38 | **提升共通** | [ASYNC](#target-async)、[PERF](#target-perf)、[LIFE](#target-life) | 資源上限已共通，執行資源集中管理與生命週期需補到一般非同步流程。 | 保留 Executor／ExecutorService／虛擬執行緒仍受下游限制的 Java 落實。 |
| CA-03：可見性與共享資料 | 9／39 | **保留** | [ASYNC](#target-async)、[DESIGN](#target-design) | 可見性及 volatile 對物件安全的限制是 Java 記憶體模型落實。 | 保留跨執行緒交付及 volatile 不代表複合操作安全；所有權引用共通候選。 |
| CA-04：等待期限與逾時處置 | 13／40 | **提升共通** | [ASYNC](#target-async)、[PERF](#target-perf)、[EXTERNAL](#target-external) | 外部呼叫已有整體期限；本機非同步等待亦納入預算是適用範圍擴充，須明確認可。 | 保留 Java 等待 API 的落實；不把等待結束當任務停止。 |
| CA-05：取消傳遞與實際停止 | 14／40 | **提升共通** | [ASYNC](#target-async)、[ERROR](#target-error) | 共通已有取消傳遞與副作用不撤銷；子工作未停止時的擁有者與結案追蹤需補明。 | Java 中斷及 Future 取消的具體行為分別引用 EX-04／本語言落實。 |
| CA-06：結果接收與故障處置 | 15／37 | **保留** | [ERROR](#target-error)、[ASYNC](#target-async) | 故障分類共通，Future／CompletableFuture 的結果與例外鏈需要 Java 特定處置。 | 保留不得忽略工作控制物件、結果鏈恢復不能假成功。 |
| CA-07：多工作組合的完成條件 | 16／41 | **提升共通** | [ASYNC](#target-async)、[ERROR](#target-error) | 多工作整體完成、競速成功及剩餘工作處置不是 Java 專屬，現行共通未完整定義。 | 保留 Java 組合 API 例子；不把第一個完成視為第一個成功。 |
| CA-08：執行位置與阻塞行為 | 20／38 | **提升共通** | [ASYNC](#target-async)、[PERF](#target-perf) | 同一受限資源的等待造成無法前進，是通用排程與阻塞問題。 | 保留 Java executor 執行位置說明；不強制每階段獨立執行緒池。 |
| CA-09：明確傳遞與清理脈絡 | 21／42 | **提升共通** | [ASYNC](#target-async)、[SEC](#target-sec)、[OBS](#target-obs) | 安全與追蹤原則已共通；工作脈絡交付、清理及還原需整合成非同步契約。 | 保留 ThreadLocal 不會自動沿用與共用執行緒清理的 Java 限制。 |
| CA-10：鎖定範圍與取得策略 | 22／39 | **提升共通** | [ASYNC](#target-async) | 資料庫交易規則不足以涵蓋程序內鎖定、回呼、鎖順序及釋放責任。 | 保留 Java 同步及鎖 API 的實作範例；不把語言特性套給所有鎖。 |
| CA-11：受控關閉 | 26／43 | **提升共通** | [LIFE](#target-life)、[ASYNC](#target-async)、[PERF](#target-perf) | 共通資源回收尚未完整定義停止受理、排隊、未知結果接手的關閉流程。 | 保留 Java 執行元件的關閉落實；不把 shutdown 要求等同停止完成。 |
| CA-12：可控制的併發驗收 | 27／44 | **提升共通** | [TEST](#target-test)、[ASYNC](#target-async) | 共通已有期限與完成條件；受控交錯及壓力測試不能獨自證明安全需補明。 | 保留 Java 協調原語的驗收方式，不硬性指定測試框架。 |

## 14. Java 反射、動態能力與檢查抑制（RF，8 條）

原文件：[reflection-and-suppression.md](../rules/stacks/java/common/reflection-and-suppression.md)。以下行號均指此檔。

| 追蹤 ID／原條目 | 原行／驗收行 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| RF-01：明確需求與型別契約 | 7／27 | **保留** | [TYPE](#target-type)、[DI](#target-di) | 共同禁止型別逃逸已存在，Java 反射能力的集中使用是具體落實情境。 | 保留反射／動態呼叫的需求與型別銜接，不重訂一般架構政策。 |
| RF-02：受控目標與授權 | 8／27 | **提升共通** | [SEC](#target-sec)、[TYPE](#target-type) | 共通反序列化已有任意類別限制，但一般外掛／動態呼叫的允許清單需補明範圍。 | 保留 Java 類別、方法、建構子的目標解析說明；不以型別符合代替授權。 |
| RF-03：維持封裝與不變條件 | 9／28 | **保留** | [DESIGN](#target-design)、[GOV](#target-gov)、[TYPE](#target-type) | 封裝及驗證原則共通，Java 反射特殊存取須明確受限。 | 保留反射不得繞過建立條件；存取放寬核准流程引用 GOV。 |
| RF-04：使用前驗證契約 | 10／28 | **提升共通** | [TYPE](#target-type)、[VALID](#target-valid) | 動態能力的版本、能力及型別檢查時機，比既有未知資料驗證更具體。 | 保留 Java 反射檢查例子；適用範圍限有動態載入／呼叫能力的元件。 |
| RF-05：區分故障與執行結果 | 11／29 | **提升共通** | [ERROR](#target-error) | 共通已有原因保留與未知結果；解析／存取／契約失敗與已執行故障的動態情境需補明。 | 保留 Java 動態呼叫的例外包裝與原始原因處理，不能因收到外層例外就重跑。 |
| RF-06：限定檢查抑制 | 15／30 | **提升共通** | [GOV](#target-gov)、[VERIFY](#target-verify) | 最小例外已共通；誤報依據、最小抑制及工具變更後重審尚需明訂。 | Java 只保留 SuppressWarnings 等機制及既有 raw／unchecked 禁令。 |
| RF-07：產生碼不擴大豁免 | 16／31 | **提升共通** | [GOV](#target-gov) | 產生碼來源管理已有規則；重新產生後確認例外有效性及不擴大手寫碼豁免需補強。 | 保留 Java 產生器／手寫銜接例子，不維護第二份產生碼治理。 |
| RF-08：驗證限制實際有效 | 17／32 | **提升共通** | [VERIFY](#target-verify)、[SEC](#target-sec)、[GOV](#target-gov) | 動態拒絕、抑制有效範圍與重新產生結果的驗收，應隨 RF-02／04／05／06／07 提升。 | 保留 Java 反射存取與型別實際路徑的驗收。 |

## 15. Java 命名、套件與文件（ND，7 條）

原文件：[naming-packages-docs.md](../rules/stacks/java/common/naming-packages-docs.md)。以下行號均指此檔。

| 追蹤 ID／原條目 | 原行／驗收行 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| ND-01：一致的命名形式 | 7／26 | **保留** | [NAME](#target-name) | 大小寫、package 與列舉常數形式是 Java 慣例的明確落實。 | 保留各識別字命名形式、常數判定及不強制 I 前綴。 |
| ND-02：名稱表達具體責任 | 8／26 | **改引用** | [NAME](#target-name)、[DESIGN](#target-design) | 名稱表達責任與上下文已有共通原則，不因 Service／Utils 字樣成為 Java 專屬。 | 保留 Java 常見角色後綴的例子，不新增後綴禁令。 |
| ND-03：套件與架構邊界 | 9／27 | **保留** | [MODULE](#target-module)、[SHARED](#target-shared)、[DESIGN](#target-design) | 責任與依賴已共通；Java package 與可見性落實仍需語言說明。 | 保留 package 公開／內部界線及檢查，不重訂目錄或架構政策。 |
| ND-04：補足契約資訊 | 13／28 | **保留** | [DESIGN](#target-design)、[CONTRACT](#target-contract) | 公開契約內容已有共通規定；Javadoc 就近維護是 Java 文件方式。 | 保留 Javadoc 或引用主要來源的做法；生命週期等契約內容引用共同來源。 |
| ND-05：實作註解與暫時處理 | 14／28 | **提升共通** | [DESIGN](#target-design)、[GOV](#target-gov) | 註解理由與同步維護已共通；暫時處理及 TODO 的可追蹤後續事項需補入。 | Java 僅保留註解範例，不另設專屬 TODO 治理。 |
| ND-06：重新命名與搬移的影響 | 15／29 | **保留** | [CONTRACT](#target-contract)、[MODULE](#target-module) | 公開相容性共通；Java 類別及 package 名稱可能被設定／反射引用需具體核對。 | 保留 IDE 重構不足以保證動態引用更新的提醒及驗收。 |
| ND-07：形式與語意分別驗收 | 16／30 | **提升共通** | [VERIFY](#target-verify)、[DESIGN](#target-design)、[TEST](#target-test) | 自動形式與人工語意已共通；文件連結、參照及可執行範例的驗證需補明。 | 保留 Java Javadoc／範例在支援版本下的實際驗收。 |

## 16. 尚未寫入的自動檢查決策（AU）

來源為本聊天的討論紀錄，以下為決策摘要，並非宣稱逐字引述。AU-01 至 AU-08 已確認、未寫入；AU-09 是未確認提案。尚無來源 Rule 檔或驗收表，不能把這份清單當作已生效規範。尤其僅以「同意」確認的項目，後續寫入前仍須核對摘要涵蓋的語意。

| ID／決策摘要 | 狀態 | 處置 | 共通對應 | 理由與缺口 | Java 後續保留／處置 |
| --- | --- | --- | --- | --- | --- |
| AU-01：規範須對應自動檢查、行為測試或人工審查，標示未涵蓋處 | 已確認，未寫入 | **改引用** | [VERIFY](#target-verify) | 共同把關已明訂工具、行為、人工與工具缺口，不應再建立 Java 治理副本。 | Java 後續只列對應檢查能力及尚未覆蓋的具體語言要求。 |
| AU-02：必要檢查版本、規則與設定受版本控制；本機與 CI 一致且可重現 | 已確認，未寫入 | **提升共通** | [VERIFY](#target-verify) | 現有共通規範要求執行檢查，但工具與規則版本、可重現入口尚未完整明訂。 | Java 僅補 JDK、編譯器及建置入口的適用方式；不選定工具。 |
| AU-03：確認必要檢查實際執行範圍與結果；未執行或未涵蓋不算通過；無適用內容須有依據 | 已確認，未寫入 | **提升共通** | [VERIFY](#target-verify)、[PR](#target-pr) | PR 已禁止未完成／略過當成功；需補檢查覆蓋範圍及無適用內容的證據。 | Java 僅列 source set、模組或產生碼等需核對的實際範圍。 |
| AU-04：檢查規則與配置本身須以符合／違反案例驗證能正確放行與拒絕 | 已確認，未寫入 | **提升共通** | [VERIFY](#target-verify) | 測試被測程式不等於驗證檢查設定；目前缺少一般檢查有效性要求。 | Java 可補 raw／unchecked 或版本越界的代表案例，不重寫政策。 |
| AU-05：既有違規基準辨識規則及位置；修正項目移出；不得吸收新違規 | 已確認，未寫入 | **提升共通** | [GOV](#target-gov)、[VERIFY](#target-verify) | 已有基準、不得新增及精確範圍；需補不能只看總數與移除已修正項目的維護方式。 | Java 只記工具可提供的具體定位方式。 |
| AU-06：驗證證據對應受驗版本、環境及設定；快取／增量結果須確認依賴與覆蓋仍有效 | 已確認，未寫入 | **提升共通** | [VERIFY](#target-verify)、[PR](#target-pr) | 合併驗證已有實際內容要求；快取及增量證據有效性尚缺完整共同要求。 | Java 僅補建置快取、增量編譯等適用實作，不指定系統。 |
| AU-07：自動修正須審查差異與行為契約；不得加未核准抑制、移除必要測試或降低規則 | 已確認，未寫入 | **改引用** | [PR](#target-pr)、[GOV](#target-gov)、[TEST](#target-test) | 工具產出作者責任、不得擅降標準與必要測試已有共同依據；以自動修正情境串接引用即可。 | Java 可列格式化／IDE 修正範例，不新增另一套審查程序。 |
| AU-08：結果可定位、可重現及追溯受驗版本；區分違規、行為失敗及工具故障；診斷遵守安全要求 | 已確認，未寫入 | **提升共通** | [VERIFY](#target-verify)、[SEC](#target-sec)、[OBS](#target-obs) | 安全與診斷原則已存在；檢查結果的三種分類及可重現證據需補明。 | Java 僅補編譯診斷、測試與分析工具報告的對應入口。 |
| AU-09：必要檢查的合併阻擋須實際有效，不以只有報告取代門檻 | 待確認，不納入已同意項目 | **改引用** | [PR](#target-pr)、[VERIFY](#target-verify) | 既有共通已要求違規阻擋；此列僅記錄先前提出的方向，新增驗證門檻有效性的要求尚未核准。 | 不寫入 Java 或共通 Rule；需先釐清與既有條款的差異。 |

## 彙總與必須先確認的範圍

已寫入 Java：15 份、153 條；保留 69 條、改引用 19 條、提升共通 65 條。混合條款只按主要處置計數，不能以此推算最後條數或刪除數。

已確認未寫入：8 條；改引用 2 條、提升共通 6 條、純 Java 保留 0 條。另列 AU-09 待確認，不計入 161 條已確認決策。

以下不是此次新增決策，而是執行整理前必須解決的歸屬／適用範圍問題：

1. **新共通主題的落點**：COLL、LIFE、ASYNC、DATA 是否獨立成檔，或先補到現有章節。此清單只提供候選位置。
2. **物件導向的適用條件**：CL-02／06／08、EQ-01／04 等只約束具有相應物件、子型別或身分模型的設計；不強迫所有語言採用類別、介面或 Builder。
3. **新跨語言義務**：VO-03 的值物件不可變、JN-09 的內部空值契約相容、CA-04 的所有非同步等待期限等，不能因 Java 已同意就自動視為其他語言已核准。
4. **HTTP／JSON 的條件式規則**：JN-12 放在共通介面設計仍須限定適用協定，不要求 RPC 或其他協定使用 HTTP 狀態或 JSON。
5. **禁止回傳 Entity 的邊界**：BM-01 改引用時核對既有外部／跨模組責任，不把語句簡化成所有內部方法都不得回傳 Entity。
6. **避免重複提升**：VO-04 與 EQ-01 的相等語意由 DOMAIN 統一；CO-05 與 CA-03／10 的原子性由 ASYNC 統一；CO-07、CL-03／09、EX-07／08、CA-11 的生命週期由 LIFE 統一。
7. **驗收隨主要來源維護**：共通測試策略只管選案與執行方式，領域、映射、資源等特有驗收仍連回其主題；Java 語言機制案例不能因原則提升而遺失。
8. **自動檢查尚未完成**：AU-09 尚未核准；AU-01／07 可由現有共通政策引用承接，其他提案只補明缺口，不另建相同的 Java 治理制度。

## 本次未執行及後續驗證

- 未修改任何 Rule、索引、既有驗收，未搬移檔案，未提交或推送。
- 未新增 Framework 或各專案配置；也未決定 Java 版本差異及具體檢查工具。
- workflow 目錄分類與 java/common 命名仍是另外的結構議題，不混入本次逐條搬移。
- 此表確認後，才依原 ID 建立「原條文 → 主要來源／Java 增量 → 驗收」的實際變更，並核對沒有降低原要求或默默擴大範圍。

## 來源快照

| 代碼 | 來源 | 編號決策數 | SHA-256 |
| --- | --- | --- | --- |
| JV | [version-policy.md](../rules/stacks/java/common/version-policy.md) | 12 | `0b2b1c12ce2dc1766c8b3f3a9a35390085d3679569c6a08013a0154319cfd0b9` |
| JT | [types-and-generics.md](../rules/stacks/java/common/types-and-generics.md) | 11 | `de4032ebbb7112df08e59ba19030a72e4578a47830f24afff86651729588848f` |
| JN | [null-and-optional.md](../rules/stacks/java/common/null-and-optional.md) | 12 | `433e5757065697f0cc757bf8a0905918d3bd1277d38ca3edfcbf7aaa827d04a7` |
| VO | [value-objects.md](../rules/stacks/java/common/value-objects.md) | 10 | `279a85c94b73bce9e77de1ce6ced05bbf449370d0a53dac9d9b77603e752e1d2` |
| ST | [states-and-results.md](../rules/stacks/java/common/states-and-results.md) | 10 | `8f74a32404d9adfb2e1ba14410fd29010882d88651afa24bb5f17087f298e44d` |
| BM | [boundary-mapping.md](../rules/stacks/java/common/boundary-mapping.md) | 9 | `0555c5d842159efd3551ccd6b8df2f87ed6c596ecf8da76c6a34f2df90486ce5` |
| CL | [classes-and-construction.md](../rules/stacks/java/common/classes-and-construction.md) | 10 | `3a6c8e24f1c0fd1fe951e96d28692376b6c9834be6f57b6e8087857dac86b4c1` |
| EQ | [equality-hashing-ordering.md](../rules/stacks/java/common/equality-hashing-ordering.md) | 10 | `82d1a5bd8fd59f267306d2046055ad415060f2589368f1601e5196ffce085295` |
| CO | [collections-and-ownership.md](../rules/stacks/java/common/collections-and-ownership.md) | 9 | `d4d5b174075537b5610aac67d622e7a55bc7d8033f7e7ac69a217936ec17458b` |
| EX | [exceptions-and-resources.md](../rules/stacks/java/common/exceptions-and-resources.md) | 9 | `ffcbbf72b9ee7e75366c2c5677ff24b9a18121be9195467ba22271d39ff0088a` |
| NT | [numbers-dates-text.md](../rules/stacks/java/common/numbers-dates-text.md) | 14 | `a4524fc0a7e14d2e8c4df17e1bbadc391561d385569ab0239a000be5888de7d5` |
| LS | [lambda-and-stream.md](../rules/stacks/java/common/lambda-and-stream.md) | 10 | `347d7b8586dd50c2596bc8e12cac6a24959453f1cc74969f1543eefb4d46ee7f` |
| CA | [concurrency-and-async.md](../rules/stacks/java/common/concurrency-and-async.md) | 12 | `d3833834ae56e372d38f550104380f778673562b9c0fe99beb6d138fb876bd4c` |
| RF | [reflection-and-suppression.md](../rules/stacks/java/common/reflection-and-suppression.md) | 8 | `396c76ba28661a2dbc1a454ea2771bbc851d85b82e78eef3fc75e8f55adb0841` |
| ND | [naming-packages-docs.md](../rules/stacks/java/common/naming-packages-docs.md) | 7 | `a6b455fa1b61d2711dfb932adf42ad200a39af260242cdcef059af6211f28866` |

共通來源亦以此次檢查時的工作區版本為準。下表供日後判斷「已由共通涵蓋」的依據是否改變；候選新主題沒有檔案雜湊。

| 對應代碼 | SHA-256 |
| --- | --- |
| TYPE | `58d460cdc9c87af993f3b51225ab82b2e0e799c17cfe220e6b47e05570ead6d8` |
| NULL | `0839a69fbba2ff5eff02c0196f7b2193c10140d59e93317dc3cfbe2ffba6866c` |
| DOMAIN | `891c37217a4f63f7496eb85f18192da8ec6fe09653160aadea896c7edf662bbf` |
| DESIGN | `4d7cac28bd81f072d90279d140cbe1d5f21e7a4f328400e78ced88b00f21c691` |
| ERROR | `aa6c82a648db93c21728244f7cd8e5e5c6daa9f8ed7b7b0741df11ef3e8017fb` |
| VALID | `18825e3751483b2a6d6a3470d4cacb971c54392fdf5fa0d3d53d7343a6b145f0` |
| NAME | `d8686d404c3e22bdca4739af63bd5f1c8edd44ac08f15e73660d7fe9caf939e5` |
| BOUND | `65d4ffdd2f033616ae078d5b4af3a51f7ed91b33d9d7bcfec1719b8d42462597` |
| MAP | `e69d0c5be88d2badcd45bf5bd5eb1d7856cd1797707850d7fe1892e26f3d7cc0` |
| DI | `3074105354c03b80070ef3a9336c25f8e128492b583f0efdad0784d68bce9927` |
| MODULE | `008301749a1d4e275ac3c09ed43724090e4325096e5ad9dbd6248d3a65b48a94` |
| SHARED | `d3ba2940a15295420205bee95db3646905bffdc4f2fa0a08089169ab9861b5e4` |
| API | `a8cab6c2438488602e6cc59cce66e9945db66a92ab73b50b3dabb5b5d4b24349` |
| CONTRACT | `38d9d1cac85f7868f9cdbb622c796d066fd5628bd923489c029c81e6792ae5bd` |
| EXTERNAL | `b0b09004a967cdc5dfb6100c7a6ba5f97706283fb42d475f60b7da67dc48fd0e` |
| MIGRATE | `450cff28ec2d0aece1ac5324b1d7b7f3cf0487f50c881f9ea5751306df07d713` |
| VERIFY | `26203752c83e588726247a0a1ff3c5195572529bde679cd2b858eabe939edcfb` |
| TEST | `fa4c30495331b880aea06a22d56e2f7e0e0c0dc039aba4e6029cd5e62bdceab6` |
| SEC | `3170db4be252d92651c505c4dc503d1d7aebd3ca75dd297b8d50093db3fa5645` |
| OBS | `ca2370cdad2997bf73563c01640df9cb24c1237e96b17b551796cb6b85cb1ff7` |
| PERF | `cf586c6984308c8db7fd0cea4238b27de0286c9fa1eb47eef4fe3a27e5dc4f64` |
| GOV | `ed8b7eb1556f73763194a11ecb2d928464e70ac7a9a59319c5b8c594153126d1` |
| PR | `a2d8516df4e80567391835ec7ec46f65c283f22cf7920ad47f76cdad4920c5f9` |
| DEP | `7f419ae85696e2c16da90270821d59d86d294d2477f99cd3f6ac681de899c12e` |
