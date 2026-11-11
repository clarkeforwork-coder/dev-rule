# javac 檢查

`lint-jdk8.txt`、`lint-jdk11.txt`、`lint-jdk17.txt`、`lint-jdk21.txt` 是 javac argument file；註解列出該版實測可用類別，非把 JDK 21 清單套到舊版。各檔預設為診斷工作（不含 `-Werror`）。JDK 8／11／17／21 分別為 20／27／31／34 類；`all`、`none` 是控制鍵。

```sh
javac --release 17 @vendor/dev-rule/tools/java/javac/lint-jdk17.txt -d target/lint @sources.txt
```

JDK 8 本機改為 `-source 8 -target 8`；跨編譯應使用 `--release`，不能只靠 source／target 防止誤用新版 API。來源檔名與 classpath 由消費專案建置系統提供。

## 阻擋工作

先清理基線，再在**獨立編譯工作**啟用已核准的型別安全與明確錯誤類別：

```sh
javac --release 17 \
  -Xlint:rawtypes,unchecked,varargs,overrides,finally,divzero,empty,removal,synchronization \
  -Werror -d target/lint-gate @sources.txt
```

不要在指定類別前加入 `-Xlint:none`：本次四版驗證發現它會壓掉後續指定類別的警告。

8 不開 removal／synchronization，11 不開 synchronization，21 可經基線審查加入 this-escape／lossy-conversions。`-Werror` 是全域選項，會將本次編譯的**所有警告**升為錯誤，包括註解處理器與非 lint 警告；沒有 `-Werror:rawtypes`。不可把 `-Xlint:all -Werror` 當成只阻擋指定類別。較廣的 `-Xlint:all` 另作報告工作；deprecation、serial、try、cast 等先供審查。Preview 預設不加 `--enable-preview`，核准與否仍須人工確認。

javac 原生訊息不能覆寫；CI 摘要以 rule-map 的 check 對照 `[ID] 標題 → rule`，同一類別對多個小節時全部保留，不得任意取第一筆。`-Xdoclint` 檢查文件形式，不能證明契約內容充分；`--release` 是建置限制，不等於某條 lint 診斷。`Integer(int)` 在 8 未棄用、11 為 deprecation、17／21 為 removal，測試明確使用實際目標平台。

## 重跑

```sh
JAVA_HOME=/path/to/jdk ruby tools/java/tests/run-ci-tools.rb
```

Ruby 僅供本庫驗收；從規範抽出原始範例與共同 imports，不改寫正反例。每例先做正常編譯，再只辨識指定類別警告；不以一般編譯錯誤冒充命中。工具錯誤與已驗證 JDK 的 verified 回歸皆非零退出。低版本不能編譯主範例時明示未驗證，不把單獨符合例算通過。

來源：[javac 21 官方選項](https://docs.oracle.com/en/java/javase/21/docs/specs/man/javac.html)；2026-11-11 inv-codex-b 四版實測清單。清單是固定基線，JDK 升級需重新驗證。
