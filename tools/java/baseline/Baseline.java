import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.security.MessageDigest;
import java.time.LocalDate;
import java.util.*;
import java.util.regex.*;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.*;

/** 無第三方依賴；以 Java 8 編譯與執行。 */
public final class Baseline {
    private static final String HEADER = "# dev-rule-baseline-v2\n# tool\trule\tfile\tsha256\tlevel\tcount\towner\tdue\tmessage\n";
    private static int suppressed;
    private static final Pattern ID = Pattern.compile("\\[(JV-[A-Z]+-[0-9]{3})\\]");
    private static final class Entry {
        String tool, rule, file, hash, level, owner, due, message;
        int count = 1, line;
        String key() { return tool + "\t" + rule + "\t" + file + "\t" + hash + "\t" + level; }
        String row() { return key() + "\t" + count + "\t" + owner + "\t" + due + "\t" + message; }
    }
    private static void require(boolean ok, String message) {
        if (!ok) throw new IllegalArgumentException(message);
    }
    private static String field(String value) {
        require(!value.contains("\t") && !value.contains("\n") && !value.contains("\r"), "欄位不得包含 Tab 或換行");
        return value;
    }
    private static String digest(String value) throws Exception {
        StringBuilder result = new StringBuilder();
        for (byte b : MessageDigest.getInstance("SHA-256").digest(value.getBytes(StandardCharsets.UTF_8)))
            result.append(String.format(Locale.ROOT, "%02x", b & 255));
        return result.toString();
    }
    private static Map<String, Entry> read(Path path) throws Exception {
        List<String> lines = Files.readAllLines(path, StandardCharsets.UTF_8);
        require(!lines.isEmpty() && lines.get(0).equals("# dev-rule-baseline-v2"), "不支援的基準版本");
        Map<String, Entry> result = new TreeMap<String, Entry>();
        for (String line : lines) {
            if (line.startsWith("#") || line.isEmpty()) continue;
            String[] f = line.split("\t", -1);
            require(f.length == 9, "基準欄位必須為 9 欄");
            Entry e = new Entry();
            e.tool=f[0]; e.rule=f[1]; e.file=f[2]; e.hash=f[3]; e.level=f[4];
            e.count=Integer.parseInt(f[5]); e.owner=f[6]; e.due=f[7]; e.message=f[8];
            require(e.tool.equals("pmd") || e.tool.equals("checkstyle"), "未知工具");
            require(e.rule.matches("JV-[A-Z]+-[0-9]{3}") && e.hash.matches("[0-9a-f]{64}"), "無效規則或指紋");
            require(!e.file.isEmpty() && !Paths.get(e.file).isAbsolute() && !e.file.contains("\\")
                && !Arrays.asList(e.file.split("/")).contains(".."), "無效相對檔名");
            require(e.level.equals("error") || e.level.equals("warn"), "無效等級");
            require(e.count > 0 && !e.owner.trim().isEmpty(), "必須有正數筆數與負責人");
            LocalDate.parse(e.due);
            require(result.put(e.key(), e) == null, "基準有重複鍵");
        }
        return result;
    }
    private static void write(Path path, Collection<Entry> entries, boolean create) throws Exception {
        StringBuilder data = new StringBuilder(HEADER);
        for (Entry e : entries) data.append(e.row()).append('\n');
        if (create) {
            Files.write(path, data.toString().getBytes(StandardCharsets.UTF_8), StandardOpenOption.CREATE_NEW);
        } else {
            Path tmp = Files.createTempFile(path.toAbsolutePath().getParent(), ".baseline-", ".tmp");
            try {
                Files.write(tmp, data.toString().getBytes(StandardCharsets.UTF_8));
                Files.move(tmp, path, StandardCopyOption.ATOMIC_MOVE, StandardCopyOption.REPLACE_EXISTING);
            } finally { Files.deleteIfExists(tmp); }
        }
    }
    private static List<Entry> report(String tool, Path report, Path root) throws Exception {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);
        factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
        factory.setFeature("http://xml.org/sax/features/external-general-entities", false);
        factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);
        factory.setXIncludeAware(false);
        factory.setExpandEntityReferences(false);
        Document document = factory.newDocumentBuilder().parse(report.toFile());
        Element top = document.getDocumentElement();
        require(top.getTagName().equals(tool), "報告根元素不符：" + report);
        List<Entry> result = new ArrayList<Entry>();
        NodeList files = top.getChildNodes();
        for (int i=0; i<files.getLength(); i++) {
            if (!(files.item(i) instanceof Element)) continue;
            Element file = (Element) files.item(i);
            if (tool.equals("pmd") && file.getTagName().equals("suppressedviolation")) { suppressed++; continue; }
            require(file.getTagName().equals("file"), "報告含工具錯誤或未知元素：" + file.getTagName());
            String name = file.getAttribute("name");
            require(!name.isEmpty(), "報告缺少檔名");
            Path source = root.resolve(name).toRealPath();
            require(source.startsWith(root), "來源不在專案根目錄：" + name);
            List<String> content;
            try { content = Files.readAllLines(source, StandardCharsets.UTF_8); }
            catch (IOException e) { throw new IOException("無法讀取 UTF-8 來源：" + source + "：" + e.getMessage(), e); }
            NodeList violations = file.getChildNodes();
            for (int j=0; j<violations.getLength(); j++) {
                if (!(violations.item(j) instanceof Element)) continue;
                Element v = (Element) violations.item(j);
                require(v.getTagName().equals(tool.equals("pmd") ? "violation" : "error"), "報告含未知診斷元素");
                Entry e = new Entry(); e.tool=tool;
                e.file=field(root.relativize(source).toString().replace('\\', '/'));
                e.line=Integer.parseInt(v.getAttribute(tool.equals("pmd") ? "beginline" : "line"));
                require(e.line>0 && e.line<=content.size(), "診斷行號不在來源內：" + name);
                e.message=field((tool.equals("pmd") ? v.getTextContent() : v.getAttribute("message")).trim().replaceAll("[\\r\\n\\t]+", " "));
                Matcher id = ID.matcher(e.message);
                require(id.find() && e.message.startsWith("[JV-") && e.message.contains("→ rules/"), "缺少規範 ID／錨點：" + e.message);
                e.rule=id.group(1);
                if (tool.equals("pmd")) {
                    int priority=Integer.parseInt(v.getAttribute("priority"));
                    require(priority>=1 && priority<=5, "無效 PMD priority");
                    e.level=priority<=2 ? "error" : "warn";
                } else {
                    String severity=v.getAttribute("severity");
                    require(severity.equals("error") || severity.equals("warning") || severity.equals("info"), "無效 Checkstyle severity");
                    e.level=severity.equals("error") ? "error" : "warn";
                }
                // 只修剪行首尾；保留字串常值與行內空白，避免改變語意後仍命中。
                int before=e.line-2, after=e.line;
                while (before>=0 && content.get(before).trim().isEmpty()) before--;
                while (after<content.size() && content.get(after).trim().isEmpty()) after++;
                e.hash=digest((before>=0 ? content.get(before).trim() : "") + "\n"
                    + content.get(e.line-1).trim() + "\n" + (after<content.size() ? content.get(after).trim() : ""));
                result.add(e);
            }
        }
        return result;
    }
    public static void main(String[] args) {
        try { System.exit(run(args)); }
        catch (Exception e) { System.err.println("基準工具錯誤：" + e.getMessage()); System.exit(2); }
    }
    private static int run(String[] args) throws Exception {
        require(args.length>0 && Arrays.asList("create", "check", "prune").contains(args[0]), "用法：create|check|prune --baseline 檔 --pmd 報告／--checkstyle 報告 [--root 專案根] [--owner 負責人 --due YYYY-MM-DD]");
        Map<String,String> options = new HashMap<String,String>();
        List<String[]> reports = new ArrayList<String[]>();
        boolean allowStale=false;
        for (int i=1; i<args.length; i+=2) {
            if (args[i].equals("--allow-stale")) { require(args[0].equals("check") && !allowStale, "--allow-stale 僅適用 check 且不可重複"); allowStale=true; i--; continue; }
            require(i+1<args.length, "選項缺少值");
            String flag=args[i];
            require(Arrays.asList("--baseline","--root","--owner","--due","--pmd","--checkstyle").contains(flag), "未知選項：" + flag);
            if (flag.equals("--pmd") || flag.equals("--checkstyle")) reports.add(new String[]{flag.substring(2), args[i+1]});
            else require(options.put(flag,args[i+1])==null, "重複選項：" + flag);
        }
        require(options.containsKey("--baseline") && !reports.isEmpty(), "必須指定基準檔與至少一份報告");
        Path root=Paths.get(options.containsKey("--root") ? options.get("--root") : ".").toRealPath();
        Path baseline=Paths.get(options.get("--baseline"));
        boolean create=args[0].equals("create");
        String owner=field(options.containsKey("--owner") ? options.get("--owner") : "");
        String due=field(options.containsKey("--due") ? options.get("--due") : "");
        if (create) { require(!owner.trim().isEmpty(), "create 必須指定 --owner"); LocalDate.parse(due); }
        else require(owner.isEmpty() && due.isEmpty(), "--owner／--due 僅適用 create");
        Map<String,Entry> old=create ? new TreeMap<String,Entry>() : read(baseline);
        List<Entry> current=new ArrayList<Entry>();
        Set<Path> seen=new HashSet<Path>();
        Set<String> covered=new HashSet<String>();
        for (String[] r : reports) {
            Path path=Paths.get(r[1]).toRealPath();
            require(seen.add(path), "重複報告：" + path);
            covered.add(r[0]); current.addAll(report(r[0], path, root));
        }
        System.out.println("略過 PMD 已抑制診斷：" + suppressed + " 筆");
        for (Entry e : old.values()) require(covered.contains(e.tool), "未提供基準中工具的完整報告：" + e.tool);
        Map<String,Entry> now=new TreeMap<String,Entry>();
        int errors=0, warnings=0, resolved=0;
        for (Entry e : current) {
            Entry aggregate=now.get(e.key());
            if (aggregate==null) { e.owner=owner; e.due=due; now.put(e.key(),e); aggregate=e; }
            else aggregate.count++;
            Entry previous=old.get(e.key());
            if (!create && (previous==null || aggregate.count>previous.count)) {
                System.out.println(e.file + ":" + e.line + " " + e.message + (e.level.equals("warn") ? " (warn)" : ""));
                if (e.level.equals("error")) errors++; else warnings++;
            }
        }
        Map<String,Entry> retained=new TreeMap<String,Entry>();
        for (Entry e : old.values()) {
            Entry n=now.get(e.key()); int remaining=n==null ? 0 : Math.min(e.count,n.count);
            resolved+=e.count-remaining;
            if (e.count>remaining) System.out.println("已清償：" + e.file + " " + e.rule + " " + e.hash + " × " + (e.count-remaining));
            if (args[0].equals("check") && LocalDate.parse(e.due).isBefore(LocalDate.now()))
                System.out.println("基準已逾期：" + e.file + " " + e.rule + " owner=" + e.owner + " due=" + e.due);
            if (remaining>0) { e.count=remaining; retained.put(e.key(),e); }
        }
        if (create) { write(baseline,now.values(),true); System.out.println("已建立基準：" + current.size() + " 筆"); }
        else {
            // prune 永不吸收新違規，且有新 error 時不修改基準。
            if (args[0].equals("prune") && errors==0) write(baseline,retained.values(),false);
            System.out.println("新增 error：" + errors + "；新增 warn：" + warnings + "；已清償：" + resolved + " 筆");
        }
        return errors>0 || (args[0].equals("check") && resolved>0 && !allowStale) ? 1 : 0;
    }
}
