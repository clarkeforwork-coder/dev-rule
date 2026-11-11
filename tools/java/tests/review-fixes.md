# Java pre-commit 審閱修正與驗證

日期：2026-11-11；分支 `tools/java-precommit`。本次修改限於 `tools/java/`；未修改根目錄 `rules/`、`scripts/`，未推送、未建立 PR。執行環境為 macOS arm64、Bash 3.2.57、Temurin 17.0.19／21.0.13、Zulu 8.0.512、Maven 3.9.9、Gradle 8.14.3。

## 逐項處理

| 項目 | 修正 | 驗證 |
| --- | --- | --- |
| H-1 | shell 具名變數改 `${var}`；EXIT trap 保存原退出碼。新增 run-hook-failure.sh，使用 /bin/bash 與 UTF-8 語系 | 離線 PMD jar 竄改、缺少、JDK 17 解析 Java 21 語法皆 exit 2；不再出現 unbound variable；納入 run-all |
| H-2 | 自訂 XPath 內嵌到正式／候選 ruleset，刪除 pmd/rules；不產出 Maven 專用副本；映射與生成來源仍為 rule-map.yml | 一致性讀取內嵌規則；Maven／Gradle 正式規則集在 JDK 17、8 的合規專案通過，raw List 違規失敗 |
| H-3 | RawGenericType 排除父節點 ClassType 的限定部分，使用 PMD 標準 Map.Entry 型別名；TG-005／025 合併一條診斷，訊息保留兩 ID | Map.Entry 與 Set<Map.Entry<…>> 不報；raw List、raw Map.Entry 各一筆；一致性允許多映射對一規則 |
| H-4 | Lambda catch 排除 throw、interrupt、cancel、shutdownNow，維持 error | 吞錯命中，四種處理各有 good fixture 不命中 |
| M-1 | 21 筆無本庫可重跑證據的 CI verified → partial，保留研究描述並註明待 CI；coverage 只計 PMD／Checkstyle verified，另列 CI 層候選 | verified 62、partial 66、candidate 40、manual 140；43／143＝30.07%；CI 層候選 57 筆；README 同步 |
| M-2 | 先擷取版本引號字串，再解析主版本及 1.8 前綴 | `21`、`17.0.19`、`1.8.0_512` 假 java 回應皆進入離線快取檢查，無不支援版本誤判 |
| M-3 | ND-019 error → warn，Checkstyle warning | ofHours／ofDays fixture 命中 warning；ofMinutes 不命中；PMD 逾時樣本不命中 |
| M-4 | LS-003 限縮 `\(\s*var\s+`；維持 partial | Lambda var 命中；區域 var、明確型別 Lambda 不命中；不宣稱抓到省略型別的 value → |
| M-5 | 依下表修正 level；ER-010 由 candidate → partial 並加入正式 error 集合 | 一致性確認 Checkstyle severity／PMD priority；Throwable／Error 各命中 error、具體例外不命中 |
| M-6 | 兩份 README rev 統一 commit SHA；本層納入正式版本後改用 tag | 不再以尚未發布的 v1.0.0 作接入範例 |
| M-7 | 以新 run-build-integration.rb 建立最小 Maven／Gradle 專案，直接用正式片段及規則集 | 8 組建置結果詳下表及完整 log；舊 VERIFICATION／validation 標為歷史並連至本紀錄 |
| M-8 | NarrowingPrimitiveCast 排除 CompileTimeConstant、char、byte 的 0xFF 遮罩；補 double → float，維持 error | 常數、常數運算式、char 與遮罩 good；int、byte、float 縮窄 bad 皆命中；原規範 Math.clamp 仍命中 |
| M-9 | Wildcard 排除巢狀 Class<?>；forEach 排除 Lambda 自宣告集合；Stream 只計同一 Block 的直接終端操作；LazyStream 排除 collect／toList／toArray 實體化鏈；Thread 排除 shutdown hook／ThreadFactory；formatter 支援 static import STRICT | 六規則逐一 bad／good fixtures；仍有語意誤報的 StreamVariableReused、NoUnmanagedThread、DateTimeFormatterPatternNotStrict 改 warn＋partial，note 明列剩餘情境 |
| M-10 | ObjectValuedDataShape 改型別後代比對；NowWithoutClock 檢查引數非 Clock，涵蓋 Calendar 引數重載 | 巢狀 Map、Map 陣列、now(ZoneId)、getInstance(TimeZone) 命中；明確資料型別與 now(Clock) 不命中 |
| L-1 | evidence 與 validation 移除本機絕對路徑，以 REPO／TMP／JDK 佔位 | 全文掃描無使用者家目錄、macOS 暫存路徑；保留完整診斷與退出碼 |
| L-2 | README 補 Bash 3.2／UTF-8 實測說明 | 本機 /bin/bash 為 3.2.57，三種失敗皆非零 |
| L-3 | run-checkstyle.rb 透過 toolbox checkstyle-path 取得已校驗快取，不自行下載 | JDK 8 的 9.3、JDK 17／21 的 10.26.1 共用 hook 快取，正式 17 筆／44 範例全過 |
| L-4 | 保留只支援 8／11／17／21 的設計 | JDK 25 仍拒絕；新增版本須另行驗證 profile，未擴大支援宣稱 |
| L-5 | 候選 XML 註明 ExhaustiveSwitchHasDefault 動態訊息覆寫無效；一致性檢查要求此註記 | 該候選未進正式集合；修妥訊息前不可升正式 |
| L-6 | note 加盤點檔名、原始筆序與穩定 ID；未保存的暫存結果明示為歷史研究；新增來源 SHA-256 索引 | 參見 coverage/inventory-provenance.md；SpotBugs 目標統一 4.10.5，CA-004／012 的舊 4.8.6 歷史證據明示待重驗，未偽稱新版本實跑 |
| L-7 | 保留 regex 字串常值誤報限制 | TG-001、ND-022、ND-026 的字串常值誤報仍需精確抑制，未宣稱解決 |

## M-5 level 前後與條文依據

提示等級不解除條文義務；啟發式可能命中合法程式時以 warn 交由審查。

| ID | 前 → 後 | 條文句與採用依據 |
| --- | --- | --- |
| JV-SR-002 | warn → error | 「Java 應以對應狀態型別保護必要資料，不只用狀態碼搭配多個可空欄位讓使用端推測。」與其他實質 manual 義務一致 |
| JV-ND-028 | error → warn | 「Java 解析及格式化須明訂格式、地區、時區／偏移及精度，不允許寬鬆修正非法日期或只解析前段。」只用於輸出的 formatter 不必 STRICT；partial 保留此誤報 |
| JV-CO-011 | error → warn | 「Java Iterator 或 Stream 不保證實際有界；排序、去重及分組的保留資料成本仍須核對。」sorted().limit() 本身不能證明來源無界；精確無界規則 CO-012 仍 error |
| JV-RS-002 | error → warn | 「必要的存取放寬須個別核准並驗證影響，不得以框架、映射或測試用途自行豁免。」ReviewReflectiveFieldWrite 只能提出審查，無法判斷是否已核准 |
| JV-CA-015 | error → warn | 「不以固定睡眠或壓力測試單獨證明安全。」並非禁止一切 Thread.sleep，故採條件式提醒 |
| JV-NP-030 | error → warn | 「不要求每個方法套用全部項目。優先以 Javadoc 就近維護，或明確引用既有權威契約」；JavadocMethod 全標籤檢查只能提醒 |
| JV-ER-009 | warn → warn | 「優先捕捉具體例外並縮小 try 範圍」；保留一般廣泛捕捉提醒 |
| JV-ER-010 | error（candidate）→ error（正式 partial） | 「不得以廣泛捕捉 Throwable 或 Error 掩蓋嚴重故障並繼續操作。」以合成樣本證明命中，補純 PMD 路徑缺口；不冒充規範 verified |

## 正式建置結果

`run-build-integration.rb` 只替換消費端 source／target，沒有替換正式規則集或抑制設定。每次執行 clean；good 是空的 final class，bad 是含 raw java.util.List 參數的 final class，必須由 RawGenericType 命中而失敗。

```sh
JAVA_HOME=<JDK17或JDK8> MAVEN_BIN=<Maven3.9.9>/bin/mvn GRADLE_BIN=<Gradle8.14.3>/bin/gradle \
  ruby tools/java/tests/run-build-integration.rb <輸出目錄>
```

| 工具 | JDK | 合規 | 自訂違規 | 完整輸出 |
| --- | --- | --- | --- | --- |
| Maven verify | 17 | exit 0，BUILD SUCCESS | exit 1，RawGenericType／BUILD FAILURE | [good](evidence/review-fixes/maven-jdk17-good.log)、[bad](evidence/review-fixes/maven-jdk17-bad.log) |
| Maven verify | 8 | exit 0，BUILD SUCCESS | exit 1，RawGenericType／BUILD FAILURE | [good](evidence/review-fixes/maven-jdk8-good.log)、[bad](evidence/review-fixes/maven-jdk8-bad.log) |
| Gradle check | 17 | exit 0，BUILD SUCCESSFUL | exit 1，RawGenericType／pmdMain FAILED | [good](evidence/review-fixes/gradle-jdk17-good.log)、[bad](evidence/review-fixes/gradle-jdk17-bad.log) |
| Gradle check | 8 | exit 0，BUILD SUCCESSFUL | exit 1，RawGenericType／pmdMain FAILED | [good](evidence/review-fixes/gradle-jdk8-good.log)、[bad](evidence/review-fixes/gradle-jdk8-bad.log) |

## 完整測試結果

JDK 8、17、21 的 `run-all.sh` 全部 exit 0：319 個規範範例抽取、涵蓋率一致、雙向設定一致、PMD verified 45 通過／0 失敗（partial 21 僅報告）、Checkstyle verified 17 筆／44 範例全過、55 個合成 fixtures 全過、3 個版本解析與 3 個 hook 失敗案例全過。三次的 Java 21 語法失敗案例均使用本機真實 JDK 17；Linux 無 JDK 17 時腳本另有舊 profile 後備路徑。

完整輸出：[JDK 8](evidence/review-fixes/run-all-jdk8.log)、[JDK 17](evidence/review-fixes/run-all-jdk17.log)、[JDK 21](evidence/review-fixes/run-all-jdk21.log)。保留所有診斷行，將機器路徑換成佔位符並清除行尾空白。

`PATH=<JDK21>/bin:$PATH ruby scripts/check-rules.rb` 六項通過：links 945、失效 0、既有警告 53；skeleton 39；headings 55；template 15；examples 319；versions 97。[完整輸出](evidence/review-fixes/rules-check.log)。

JDK 17 的既有 hook 回歸套件與正式設定套件也全過：[hook-regression](evidence/review-fixes/hook-regression.log)、[hook-official](evidence/review-fixes/hook-official.log)。包含安裝器重入、staged 快照與新增行過濾。

## 剩餘限制

未推送，因此未執行 GitHub Actions；本次未重跑 JDK 11，未驗證 pre-commit 框架本體及大型專案效能。21 筆 CI 工具仍待 CI 層提供可重跑驗收；部分啟發式已依裁決降 warn＋partial，沒有宣稱完全消除語意誤報。L-4 與 L-7 為明確保留的限制，其餘指定修改與驗收已完成。

## 新 fixtures 清單

所有檔案位於 `tests/fixtures/synthetic/`，由 `run-synthetic.rb` 自動發現；bad 必須命中，good 必須不命中。warning 提醒樣本語意見該目錄 README。
- `CatchThrowableOrError/bad-error.java`
- `CatchThrowableOrError/bad-throwable.java`
- `CatchThrowableOrError/good-specific.java`
- `DateTimeFormatterPatternNotStrict/bad-smart.java`
- `DateTimeFormatterPatternNotStrict/good-qualified.java`
- `DateTimeFormatterPatternNotStrict/good-static.java`
- `DurationUsedForCalendarDay/bad-calendar.java`
- `DurationUsedForCalendarDay/good-timeout.java`
- `ForEachAccumulatesExternalState/bad-external.java`
- `ForEachAccumulatesExternalState/good-local.java`
- `ForEachAccumulatesExternalState/good-parameter.java`
- `JV-ER-008/bad-error.java`
- `JV-ER-008/bad-throwable.java`
- `JV-ER-008/good-specific.java`
- `JV-LS-003/bad-lambda.java`
- `JV-LS-003/good-local.java`
- `JV-LS-003/good-typed.java`
- `JV-ND-019/bad-days.java`
- `JV-ND-019/bad-hours.java`
- `JV-ND-019/good-minutes.java`
- `LambdaCatchWithoutRethrow/bad-swallow.java`
- `LambdaCatchWithoutRethrow/good-cancel.java`
- `LambdaCatchWithoutRethrow/good-interrupt.java`
- `LambdaCatchWithoutRethrow/good-shutdown.java`
- `LambdaCatchWithoutRethrow/good-throw.java`
- `LazyStreamReturnedFromTryWithResources/bad-lines.java`
- `LazyStreamReturnedFromTryWithResources/good-collect.java`
- `LazyStreamReturnedFromTryWithResources/good-tolist.java`
- `NarrowingPrimitiveCast/bad-byte.java`
- `NarrowingPrimitiveCast/bad-float.java`
- `NarrowingPrimitiveCast/bad-int.java`
- `NarrowingPrimitiveCast/good-char.java`
- `NarrowingPrimitiveCast/good-constants.java`
- `NarrowingPrimitiveCast/good-mask.java`
- `NoUnmanagedThread/bad-start.java`
- `NoUnmanagedThread/good-factory.java`
- `NoUnmanagedThread/good-shutdown.java`
- `NowWithoutClock/bad-empty.java`
- `NowWithoutClock/bad-timezone.java`
- `NowWithoutClock/bad-zone.java`
- `NowWithoutClock/good-clock.java`
- `ObjectValuedDataShape/bad-array.java`
- `ObjectValuedDataShape/bad-nested.java`
- `ObjectValuedDataShape/good-typed.java`
- `ParallelStreamUsage/bad-parallel.java`
- `ParallelStreamUsage/good-stream.java`
- `RawGenericType/bad-entry.java`
- `RawGenericType/bad-list.java`
- `RawGenericType/good-entry.java`
- `StreamVariableReused/bad-double.java`
- `StreamVariableReused/good-filter.java`
- `StreamVariableReused/good-null.java`
- `StreamVariableReused/good-scope.java`
- `UnboundedWildcardReturnType/bad-list.java`
- `UnboundedWildcardReturnType/good-class.java`
