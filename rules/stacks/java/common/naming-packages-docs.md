# Java 命名、套件與文件

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[命名與可讀性](../../../coding/naming.md)、[程式碼設計與公開介面](../../../coding/code-design.md)及[模組責任與公開入口](../../../architecture/module-boundaries.md)，定義 Java 命名形式、套件組織與契約文件要求。

本文件另依[nd-05](../../../coding/code-design.md#nd-05)辦理。

## 命名與套件責任

<a id="java-naming-form"></a>

### 一致的命名形式

Java 識別字須遵循一致的命名形式，並以業務概念與責任表達含義。類別、介面、列舉與 `record` 使用 `UpperCamelCase`；方法、欄位、參數與區域變數使用 `lowerCamelCase`；常數與列舉常數使用 `UPPER_SNAKE_CASE`；套件名稱使用小寫。團隊須統一縮寫慣例，避免同一概念大小寫不一致。不以 `final` 等修飾詞機械式判定常數，也不強制以 `I` 等名稱前綴標示介面。

<a id="java-specific-responsibility"></a>

### 名稱表達具體責任

依[命名與可讀性](../../../coding/naming.md)、[程式碼設計與公開介面](../../../coding/code-design.md)執行。Java 的 `Service`、`Handler`、`Helper`、`Utils` 可使用，但名稱須有明確責任且與行為一致。

<a id="java-package-boundaries"></a>

### 套件與架構邊界

套件須依業務或技術責任及專案架構組織，明確區分公開契約與內部實作，不強制固定目錄排列。共用套件須有明確責任與依賴方向，不作為雜項收容處，也不得反向依賴使用它的業務模組。邊界須以可見性及適用檢查落實，不能只靠套件名稱。

## 契約文件與維護

<a id="java-javadoc-contract"></a>

### 補足契約資訊

供使用端依賴的類別與方法須記錄型別及名稱無法充分表達的契約，依責任補充前置條件、結果、失敗、副作用與適用的生命週期保證。可包含非空、資源所有權、執行緒安全或資料時效等必要資訊，不要求每個方法套用全部項目。優先以 Javadoc 就近維護，或明確引用既有權威契約，避免重複定義；不以重述名稱代替說明。

<a id="java-rename-impact"></a>

### 重新命名與搬移的影響

類別、方法與套件重新命名或搬移時，須核對直接引用、設定、動態機制及外部使用端的影響。已構成公開或持久化契約的名稱，須依相容性要求處理，必要時安排遷移，並同步更新文件、範例與驗證。不僅依賴 IDE 重構結果，也不得因直接引用已更新就推定所有影響已處理。

<a id="java-document-verification"></a>

### 形式與語意分別驗收

依[形式與語意分別驗收的共通要求](../../../quality/rule-verification.md#nd-07)執行。Java 命名形式、Javadoc 參照及可執行範例須驗證實際結果；範例能在承諾支援的版本使用，不以文件產生成功代替內容正確。

<a id="java-closing-requirements"></a>

## 補充要求

共用責任與依賴另依[共通機制與程式碼共用](../../../architecture/shared-capabilities.md)，泛型參數命名依[型別宣告與泛型](types-and-generics.md)。動態引用的核對依[反射、動態能力與檢查抑制](reflection-and-suppression.md)，名稱成為外部值時另依[相等性、雜湊與排序](equality-hashing-ordering.md)及[狀態與結果建模](states-and-results.md)的契約要求。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響選擇檢查，測試層級及證據依[共通測試策略](../../../quality/testing.md)與[規範驗證](../../../quality/rule-verification.md)。

### 共同驗收

- [註解與公開文件、實作註解與暫時處理](../../../coding/code-design.md#acceptance-document-contract)。
- [形式與語意分別驗收](../../../quality/rule-verification.md#acceptance-document-verification)。
- [審查清單](../../../quality/rule-verification.md#審查清單)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-naming-form"></a>[一致的命名形式](#java-naming-form)、[名稱表達具體責任](#java-specific-responsibility) | 自動檢查適用的命名形式與團隊縮寫慣例，人工從使用處核對名稱與實際責任一致。確認未將所有 `final` 欄位機械式視為常數，也未用籠統後綴掩蓋不同用途。 |
| <a id="acceptance-java-package-boundaries"></a>[套件與架構邊界](#java-package-boundaries) | 審查套件責任、公開與內部界線，以及共用套件依賴方向；以適用的可見性與依賴檢查確認邊界有效，不僅核對目錄名稱。 |
| <a id="acceptance-java-javadoc-contract"></a>[補足契約資訊](#java-javadoc-contract) | 核對供使用端依賴的類別與方法優先以 Javadoc 就近維護必要契約，或明確引用既有權威契約；確認 Javadoc 與實際前置條件、結果、失敗、副作用及適用生命週期一致。 |
| <a id="acceptance-java-rename-paths"></a>[重新命名與搬移的影響](#java-rename-impact) | 重新命名或搬移後，核對直接引用、設定、動態登錄、序列化或持久化引用及外部使用端等適用路徑。確認相容性與必要遷移已有處置，文件與範例同步更新。 |
| <a id="acceptance-java-javadoc-examples"></a>[形式與語意分別驗收](#java-document-verification) | 驗證受影響的連結、Javadoc 參照與適用範例，確認在支援版本下可用。 |

既有程式碼與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行放寬要求。
