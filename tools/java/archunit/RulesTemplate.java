import com.tngtech.archunit.core.domain.JavaClasses;
import com.tngtech.archunit.core.importer.ClassFileImporter;
import com.tngtech.archunit.lang.ArchRule;
import static com.tngtech.archunit.lang.syntax.ArchRuleDefinition.*;
import static com.tngtech.archunit.library.dependencies.SlicesRuleDefinition.slices;

/** 把 com.example 換成專案根套件；在 JUnit 測試呼叫 check(classes)。 */
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
    public static void check(JavaClasses classes) {
        for (ArchRule rule : new ArchRule[]{INTERNAL, STORAGE, SHARED, LAYERS, CORE, CYCLES}) rule.check(classes);
    }
    public static void main(String[] paths) {
        check(new ClassFileImporter().importPaths(paths));
    }
}
