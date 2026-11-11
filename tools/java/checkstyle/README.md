# Java Checkstyle 設定與驗證

此設定對應 rule-map 的 35 筆 Checkstyle 映射：正式 `checkstyle.xml` 含 21 個檢查實例（17 verified、4 partial），`candidates.xml` 保留 14 個 candidate 實例供評估，不接入預設提交阻擋。相同模組可對應不同 ID；合計 28 種模組名稱（不含 Checker、TreeWalker、SuppressionFilter）。候選包括不宜直接啟用的 DesignForExtension；候選成功載入不等於正反例已驗證。兩份設定皆供 10.26.1 與 9.3 共用，並非依版本分叉。

每個實例以映射 ID 識別、以原 level 設定 severity（warn 對應 warning），診斷以前綴 `[JV-XX-NNN] 條文標題 → 規範路徑#錨點` 呈現。Regexp 使用 `message` 屬性；內建模組不提供通用 `message` 屬性，改用 Checkstyle 的 `<message key="..." value="..."/>` 覆寫診斷。XML 的 source 會是指定的 ID；測試先核對 ID 與模組名稱，再用 source 與訊息前綴確認命中。

## 重現

只需 Ruby 標準函式庫、curl、JDK 17；如有 JDK 8 會用它執行 9.3。可設定 `JAVA17_HOME`、`JAVA8_HOME`，macOS 也會透過 `java_home -F` 嚴格尋找版本。執行期版本會另外檢查，避免系統默默回退到其他 JDK。

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
| JV-TG-001、JV-LS-003 | 辨識 `var name =`、`var name :`、`var name )` 等；字串相同文字會報，跨行宣告可能漏報；不能檢查省略型別的 Lambda。 |
| JV-ER-013 | RegexpMultiline 僅辨識空的 `catch (InterruptedException name) { }`；註解／字串／文字區塊中的相同文字可能誤報，有註解的空 catch、限定名稱、多重 catch 及有內容但吞中斷皆可能漏報。不能證明中斷契約正確。 |
| JV-ND-002 | 辨識 `new BigDecimal` 的浮點 literal、cast 或列舉的 Double／Float 轉換呼叫；無法判斷變數型別、限定類名、別名與跨行，字串可能誤報。 |
| JV-ND-019 | 所有 `Duration.ofDays(`／`ofHours(` 都報；固定時間長度契約也會誤報，不能由文字判斷日曆語意。原 level 是 error，本次未擅自降級，導入前須判定精確適用範圍。 |
| JV-ND-022 | 辨識列舉時間型別的零參數 now、System.currentTimeMillis 與零參數 new Date；時鐘適配器／測試可能誤報，static import、換行與自訂包裝可能漏報。 |
| JV-ND-026 | 辨識 ResolverStyle.SMART／LENIENT；業務允許的其他解析契約、字串可能誤報，static import／換行可能漏報。 |

partial 的 EqualsHashCode、MissingJavadocMethod、IllegalType 僅檢查 rule-map 記載子句，不代表語意全覆蓋。重複映射的 RegexpSinglelineJava、EqualsHashCode 可能針對同一行輸出不同 ID，保留追溯而非把它們合為一筆。

## 已知驗收衝突

JV-ER-008 是唯一不符：rule-map 的 error 子句與最後設定限定 Throwable／Error，但小節原違反範例只有 Exception。依嚴重故障子句配置後兩版都是零命中；若加入 Exception 並沿用 error，會把條文「優先」及合法最外層入口升級成全面禁止。原 note 也要求 Exception 使用 warning，然而該映射只有一個 error level。本次保留 error 子句設定與原始失敗，未改 rule-map、未跳過測試、未以合成樣本頂替。需由整併者拆分 Exception 的 warning 映射，或更正 verified 的證據與狀態後重驗。

截至本次驗證，兩版均為 16/17 筆通過、43/44 範例通過；「所有 verified 通過」尚未達成，腳本回傳 1。完整輸出與環境見 [validation.md](validation.md)。例外原則與範本見 [suppressions.md](suppressions.md)。
