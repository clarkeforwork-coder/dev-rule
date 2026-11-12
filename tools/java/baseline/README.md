# 精確違規基準

此工具依[精確違規基準](../../../rules/workflow/rule-governance.md#precise-violation-baseline)比對完整 PMD／Checkstyle XML 報告，阻擋新增 error 與尚未移除的已清償項目。單檔 `Baseline.java` 無第三方依賴，使用 Java 8 語法與 API；消費端只需要 JDK 與 POSIX shell，不需要 Ruby／Python。

## 建立與檢查

在消費端專案根目錄，先以同一份來源與正式規則產生**完整且最新**的報告：

```sh
# Maven：產生報告，仍保留工具執行失敗；只關閉原生違規門檻。
mvn -Dcheckstyle.failOnViolation=false -Dpmd.failOnViolation=false verify
sh vendor/dev-rule/tools/java/baseline/run.sh create \
  --baseline dev-rule-baseline.tsv \
  --pmd target/pmd.xml --checkstyle target/checkstyle-result.xml \
  --owner team-java --due 2027-03-01

sh vendor/dev-rule/tools/java/baseline/run.sh check \
  --baseline dev-rule-baseline.tsv \
  --pmd target/pmd.xml --checkstyle target/checkstyle-result.xml
```

`create` 要求負責人與 ISO 日期，不覆寫既有檔案。建立基準屬首次接入的審查動作；PR 不應重新 `create` 吸收新問題。`check` 不修改基準，列出新增診斷與已清償筆數，最後以「判定」列出新增 error 與待移出數量。缺少 `--owner`／`--due`、建立時檔案已存在或檢查時基準不存在，均給具名錯誤。結束碼：0＝無新增 error 且無已清償項目，1＝新增 error 或待 prune，2＝輸入／設定／工具錯誤。`check --allow-stale` 可暫時容許已清償項目；CI 預設不加此旗標。PMD priority 1／2 與 Checkstyle error 阻擋；其餘支援等級只警告。所有子命令至少須指定一份報告；`--pmd`、`--checkstyle` 可重複指定不同報告，但不可重複傳入同一檔案。若基準含兩種工具就必須提供兩者報告。

報告路徑、基準路徑相對於工作目錄；報告內相對來源路徑相對於專案根目錄（預設工作目錄，可用 `--root` 指定）。來源必須存在且位於根目錄內，包含符號連結解析後的位置。PMD XML 必須使用正式 ruleset，使訊息保留 `[JV-…]` 與規範錨點；PMD 的 `<suppressedviolation>` 略過並統計；其他未知診斷、工具錯誤與不合法 XML 不可納入基準。XML 禁止 DTD／外部實體。

## 可審查的格式

UTF-8 TSV，第一行是 `# dev-rule-baseline-v2`，第二行是欄名：

```text
tool  rule  file  sha256  level  count  owner  due  message
```

上例以空格顯示欄位，實檔使用 Tab。每列為工具＋規則 ID＋專案相對檔名＋診斷起始行及前後各一個非空行的 SHA-256＋等級；`count` 保存相同鍵的出現次數。三行分別 trim 後以換行連接，檔案邊界用空字串；指紋只移除各行首尾空白，保留行內空白，避免把字串常值變更視為相同內容。行號只用於診斷輸出，不寫入識別鍵，因此上方插入三行仍命中。等級參與鍵，warning 升級 error 必須重新阻擋；工具參與鍵，避免兩種分析器互相抵銷。輸出依鍵排序，方便 diff。

`owner` 與 `due` 可逐列編輯；必須非空且日期合法。期限供清償追蹤，check 對過期項目列出檔名、ID、owner 與 due 警告，不自動豁免或更改等級。相同內容重複出現用次數限制，不用集合去重，新增相同違規仍會失敗。訊息保留規範連結，供審查定位；欄位不允許 Tab／換行。

v2 納入前後非空行，能區分不同上下文的同一違規行，但三行完全相同的重複區塊仍可能混淆；這是局部指紋而非 AST 語意定位。修改相鄰內容會視為新鍵，需審查後更新基準；上方插入空行不改鍵。v1 基準明確拒絕，升級時須重新產生完整報告、審查差異並建立 v2，不得直接改表頭或用重新 create 吸收新增問題。

## 碰到既有違規相鄰行時的處理

修改前後非空行可能讓既有違規變成「新增＋已清償」。先重新產生完整報告，執行 `check`，核對新增診斷的 `sha256`、已清償指紋及來源 diff；確認違規行本身未改、只是相鄰上下文位移，再執行：

```sh
sh vendor/dev-rule/tools/java/baseline/run.sh rekey \
  --baseline dev-rule-baseline.tsv \
  --pmd target/pmd.xml --checkstyle target/checkstyle-result.xml
# 隨後用相同報告執行 check，審查並提交基準 diff 與來源變更。
```

`rekey` 以工具＋檔名＋規則分組，只接受恰好一個完整消失的舊鍵和一個全新鍵，且等級與 count 相等；僅更新指紋，保留其餘欄位，包括負責人、期限與訊息。仍命中的舊鍵不動。部分次數清償、次數增加、不同等級、多個候選或單邊新增／清償均列出待配對指紋，退出 1，整份基準保持原樣；全部配對成功才原子寫入，退出 0，沒有差異時不寫檔。輸入錯誤仍退出 2。

`rekey` 不會吸收額外的真正新違規，配對不成立就拒絕，warn 也必須配對；不可重新 create 來繞過拒絕。但 v2 只保存上下文雜湊，沒有舊行原文，無法自動證明違規行未改，也無法辨識恰好同組等量的「一修一增」。所以必須先 `check` → 人工審查 → `rekey` → 再 `check` → 提交基準，不能把 `rekey` 放入 CI 自動刷新。真正修好的項目應使用 `prune`，新的違規應修正。

## 清償與 PR 門檻

修正後重新產生全部報告，再執行同樣參數的 `prune`：

```sh
sh vendor/dev-rule/tools/java/baseline/run.sh prune \
  --baseline dev-rule-baseline.tsv \
  --pmd target/pmd.xml --checkstyle target/checkstyle-result.xml
```

`prune` 只保留仍存在的舊鍵、減少次數，保留原負責人／期限；有新增 error 時退出 1 且不修改基準，絕不吸收新增違規。把刪減基準的 diff 與修正一起提交，之後復發就會失敗。`check` 會列出已清償數，預設以非零結束碼要求執行 `prune`；它不會在 CI 偷改版本控制內容。不要用局部報告執行 prune；CLI 無法判斷使用者是否漏傳同工具的某個 source set，也無法證明手動提供的報告與來源同版本。CI 應從乾淨 checkout 執行完整建置。

Git hook 以 HEAD／index 的新增行決定範圍，可在提交前快速檢查；本基準則比較 CI 完整分析所得的具體違規，兩者互補。不得以基準關閉編譯、測試或其他 CI 分析器。

## Maven 與 Gradle

合併既有 Maven 片段後，以 `mvn -Pdev-rule-baseline verify` 啟用。profile 只解除 PMD／Checkstyle 原生違規失敗，由排列在報告外掛之後、同在 verify 階段的 exec 外掛執行基準檢查；Maven 沒有「verify 後」的獨立階段。請保留外掛順序，每個模組各自維護根目錄下的 `dev-rule-baseline.tsv`，不要用聚合根的一份局部報告替代子模組。無 Java 原始碼的聚合 POM 不應啟用該執行。

Gradle 使用 `./gradlew -PdevRuleBaseline check`。`devRuleBaselineCheck` 依賴所有 PMD／Checkstyle task，收集各 source set 的 XML；NO-SOURCE 轉成明確空報告，防止讀入上次建置殘留報告。其他跳過狀態與缺少報告會失敗；建置工具仍負責解析與執行錯誤。首次產生報告時可執行 `./gradlew -PdevRuleBaseline checkstyleMain pmdMain checkstyleTest pmdTest`，再將所有非空 source set 的報告傳給 `create`。後續 CLI prune 同樣需完整範圍。

`run.sh` 優先使用 `JAVA_HOME`，否則使用 PATH；請與建置使用同一個 JDK。獨立呼叫時以 `mktemp -d` 建立私有目錄重新編譯，結束後移除；建置內設定 `JAVA_HOME` 與 `DEV_RULE_TOOLS_DIR` 時，才以來源 SHA-256＋JDK 版本在該專案建置目錄重用，沒有跨專案 class 快取或外部 JAR 下載。也可直接執行：

```sh
javac -encoding UTF-8 -d /tmp/baseline-classes vendor/dev-rule/tools/java/baseline/Baseline.java
java -cp /tmp/baseline-classes Baseline check --baseline dev-rule-baseline.tsv --pmd target/pmd.xml
```

未來 SpotBugs／Error Prone 應新增報告轉換器，沿用規則、檔案、內容指紋、等級與次數的模型；目前未知工具明確拒絕，不宣稱已支援。

## 本庫驗證

```sh
JAVA_HOME=/path/to/jdk17 JAVA8_HOME=/path/to/jdk8 tools/java/tests/run-baseline.sh
```

測試使用暫存來源與 XML，驗證建立、既有違規、新增、重複、行號位移、相鄰行 rekey、拒絕額外新違規與不等量配對、清償、復發、warning、工具錯誤、外部實體與缺報告。測試端使用 Ruby，消費端不需要；`run-all.sh` 已串接本階段。JDK 8 未提供時會明確顯示矩陣缺口。

實際 Maven／Gradle 最小專案回歸（缺基準失敗、建立後舊違規通過、再新增違規失敗）：

```sh
MVN_BIN=/path/to/mvn GRADLE_BIN=/path/to/gradle \
  JAVA_HOME=/path/to/jdk17 ruby tools/java/tests/run-ci-integration.rb /tmp/java-ci-output
```

此項需要取得已固定版本的建置外掛與分析器，已由 run-all 在各 JDK 執行；一般基準回歸不連網，整合回歸缺少工具時明確列出 SKIP。
