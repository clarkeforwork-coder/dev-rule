# 規範檢查

本機需 Ruby 2.6 以上（只使用標準函式庫）及 JDK 17。在儲存庫根目錄執行 `ruby scripts/check-rules.rb` 執行全部檢查，也可指定 `links`、`skeleton`、`headings`、`template`、`examples`，例如 `ruby scripts/check-rules.rb links headings`。GitHub Actions 在 PR 與推送到 `main` 時使用 Ruby 3.3、Temurin 17 執行相同入口。

`links` 檢查本地 Markdown 連結的檔案與錨點，Java → 共通整檔連結列為警告並計數，但不影響結束碼，失效連結仍算失敗；`skeleton` 檢查共通文件 S1–S8（一級標題、層級、語意錨點、導言、驗收位置、樣板、重複與整檔連結位置），沿用既有檢查器的 README／跨主題驗收索引 S5 例外與 README 的 S8 例外；`headings` 檢查所有文件的重複標題文字及明訂錨點；`template` 限制共通樣板句只在 testing.md，並要求 15 份 Java 主題各有一份以「共同驗收與 Java 語言增量」起頭的導言段落，去除換行後只比對第一句（至第一個「。」），15 份須相同（以最多數版本列出差異），之後依主題不同的案例選擇句不比對；`examples` 將「違反／符合」後的 Java 區塊補上常用 import，逐一在暫存目錄以 javac 17 編譯，僅驗證語法與型別，不執行範例，其他 `java` 區塊不編譯。

問題輸出為 `檔案:行 [規則] 說明`，行號從 1 起算；最後一行列出各項狀態、問題數與檢查範圍。結束碼 0 表示所有指定檢查通過，1 表示有問題，2 表示參數錯誤或因缺少 javac 跳過（跳過不算通過）。Markdown 檢查忽略程式碼圍欄，支援 ATX 標題、`<a id>`、行內連結及完整／縮寫 reference links；不連線檢查外部網址。依輸出的文件與行號檢查原因，不以工具通過取代語意審查。
