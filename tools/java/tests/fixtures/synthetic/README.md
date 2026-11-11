# 合成回歸樣本

執行 `ruby tools/java/tests/run-synthetic.rb`，或由 `run-all.sh` 一併執行。每個目錄是正式 PMD 規則名稱或 Checkstyle ID；`bad*.java` 必須命中該規則，`good*.java` 必須不命中，並核對 priority／severity。不同目錄的其他診斷不影響此規則的斷言；RawGenericType 另斷言一個宣告只報一次。

`bad` 表示預期有工具診斷。JV-ND-019 的固定時長逾時／TTL 仍會有 warning，這是提醒而非已證明的違規；DurationUsedForCalendarDay/good-timeout.java 同時確保較精確的 PMD 規則不誤報。這些合成證據不會把 partial 升為 verified。

樣本使用 Java 17 語法解析；Lambda var 為 Java 11 語法，Stream.toList 為 Java 16 API。PMD 可在 JDK 8 啟動並解析較新語法，但不代表 JDK 8 能編譯全部 fixtures；原規範可編譯性由 `scripts/check-rules.rb` 驗證。
