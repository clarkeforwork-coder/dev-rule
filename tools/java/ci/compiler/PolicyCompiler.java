import java.io.*;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.regex.*;
import java.security.MessageDigest;
import java.util.*;

/** 以建置系統的原始 classpath 編譯；消費端不依賴 Ruby／Python。 */
public final class PolicyCompiler {
    private static Path base;
    private static final Map<String, String> profile = new HashMap<String, String>();
    public static void main(String[] args) throws Exception {
        base = Paths.get(args[0]);
        String version = System.getProperty("java.specification.version").replace("1.", "");
        for (String line : Files.readAllLines(base.resolve("profiles/jdk" + version + ".env"), StandardCharsets.UTF_8)) {
            if (line.matches("[A-Z0-9_]+='.*'")) {
                int at = line.indexOf('=');
                profile.put(line.substring(0, at), line.substring(at + 2, line.length() - 1));
            }
        }
        List<String> original = new ArrayList<String>();
        for (int i = 1; i < args.length; i++) expand(args[i], original);
        List<String> command = new ArrayList<String>();
        command.add(Paths.get(System.getenv("JAVA_HOME"), "bin", "javac").toString());
        if (version.equals("8")) command.add("-J-Xbootclasspath/p:" + artifact("ERRORPRONE_JAVAC"));
        else {
            for (String part : "api file main model parser processing tree util code comp".split(" "))
                command.add("-J--add-exports=jdk.compiler/com.sun.tools.javac." + part + "=ALL-UNNAMED");
            for (String part : new String[]{"code", "comp"})
                command.add("-J--add-opens=jdk.compiler/com.sun.tools.javac." + part + "=ALL-UNNAMED");
        }
        String processor = artifact("ERRORPRONE").toString();
        boolean explicitProcessor = false;
        String classpath = null;
        Path destination = null;
        for (int i = 0; i < original.size(); i++) {
            String arg = original.get(i);
            if (arg.equals("-processorpath") || arg.equals("--processor-path")) { explicitProcessor = true; processor += File.pathSeparator + original.get(++i); }
            else if (arg.startsWith("--processor-path=")) { explicitProcessor = true; processor += File.pathSeparator + arg.substring(17); }
            else {
                command.add(arg);
                if (arg.equals("-classpath") || arg.equals("-cp") || arg.equals("--class-path")) classpath = original.get(i + 1);
                if (arg.startsWith("--class-path=")) classpath = arg.substring(13);
                if (arg.equals("-d")) destination = Paths.get(original.get(i + 1));
            }
        }
        if (!explicitProcessor && classpath != null) processor += File.pathSeparator + classpath;
        command.addAll(Arrays.asList("-Xmaxwarns", "2147483647", "-Xmaxerrs", "2147483647"));
        command.add("-processorpath"); command.add(processor);
        command.add("-XDcompilePolicy=simple");
        if (Integer.parseInt(version) >= 17) {
            command.add("--should-stop=ifError=FLOW"); command.add("-XDaddTypeAnnotationsToSymbol=true");
        }
        command.addAll(flags("javac/lint-jdk" + version + ".txt"));
        command.add("-Xplugin:ErrorProne " + String.join(" ", flags("errorprone/flags-jdk" + version + ".txt")));
        // -J 選項由 launcher 處理，不能放在 javac argfile；其餘參數全部寫檔。
        List<String> launch = new ArrayList<String>();
        launch.add(command.get(0));
        List<String> arguments = new ArrayList<String>();
        for (String argument : command.subList(1, command.size())) {
            if (argument.startsWith("-J")) launch.add(argument);
            else arguments.add("\"" + argument.replace("\\", "\\\\").replace("\"", "\\\"")
                .replace("\n", "\\n").replace("\r", "\\r") + "\"");
        }
        Path argfile = Files.createTempFile("dev-rule-javac-", ".args");
        argfile.toFile().deleteOnExit();
        Files.write(argfile, arguments, StandardCharsets.UTF_8);
        launch.add("@" + argfile);
        Process process = new ProcessBuilder(launch).redirectErrorStream(true).start();
        StringBuilder log = new StringBuilder();
        BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream(), StandardCharsets.UTF_8));
        String line;
        while ((line = reader.readLine()) != null) { log.append(line).append('\n'); }
        int code = process.waitFor();
        Files.deleteIfExists(argfile);
        Map<String, List<Map<String, String>>> checks = new HashMap<String, List<Map<String, String>>>();
        Map<String, String> row = new HashMap<String, String>();
        for (String item : Files.readAllLines(base.resolve("rule-map.yml"), StandardCharsets.UTF_8)) {
            if (item.startsWith("- id: ")) {
                index(checks, row); row = new HashMap<String, String>(); row.put("id", item.substring(6));
            } else if (item.matches("  (tool|check|title|rule|level|status): .*")) {
                int at = item.indexOf(": "); String value = item.substring(at + 2);
                if (value.startsWith("\"") || value.startsWith("'")) value = value.substring(1, value.length() - 1);
                row.put(item.substring(2, at), value);
            }
        }
        index(checks, row);
        boolean violation = false;
        Pattern token = Pattern.compile("\\[([^\\]]+)\\]");
        for (String diagnostic : log.toString().split("\n")) {
            StringBuilder annotated = new StringBuilder(diagnostic);
            Set<Map<String, String>> matched = new LinkedHashSet<Map<String, String>>();
            Matcher matcher = token.matcher(diagnostic);
            while (matcher.find()) {
                List<Map<String, String>> mappings = checks.get(matcher.group(1));
                if (mappings != null) matched.addAll(mappings);
            }
            for (Map<String, String> mapping : matched) {
                annotated.append(" [").append(mapping.get("id")).append("] ").append(mapping.get("title"))
                    .append(" → ").append(mapping.get("rule"));
                violation |= "error".equals(mapping.get("level"));
            }
            System.out.println(annotated);
        }
        // 政策失敗時移除輸出目錄內所有 class，保留資源及目錄；避免 Maven 誤判為最新。
        // 不追蹤符號連結，也不刪除 -d 以外的檔案。
        if (violation && destination != null && Files.isDirectory(destination)) {
            Files.walkFileTree(destination, new SimpleFileVisitor<Path>() {
                @Override public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
                    if (file.toString().endsWith(".class") && attrs.isRegularFile()) Files.delete(file);
                    return FileVisitResult.CONTINUE;
                }
            });
        }
        System.exit(code != 0 ? code : violation ? 1 : 0);
    }
    private static void index(Map<String, List<Map<String, String>>> checks, Map<String, String> row) {
        String check = row.get("check");
        if (check == null || "candidate".equals(row.get("status"))) return;
        String[] names;
        if ("javac".equals(row.get("tool")) && check.startsWith("-Xlint:")) names = check.substring(7).split("[ ,]+");
        else if ("errorprone".equals(row.get("tool"))) names = new String[]{check};
        else return;
        for (String name : names) {
            if (!checks.containsKey(name)) checks.put(name, new ArrayList<Map<String, String>>());
            checks.get(name).add(row);
        }
    }
    private static List<String> flags(String file) throws IOException {
        List<String> result = new ArrayList<String>();
        for (String line : Files.readAllLines(base.resolve(file), StandardCharsets.UTF_8)) {
            String value = line.trim();
            if (!value.isEmpty() && !value.startsWith("#")) result.add(value);
        }
        return result;
    }
    private static Path artifact(String name) throws Exception {
        Path cache = Paths.get(System.getProperty("user.home"), ".cache", "dev-rule", "ci");
        Files.createDirectories(cache);
        Path file = cache.resolve(profile.get(name + "_SHA256") + ".jar");
        if (!Files.exists(file)) {
            Path temporary = Files.createTempFile(cache, "download-", ".jar");
            try {
                try (InputStream source = new URL(profile.get(name + "_URL")).openStream()) {
                    Files.copy(source, temporary, StandardCopyOption.REPLACE_EXISTING);
                }
                verify(temporary, profile.get(name + "_SHA256"));
                Files.move(temporary, file, StandardCopyOption.REPLACE_EXISTING);
            } finally { Files.deleteIfExists(temporary); }
        }
        verify(file, profile.get(name + "_SHA256")); return file;
    }
    private static void verify(Path file, String expected) throws Exception {
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        try (InputStream input = Files.newInputStream(file)) {
            byte[] buffer = new byte[8192]; int count;
            while ((count = input.read(buffer)) != -1) digest.update(buffer, 0, count);
        }
        StringBuilder actual = new StringBuilder();
        for (byte value : digest.digest()) actual.append(String.format("%02x", value & 255));
        if (!actual.toString().equals(expected)) throw new IOException("SHA-256 不符：" + file);
    }
    private static void expand(String argument, List<String> output) throws IOException {
        if (!argument.startsWith("@")) { output.add(argument); return; }
        try (Reader input = Files.newBufferedReader(Paths.get(argument.substring(1)), StandardCharsets.UTF_8)) {
            StreamTokenizer tokens = new StreamTokenizer(input);
            tokens.resetSyntax(); tokens.wordChars(33, 65535); tokens.whitespaceChars(0, 32);
            tokens.quoteChar('"'); tokens.quoteChar('\''); tokens.commentChar('#');
            while (tokens.nextToken() != StreamTokenizer.TT_EOF) output.add(tokens.sval);
        }
    }
}
