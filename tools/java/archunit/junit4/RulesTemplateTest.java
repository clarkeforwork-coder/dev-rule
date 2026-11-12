import com.tngtech.archunit.core.importer.ClassFileImporter;
import com.tngtech.archunit.core.importer.ImportOption;
import org.junit.Test;

/** 驗證已核准的專案架構邊界；與 RulesTemplate 使用相同測試套件。 */
public class RulesTemplateTest {
    /** 驗證正式程式的架構邊界。 */
    @Test
    public void architecture() {
        ClassFileImporter importer = new ClassFileImporter();
        RulesTemplate.ALL.check(importer
            .withImportOption(ImportOption.Predefined.DO_NOT_INCLUDE_TESTS)
            .importPackages("com.example"));
    }
}
