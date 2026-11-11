# Checkstyle 驗證紀錄

日期：2026-11-11。環境：macOS arm64，Eclipse Temurin 17.0.19；無 JDK 8，以 JDK 17 執行 9.3。

指令：`CHECKSTYLE_CACHE=<TMP>/dev-rule-checkstyle ruby tools/java/tests/run-checkstyle.rb`。退出碼：1，屬驗收未全通過；不將規範映射缺口視為成功。原始來源與 SHA-256 列於輸出及 versions.json。

正式設定 21 個檢查實例、候選設定 14 個，共 35 個／28 種模組；兩版均能載入兩份配置。候選僅用空類別驗證載入，不計入正反例覆蓋率。

## 完整輸出

```text
Checkstyle 10.26.1；openjdk version "17.0.19" 2026-04-21
來源：https://github.com/checkstyle/checkstyle/releases/download/checkstyle-10.26.1/checkstyle-10.26.1-all.jar
SHA-256：e41c24433723ba310a30e41da4f449c105ad47cab2ae9e6be5e06606a647dbca
正式與候選設定載入：通過
通過 JV-TG-001 RegexpSinglelineJava 違反：命中 1
通過 JV-TG-001 RegexpSinglelineJava 符合：命中 0
通過 JV-TG-001 RegexpSinglelineJava 符合（Java 8）：命中 0
通過 JV-TG-011 SuppressWarnings 違反：命中 2
通過 JV-TG-011 SuppressWarnings 符合：命中 0
通過 JV-TG-020 IllegalType 違反：命中 1
通過 JV-TG-020 IllegalType 符合：命中 0
通過 JV-TG-020 IllegalType 符合（Java 21）：命中 0
通過 JV-TG-029 InterfaceTypeParameterName 違反：命中 3
通過 JV-TG-029 InterfaceTypeParameterName 符合：命中 0
通過 JV-LS-001 LambdaBodyLength 違反：命中 1
通過 JV-LS-001 LambdaBodyLength 符合：命中 0
通過 JV-LS-001 LambdaBodyLength 符合（Java 8）：命中 0
通過 JV-NP-002 ConstantName 違反：命中 1
通過 JV-NP-002 ConstantName 符合：命中 0
通過 JV-NP-007 MethodName 違反：命中 1
通過 JV-NP-007 MethodName 符合：命中 0
通過 JV-NP-013 TypeName 違反：命中 1
通過 JV-NP-013 TypeName 符合：命中 0
通過 JV-NP-030 JavadocMethod 違反：命中 3
通過 JV-NP-030 JavadocMethod 符合：命中 0
通過 JV-NP-030 JavadocMethod 符合（Java 8）：命中 0
通過 JV-NP-030 JavadocMethod 符合（Java 21）：命中 0
通過 JV-ER-001 IllegalThrows 違反：命中 1
通過 JV-ER-001 IllegalThrows 符合：命中 0
通過 JV-ER-001 IllegalThrows 符合（Java 8）：命中 0
失敗 JV-ER-008 IllegalCatch 違反：命中 0
通過 JV-ER-008 IllegalCatch 符合：命中 0
通過 JV-ER-008 IllegalCatch 符合（Java 8）：命中 0
通過 JV-ER-013 RegexpMultiline 違反：命中 1
通過 JV-ER-013 RegexpMultiline 符合：命中 0
通過 JV-EH-010 EqualsHashCode 違反：命中 1
通過 JV-EH-010 EqualsHashCode 符合：命中 0
通過 JV-EH-010 EqualsHashCode 符合（Java 8）：命中 0
通過 JV-EH-010 EqualsHashCode 符合（Java 17）：命中 0
通過 JV-ND-002 RegexpSinglelineJava 違反：命中 1
通過 JV-ND-002 RegexpSinglelineJava 符合：命中 0
通過 JV-ND-019 RegexpSinglelineJava 違反：命中 1
通過 JV-ND-019 RegexpSinglelineJava 符合：命中 0
通過 JV-ND-022 RegexpSinglelineJava 違反：命中 1
通過 JV-ND-022 RegexpSinglelineJava 符合：命中 0
通過 JV-ND-022 RegexpSinglelineJava 符合（Java 17）：命中 0
通過 JV-ND-026 RegexpSinglelineJava 違反：命中 1
通過 JV-ND-026 RegexpSinglelineJava 符合：命中 0
總結 10.26.1：17 筆 verified，44 個範例；16 筆通過，1 筆失敗。
不符映射：JV-ER-008
Checkstyle 9.3；openjdk version "17.0.19" 2026-04-21
本機沒有 JDK 8；9.3 改用 JDK 17，未驗證 JDK 8 執行期。
來源：https://github.com/checkstyle/checkstyle/releases/download/checkstyle-9.3/checkstyle-9.3-all.jar
SHA-256：02ad3307e46059a7c4f8af6c5f61f477bc5fd910e56afb145c45904c95d213ac
正式與候選設定載入：通過
通過 JV-TG-001 RegexpSinglelineJava 違反：命中 1
通過 JV-TG-001 RegexpSinglelineJava 符合：命中 0
通過 JV-TG-001 RegexpSinglelineJava 符合（Java 8）：命中 0
通過 JV-TG-011 SuppressWarnings 違反：命中 2
通過 JV-TG-011 SuppressWarnings 符合：命中 0
通過 JV-TG-020 IllegalType 違反：命中 1
通過 JV-TG-020 IllegalType 符合：命中 0
通過 JV-TG-020 IllegalType 符合（Java 21）：命中 0
通過 JV-TG-029 InterfaceTypeParameterName 違反：命中 3
通過 JV-TG-029 InterfaceTypeParameterName 符合：命中 0
通過 JV-LS-001 LambdaBodyLength 違反：命中 1
通過 JV-LS-001 LambdaBodyLength 符合：命中 0
通過 JV-LS-001 LambdaBodyLength 符合（Java 8）：命中 0
通過 JV-NP-002 ConstantName 違反：命中 1
通過 JV-NP-002 ConstantName 符合：命中 0
通過 JV-NP-007 MethodName 違反：命中 1
通過 JV-NP-007 MethodName 符合：命中 0
通過 JV-NP-013 TypeName 違反：命中 1
通過 JV-NP-013 TypeName 符合：命中 0
通過 JV-NP-030 JavadocMethod 違反：命中 3
通過 JV-NP-030 JavadocMethod 符合：命中 0
通過 JV-NP-030 JavadocMethod 符合（Java 8）：命中 0
通過 JV-NP-030 JavadocMethod 符合（Java 21）：命中 0
通過 JV-ER-001 IllegalThrows 違反：命中 1
通過 JV-ER-001 IllegalThrows 符合：命中 0
通過 JV-ER-001 IllegalThrows 符合（Java 8）：命中 0
失敗 JV-ER-008 IllegalCatch 違反：命中 0
通過 JV-ER-008 IllegalCatch 符合：命中 0
通過 JV-ER-008 IllegalCatch 符合（Java 8）：命中 0
通過 JV-ER-013 RegexpMultiline 違反：命中 1
通過 JV-ER-013 RegexpMultiline 符合：命中 0
通過 JV-EH-010 EqualsHashCode 違反：命中 1
通過 JV-EH-010 EqualsHashCode 符合：命中 0
通過 JV-EH-010 EqualsHashCode 符合（Java 8）：命中 0
通過 JV-EH-010 EqualsHashCode 符合（Java 17）：命中 0
通過 JV-ND-002 RegexpSinglelineJava 違反：命中 1
通過 JV-ND-002 RegexpSinglelineJava 符合：命中 0
通過 JV-ND-019 RegexpSinglelineJava 違反：命中 1
通過 JV-ND-019 RegexpSinglelineJava 符合：命中 0
通過 JV-ND-022 RegexpSinglelineJava 違反：命中 1
通過 JV-ND-022 RegexpSinglelineJava 符合：命中 0
通過 JV-ND-022 RegexpSinglelineJava 符合（Java 17）：命中 0
通過 JV-ND-026 RegexpSinglelineJava 違反：命中 1
通過 JV-ND-026 RegexpSinglelineJava 符合：命中 0
總結 9.3：17 筆 verified，44 個範例；16 筆通過，1 筆失敗。
不符映射：JV-ER-008
```

## 待處理

JV-ER-008 的 error 子句不匹配 Exception 原違反範例，詳 README；需整併者決定拆分映射及重新驗證，未修改 rule-map。JDK 8 執行期相容性仍須在有該環境時補驗。未核准任何專案例外，預設抑制清單維持空白。
