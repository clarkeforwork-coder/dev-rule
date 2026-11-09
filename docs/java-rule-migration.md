# 共通與 Java 規範歸屬調整紀錄

> 後續修正：使用者已同意歷史 ID 留在追溯表，正式規範可重新編號並移除純引用條目。本文記錄前一輪狀態；「原驗收逐字保留」不再是完成標準。第一批去重與分句去向見[驗收整理第一批](acceptance-cleanup-batch-1.md)。

日期：2026-11-06。依使用者已確認的逐條歸屬清單及其後八項範圍確認執行。原清單保留作為來源快照，本文件記錄實際去向；原清單中的「待確認」不再代表目前狀態。

## 已確認範圍

- 物件導向原則按實際設計適用；不強制新增介面、繼承或 Builder。
- 值型別／值物件不可變；Entity 可透過受控業務操作修改。
- 內部及公開空值契約均須評估相容性；可同步使用端同次更新即可。
- 等待期限涵蓋程序內非同步工作；長期服務的個別結果等待與關閉仍有期限。
- API 缺值表示按實際協定適用；HTTP／JSON 不強制套用於其他協定。
- 對外 API／跨模組使用公開契約，模組內依架構傳遞物件，不強制每次轉 DTO。
- 新增 coding 下集合、生命週期、非同步、數值時間文字四份共通文件。
- 第九項必要檢查的合併門檻有效性已確認並寫入；自動檢查九項均已落實。

## 決策去向與驗收

153 條 Java 原條號全部保留。主要規則可改為共通來源，Java 仍保留具體限制、情境與原驗收表。自動檢查另 9 條，合計 162 條。下表的來源文件已更新，原文基準以[原歸屬清單](java-rule-classification.md)所記錄的雜湊及原條號辨識。

| 決策 | 原條目 | 處置 | 現行主要來源 | 語言落實與驗收 |
| --- | --- | --- | --- | --- |
| JV-01 | 分別記錄版本資訊 | 保留 | [分別記錄版本資訊](../rules/stacks/java/common/version-policy.md) | [原第 1 條及驗收表](../rules/stacks/java/common/version-policy.md#驗收要求) |
| JV-02 | 建置設定落實限制 | 保留 | [建置設定落實限制](../rules/stacks/java/common/version-policy.md) | [原第 2 條及驗收表](../rules/stacks/java/common/version-policy.md#驗收要求) |
| JV-03 | 執行版本驗證 | 保留 | [執行版本驗證](../rules/stacks/java/common/version-policy.md) | [原第 3 條及驗收表](../rules/stacks/java/common/version-policy.md#驗收要求) |
| JV-04 | 多模組版本要求 | 保留 | [多模組版本要求](../rules/stacks/java/common/version-policy.md) | [原第 4 條及驗收表](../rules/stacks/java/common/version-policy.md#驗收要求) |
| JV-05 | 依賴版本要求 | 保留 | [依賴版本要求](../rules/stacks/java/common/version-policy.md) | [原第 5 條及驗收表](../rules/stacks/java/common/version-policy.md#驗收要求) |
| JV-06 | 建置升級與支援範圍變更 | 保留 | [建置升級與支援範圍變更](../rules/stacks/java/common/version-policy.md) | [原第 6 條及驗收表](../rules/stacks/java/common/version-policy.md#驗收要求) |
| JV-07 | Preview 功能 | 保留 | [Preview 功能](../rules/stacks/java/common/version-policy.md) | [原第 7 條及驗收表](../rules/stacks/java/common/version-policy.md#驗收要求) |
| JV-08 | JDK 內部實作與存取限制 | 保留 | [JDK 內部實作與存取限制](../rules/stacks/java/common/version-policy.md) | [原第 8 條及驗收表](../rules/stacks/java/common/version-policy.md#驗收要求) |
| JV-09 | 棄用 API | 保留 | [棄用 API](../rules/stacks/java/common/version-policy.md) | [原第 9 條及驗收表](../rules/stacks/java/common/version-policy.md#驗收要求) |
| JV-10 | 建置與驗證工具相容性 | 保留 | [建置與驗證工具相容性](../rules/stacks/java/common/version-policy.md) | [原第 10 條及驗收表](../rules/stacks/java/common/version-policy.md#驗收要求) |
| JV-11 | JDK 發行商與完整版本 | 保留 | [JDK 發行商與完整版本](../rules/stacks/java/common/version-policy.md) | [原第 11 條及驗收表](../rules/stacks/java/common/version-policy.md#驗收要求) |
| JV-12 | 產物與執行環境追溯 | 保留 | [產物與執行環境追溯](../rules/stacks/java/common/version-policy.md) | [原第 12 條及驗收表](../rules/stacks/java/common/version-policy.md#驗收要求) |
| JT-01 | 明確宣告型別 | 保留 | [明確宣告型別](../rules/stacks/java/common/types-and-generics.md) | [原第 1 條及驗收表](../rules/stacks/java/common/types-and-generics.md#驗收要求) |
| JT-02 | 禁止 raw type 與不必要的型別抽象 | 保留 | [禁止 raw type 與不必要的型別抽象](../rules/stacks/java/common/types-and-generics.md) | [原第 2 條及驗收表](../rules/stacks/java/common/types-and-generics.md#驗收要求) |
| JT-03 | 輸入與輸出的型別關聯 | 改引用 | [輸入與輸出的型別關聯](../rules/coding/type-safety.md) | [原第 3 條及驗收表](../rules/stacks/java/common/types-and-generics.md#驗收要求) |
| JT-04 | 不得以向下轉型補回業務型別 | 保留 | [不得以向下轉型補回業務型別](../rules/stacks/java/common/types-and-generics.md) | [原第 4 條及驗收表](../rules/stacks/java/common/types-and-generics.md#驗收要求) |
| JT-05 | 型別安全警告 | 保留 | [型別安全警告](../rules/stacks/java/common/types-and-generics.md) | [原第 5 條及驗收表](../rules/stacks/java/common/types-and-generics.md#驗收要求) |
| JT-06 | 業務資料結構 | 改引用 | [業務資料結構](../rules/coding/type-safety.md) | [原第 6 條及驗收表](../rules/stacks/java/common/types-and-generics.md#驗收要求) |
| JT-07 | 型別能力與約束 | 保留 | [型別能力與約束](../rules/stacks/java/common/types-and-generics.md) | [原第 7 條及驗收表](../rules/stacks/java/common/types-and-generics.md#驗收要求) |
| JT-08 | 集合與映射的宣告型別 | 保留 | [集合與映射的宣告型別](../rules/stacks/java/common/types-and-generics.md) | [原第 8 條及驗收表](../rules/stacks/java/common/types-and-generics.md#驗收要求) |
| JT-09 | 允許建構端使用菱形運算子 | 保留 | [允許建構端使用菱形運算子](../rules/stacks/java/common/types-and-generics.md) | [原第 9 條及驗收表](../rules/stacks/java/common/types-and-generics.md#驗收要求) |
| JT-10 | 泛型回傳值 | 保留 | [泛型回傳值](../rules/stacks/java/common/types-and-generics.md) | [原第 10 條及驗收表](../rules/stacks/java/common/types-and-generics.md#驗收要求) |
| JT-11 | 泛型參數命名 | 保留 | [泛型參數命名](../rules/stacks/java/common/types-and-generics.md) | [原第 11 條及驗收表](../rules/stacks/java/common/types-and-generics.md#驗收要求) |
| JN-01 | 查詢的正常缺值 | 保留 | [查詢的正常缺值](../rules/stacks/java/common/null-and-optional.md#java-query-absence) | [原第 1 條的現行去向](../rules/stacks/java/common/null-and-optional.md#java-query-absence)；[Java 驗收](../rules/stacks/java/common/null-and-optional.md#驗收要求) |
| JN-02 | Optional 本身非空 | 保留 | [Optional 本身非空](../rules/stacks/java/common/null-and-optional.md#java-optional-nonnull) | [原第 2 條的現行去向](../rules/stacks/java/common/null-and-optional.md#java-optional-nonnull)；[Java 驗收](../rules/stacks/java/common/null-and-optional.md#驗收要求) |
| JN-03 | 取值與缺值處置 | 保留 | [取值與缺值處置](../rules/stacks/java/common/null-and-optional.md#java-optional-access) | [原第 3 條的現行去向](../rules/stacks/java/common/null-and-optional.md#java-optional-access)；[Java 驗收](../rules/stacks/java/common/null-and-optional.md#驗收要求) |
| JN-04 | 使用位置與狀態表達 | 保留 | [使用位置與狀態表達](../rules/stacks/java/common/null-and-optional.md#java-optional-positions) | [原第 4 條的現行去向](../rules/stacks/java/common/null-and-optional.md#java-optional-positions)；[Java 驗收](../rules/stacks/java/common/null-and-optional.md#驗收要求) |
| JN-05 | 集合內容的空值 | 保留 | [集合內容的空值](../rules/stacks/java/common/null-and-optional.md#java-container-nulls) | [原第 5 條的現行去向](../rules/stacks/java/common/null-and-optional.md#java-container-nulls)；[Java 驗收](../rules/stacks/java/common/null-and-optional.md#驗收要求) |
| JN-06 | 非空驗證的位置 | 改引用 | [非空驗證的位置](../rules/coding/validation.md) | [原第 6 條的現行去向](../rules/coding/validation.md#責任分工)；[Java 驗收](../rules/stacks/java/common/null-and-optional.md#驗收要求) |
| JN-07 | 工具可辨識的契約 | 保留 | [工具可辨識的契約](../rules/stacks/java/common/null-and-optional.md#java-null-contract-tools) | [原第 7 條的現行去向](../rules/stacks/java/common/null-and-optional.md#java-null-contract-tools)；[Java 驗收](../rules/stacks/java/common/null-and-optional.md#驗收要求) |
| JN-08 | 第三方空值行為 | 提升共通 | [第三方空值行為](../rules/coding/nullability.md#jn-08) | [原第 8 條的現行去向](../rules/stacks/java/common/null-and-optional.md#java-third-party-optional)；[Java 驗收](../rules/stacks/java/common/null-and-optional.md#驗收要求) |
| JN-09 | 空值契約變更 | 提升共通 | [空值契約變更](../rules/coding/nullability.md#jn-09) | [原第 9 條的現行去向](../rules/stacks/java/common/null-and-optional.md#java-null-contract-evolution)；[Java 驗收](../rules/stacks/java/common/null-and-optional.md#驗收要求) |
| JN-10 | 空值情境驗收 | 改引用 | [空值情境驗收](../rules/quality/rule-verification.md) | [原第 10 條的現行去向](../rules/stacks/java/common/null-and-optional.md#驗收要求)；[Java 驗收](../rules/stacks/java/common/null-and-optional.md#驗收要求) |
| JN-11 | 預設非空與明確語意 | 保留 | [預設非空與明確語意](../rules/stacks/java/common/null-and-optional.md#java-nonnull-default) | [原第 11 條的現行去向](../rules/stacks/java/common/null-and-optional.md#java-nonnull-default)；[Java 驗收](../rules/stacks/java/common/null-and-optional.md#驗收要求) |
| JN-12 | API 邊界的缺值轉換 | 提升共通 | [API 邊界的缺值轉換](../rules/interfaces/api-contracts.md#jn-12) | [原第 12 條的現行去向](../rules/stacks/java/common/null-and-optional.md#java-api-absence)；[Java 驗收](../rules/stacks/java/common/null-and-optional.md#驗收要求) |
| VO-01 | 建立專屬型別的條件 | 改引用 | [建立專屬型別的條件](../rules/coding/domain-modeling.md) | [原第 1 條及驗收表](../rules/stacks/java/common/value-objects.md#驗收要求) |
| VO-02 | 建立時保護不變條件 | 改引用 | [建立時保護不變條件](../rules/coding/domain-modeling.md) | [原第 2 條及驗收表](../rules/stacks/java/common/value-objects.md#驗收要求) |
| VO-03 | 不可變性 | 提升共通 | [不可變性](../rules/coding/domain-modeling.md#vo-03) | [原第 3 條及驗收表](../rules/stacks/java/common/value-objects.md#驗收要求) |
| VO-04 | 值相等的條件 | 保留 | [值相等的條件](../rules/stacks/java/common/value-objects.md) | [原第 4 條及驗收表](../rules/stacks/java/common/value-objects.md#驗收要求) |
| VO-05 | 正規化規則 | 提升共通 | [正規化規則](../rules/coding/domain-modeling.md#vo-05) | [原第 5 條及驗收表](../rules/stacks/java/common/value-objects.md#驗收要求) |
| VO-06 | 運算責任 | 提升共通 | [運算責任](../rules/coding/domain-modeling.md#vo-06) | [原第 6 條及驗收表](../rules/stacks/java/common/value-objects.md#驗收要求) |
| VO-07 | 資料還原 | 提升共通 | [資料還原](../rules/coding/domain-modeling.md#vo-07) | [原第 7 條及驗收表](../rules/stacks/java/common/value-objects.md#驗收要求) |
| VO-08 | 一般類別與 record | 保留 | [一般類別與 record](../rules/stacks/java/common/value-objects.md) | [原第 8 條及驗收表](../rules/stacks/java/common/value-objects.md#驗收要求) |
| VO-09 | 診斷字串與交換格式 | 保留 | [診斷字串與交換格式](../rules/stacks/java/common/value-objects.md) | [原第 9 條及驗收表](../rules/stacks/java/common/value-objects.md#驗收要求) |
| VO-10 | 業務保證的測試 | 改引用 | [業務保證的測試](../rules/coding/domain-modeling.md) | [原第 10 條及驗收表](../rules/stacks/java/common/value-objects.md#驗收要求) |
| ST-01 | 明確的狀態型別 | 保留 | [明確的狀態型別](../rules/stacks/java/common/states-and-results.md) | [原第 1 條及驗收表](../rules/stacks/java/common/states-and-results.md#驗收要求) |
| ST-02 | 各狀態的必要資料 | 改引用 | [各狀態的必要資料](../rules/coding/domain-modeling.md) | [原第 2 條及驗收表](../rules/stacks/java/common/states-and-results.md#驗收要求) |
| ST-03 | 業務操作控制轉換 | 改引用 | [業務操作控制轉換](../rules/coding/domain-modeling.md) | [原第 3 條及驗收表](../rules/stacks/java/common/states-and-results.md#驗收要求) |
| ST-04 | 結果與目前狀態分開表達 | 提升共通 | [結果與目前狀態分開表達](../rules/coding/domain-modeling.md#st-04) | [原第 4 條及驗收表](../rules/stacks/java/common/states-and-results.md#驗收要求) |
| ST-05 | 具型別的業務失敗 | 改引用 | [具型別的業務失敗](../rules/coding/error-handling.md) | [原第 5 條及驗收表](../rules/stacks/java/common/states-and-results.md#驗收要求) |
| ST-06 | 處理完整性 | 提升共通 | [處理完整性](../rules/coding/domain-modeling.md#st-06) | [原第 6 條及驗收表](../rules/stacks/java/common/states-and-results.md#驗收要求) |
| ST-07 | 穩定的外部代碼 | 保留 | [穩定的外部代碼](../rules/stacks/java/common/states-and-results.md) | [原第 7 條及驗收表](../rules/stacks/java/common/states-and-results.md#驗收要求) |
| ST-08 | 封閉或允許擴充 | 提升共通 | [封閉或允許擴充](../rules/coding/domain-modeling.md#st-08) | [原第 8 條及驗收表](../rules/stacks/java/common/states-and-results.md#驗收要求) |
| ST-09 | 結果保留當時事實 | 提升共通 | [結果保留當時事實](../rules/coding/domain-modeling.md#st-09) | [原第 9 條及驗收表](../rules/stacks/java/common/states-and-results.md#驗收要求) |
| ST-10 | 模型驗收 | 提升共通 | [模型驗收](../rules/coding/domain-modeling.md#st-10) | [原第 10 條及驗收表](../rules/stacks/java/common/states-and-results.md#驗收要求) |
| BM-01 | 依隔離需求拆分 | 改引用 | [依隔離需求拆分](../rules/architecture/boundary-objects.md) | [原第 1 條及驗收表](../rules/stacks/java/common/boundary-mapping.md#驗收要求) |
| BM-02 | 明確控制欄位及來源 | 改引用 | [明確控制欄位及來源](../rules/architecture/data-mapping.md) | [原第 2 條及驗收表](../rules/stacks/java/common/boundary-mapping.md#驗收要求) |
| BM-03 | 聚焦轉換與必要驗證 | 提升共通 | [聚焦轉換與必要驗證](../rules/architecture/data-mapping.md#bm-03) | [原第 3 條及驗收表](../rules/stacks/java/common/boundary-mapping.md#驗收要求) |
| BM-04 | 失敗明確回報 | 改引用 | [失敗明確回報](../rules/coding/error-handling.md) | [原第 4 條及驗收表](../rules/stacks/java/common/boundary-mapping.md#驗收要求) |
| BM-05 | 保留更新意圖 | 保留 | [保留更新意圖](../rules/stacks/java/common/boundary-mapping.md) | [原第 5 條及驗收表](../rules/stacks/java/common/boundary-mapping.md#驗收要求) |
| BM-06 | 可變參考隔離 | 改引用 | [可變參考隔離](../rules/architecture/boundary-objects.md) | [原第 6 條及驗收表](../rules/stacks/java/common/boundary-mapping.md#驗收要求) |
| BM-07 | 各方向分別定義 | 提升共通 | [各方向分別定義](../rules/architecture/data-mapping.md#bm-07) | [原第 7 條及驗收表](../rules/stacks/java/common/boundary-mapping.md#驗收要求) |
| BM-08 | 明確維護責任 | 改引用 | [明確維護責任](../rules/architecture/data-mapping.md) | [原第 8 條及驗收表](../rules/stacks/java/common/boundary-mapping.md#驗收要求) |
| BM-09 | 驗證實際映射路徑 | 提升共通 | [驗證實際映射路徑](../rules/architecture/data-mapping.md#bm-09) | [原第 9 條及驗收表](../rules/stacks/java/common/boundary-mapping.md#驗收要求) |
| CL-01 | 介面的用途 | 改引用 | [介面的用途](../rules/architecture/dependency-composition.md) | [原第 1 條及驗收表](../rules/stacks/java/common/classes-and-construction.md#驗收要求) |
| CL-02 | 繼承的可替代性 | 提升共通 | [繼承的可替代性](../rules/coding/code-design.md#cl-02) | [原第 2 條及驗收表](../rules/stacks/java/common/classes-and-construction.md#驗收要求) |
| CL-03 | 必要資料與依賴齊備 | 提升共通 | [必要資料與依賴齊備](../rules/coding/resource-lifecycle.md#cl-03) | [原第 3 條及驗收表](../rules/stacks/java/common/classes-and-construction.md#驗收要求) |
| CL-04 | 建構期間的安全性 | 保留 | [建構期間的安全性](../rules/stacks/java/common/classes-and-construction.md) | [原第 4 條及驗收表](../rules/stacks/java/common/classes-and-construction.md#驗收要求) |
| CL-05 | 明確取得依賴 | 提升共通 | [明確取得依賴](../rules/architecture/dependency-composition.md#cl-05) | [原第 5 條及驗收表](../rules/stacks/java/common/classes-and-construction.md#驗收要求) |
| CL-06 | 依需求選擇建立方式 | 提升共通 | [依需求選擇建立方式](../rules/coding/code-design.md#cl-06) | [原第 6 條及驗收表](../rules/stacks/java/common/classes-and-construction.md#驗收要求) |
| CL-07 | 控制繼承與覆寫範圍 | 保留 | [控制繼承與覆寫範圍](../rules/stacks/java/common/classes-and-construction.md) | [原第 7 條及驗收表](../rules/stacks/java/common/classes-and-construction.md#驗收要求) |
| CL-08 | 介面的能力劃分 | 提升共通 | [介面的能力劃分](../rules/coding/code-design.md#cl-08) | [原第 8 條及驗收表](../rules/stacks/java/common/classes-and-construction.md#驗收要求) |
| CL-09 | 生命週期與可變狀態相容 | 提升共通 | [生命週期與可變狀態相容](../rules/coding/resource-lifecycle.md#cl-09) | [原第 9 條及驗收表](../rules/stacks/java/common/classes-and-construction.md#驗收要求) |
| CL-10 | 契約與生命週期驗收 | 提升共通 | [契約與生命週期驗收](../rules/coding/resource-lifecycle.md#cl-10) | [原第 10 條及驗收表](../rules/stacks/java/common/classes-and-construction.md#驗收要求) |
| EQ-01 | 明訂比較語意 | 提升共通 | [明訂比較語意](../rules/coding/domain-modeling.md#eq-01) | [原第 1 條及驗收表](../rules/stacks/java/common/equality-hashing-ordering.md#驗收要求) |
| EQ-02 | 相等與雜湊契約 | 保留 | [相等與雜湊契約](../rules/stacks/java/common/equality-hashing-ordering.md) | [原第 2 條及驗收表](../rules/stacks/java/common/equality-hashing-ordering.md#驗收要求) |
| EQ-03 | 雜湊集合中的穩定性 | 保留 | [雜湊集合中的穩定性](../rules/stacks/java/common/equality-hashing-ordering.md) | [原第 3 條及驗收表](../rules/stacks/java/common/equality-hashing-ordering.md#驗收要求) |
| EQ-04 | Entity 識別碼的生命週期 | 提升共通 | [Entity 識別碼的生命週期](../rules/coding/domain-modeling.md#eq-04) | [原第 4 條及驗收表](../rules/stacks/java/common/equality-hashing-ordering.md#驗收要求) |
| EQ-05 | 跨型別相等範圍 | 保留 | [跨型別相等範圍](../rules/stacks/java/common/equality-hashing-ordering.md) | [原第 5 條及驗收表](../rules/stacks/java/common/equality-hashing-ordering.md#驗收要求) |
| EQ-06 | 自然順序與情境排序 | 保留 | [自然順序與情境排序](../rules/stacks/java/common/equality-hashing-ordering.md) | [原第 6 條及驗收表](../rules/stacks/java/common/equality-hashing-ordering.md#驗收要求) |
| EQ-07 | 比較關係一致 | 保留 | [比較關係一致](../rules/stacks/java/common/equality-hashing-ordering.md) | [原第 7 條及驗收表](../rules/stacks/java/common/equality-hashing-ordering.md#驗收要求) |
| EQ-08 | 比較為零與相等性 | 保留 | [比較為零與相等性](../rules/stacks/java/common/equality-hashing-ordering.md) | [原第 8 條及驗收表](../rules/stacks/java/common/equality-hashing-ordering.md#驗收要求) |
| EQ-09 | 排序集合中的穩定性 | 保留 | [排序集合中的穩定性](../rules/stacks/java/common/equality-hashing-ordering.md) | [原第 9 條及驗收表](../rules/stacks/java/common/equality-hashing-ordering.md#驗收要求) |
| EQ-10 | 關係與集合行為驗收 | 保留 | [關係與集合行為驗收](../rules/stacks/java/common/equality-hashing-ordering.md) | [原第 10 條及驗收表](../rules/stacks/java/common/equality-hashing-ordering.md#驗收要求) |
| CO-01 | 明確定義修改權與參考關係 | 提升共通 | [明確定義修改權與參考關係](../rules/coding/collections-and-ownership.md#co-01) | [原第 1 條及驗收表](../rules/stacks/java/common/collections-and-ownership.md#驗收要求) |
| CO-02 | 區分不可修改與不可變快照 | 提升共通 | [區分不可修改與不可變快照](../rules/coding/collections-and-ownership.md#co-02) | [原第 2 條及驗收表](../rules/stacks/java/common/collections-and-ownership.md#驗收要求) |
| CO-03 | 順序與重複資料 | 提升共通 | [順序與重複資料](../rules/coding/collections-and-ownership.md#co-03) | [原第 3 條及驗收表](../rules/stacks/java/common/collections-and-ownership.md#驗收要求) |
| CO-04 | 遍歷期間的修改 | 提升共通 | [遍歷期間的修改](../rules/coding/collections-and-ownership.md#co-04) | [原第 4 條及驗收表](../rules/stacks/java/common/collections-and-ownership.md#驗收要求) |
| CO-05 | 複合操作的原子性 | 提升共通 | [複合操作的原子性](../rules/coding/concurrency-and-async.md#co-05) | [原第 5 條及驗收表](../rules/stacks/java/common/collections-and-ownership.md#驗收要求) |
| CO-06 | 限制資料累積 | 提升共通 | [限制資料累積](../rules/quality/performance.md#co-06) | [原第 6 條及驗收表](../rules/stacks/java/common/collections-and-ownership.md#驗收要求) |
| CO-07 | 延遲讀取的資源責任 | 提升共通 | [延遲讀取的資源責任](../rules/coding/resource-lifecycle.md#co-07) | [原第 7 條及驗收表](../rules/stacks/java/common/collections-and-ownership.md#驗收要求) |
| CO-08 | 批次修改的失敗保證 | 改引用 | [批次修改的失敗保證](../rules/coding/error-handling.md) | [原第 8 條及驗收表](../rules/stacks/java/common/collections-and-ownership.md#驗收要求) |
| CO-09 | 所有權與行為驗收 | 提升共通 | [所有權與行為驗收](../rules/coding/collections-and-ownership.md#co-09) | [原第 9 條及驗收表](../rules/stacks/java/common/collections-and-ownership.md#驗收要求) |
| EX-01 | 明確的故障分類 | 保留 | [明確的故障分類](../rules/stacks/java/common/exceptions-and-resources.md) | [原第 1 條及驗收表](../rules/stacks/java/common/exceptions-and-resources.md#驗收要求) |
| EX-02 | Checked 與 Unchecked 的選擇 | 保留 | [Checked 與 Unchecked 的選擇](../rules/stacks/java/common/exceptions-and-resources.md) | [原第 2 條及驗收表](../rules/stacks/java/common/exceptions-and-resources.md#驗收要求) |
| EX-03 | 捕捉範圍與處置相符 | 保留 | [捕捉範圍與處置相符](../rules/stacks/java/common/exceptions-and-resources.md) | [原第 3 條及驗收表](../rules/stacks/java/common/exceptions-and-resources.md#驗收要求) |
| EX-04 | 保留中斷意圖 | 保留 | [保留中斷意圖](../rules/stacks/java/common/exceptions-and-resources.md) | [原第 4 條及驗收表](../rules/stacks/java/common/exceptions-and-resources.md#驗收要求) |
| EX-05 | 優先使用語言資源管理機制 | 保留 | [優先使用語言資源管理機制](../rules/stacks/java/common/exceptions-and-resources.md) | [原第 5 條及驗收表](../rules/stacks/java/common/exceptions-and-resources.md#驗收要求) |
| EX-06 | 保留操作與清理失敗 | 保留 | [保留操作與清理失敗](../rules/stacks/java/common/exceptions-and-resources.md) | [原第 6 條及驗收表](../rules/stacks/java/common/exceptions-and-resources.md#驗收要求) |
| EX-07 | 部分取得與所有權移交 | 提升共通 | [部分取得與所有權移交](../rules/coding/resource-lifecycle.md#ex-07) | [原第 7 條及驗收表](../rules/stacks/java/common/exceptions-and-resources.md#驗收要求) |
| EX-08 | 有效期與關閉契約 | 提升共通 | [有效期與關閉契約](../rules/coding/resource-lifecycle.md#ex-08) | [原第 8 條及驗收表](../rules/stacks/java/common/exceptions-and-resources.md#驗收要求) |
| EX-09 | 失敗路徑驗收 | 保留 | [失敗路徑驗收](../rules/stacks/java/common/exceptions-and-resources.md) | [原第 9 條及驗收表](../rules/stacks/java/common/exceptions-and-resources.md#驗收要求) |
| NT-01 | 依語意選擇數值型別 | 提升共通 | [依語意選擇數值型別](../rules/coding/numbers-dates-text.md#nt-01) | [原第 1 條及驗收表](../rules/stacks/java/common/numbers-dates-text.md#驗收要求) |
| NT-02 | 從精確來源建立 | 提升共通 | [從精確來源建立](../rules/coding/numbers-dates-text.md#nt-02) | [原第 2 條及驗收表](../rules/stacks/java/common/numbers-dates-text.md#驗收要求) |
| NT-03 | 明訂捨入規則 | 提升共通 | [明訂捨入規則](../rules/coding/numbers-dates-text.md#nt-03) | [原第 3 條及驗收表](../rules/stacks/java/common/numbers-dates-text.md#驗收要求) |
| NT-04 | 範圍與轉換檢查 | 提升共通 | [範圍與轉換檢查](../rules/coding/numbers-dates-text.md#nt-04) | [原第 4 條及驗收表](../rules/stacks/java/common/numbers-dates-text.md#驗收要求) |
| NT-05 | BigDecimal 判同語意 | 保留 | [BigDecimal 判同語意](../rules/stacks/java/common/numbers-dates-text.md) | [原第 5 條及驗收表](../rules/stacks/java/common/numbers-dates-text.md#驗收要求) |
| NT-06 | 依業務語意選擇時間型別 | 提升共通 | [依業務語意選擇時間型別](../rules/coding/numbers-dates-text.md#nt-06) | [原第 6 條及驗收表](../rules/stacks/java/common/numbers-dates-text.md#驗收要求) |
| NT-07 | 明確的時區轉換 | 提升共通 | [明確的時區轉換](../rules/coding/numbers-dates-text.md#nt-07) | [原第 7 條及驗收表](../rules/stacks/java/common/numbers-dates-text.md#驗收要求) |
| NT-08 | 區分時間長度與日曆規則 | 提升共通 | [區分時間長度與日曆規則](../rules/coding/numbers-dates-text.md#nt-08) | [原第 8 條及驗收表](../rules/stacks/java/common/numbers-dates-text.md#驗收要求) |
| NT-09 | 可控制的時間基準 | 提升共通 | [可控制的時間基準](../rules/coding/numbers-dates-text.md#nt-09) | [原第 9 條及驗收表](../rules/stacks/java/common/numbers-dates-text.md#驗收要求) |
| NT-10 | 解析與輸出契約 | 提升共通 | [解析與輸出契約](../rules/coding/numbers-dates-text.md#nt-10) | [原第 10 條及驗收表](../rules/stacks/java/common/numbers-dates-text.md#驗收要求) |
| NT-11 | 明確指定字元編碼 | 提升共通 | [明確指定字元編碼](../rules/coding/numbers-dates-text.md#nt-11) | [原第 11 條及驗收表](../rules/stacks/java/common/numbers-dates-text.md#驗收要求) |
| NT-12 | 長度與截取單位 | 提升共通 | [長度與截取單位](../rules/coding/numbers-dates-text.md#nt-12) | [原第 12 條及驗收表](../rules/stacks/java/common/numbers-dates-text.md#驗收要求) |
| NT-13 | 用途明確的文字轉換 | 提升共通 | [用途明確的文字轉換](../rules/coding/numbers-dates-text.md#nt-13) | [原第 13 條及驗收表](../rules/stacks/java/common/numbers-dates-text.md#驗收要求) |
| NT-14 | 邊界與環境差異驗收 | 提升共通 | [邊界與環境差異驗收](../rules/coding/numbers-dates-text.md#nt-14) | [原第 14 條及驗收表](../rules/stacks/java/common/numbers-dates-text.md#驗收要求) |
| LS-01 | 意圖與可讀性優先 | 改引用 | [意圖與可讀性優先](../rules/coding/code-design.md) | [原第 1 條及驗收表](../rules/stacks/java/common/lambda-and-stream.md#驗收要求) |
| LS-02 | 明確的參數型別 | 保留 | [明確的參數型別](../rules/stacks/java/common/lambda-and-stream.md) | [原第 2 條及驗收表](../rules/stacks/java/common/lambda-and-stream.md#驗收要求) |
| LS-03 | 中間操作不隱藏業務副作用 | 保留 | [中間操作不隱藏業務副作用](../rules/stacks/java/common/lambda-and-stream.md) | [原第 3 條及驗收表](../rules/stacks/java/common/lambda-and-stream.md#驗收要求) |
| LS-04 | 明確累積結果 | 保留 | [明確累積結果](../rules/stacks/java/common/lambda-and-stream.md) | [原第 4 條及驗收表](../rules/stacks/java/common/lambda-and-stream.md#驗收要求) |
| LS-05 | 延遲與短路範圍 | 保留 | [延遲與短路範圍](../rules/stacks/java/common/lambda-and-stream.md) | [原第 5 條及驗收表](../rules/stacks/java/common/lambda-and-stream.md#驗收要求) |
| LS-06 | 平行處理的採用條件 | 保留 | [平行處理的採用條件](../rules/stacks/java/common/lambda-and-stream.md) | [原第 6 條及驗收表](../rules/stacks/java/common/lambda-and-stream.md#驗收要求) |
| LS-07 | 歸約與收集契約 | 保留 | [歸約與收集契約](../rules/stacks/java/common/lambda-and-stream.md) | [原第 7 條及驗收表](../rules/stacks/java/common/lambda-and-stream.md#驗收要求) |
| LS-08 | 維持錯誤分類 | 保留 | [維持錯誤分類](../rules/stacks/java/common/lambda-and-stream.md) | [原第 8 條及驗收表](../rules/stacks/java/common/lambda-and-stream.md#驗收要求) |
| LS-09 | 明確消費範圍 | 保留 | [明確消費範圍](../rules/stacks/java/common/lambda-and-stream.md) | [原第 9 條及驗收表](../rules/stacks/java/common/lambda-and-stream.md#驗收要求) |
| LS-10 | 執行語意驗收 | 保留 | [執行語意驗收](../rules/stacks/java/common/lambda-and-stream.md) | [原第 10 條及驗收表](../rules/stacks/java/common/lambda-and-stream.md#驗收要求) |
| CA-01 | 明確的工作擁有者 | 提升共通 | [明確的工作擁有者](../rules/coding/concurrency-and-async.md#ca-01) | [原第 1 條及驗收表](../rules/stacks/java/common/concurrency-and-async.md#驗收要求) |
| CA-02 | 統一管理執行資源 | 提升共通 | [統一管理執行資源](../rules/coding/concurrency-and-async.md#ca-02) | [原第 2 條及驗收表](../rules/stacks/java/common/concurrency-and-async.md#驗收要求) |
| CA-03 | 可見性與共享資料 | 保留 | [可見性與共享資料](../rules/stacks/java/common/concurrency-and-async.md) | [原第 3 條及驗收表](../rules/stacks/java/common/concurrency-and-async.md#驗收要求) |
| CA-04 | 等待期限與逾時處置 | 提升共通 | [等待期限與逾時處置](../rules/coding/concurrency-and-async.md#ca-04) | [原第 4 條及驗收表](../rules/stacks/java/common/concurrency-and-async.md#驗收要求) |
| CA-05 | 取消傳遞與實際停止 | 提升共通 | [取消傳遞與實際停止](../rules/coding/concurrency-and-async.md#ca-05) | [原第 5 條及驗收表](../rules/stacks/java/common/concurrency-and-async.md#驗收要求) |
| CA-06 | 結果接收與故障處置 | 保留 | [結果接收與故障處置](../rules/stacks/java/common/concurrency-and-async.md) | [原第 6 條及驗收表](../rules/stacks/java/common/concurrency-and-async.md#驗收要求) |
| CA-07 | 多工作組合的完成條件 | 提升共通 | [多工作組合的完成條件](../rules/coding/concurrency-and-async.md#ca-07) | [原第 7 條及驗收表](../rules/stacks/java/common/concurrency-and-async.md#驗收要求) |
| CA-08 | 執行位置與阻塞行為 | 提升共通 | [執行位置與阻塞行為](../rules/coding/concurrency-and-async.md#ca-08) | [原第 8 條及驗收表](../rules/stacks/java/common/concurrency-and-async.md#驗收要求) |
| CA-09 | 明確傳遞與清理脈絡 | 提升共通 | [明確傳遞與清理脈絡](../rules/coding/concurrency-and-async.md#ca-09) | [原第 9 條及驗收表](../rules/stacks/java/common/concurrency-and-async.md#驗收要求) |
| CA-10 | 鎖定範圍與取得策略 | 提升共通 | [鎖定範圍與取得策略](../rules/coding/concurrency-and-async.md#ca-10) | [原第 10 條及驗收表](../rules/stacks/java/common/concurrency-and-async.md#驗收要求) |
| CA-11 | 受控關閉 | 提升共通 | [受控關閉](../rules/coding/resource-lifecycle.md#ca-11) | [原第 11 條及驗收表](../rules/stacks/java/common/concurrency-and-async.md#驗收要求) |
| CA-12 | 可控制的併發驗收 | 提升共通 | [可控制的併發驗收](../rules/quality/testing.md#ca-12) | [原第 12 條及驗收表](../rules/stacks/java/common/concurrency-and-async.md#驗收要求) |
| RF-01 | 明確需求與型別契約 | 保留 | [明確需求與型別契約](../rules/stacks/java/common/reflection-and-suppression.md) | [原第 1 條及驗收表](../rules/stacks/java/common/reflection-and-suppression.md#驗收要求) |
| RF-02 | 受控目標與授權 | 提升共通 | [受控目標與授權](../rules/quality/security.md#rf-02) | [原第 2 條及驗收表](../rules/stacks/java/common/reflection-and-suppression.md#驗收要求) |
| RF-03 | 維持封裝與不變條件 | 保留 | [維持封裝與不變條件](../rules/stacks/java/common/reflection-and-suppression.md) | [原第 3 條及驗收表](../rules/stacks/java/common/reflection-and-suppression.md#驗收要求) |
| RF-04 | 使用前驗證契約 | 提升共通 | [使用前驗證契約](../rules/coding/type-safety.md#rf-04) | [原第 4 條及驗收表](../rules/stacks/java/common/reflection-and-suppression.md#驗收要求) |
| RF-05 | 區分故障與執行結果 | 提升共通 | [區分故障與執行結果](../rules/coding/error-handling.md#rf-05) | [原第 5 條及驗收表](../rules/stacks/java/common/reflection-and-suppression.md#驗收要求) |
| RF-06 | 限定檢查抑制 | 提升共通 | [限定檢查抑制](../rules/workflow/rule-governance.md#rf-06) | [原第 6 條及驗收表](../rules/stacks/java/common/reflection-and-suppression.md#驗收要求) |
| RF-07 | 產生碼不擴大豁免 | 提升共通 | [產生碼不擴大豁免](../rules/workflow/rule-governance.md#rf-07) | [原第 7 條及驗收表](../rules/stacks/java/common/reflection-and-suppression.md#驗收要求) |
| RF-08 | 驗證限制實際有效 | 提升共通 | [驗證限制實際有效](../rules/quality/rule-verification.md#rf-08) | [原第 8 條及驗收表](../rules/stacks/java/common/reflection-and-suppression.md#驗收要求) |
| ND-01 | 一致的命名形式 | 保留 | [一致的命名形式](../rules/stacks/java/common/naming-packages-docs.md) | [原第 1 條及驗收表](../rules/stacks/java/common/naming-packages-docs.md#驗收要求) |
| ND-02 | 名稱表達具體責任 | 改引用 | [名稱表達具體責任](../rules/coding/naming.md) | [原第 2 條及驗收表](../rules/stacks/java/common/naming-packages-docs.md#驗收要求) |
| ND-03 | 套件與架構邊界 | 保留 | [套件與架構邊界](../rules/stacks/java/common/naming-packages-docs.md) | [原第 3 條及驗收表](../rules/stacks/java/common/naming-packages-docs.md#驗收要求) |
| ND-04 | 補足契約資訊 | 保留 | [補足契約資訊](../rules/stacks/java/common/naming-packages-docs.md) | [原第 4 條及驗收表](../rules/stacks/java/common/naming-packages-docs.md#驗收要求) |
| ND-05 | 實作註解與暫時處理 | 提升共通 | [實作註解與暫時處理](../rules/coding/code-design.md#nd-05) | [原第 5 條及驗收表](../rules/stacks/java/common/naming-packages-docs.md#驗收要求) |
| ND-06 | 重新命名與搬移的影響 | 保留 | [重新命名與搬移的影響](../rules/stacks/java/common/naming-packages-docs.md) | [原第 6 條及驗收表](../rules/stacks/java/common/naming-packages-docs.md#驗收要求) |
| ND-07 | 形式與語意分別驗收 | 提升共通 | [形式與語意分別驗收](../rules/quality/rule-verification.md#nd-07) | [原第 7 條及驗收表](../rules/stacks/java/common/naming-packages-docs.md#驗收要求) |
| AU-01 | 規範與檢查對應 | 共通落實 | [規範與檢查對應](../rules/quality/rule-verification.md#au-01) | 共同條款附驗收；Java 索引引用 |
| AU-02 | 檢查配置可重現 | 共通落實 | [檢查配置可重現](../rules/quality/rule-verification.md#au-02) | 共同條款附驗收；Java 索引引用 |
| AU-03 | 實際執行範圍 | 共通落實 | [實際執行範圍](../rules/quality/rule-verification.md#au-03) | 共同條款附驗收；Java 索引引用 |
| AU-04 | 檢查設定本身的有效性 | 共通落實 | [檢查設定本身的有效性](../rules/quality/rule-verification.md#au-04) | 共同條款附驗收；Java 索引引用 |
| AU-05 | 精確違規基準 | 共通落實 | [精確違規基準](../rules/workflow/rule-governance.md#au-05) | 共同條款附驗收；Java 索引引用 |
| AU-06 | 證據版本與快取有效性 | 共通落實 | [證據版本與快取有效性](../rules/quality/rule-verification.md#au-06) | 共同條款附驗收；Java 索引引用 |
| AU-07 | 自動修正的審查 | 共通落實 | [自動修正的審查](../rules/workflow/git-pr-review.md#au-07) | 共同條款附驗收；Java 索引引用 |
| AU-08 | 結果分類與安全診斷 | 共通落實 | [結果分類與安全診斷](../rules/quality/rule-verification.md#au-08) | 共同條款附驗收；Java 索引引用 |
| AU-09 | 合併門檻實際有效 | 共通落實 | [合併門檻實際有效](../rules/quality/rule-verification.md#au-09) | 共同條款附驗收；Java 索引引用 |

## 核對方法

- 逐條核對 153 個原條號與現行條號一一對應，19 條改引用、65 條共通化、69 條保留語言主要要求。
- Java 15 份原驗收表逐字保留；共通化條目另增加適用的共通驗收，語言具體案例繼續執行。
- 核對所有本地連結、章節與穩定錨點；確認總索引及 Java 索引可到達新主題。
- 本次僅調整規範文件，未執行應用程式測試，也不宣稱任何專案已通過規範驗收。
- 未提交或推送；執行前既有工作區變更保留。

## 本次核對結果

- 15 份 Java 文件的 153 個編號逐一對應，無遺漏或重複；69 條保留項的原條文逐字維持，65 條提升項均有共通錨點及 Java 連結，19 條引用項均連至共同來源。
- 15 份 Java 文件原有 107 列驗收內容逐字保留；共通層新增對應驗收，重複的共通案例合併維護。
- 9 項自動檢查決策均有主要來源及驗收，包括最後確認的合併門檻有效性。
- 57 份 Markdown 文件的 1,255 個本地連結及章節引用檢查通過；四份新增共通文件均已納入索引。
- 已人工核對混合條款的 Java 增量及共通適用範圍，保留原義務與禁止事項；HTTP／JSON 驗收以實際協定為條件，不擴大到其他協定。
- `git diff --check` 通過。本次為文件重整，未以文件檢查取代任何實際軟體專案的行為驗收。
