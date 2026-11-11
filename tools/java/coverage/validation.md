# 自檢紀錄

本階段驗證映射與報告，未重新執行 Java 工具；status 的實證來源見整併紀錄。

```text
通過：15 份文件、143 個 Java 小節。
通過：307 筆映射的錨點存在、標題相符、ID 唯一、欄位合法。
通過：全部 Java 小節至少一筆映射；沒有重複的小節 × 工具規則。
通過：自訂名稱與 XPath 欄位合法，同名 XPath 一致。
涵蓋率：53／143 = 37.06%。
通過：coverage.md 與 rule-map.yml 一致。
通過：41 筆 PMD 自訂映射的 XPath 與來源字串逐字相同（40 個名稱）。
通過：重複 ID → exit 1，ID 重複
通過：不存在錨點 → exit 1，JV-TG-001 錨點不屬於 Java 小節：rules/stacks/java/common/types-and-generics.md#java-explicit-types-missing
通過：缺少整個小節 → exit 1，缺少小節 rules/stacks/java/common/types-and-generics.md#java-explicit-types
通過：非法 status → exit 1，JV-TG-001 status 值錯誤
通過：過期報告 → exit 1，coverage.md 已過期；請重新產生
通過：由其他工作目錄以絕對路徑執行 --check。
```

所有負向檢查均在 tools/java/coverage 下的臨時副本執行，完成後移除，未更動正式映射或規範。

## 涵蓋率總表

| 項目 | 數量 |
| --- | --- |
| 文件數 | 15 |
| 小節數 | 143 |
| 映射筆數 | 307 |
| status：verified（筆） | 87 |
| status：partial（筆） | 39 |
| status：candidate（筆） | 41 |
| status：manual（筆） | 140 |
| tier：pre-commit（筆） | 110 |
| tier：ci-compile（筆） | 28 |
| tier：ci-bytecode（筆） | 16 |
| tier：ci-arch（筆） | 3 |
| tier：ci-build（筆） | 10 |
| tier：test（筆） | 0 |
| tier：manual（筆） | 140 |
| tool：pmd（筆） | 75 |
| tool：checkstyle（筆） | 35 |
| tool：javac（筆） | 12 |
| tool：errorprone（筆） | 16 |
| tool：spotbugs（筆） | 16 |
| tool：archunit（筆） | 3 |
| tool：jdeps（筆） | 3 |
| tool：jdeprscan（筆） | 1 |
| tool：maven-enforcer（筆） | 4 |
| tool：gradle（筆） | 2 |
| tool：none（筆） | 140 |
| verified 小節數 | 53 |
| 涵蓋率（verified 小節／全部小節） | 53／143 = 37.06% |
