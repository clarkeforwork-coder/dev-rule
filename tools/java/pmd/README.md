# Java PMD 規則集

固定使用 **PMD 7.29.0**。`ruleset.xml` 有 65 條規則、66 筆非候選映射；`ruleset-candidates.xml` 有 9 條候選規則，不由預設集合引用。自訂規則分別內嵌在這兩個檔案，沒有獨立規則 XML 或第二份 Maven 專用集合。

來源為 [PMD 官方發行檔](https://github.com/pmd/pmd/releases/download/pmd_releases%2F7.29.0/pmd-dist-7.29.0-bin.zip)，下載檔 SHA-256：

```text
d27177c185b837fa57f097e482d1253468aa035379c5eb2671fa0a279109b179
```

下載、解壓至自行指定的暫存目錄，將 `PMD_BIN` 指到解壓後的 `pmd-bin-7.29.0/bin/pmd`。Java 21 範例涉及 JDK 21 型別，回歸驗收以 JDK 21 執行 PMD，透過 `--use-version java-8/11/17/21` 分別解析範例；這不是四種 JDK 執行期矩陣，也不是 `javac --release` 編譯驗收。實務專案須提供相應 `--aux-classpath` 型別資訊。

```sh
export JAVA_HOME=/你的/jdk-21/Contents/Home
export PMD_BIN=/你的/暫存目錄/pmd-bin-7.29.0/bin/pmd
ruby tools/java/tests/run-pmd.rb --output /你的/暫存目錄/examples
```

也可傳 `--pmd` 與 `--aux-classpath`（或 `PMD_AUX_CLASSPATH`）。腳本從任何工作目錄皆可執行，範例清單、PMD JSON 與 log 留在輸出目錄；未指定則建立唯一暫存目錄。指定目錄應專供此次驗收，避免覆蓋其他檔案。

每筆 verified 對照都要求該小節至少有違反及符合範例，並逐一核對命中；版本增量範例也計入，不因 mapping 的版本清單省略舊版符合例。partial 僅報告，不計語意失敗；執行、解析或設定錯誤一律使驗收失敗。為減少啟動成本，依四個語法版本批次執行完整預設集合，再用實際規則名稱核對各筆範例，不將其他規則的命中算為成功。

收尾後嚴格驗收 **45 通過、0 失敗**（21 partial 僅報告）；詳 [最新完整驗收紀錄](../tests/validation.md)，原 [validation.md](validation.md) 保留歷史。缺少規範案例不以合成案例冒充，已知不涵蓋的 Java 21 違反例也不略過。

## 規則來源與重建

```sh
ruby tools/java/pmd/build-rulesets.rb
```

唯一來源是 [rule-map.yml](../rule-map.yml)。40 個內嵌自訂定義的 XPath 與 rule-map 逐字一致；NarrowingPrimitiveCast 已依收尾裁決擴充 Math.clamp 分支；PMD 7 的 XPathRule 使用 XPath 3.1，不設定舊版的 `version` 屬性。每筆引用各自帶有規範 ID、標題、錨點、外部連結，以及 error→1／warn→3 的優先序。相同內建 PMD 規則對應多筆映射時，引用名稱加上 `_JV_XX_NNN`，避免 PMD 僅保留最後一份設定而丟失條文與優先序；例如 `UseTryWithResources_JV_ER_018` 為 3，`UseTryWithResources_JV_ER_024` 為 1。這些別名會各自報告，也要各自精確抑制。

自訂規則直接內嵌，使用原規則名。RawGenericType 的 JV-TG-005／025 共用一次診斷與 `PMD.RawGenericType` 抑制名稱，訊息包含兩個條文 ID；相同 XPath 不重複執行。內建屬性保留預設：note 的「可用 allowedTypes 放寬」等只是可選的專案例外，沒有已核准的型別清單可套用。

套用前須閱讀 [抑制與適用邊界](suppressions.md)。此集合包含需個別限定範圍的啟發式規則，特別是併發測試等待、資源管理擁有者、反射及資料邊界；接入專案前應明確選擇來源集與核准例外。候選集合只供評估，不作提交阻擋。

候選 JV-SR-006 ExhaustiveSwitchHasDefault 的內建動態訊息不接受 message 覆寫；候選 XML 與一致性檢查已記錄此限制，修妥前不可升正式。
