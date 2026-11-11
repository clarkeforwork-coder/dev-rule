# Java 提交前檢查

此 hook 對 staged 的 `.java` 先執行 Checkstyle，再執行 PMD。預設只阻擋新增／修改行上的 error；warn 列出但不阻擋。它不會修改工作目錄、stash 內容或變更 index，也不需要 Python、Maven、Gradle、unzip 或 `jar` 指令。

需要 Bash 3.2+（已在 macOS Bash 3.2／UTF-8 語系驗證）、Git、curl、`shasum` 或 `sha256sum`、Java，以及系統基本工具（awk、sed、grep、mktemp、mkdir 等）。適用 macOS／Linux；Windows 請使用 WSL。工具第一次下載需要網路，其後每次均先校驗快取。

## 安裝

先將本庫固定在一個可信任 revision，例如 submodule `vendor/dev-rule`。在**要受檢查的專案**執行以下其中一種方式：

```sh
# 方式一：由本庫目錄直接提供 hooks，適合 submodule／vendor。
bash vendor/dev-rule/tools/java/hooks/install.sh --hooks-path

# 方式二：在 Git 實際 hooks 目錄寫入 pre-commit 啟動器。
bash vendor/dev-rule/tools/java/hooks/install.sh --copy

# 也可以從任意目錄指定專案路徑。
bash /path/to/dev-rule/tools/java/hooks/install.sh --hooks-path /path/to/project
```

兩種方式都會印出模式、專案及路徑，且可重複執行。複製模式複製的是啟動器，仍需保留來源 checkout；搬動來源後重新安裝。使用 `git rev-parse --git-path hooks`，因此 linked worktree 的 `.git` 是檔案也能處理。`core.hooksPath` 設定可能由同一 Git common directory 的 worktree 共用，請在切換模式前確認。

已有自訂 `core.hooksPath` 或非本工具建立的 `pre-commit` 時，安裝器會停止並保留既有檔案，請由專案維護者整合。`--hooks-path` 會改由本庫提供 hooks，原本 `.git/hooks` 中其他 hooks 將不再被 Git 呼叫。從 hooksPath 改用複製模式前，先執行 `git config --local --unset core.hooksPath`。

使用 pre-commit 框架的團隊可在專案 `.pre-commit-config.yaml` 加入：

```yaml
repos:
  - repo: https://github.com/clarkeforwork-coder/dev-rule
    rev: '<包含本次工具設定的已審查 commit SHA>'
    hooks:
      - id: dev-rule-java
```

rev 使用 commit SHA；本層納入正式版本後改用 tag。框架本身需要其執行環境；本 hook 使用 `language: script`，不建立 Python 虛擬環境。忽略框架傳入的檔名，統一以 Git index 為準；一次呼叫處理所有 staged Java 檔案。`pre-commit run --all-files` 仍只檢查 staged Java。

## 首次下載與離線

```sh
# 可先在有網路時預熱所選 JDK profile。
tools/java/hooks/toolbox.sh checkstyle --version
tools/java/hooks/toolbox.sh pmd --help

# 再離線執行。
DEV_RULE_OFFLINE=1 tools/java/hooks/pre-commit
```

預設快取為 `${XDG_CACHE_HOME:-$HOME/.cache}/dev-rule/java/<tool>-<version>/`。Checkstyle 使用官方 all-in-one JAR；PMD 使用 Maven Central 的 CLI、Java 模組與必要依賴，逐筆固定於 `../profiles/pmd-7.29.0.lock`。只載入 lock 指定的 JAR，快取目錄內其他 JAR 不會加入 classpath。版本、下載 URL、實際下載檔案的 SHA-256 都已提交，沒有 `latest` 下載。

已有通過校驗的快取時不連網。缺少或損壞的檔案，線上時重新下載並於驗證成功後原子替換；離線時回報明確錯誤並退出 2，絕不跳過檢查。可將完整的對應版本快取目錄帶至離線機器。快取不可放在不受信任的共用可寫目錄。

## JDK 與工具版本

優先執行 `$JAVA_HOME/bin/java`，未設定時使用 PATH 中的 `java`，解析 `java -version` 後選 profile。只接受下列版本；未知版本或失效的 JAVA_HOME 會明確失敗。

| 執行 JDK | Checkstyle | PMD | PMD 旗標 |
| --- | --- | --- | --- |
| 8 | 9.3 | 7.29.0 | `--use-version java-8` |
| 11 | 10.26.1 | 7.29.0 | `--use-version java-11` |
| 17 | 10.26.1 | 7.29.0 | `--use-version java-17` |
| 21 | 10.26.1 | 7.29.0 | `--use-version java-21` |

以執行 JDK 作為語言版本，不自行猜測 `pom.xml`／Gradle toolchain。若建置 JDK 與專案語言版本不同，請在執行 hook 前設定與專案相符的 JAVA_HOME。純 hook 不解析外部相依套件，PMD 的型別解析能力因此有限；需完整 classpath 的規則應在建置或 CI 中驗證。

## 新增行與精確違規基準

1. `git write-tree` 固定 index 快照，再取得相對 HEAD 的 ACMR Java 路徑；首次提交以空 tree 作為基準。
2. 將 staged blob 寫入獨立暫存目錄；不讀工作目錄 Java 內容。
3. 以零行上下文比較各檔案的舊 blob 與 staged blob，取得新版本 hunk 範圍。重新命名沿用舊檔基準；純重新命名不會把整檔當新增。刪除檔案不檢查。
4. 依序產生 Checkstyle 與 PMD XML，再按診斷的起始行過濾。

這是**新增／修改行基準**，不是違規數量相減。改動既有違規所在行會重新納入檢查；刪除行、未變更行不納入。多行違規以工具回報的起始行判定，無法保證捕捉起始行未變更的跨行語意問題。設定檔取自固定工具 checkout，不隨專案 staged Java 快照複製。

```text
OrderLimit.java:1 [JV-NM-001] 一致的命名形式 → rules/stacks/java/common/naming-packages-docs.md#java-naming-form
WarningOnly.java:1 [JV-NM-001] 一致的命名形式 → rules/stacks/java/common/naming-packages-docs.md#java-naming-form (warn)
```

Checkstyle 遵循 `severity`；PMD priority 1／2 阻擋，3／4／5 為 warn（本庫約定 1=error、3=warn）。所有規則訊息須帶 `[JV-XX-NNN]` 與條文錨點。沒有條文 ID 的診斷、語法錯誤、工具執行錯誤、設定錯誤及不完整報告，均視為檢查失敗，不能透過行過濾隱藏。

退出碼：0=通過或只有 warn，1=新增 error，2=工具／設定／檔案類型錯誤。沒有 staged Java 時不啟動 JVM。

## 環境變數

| 變數 | 用途 |
| --- | --- |
| `JAVA_HOME` | 選擇 Java 執行環境及對應 profile |
| `XDG_CACHE_HOME` | 工具快取根目錄，預設 `$HOME/.cache` |
| `DEV_RULE_OFFLINE=1` | 禁止下載，只用已校驗的快取 |
| `DEV_RULE_FULL_FILE=1` | 檢查 staged Java 的整檔診斷，仍不掃描未 staged 檔案 |
| `DEV_RULE_ROOT` | 規則庫 checkout 根目錄；預設由 hook 所在位置推導 |
| `DEV_RULE_CHECKSTYLE_CONFIG` | 覆寫 Checkstyle XML 路徑，主要供整合測試 |
| `DEV_RULE_PMD_RULESET` | 覆寫 PMD XML 路徑，主要供整合測試 |
| `TMPDIR` | 暫存目錄父層，完成或失敗後清除 |

## Maven／Gradle

- Maven：將 `../ci/maven/pom-fragment.xml` 的 properties、profiles、build 合併到專案 POM，修改 `dev-rule.root` 與 compiler source／target，執行 `mvn verify`。固定 maven-checkstyle-plugin 3.6.0、maven-pmd-plugin 3.28.0；執行 JDK 8 自動選 Checkstyle 9.3，其他使用 10.26.1；PMD 模組固定 7.29.0。
- Gradle：以 `apply(from = "vendor/dev-rule/tools/java/ci/gradle/rules.gradle.kts")` 接入，專案套用 Java plugin 並設定 `mavenCentral()`，執行 `gradle check`。內建外掛版本隨 Gradle wrapper 固定，範例驗證版本為 8.14.3。可用 `-PdevRuleRoot=/path/to/dev-rule` 指定規則庫。

建置外掛檢查工作目錄整檔，**不實作 staged 新增行過濾**；提交前的精確行基準由 shell hook 負責。Maven 的 PMD 報告包含所有等級但僅 priority 1／2 阻擋；Gradle 原生外掛沒有分開列出與阻擋門檻的設定，因此僅啟用 priority 1／2，warn 仍由 hook 列出。Checkstyle warning 不阻擋建置。

## 驗證與耗時

執行 `bash tools/java/hooks/test.sh`。測試在暫存 Git 專案內產生最小測試規則，使用命名規範的符合／違反範例，再呼叫真實工具，結束後清除；不修改正式設定。完整結果見 [驗證紀錄](VERIFICATION.md)。

2026-11-11 在 macOS arm64，JDK 8、17、21 實測均通過。已預熱快取、十個簡單 Java 檔案時約 **1.5–1.8 秒**；未 staged Java 約 **0.05–0.08 秒**。十秒目標在這組測試達成，首次下載、較大檔案、正式規則全集及外部型別解析成本不包含在此數據內。正式全集已由 `tools/java/tests/run-hook-official.sh` 驗證；最新逐案輸出及耗時見 [收尾驗證](../tests/validation.md)。

## 常見問題

- **檢查到已在工作目錄修好的違規？** 執行 `git add` 更新 staged 內容；hook 故意不讀尚未暫存的修改。
- **沒檢查到舊問題？** 預設僅比對新增行；設定 `DEV_RULE_FULL_FILE=1` 檢查 staged 整檔。
- **缺少設定檔？** 確認 checkout 包含 `tools/java/pmd/ruleset.xml`、`tools/java/checkstyle/checkstyle.xml`、`tools/java/checkstyle/suppressions.xml`。單獨複製 pre-commit 檔案不足以執行。
- **Checkstyle 抑制檔如何定位？** toolbox 提供 Java system property `checkstyle.suppressions.file` 指向其工具庫的抑制檔，Maven／Gradle 片段提供同名屬性。
- **檔名有哪些限制？** 支援空格、冒號、`&`、中文及 Git pathspec 字元；換行、tab 與 Java symlink 會明確拒絕。不要將 Java 工具快取放在名稱含 classpath 分隔符 `:` 的目錄。
- **這是否取代編譯與 CI？** 不會。hook 只分析 staged 檔案且可被 Git `--no-verify` 略過，完整建置、型別解析與團隊 CI 仍需保留。

工具介面參考：[Checkstyle CLI](https://checkstyle.org/cmdline.html)、[PMD CLI](https://pmd.github.io/pmd/pmd_userdocs_cli_reference.html)、[PMD Maven 接入](https://pmd.github.io/pmd/pmd_userdocs_tools_maven.html)、[Gradle PMD](https://docs.gradle.org/8.14.3/userguide/pmd_plugin.html)。

失敗回歸：`/bin/bash tools/java/tests/run-hook-failure.sh` 在 UTF-8 語系下驗證離線 PMD jar 竄改、缺少與 Java 21 語法解析錯誤均以 2 阻擋。`run-all.sh` 已包含此測試。
