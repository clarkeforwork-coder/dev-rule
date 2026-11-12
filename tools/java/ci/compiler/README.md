# 編譯器包裝

`javac.sh` 每次在私有暫存目錄編譯 Java 包裝器，不使用編譯快取；消費端不需要 Ruby／Python。最終參數以 argfile 傳給 javac，在消費端參數之後加入 `-Xmaxwarns 2147483647 -Xmaxerrs 2147483647`，避免前面的未映射警告截斷政策診斷。

Error Prone JAR 放在 processor path 最前。明訂 `-processorpath`／`--processor-path` 時保留原值，未指定時使用 `-classpath`／`-cp`／`--class-path` 的值，保留 classpath annotation processor 探索。

rule-map 只讀取一次，建立 check 對診斷的一對多映射，逐行掃描 javac 輸出；每個相符行都附 ID 與錨點。warn 標註但不阻擋，candidate 不標註；原始 javac 非零退出碼優先保留。

政策違規時刪除 `-d` 目錄內所有一般 `.class` 檔，保留資源及目錄，不追蹤符號連結。這會連同同目錄既有 class 一併失效，讓 Maven 下次確實重編；因此 `-d` 必須是專案專用的編譯輸出目錄。未提供 `-d` 時不清除來源目錄，建置系統接入應始終指定 `-d`。

本庫回歸：`JAVA_HOME=/path/to/jdk ruby tools/java/tests/run-compiler-regressions.rb`；可另提供 `MVN_BIN` 驗證 Maven 連續兩次 compile 都拒絕 rawtypes，不執行 clean。
