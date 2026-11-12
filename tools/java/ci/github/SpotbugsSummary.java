import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Properties;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.NodeList;
import org.w3c.dom.Element;

/** 只解析本機報告；拒絕 XML 外部實體與未知 pattern。 */
public final class SpotbugsSummary {
    public static void main(String[] args) throws Exception {
        Properties mapping = new Properties();
        try (java.io.Reader reader = Files.newBufferedReader(Paths.get(args[1]), java.nio.charset.StandardCharsets.UTF_8)) {
            mapping.load(reader);
        }
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
        factory.setFeature("http://xml.org/sax/features/external-general-entities", false);
        factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);
        org.w3c.dom.Document document = factory.newDocumentBuilder().parse(Paths.get(args[0]).toFile());
        if (!"BugCollection".equals(document.getDocumentElement().getTagName())) throw new IllegalArgumentException("非 SpotBugs 報告");
        NodeList bugs = document.getElementsByTagName("BugInstance");
        boolean errors = false;
        for (int i = 0; i < bugs.getLength(); i++) {
            Element bug = (Element) bugs.item(i);
            String pattern = bug.getAttribute("type");
            String diagnostic = mapping.getProperty(pattern);
            if (diagnostic == null || !diagnostic.contains("[JV-") || !diagnostic.contains(" → rules/")) throw new IllegalArgumentException("未映射 SpotBugs pattern: " + pattern);
            String level = mapping.getProperty(pattern + ".level");
            if (!"error".equals(level) && !"warn".equals(level)) throw new IllegalArgumentException("缺少 SpotBugs 等級：" + pattern);
            errors |= "error".equals(level);
            System.out.println(diagnostic + " (" + pattern + ", " + level + ")");
        }
        if (document.getElementsByTagName("Error").getLength() > 0 || document.getElementsByTagName("MissingClass").getLength() > 0) {
            throw new IllegalStateException("SpotBugs 分析不完整");
        }
        if (errors) System.exit(1);
    }
}
