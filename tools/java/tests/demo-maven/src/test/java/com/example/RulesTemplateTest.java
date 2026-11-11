package com.example;

import com.tngtech.archunit.core.importer.ClassFileImporter;
import com.tngtech.archunit.core.importer.ImportOption;
import org.junit.Test;

/** 驗證示範專案實際具備的內部套件邊界。 */
public final class RulesTemplateTest {
    /** 僅執行此專案存在的 internal 規則，不放寬空匹配。 */
    @Test
    public void architecture() {
        ClassFileImporter importer = new ClassFileImporter();
        RulesTemplate.INTERNAL.check(importer.withImportOption(ImportOption.Predefined.DO_NOT_INCLUDE_TESTS)
            .importPackages("com.example.internal"));
    }
}
