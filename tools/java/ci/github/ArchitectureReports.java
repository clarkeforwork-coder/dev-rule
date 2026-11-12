import java.io.File;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Element;

/** 驗證首次建置確實執行架構測試，不觸發第二次建置。 */
public final class ArchitectureReports {
    public static void main(String[] args) throws Exception {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
        factory.setFeature("http://xml.org/sax/features/external-general-entities", false);
        factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);
        factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");
        factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_SCHEMA, "");
        int executed = 0;
        for (String path : args) {
            File file = new File(path);
            if (!file.isFile()) { continue; }
            Element suite = factory.newDocumentBuilder().parse(file).getDocumentElement();
            if (!"testsuite".equals(suite.getTagName())) {
                throw new IllegalArgumentException("無效 JUnit testsuite：" + path);
            }
            int tests = Integer.parseInt(suite.getAttribute("tests"));
            int skipped = suite.hasAttribute("skipped") ? Integer.parseInt(suite.getAttribute("skipped")) : 0;
            if (tests <= 0 || skipped < 0 || skipped >= tests) {
                throw new IllegalArgumentException("架構測試未執行或全部略過：" + path);
            }
            executed += tests - skipped;
        }
        if (executed == 0) {
            throw new IllegalArgumentException("缺少已執行的 RulesTemplateTest JUnit XML（須 tests > 0 且 skipped < tests）");
        }
        System.out.println("架構測試已執行：" + executed);
    }
}
