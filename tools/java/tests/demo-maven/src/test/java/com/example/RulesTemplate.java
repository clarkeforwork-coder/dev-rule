package com.example;
import com.tngtech.archunit.core.importer.ClassFileImporter;
import com.tngtech.archunit.lang.ArchRule;
import com.tngtech.archunit.lang.CompositeArchRule;
import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.classes;
import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.noClasses;
import static com.tngtech.archunit.library.dependencies.SlicesRuleDefinition.slices;

/** 把 com.example 換成專案根套件；在 JUnit 測試執行已選定的規則。 */
public final class RulesTemplate {
    private static String reason(String id) {
        return "[" + id + "] 套件與架構邊界 → rules/stacks/java/common/naming-packages-docs.md#java-package-boundaries";
    }
    public static final ArchRule INTERNAL = classes().that().resideInAPackage("..internal..")
        .should().notBePublic().because(reason("JV-NP-023"));
    public static final ArchRule STORAGE = classes().that().haveSimpleNameEndingWith("Storage")
        .and().areNestedClasses().should().notBePublic().because(reason("JV-NP-024"));
    public static final ArchRule SHARED = noClasses().that().resideInAPackage("com.example.shared..")
        .should().dependOnClassesThat().resideInAnyPackage("com.example.order..", "com.example.business..")
        .because(reason("JV-NP-025"));
    public static final ArchRule LAYERS = noClasses().that().resideInAPackage("..domain..")
        .should().dependOnClassesThat().resideInAnyPackage("..application..", "..web..")
        .because(reason("JV-NP-023"));
    public static final ArchRule CORE = noClasses().that().resideInAPackage("..domain..")
        .should().dependOnClassesThat().resideInAnyPackage("..infrastructure..", "java.sql..", "javax.persistence..", "jakarta.persistence..")
        .because(reason("JV-NP-023"));
    public static final ArchRule CYCLES = slices().matching("com.example.(*)..")
        .should().beFreeOfCycles().because(reason("JV-NP-023"));
    public static final ArchRule ALL = CompositeArchRule.of(INTERNAL).and(STORAGE).and(SHARED)
        .and(LAYERS).and(CORE).and(CYCLES);
    /** 從指定的編譯產物執行架構檢查。
     * @param paths 編譯產物目錄
     */
    public static void main(String[] paths) {
        ClassFileImporter importer = new ClassFileImporter();
        ALL.check(importer.importPaths(paths));
    }
}
