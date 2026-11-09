# 共通與 Java 規範分離：待確認事項

> 狀態更新：使用者已核准正文整理；以下決策前紀錄保留，最新執行與後續批次範圍見第九節。

日期：2026-11-06。檢視基準：`6a16349`；已完成修正提交 `fffd115b257e304ddc56a33edb1307e5458f7c0a` 與 `fba46eefe55a816735dda26bc69c6711c00d7592`；第三輪修正見修正紀錄。本文件僅提出決策選項，**未執行正文重編、刪除純引用條目、合併文件、提升義務或變更規則錨點**。

依據：[原始分類](java-rule-classification.md)、[第一輪去向](java-rule-migration.md)、[第一批](acceptance-cleanup-batch-1.md)、[第二批](acceptance-cleanup-batch-2.md)、[第三批](acceptance-cleanup-batch-3.md)、[第四批](acceptance-cleanup-batch-4.md)、[第五批](acceptance-cleanup-batch-5.md)及[複核修正](acceptance-cleanup-review.md)。以下 ID 是歷史決策 ID；連結指向現行文件，並明列現行條號。

## 決策順序與證據限制

1. 先處理未列管摘要義務；否則刪除 Java 引用條目可能把摘要誤當已核准的主要規則。
2. 確認 Java 正文格式及小型文件的保留方式，再依下列 84／69 條逐項判斷實施。
3. 決定語意錨點及遷移方式，最後同步更新索引、追溯目的地與檢查。
4. 19 條「改引用」的整理前全文未提交，無法用儲存庫證明完整覆蓋。原分類的摘要與現行驗收可以指出疑點，但不能冒充原全文；不得把「未發現摘要缺口」寫成「證明原義務完整保留」。

檢索範圍涵蓋全部 `rules/**/*.md`，另比對 `718be92` 至 `6f7ae5d` 的共通新增段落，以及 `6a16349` 至現行版本的差異。這能辨識第一輪新增摘要的位置；不代表 `718be92` 保存了遺失的 Java 原文。正文改寫的建議不以有無程式碼標記判定，而是看相較共通要求，是否增加 Java 特有的限制、操作方式或失效情境。

## 一、未列管摘要義務

每列列出兩條決策路徑。「正式提升並補驗收」對已有共通來源的部分，應正式登錄既有來源及驗收，移除摘要中的獨立重述；不新增第二份驗收。只有新增的跨語言保證才需要核准後補規則。下列位置均仍維持原正文，沒有藉本次驗收整理決定其效力。

| 位置／來源 | 尚待釐清的文字與現況 | 選項 A：正式提升並補驗收 | 選項 B：移回 Java | 建議與理由 |
| --- | --- | --- | --- | --- |
| [併發開頭](../rules/coding/concurrency-and-async.md)，CA-03 | 「共享資料須維持可見性」沒有獨立規則錨點；複合原子性已有 co-05，但不能代替可見性交付。 | 明訂各執行模型適用的可見性交付保證，補可見性設計及交付驗收。 | 移除摘要的可見性義務，保留 Java 第 3 條及其驗收。 | 暫選 B；若要 A，先核准適用模型，不能把 volatile／JMM 直接泛化。 |
| [併發共同生命週期](../rules/coding/concurrency-and-async.md#共同生命週期)，CA-06 | 「明訂接收路徑，不得丟棄故障」比 ca-01 的工作擁有者更具體；目前只有 Java 結果鏈驗收。 | 明訂結果接收及未觀察故障的責任，與 ca-01 去重後補驗收。 | 結果接收的增量保留 Java 第 6 條；共通只引用已有所有權／錯誤分類。 | 建議 A，但須獨立核准；常見跨語言需求不等於已獲准。 |
| [領域模型驗證與還原](../rules/coding/domain-modeling.md#模型驗證與還原)，ST-01 | 「不同業務面向應分別建模再明訂相互限制」不是互斥狀態型別的同義句。 | 明訂獨立面向的判準與適用條件，補付款／配送等獨立與相互限制案例。 | 移回 Java 第 1 條，維持目前 Java 驗收。 | 暫選 B；尚未定義何謂應分開的業務面向，不能由例子擴大義務。 |
| [集合跨主題契約](../rules/coding/collections-and-ownership.md#跨主題契約)，CO-08 | 「不得假設拋例外即未修改」未以獨立 ID 登錄；既有全部／部分成功規則只規範結果保證。 | 在錯誤處理正式定義失敗不等於無副作用，沿用部分操作驗收並補例外後實際狀態核對。 | 集合 API 失敗後狀態提醒保留 Java 第 8 條。 | 建議 A，仍需核准；同時保留「不要求全部集合操作具交易能力」的適用邊界。 |
| [映射共同保證](../rules/architecture/data-mapping.md#既有共同保證的落實)，BM-04 | 「不得略過欄位或產生不完整物件掩蓋失敗」沒有自己的列管去向；錯誤處理有停止缺陷與禁止預設值，但未逐字定義半成品映射。 | 把映射完整性正式列入既有轉換要求，補非法外部值、內部缺陷與半成品拒絕驗收。 | 保留 Java 第 4 條的情境及驗收，共通摘要只引用既有錯誤規則。 | 暫選 B；現行 Java 半成品驗收可保住要求，待確認是否正式跨語言化。 |
| [映射共同保證](../rules/architecture/data-mapping.md#既有共同保證的落實)，BM-04／CO-08 | 「部分成功保留各筆結果及來源對應」已有錯誤處理規則，但摘要沒有追溯列。 | 登錄為錯誤處理「多步驟與部分成功」的引用，沿用唯一驗收。 | 移回 Java 映射情境；共同規則不變。 | 建議 A，以引用登錄，不新增義務或複製驗收。 |
| [映射共同保證](../rules/architecture/data-mapping.md#既有共同保證的落實)，BM-05 | 「未提供、清空、設定值」已有空值語意；摘要未列管。 | 登錄為空值語意引用；本階段曾在空值正文新增的驗收句已撤回，原斷言歸入既有映射驗收列。 | 移回 Java null／Optional 的具體表示說明。 | 建議 A 只保留連結，Java 保留表示限制。 |
| [映射共同保證](../rules/architecture/data-mapping.md#既有共同保證的落實)，BM-06 | 隔離、共用不可變值與不強制深層複製分散在邊界、值物件、集合規則，摘要像另一份規則。 | 登錄各保證的主要來源，沿用邊界隔離驗收；明確限定共用值須符合契約。 | 移回 Java 集合複製情境，移除摘要中的獨立義務。 | 建議 A，以既有規則引用收斂；不能把「不強制複製」誤讀成免除隔離。 |
| [映射共同保證](../rules/architecture/data-mapping.md#既有共同保證的落實)，BM-08 | 「簡單方法或專責類別依需求選擇、不強制 Mapper 介面」已有責任配置及介面原則。 | 登錄責任配置／介面用途來源，沿用既有驗收。 | 移回 Java 方法／類別例子。 | 建議 A，只保留引用，避免摘要成為第二個維護位置。 |
| [領域模型驗證與還原](../rules/coding/domain-modeling.md#模型驗證與還原)，VO-10 | 建立、邊界、相等、不可變、運算／還原的覆蓋義務原分類為改引用；摘要比早期共通概括驗證更完整。 | 正式登錄至既有模型驗收範圍；本次將完整覆蓋片段保留 Java，沒有利用該摘要新增共同驗收。 | 保留 Java 第 10 條的語言保證覆蓋，撤除未確認的共通擴寫部分。 | 建議 A，逐一連回已核准的 VO-03／05／06／07，避免以摘要產生額外測試義務。 |
| [領域模型驗證與還原](../rules/coding/domain-modeling.md#模型驗證與還原)，ST-03／VO-02 | 來源狀態、必要條件、轉換後資料，以及存在性／授權由業務元件驗證，已有狀態建模與資料驗證背景。 | 登錄既有來源及目前狀態轉換驗收，不另列摘要義務。 | 移回 Java 轉換與建立情境。 | 建議 A，以引用承接；不把型別有效當成授權成立。 |
| [資源共用元件責任](../rules/coding/resource-lifecycle.md#共用元件的責任)，EX-06／08 | 委派／非同步有效期及同時失敗保留關係、繼續其他安全清理，重述 ex-08 與錯誤處理。 | 登錄既有來源及對應有效期、清理失敗驗收，只保留引用。 | 移回 Java AutoCloseable／suppressed 情境。 | 建議 A；沒有必要重新提升同一要求，但摘要應納入追溯。 |
| [邊界隔離與拆分](../rules/architecture/boundary-objects.md#隔離與拆分)，BM-01 | 「模組內不強制每次轉 DTO、內部彈性不豁免對外公開契約」無獨立 ID，但已在第一輪適用範圍確認。 | 正式登錄既有範圍決策與邊界拆分驗收。 | 移回 Java 範例，仍不得取消已確認的跨語言適用範圍。 | 建議 A；屬未列管的已確認範圍，不是新的待授權義務。 |
| [共通物件導向適用範圍](../rules/coding/code-design.md#物件導向設計的適用範圍)、資源／集合開頭 | 不強制物件導向、DI、Builder、全面複製等摘要，無獨立 ID，但可由既有範圍決策及主條文追溯。 | 登錄為適用條件，連到既有驗收，不另造豁免。 | Java 例子移回語言層；已核准共同範圍仍須在共通保留入口。 | 建議 A；未發現新增義務，但應區分範圍說明與新政策。 |
| [語言與共通主題驗收入口](../rules/quality/rule-verification.md#語言與共通主題驗收入口) | 「尚無語言文件不能豁免共同要求」無單獨 ID；由 rules 索引的共同底線即可承接。 | 登錄索引效力引用，不新增驗收制度。 | Java 頁只保留其入口；共通效力仍依索引。 | 建議 A；這是既有規範效力摘要，不屬需新增的義務。 |

## 二、正文格式與小型文件

已確認的事項不再重問：歷史 ID 留在追溯表；正式文件可以重新編號；沒有 Java 增量的純引用條目可以移除。尚待決定如下。

| 決策 | 選項 | 建議與具體影響 |
| --- | --- | --- |
| Java 條文定位 | 新流水號；或小標題＋語意錨點 | 建議小標題＋語意錨點，與共通檔一致，刪除純引用項時不會讓後續條號全面位移。歷史 ID→現行錨點保存在 docs；每次異動驗證連結。 |
| [集合](../rules/stacks/java/common/collections-and-ownership.md) | 保留；併入型別／Stream；刪除並搬移全部增量 | 建議確認 CO-08 後再決定；若只剩失敗後狀態提醒，可併入例外／資源，所有權共同驗收直接引用。不可先刪掉提醒。 |
| [數值時間文字](../rules/stacks/java/common/numbers-dates-text.md) | 保留；拆入值物件與其他主題；刪除 | 建議暫留。除了 NT-05，現行還有 BigDecimal、java.time 型別、Clock、UTF-16 等實質操作／失效情境；不能只按「原保留條數為一」判斷可刪。可合併相近增量後再評估篇幅。 |
| [併發](../rules/stacks/java/common/concurrency-and-async.md) | 保留；併入例外／資源；刪除 | 建議保留，可見性／volatile 與 Future 結果鏈相互關聯，另有 ThreadLocal／取消機制。即使只有少數小節，也有獨立執行模型。 |
| [邊界映射](../rules/stacks/java/common/boundary-mapping.md) | 保留；併入 null／Optional；刪除 | 建議先解決 BM-04 完整性疑點；若只剩 BM-05，可併入 null／Optional 的更新意圖小節，保留所有原連結與驗收去向。 |

## 三、84 條引用型條文的後附說明

總數為 65 條「提升共通」加 19 條「改引用」。逐條引用現行後附說明；「增量」是相較其共通主規則仍有 Java 操作或失效情境，「混合」需拆除其中共同重述。「驗收入口」不建議保留為獨立正文規則，但必須保留有效驗收及連結。以下全部是建議，尚未刪文。

| 歷史 ID／現行位置 | 現行後附說明 | 判斷 | 依據與建議 |
| --- | --- | --- | --- |
| [JT-03 第 3 條（歷史；現行整條保留）](../rules/stacks/java/common/types-and-generics.md#java-input-output-type-relation)（歷史第 3 條；全部去向：[java-input-output-type-relation](../rules/stacks/java/common/types-and-generics.md#java-input-output-type-relation)） | Java 泛型簽章須實際連結輸入與輸出的型別；特定業務操作直接使用其型別，不要求呼叫端轉型補回。 | 重述 | 泛型關聯、固定物件與明確鍵值型別已在共通型別安全定義；Java 名稱或範例未增加限制，建議移除純引用條目。 共通對照：[型別安全](../rules/coding/type-safety.md)。 |
| [JT-06 第 6 條（歷史；現行整條保留）](../rules/stacks/java/common/types-and-generics.md#java-business-data-shape)（歷史第 6 條；全部去向：[java-business-data-shape](../rules/stacks/java/common/types-and-generics.md#java-business-data-shape)） | 例如固定欄位資料不得改以 `Map<String, Object>` 或 `Object[]` 承載；真正動態的映射仍須保留明確鍵值型別。 | 重述 | 泛型關聯、固定物件與明確鍵值型別已在共通型別安全定義；Java 名稱或範例未增加限制，建議移除純引用條目。 共通對照：[型別安全](../rules/coding/type-safety.md)。 |
| [JN-06 第 6 條](../rules/coding/validation.md#責任分工) | Java 接收、建立及狀態變更位置依上述非空保證驗證；內部可靠契約已成立時不逐層重複檢查。 | 重述 | 接收／建立／變更驗證與可靠內部契約免重複檢查，均由共通責任分工承接。 共通對照：[資料驗證](../rules/coding/validation.md)、[錯誤處理](../rules/coding/error-handling.md)、[領域建模](../rules/coding/domain-modeling.md)。 |
| [JN-08 第 8 條](../rules/stacks/java/common/null-and-optional.md#java-third-party-optional) | 第三方明訂 `null` 是正常查無資料時，才轉成空的 `Optional`；契約不明或違約的 `null` 不得擅自視為正常缺值。 | 增量 | 保留第三方 null 轉 Optional 的具體表示；第三方語意不明不得推測的政策只引用共通。 共通對照：[第三方空值行為的共通要求](../rules/coding/nullability.md#third-party-null-contract)。 |
| [JN-09 第 9 條](../rules/stacks/java/common/null-and-optional.md#java-null-contract-evolution) | Java 空值標註、`Optional` 使用及缺值處置須同步更新，不因 Java 方法簽章未變就視為相容。 | 混合 | 標註與 Optional 同步更新是 Java 落實；簽章不變不代表相容已在共通，刪除重述部分。 共通對照：[空值契約變更的共通要求](../rules/coding/nullability.md#null-contract-evolution)。 |
| [JN-10 第 10 條](../rules/stacks/java/common/null-and-optional.md#驗收要求) | 保留本文件驗收表中的 `Optional`、非空標註及實際 API 路徑案例；不合法資料從允許承接它的邊界輸入。 | 驗收入口 | Optional／非空標註及 API 路徑是現行驗收的索引，無須再設正文義務；保留驗收入口。 共通對照：[規範驗證](../rules/quality/rule-verification.md)、[共通測試策略](../rules/quality/testing.md)、[型別安全](../rules/coding/type-safety.md)。 |
| [JN-12 第 12 條](../rules/stacks/java/common/null-and-optional.md#java-api-absence) | Java 的 `Optional` 與內部 `null` 在 API 邊界轉換；不要求對外暴露 `Optional`。具體序列化配置由 Framework 規範落實，不能用預設輸出代替契約。 | 混合 | Optional／內部 null 的邊界轉換是 Java 表示；不外露包裝型別及不得用框架預設取代契約已共通。 共通對照：[API 邊界的缺值轉換的共通要求](../rules/interfaces/api-contracts.md#api-absence-representation)。 |
| [VO-01 第 1 條（歷史；現行整條移除）](../rules/coding/domain-modeling.md#專屬型別)（歷史第 1 條；全部去向：[專屬型別](../rules/coding/domain-modeling.md#專屬型別)） | Java 的 `OrderId` 與 `CustomerId` 須維持不同業務型別；一般描述性資料不要求機械式包裝。 | 重述 | OrderId／CustomerId 與建構子／工廠只是既有型別隔離、建立有效及授權分離的例子。 共通對照：[領域建模](../rules/coding/domain-modeling.md)。 |
| [VO-02 第 2 條（歷史；現行整條移除）](../rules/coding/domain-modeling.md#專屬型別)（歷史第 2 條；全部去向：[專屬型別](../rules/coding/domain-modeling.md#專屬型別)、[責任分工](../rules/coding/validation.md#責任分工)、[cl-06](../rules/coding/code-design.md#construction-entrypoints)） | Java 建構子或工廠維持一致驗證；合法 `OrderId` 不代表訂單存在或已取得存取權。 | 重述 | OrderId／CustomerId 與建構子／工廠只是既有型別隔離、建立有效及授權分離的例子。 共通對照：[領域建模](../rules/coding/domain-modeling.md)、[資料驗證](../rules/coding/validation.md)。 |
| [VO-03 第 3 條（歷史；現行保留增量）](../rules/stacks/java/common/value-objects.md#java-value-immutability)（歷史第 3 條；全部去向：[java-value-immutability](../rules/stacks/java/common/value-objects.md#java-value-immutability)） | Java 欄位標示 `final` 不代表內容不可變；傳入及取出可變集合或巢狀物件時，須以不可變表示、封裝或必要的防禦性複製維持隔離。 | 增量 | final 只限制欄位重新指定，不能證明被參考內容不可變；保留此 Java 失效情境，隔離政策引用共通。 共通對照：[不可變性的共通要求](../rules/coding/domain-modeling.md#value-immutability)。 |
| [VO-05 第 5 條（歷史；現行整條保留）](../rules/stacks/java/common/value-objects.md#java-value-normalization)（歷史第 5 條；全部去向：[java-value-normalization](../rules/stacks/java/common/value-objects.md#java-value-normalization)） | Java 建構子、工廠及其他建立入口須一致執行正規化，並讓 `equals()` 與 `hashCode()` 反映已定義的值語意。 | 混合 | equals／hashCode 對正規化後值語意的落實保留；所有建立入口一致正規化已共通。 共通對照：[正規化規則的共通要求](../rules/coding/domain-modeling.md#value-normalization)。 |
| [VO-06 第 6 條（歷史；現行拆分）](../rules/stacks/java/common/value-objects.md#java-value-operations)（歷史第 6 條；全部去向：[java-value-operations](../rules/stacks/java/common/value-objects.md#java-value-operations)） | Java 值物件操作保留專屬型別；必要邊界呈現可讀底層值，跨幣別等依賴外部政策的操作由領域元件協調。 | 重述 | 保留專屬型別、邊界讀值與外部政策協調都已在共通運算責任逐項寫明。 共通對照：[運算責任的共通要求](../rules/coding/domain-modeling.md#value-operations)。 |
| [VO-07 第 7 條（歷史；現行拆分）](../rules/stacks/java/common/value-objects.md#java-value-restoration)（歷史第 7 條；全部去向：[java-value-restoration](../rules/stacks/java/common/value-objects.md#java-value-restoration)、[vo-07](../rules/coding/domain-modeling.md#value-restoration)） | Java 建構、反序列化及持久化還原均須維持共同保證；一般類別或 `record` 的實作選擇不得形成驗證旁路。具體框架配置另訂。 | 混合 | record／一般類別的還原不得繞過驗證可留語言實作提醒；還原維持共同保證只是引用。 共通對照：[資料還原的共通要求](../rules/coding/domain-modeling.md#value-restoration)。 |
| [VO-10 第 10 條（歷史；現行整條保留）](../rules/stacks/java/common/value-objects.md#java-value-test-coverage)（歷史第 10 條；全部去向：[java-value-test-coverage](../rules/stacks/java/common/value-objects.md#java-value-test-coverage)） | Java 的 `equals()`、`hashCode()`、`record` 自動產生方法與還原路徑依下方驗收表驗證，不機械式測試每個產生的方法。 | 驗收入口 | equals／hashCode／record 的具體驗收保留；一般依風險選案與不測每個產生方法不另寫政策。 共通對照：[領域建模](../rules/coding/domain-modeling.md)、[共通測試策略](../rules/quality/testing.md)。 |
| [ST-02 第 2 條（歷史；現行整條保留）](../rules/stacks/java/common/states-and-results.md#java-required-state-data)（歷史第 2 條；全部去向：[java-required-state-data](../rules/stacks/java/common/states-and-results.md#java-required-state-data)） | Java 應以對應狀態型別保護必要資料，不只用狀態碼搭配多個可空欄位讓使用端推測。 | 重述 | 必要資料、操作保護、結果區別、失敗型別、完整處理與可變參考隔離已由引用共通逐項涵蓋；setter 或 default 字樣本身沒有新增限制。 共通對照：[領域建模](../rules/coding/domain-modeling.md)。 |
| [ST-03 第 3 條（歷史；現行整條保留）](../rules/stacks/java/common/states-and-results.md#java-business-state-transitions)（歷史第 3 條；全部去向：[java-business-state-transitions](../rules/stacks/java/common/states-and-results.md#java-business-state-transitions)） | Java 公開狀態 setter 不得成為繞過業務操作的入口；修改既有物件或產生新狀態物件由模型決定。 | 重述 | 必要資料、操作保護、結果區別、失敗型別、完整處理與可變參考隔離已由引用共通逐項涵蓋；setter 或 default 字樣本身沒有新增限制。 共通對照：[領域建模](../rules/coding/domain-modeling.md)。 |
| [ST-04 第 4 條（歷史；現行整條移除）](../rules/coding/domain-modeling.md#operation-results)（歷史第 4 條；全部去向：[st-04](../rules/coding/domain-modeling.md#operation-results)） | Java 結果型別只保留使用端需要的區別及資料，不要求每個操作建立複雜物件。 | 重述 | 必要資料、操作保護、結果區別、失敗型別、完整處理與可變參考隔離已由引用共通逐項涵蓋；setter 或 default 字樣本身沒有新增限制。 共通對照：[結果與目前狀態分開表達的共通要求](../rules/coding/domain-modeling.md#operation-results)。 |
| [ST-05 第 5 條（歷史；現行整條保留）](../rules/stacks/java/common/states-and-results.md#java-typed-business-failures)（歷史第 5 條；全部去向：[java-typed-business-failures](../rules/stacks/java/common/states-and-results.md#java-typed-business-failures)） | Java 可用不同失敗型別或具型別原因代碼；技術故障仍透過例外，不為統一格式混入一般業務失敗。 | 重述 | 必要資料、操作保護、結果區別、失敗型別、完整處理與可變參考隔離已由引用共通逐項涵蓋；setter 或 default 字樣本身沒有新增限制。 共通對照：[錯誤處理](../rules/coding/error-handling.md)。 |
| [ST-06 第 6 條（歷史；現行整條移除）](../rules/coding/domain-modeling.md#exhaustive-result-handling)（歷史第 6 條；全部去向：[st-06](../rules/coding/domain-modeling.md#exhaustive-result-handling)） | Java 優先利用適用版本的編譯檢查；工具無法涵蓋的分支由測試及審查補足，不以 `default` 將未知狀態當成功。 | 重述 | 必要資料、操作保護、結果區別、失敗型別、完整處理與可變參考隔離已由引用共通逐項涵蓋；setter 或 default 字樣本身沒有新增限制。 共通對照：[處理完整性的共通要求](../rules/coding/domain-modeling.md#exhaustive-result-handling)。 |
| [ST-08 第 8 條（歷史；現行保留增量）](../rules/stacks/java/common/states-and-results.md#java-model-extensibility)（歷史第 8 條；全部去向：[java-model-extensibility](../rules/stacks/java/common/states-and-results.md#java-model-extensibility)） | 支援 `sealed` 的 Java 版本可用其限制實作；其他版本以可見性、建立入口及檢查維持封閉契約，不強制同一語法。 | 增量 | sealed 的版本能力與其他版本採可見性／建立入口控制，是具體 Java 落實方式，保留。 共通對照：[封閉或允許擴充的共通要求](../rules/coding/domain-modeling.md#model-extensibility)。 |
| [ST-09 第 9 條（歷史；現行整條移除）](../rules/coding/domain-modeling.md#result-facts)（歷史第 9 條；全部去向：[st-09](../rules/coding/domain-modeling.md#result-facts)） | Java 結果不可持有會改變已確認事實的可變業務參考；只隔離必要資料，不要求複製完整物件。 | 重述 | 必要資料、操作保護、結果區別、失敗型別、完整處理與可變參考隔離已由引用共通逐項涵蓋；setter 或 default 字樣本身沒有新增限制。 共通對照：[結果保留當時事實的共通要求](../rules/coding/domain-modeling.md#result-facts)。 |
| [ST-10 第 10 條（歷史；現行整條保留）](../rules/stacks/java/common/states-and-results.md#java-model-acceptance)（歷史第 10 條；全部去向：[java-model-acceptance](../rules/stacks/java/common/states-and-results.md#java-model-acceptance)） | Java 狀態型別、使用端分支、`enum` 外部代碼及封閉模型依下方表格驗收，並核對實際副作用。 | 驗收入口 | enum 外部代碼及封閉模型的驗收可直接引用本文件有效驗收，移除純覆蓋宣告。 共通對照：[模型驗收的共通要求](../rules/coding/domain-modeling.md#model-verification)。 |
| [BM-01 第 1 條（歷史；現行整條移除）](../rules/architecture/boundary-objects.md#隔離與拆分)（歷史第 1 條；全部去向：[隔離與拆分](../rules/architecture/boundary-objects.md#隔離與拆分)） | Java 模組內的物件傳遞依架構決議處理，不強制每次呼叫轉 DTO；對外 API 及跨模組仍使用公開資料契約。 | 重述 | 邊界範圍、允許欄位、協調責任、淺複製、反向映射及實際工具路徑均已在共通；未指定 Java 特有 API 或額外失效條件。 共通對照：[邊界物件](../rules/architecture/boundary-objects.md)。 |
| [BM-02 第 2 條（歷史；現行整條保留）](../rules/stacks/java/common/boundary-mapping.md#java-mapping-fields)（歷史第 2 條；全部去向：[java-mapping-fields](../rules/stacks/java/common/boundary-mapping.md#java-mapping-fields)） | Java 映射工具不得因同名或來源新增欄位而擴大傳遞範圍；租戶與建立者等可信欄位仍依伺服器契約取得。 | 重述 | 邊界範圍、允許欄位、協調責任、淺複製、反向映射及實際工具路徑均已在共通；未指定 Java 特有 API 或額外失效條件。 共通對照：[資料映射](../rules/architecture/data-mapping.md)、[API 操作語意與介面設計](../rules/interfaces/api-contracts.md)、[安全](../rules/quality/security.md)。 |
| [BM-03 第 3 條（歷史；現行整條移除）](../rules/architecture/data-mapping.md#mapping-responsibility)（歷史第 3 條；全部去向：[bm-03](../rules/architecture/data-mapping.md#mapping-responsibility)） | Java 映射可解析格式及建立專屬型別；需要補查資料時，由負責流程的元件先協調。 | 重述 | 邊界範圍、允許欄位、協調責任、淺複製、反向映射及實際工具路徑均已在共通；未指定 Java 特有 API 或額外失效條件。 共通對照：[聚焦轉換與必要驗證的共通要求](../rules/architecture/data-mapping.md#mapping-responsibility)。 |
| [BM-04 第 4 條（歷史；現行整條保留）](../rules/stacks/java/common/boundary-mapping.md#java-mapping-integrity)（歷史第 4 條；全部去向：[java-mapping-integrity](../rules/stacks/java/common/boundary-mapping.md#java-mapping-integrity)） | 依下方 Java 實際映射路徑驗收拒絕、缺陷與部分成功，不以建立了目標型別就視為有效。 | 待確認 | 目前一句引用沒有完整承載半成品／內部缺陷的具體映射說明；保留 Java 情境驗收，先決定摘要義務歸屬。 共通對照：[錯誤處理](../rules/coding/error-handling.md)、[資料驗證](../rules/coding/validation.md)、[資料映射](../rules/architecture/data-mapping.md)。 |
| [BM-06 第 6 條（歷史；現行整條保留）](../rules/stacks/java/common/boundary-mapping.md#java-mutable-isolation)（歷史第 6 條；全部去向：[java-mutable-isolation](../rules/stacks/java/common/boundary-mapping.md#java-mutable-isolation)） | Java 複製集合外層不一定隔離可變元素；符合契約的不可變值可共用，不要求全面深層複製。 | 重述 | 邊界範圍、允許欄位、協調責任、淺複製、反向映射及實際工具路徑均已在共通；未指定 Java 特有 API 或額外失效條件。 共通對照：[邊界物件](../rules/architecture/boundary-objects.md)、[程式碼設計與公開介面](../rules/coding/code-design.md)。 |
| [BM-07 第 7 條（歷史；現行整條保留）](../rules/stacks/java/common/boundary-mapping.md#java-directional-mapping)（歷史第 7 條；全部去向：[java-directional-mapping](../rules/stacks/java/common/boundary-mapping.md#java-directional-mapping)） | Java 映射工具支援反向產生不代表可直接採用；具體工具配置另由 Framework 規範落實。 | 重述 | 邊界範圍、允許欄位、協調責任、淺複製、反向映射及實際工具路徑均已在共通；未指定 Java 特有 API 或額外失效條件。 共通對照：[各方向分別定義的共通要求](../rules/architecture/data-mapping.md#directional-mapping)。 |
| [BM-08 第 8 條（歷史；現行整條保留）](../rules/stacks/java/common/boundary-mapping.md#java-mapping-ownership)（歷史第 8 條；全部去向：[java-mapping-ownership](../rules/stacks/java/common/boundary-mapping.md#java-mapping-ownership)） | Java 簡單映射可使用方法，有實際責任或共用需求才建立專責類別，不強制 Mapper 介面或包裝層。 | 重述 | 邊界範圍、允許欄位、協調責任、淺複製、反向映射及實際工具路徑均已在共通；未指定 Java 特有 API 或額外失效條件。 共通對照：[資料映射](../rules/architecture/data-mapping.md)、[共用能力](../rules/architecture/shared-capabilities.md)、[框架與依賴組裝](../rules/architecture/dependency-composition.md)。 |
| [BM-09 第 9 條（歷史；現行整條保留）](../rules/stacks/java/common/boundary-mapping.md#java-mapping-verification)（歷史第 9 條；全部去向：[java-mapping-verification](../rules/stacks/java/common/boundary-mapping.md#java-mapping-verification)） | Java 測試須經實際映射及適用的序列化／反序列化路徑，不能只測手寫替代版本。 | 重述 | 邊界範圍、允許欄位、協調責任、淺複製、反向映射及實際工具路徑均已在共通；未指定 Java 特有 API 或額外失效條件。 共通對照：[驗證實際映射路徑的共通要求](../rules/architecture/data-mapping.md#mapping-path-verification)。 |
| [CL-01 第 1 條（歷史；現行整條保留）](../rules/stacks/java/common/classes-and-construction.md#java-interface-purpose)（歷史第 1 條；全部去向：[java-interface-purpose](../rules/stacks/java/common/classes-and-construction.md#java-interface-purpose)） | Java 可依契約依賴介面或具體類別；單一實作不構成省略必要架構隔離的理由。 | 重述 | 介面、替代契約、就緒、依賴、Builder 有效性、能力、生命週期與實際框架路徑均已在共通；build、實例欄位或代理名詞未額外限制 Java。 共通對照：[框架與依賴組裝](../rules/architecture/dependency-composition.md)、[模組責任與公開入口](../rules/architecture/module-boundaries.md)。 |
| [CL-02 第 2 條（歷史；現行整條移除）](../rules/coding/code-design.md#substitutability)（歷史第 2 條；全部去向：[cl-02](../rules/coding/code-design.md#substitutability)） | Java 子類別須維持父型別輸入、結果及行為保證；僅共用實作時優先組合或委派。 | 重述 | 介面、替代契約、就緒、依賴、Builder 有效性、能力、生命週期與實際框架路徑均已在共通；build、實例欄位或代理名詞未額外限制 Java。 共通對照：[繼承的可替代性的共通要求](../rules/coding/code-design.md#substitutability)。 |
| [CL-03 第 3 條（歷史；現行整條移除）](../rules/coding/resource-lifecycle.md#initialization-readiness)（歷史第 3 條；全部去向：[cl-03](../rules/coding/resource-lifecycle.md#initialization-readiness)） | Java 建構完成須具備必要資料與依賴；外部連線或背景工作不必放在建構子，依明確生命週期啟動。 | 重述 | 介面、替代契約、就緒、依賴、Builder 有效性、能力、生命週期與實際框架路徑均已在共通；build、實例欄位或代理名詞未額外限制 Java。 共通對照：[必要資料與依賴齊備的共通要求](../rules/coding/resource-lifecycle.md#initialization-readiness)。 |
| [CL-05 第 5 條（歷史；現行整條保留）](../rules/stacks/java/common/classes-and-construction.md#java-explicit-dependencies)（歷史第 5 條；全部去向：[java-explicit-dependencies](../rules/stacks/java/common/classes-and-construction.md#java-explicit-dependencies)） | Java 服務透過明確依賴取得；需要延後或按次建立時使用工廠或提供者，不隱藏查全域容器、靜態服務登錄或單例。 | 重述 | 介面、替代契約、就緒、依賴、Builder 有效性、能力、生命週期與實際框架路徑均已在共通；build、實例欄位或代理名詞未額外限制 Java。 共通對照：[明確取得依賴的共通要求](../rules/architecture/dependency-composition.md#explicit-dependencies)。 |
| [CL-06 第 6 條（歷史；現行整條移除）](../rules/coding/code-design.md#construction-entrypoints)（歷史第 6 條；全部去向：[cl-06](../rules/coding/code-design.md#construction-entrypoints)） | Java 可選建構子、具名工廠或 Builder；Builder 可暫存組裝中資料，但 `build` 不得產出無效物件。 | 重述 | 介面、替代契約、就緒、依賴、Builder 有效性、能力、生命週期與實際框架路徑均已在共通；build、實例欄位或代理名詞未額外限制 Java。 共通對照：[依需求選擇建立方式的共通要求](../rules/coding/code-design.md#construction-entrypoints)。 |
| [CL-08 第 8 條（歷史；現行整條移除）](../rules/coding/code-design.md#interface-capabilities)（歷史第 8 條；全部去向：[cl-08](../rules/coding/code-design.md#interface-capabilities)） | Java 介面不機械式拆成單一方法；同一責任的操作可共用契約，執行時授權仍須另外檢查。 | 重述 | 介面、替代契約、就緒、依賴、Builder 有效性、能力、生命週期與實際框架路徑均已在共通；build、實例欄位或代理名詞未額外限制 Java。 共通對照：[介面的能力劃分的共通要求](../rules/coding/code-design.md#interface-capabilities)。 |
| [CL-09 第 9 條（歷史；現行整條移除）](../rules/coding/resource-lifecycle.md#shared-lifecycle)（歷史第 9 條；全部去向：[cl-09](../rules/coding/resource-lifecycle.md#shared-lifecycle)） | Java 共用服務的實例欄位不得存放會跨操作互相覆蓋的使用者或訂單；框架注入不代表執行緒安全或生命週期正確。 | 重述 | 介面、替代契約、就緒、依賴、Builder 有效性、能力、生命週期與實際框架路徑均已在共通；build、實例欄位或代理名詞未額外限制 Java。 共通對照：[生命週期與可變狀態相容的共通要求](../rules/coding/resource-lifecycle.md#shared-lifecycle)。 |
| [CL-10 第 10 條（歷史；現行整條保留）](../rules/stacks/java/common/classes-and-construction.md#java-lifecycle-verification)（歷史第 10 條；全部去向：[java-lifecycle-verification](../rules/stacks/java/common/classes-and-construction.md#java-lifecycle-verification)） | Java 建構、繼承、覆寫及框架代理須驗證實際路徑；單純值物件不必啟動完整框架。 | 重述 | 介面、替代契約、就緒、依賴、Builder 有效性、能力、生命週期與實際框架路徑均已在共通；build、實例欄位或代理名詞未額外限制 Java。 共通對照：[契約與生命週期驗收的共通要求](../rules/coding/resource-lifecycle.md#lifecycle-verification)。 |
| [EQ-01 第 1 條（歷史；現行保留增量）](../rules/stacks/java/common/equality-hashing-ordering.md#java-comparison-semantics)（歷史第 1 條；全部去向：[java-comparison-semantics](../rules/stacks/java/common/equality-hashing-ordering.md#java-comparison-semantics)） | Java `equals()` 須落實選定比較語意，不任意將 Entity 所有欄位納入比較。 | 增量 | 把既定比較語意落實於 Java equals，保留方法契約銜接；Entity 全欄位比較禁令只引用共通。 共通對照：[明訂比較語意的共通要求](../rules/coding/domain-modeling.md#identity-semantics)。 |
| [EQ-04 第 4 條（歷史；現行整條保留）](../rules/stacks/java/common/equality-hashing-ordering.md#java-entity-identity-lifecycle)（歷史第 4 條；全部去向：[java-entity-identity-lifecycle](../rules/stacks/java/common/equality-hashing-ordering.md#java-entity-identity-lifecycle)） | Java 沒有跨實例相等需求時不強制覆寫 `equals()`；識別碼變化不得破壞雜湊或排序集合契約。 | 混合 | 無跨實例比較時不覆寫 equals 是 Java 操作方式；識別碼變化不得破壞集合契約已共通。 共通對照：[Entity 識別碼的生命週期的共通要求](../rules/coding/domain-modeling.md#identity-lifecycle)。 |
| [CO-01 第 1 條（歷史；現行整條保留）](../rules/stacks/java/common/collections-and-ownership.md#java-collection-ownership)（歷史第 1 條；全部去向：[java-collection-ownership](../rules/stacks/java/common/collections-and-ownership.md#java-collection-ownership)） | Java 集合介面本身不能取代所有權契約；接收或回傳集合時須涵蓋可變元素及參考保留行為。 | 重述 | 共通已明訂集合介面／包裝不保證所有權或快照、轉換順序、支援的遍歷操作、複合原子性、延遲累積與資源責任；現行附句未增加 Java API 細節。 共通對照：[明確定義修改權與參考關係的共通要求](../rules/coding/collections-and-ownership.md#collection-ownership)。 |
| [CO-02 第 2 條（歷史；現行整條保留）](../rules/stacks/java/common/collections-and-ownership.md#java-snapshots-and-views)（歷史第 2 條；全部去向：[java-snapshots-and-views](../rules/stacks/java/common/collections-and-ownership.md#java-snapshots-and-views)） | Java 不可修改包裝可能仍是來源的檢視；外層複製可能保留相同可變元素，須驗證實際隔離。 | 重述 | 共通已明訂集合介面／包裝不保證所有權或快照、轉換順序、支援的遍歷操作、複合原子性、延遲累積與資源責任；現行附句未增加 Java API 細節。 共通對照：[區分不可修改與不可變快照的共通要求](../rules/coding/collections-and-ownership.md#snapshots-and-views)。 |
| [CO-03 第 3 條（歷史；現行整條移除）](../rules/coding/collections-and-ownership.md#order-and-duplicates)（歷史第 3 條；全部去向：[co-03](../rules/coding/collections-and-ownership.md#order-and-duplicates)） | Java 選用或轉換 List、Set、Map 時須維持約定順序、重複元素與重複鍵處理，不意外去重或覆蓋。 | 重述 | 共通已明訂集合介面／包裝不保證所有權或快照、轉換順序、支援的遍歷操作、複合原子性、延遲累積與資源責任；現行附句未增加 Java API 細節。 共通對照：[順序與重複資料的共通要求](../rules/coding/collections-and-ownership.md#order-and-duplicates)。 |
| [CO-04 第 4 條（歷史；現行整條移除）](../rules/coding/collections-and-ownership.md#traversal-mutation)（歷史第 4 條；全部去向：[co-04](../rules/coding/collections-and-ownership.md#traversal-mutation)） | Java 遍歷修改須使用集合支援的操作；未拋出遍歷修改例外不代表安全，也不得捕捉後直接重跑。 | 重述 | 共通已明訂集合介面／包裝不保證所有權或快照、轉換順序、支援的遍歷操作、複合原子性、延遲累積與資源責任；現行附句未增加 Java API 細節。 共通對照：[遍歷期間的修改的共通要求](../rules/coding/collections-and-ownership.md#traversal-mutation)。 |
| [CO-05 第 5 條（歷史；現行整條移除）](../rules/coding/concurrency-and-async.md#compound-atomicity)（歷史第 5 條；全部去向：[co-05](../rules/coding/concurrency-and-async.md#compound-atomicity)） | Java concurrent collection 的單一操作保證不能推導為多步驟或跨鍵操作原子性。 | 重述 | 共通已明訂集合介面／包裝不保證所有權或快照、轉換順序、支援的遍歷操作、複合原子性、延遲累積與資源責任；現行附句未增加 Java API 細節。 共通對照：[複合操作的原子性的共通要求](../rules/coding/concurrency-and-async.md#compound-atomicity)。 |
| [CO-06 第 6 條（歷史；現行整條移除）](../rules/quality/performance.md#bounded-accumulation)（歷史第 6 條；全部去向：[co-06](../rules/quality/performance.md#bounded-accumulation)） | Java Iterator 或 Stream 不保證實際有界；排序、去重及分組的保留資料成本仍須核對。 | 重述 | 共通已明訂集合介面／包裝不保證所有權或快照、轉換順序、支援的遍歷操作、複合原子性、延遲累積與資源責任；現行附句未增加 Java API 細節。 共通對照：[限制資料累積的共通要求](../rules/quality/performance.md#bounded-accumulation)。 |
| [CO-07 第 7 條（歷史；現行整條保留）](../rules/stacks/java/common/collections-and-ownership.md#java-lazy-resource-lifetime)（歷史第 7 條；全部去向：[java-lazy-resource-lifetime](../rules/stacks/java/common/collections-and-ownership.md#java-lazy-resource-lifetime)） | Java 資源型 Iterator／Stream 須明確有效期及關閉責任；必要時在資源範圍內產生受控結果，關閉方式依例外與資源管理。 | 重述 | 共通已明訂集合介面／包裝不保證所有權或快照、轉換順序、支援的遍歷操作、複合原子性、延遲累積與資源責任；現行附句未增加 Java API 細節。 共通對照：[延遲讀取的資源責任的共通要求](../rules/coding/resource-lifecycle.md#lazy-resource-lifetime)。 |
| [CO-08 第 8 條（歷史；現行整條保留）](../rules/stacks/java/common/collections-and-ownership.md#java-batch-failure-state)（歷史第 8 條；全部去向：[java-batch-failure-state](../rules/stacks/java/common/collections-and-ownership.md#java-batch-failure-state)） | Java 批次集合方法拋出例外不代表未修改；不要求所有集合操作具有交易能力，須核對約定的失敗後狀態。 | 待確認 | 拋例外不代表未修改是原摘要中的未列管義務；不可只因已寫入共通摘要便刪去 Java 提醒。 共通對照：[錯誤處理](../rules/coding/error-handling.md)。 |
| [CO-09 第 9 條（歷史；現行整條保留）](../rules/stacks/java/common/collections-and-ownership.md#java-collection-verification)（歷史第 9 條；全部去向：[java-collection-verification](../rules/stacks/java/common/collections-and-ownership.md#java-collection-verification)） | Java 集合的實際修改、遍歷、檢視及資源路徑依下方驗收，不重測標準函式庫本身。 | 重述 | 共通已明訂集合介面／包裝不保證所有權或快照、轉換順序、支援的遍歷操作、複合原子性、延遲累積與資源責任；現行附句未增加 Java API 細節。 共通對照：[所有權與行為驗收的共通要求](../rules/coding/collections-and-ownership.md#collection-verification)。 |
| [EX-07 第 7 條（歷史；現行整條移除）](../rules/coding/resource-lifecycle.md#partial-acquisition)（歷史第 7 條；全部去向：[ex-07](../rules/coding/resource-lifecycle.md#partial-acquisition)） | Java 多資源取得及建構失敗亦須清理；資源移交前仍由取得方負責，釋放順序遵循依賴。 | 重述 | 多資源取得、建構失敗、正式移交前責任與依賴順序已由共通完整涵蓋。 共通對照：[部分取得與所有權移交的共通要求](../rules/coding/resource-lifecycle.md#partial-acquisition)。 |
| [EX-08 第 8 條（歷史；現行整條移除）](../rules/coding/resource-lifecycle.md#resource-close-contract)（歷史第 8 條；全部去向：[ex-08](../rules/coding/resource-lifecycle.md#resource-close-contract)） | Java `AutoCloseable` 資源不可在非同步工作仍使用時提前關閉，不無依據假設所有 `close()` 都可重複呼叫。 | 重述 | 共通 ex-08 已禁止提前關閉與無依據假設重複關閉；AutoCloseable／close 名稱沒有額外限制。 共通對照：[有效期與關閉契約的共通要求](../rules/coding/resource-lifecycle.md#resource-close-contract)。 |
| [NT-01 第 1 條（歷史；現行保留增量）](../rules/stacks/java/common/numbers-dates-text.md#java-numeric-representation)（歷史第 1 條；全部去向：[java-numeric-representation](../rules/stacks/java/common/numbers-dates-text.md#java-numeric-representation)） | Java 精確十進位語意使用 `BigDecimal` 或契約允許的最小單位整數，不以二進位浮點數作精確表示。 | 增量 | BigDecimal／最小單位整數的選擇與浮點轉 BigDecimal 無法復原，是 Java 標準型別落實。 共通對照：[依語意選擇數值型別的共通要求](../rules/coding/numbers-dates-text.md#numeric-representation)。 |
| [NT-02 第 2 條（歷史；現行保留增量）](../rules/stacks/java/common/numbers-dates-text.md#java-exact-numeric-sources)（歷史第 2 條；全部去向：[java-exact-numeric-sources](../rules/stacks/java/common/numbers-dates-text.md#java-exact-numeric-sources)） | Java 精確值不可先轉浮點數再轉 `BigDecimal` 期待還原；直接從契約允許的精確來源建立後仍須驗證業務限制。 | 增量 | BigDecimal／最小單位整數的選擇與浮點轉 BigDecimal 無法復原，是 Java 標準型別落實。 共通對照：[從精確來源建立的共通要求](../rules/coding/numbers-dates-text.md#exact-numeric-sources)。 |
| [NT-03 第 3 條（歷史；現行整條保留）](../rules/stacks/java/common/numbers-dates-text.md#java-rounding-policy)（歷史第 3 條；全部去向：[java-rounding-policy](../rules/stacks/java/common/numbers-dates-text.md#java-rounding-policy)） | Java 數值運算依契約指定精度、捨入模式及時機，不能讓 API 預設或各呼叫端自行決定。 | 重述 | 精度捨入、地區／時區、完整解析及字元編碼皆重述共通；僅加上 Java 或 API 字樣不構成增量。 共通對照：[明訂捨入規則的共通要求](../rules/coding/numbers-dates-text.md#rounding-policy)。 |
| [NT-04 第 4 條（歷史；現行整條移除）](../rules/coding/numbers-dates-text.md#numeric-range-checks)（歷史第 4 條；全部去向：[nt-04](../rules/coding/numbers-dates-text.md#numeric-range-checks)） | Java 縮窄轉型、整數溢位回繞與小數捨棄須明確檢查，不能用強制轉型掩蓋超限。 | 重述 | 共通 nt-04 已明列溢位回繞、縮小範圍及強制轉型；現行附句沒有額外 Java 限制。 共通對照：[範圍與轉換檢查的共通要求](../rules/coding/numbers-dates-text.md#numeric-range-checks)。 |
| [NT-06 第 6 條（歷史；現行保留增量）](../rules/stacks/java/common/numbers-dates-text.md#java-temporal-representation)（歷史第 6 條；全部去向：[java-temporal-representation](../rules/stacks/java/common/numbers-dates-text.md#java-temporal-representation)） | Java 優先使用 `java.time`：日期可用 `LocalDate`，確切時點可用 `Instant`；不得以 `LocalDateTime` 冒充唯一時點，必要時保留時區或偏移。 | 增量 | java.time 型別選擇、Duration／Period、Clock 與 String.length 的 UTF-16 單位，增加具體 Java 操作方式或失效情境。 共通對照：[依業務語意選擇時間型別的共通要求](../rules/coding/numbers-dates-text.md#temporal-representation)。 |
| [NT-07 第 7 條（歷史；現行整條移除）](../rules/coding/numbers-dates-text.md#timezone-conversion)（歷史第 7 條；全部去向：[nt-07](../rules/coding/numbers-dates-text.md#timezone-conversion)） | Java 時區轉換須明確指定契約時區或偏移，不讓函式庫預設決定不存在或重複當地時間的業務處置。 | 重述 | 精度捨入、地區／時區、完整解析及字元編碼皆重述共通；僅加上 Java 或 API 字樣不構成增量。 共通對照：[明確的時區轉換的共通要求](../rules/coding/numbers-dates-text.md#timezone-conversion)。 |
| [NT-08 第 8 條（歷史；現行保留增量）](../rules/stacks/java/common/numbers-dates-text.md#java-durations-calendar-periods)（歷史第 8 條；全部去向：[java-durations-calendar-periods](../rules/stacks/java/common/numbers-dates-text.md#java-durations-calendar-periods)） | Java 按語意使用 `Duration`、`Period` 或業務計算，不假設一般日曆間隔包含營業日規則。 | 增量 | java.time 型別選擇、Duration／Period、Clock 與 String.length 的 UTF-16 單位，增加具體 Java 操作方式或失效情境。 共通對照：[區分時間長度與日曆規則的共通要求](../rules/coding/numbers-dates-text.md#durations-and-calendar-periods)。 |
| [NT-09 第 9 條（歷史；現行保留增量）](../rules/stacks/java/common/numbers-dates-text.md#java-clock-source)（歷史第 9 條；全部去向：[java-clock-source](../rules/stacks/java/common/numbers-dates-text.md#java-clock-source)） | Java 業務目前時間優先由明確提供的 `Clock` 取得；耗時及等待期限使用適合的單調時間來源。 | 增量 | java.time 型別選擇、Duration／Period、Clock 與 String.length 的 UTF-16 單位，增加具體 Java 操作方式或失效情境。 共通對照：[可控制的時間基準的共通要求](../rules/coding/numbers-dates-text.md#time-source)。 |
| [NT-10 第 10 條（歷史；現行整條保留）](../rules/stacks/java/common/numbers-dates-text.md#java-temporal-parsing-formatting)（歷史第 10 條；全部去向：[java-temporal-parsing-formatting](../rules/stacks/java/common/numbers-dates-text.md#java-temporal-parsing-formatting)） | Java 解析及格式化須明訂格式、地區、時區／偏移及精度，不允許寬鬆修正非法日期或只解析前段。 | 重述 | 精度捨入、地區／時區、完整解析及字元編碼皆重述共通；僅加上 Java 或 API 字樣不構成增量。 共通對照：[解析與輸出契約的共通要求](../rules/coding/numbers-dates-text.md#temporal-parsing-formatting)。 |
| [NT-11 第 11 條（歷史；現行整條移除）](../rules/coding/numbers-dates-text.md#character-encoding)（歷史第 11 條；全部去向：[nt-11](../rules/coding/numbers-dates-text.md#character-encoding)） | Java 文字與位元組轉換明確指定字元編碼；不得靠系統預設或未授權替換掩蓋資料損失。 | 重述 | 精度捨入、地區／時區、完整解析及字元編碼皆重述共通；僅加上 Java 或 API 字樣不構成增量。 共通對照：[明確指定字元編碼的共通要求](../rules/coding/numbers-dates-text.md#character-encoding)。 |
| [NT-12 第 12 條（歷史；現行保留增量）](../rules/stacks/java/common/numbers-dates-text.md#java-text-length-units)（歷史第 12 條；全部去向：[java-text-length-units](../rules/stacks/java/common/numbers-dates-text.md#java-text-length-units)） | Java `String.length()` 計算 UTF-16 單位，不是通用字數；截取不能切斷代理對或契約要求保留的字元組合。 | 增量 | java.time 型別選擇、Duration／Period、Clock 與 String.length 的 UTF-16 單位，增加具體 Java 操作方式或失效情境。 共通對照：[長度與截取單位的共通要求](../rules/coding/numbers-dates-text.md#text-length-units)。 |
| [NT-13 第 13 條（歷史；現行整條移除）](../rules/coding/numbers-dates-text.md#text-transformations)（歷史第 13 條；全部去向：[nt-13](../rules/coding/numbers-dates-text.md#text-transformations)） | Java 字串比較、大小寫與正規化須使用明確地區及用途，不無意依賴環境預設。 | 重述 | 精度捨入、地區／時區、完整解析及字元編碼皆重述共通；僅加上 Java 或 API 字樣不構成增量。 共通對照：[用途明確的文字轉換的共通要求](../rules/coding/numbers-dates-text.md#text-transformations)。 |
| [NT-14 第 14 條（歷史；現行整條保留）](../rules/stacks/java/common/numbers-dates-text.md#java-boundary-verification)（歷史第 14 條；全部去向：[java-boundary-verification](../rules/stacks/java/common/numbers-dates-text.md#java-boundary-verification)） | Java `BigDecimal`、`java.time`、`Clock` 及字串轉換的實際路徑依下方表格驗收。 | 驗收入口 | BigDecimal、java.time 與字串實際路徑由驗收章節承接，不另保留正文純入口。 共通對照：[邊界與環境差異驗收的共通要求](../rules/coding/numbers-dates-text.md#data-boundary-verification)。 |
| [LS-01 第 1 條（歷史；現行整條保留）](../rules/stacks/java/common/lambda-and-stream.md#java-intent-readability)（歷史第 1 條；全部去向：[java-intent-readability](../rules/stacks/java/common/lambda-and-stream.md#java-intent-readability)） | Java Lambda／Stream 不強制取代迴圈；複雜或獨立責任採具名方法或清楚流程，不要求每個 Lambda 都抽方法。 | 重述 | 不強制 Stream 取代迴圈或每個 Lambda 抽方法，是責任與可讀性原則的情境說明，沒有額外機制要求。 共通對照：[程式碼設計與公開介面](../rules/coding/code-design.md)、[命名與可讀性](../rules/coding/naming.md)。 |
| [CA-01 第 1 條（歷史；現行整條移除）](../rules/coding/concurrency-and-async.md#task-ownership)（歷史第 1 條；全部去向：[ca-01](../rules/coding/concurrency-and-async.md#task-ownership)、[async-result-reception](../rules/coding/concurrency-and-async.md#async-result-reception)） | Java 任務脫離呼叫流程時仍須有明確接手元件及結果處置路徑。 | 重述 | 工作接手、逾時不等於停止、完成不等於成功、受限 executor 等待、鎖範圍及關閉驗收均已共通；現行文字未另指定 API 操作。 共通對照：[明確的工作擁有者的共通要求](../rules/coding/concurrency-and-async.md#task-ownership)。 |
| [CA-02 第 2 條（歷史；現行整條保留）](../rules/stacks/java/common/concurrency-and-async.md#java-execution-resources)（歷史第 2 條；全部去向：[java-execution-resources](../rules/stacks/java/common/concurrency-and-async.md#java-execution-resources)） | Java 可用明確提供的 `Executor`、`ExecutorService` 或框架提交工作；虛擬執行緒也須遵守下游容量。 | 混合 | 明確提供 Executor／ExecutorService 的提交方式保留；虛擬執行緒仍受下游限制是共同容量規則的例子。 共通對照：[統一管理執行資源的共通要求](../rules/coding/concurrency-and-async.md#execution-resources)。 |
| [CA-04 第 4 條（歷史；現行整條移除）](../rules/coding/concurrency-and-async.md#deadline-budget)（歷史第 4 條；全部去向：[ca-04](../rules/coding/concurrency-and-async.md#deadline-budget)） | Java 非同步等待的逾時不代表底層工作已停止；等待 API 須承接整體時間預算。 | 重述 | 工作接手、逾時不等於停止、完成不等於成功、受限 executor 等待、鎖範圍及關閉驗收均已共通；現行文字未另指定 API 操作。 共通對照：[等待期限與逾時處置的共通要求](../rules/coding/concurrency-and-async.md#deadline-budget)。 |
| [CA-05 第 5 條（歷史；現行保留增量）](../rules/stacks/java/common/concurrency-and-async.md#java-cancellation-propagation)（歷史第 5 條；全部去向：[java-cancellation-propagation](../rules/stacks/java/common/concurrency-and-async.md#java-cancellation-propagation)） | Java 取消訊號及中斷依任務契約傳遞，不把取消最外層 Future 視為全部子工作已停止。 | 增量 | Future 取消不代表全部子工作停止，並與 Java 中斷機制銜接；共同取消契約只引用。 共通對照：[取消傳遞與實際停止的共通要求](../rules/coding/concurrency-and-async.md#cancellation-and-termination)。 |
| [CA-07 第 7 條（歷史；現行整條保留）](../rules/stacks/java/common/concurrency-and-async.md#java-task-completion)（歷史第 7 條；全部去向：[java-task-completion](../rules/stacks/java/common/concurrency-and-async.md#java-task-completion)） | Java 多工作組合須驗證完成順序及剩餘任務處置，第一個完成不等於第一個成功。 | 重述 | 工作接手、逾時不等於停止、完成不等於成功、受限 executor 等待、鎖範圍及關閉驗收均已共通；現行文字未另指定 API 操作。 共通對照：[多工作組合的完成條件的共通要求](../rules/coding/concurrency-and-async.md#task-completion-contract)。 |
| [CA-08 第 8 條（歷史；現行整條保留）](../rules/stacks/java/common/concurrency-and-async.md#java-execution-location)（歷史第 8 條；全部去向：[java-execution-location](../rules/stacks/java/common/concurrency-and-async.md#java-execution-location)） | Java 任務及回呼須明確安排 executor 與阻塞行為，避免占用同一受限 executor 等待其排隊工作。 | 重述 | 工作接手、逾時不等於停止、完成不等於成功、受限 executor 等待、鎖範圍及關閉驗收均已共通；現行文字未另指定 API 操作。 共通對照：[執行位置與阻塞行為的共通要求](../rules/coding/concurrency-and-async.md#execution-and-blocking)。 |
| [CA-09 第 9 條（歷史；現行保留增量）](../rules/stacks/java/common/concurrency-and-async.md#java-context-propagation)（歷史第 9 條；全部去向：[java-context-propagation](../rules/stacks/java/common/concurrency-and-async.md#java-context-propagation)） | Java 不假設 `ThreadLocal` 或日誌脈絡自動沿用；共用執行緒上的脈絡須在結束時清理或還原。 | 增量 | ThreadLocal 不會自動沿非同步工作傳遞，是 Java 特有失效情境；共用執行緒清理政策引用共通。 共通對照：[明確傳遞與清理脈絡的共通要求](../rules/coding/concurrency-and-async.md#context-propagation)。 |
| [CA-10 第 10 條（歷史；現行整條保留）](../rules/stacks/java/common/concurrency-and-async.md#java-lock-scope)（歷史第 10 條；全部去向：[java-lock-scope](../rules/stacks/java/common/concurrency-and-async.md#java-lock-scope)） | Java 同步與鎖的實作須涵蓋全部退出路徑，必要檢查不能為縮短持鎖而移出原子範圍。 | 重述 | 工作接手、逾時不等於停止、完成不等於成功、受限 executor 等待、鎖範圍及關閉驗收均已共通；現行文字未另指定 API 操作。 共通對照：[鎖定範圍與取得策略的共通要求](../rules/coding/concurrency-and-async.md#lock-scope)。 |
| [CA-11 第 11 條（歷史；現行整條保留）](../rules/stacks/java/common/concurrency-and-async.md#java-controlled-shutdown)（歷史第 11 條；全部去向：[java-controlled-shutdown](../rules/stacks/java/common/concurrency-and-async.md#java-controlled-shutdown)） | Java 執行元件開始關閉或發出停止要求不代表工作全數結束；實際關閉與資源釋放依共同契約驗證。 | 重述 | 工作接手、逾時不等於停止、完成不等於成功、受限 executor 等待、鎖範圍及關閉驗收均已共通；現行文字未另指定 API 操作。 共通對照：[受控關閉的共通要求](../rules/coding/resource-lifecycle.md#controlled-shutdown)。 |
| [CA-12 第 12 條（歷史；現行整條保留）](../rules/stacks/java/common/concurrency-and-async.md#java-controlled-verification)（歷史第 12 條；全部去向：[java-controlled-verification](../rules/stacks/java/common/concurrency-and-async.md#java-controlled-verification)） | Java 測試使用可控制的協調與完成條件，並審查同步／可見性設計，不以固定睡眠或壓力測試單獨證明安全。 | 重述 | 工作接手、逾時不等於停止、完成不等於成功、受限 executor 等待、鎖範圍及關閉驗收均已共通；現行文字未另指定 API 操作。 共通對照：[可控制的併發驗收的共通要求](../rules/quality/testing.md#controlled-interleaving)。 |
| [RF-02 第 2 條（歷史；現行整條移除）](../rules/quality/security.md#dynamic-target-authorization)（歷史第 2 條；全部去向：[rf-02](../rules/quality/security.md#dynamic-target-authorization)） | Java 類別、方法及建構子的動態目標須受控，不因型別符合就略過授權。 | 重述 | 類別／方法／建構子的目標檢查仍是共同允許清單、能力及型別檢查，沒有具體反射 API 操作限制。 共通對照：[受控目標與授權的共通要求](../rules/quality/security.md#dynamic-target-authorization)。 |
| [RF-04 第 4 條（歷史；現行整條移除）](../rules/coding/type-safety.md#dynamic-contract-validation)（歷史第 4 條；全部去向：[rf-04](../rules/coding/type-safety.md#dynamic-contract-validation)） | Java 動態元件須驗證能力、版本及型別，不只確認名稱存在，也不靠未驗證轉型掩蓋不相容。 | 重述 | 類別／方法／建構子的目標檢查仍是共同允許清單、能力及型別檢查，沒有具體反射 API 操作限制。 共通對照：[使用前驗證契約的共通要求](../rules/coding/type-safety.md#dynamic-contract-validation)。 |
| [RF-05 第 5 條（歷史；現行拆分）](../rules/stacks/java/common/reflection-and-suppression.md#java-reflection-failure)（歷史第 5 條；全部去向：[java-reflection-failure](../rules/stacks/java/common/reflection-and-suppression.md#java-reflection-failure)） | Java 反射或動態呼叫的外層例外須保留原始原因，不能據此推定目標未執行而替換或重跑。 | 混合 | Java 反射外層例外與原始原因關係保留；收到錯誤不得推定未執行並重跑已由共通明訂。 共通對照：[區分故障與執行結果的共通要求](../rules/coding/error-handling.md#dynamic-failure-classification)。 |
| [RF-06 第 6 條（歷史；現行整條保留）](../rules/stacks/java/common/reflection-and-suppression.md#java-warning-suppression)（歷史第 6 條；全部去向：[java-warning-suppression](../rules/stacks/java/common/reflection-and-suppression.md#java-warning-suppression)） | Java `@SuppressWarnings` 須限具體規則及最小範圍；raw type／unchecked 仍遵守型別與泛型規範的禁止事項及個別核准要求。 | 混合 | SuppressWarnings 及 raw／unchecked 禁令由 Java 型別政策承接；最小抑制與核准程序只引用共通。 共通對照：[限定檢查抑制的共通要求](../rules/workflow/rule-governance.md#suppression-scope)。 |
| [RF-07 第 7 條（歷史；現行整條保留）](../rules/stacks/java/common/reflection-and-suppression.md#java-generated-code)（歷史第 7 條；全部去向：[java-generated-code](../rules/stacks/java/common/reflection-and-suppression.md#java-generated-code)） | Java 產生碼須由來源／設定重建；手寫銜接維持完整型別檢查，重建後確認例外範圍仍適用。 | 驗收入口 | 來源重建、手寫銜接與拒絕／限制生效皆有共通主要驗收；Java 反射的實際驗收入口保留，不重訂治理。 共通對照：[產生碼不擴大豁免的共通要求](../rules/workflow/rule-governance.md#generated-code-exceptions)。 |
| [RF-08 第 8 條（歷史；現行整條保留）](../rules/stacks/java/common/reflection-and-suppression.md#java-dynamic-verification)（歷史第 8 條；全部去向：[java-dynamic-verification](../rules/stacks/java/common/reflection-and-suppression.md#java-dynamic-verification)） | Java 實際反射、存取及重新產生路徑依下方驗收，不只確認警告消失或成功目標能執行。 | 驗收入口 | 來源重建、手寫銜接與拒絕／限制生效皆有共通主要驗收；Java 反射的實際驗收入口保留，不重訂治理。 共通對照：[驗證限制實際有效的共通要求](../rules/quality/rule-verification.md#dynamic-control-verification)。 |
| [ND-02 第 2 條（歷史；現行整條保留）](../rules/stacks/java/common/naming-packages-docs.md#java-specific-responsibility)（歷史第 2 條；全部去向：[java-specific-responsibility](../rules/stacks/java/common/naming-packages-docs.md#java-specific-responsibility)） | Java 的 `Service`、`Handler`、`Helper`、`Utils` 可使用，但名稱須有明確責任且與行為一致。 | 待補證 | 共通命名的具體名稱主要針對變數，沒有類別名稱與責任一致的直接條文；先保留 Java 原文與驗收，不先刪除純引用條目。 共通對照：[命名與可讀性](../rules/coding/naming.md)、[程式碼設計與公開介面](../rules/coding/code-design.md)。 |
| [ND-05 第 5 條（歷史；現行整條移除）](../rules/coding/code-design.md#implementation-notes)（歷史第 5 條；全部去向：[nd-05](../rules/coding/code-design.md#implementation-notes)） | Java 註解及 TODO 依共同追蹤要求維護，不以模糊標記代替負責事項。 | 重述 | Service／Handler／Helper／Utils 與 TODO 是例子，沒有超出共通責任命名及後續追蹤的新要求。 共通對照：[實作註解與暫時處理的共通要求](../rules/coding/code-design.md#implementation-notes)。 |
| [ND-07 第 7 條（歷史；現行保留增量）](../rules/stacks/java/common/naming-packages-docs.md#java-document-verification)（歷史第 7 條；全部去向：[java-document-verification](../rules/stacks/java/common/naming-packages-docs.md#java-document-verification)） | Java 命名形式、Javadoc 參照及可執行範例須驗證實際結果；範例能在承諾支援的版本使用，不以文件產生成功代替內容正確。 | 增量 | Javadoc 參照及可執行範例在支援 Java 版本驗證，保留實際語言驗收；形式不能代替語意只引用共通。 共通對照：[形式與語意分別驗收的共通要求](../rules/quality/rule-verification.md#document-verification)。 |

## 四、69 條保留條文的可拆共通背景

「新義務」指把建議的背景抽成跨語言強制要求時，是否超過現有共通規則；不是本次已執行的變更。標為「是／可能」的內容一律維持 Java，待使用者逐項確認。未標為新義務者只建議改引用既有來源，不另增共通規則。

| 歷史 ID／現行位置 | 可拆的共通背景 | 須保留的 Java 增量 | 是否形成新跨語言義務 |
| --- | --- | --- | --- |
| [JV-01 第 1 條（歷史；現行保留增量）](../rules/stacks/java/common/version-policy.md#java-version-declarations)（歷史第 1 條；全部去向：[java-version-declarations](../rules/stacks/java/common/version-policy.md#java-version-declarations)） | 未找到涵蓋 JDK 執行支援範圍的共通來源；資料契約不能代替 | 建置 JDK、目標語言、標準 API、位元碼及執行版本分開 | 否：先保留 Java，若提升執行版本支援義務須另行核准 |
| [JV-02 第 2 條（歷史；現行保留增量）](../rules/stacks/java/common/version-policy.md#java-build-compatibility)（歷史第 2 條；全部去向：[java-build-compatibility](../rules/stacks/java/common/version-policy.md#java-build-compatibility)） | 受控設定、本機／CI 一致引用規範驗證 | Java 語言、API、位元碼編譯限制 | 否：引用現有共通即可 |
| [JV-03 第 3 條（歷史；現行保留增量）](../rules/stacks/java/common/version-policy.md#java-runtime-verification)（歷史第 3 條；全部去向：[java-runtime-verification](../rules/stacks/java/common/version-policy.md#java-runtime-verification)） | 風險選案與證據引用共通測試 | 每個承諾 runtime 實際啟動、載入與函式庫使用端驗證 | 否：引用現有共通即可 |
| [JV-04 第 4 條（歷史；現行保留增量）](../rules/stacks/java/common/version-policy.md#java-module-versions)（歷史第 4 條；全部去向：[java-module-versions](../rules/stacks/java/common/version-policy.md#java-module-versions)） | 跨模組相容責任引用資料契約 | 逐模組編譯目標與 runtime 範圍 | 否：引用現有共通即可 |
| [JV-05 第 5 條（歷史；現行保留增量）](../rules/stacks/java/common/version-policy.md#java-dependency-versions)（歷史第 5 條；全部去向：[java-dependency-versions](../rules/stacks/java/common/version-policy.md#java-dependency-versions)） | 依賴採用與升級處置引用依賴管理 | 直接／間接依賴最低 Java 版本核對 | 否：引用現有共通即可 |
| [JV-06 第 6 條（歷史；現行保留增量）](../rules/stacks/java/common/version-policy.md#java-build-upgrade)（歷史第 6 條；全部去向：[java-build-upgrade](../rules/stacks/java/common/version-policy.md#java-build-upgrade)） | 使用端遷移、回退與公告引用契約管理 | 建置 JDK 升級不等於提高最低執行版本 | 否：引用現有共通即可 |
| [JV-07 第 7 條（歷史；現行保留增量）](../rules/stacks/java/common/version-policy.md#java-preview-features)（歷史第 7 條；全部去向：[java-preview-features](../rules/stacks/java/common/version-policy.md#java-preview-features)） | 核准、理由與維護責任引用治理 | 正式功能預設與 Preview 配套 | 否：引用現有共通即可 |
| [JV-08 第 8 條（歷史；現行保留增量）](../rules/stacks/java/common/version-policy.md#java-jdk-internals)（歷史第 8 條；全部去向：[java-jdk-internals](../rules/stacks/java/common/version-policy.md#java-jdk-internals)） | 例外核准及替代方案引用治理 | JDK 內部 API、存取限制及升級重驗 | 否：引用現有共通即可 |
| [JV-09 第 9 條（歷史；現行保留增量）](../rules/stacks/java/common/version-policy.md#java-deprecated-api)（歷史第 9 條；全部去向：[java-deprecated-api](../rules/stacks/java/common/version-policy.md#java-deprecated-api)） | 移除風險與例外程序引用依賴／治理 | Java 棄用 API 與目標版本替代方式 | 否：引用現有共通即可 |
| [JV-10 第 10 條（歷史；現行保留增量）](../rules/stacks/java/common/version-policy.md#java-toolchain-compatibility)（歷史第 10 條；全部去向：[java-toolchain-compatibility](../rules/stacks/java/common/version-policy.md#java-toolchain-compatibility)） | 必要檢查實際執行引用規範驗證 | 註解處理器、編譯外掛及產物處理相容性 | 否：引用現有共通即可 |
| [JV-11 第 11 條（歷史；現行保留增量）](../rules/stacks/java/common/version-policy.md#java-jdk-distribution)（歷史第 11 條；全部去向：[java-jdk-distribution](../rules/stacks/java/common/version-policy.md#java-jdk-distribution)） | 未找到涵蓋 JDK 發行商與執行環境識別的共通來源；第三方依賴管理不能代替 | JDK 發行商、完整修補版本與啟動配置 | 否：先保留 Java，若提升執行環境識別義務須另行核准 |
| [JV-12 第 12 條（歷史；現行保留增量）](../rules/stacks/java/common/version-policy.md#java-artifact-traceability)（歷史第 12 條；全部去向：[java-artifact-traceability](../rules/stacks/java/common/version-policy.md#java-artifact-traceability)） | 產物及證據追溯引用規範驗證 | 建置 JDK、目標與部署 runtime 的具體追溯欄位 | 否：引用現有共通即可 |
| [JT-01 第 1 條（歷史；現行保留增量）](../rules/stacks/java/common/types-and-generics.md#java-explicit-types)（歷史第 1 條；全部去向：[java-explicit-types](../rules/stacks/java/common/types-and-generics.md#java-explicit-types)） | 明確宣告引用型別安全 | 禁用 var 與各宣告位置保留泛型 | 否：引用現有共通即可 |
| [JT-02 第 2 條（歷史；現行保留增量）](../rules/stacks/java/common/types-and-generics.md#java-generic-type-information)（歷史第 2 條；全部去向：[java-generic-type-information](../rules/stacks/java/common/types-and-generics.md#java-generic-type-information)） | 真實型別關聯及不得隱藏業務型別引用型別安全 | raw type 禁令、Object／萬用字元的選用界線 | 否：引用現有共通即可 |
| [JT-04 第 4 條（歷史；現行保留增量）](../rules/stacks/java/common/types-and-generics.md#java-business-type-casts)（歷史第 4 條；全部去向：[java-business-type-casts](../rules/stacks/java/common/types-and-generics.md#java-business-type-casts)） | 外部未知輸入驗證與例外流程引用共通 | 禁止用參考型別向下轉型補回業務型別，與數值轉換分開 | 否：引用現有共通即可 |
| [JT-05 第 5 條（歷史；現行保留增量）](../rules/stacks/java/common/types-and-generics.md#java-type-safety-warnings)（歷史第 5 條；全部去向：[java-type-safety-warnings](../rules/stacks/java/common/types-and-generics.md#java-type-safety-warnings)） | 不得繞過檢查及核准程序引用共通 | raw／unchecked 診斷與 SuppressWarnings | 否：引用現有共通即可 |
| [JT-07 第 7 條（歷史；現行保留增量）](../rules/stacks/java/common/types-and-generics.md#java-generic-capabilities)（歷史第 7 條；全部去向：[java-generic-capabilities](../rules/stacks/java/common/types-and-generics.md#java-generic-capabilities)） | 真實需求、不強建介面引用型別安全／依賴組裝 | 上界、型別參數與參數契約表達能力 | 否：引用現有共通即可 |
| [JT-08 第 8 條（歷史；現行保留增量）](../rules/stacks/java/common/types-and-generics.md#java-collection-declarations)（歷史第 8 條；全部去向：[java-collection-declarations](../rules/stacks/java/common/types-and-generics.md#java-collection-declarations)） | 操作能力與所有權引用型別安全／集合 | 介面與實作宣告選擇，不能迫使使用端轉型 | 否：引用現有共通即可 |
| [JT-09 第 9 條（歷史；現行保留增量）](../rules/stacks/java/common/types-and-generics.md#java-diamond-construction)（歷史第 9 條；全部去向：[java-diamond-construction](../rules/stacks/java/common/types-and-generics.md#java-diamond-construction)） | 宣告端明確引用型別安全 | 僅建構端允許菱形運算子 | 否：引用現有共通即可 |
| [JT-10 第 10 條（歷史；現行保留增量）](../rules/stacks/java/common/types-and-generics.md#java-generic-return-types)（歷史第 10 條；全部去向：[java-generic-return-types](../rules/stacks/java/common/types-and-generics.md#java-generic-return-types)） | 必要型別與不可變性政策引用共通 | 萬用字元回傳及上下界採用條件 | 否：引用現有共通即可 |
| [JT-11 第 11 條（歷史；現行保留增量）](../rules/stacks/java/common/types-and-generics.md#java-type-parameter-names)（歷史第 11 條；全部去向：[java-type-parameter-names](../rules/stacks/java/common/types-and-generics.md#java-type-parameter-names)） | 用途／關聯可辨識引用命名 | T／K／V 與角色型別參數的適用界線 | 否：引用現有共通即可 |
| [JN-01 第 1 條](../rules/stacks/java/common/null-and-optional.md#java-query-absence) | 正常缺值、必須存在與技術故障分類引用共通 | 單筆 Optional、多筆非 null 空集合 | 否：引用現有共通即可 |
| [JN-02 第 2 條](../rules/stacks/java/common/null-and-optional.md#java-optional-nonnull) | 不得用正常缺值掩蓋故障引用錯誤處理 | Optional 物件本身必須非 null | 否：引用現有共通即可 |
| [JN-03 第 3 條](../rules/stacks/java/common/null-and-optional.md#java-optional-access) | 替代結果及缺陷分類引用錯誤處理 | Optional 取值前處置與不變條件成立時的例外路徑 | 否：引用現有共通即可 |
| [JN-04 第 4 條](../rules/stacks/java/common/null-and-optional.md#java-optional-positions) | 三種更新意圖引用空值語意 | Optional 使用位置及框架配套，不全面禁止／包裝 | 否：引用現有共通即可 |
| [JN-05 第 5 條](../rules/stacks/java/common/null-and-optional.md#java-container-nulls) | 邊界拒絕不合法資料引用資料驗證 | 集合、陣列、映射鍵值預設非 null | 是：全面容器非空是額外跨語言義務，建議留 Java |
| [JN-07 第 7 條](../rules/stacks/java/common/null-and-optional.md#java-null-contract-tools) | 工具缺口、行為一致及執行期驗證引用規範驗證 | 統一 Java 空值標註方式與適用範圍 | 否：引用現有共通即可 |
| [JN-11 第 11 條](../rules/stacks/java/common/null-and-optional.md#java-nonnull-default) | 空值必須具有明確語意引用空值語意 | Java 參數、欄位及回傳值預設非 null | 是：全語言預設非空不得直接提升，建議留 Java |
| [VO-04 第 4 條（歷史；現行保留增量）](../rules/stacks/java/common/value-objects.md#java-value-equality)（歷史第 4 條；全部去向：[java-value-equality](../rules/stacks/java/common/value-objects.md#java-value-equality)） | 業務概念區別與比較語意引用領域建模 | equals／hashCode、一致雜湊及不得盲用產生方法 | 否：引用現有共通即可 |
| [VO-08 第 8 條（歷史；現行保留增量）](../rules/stacks/java/common/value-objects.md#java-value-implementation)（歷史第 8 條；全部去向：[java-value-implementation](../rules/stacks/java/common/value-objects.md#java-value-implementation)） | 有效性、不可變性與敏感資料引用共通 | record／一般類別選擇、產生方法與可變成員 | 否：引用現有共通即可 |
| [VO-09 第 9 條（歷史；現行整條保留）](../rules/stacks/java/common/value-objects.md#java-diagnostic-representation)（歷史第 9 條；全部去向：[java-diagnostic-representation](../rules/stacks/java/common/value-objects.md#java-diagnostic-representation)） | 交換契約與敏感資訊引用資料契約／可觀測性 | toString 不默認為穩定交換格式 | 可能：若提升為所有語言診斷字串不得交換，須另確認；現行共通僅提供格式契約原則 |
| [ST-01 第 1 條（歷史；現行整條保留）](../rules/stacks/java/common/states-and-results.md#java-explicit-state-types)（歷史第 1 條；全部去向：[java-explicit-state-types](../rules/stacks/java/common/states-and-results.md#java-explicit-state-types)） | 互斥型別及必要資料已有領域建模 | enum 選擇；不同業務面向分開建模暫留本條 | 是：不同業務面向一律分開建模未由原共通明訂，建議正式決策後才提升 |
| [ST-07 第 7 條（歷史；現行整條保留）](../rules/stacks/java/common/states-and-results.md#java-stable-external-codes)（歷史第 7 條；全部去向：[java-stable-external-codes](../rules/stacks/java/common/states-and-results.md#java-stable-external-codes)） | 對外代碼相容與未知值處理引用資料契約 | 禁止 ordinal，enum 名稱納入相容管理 | 可能：一般穩定代碼與未知代碼不得任意回填若獨立成新規則，需明確範圍 |
| [BM-05 第 5 條（歷史；現行保留增量）](../rules/stacks/java/common/boundary-mapping.md#java-update-intent)（歷史第 5 條；全部去向：[java-update-intent](../rules/stacks/java/common/boundary-mapping.md#java-update-intent)） | 省略／清空／設定三種意圖引用空值語意 | Java null／Optional 與反序列化不得合併三種意圖 | 否：引用現有共通即可 |
| [CL-04 第 4 條（歷史；現行整條保留）](../rules/stacks/java/common/classes-and-construction.md#java-construction-safety)（歷史第 4 條；全部去向：[java-construction-safety](../rules/stacks/java/common/classes-and-construction.md#java-construction-safety)） | 建立就緒及啟動責任引用生命週期 | this 外洩與建構子呼叫可覆寫方法禁令 | 是：其他語言建構期外洩／動態派送禁令不能自動提升 |
| [CL-07 第 7 條（歷史；現行整條保留）](../rules/stacks/java/common/classes-and-construction.md#java-override-scope)（歷史第 7 條；全部去向：[java-override-scope](../rules/stacks/java/common/classes-and-construction.md#java-override-scope)） | 最小公開與必要檢查已有共通背景 | super 呼叫依賴、覆寫範圍與 final／代理相容 | 可能：一般擴充範圍及必要檢查不得依賴子類自律若獨立提升，須確認 |
| [EQ-02 第 2 條（歷史；現行整條保留）](../rules/stacks/java/common/equality-hashing-ordering.md#java-equality-hash-contract)（歷史第 2 條；全部去向：[java-equality-hash-contract](../rules/stacks/java/common/equality-hashing-ordering.md#java-equality-hash-contract)） | 比較用途引用領域建模 | equals 關係、null 與 hashCode 契約 | 是：各語言相等操作是否採同一組關係不可直接提升 |
| [EQ-03 第 3 條（歷史；現行整條保留）](../rules/stacks/java/common/equality-hashing-ordering.md#java-hash-collection-stability)（歷史第 3 條；全部去向：[java-hash-collection-stability](../rules/stacks/java/common/equality-hashing-ordering.md#java-hash-collection-stability)） | 鍵所有權與修改管理引用集合 | equals／hashCode 依據在雜湊集合內穩定、移出重加 | 是：跨語言集合索引穩定政策須另定適用能力 |
| [EQ-05 第 5 條（歷史；現行整條保留）](../rules/stacks/java/common/equality-hashing-ordering.md#java-cross-type-equality)（歷史第 5 條；全部去向：[java-cross-type-equality](../rules/stacks/java/common/equality-hashing-ordering.md#java-cross-type-equality)） | 可替代性引用程式碼設計 | instanceof／getClass 選擇及父子 equals 範圍 | 是：跨型別相等範圍、對稱遞移與擴充限制是新跨語言義務 |
| [EQ-06 第 6 條（歷史；現行整條保留）](../rules/stacks/java/common/equality-hashing-ordering.md#java-ordering-choice)（歷史第 6 條；全部去向：[java-ordering-choice](../rules/stacks/java/common/equality-hashing-ordering.md#java-ordering-choice)） | 比較欄位／方向是契約內容 | Comparable 自然順序與 Comparator 情境排序 | 可能：若要求所有語言區分自然／情境順序，需另確認 |
| [EQ-07 第 7 條（歷史；現行整條保留）](../rules/stacks/java/common/equality-hashing-ordering.md#java-comparator-relations)（歷史第 7 條；全部去向：[java-comparator-relations](../rules/stacks/java/common/equality-hashing-ordering.md#java-comparator-relations)） | 數值溢位與精度引用數值規則 | 比較器關係、同次比較依據穩定、禁用可能溢位相減 | 是：排序關係與同次依據固定不能由一般數值規則直接推得 |
| [EQ-08 第 8 條（歷史；現行保留增量）](../rules/stacks/java/common/equality-hashing-ordering.md#java-sorted-key-equivalence)（歷史第 8 條；全部去向：[java-sorted-key-equivalence](../rules/stacks/java/common/equality-hashing-ordering.md#java-sorted-key-equivalence)） | 不得意外丟失資料引用集合 | compare 為零與 equals、TreeSet／TreeMap 判同 | 否：引用現有共通即可 |
| [EQ-09 第 9 條（歷史；現行整條保留）](../rules/stacks/java/common/equality-hashing-ordering.md#java-sorted-collection-stability)（歷史第 9 條；全部去向：[java-sorted-collection-stability](../rules/stacks/java/common/equality-hashing-ordering.md#java-sorted-collection-stability)） | 資料不遺失與修改責任引用集合 | 排序索引與比較器設定變更後移出重加／重建 | 是：跨語言排序索引失效與重建策略須另確認 |
| [EQ-10 第 10 條（歷史；現行保留增量）](../rules/stacks/java/common/equality-hashing-ordering.md#java-relationship-coverage)（歷史第 10 條；全部去向：[java-relationship-coverage](../rules/stacks/java/common/equality-hashing-ordering.md#java-relationship-coverage)） | 風險選案與工具不能代替契約驗證引用測試 | Java 關係性及實際集合案例 | 否：引用現有共通即可 |
| [EX-01 第 1 條（歷史；現行保留增量）](../rules/stacks/java/common/exceptions-and-resources.md#java-exception-classification)（歷史第 1 條；全部去向：[java-exception-classification](../rules/stacks/java/common/exceptions-and-resources.md#java-exception-classification)） | 分類、原因保留及業務失敗型別引用錯誤處理 | throws Exception／RuntimeException 與例外類別選擇 | 否：引用現有共通即可 |
| [EX-02 第 2 條（歷史；現行保留增量）](../rules/stacks/java/common/exceptions-and-resources.md#java-checked-unchecked)（歷史第 2 條；全部去向：[java-checked-unchecked](../rules/stacks/java/common/exceptions-and-resources.md#java-checked-unchecked)） | 恢復／重試依語意決定引用錯誤處理 | Checked／Unchecked 與宣告／捕捉義務 | 否：引用現有共通即可 |
| [EX-03 第 3 條（歷史；現行保留增量）](../rules/stacks/java/common/exceptions-and-resources.md#java-catch-scope)（歷史第 3 條；全部去向：[java-catch-scope](../rules/stacks/java/common/exceptions-and-resources.md#java-catch-scope)） | 捕捉責任及不得偽裝恢復引用錯誤處理 | 具體 catch、try 範圍及 Throwable／Error 限制 | 否：引用現有共通即可 |
| [EX-04 第 4 條（歷史；現行保留增量）](../rules/stacks/java/common/exceptions-and-resources.md#java-interruption)（歷史第 4 條；全部去向：[java-interruption](../rules/stacks/java/common/exceptions-and-resources.md#java-interruption)） | 取消不得吞掉及必要清理引用錯誤處理 | InterruptedException 傳遞或恢復旗標 | 否：引用現有共通即可 |
| [EX-05 第 5 條（歷史；現行整條保留）](../rules/stacks/java/common/exceptions-and-resources.md#java-resource-management)（歷史第 5 條；全部去向：[java-resource-management](../rules/stacks/java/common/exceptions-and-resources.md#java-resource-management)） | 資源所有權與可靠釋放引用生命週期 | AutoCloseable／try-with-resources 及不依賴垃圾回收 | 可能：所有語言 GC 不代替釋放的政策須先確認適用資源 |
| [EX-06 第 6 條（歷史；現行保留增量）](../rules/stacks/java/common/exceptions-and-resources.md#java-suppressed-failures)（歷史第 6 條；全部去向：[java-suppressed-failures](../rules/stacks/java/common/exceptions-and-resources.md#java-suppressed-failures)） | 原始與清理故障並存引用錯誤處理 | suppressed exceptions、finally return 與單獨 close 失敗 | 否：引用現有共通即可 |
| [EX-09 第 9 條（歷史；現行保留增量）](../rules/stacks/java/common/exceptions-and-resources.md#java-failure-coverage)（歷史第 9 條；全部去向：[java-failure-coverage](../rules/stacks/java/common/exceptions-and-resources.md#java-failure-coverage)） | 風險覆蓋與實際框架整合引用測試／生命週期 | 中斷、suppressed、部分初始化與關閉路徑 | 否：引用現有共通即可 |
| [NT-05 第 5 條（歷史；現行保留增量）](../rules/stacks/java/common/numbers-dates-text.md#java-decimal-equivalence)（歷史第 5 條；全部去向：[java-decimal-equivalence](../rules/stacks/java/common/numbers-dates-text.md#java-decimal-equivalence)） | 業務等價、正規化與集合資料保留引用共通 | BigDecimal scale、1.0／1.00 與 equals／排序判同 | 否：引用現有共通即可 |
| [LS-02 第 2 條（歷史；現行保留增量）](../rules/stacks/java/common/lambda-and-stream.md#java-lambda-parameter-types)（歷史第 2 條；全部去向：[java-lambda-parameter-types](../rules/stacks/java/common/lambda-and-stream.md#java-lambda-parameter-types)） | 明確宣告與泛型資訊引用型別安全 | Lambda 參數不可省略或 var，方法參考的允許條件 | 否：引用現有共通即可 |
| [LS-03 第 3 條（歷史；現行保留增量）](../rules/stacks/java/common/lambda-and-stream.md#java-intermediate-side-effects)（歷史第 3 條；全部去向：[java-intermediate-side-effects](../rules/stacks/java/common/lambda-and-stream.md#java-intermediate-side-effects)） | 副作用責任、順序與失敗保證引用共通 | Stream 中間操作、peek 與 forEach 的必要工作限制 | 否：引用現有共通即可 |
| [LS-04 第 4 條（歷史；現行整條保留）](../rules/stacks/java/common/lambda-and-stream.md#java-result-accumulation)（歷史第 4 條；全部去向：[java-result-accumulation](../rules/stacks/java/common/lambda-and-stream.md#java-result-accumulation)） | 狀態責任與流程清楚引用程式碼設計 | collect／reduce，不捕捉外部可變累積狀態 | 是：不得泛化成所有語言函式一律禁止修改外部狀態 |
| [LS-05 第 5 條（歷史；現行保留增量）](../rules/stacks/java/common/lambda-and-stream.md#java-lazy-short-circuit)（歷史第 5 條；全部去向：[java-lazy-short-circuit](../rules/stacks/java/common/lambda-and-stream.md#java-lazy-short-circuit)） | 必要工作完成語意引用契約 | Stream 延遲、終端及短路不保證全部元素執行 | 否：引用現有共通即可 |
| [LS-06 第 6 條（歷史；現行保留增量）](../rules/stacks/java/common/lambda-and-stream.md#java-parallel-stream-adoption)（歷史第 6 條；全部去向：[java-parallel-stream-adoption](../rules/stacks/java/common/lambda-and-stream.md#java-parallel-stream-adoption)） | 容量、隔離與量測依效能／併發 | 平行 Stream 採用、阻塞與歸約語意 | 否：引用現有共通即可 |
| [LS-07 第 7 條（歷史；現行整條保留）](../rules/stacks/java/common/lambda-and-stream.md#java-reduction-collection)（歷史第 7 條；全部去向：[java-reduction-collection](../rules/stacks/java/common/lambda-and-stream.md#java-reduction-collection)） | 捨入順序與資料隔離引用共通 | 初始值、結合性、分段合併與可變容器收集 | 是：一般歸約代數契約若提升須限定操作與平行模型 |
| [LS-08 第 8 條（歷史；現行保留增量）](../rules/stacks/java/common/lambda-and-stream.md#java-failure-classification)（歷史第 8 條；全部去向：[java-failure-classification](../rules/stacks/java/common/lambda-and-stream.md#java-failure-classification)） | 故障分類、原因與部分成功引用錯誤處理 | 函式介面例外限制、流程調整及禁止隱藏拋出 | 否：引用現有共通即可 |
| [LS-09 第 9 條（歷史；現行保留增量）](../rules/stacks/java/common/lambda-and-stream.md#java-stream-consumption)（歷史第 9 條；全部去向：[java-stream-consumption](../rules/stacks/java/common/lambda-and-stream.md#java-stream-consumption)） | 快照／最新資料與有效期引用集合／生命週期 | Stream 單次消費、不可重用或多人各自消費 | 否：引用現有共通即可 |
| [LS-10 第 10 條（歷史；現行保留增量）](../rules/stacks/java/common/lambda-and-stream.md#java-execution-verification)（歷史第 10 條；全部去向：[java-execution-verification](../rules/stacks/java/common/lambda-and-stream.md#java-execution-verification)） | 風險選案、實際效能與不重測函式庫引用測試 | Stream 短路、順序、歸約及平行執行語意 | 否：引用現有共通即可 |
| [CA-03 第 3 條（歷史；現行整條保留）](../rules/stacks/java/common/concurrency-and-async.md#java-visibility-sharing)（歷史第 3 條；全部去向：[java-visibility-sharing](../rules/stacks/java/common/concurrency-and-async.md#java-visibility-sharing)） | 隔離快照、同步及複合原子性引用共通 | 跨執行緒可見性交付與 volatile 限制 | 是：可見性交付是未正式列管的新跨語言義務 |
| [CA-06 第 6 條（歷史；現行整條保留）](../rules/stacks/java/common/concurrency-and-async.md#java-result-reception)（歷史第 6 條；全部去向：[java-result-reception](../rules/stacks/java/common/concurrency-and-async.md#java-result-reception)） | 故障分類、原因與恢復條件引用錯誤處理 | Future／CompletableFuture 工作控制物件與結果鏈 | 是：所有工作結果必有接收路徑的獨立義務須正式決策 |
| [RF-01 第 1 條（歷史；現行保留增量）](../rules/stacks/java/common/reflection-and-suppression.md#java-dynamic-type-contract)（歷史第 1 條；全部去向：[java-dynamic-type-contract](../rules/stacks/java/common/reflection-and-suppression.md#java-dynamic-type-contract)） | 明確契約、禁止型別逃逸與集中責任引用共通 | 反射需求、名稱解析及動態物件收斂 | 否：引用現有共通即可 |
| [RF-03 第 3 條（歷史；現行保留增量）](../rules/stacks/java/common/reflection-and-suppression.md#java-reflective-encapsulation)（歷史第 3 條；全部去向：[java-reflective-encapsulation](../rules/stacks/java/common/reflection-and-suppression.md#java-reflective-encapsulation)） | 封裝、建立有效及例外程序引用共通 | Java 反射特殊存取、私有欄位及還原驗證 | 否：引用現有共通即可 |
| [ND-01 第 1 條（歷史；現行保留增量）](../rules/stacks/java/common/naming-packages-docs.md#java-naming-form)（歷史第 1 條；全部去向：[java-naming-form](../rules/stacks/java/common/naming-packages-docs.md#java-naming-form)） | 領域詞彙、一致命名引用命名規則 | CamelCase、UPPER_SNAKE_CASE、package、final 與 I 前綴 | 否：引用現有共通即可 |
| [ND-03 第 3 條（歷史；現行保留增量）](../rules/stacks/java/common/naming-packages-docs.md#java-package-boundaries)（歷史第 3 條；全部去向：[java-package-boundaries](../rules/stacks/java/common/naming-packages-docs.md#java-package-boundaries)） | 模組責任、公開範圍及共用依賴引用共通 | Java package 與可見性檢查 | 否：引用現有共通即可 |
| [ND-04 第 4 條（歷史；現行保留增量）](../rules/stacks/java/common/naming-packages-docs.md#java-javadoc-contract)（歷史第 4 條；全部去向：[java-javadoc-contract](../rules/stacks/java/common/naming-packages-docs.md#java-javadoc-contract)） | 前置條件、失敗、副作用與生命週期引用公開文件 | Javadoc 就近維護或引用權威契約 | 否：引用現有共通即可 |
| [ND-06 第 6 條（歷史；現行保留增量）](../rules/stacks/java/common/naming-packages-docs.md#java-rename-impact)（歷史第 6 條；全部去向：[java-rename-impact](../rules/stacks/java/common/naming-packages-docs.md#java-rename-impact)） | 公開名稱相容、遷移及文件同步引用資料契約 | 類別／package 動態引用與 IDE 重構不完整的風險 | 否：引用現有共通即可 |

## 五、共通歷史規則錨點的語意名稱建議

階段 C 第一部分已執行：以下 74 筆全數採用表列名稱，沒有名稱調整；表內顯示的舊代號是相容別名，連結目的地為現行語意錨點。同一位置保留新舊錨點，未複製正文；集中清冊見[共通錨點別名](common-anchor-aliases.md)。下段原建議保留作歷史決策，原「尚未變更／待確認」狀態已由本段取代。

以下列出現存全部歷史代碼錨點，包含已整合的 AU 檢查政策。只提出對照，未變更任何規則錨點。建議一次更新 rules 及 docs 的有效目的地；若有儲存庫外引用，先保留舊錨點作過渡別名，同一規則不複製正文。是否保留別名及期限仍待確認。

| 歷史位置／相容錨點（連至現行） | 建議暨實際採用語意錨點 |
| --- | --- |
| [architecture/data-mapping.md#bm-03](../rules/architecture/data-mapping.md#mapping-responsibility) | `mapping-responsibility` |
| [architecture/data-mapping.md#bm-07](../rules/architecture/data-mapping.md#directional-mapping) | `directional-mapping` |
| [architecture/data-mapping.md#bm-09](../rules/architecture/data-mapping.md#mapping-path-verification) | `mapping-path-verification` |
| [architecture/dependency-composition.md#cl-05](../rules/architecture/dependency-composition.md#explicit-dependencies) | `explicit-dependencies` |
| [coding/code-design.md#cl-02](../rules/coding/code-design.md#substitutability) | `substitutability` |
| [coding/code-design.md#cl-06](../rules/coding/code-design.md#construction-entrypoints) | `construction-entrypoints` |
| [coding/code-design.md#cl-08](../rules/coding/code-design.md#interface-capabilities) | `interface-capabilities` |
| [coding/code-design.md#nd-05](../rules/coding/code-design.md#implementation-notes) | `implementation-notes` |
| [coding/collections-and-ownership.md#co-01](../rules/coding/collections-and-ownership.md#collection-ownership) | `collection-ownership` |
| [coding/collections-and-ownership.md#co-02](../rules/coding/collections-and-ownership.md#snapshots-and-views) | `snapshots-and-views` |
| [coding/collections-and-ownership.md#co-03](../rules/coding/collections-and-ownership.md#order-and-duplicates) | `order-and-duplicates` |
| [coding/collections-and-ownership.md#co-04](../rules/coding/collections-and-ownership.md#traversal-mutation) | `traversal-mutation` |
| [coding/collections-and-ownership.md#co-09](../rules/coding/collections-and-ownership.md#collection-verification) | `collection-verification` |
| [coding/concurrency-and-async.md#co-05](../rules/coding/concurrency-and-async.md#compound-atomicity) | `compound-atomicity` |
| [coding/concurrency-and-async.md#ca-01](../rules/coding/concurrency-and-async.md#task-ownership) | `task-ownership` |
| [coding/concurrency-and-async.md#ca-02](../rules/coding/concurrency-and-async.md#execution-resources) | `execution-resources` |
| [coding/concurrency-and-async.md#ca-04](../rules/coding/concurrency-and-async.md#deadline-budget) | `deadline-budget` |
| [coding/concurrency-and-async.md#ca-05](../rules/coding/concurrency-and-async.md#cancellation-and-termination) | `cancellation-and-termination` |
| [coding/concurrency-and-async.md#ca-07](../rules/coding/concurrency-and-async.md#task-completion-contract) | `task-completion-contract` |
| [coding/concurrency-and-async.md#ca-08](../rules/coding/concurrency-and-async.md#execution-and-blocking) | `execution-and-blocking` |
| [coding/concurrency-and-async.md#ca-09](../rules/coding/concurrency-and-async.md#context-propagation) | `context-propagation` |
| [coding/concurrency-and-async.md#ca-10](../rules/coding/concurrency-and-async.md#lock-scope) | `lock-scope` |
| [coding/domain-modeling.md#vo-03](../rules/coding/domain-modeling.md#value-immutability) | `value-immutability` |
| [coding/domain-modeling.md#vo-05](../rules/coding/domain-modeling.md#value-normalization) | `value-normalization` |
| [coding/domain-modeling.md#vo-06](../rules/coding/domain-modeling.md#value-operations) | `value-operations` |
| [coding/domain-modeling.md#vo-07](../rules/coding/domain-modeling.md#value-restoration) | `value-restoration` |
| [coding/domain-modeling.md#st-04](../rules/coding/domain-modeling.md#operation-results) | `operation-results` |
| [coding/domain-modeling.md#st-06](../rules/coding/domain-modeling.md#exhaustive-result-handling) | `exhaustive-result-handling` |
| [coding/domain-modeling.md#st-08](../rules/coding/domain-modeling.md#model-extensibility) | `model-extensibility` |
| [coding/domain-modeling.md#st-09](../rules/coding/domain-modeling.md#result-facts) | `result-facts` |
| [coding/domain-modeling.md#st-10](../rules/coding/domain-modeling.md#model-verification) | `model-verification` |
| [coding/domain-modeling.md#eq-01](../rules/coding/domain-modeling.md#identity-semantics) | `identity-semantics` |
| [coding/domain-modeling.md#eq-04](../rules/coding/domain-modeling.md#identity-lifecycle) | `identity-lifecycle` |
| [coding/error-handling.md#rf-05](../rules/coding/error-handling.md#dynamic-failure-classification) | `dynamic-failure-classification` |
| [coding/nullability.md#jn-08](../rules/coding/nullability.md#third-party-null-contract) | `third-party-null-contract` |
| [coding/nullability.md#jn-09](../rules/coding/nullability.md#null-contract-evolution) | `null-contract-evolution` |
| [coding/numbers-dates-text.md#nt-01](../rules/coding/numbers-dates-text.md#numeric-representation) | `numeric-representation` |
| [coding/numbers-dates-text.md#nt-02](../rules/coding/numbers-dates-text.md#exact-numeric-sources) | `exact-numeric-sources` |
| [coding/numbers-dates-text.md#nt-03](../rules/coding/numbers-dates-text.md#rounding-policy) | `rounding-policy` |
| [coding/numbers-dates-text.md#nt-04](../rules/coding/numbers-dates-text.md#numeric-range-checks) | `numeric-range-checks` |
| [coding/numbers-dates-text.md#nt-06](../rules/coding/numbers-dates-text.md#temporal-representation) | `temporal-representation` |
| [coding/numbers-dates-text.md#nt-07](../rules/coding/numbers-dates-text.md#timezone-conversion) | `timezone-conversion` |
| [coding/numbers-dates-text.md#nt-08](../rules/coding/numbers-dates-text.md#durations-and-calendar-periods) | `durations-and-calendar-periods` |
| [coding/numbers-dates-text.md#nt-09](../rules/coding/numbers-dates-text.md#time-source) | `time-source` |
| [coding/numbers-dates-text.md#nt-10](../rules/coding/numbers-dates-text.md#temporal-parsing-formatting) | `temporal-parsing-formatting` |
| [coding/numbers-dates-text.md#nt-11](../rules/coding/numbers-dates-text.md#character-encoding) | `character-encoding` |
| [coding/numbers-dates-text.md#nt-12](../rules/coding/numbers-dates-text.md#text-length-units) | `text-length-units` |
| [coding/numbers-dates-text.md#nt-13](../rules/coding/numbers-dates-text.md#text-transformations) | `text-transformations` |
| [coding/numbers-dates-text.md#nt-14](../rules/coding/numbers-dates-text.md#data-boundary-verification) | `data-boundary-verification` |
| [coding/resource-lifecycle.md#cl-03](../rules/coding/resource-lifecycle.md#initialization-readiness) | `initialization-readiness` |
| [coding/resource-lifecycle.md#cl-09](../rules/coding/resource-lifecycle.md#shared-lifecycle) | `shared-lifecycle` |
| [coding/resource-lifecycle.md#cl-10](../rules/coding/resource-lifecycle.md#lifecycle-verification) | `lifecycle-verification` |
| [coding/resource-lifecycle.md#co-07](../rules/coding/resource-lifecycle.md#lazy-resource-lifetime) | `lazy-resource-lifetime` |
| [coding/resource-lifecycle.md#ex-07](../rules/coding/resource-lifecycle.md#partial-acquisition) | `partial-acquisition` |
| [coding/resource-lifecycle.md#ex-08](../rules/coding/resource-lifecycle.md#resource-close-contract) | `resource-close-contract` |
| [coding/resource-lifecycle.md#ca-11](../rules/coding/resource-lifecycle.md#controlled-shutdown) | `controlled-shutdown` |
| [coding/type-safety.md#rf-04](../rules/coding/type-safety.md#dynamic-contract-validation) | `dynamic-contract-validation` |
| [interfaces/api-contracts.md#jn-12](../rules/interfaces/api-contracts.md#api-absence-representation) | `api-absence-representation` |
| [quality/performance.md#co-06](../rules/quality/performance.md#bounded-accumulation) | `bounded-accumulation` |
| [quality/rule-verification.md#au-01](../rules/quality/rule-verification.md#verification-coverage) | `verification-coverage` |
| [quality/rule-verification.md#rf-08](../rules/quality/rule-verification.md#dynamic-control-verification) | `dynamic-control-verification` |
| [quality/rule-verification.md#nd-07](../rules/quality/rule-verification.md#document-verification) | `document-verification` |
| [quality/rule-verification.md#au-02](../rules/quality/rule-verification.md#reproducible-check-configuration) | `reproducible-check-configuration` |
| [quality/rule-verification.md#au-03](../rules/quality/rule-verification.md#actual-check-scope) | `actual-check-scope` |
| [quality/rule-verification.md#au-04](../rules/quality/rule-verification.md#check-configuration-validation) | `check-configuration-validation` |
| [quality/rule-verification.md#au-06](../rules/quality/rule-verification.md#evidence-version-validity) | `evidence-version-validity` |
| [quality/rule-verification.md#au-08](../rules/quality/rule-verification.md#diagnostic-classification) | `diagnostic-classification` |
| [quality/rule-verification.md#au-09](../rules/quality/rule-verification.md#effective-merge-gates) | `effective-merge-gates` |
| [quality/security.md#rf-02](../rules/quality/security.md#dynamic-target-authorization) | `dynamic-target-authorization` |
| [quality/testing.md#ca-12](../rules/quality/testing.md#controlled-interleaving) | `controlled-interleaving` |
| [workflow/git-pr-review.md#au-07](../rules/workflow/git-pr-review.md#automated-fix-review) | `automated-fix-review` |
| [workflow/rule-governance.md#rf-06](../rules/workflow/rule-governance.md#suppression-scope) | `suppression-scope` |
| [workflow/rule-governance.md#rf-07](../rules/workflow/rule-governance.md#generated-code-exceptions) | `generated-code-exceptions` |
| [workflow/rule-governance.md#au-05](../rules/workflow/rule-governance.md#precise-violation-baseline) | `precise-violation-baseline` |

## 六、19 條「改引用」的覆蓋疑點

本節只比對原分類摘要、現行 Java 附句及現行共通。**缺少原全文，因此每列都不能證明沒有遺漏。**「摘要可涵蓋」只表示可見摘要沒有額外缺口；「待補證」指出現行共通不夠直接或需核准的部分。引用指向共通正文，不用本次補寫的驗收反向證明當年正文完整。

| 歷史 ID／現行位置 | 共通對照 | 可確認涵蓋與缺口 | 建議 |
| --- | --- | --- | --- |
| [JT-03 第 3 條（歷史；現行整條保留）](../rules/stacks/java/common/types-and-generics.md#java-input-output-type-relation)（歷史第 3 條；全部去向：[java-input-output-type-relation](../rules/stacks/java/common/types-and-generics.md#java-input-output-type-relation)） | [型別安全](../rules/coding/type-safety.md) | 摘要可涵蓋：容器與泛型要求真實輸入輸出關聯、禁止無保證回傳；現行 Java 簽章／呼叫端不補轉型沒有可見額外缺口。 | 可移除重述，保留泛型機制驗收；原全文缺失須保留註記。 |
| [JT-06 第 6 條（歷史；現行整條保留）](../rules/stacks/java/common/types-and-generics.md#java-business-data-shape)（歷史第 6 條；全部去向：[java-business-data-shape](../rules/stacks/java/common/types-and-generics.md#java-business-data-shape)） | [型別安全](../rules/coding/type-safety.md) | 摘要可涵蓋：固定結構用明確型別、動態映射鍵值明確；Map／Object[] 只是具體反例。 | 直接引用型別安全；不要宣稱已逐字還原原要求。 |
| [JN-06 第 6 條](../rules/coding/validation.md#責任分工) | [資料驗證](../rules/coding/validation.md)、[錯誤處理](../rules/coding/error-handling.md)、[領域建模](../rules/coding/domain-modeling.md) | 摘要可涵蓋：邊界結構驗證、建立有效、可信內部不逐層重查與缺陷分類均有明文。 | 引用三個主要來源，非空預設留 Java JN-11。 |
| [JN-10 第 10 條](../rules/stacks/java/common/null-and-optional.md#驗收要求) | [規範驗證](../rules/quality/rule-verification.md)、[共通測試策略](../rules/quality/testing.md)、[型別安全](../rules/coding/type-safety.md) | 待補證：共通有空值行為與測試型別安全，但沒有 Optional／非空標註及全部分類的 Java 覆蓋清單。 | 保留 Java 機制驗收及 Optional 分類覆蓋；可移除正文純入口。 |
| [VO-01 第 1 條（歷史；現行整條移除）](../rules/coding/domain-modeling.md#專屬型別)（歷史第 1 條；全部去向：[專屬型別](../rules/coding/domain-modeling.md#專屬型別)） | [領域建模](../rules/coding/domain-modeling.md) | 摘要可涵蓋：容易混用的值使用專屬型別，內部介面維持型別，一般描述資料不強制包裝。 | 可引用專屬型別；原文中的更多採用例外無法確認。 |
| [VO-02 第 2 條（歷史；現行整條移除）](../rules/coding/domain-modeling.md#專屬型別)（歷史第 2 條；全部去向：[專屬型別](../rules/coding/domain-modeling.md#專屬型別)、[責任分工](../rules/coding/validation.md#責任分工)、[cl-06](../rules/coding/code-design.md#construction-entrypoints)） | [領域建模](../rules/coding/domain-modeling.md)、[資料驗證](../rules/coding/validation.md) | 摘要可涵蓋：建立驗證及格式有效不代表存在性／授權均有明文；所有建立入口一致另由 cl-06 承接。 | 主要連結應同時指建立入口，避免只引用領域建模而漏掉入口一致。 |
| [VO-10 第 10 條（歷史；現行整條保留）](../rules/stacks/java/common/value-objects.md#java-value-test-coverage)（歷史第 10 條；全部去向：[java-value-test-coverage](../rules/stacks/java/common/value-objects.md#java-value-test-coverage)） | [領域建模](../rules/coding/domain-modeling.md)、[共通測試策略](../rules/quality/testing.md) | 待補證：早期共通只有型別誤用、無效建立與狀態轉換；完整值物件覆蓋清單寫在未列管摘要。一般測試策略也未明訂「無業務邏輯存取方法免逐一測試」。 | 先確認摘要歸屬；保留 Java equals／record 及存取方法的原有驗收範圍。 |
| [ST-02 第 2 條（歷史；現行整條保留）](../rules/stacks/java/common/states-and-results.md#java-required-state-data)（歷史第 2 條；全部去向：[java-required-state-data](../rules/stacks/java/common/states-and-results.md#java-required-state-data)） | [領域建模](../rules/coding/domain-modeling.md) | 摘要可涵蓋：不同狀態分別以型別表達必要資料；狀態碼加多可空欄位只是違規情境。 | 可移除重述；保留狀態資料驗收。 |
| [ST-03 第 3 條（歷史；現行整條保留）](../rules/stacks/java/common/states-and-results.md#java-business-state-transitions)（歷史第 3 條；全部去向：[java-business-state-transitions](../rules/stacks/java/common/states-and-results.md#java-business-state-transitions)） | [領域建模](../rules/coding/domain-modeling.md) | 摘要可涵蓋：業務操作控制轉換、必要檢查、不得任改狀態均有明文。拒絕後副作用另由測試策略涵蓋。 | 引用狀態建模及驗收，setter 例子不需獨立條目。 |
| [ST-05 第 5 條（歷史；現行整條保留）](../rules/stacks/java/common/states-and-results.md#java-typed-business-failures)（歷史第 5 條；全部去向：[java-typed-business-failures](../rules/stacks/java/common/states-and-results.md#java-typed-business-failures)） | [錯誤處理](../rules/coding/error-handling.md) | 摘要可涵蓋：明確結果型別與原因、不得以布林／文字隱藏原因、技術故障用例外均有明文。 | 保留 Java 結果表示範例即可，毋須另一套分類。 |
| [BM-01 第 1 條（歷史；現行整條移除）](../rules/architecture/boundary-objects.md#隔離與拆分)（歷史第 1 條；全部去向：[隔離與拆分](../rules/architecture/boundary-objects.md#隔離與拆分)） | [邊界物件](../rules/architecture/boundary-objects.md) | 摘要可涵蓋：對外／跨模組公開契約、禁止直接回傳內部模型與不強制每層 DTO 已確認。 | 只在已確認邊界範圍刪除重述，不擴大成全部方法不得回傳 Entity。 |
| [BM-02 第 2 條（歷史；現行整條保留）](../rules/stacks/java/common/boundary-mapping.md#java-mapping-fields)（歷史第 2 條；全部去向：[java-mapping-fields](../rules/stacks/java/common/boundary-mapping.md#java-mapping-fields)） | [資料映射](../rules/architecture/data-mapping.md)、[API 操作語意與介面設計](../rules/interfaces/api-contracts.md)、[安全](../rules/quality/security.md) | 摘要可涵蓋：明確允許欄位、來源新增不自動帶入，以及可信欄位伺服器決定、最小揭露均有明文。 | 引用映射／API／安全三個來源，不能只保留映射的欄位名稱對應。 |
| [BM-04 第 4 條（歷史；現行整條保留）](../rules/stacks/java/common/boundary-mapping.md#java-mapping-integrity)（歷史第 4 條；全部去向：[java-mapping-integrity](../rules/stacks/java/common/boundary-mapping.md#java-mapping-integrity)） | [錯誤處理](../rules/coding/error-handling.md)、[資料驗證](../rules/coding/validation.md)、[資料映射](../rules/architecture/data-mapping.md) | 待補證：錯誤處理明訂分類、禁止預設值及部分結果；「略過欄位或半成品」只在未列管映射摘要直接出現，原條文細節無法還原。 | 暫保留 Java 完整性驗收，正式提升或移回 Java 由使用者決定。 |
| [BM-06 第 6 條（歷史；現行整條保留）](../rules/stacks/java/common/boundary-mapping.md#java-mutable-isolation)（歷史第 6 條；全部去向：[java-mutable-isolation](../rules/stacks/java/common/boundary-mapping.md#java-mutable-isolation)） | [邊界物件](../rules/architecture/boundary-objects.md)、[程式碼設計與公開介面](../rules/coding/code-design.md) | 摘要可涵蓋隔離與巢狀可變內容；共用不可變值／不強制深複製需合讀值物件及集合規則，單獨的邊界連結不足以表明完整範圍。 | 補正主要引用組合後才能移除 Java 說明，不應把未列管摘要當唯一依據。 |
| [BM-08 第 8 條（歷史；現行整條保留）](../rules/stacks/java/common/boundary-mapping.md#java-mapping-ownership)（歷史第 8 條；全部去向：[java-mapping-ownership](../rules/stacks/java/common/boundary-mapping.md#java-mapping-ownership)） | [資料映射](../rules/architecture/data-mapping.md)、[共用能力](../rules/architecture/shared-capabilities.md)、[框架與依賴組裝](../rules/architecture/dependency-composition.md) | 摘要可涵蓋：簡單轉換留負責元件，複雜／重複才抽 Mapper，依架構方向與責任共用；介面非強制由依賴組裝承接。 | 引用責任配置及介面原則，移除純 Java 重述。 |
| [CL-01 第 1 條（歷史；現行整條保留）](../rules/stacks/java/common/classes-and-construction.md#java-interface-purpose)（歷史第 1 條；全部去向：[java-interface-purpose](../rules/stacks/java/common/classes-and-construction.md#java-interface-purpose)） | [框架與依賴組裝](../rules/architecture/dependency-composition.md)、[模組責任與公開入口](../rules/architecture/module-boundaries.md) | 摘要可涵蓋：依架構、替換、多型引入抽象，DI 可注入具體類別；不能因單一實作省略隔離須合讀架構邊界。 | 保留共同介面用途驗收及架構來源；原全文是否另有能力條件無法確認。 |
| [CO-08 第 8 條（歷史；現行整條保留）](../rules/stacks/java/common/collections-and-ownership.md#java-batch-failure-state)（歷史第 8 條；全部去向：[java-batch-failure-state](../rules/stacks/java/common/collections-and-ownership.md#java-batch-failure-state)） | [錯誤處理](../rules/coding/error-handling.md) | 待補證：多步驟規則涵蓋全部／部分成功及項目對應；「拋例外不代表未修改」和「不要求全部集合具交易能力」只在未列管摘要直接出現。 | 暫不刪 Java 附句；核准共通失敗後狀態義務或明確移回 Java。 |
| [LS-01 第 1 條（歷史；現行整條保留）](../rules/stacks/java/common/lambda-and-stream.md#java-intent-readability)（歷史第 1 條；全部去向：[java-intent-readability](../rules/stacks/java/common/lambda-and-stream.md#java-intent-readability)） | [程式碼設計與公開介面](../rules/coding/code-design.md)、[命名與可讀性](../rules/coding/naming.md) | 摘要可涵蓋責任、可讀性與不訂行數；不強制 Stream／每個 Lambda 抽方法是 Java 表達選擇，沒有反向強制規則。 | 可移除純引用項，保留示例或語法章的適用說明。 |
| [ND-02 第 2 條（歷史；現行整條保留）](../rules/stacks/java/common/naming-packages-docs.md#java-specific-responsibility)（歷史第 2 條；全部去向：[java-specific-responsibility](../rules/stacks/java/common/naming-packages-docs.md#java-specific-responsibility)） | [命名與可讀性](../rules/coding/naming.md)、[程式碼設計與公開介面](../rules/coding/code-design.md) | 待補證：類別名稱與責任一致、不得用籠統後綴掩蓋不同用途，未在現行共通找到直接條文；沒有一律禁止 Service／Utils 的規則。 | 先保留 Java 第 2 條及命名驗收；只有核准共通來源後才能移除附句，不得新增後綴禁令。 |

## 尚未執行事項

本清單的所有選項均待決定：未提升可見性、結果接收、跨型別相等或其他新跨語言義務；未移動或刪除任何正文條目；未重編正式條號；未合併／刪除 Java 主題；未改動歷史規則錨點；未自行還原或補造 19 條遺失原文。上述動作必須在使用者選定方向後另開正文整理批次，建立新的基準及逐條追溯。

## 七、獨立審閱後仍須決定的事項

本節是待決事項，不授權改動規則正文。原要求已先還原；「零逐字重複」不代表沒有語意重複。以下保留重疊是正文不變與不降低要求優先的結果。

| 審閱項目／位置 | 選項與建議 |
| --- | --- |
| H1：value-objects、states-and-results、boundary-mapping、numbers-dates-text、lambda-and-stream、naming-packages-docs 的驗收尾句 | 六句已依 `6a16349` 逐字還原。可保留各文件治理入口，或日後集中索引；建議保留，因句子另含工具、既有資料、外部契約等文件專屬的不得豁免條件，不能當成無效重複刪除。 |
| H2：[規範驗證](../rules/quality/rule-verification.md#架構檢查與可測試性)「不因此強制每個類別建立介面」及「部分成功、降級與補償失敗」 | 已還原政策原句。日後可保留政策與驗收的不同責任，或經核准合併；建議保留原政策，驗收只列證據，不以去重為由再刪政策。 |
| M1：VO-10、JN-10、LS-8、JV-10／11、ND-1／2、LS-1／2 | 本次保留完整原斷言，Java 機制僅補充。日後若刪除共同背景，先確認共通列逐項承接；ND 後綴與 LS 複雜邏輯目前沒有完整共通依據，建議留 Java。 |
| M2：[空值語意](../rules/coding/nullability.md)、[映射驗收](../rules/architecture/data-mapping.md#acceptance-mapping-paths) | 已撤回寫入空值正文的新驗收句與錨點。三種更新意圖的原斷言補入既有映射驗收列，依據 bm-09 與既有空值語意；Java 第 5 條的表示失效情境另列。日後若改歸位方向須一併決定，不再把曾新增的句子描述成基準既有驗收。 |
| M4：共通驗收歸位 | 選項 A：按規則檔維護驗收，規範驗證只維護共同把關；選項 B：集中規範驗證並從各規則引用。建議 A，專屬情境緊鄰依據，規範驗證維持跨主題機制；但本次不執行搬移，已有指向規範驗證的介面用途與多步驟案例維持現況。 |
| M4：[領域建模](../rules/coding/domain-modeling.md#模型驗證與還原)、[資料映射](../rules/architecture/data-mapping.md#轉換要求)與補充契約驗收 | 撤回本階段新加的失敗分類連結與三列專屬型別／狀態詳細驗收；完整原斷言保留 Java。基準已有的領域驗證摘要、失敗分類與結果驗收，以及映射摘要與實際路徑驗收仍有重疊。建議先決定 A／B，再整合既有內容，本次不刪正文。 |
| L2：[null／Optional 第 10 條](../rules/stacks/java/common/null-and-optional.md#契約維護與對外表示) | 「本文件驗收表」的 API 案例分散於共同引用與 Java 覆蓋列；建議日後改指整個驗收章節或確切語意錨點，現在不改正文。（以上為歷史決策敘述；第五次審閱後的現行入口為[驗收章節](../rules/stacks/java/common/null-and-optional.md#驗收要求)，已無正文第 10 條。） |
| L2：[VO-10 第 10 條（歷史；現行整條保留）](../rules/stacks/java/common/value-objects.md#java-value-test-coverage)（歷史第 10 條；全部去向：[java-value-test-coverage](../rules/stacks/java/common/value-objects.md#java-value-test-coverage)） | 還原路徑的詳細斷言位於共同引用；建議改為精確引用共同還原與 Java 覆蓋兩處。 |
| L2：[ST-10 第 10 條（歷史；現行整條保留）](../rules/stacks/java/common/states-and-results.md#java-model-acceptance)（歷史第 10 條；全部去向：[java-model-acceptance](../rules/stacks/java/common/states-and-results.md#java-model-acceptance)） | 使用端分支及封閉模型已引用共通，並非下方 Java 表格列；建議改指共同處理完整性驗收。 |
| L2：[BM-04 第 4 條（歷史；現行整條保留）](../rules/stacks/java/common/boundary-mapping.md#java-mapping-integrity)（歷史第 4 條；全部去向：[java-mapping-integrity](../rules/stacks/java/common/boundary-mapping.md#java-mapping-integrity)） | 部分成功驗收已在規範驗證，不能只指下方 Java 表格；建議日後改精確引用部分操作列。 |
| L2：[NT-14 第 14 條（歷史；現行整條保留）](../rules/stacks/java/common/numbers-dates-text.md#java-boundary-verification)（歷史第 14 條；全部去向：[java-boundary-verification](../rules/stacks/java/common/numbers-dates-text.md#java-boundary-verification)） | java.time 與字串轉換案例主要由共同驗收及 Java 實際路徑引言承接；建議改指整個驗收章節，不宣稱 Java 表內均有獨立列。 |
| L6：[集合開頭](../rules/stacks/java/common/collections-and-ownership.md)「由後續 Java 主題展開」 | 主題已存在，可改現行連結；因位於正文，本次保留，建議下次正文整理處理。 |
| L6：[映射「既有共同保證的落實」](../rules/architecture/data-mapping.md#既有共同保證的落實) | 可改中性標題或刪除重述；先處理第一節未列管義務，不能連同義務直接刪除。 |
| L6：[規範驗證](../rules/quality/rule-verification.md#測試程式碼)「遵守下列型別安全要求」 | 「下列」本來已沒有明確對象；建議日後改成型別安全文件連結，本次保持基準正文。 |
| L7：BM 轉換失敗與半成品、ST 獨立業務面向、VO 不只測建立成功、JT 外部非法資料、JN 必填拒絕與故障分類 | 這五組 Java 驗收仍與共通正文或驗收有換句話說的重複。選項是先核准共通依據並拆出引用，或保留 Java 原斷言等待正文整理；建議後者優先，避免再次縮小範圍。機械檢查不宣稱消除此類重複。 |
| L5：[邊界隔離驗收](../rules/architecture/boundary-objects.md#acceptance-boundary-isolation)後半 | 本階段已把共用不可變值與不強制全面複製寫成驗收，依據包含尚未列管的映射摘要。這是既有適用邊界的具體核對，並非新增強制複製，但不能據此宣稱摘要已正式提升。選項為正式列管來源或把此段驗收移回 Java；建議先決定第一節 BM-06，原要求保持。 |

### AU-01／07／09 與第六節的範圍

原分類「改引用」共 22 條；第六節限於十五份 Java 文件的 19 條，故未包含自動檢查主題 AU-01、AU-07、AU-09。這三條來源是討論摘要，從未有來源 Rule 檔或驗收表；與第六節曾有 Java 原文但未提交的證據限制不同。第一輪遷移紀錄已記載後續確認與實際落實，故不能沿用分類快照把 AU-09 當成現行未核准規則；也不能混入 153 條 Java 條文的 84／69 統計。

| 歷史 ID | 現行對照與尚待確認 |
| --- | --- |
| AU-01 | [規範驗證](../rules/quality/rule-verification.md)的共同把關與檢查對應；原摘要是規範對應自動檢查、行為測試或人工審查並標示缺口；已由 au-01 承接，證據限於討論摘要而非遺失的 Java 條文。 |
| AU-07 | [自動修正的審查](../rules/workflow/git-pr-review.md#automated-fix-review)：原摘要要求審查差異與行為契約，不得加未核准抑制、移除必要測試或降低規則；現行共同條款有對應，並非既有違規基準那一條。 |
| AU-09 | [Git／PR](../rules/workflow/git-pr-review.md)與[規範驗證](../rules/quality/rule-verification.md)的合併把關；原摘要要求必要檢查的合併阻擋實際有效，不只提供報告；分類快照原為待確認，後續遷移紀錄記載已確認落實至 au-09。建議保留兩份紀錄的時間先後，不把歷史待確認誤列為本輪待決。 |

## 八、第二次審閱補列的知情事項

下列僅請使用者確認，不執行新增、刪除或搬移規則的決策。

| 位置 | 現況、選項與建議 |
| --- | --- |
| [ND 歷史第 4 條](../rules/stacks/java/common/naming-packages-docs.md#acceptance-java-javadoc-contract) | fffd115 依正文新增 Javadoc 契約驗收列，沒有原驗收追溯 ID。選項為確認保留此列，或日後核准整合；建議保留語言機制的驗收，未在本次改動此列。 |
| [BM 歷史第 5 條](../rules/stacks/java/common/boundary-mapping.md#acceptance-java-update-intent) | fffd115 依正文新增 Java 欄位、預設值與反序列化不得合併意圖的驗收列，沒有原驗收追溯 ID。建議確認保留；若整合須保留全部表示限制。 |
| [VO 歷史第 10 條補充](../rules/stacks/java/common/value-objects.md#acceptance-java-value-method-coverage) | 句尾補充 equals()、hashCode()、record 產生方法與還原路徑的適用案例，源於 fffd115 修正，沒有獨立原片段。建議確認保留為例示，不得限縮前文完整覆蓋要求。 |
| [JN 第 10 條補充](../rules/stacks/java/common/null-and-optional.md#acceptance-java-optional-coverage) | 句尾補充 Optional、非空標註與實際 API 路徑，源於 fffd115 修正，沒有獨立原片段。建議確認保留為適用案例，不取代全部有值與缺值分類。 |
| [LS 歷史第 8 條補充](../rules/stacks/java/common/lambda-and-stream.md#acceptance-java-functional-exceptions) | 句尾補充 Lambda／Stream 函式介面的例外宣告限制與轉換路徑，源於 fffd115 修正，沒有獨立原片段。建議確認保留，仍須驗證所有適用處理階段的失敗。 |
| 規範驗證的舊隱含錨點 | 標題從「語言與新增共通主題驗收入口」改為「語言與共通主題驗收入口」，儲存庫內連結有效，外部引用無從查證。是否為舊標題補相容錨點須由使用者決定；建議有外部使用者時保留舊入口。本次不改規則檔或新增錨點。 |

## 九、正文整理階段 A 的核准與執行狀態

2026-11-09：使用者已核准依各列建議進入正文整理，並明確核准 CA-06、CO-08 兩項跨語言義務。上方「尚未執行」「待決」等敘述保留為決策前的歷史紀錄；現行狀態以下表為準。新基準為 `350668eb14ede247af22c782323beebf940c2a5f`。逐句機器紀錄與執行規則見[作業說明](body-restructuring-guide.md)。

| 範圍 | 核准方向與階段 A 結果 | 後續工作 |
| --- | --- | --- |
| R4-L1／L2 收尾 | `350668e` 恢復三份引言的實際使用路徑，JN 概括引用及 JT 明確規範驗證引用。 | 已完成；完整雜湊為固定正文新基準。 |
| 新去向工具 | `9d81b4a` 建立 15 份分檔紀錄與 153 ID 對照；`9e21f34` 補作業說明及目的小節、共通來源、驗收內容檢查。 | 其他工作者只維護被分派檔案與其紀錄。 |
| 一／CA-03、ST-01、BM-04 | 選 B；`4b33eb0` 移除共通相應摘要，保留 Java 正文與驗收；但 BM-04 並未完整承接刪句，第五次審閱已恢復共通原句並延後刪除；逐項依據見[共通側紀錄](body-restructuring-common-decisions.md)。 | 未改動三份 Java 文件，後續依各自分類整理。 |
| 一／CA-06 | 選 A；`b1d2f33` 正式列管結果接收／不得丟棄故障，與 ca-01 以引用分工並補接收驗收。 | Java Future 等語言機制留後續併發批次。 |
| 一／CO-08 | 選 A；`5a16124` 正式列管批次失敗後狀態，保留不強制全部集合交易能力。 | 集合若只剩失敗狀態提醒，再由協調者整份併入例外；本階段未合併。 |
| 一／其餘既有來源與七／L5 | `4b33eb0` 登錄映射各來源、ST-03／VO-02、EX-06／08、邊界及適用範圍、規範效力；不新增義務或驗收。 | 共通驗收最終歸位依 M4 後續整合。 |
| 一／VO-10 | 暫停刪除原摘要首句；現行共同來源未直接逐項承接全部值型別邊界值覆蓋及不能只測建立成功，泛稱重要行為測試不足以證明覆蓋。 | 保留原文與 Java 驗收，待獨立審閱確認足夠來源後再收斂；未自行提升或補驗收。 |
| 二／正文形式 | 核准小標題＋語意錨點；`cdcd548` 以 null／Optional 完成樣板，原分組標題留作入口。 | 其餘 14 份依此整理；數值時間文字、併發、邊界映射保留獨立檔案。 |
| 三／JN 引用型條文 | JN-06 移除、JN-08 保留增量、JN-09／12 拆分、JN-10 轉驗收入口；全部共同來源與句子去向已登錄。 | 其餘引用型條文未執行，BM-04／CO-08 依上述核准，ND-02 整條保留。 |
| 四／JN 保留條文 | JN-01／02／03 留語言增量並連共通背景，JN-04／07 拆分；JN-05／11 整條保留，不提升全語言預設非空。 | 其他保留條文未執行；標為「是／可能」的新義務整條留 Java。 |
| 五／74 個共通歷史錨點 | 已核准改語意名稱並保留同位置相容別名，但階段 A 未執行。 | 後續統一改名、更新連結及集中別名清單；不要由單檔工作者先改。 |
| 六／19 條遺失原文 | JN-06／10 已在去向理由記「整理前原文未提交，無法證明完整覆蓋」。 | 其餘 17 條後續處理，同樣保留證據限制，不能宣稱已還原未提交原文。 |
| 七／H1、H2、L7 | 維持現狀；沒有為去重刪除例外句、政策或語意重疊驗收。 | 繼續保留。 |
| 七／M4 | 核准 A，驗收跟規則檔，規範驗證留跨主題機制；階段 A 未做既有驗收搬移。 | 後續獨立批次整理，保留全部斷言。 |
| 七／L2、L6 | JN-10 入口已由整個驗收章節及精確連結承接；其餘失準引用與正文殘留未處理。 | 各主題批次處理 L2；集合開頭、映射舊標題及規範驗證「下列」留後續，不藉共通收斂擴大本次範圍。 |
| 八／五處補充驗收 | 使用者確認保留；JN 的 Optional／非空標註／API 句尾完整未動，其餘四處未改。 | 不因沒有獨立歷史片段而刪除。 |
| 八／舊隱含錨點 | `4b33eb0` 補舊標題「語言與新增共通主題驗收入口」相容入口，正文不複製。 | 此別名與未來 74 個歷史別名應一併維護。 |

### 第五次審閱後的修正狀態

原第九節保留為階段 A 首輪紀錄；本段更新其現況，不改動前面 153／19 條歷史清冊。

- BM-04 選 B 不變，但 Java 尚未承接「不得略過欄位或產生不完整物件掩蓋失敗」；共通原句已恢復，後續工作者逐字移入，協調者全部合併後再刪。不能再以原 Java 第 4 條或半成品驗收聲稱已完整承接。
- JN-03 補回「不得掩蓋缺值」；JN-06 保留整份引用並補一般建立 cl-06 與狀態建模來源；JN-02 補捕捉與處置責任證據。
- JN 樣板依新結構逐句登錄被刪子句及共通原文，JN-02／03 的去向種類統一為「拆分」，只改分類紀錄，沒有降低要求。
- CA-06／CO-08 已提升的 Java 條文後續按混合拆分，不再套原「是」的整條保留。CA-03、ST-01 及 BM-04 選 B 整條留 Java；其餘 14 份文件本輪未改。
- VO-10 摘要首句按使用者決定維持現狀；相關 Java 內容不得只因這句共通摘要就移除。
- 七／L2 的「null／Optional 第 10 條」與原連結是歷史位置；目前正文入口已移除，現行為[驗收章節](../rules/stacks/java/common/null-and-optional.md#驗收要求)，第一欄使用純文字「覆蓋要求（原驗收入口）」而非自我連結。
- CA-06／CO-08 的規則與驗收列本輪不改；重疊分工及撤回後需同步的位置見[共通決策](body-restructuring-common-decisions.md)。
- 工作者僅准改被分派的 Java 檔與同名 JSON；共用遷移、待決清單、驗證紀錄由協調者統一更新。新工具已保護驗收非表格內容、整條保留、逐句種類、未登錄增文與共通清單檔名，並恢復清冊及空驗收檢查。

其餘 14 份平行工作仍須等本輪獨立複核通過後才展開；本紀錄不代表已通過獨立審閱。

### 第九節續：第六次審閱修正

正文基準仍為 `350668eb14ede247af22c782323beebf940c2a5f`。本輪只調整 JN 尾段結構；固定 19 條整條保留清單、移入及共同驗收清單規則由工具核對。新增正向演練與結構掃描，詳見[第六次修正回報](body-restructuring-review-6.md)。工作者可採更保守保留但必須指出具體原因；機器列出原判斷與實際去向，不能替代語意審閱。其餘 14 份仍 pending，未啟動平行整理；共通提升與舊決策不變。

### 第九節續：第七次審閱後可分派狀態

第七次審閱確認可展開其餘 14 份，分派前的三條規則已寫入[作業說明](body-restructuring-guide.md)：拆分且整句移除須同列 Java／共通去向；VO-10、ST-10、RF-07、RF-08、NT-14 先整條保留並回報協調者；第四節「否」預設原文不動且種類填保留增量。工具另要求拆分／保留增量仍有本文件 Java 小節與至少一句未移除正文。本輪未改任何規範句子或既有句子處置，仍為 completed=1、pending=14，由協調者接續分派；R7-M4 收尾工具與 R7-M5 可讀性事項本輪不執行。

### 階段 B 合併後現行定位

14 份工作者文件已合併，連同樣板共 15 份完成；前三、四、六節的原判斷與建議保留為歷史決策證據，連結已更新為現行去向。153 條最終對照、保守保留理由與未執行事項由[階段 B 紀錄](body-restructuring-stage-b.md)集中列出。五條驗收入口 VO-10、ST-10、RF-07、RF-08、NT-14 已核准整條保留；涵蓋不夠直接而保留的其他條文亦維持工作者處理。

階段 B 收尾已確認：BM-04 禁止句已在 Java 的 `java-mapping-integrity` 逐字存在，共通摘要暫留句已依選 B 刪除並登錄；先前第九節記述的延後刪除已完成。併發與集合驗收連結、EX-09 與 EQ-10 非表格引用已核對；共有 24 條非驗收入口的保守去向，均維持現狀，另五條驗收入口保留。集合合併、共通錨點改名、指路可讀性及驗收整合仍未執行。

### 第八次審閱還原

CA-08、CA-10、BM-09 整條逐字還原；CA-02、VO-05、EQ-04 還原基準 Java 原句；CO-01、CO-02、CO-07、CO-08、CO-09、RF-06 的引用句回到原小節，十二條均改為整條保留。CA-01 結果接收及 ND-05 註解維護補登直接共通原句。原階段 B 的 24 條保守處置計數保留為歷史，本輪最新計數與總表見[階段 B 紀錄](body-restructuring-stage-b.md)，逐處前後文字見[第八次審閱修正](body-restructuring-review-8.md)。L5 維持現狀；L7、L14 僅記錄；L9 至 L13、L15 留下一階段。

### 階段 C 第一部分

74 個共通錨點已採語意名稱並保留舊別名；15 份 Java 指路與引言使用共通標題，所有有整條移除條文的分組都有指路。version-policy 兩段與 types-and-generics 一段中間尾段回原分組，原文不變；索引摘要以現存 Java 小節為準。完整紀錄見[階段 C](body-restructuring-stage-c.md)。Java 條文錨點未改；驗收整合、殘留敘述、集合是否併檔仍留後續。
