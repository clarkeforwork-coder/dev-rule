# 專案架構測試範本

固定使用 ArchUnit 1.4.1（JDK 8／11／17／21 bytecode）；下載 URL 與 SHA-256 在四個 `profiles/jdk*.env` 的 `ARCHUNIT_*`。純 ArchUnit 核心 JAR 需 slf4j-api 2.0.17；測試腳本校驗兩者雜湊。專案透過 Maven／Gradle 依賴解析時須保留自身 dependency verification／鎖檔策略。

把 `RulesTemplate.java` 放進 `src/test/java`，加上專案測試套件宣告，將 `com.example`、`order`、`business`、`shared`、`domain`、`application`、`web`、`infrastructure` 換成核准架構。分層方向為外層可依賴 domain，domain 不得反向依賴 application／web 或技術實作；共用套件不可依賴業務；頂層模組禁止循環。Storage／internal 規則檢查實際可見性。所有規則 `because` 保留 ID 與錨點。

範本是專案設定起點，不假設所有專案都採相同分層。規則預設拒絕空匹配：專案沒有某種層次時須經審查移除該條，而非全面 `allowEmptyShould(true)`。選定完整業務根套件並排除測試類別，避免把缺漏 import 當通過。

加入 test scope `com.tngtech.archunit:archunit:1.4.1` 與 JUnit 4.13.2，建立 `RulesTemplateTest.java`：

```java
import org.junit.Test;
import com.tngtech.archunit.core.importer.ClassFileImporter;
import com.tngtech.archunit.core.importer.ImportOption;
public class RulesTemplateTest {
    @Test public void architecture() {
        RulesTemplate.check(new ClassFileImporter()
            .withImportOption(ImportOption.Predefined.DO_NOT_INCLUDE_TESTS)
            .importPackages("com.example"));
    }
}
```

執行 `mvn test -Dtest=RulesTemplateTest` 或 `./gradlew test --tests '*RulesTemplateTest'`。本庫測試直接執行同一範本，不依賴 JUnit runner；另從正式規範抽取 OrderService／OrderStorage 正反例驗證 JV-NP-024。其餘架構規則使用合成套件，不提升為完整規範 verified。ArchUnit 只檢查 bytecode 可見依賴，反射、設定字串與執行期注入仍需人工審查。

來源：[ArchUnit 使用手冊](https://www.archunit.org/userguide/html/000_Index.html)、[Maven Central 1.4.1](https://repo.maven.apache.org/maven2/com/tngtech/archunit/archunit/1.4.1/)。
