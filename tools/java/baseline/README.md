# 精確違規基準

此工具依[精確違規基準](../../../rules/workflow/rule-governance.md#precise-violation-baseline)比對完整 PMD／Checkstyle XML 報告，只阻擋新增 error。單檔 `Baseline.java` 無第三方依賴，使用 Java 8 語法與 API；消費端只需要 JDK 與 POSIX shell，不需要 Ruby／Python。

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

`create` 要求負責人與 ISO 日期，不覆寫既有檔案。建立基準屬首次接入的審查動作；PR 不應重新 `create` 吸收新問題。`check` 不修改基準，列出新增診斷與已清償筆數。結束碼：0＝無新增 error，1＝新增 error，2＝輸入／設定／工具錯誤。PMD priority 1／2 與 Checkstyle error 阻擋；其餘支援等級只警告。所有子命令至少須指定一份報告；`--pmd`、`--checkstyle` 可重複指定不同報告，但不可重複傳入同一檔案。若基準含兩種工具就必須提供兩者報告。

報告路徑、基準路徑相對於工作目錄；報告內相對來源路徑相對於專案根目錄（預設工作目錄，可用 `--root` 指定）。來源必須存在且位於根目錄內，包含符號連結解析後的位置。PMD XML 必須使用正式 ruleset，使訊息保留 `[JV-…]` 與規範錨點；未知診斷、工具錯誤與不合法 XML 不可納入基準。XML 禁止 DTD／外部實體。

## 可審查的格式

UTF-8 TSV，第一行是 `# dev-rule-baseline-v1`，第二行是欄名：

```text
tool  rule  file  sha256  level  count  owner  due  message
```

上例以空格顯示欄位，實檔使用 Tab。每列為工具＋規則 ID＋專案相對檔名＋診斷起始行的 SHA-256＋等級；`count` 保存相同鍵的出現次數。指紋只移除該行首尾空白，保留行內空白，避免把字串常值變更視為相同內容。行號只用於診斷輸出，不寫入識別鍵，因此上方插入三行仍命中。等級參與鍵，warning 升級 error 必須重新阻擋；工具參與鍵，避免兩種分析器互相抵銷。輸出依鍵排序，方便 diff。

`owner` 與 `due` 可逐列編輯；必須非空且日期合法。期限供清償追蹤，工具不因到期自動豁免或更改等級。相同內容重複出現用次數限制，不用集合去重，新增相同違規仍會失敗。訊息保留規範連結，供審查定位；欄位不允許 Tab／換行。

此版採「行內容」指紋而非 AST／方法定位：相同檔案內刪除一處並新增完全相同內容的另一處，無法區分其語意位置；跨行違規若只改起始行以外的內容，也可能仍命中。敏感變更需人工審查，後續可升級格式加入語意位置／多行指紋。重新命名檔案或修改起始行會視為新違規。程式不以全專案總數互相抵銷。

## 清償與 PR 門檻

修正後重新產生全部報告，再執行同樣參數的 `prune`：

```sh
sh vendor/dev-rule/tools/java/baseline/run.sh prune \
  --baseline dev-rule-baseline.tsv \
  --pmd target/pmd.xml --checkstyle target/checkstyle-result.xml
```

`prune` 只保留仍存在的舊鍵、減少次數，保留原負責人／期限；有新增 error 時退出 1 且不修改基準，絕不吸收新增違規。把刪減基準的 diff 與修正一起提交，之後復發就會失敗。`check` 會列出已清償數，PR 審查必須確認已執行 `prune`；它不會在 CI 偷改版本控制內容。不要用局部報告執行 prune；CLI 無法判斷使用者是否漏傳同工具的某個 source set，也無法證明手動提供的報告與來源同版本。CI 應從乾淨 checkout 執行完整建置。

Git hook 以 HEAD／index 的新增行決定範圍，可在提交前快速檢查；本基準則比較 CI 完整分析所得的具體違規，兩者互補。不得以基準關閉編譯、測試或其他 CI 分析器。

## Maven 與 Gradle

合併既有 Maven 片段後，以 `mvn -Pdev-rule-baseline verify` 啟用。profile 只解除 PMD／Checkstyle 原生違規失敗，由排列在報告外掛之後、同在 verify 階段的 exec 外掛執行基準檢查；Maven 沒有「verify 後」的獨立階段。請保留外掛順序，每個模組各自維護根目錄下的 `dev-rule-baseline.tsv`，不要用聚合根的一份局部報告替代子模組。無 Java 原始碼的聚合 POM 不應啟用該執行。

Gradle 使用 `./gradlew -PdevRuleBaseline check`。`devRuleBaselineCheck` 依賴所有 PMD／Checkstyle task，收集各 source set 的 XML；NO-SOURCE 轉成明確空報告，防止讀入上次建置殘留報告。其他跳過狀態與缺少報告會失敗；建置工具仍負責解析與執行錯誤。首次產生報告時可執行 `./gradlew -PdevRuleBaseline checkstyleMain pmdMain checkstyleTest pmdTest`，再將所有非空 source set 的報告傳給 `create`。後續 CLI prune 同樣需完整範圍。

`run.sh` 優先使用 `JAVA_HOME`，否則使用 PATH；請與建置使用同一個 JDK。編譯快取在 `$HOME/.cache/dev-rule-baseline`，可用 `DEV_RULE_BASELINE_CACHE` 改位置。快取鍵包含原始碼與 javac 版本，未改動時直接執行；此處 cksum 僅用於快取失效，不是下載工具的信任校驗。沒有外部 JAR 下載。也可直接執行：

```sh
javac -encoding UTF-8 -d /tmp/baseline-classes vendor/dev-rule/tools/java/baseline/Baseline.java
java -cp /tmp/baseline-classes Baseline check --baseline dev-rule-baseline.tsv --pmd target/pmd.xml
```

未來 SpotBugs／Error Prone 應新增報告轉換器，沿用規則、檔案、內容指紋、等級與次數的模型；目前未知工具明確拒絕，不宣稱已支援。

## 本庫驗證

```sh
JAVA_HOME=/path/to/jdk17 JAVA8_HOME=/path/to/jdk8 tools/java/tests/run-baseline.sh
```

測試使用暫存來源與 XML，驗證建立、既有違規、新增、重複、行號位移、清償、復發、warning、工具錯誤、外部實體與缺報告。測試端使用 Ruby，消費端不需要；`run-all.sh` 已串接本階段。JDK 8 未提供時會明確顯示矩陣缺口。

實際 Maven／Gradle 最小專案回歸（缺基準失敗、建立後舊違規通過、再新增違規失敗）：

```sh
BASELINE_BUILD_INTEGRATION=1 MAVEN_BIN=/path/to/mvn GRADLE_BIN=/path/to/gradle \
  JAVA_HOME=/path/to/jdk17 JAVA8_HOME=/path/to/jdk8 tools/java/tests/run-baseline.sh
```

此項需要取得已固定版本的建置外掛與分析器，因此以明確旗標啟用，適合完整 CI 環境；一般基準回歸不連網。
