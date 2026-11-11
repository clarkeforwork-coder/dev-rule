# Hook 接入驗證紀錄

2026-11-11 審閱修正：正式 ruleset 已內嵌所有自訂規則；Maven 3.9.9 與 Gradle 8.14.3 在 JDK 17／8 的合規專案皆成功，raw List 自訂違規皆失敗。完整命令、8 組建置輸出與 Bash 3.2／UTF-8 失敗回歸見 [最新修正驗證](../tests/review-fixes.md)。以下舊紀錄使用臨時測試規則集，僅能證明接入機制，不能視為正式規則集驗證。

日期：2026-11-11。平台：macOS arm64。測量使用 `/usr/bin/time -p` 的 real 秒數；工具快取已預熱，無 Maven／Gradle 參與 hook 執行。

## 版本與重現

| 執行環境 | 版本 |
| --- | --- |
| JDK 8 | Azul Zulu 1.8.0_512-b09，8.98.0.111-CA-macos-aarch64 |
| JDK 17 | Eclipse Temurin 17.0.19，系統已安裝版本 |
| JDK 21 | Eclipse Temurin 21.0.13+9-LTS |
| Checkstyle | JDK 8：9.3；JDK 17／21：10.26.1 |
| PMD | 7.29.0，22 個固定且逐筆 SHA-256 校驗的 Java CLI JAR |

```sh
JAVA_HOME=/path/to/jdk8  bash tools/java/hooks/test.sh
JAVA_HOME=/path/to/jdk17 bash tools/java/hooks/test.sh
JAVA_HOME=/path/to/jdk21 bash tools/java/hooks/test.sh
```

三次均輸出 `所有案例通過。`。測試規則只在暫存目錄建立，測試使用 `naming-packages-docs.md#java-naming-form` 的符合／違反範例；測試用 `JV-NM-001` 僅驗證訊息格式，不宣稱是正式 rule-map 的 ID。當時正式 PMD／Checkstyle 設定尚未提供，因此本紀錄證明的是接入、真實工具執行及過濾語意；正式規則全集需整合後另驗。

## 案例、退出碼與實測耗時

| 案例 | 退出碼 | JDK 8 秒 | JDK 17 秒 | JDK 21 秒 |
| --- | ---: | ---: | ---: | ---: |
| 無 Java、尚無 HEAD | 0 | 0.05 | 0.07 | 0.05 |
| 新增違反，Checkstyle／PMD 均執行 | 1 | 1.39 | 1.18 | 1.40 |
| staged 違反、工作目錄已修好 | 1 | 1.33 | 1.17 | 1.13 |
| staged 符合、工作目錄改壞 | 0 | 1.32 | 1.15 | 1.16 |
| 未變更行的既有違規 | 0 | 1.28 | 1.17 | 1.17 |
| 整檔模式重新納入既有違規 | 1 | 1.29 | 1.16 | 1.15 |
| 純重新命名 | 0 | 1.31 | 1.16 | 1.15 |
| 只有 warn | 0 | 1.27 | 1.14 | 1.12 |
| 刪除 Java | 0 | 0.06 | 0.07 | 0.06 |
| 只有非 Java 檔案 | 0 | 0.06 | 0.07 | 0.07 |
| 十個符合檔案、強制離線 | 0 | 1.70 | 1.54 | 1.55 |
| 語法錯誤 | 2 | 0.86 | 0.81 | 0.82 |
| 空格、`&`、冒號路徑的違規 | 1 | 1.78 | 1.59 | 1.63 |
| 12 行 hunk 內第 2、11 行均正確命中 | 1 | 1.83 | 1.69 | 1.66 |
| Git color／interHunkContext 不得影響檢查 | 1 | 1.81 | 1.68 | 1.57 |
| 強制離線且缺少快取 | 2 | 0.69 | 0.69 | 0.68 |
| 強制離線且快取損壞 | 2 | 0.66 | 0.69 | 0.67 |

額外驗證：兩種安裝方式分別連續執行兩次成功，複製到 Git hooks 的啟動器實際執行後以 1 阻擋新增違規。`bash -n` 與 `git diff --check` 通過。

## 實際輸出節錄（JDK 17）

```text
案例：新增違反（Checkstyle、PMD error、PMD warn）（預期 1）
OrderLimit.java:1 [JV-NM-001] 一致的命名形式 → rules/stacks/java/common/naming-packages-docs.md#java-naming-form
OrderLimit.java:2 [JV-NM-001] 一致的命名形式 → rules/stacks/java/common/naming-packages-docs.md#java-naming-form (warn)
OrderLimit.java:3 [JV-NM-001] 一致的命名形式 → rules/stacks/java/common/naming-packages-docs.md#java-naming-form
real 1.18
PASS exit=1

案例：staged 符合、工作目錄違反仍通過（預期 0）
real 1.15
PASS exit=0

案例：未變更行既有違規不擋（預期 0）
real 1.17
PASS exit=0

案例：十個符合檔案、離線快取（預期 0）
real 1.54
PASS exit=0

案例：超過十行的 hunk 必須以數值比較行號（預期 1）
Long.java:2 [JV-NM-001] 一致的命名形式 → rules/stacks/java/common/naming-packages-docs.md#java-naming-form
Space & colon:File.java:1 [JV-NM-001] 一致的命名形式 → rules/stacks/java/common/naming-packages-docs.md#java-naming-form
Long.java:11 [JV-NM-001] 一致的命名形式 → rules/stacks/java/common/naming-packages-docs.md#java-naming-form
real 1.69
PASS exit=1
```

## Maven／Gradle 外掛接入

在另一暫存專案建立 `src/main/java/Good.java`，使用上述相同測試 XML；直接將 Maven 片段作為 POM，或由 `build.gradle.kts` 套用 Gradle 片段。正式規則並未被替換或提交。

| 測試 | 結果 |
| --- | --- |
| Maven 3.9.9，JDK 17，`mvn verify` | `BUILD SUCCESS`；固定 PMD 7.29.0，最後一次耗時 1.881 秒 |
| Maven 3.9.9，JDK 8，`mvn -Dmaven.compiler.source=8 -Dmaven.compiler.target=8 clean verify` | `BUILD SUCCESS`，4.033 秒；JDK profile 選 Checkstyle 9.3 |
| Gradle 8.14.3，JDK 17，`gradle check --no-daemon` | `BUILD SUCCESSFUL in 13s`，包含首次依賴取得／啟動 |
| Gradle 8.14.3，JDK 8，`gradle clean check --no-daemon` | `BUILD SUCCESSFUL in 9s`；Checkstyle 9.3 |
| JDK 17，只有 PMD error 的 `Accepts` 方法 | Maven `pmd:3.28.0:check` 失敗；Gradle `pmdMain FAILED` |
| JDK 17，只有 PMD warn 的 `maxOrders` 欄位 | Maven／Gradle 均成功；Gradle 的 priority 門檻不執行 warn 規則 |

Gradle 片段明確選擇執行 Gradle 的 JDK 作為工具 launcher，避免專案 Java 8 編譯 toolchain 誤啟動 Checkstyle 10；修改後在 JDK 17／8 再次成功載入並執行 `check`。Maven／Gradle 是整檔建置檢查，耗時不屬於十個 staged 檔案的十秒 hook 目標。

## 已知限制與未驗證範圍

- JDK 11 profile 版本與下載內容固定，但本次未實際啟動 JDK 11。
- 尚未驗證正式規則全集及大型真實專案效能；本次十個檔案耗時不可解讀為任何專案的保證。
- 已驗證 SHA-256 正常命中、缺檔及損壞時離線阻擋；未模擬網路中斷或多程序同時下載。
- PMD 沒有專案 classpath 時的型別解析限制、起始行判定的跨行限制，以及 Gradle 不執行 warn 的差異，已列於 README。
- `v1.0.0` 僅為接入範例；發布 tag 由整合流程負責，本工作沒有推送或建立 PR。
