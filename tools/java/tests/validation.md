# Java pre-commit 層收尾驗證（歷史）

最新審閱修正、正式 Maven／Gradle 與 JDK 8／17／21 驗收見 [審閱修正紀錄](review-fixes.md)。以下為修正前紀錄，舊涵蓋率、規則數與採用決策由新紀錄取代。

日期：2026-11-11；分支 `tools/java-precommit`。未修改 rules／scripts，未推送、未建立 PR；本分支沒有 `docs/decisions/0005-java-tooling.md`，未建立替代 ADR。

## 逐項裁決

- JV-ER-008：`IllegalCatch[illegalClassNames=Throwable,Error]` 維持 error，verified → partial。規範反例只有 Exception；正式設定合成樣本驗證 Throwable／Error 各命中 1、具體例外不命中。全名形式亦設定；不以合成證據冒充規範正反例。
- 新增 JV-ER-031：`IllegalCatch[illegalClassNames=Exception,RuntimeException]`，warn、verified、風險 high。原規範違反 catch Exception 命中、符合例乾淨。入口層依核准紀錄，以 SuppressionFilter 的 ID、檔案及行號精確抑制；設定不啟用任意原始碼 Checkstyle SuppressWarnings。
- JV-LS-013：verified → partial。原規範沒有正反例；合成 parallelStream 命中、stream 不命中，不列 verified。
- JV-ND-009：保留 verified。原 XPath 的 CastExpression 分支不變，新增 MethodCall 分支：MethodName=clamp、接收者 Math、引數含 Integer.MIN_VALUE 與 Integer.MAX_VALUE。Java 21 原反例命中，原 Math.toIntExact 符合例仍乾淨；只辨識這個語法形狀，不能推論飽和截斷是否符合業務契約，保留 high 風險與精確抑制要求。static import／別名及其他 clamp 形狀不在此新增分支內。
- test 層：原始 56 筆中 34 筆有正式 java- 英文小節錨點，已由 manual tier 還原 test、status 仍 manual；另 22 筆是共同驗收／語言增量索引（其中有重複），首次匯入即排除，不屬被合併的正式映射。下表逐筆說明，沒有為湊 56 筆而新增虛構小節；coverage 分開列測試驗收與人工審查。
- 工作者回報中的 rule-map 衝突只有上述 ER-008、LS-013、ND-009；PMD 其餘 47 筆 verified 與 Checkstyle 其餘 16 筆 verified 經原規範全量重驗均通過，不再降級。CI 工具既有研究映射不在本次執行範圍，未冒稱重新驗證。
- 合併介面：Checkstyle 改用 PMD 工作者留下的唯一 JavaExamples 抽取器，按 file／anchor／kind 選取，包含版本增量例；不存在第二套 Markdown 抽取邏輯，且缺少正反例會失敗。

## 設定一致性與執行結果

`check-consistency.rb` 雙向核對正式／候選集合、ID、模組／規則引用、訊息標題及錨點、等級、PMD URL 與自訂 XPath，並核對兩筆 IllegalCatch 屬性。結果：PMD 正式 65、候選 10；Checkstyle 正式 22、候選 14；零問題。五項負向測試（錯誤錨點、未知 ID、候選混入、缺少模組、捕捉設定漂移）都以退出碼 1 拒絕，完整輸出見 [consistency-negative.log](evidence/consistency-negative.log)。

| 執行 JDK | PMD 7.29.0 verified | partial | Checkstyle | Checkstyle verified／範例 | run-all 退出碼 |
| --- | --- | --- | --- | --- | --- |
| Zulu 8.0.512 | 48 通過／0 失敗 | 17（僅報告） | 9.3 | 17／44 全通過 | 0 |
| Temurin 17.0.19 | 48 通過／0 失敗 | 17（僅報告） | 10.26.1 | 17／44 全通過 | 0 |
| Temurin 21.0.13 | 48 通過／0 失敗 | 17（僅報告） | 10.26.1 | 17／44 全通過 | 0 |

三個執行期均抽取 319 份範例，PMD 按 Java 8／11／17／21 語法分組；每個 verified 必須所有違反命中且符合不命中。工具錯誤為 0。兩個 partial 合成樣本在三個執行期均通過。原合併版本的 Checkstyle 9.3 亦曾在 JDK 17 跑至全通過；最終交付以 JDK 8 真實執行期的完整紀錄為準。

完整輸出（未節錄）：[JDK 8](evidence/jdk8.log)、[JDK 17](evidence/jdk17.log)、[JDK 21](evidence/jdk21.log)。執行命令為 `JAVA_HOME=<對應 JDK> tools/java/tests/run-all.sh`，使用 hook 相同鎖定版本及 SHA-256 的 toolbox。PMD 補充 pmd-cli 模式以接受測試的完整 CLI 參數；原 hook pmd 模式不變。首次測試的合成檢查曾將 stderr 警告混入 JSON，已改用 capture3 分離並全量重跑。

CI 新增 `java-tools` 的 21／8 matrix，主 job 原文未動；CI 設定已提交，但本地不推送，因此沒有宣稱 GitHub Actions 遠端已執行。Ruby 3.3 環境明確安裝 REXML。

## 正式 hook 驗證

`JAVA_HOME=<對應 JDK> tools/java/tests/run-hook-official.sh` 在暫存 Git 倉庫使用正式 PMD／Checkstyle 全集：無 Java 通過、新增命名違規阻擋、staged 違反而工作目錄符合仍擋、staged 符合而工作目錄違反仍通過、既有違規不擋新增乾淨行、整檔模式仍擋既有違規、只有非 Java 通過。退出碼均符合預期，全部案例通過。

完整診斷及每案 real／user／sys 耗時：[JDK 8](evidence/hook-jdk8.log)、[JDK 17](evidence/hook-jdk17.log)、[JDK 21](evidence/hook-jdk21.log)。時間為 macOS arm64 本機實測，快取已預熱，僅代表這組小樣本，不代表大型專案或首次下載。

既有 hook 工作者的全套測試也以 JDK 17 重跑，含 warn、rename、特殊路徑、語法錯誤、離線缺快取／損壞快取、Git 設定與安裝器；全部通過，完整輸出見 [hook-regression.log](evidence/hook-regression.log)。該套使用測試專用設定，與上面的正式全集證據分開記錄。

## 規範六項檢查

使用 `PATH=<JDK21>/bin:$PATH ruby scripts/check-rules.rb`。六項通過（links、skeleton、headings、template、examples、versions），完整輸出見 [rules-check.log](evidence/rules-check.log)。既有 53 個整檔連結警告保留，不修改 rules；預設 PATH 的 javac 17 曾因檢查器明定須 21 而退出 1，換正確 JDK 後重跑，未改腳本放寬要求。

## 涵蓋率總表



| 項目 | 數量 |
| --- | --- |
| 文件數 | 15 |
| 小節數 | 143 |
| 映射筆數 | 308 |
| status：verified（筆） | 86 |
| status：partial（筆） | 41 |
| status：candidate（筆） | 41 |
| status：manual（筆） | 140 |
| tier：pre-commit（筆） | 111 |
| tier：ci-compile（筆） | 28 |
| tier：ci-bytecode（筆） | 16 |
| tier：ci-arch（筆） | 3 |
| tier：ci-build（筆） | 10 |
| tier：test（筆） | 34 |
| tier：manual（筆） | 106 |
| tool：pmd（筆） | 75 |
| tool：checkstyle（筆） | 36 |
| tool：javac（筆） | 12 |
| tool：errorprone（筆） | 16 |
| tool：spotbugs（筆） | 16 |
| tool：archunit（筆） | 3 |
| tool：jdeps（筆） | 3 |
| tool：jdeprscan（筆） | 1 |
| tool：maven-enforcer（筆） | 4 |
| tool：gradle（筆） | 2 |
| tool：none（筆） | 140 |
| verified 小節數 | 52 |
| 涵蓋率（verified 小節／全部小節） | 52／143 = 36.36% |


本次新增檢查不代表完整小節自動化；test=待實作驗收，manual=人工審查。CI 層的既有研究 verified 亦包含於總表，但本次只實作 pre-commit 層。

## 原始 56 筆 test 逐筆還原對照

| 來源與筆序 | 文件／原始錨點 | 裁決 |
| --- | --- | --- |
| inventory-inv-claude-a 第 44 筆 | lambda-and-stream.md#java-parallel-stream-adoption | JV-LS-014：tier test／status manual |
| inventory-inv-claude-a 第 46 筆 | lambda-and-stream.md#java-reduction-collection | JV-LS-015：tier test／status manual |
| inventory-inv-claude-a 第 51 筆 | lambda-and-stream.md#java-execution-verification | JV-LS-020：tier test／status manual |
| inventory-inv-claude-a 第 68 筆 | naming-packages-docs.md#java-document-verification | JV-NP-036：tier test／status manual |
| inventory-inv-claude-a 第 77 筆 | classes-and-construction.md#java-construction-entrypoints | JV-CC-008：tier test／status manual |
| inventory-inv-claude-a 第 81 筆 | classes-and-construction.md#java-lifecycle-verification | JV-CC-012：tier test／status manual |
| inventory-inv-claude-b 第 17 筆 | collections-and-ownership.md#java-collection-verification | JV-CO-017：tier test／status manual |
| inventory-inv-claude-b 第 18 筆 | collections-and-ownership.md#(none) | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-claude-b 第 19 筆 | collections-and-ownership.md#(none) | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-claude-b 第 50 筆 | exceptions-and-resources.md#java-failure-coverage | JV-ER-030：tier test／status manual |
| inventory-inv-claude-b 第 51 筆 | exceptions-and-resources.md#(none) | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-claude-b 第 52 筆 | exceptions-and-resources.md#(none) | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-claude-b 第 58 筆 | equality-hashing-ordering.md#java-equality-hash-contract | JV-EH-006：tier test／status manual |
| inventory-inv-claude-b 第 74 筆 | equality-hashing-ordering.md#java-relationship-coverage | JV-EH-022：tier test／status manual |
| inventory-inv-claude-b 第 75 筆 | equality-hashing-ordering.md#(none) | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-claude-b 第 76 筆 | equality-hashing-ordering.md#(none) | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-claude-b 第 108 筆 | numbers-dates-text.md#java-boundary-verification | JV-ND-032：tier test／status manual |
| inventory-inv-claude-b 第 109 筆 | numbers-dates-text.md#(none) | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-claude-b 第 110 筆 | numbers-dates-text.md#(none) | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-codex-a 第 11 筆 | null-and-optional.md#java-api-absence | JV-NO-014：tier test／status manual |
| inventory-inv-codex-a 第 13 筆 | value-objects.md#java-value-construction-invariants | JV-VO-002：tier test／status manual |
| inventory-inv-codex-a 第 14 筆 | value-objects.md#java-value-immutability | JV-VO-005：tier test／status manual |
| inventory-inv-codex-a 第 15 筆 | value-objects.md#java-value-equality | JV-VO-007：tier test／status manual |
| inventory-inv-codex-a 第 16 筆 | value-objects.md#java-value-normalization | JV-VO-008：tier test／status manual |
| inventory-inv-codex-a 第 18 筆 | value-objects.md#java-value-restoration | JV-VO-010：tier test／status manual |
| inventory-inv-codex-a 第 21 筆 | value-objects.md#java-value-test-coverage | JV-VO-013：tier test／status manual |
| inventory-inv-codex-a 第 29 筆 | states-and-results.md#java-model-acceptance | JV-SR-013：tier test／status manual |
| inventory-inv-codex-a 第 31 筆 | boundary-mapping.md#java-mapping-integrity | JV-BM-002：tier test／status manual |
| inventory-inv-codex-a 第 32 筆 | boundary-mapping.md#java-update-intent | JV-BM-003：tier test／status manual |
| inventory-inv-codex-a 第 33 筆 | boundary-mapping.md#java-mutable-isolation | JV-BM-006：tier test／status manual |
| inventory-inv-codex-a 第 36 筆 | boundary-mapping.md#java-mapping-verification | JV-BM-009：tier test／status manual |
| inventory-inv-codex-a 第 37 筆 | null-and-optional.md#共同驗收 | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-codex-a 第 38 筆 | null-and-optional.md#java-語言增量驗收 | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-codex-a 第 39 筆 | value-objects.md#共同驗收 | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-codex-a 第 40 筆 | value-objects.md#java-語言增量驗收 | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-codex-a 第 41 筆 | states-and-results.md#共同驗收 | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-codex-a 第 42 筆 | states-and-results.md#java-語言增量驗收 | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-codex-a 第 43 筆 | boundary-mapping.md#共同驗收 | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-codex-a 第 44 筆 | boundary-mapping.md#java-語言增量驗收 | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-codex-b 第 3 筆 | concurrency-and-async.md#java-deadline-budget | JV-CA-006：tier test／status manual |
| inventory-inv-codex-b 第 4 筆 | concurrency-and-async.md#java-cancellation-propagation | JV-CA-007：tier test／status manual |
| inventory-inv-codex-b 第 6 筆 | concurrency-and-async.md#java-task-completion | JV-CA-009：tier test／status manual |
| inventory-inv-codex-b 第 7 筆 | concurrency-and-async.md#java-execution-location | JV-CA-010：tier test／status manual |
| inventory-inv-codex-b 第 8 筆 | concurrency-and-async.md#java-context-propagation | JV-CA-011：tier test／status manual |
| inventory-inv-codex-b 第 10 筆 | concurrency-and-async.md#java-controlled-shutdown | JV-CA-014：tier test／status manual |
| inventory-inv-codex-b 第 12 筆 | concurrency-and-async.md#共同驗收 | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-codex-b 第 13 筆 | concurrency-and-async.md#java-語言增量驗收 | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-codex-b 第 16 筆 | reflection-and-suppression.md#java-dynamic-contract-validation | JV-RS-004：tier test／status manual |
| inventory-inv-codex-b 第 20 筆 | reflection-and-suppression.md#java-dynamic-verification | JV-RS-011：tier test／status manual |
| inventory-inv-codex-b 第 21 筆 | reflection-and-suppression.md#共同驗收 | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-codex-b 第 22 筆 | reflection-and-suppression.md#java-語言增量驗收 | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-codex-b 第 25 筆 | version-policy.md#java-runtime-verification | JV-VP-006：tier test／status manual |
| inventory-inv-codex-b 第 26 筆 | version-policy.md#java-module-versions | JV-VP-007：tier test／status manual |
| inventory-inv-codex-b 第 34 筆 | version-policy.md#java-toolchain-compatibility | JV-VP-024：tier test／status manual |
| inventory-inv-codex-b 第 40 筆 | version-policy.md#共同驗收 | 驗收彙整索引；維持不列獨立映射，不增加分母 |
| inventory-inv-codex-b 第 41 筆 | version-policy.md#java-語言增量驗收 | 驗收彙整索引；維持不列獨立映射，不增加分母 |

## 未完成與範圍限制

本次指定的本地收尾工作均完成。未執行發布／推送／PR（依限制），未聲稱遠端 CI 已跑；JDK 11 實測與下一期 CI 工具落地尚未進行，不屬此次驗收矩陣。原 56 筆 test 中 22 筆索引未強行變成 rule-map 映射，理由及逐筆對應如上。
