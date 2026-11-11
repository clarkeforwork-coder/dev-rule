# 變更紀錄

本檔依 Keep a Changelog 格式，記錄影響採用專案的規範與工具變更。

## [Unreleased]

### 修正

- Java CI 審閱修正：SpotBugs 低優先門檻與 error／warn 分流、基準 v2 上下文指紋及嚴格清償檢查、PMD 抑制相容、每行編譯診斷與 argfile 傳遞、固定 Maven 的可重用 workflow 與零違規示範專案；3 筆形狀巧合降 partial，明示剩餘漏報與人工審查界線。

### 新增

- 完成 Java CI 層：四版 javac／Error Prone、SpotBugs、ArchUnit、jdeps／jdeprscan、Enforcer／Gradle 依賴限制、整合 Maven／Gradle 片段與固定 revision 的可重用 workflow；新增精確 PMD／Checkstyle 基準、可重跑正反例與端到端驗收，涵蓋率提升至 48／143 小節（33.57%）。

- 加入 Java 自動檢查工具的 pre-commit 層（`tools/java/`）：規則對照表 `rule-map.yml`（每條工具規則對一個規範錨點）、PMD 7.29.0 規則集與自訂 XPath 規則、Checkstyle 10.26.1／9.3 設定、純 shell pre-commit hook（只檢查暫存的 `.java`、只阻擋新增違規、依 JDK 8／11／17／21 選工具）、`install.sh`、`.pre-commit-hooks.yaml`、Maven／Gradle 接入片段，以及以規範範例驗證工具的測試；CI 新增 `java-tools` job（#10）。

## [1.0.0] - 2026-11-11

### 新增

- 補齊 Git、PR 與程式碼審查共通規範，專案須落實審查、合併條件與跨文件驗收要求（#1）。
- 新增兩條跨語言義務（非同步結果須有接收路徑且不得丟棄故障、失敗不代表資料未修改），所有專案須落實（#2）。
- 補回 Java 語言增量及共通要求的錨點引用，Java 專案可從語言主題追查共同底線與對應驗收（#3、#6）。
- 加入 112 組 Java 違反／符合範例並以 javac 驗證，專案可對照可編譯案例理解要求與落實方式（#4、#6）。
- 加入規範檢查腳本與 CI，規範變更可透過統一入口檢查連結、格式、樣板及 Java 範例（#5、#6）。
- 補齊 Java 8／11／17／21 的 97 個版本差異區塊與 95 個版本範例，專案可依目標版本選擇落實方式而維持相同要求（#8）。

### 變更

- 分離共通與 Java 規範，使每項要求只有一個維護位置，可見性、業務面向建模、半成品映射三條移回 Java 層，Java 專案須同時遵循共通要求與語言增量（#2）。
- 統一共通文件格式，將驗收收斂到各主題檔並集中定義樣板句，專案應由主題檔查閱對應驗收（#5、#6）。
- 將版本差異檢查納入統一入口並將 CI 改為 JDK 21，維護規範的環境須具備能驗證全部支援版本的工具鏈（#8）。

### 移除

- 移除共通規範的歷史代號錨點、改名後保留的舊標題 slug 與驗收入口表舊錨點，使用舊錨點的專案須改連至對應語意錨點（#7）。

[Unreleased]: https://github.com/clarkeforwork-coder/dev-rule/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/clarkeforwork-coder/dev-rule/releases/tag/v1.0.0
