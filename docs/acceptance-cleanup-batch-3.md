# 驗收整理第 3 批

基準提交：`163af59f52ddee97b98ad2ddeac1dc918bde8010`。僅在目前分支提交，不推送。

## 範圍與完成標準

- [version-policy](../rules/stacks/java/common/version-policy.md)
- [types-and-generics](../rules/stacks/java/common/types-and-generics.md)
- [null-and-optional](../rules/stacks/java/common/null-and-optional.md)

規則正文逐字保留；共同驗收引用唯一主要來源，Java 僅保留語言機制增量。原驗收每列分句依原順序串回須與基準一致，每片段只有一個目的地。沒有已核准共通規則依據的要求保留於 Java，不新增跨語言義務。

## 拆分與人工核對

- JV 1、2 的本機／CI 一致性引用既有檢查配置；JV 10、11 保留環境或工具變更後的觸發條件與完整斷言；版本拒絕、位元碼、JDK 發行商及產物相容性仍留 Java。
- JT 6 全列依既有容器、泛型與未知輸入驗證規則補上單一驗收，未新增規則。JT 2、3、7 與 4、5 保留 Java 泛型編譯拒絕、raw type／unchecked 及向下轉型情境。
- JN 8 分開第三方語意與 Optional 轉換；JN 9、12 分別引用已有的契約變更與 API 缺值驗收。JN 10 將完整有值／缺值分類覆蓋留 Java，測試資料及替身的型別安全亦保留於 Java 的 JN-10-2 目的列。
- JN 4、5 與 6、7、11 的 Java Optional 使用位置、集合非空預設與標註檢查仍保留；不把 Java 非空預設提升為共通義務。

## 原驗收逐句追溯

下表是歷史原文，執行時只依現行主要來源。

| 片段 ID | 基準原文 | 現行唯一主要來源 |
| --- | --- | --- |
| JV-1、2-1 | 核對版本宣告與實際建置設定。以不符合目標版本的語法或標準 API 案例，確認適用檢查會拒絕，並核對產物格式。 | [主要驗收](../rules/stacks/java/common/version-policy.md#acceptance-java-version-target) |
| JV-1、2-2 | 本機與 CI 的規則須一致。 | [主要驗收](../rules/quality/rule-verification.md#acceptance-check-configuration) |
| JV-3、4-1 | 查核各承諾執行版本的實際驗證結果。多模組按依賴關係核對使用端與提供端的相容範圍，不能只依單一較新環境通過推論所有版本符合。 | [主要驗收](../rules/stacks/java/common/version-policy.md#acceptance-java-runtime-matrix) |
| JV-5、6-1 | 核對實際解析出的直接與間接依賴要求。提高最低版本時檢查使用端影響、遷移順序及回退安排，確認支援範圍變更已有明確決策。 | [主要驗收](../rules/stacks/java/common/version-policy.md#acceptance-java-version-upgrade) |
| JV-7、8、9-1 | 依實際使用情形核對 Preview、內部 API、存取放寬與棄用 API 的紀錄。確認適用核准、環境配套、維護責任及重新評估條件，並驗證替代做法符合目標版本。 | [主要驗收](../rules/stacks/java/common/version-policy.md#acceptance-java-api-exceptions) |
| JV-12-1 | 從指定發布產物查回建置環境、編譯目標、依賴與驗證紀錄，再核對部署環境中的實際產物及 Java 環境。 | [主要驗收](../rules/stacks/java/common/version-policy.md#acceptance-java-artifact-runtime) |
| JV-10、11-1 | Java 環境或工具變更後，核對必要測試與分析確實執行，避免將被略過的檢查計為通過。 | [主要驗收](../rules/stacks/java/common/version-policy.md#acceptance-java-toolchain-compatibility) |
| JV-10、11-2 | 確認產生碼與產物仍相容，並保留發行商及完整版本變更的驗證結果。 | [主要驗收](../rules/stacks/java/common/version-policy.md#acceptance-java-toolchain-compatibility) |
| JT-1、9-1 | 檢查參數、回傳值、欄位與區域變數的明確宣告及泛型資訊，拒絕以 `var` 代替標註。允許的 `<>` 不得被誤判為 raw type，且宣告端須保留完整型別。 | [主要驗收](../rules/stacks/java/common/types-and-generics.md#acceptance-java-explicit-types) |
| JT-2、3、7-1 | 從實際呼叫處確認泛型的需求、約束及輸入輸出關聯，沒有用 `Object`、萬用字元或無依據的型別參數掩蓋業務型別。以代表性不相容型別案例確認適用的編譯檢查會拒絕。 | [主要驗收](../rules/stacks/java/common/types-and-generics.md#acceptance-java-generic-relations) |
| JT-4、5-1 | 啟用適用的 raw type 與 unchecked 警告檢查，確認新增與修改部分沒有違規，且未透過抑制或關閉檢查隱藏問題。審查向下轉型是否在補回遺失的業務型別；外部輸入以合法及不合法資料驗證邊界處理，必要例外須有核准及驗證依據。 | [主要驗收](../rules/stacks/java/common/types-and-generics.md#acceptance-java-unsafe-casts) |
| JT-8、10-1 | 從使用端確認集合介面及回傳型別足以完成契約操作，不需要補做轉型；檢查暴露實作類別或萬用字元是否有必要，且未將其誤作不可變性保證。 | [主要驗收](../rules/stacks/java/common/types-and-generics.md#acceptance-java-generic-return) |
| JT-11-1 | 審查泛型參數名稱是否足以辨識責任及關聯，複雜契約有必要說明，不僅依名稱長度判定。 | [主要驗收](../rules/stacks/java/common/types-and-generics.md#acceptance-java-type-parameter-names) |
| JT-6-1 | 核對固定結構資料是否使用明確物件；動態資料的型別、結構與驗證是否有契約，並以受影響的合法及非法輸入確認驗證有效。 | [主要驗收](../rules/coding/type-safety.md#acceptance-data-shape) |
| JN-1、2、3-1 | 驗證有值、單筆正常查無資料、多筆空結果，以及適用的必須存在卻不存在、查詢故障與結果未知。確認 `Optional` 本身非空，呼叫端的缺值分支、替代值與失敗分類符合契約。 | [主要驗收](../rules/stacks/java/common/null-and-optional.md#acceptance-java-optional-results) |
| JN-4、5-1 | 審查參數與欄位採用 `Optional` 的必要性及配套。 | [主要驗收](../rules/stacks/java/common/null-and-optional.md#acceptance-java-optional-positions) |
| JN-4、5-2 | 需要多狀態時分別驗證未提供、清空與設定值； | [主要驗收](../rules/stacks/java/common/null-and-optional.md#acceptance-java-optional-positions) |
| JN-4、5-3 | 集合等輸入含不允許的空值時，確認依契約處理，沒有默默丟棄或替換資料。 | [主要驗收](../rules/stacks/java/common/null-and-optional.md#acceptance-java-optional-positions) |
| JN-6、7、11-1 | 核對非空預設、可空標註、檢查範圍及實際驗證位置。確認適用工具能偵測違反契約的使用方式；必填外部輸入缺值時依契約拒絕，且未產生不應發生的副作用。 | [主要驗收](../rules/stacks/java/common/null-and-optional.md#acceptance-java-null-contract) |
| JN-8-1 | 依第三方契約分別驗證正常缺值及適用的異常空值、故障情境，確認內部轉換保留語意， | [主要驗收](../rules/coding/nullability.md#acceptance-third-party-null) |
| JN-8-2 | 未一律轉成空的 `Optional`。 | [主要驗收](../rules/stacks/java/common/null-and-optional.md#acceptance-java-optional-adaptation) |
| JN-9-1 | 檢查空值契約差異、使用端影響與必要遷移，確認相關標註、文件及驗證同步更新，不僅比對方法簽章。 | [主要驗收](../rules/coding/nullability.md#acceptance-null-contract-change) |
| JN-10-1 | 核對案例覆蓋受影響的有值與缺值分類， | [主要驗收](../rules/stacks/java/common/null-and-optional.md#acceptance-java-optional-coverage) |
| JN-10-2 | 測試資料及替身遵守型別契約，未為製造案例而關閉檢查或使用不安全轉型。 | [主要驗收](../rules/stacks/java/common/null-and-optional.md#acceptance-java-optional-coverage) |
| JN-12-1 | 透過實際 API 回應路徑核對 HTTP 狀態與序列化結果，涵蓋契約適用的欄位省略、JSON `null` 與空集合，確認使用端可正確辨識，且未以預設序列化結果取代契約。 | [主要驗收](../rules/interfaces/api-contracts.md#acceptance-api-absence) |

## 驗證方式

執行 `ruby scripts/verify-acceptance.rb`、`ruby scripts/verify-acceptance.rb --batch 3 --baseline 163af59f52ddee97b98ad2ddeac1dc918bde8010` 及 `git diff --check`。重現歷史差異時加上 `--target` 指定本批完成提交；常駐檢查不使用歷史範圍限制。

## 獨立審閱後的重現方式

上文保留當批執行紀錄；舊提交沒有逐句差異與已改寫清單，不能用修正後檢查器回報通過。現行追溯檢查：`ruby scripts/verify-acceptance.rb --batch 3`；基準自本文讀取。常駐檢查預設同時執行五批追溯與全檔保護；`--target` 的全部讀取及統計皆來自指定提交，不混入工作區。精確差異與改寫理由見 [檢查差異清單](acceptance-check-policy.json)、[已改寫片段清單](acceptance-rewritten-fragments.json)及[審閱修正紀錄](review-remediation.md)。

補充引用：null-and-optional.md 共同驗收中的「測試程式碼」連到共通既有整節，沒有對應驗收錨點，也沒有追溯片段；保留為補充引用，不代表 JN-10-2 已移至共通。
