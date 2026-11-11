# Java 自動檢查工具

本目錄把 15 份 Java 規範的小節連到可實作的工具規則，讓規則、驗收範例與人工責任有一致的對照。使用端專案預定以儲存庫 tag 固定版本引用；目前完成規則盤點與涵蓋率產生器，檢查器配置及整合入口由後續階段補齊。

## 三層架構

- IDE：提供即時提示，採用與提交檢查相同的規則定義。
- pre-commit：執行適合原始碼階段的 PMD／Checkstyle 檢查；需型別資訊的 XPath 必須具備正確 classpath，不能將解析失敗當作零違規。
- CI：分為編譯、位元碼、架構與建置檢查；契約測試及人工審查補足靜態分析無法判斷的內容。

規範中的違反／符合範例是後續規則回歸測試的資料來源；不同版本的範例、合成證據、抑制條件與已知漏報須分開記錄。本表保留失敗候選以免再次誤採，不能直接將全部映射啟用為阻擋規則。

## 規則對照表

唯一維護來源是 [rule-map.yml](rule-map.yml)。每筆是一個小節與一條工具規則的對照；同一規則適用不同小節時各有一筆，人工責任同小節合併一筆。工具專屬設定放在 note，不與正式規則名稱混用。

| 欄位 | 意義 |
| --- | --- |
| id | `JV-<文件縮寫>-<三位流水>`；縮寫表見 YAML 檔頭，ID 建立後不重編，新增取該文件最大號加一 |
| rule、title | 儲存庫相對文件路徑與 `#java-…` 錨點，以及小節原標題 |
| level | `error` 表強制要求，`warn` 表建議或啟發式提示；依條文及該檢查對應子句判定，非工具預設級別 |
| tier | `pre-commit`、`ci-compile`、`ci-bytecode`、`ci-arch`、`ci-build`、`test`、`manual` |
| tool、check | 工具及正式 ID；自訂為 `custom:<PascalCase>`；人工為 `none` |
| xpath | 僅 PMD 自訂規則有此欄，保留研究者實證過的原字串 |
| versions | 適用 Java 版本，與工具自身需要的執行 JDK 不同；不表示每版均已實證 |
| status | `verified` 正反例成功；`partial` 部分成功或已知漏報；`candidate` 未實證或實證失敗；`manual` 人工或待實作契約測試 |
| false_positive_risk、note | `low`／`medium`／`high`，以及例外、設定、誤報、實證版本或具體審查事項 |
| source | 來源盤點 ID 陣列；合併時保留所有來源，指紋與取捨見整併紀錄 |

同名 PMD 自訂規則共用完全一致的 XPath。`level: error` 不表示候選已可啟用；啟用仍須處理 note 中的適用範圍與精確抑制，不能藉全面排除目錄掩蓋必要審查。

## 涵蓋率現況

目前 143 個小節、307 筆映射，53 個小節至少有一筆 `verified`，涵蓋率 **37.06%**。映射狀態為 verified 87、partial 39、candidate 41、manual 140；詳細工具與層級統計見 [涵蓋率報告](coverage/coverage.md)。

只有 verified 小節計入分子，partial／candidate 不算；同小節有多條 verified 也只計一次。這是規則實證涵蓋率，不是完整契約或全部版本通過率；manual 可與 verified 並存。尚未寫成可執行測試的 test 責任已歸入 manual，因此目前 test 層為零。報告末尾的「工具未涵蓋的必要內容清單」列出 140 個小節的人工／測試責任，採用工具後仍須執行。

## 產生與自檢

只需要 Ruby 標準函式庫，不需安裝 gem；可由任何工作目錄呼叫絕對腳本路徑。

```sh
ruby tools/java/coverage/build-coverage.rb
ruby tools/java/coverage/build-coverage.rb --check
```

產生前會檢查所有 rule 錨點、標題、143 個小節的登錄完整性、唯一 ID、文件縮寫、欄位、列舉值、版本、來源及 XPath。`--check` 另確認已提交報告與當前 YAML 一致，不寫檔；錯誤回傳非零退出碼。[自檢紀錄](coverage/validation.md)保留本次輸出與負向檢查結果。

[整併取捨紀錄](coverage/merge-decisions.md)記載來源指紋、重複合併、複合規則拆分與等級修正。[一次性匯入腳本](coverage/merge-inventories.rb)保留本次整理過程，接受四份盤點所在目錄；它會重新分配初始 ID，僅供重現首版，後續維護請直接修改 rule-map.yml，勿重跑匯入覆蓋既有 ID。

## 後續檔案位置

下列標註「預定」者尚未建立，供後續實作使用；不代表已可執行。

```text
tools/java/
├── README.md
├── rule-map.yml
├── coverage/
│   ├── build-coverage.rb
│   ├── coverage.md
│   ├── merge-inventories.rb
│   ├── merge-decisions.md
│   └── validation.md
├── ide/                     # 預定：IDE 匯入與設定說明
├── pmd/                     # 預定：ruleset 與 XPath 規則
├── checkstyle/              # 預定：Checkstyle 設定與精確抑制
├── pre-commit/              # 預定：提交前執行入口
├── ci/
│   ├── compile/             # 預定：javac、Error Prone
│   ├── bytecode/            # 預定：SpotBugs
│   ├── architecture/        # 預定：ArchUnit
│   └── build/               # 預定：jdeps、jdeprscan、Maven／Gradle
└── tests/
    ├── fixtures/            # 預定：規範正反例及版本案例
    └── contracts/           # 預定：規則回歸與行為契約驗收
```
