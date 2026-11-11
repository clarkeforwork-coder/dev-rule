# Java Checkstyle 設定與驗證

此設定對應 rule-map 的 36 筆 Checkstyle 映射：正式 `checkstyle.xml` 含 22 個檢查實例（17 verified、5 partial），`candidates.xml` 保留 14 個 candidate 實例供評估，不接入預設提交阻擋。相同模組可對應不同 ID；合計 28 種模組名稱（不含 Checker、TreeWalker、SuppressionFilter）。候選包括不宜直接啟用的 DesignForExtension；候選成功載入不等於正反例已驗證。兩份設定皆供 10.26.1 與 9.3 共用，並非依版本分叉。

每個實例以映射 ID 識別、以原 level 設定 severity（warn 對應 warning），診斷以前綴 `[JV-XX-NNN] 條文標題 → 規範路徑#錨點` 呈現。Regexp 使用 `message` 屬性；內建模組不提供通用 `message` 屬性，改用 Checkstyle 的 `<message key="..." value="..."/>` 覆寫診斷。XML 的 source 會是指定的 ID；測試先核對 ID 與模組名稱，再用 source 與訊息前綴確認命中。

## 重現

需要 Ruby（含 REXML）、curl 及相容 JDK；設定 JAVA_HOME 時優先使用該執行期，10.26.1 需 JDK 11+。未設定時尋找 JDK 17，9.3 優先尋找 JDK 8。可設定 `JAVA17_HOME`、`JAVA8_HOME`，macOS 也會透過 `java_home -F` 嚴格尋找版本。執行期版本會另外檢查，避免系統默默回退到其他 JDK。

```sh
ruby tools/java/tests/run-checkstyle.rb
# 亦可單跑一版：
ruby tools/java/tests/run-checkstyle.rb 9.3
```

腳本不依賴目前工作目錄。`CHECKSTYLE_CACHE` 可指定 JAR 暫存目錄，預設為系統暫存目錄下 `dev-rule-checkstyle`。首次下載自官方 GitHub release，之後每次核對 [versions.json](versions.json) 固定的 SHA-256；雜湊為本次下載計算的固定指紋，沒有宣稱為獨立簽章驗證。下載不完整或指紋不符即失敗，不覆寫既有 JAR。

從原規範錨點擷取每個違反／符合 Java 區塊，包含 Java 8／17／21 的額外範例。保留原碼、分檔檢查，不補寫替代反例；Checkstyle 不做型別解析，這些範例通過不表示可在執行期 JDK 編譯或使用 API。每筆 verified 的所有違反範例必須命中該 ID，所有符合範例必須不命中，並核對 severity。設定載入、語法解析、報告缺檔與異常退出碼均不得視為零違規。退出碼 0 為全通過、1 為範例不符、2 為工具或配置錯誤。

## 正則與局部涵蓋限制

精確 pattern 位於各模組的 `format` 屬性；所有 RegexpSinglelineJava 都設 `ignoreComments=true`、`maximum=0`。字串／文字區塊內看似 Java 的文字仍可能誤報，不處理符號解析及接收者型別。

| ID | pattern 判斷範圍及誤報／漏報 |
| --- | --- |
| JV-TG-001 | 辨識區域變數及 Lambda 的 var；字串相同文字會報，跨行宣告可能漏報。 |
| JV-LS-003 | 僅比對 `\(\s*var\s+` 的 Lambda 參數，不再對區域變數 var 重複報告；不能檢查省略型別的 Lambda，維持 partial。 |
| JV-ER-013 | RegexpMultiline 僅辨識空的 `catch (InterruptedException name) { }`；註解／字串／文字區塊中的相同文字可能誤報，有註解的空 catch、限定名稱、多重 catch 及有內容但吞中斷皆可能漏報。不能證明中斷契約正確。 |
| JV-ND-002 | 辨識 `new BigDecimal` 的浮點 literal、cast 或列舉的 Double／Float 轉換呼叫；無法判斷變數型別、限定類名、別名與跨行，字串可能誤報。 |
| JV-ND-019 | 所有 `Duration.ofDays(`／`ofHours(` 都報；固定時間長度契約也會誤報，不能由文字判斷日曆語意。已依審閱裁決降為 warning，不阻擋提交；較精確的日曆語意檢查由 PMD DurationUsedForCalendarDay 補足。 |
| JV-ND-022 | 辨識列舉時間型別的零參數 now、System.currentTimeMillis 與零參數 new Date；時鐘適配器／測試可能誤報，static import、換行與自訂包裝可能漏報。 |
| JV-ND-026 | 辨識 ResolverStyle.SMART／LENIENT；業務允許的其他解析契約、字串可能誤報，static import／換行可能漏報。 |

partial 的 EqualsHashCode、MissingJavadocMethod、IllegalType 僅檢查 rule-map 記載子句，不代表語意全覆蓋。重複映射的 RegexpSinglelineJava、EqualsHashCode 可能針對同一行輸出不同 ID，保留追溯而非把它們合為一筆。

## 收尾裁決與驗證

JV-ER-008 限定 Throwable／Error、error、partial，以自製樣本實證；新增 JV-ER-031 限定 Exception／RuntimeException、warning、verified，以原規範正反例驗證。兩版現均 17 筆／44 範例全數通過，以 `tools/java/tests/run-checkstyle.rb` 執行即可重現；例外規則見 [suppressions.md](suppressions.md)。

測試與 hook 共用 toolbox 的 SHA-256 校驗快取，不再另建測試下載目錄；`toolbox.sh checkstyle-path [9.3|10.26.1]` 可取得指定版本的已驗證 jar 路徑。
