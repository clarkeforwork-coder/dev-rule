import java.io.*;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
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
        for (int i = 0; i < original.size(); i++) {
            String arg = original.get(i);
            if (arg.equals("-processorpath") || arg.equals("--processor-path")) processor += File.pathSeparator + original.get(++i);
            else command.add(arg);
        }
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
        Map<String, String> row = new HashMap<String, String>();
        boolean violation = false;
        for (String item : Files.readAllLines(base.resolve("rule-map.yml"), StandardCharsets.UTF_8)) {
            if (item.startsWith("- id: ")) {
                violation |= emit(row, log); row.clear(); row.put("id", item.substring(6));
            } else if (item.matches("  (tool|check|title|rule|level|status): .*")) {
                int at = item.indexOf(": "); String value = item.substring(at + 2);
                if (value.startsWith("\"") || value.startsWith("'")) value = value.substring(1, value.length() - 1);
                row.put(item.substring(2, at), value);
            }
        }
        violation |= emit(row, log);
        System.out.print(log.toString());
        System.exit(code != 0 ? code : violation ? 1 : 0);
    }
    private static boolean emit(Map<String, String> row, StringBuilder output) {
        String log = output.toString();
        String check = row.get("check"); boolean hit = false;
        if (check != null && "javac".equals(row.get("tool")) && check.startsWith("-Xlint:")) {
            for (String category : check.substring(7).split("[ ,]")) hit |= log.contains("[" + category + "]");
        }
        if ("errorprone".equals(row.get("tool"))) hit = log.contains("[" + check + "]");
        if (!hit || "candidate".equals(row.get("status"))) return false;
        String diagnostic = "[" + row.get("id") + "] " + row.get("title") + " → " + row.get("rule");
        // Maven 的 fork parser 會捨棄無位置的自由文字；附在原診斷位置後保留映射。
        output.setLength(0);
        for (String line : log.split("\n")) {
            boolean matching = "errorprone".equals(row.get("tool")) && line.contains("[" + check + "]");
            if ("javac".equals(row.get("tool")))
                for (String category : check.substring(7).split("[ ,]")) matching |= line.contains("[" + category + "]");
            output.append(line);
            if (matching) output.append(" ").append(diagnostic);
            output.append('\n');
        }
        return "error".equals(row.get("level"));
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
