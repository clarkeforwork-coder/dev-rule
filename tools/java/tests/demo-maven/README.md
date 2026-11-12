# Maven 可重用 workflow 示範

三個類別，Javadoc 齊全；pom 為正式片段，僅將 dev-rule.root 改為儲存庫相對位置。RulesTemplate 與正式範本同步，只選本專案存在的 INTERNAL 規則，其他層次不以空匹配通過。

在本目錄以 JDK 17 與 Maven 3.9.9 執行 `mvn -Pdev-rule-baseline clean verify`。空的 v2 基準代表零既有違規；正式 rules-check workflow 的 java-demo job 呼叫 java-rules workflow。修改片段／範本時須同步本示範，完整輸出及 artifact 在 GitHub job 檢視。
