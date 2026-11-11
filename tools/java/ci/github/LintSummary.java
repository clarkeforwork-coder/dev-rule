import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.LinkedHashMap;
import java.util.Map;

/** 讀取本庫固定 rule-map 欄位，保留同一 javac 類別的全部錨點。 */
public final class LintSummary {
    public static void main(String[] args) throws Exception {
        String log = new String(Files.readAllBytes(Paths.get(args[0])), StandardCharsets.UTF_8);
        Map<String, String> row = new LinkedHashMap<String, String>();
        for (String line : Files.readAllLines(Paths.get(args[1]), StandardCharsets.UTF_8)) {
            if (line.startsWith("- id: ")) {
                emit(row, log); row.clear(); row.put("id", line.substring(6));
            } else if (line.matches("  (tool|check|title|rule): .*")) {
                int separator = line.indexOf(": ");
                String value = line.substring(separator + 2);
                if (value.startsWith("\"") || value.startsWith("'")) value = value.substring(1, value.length() - 1);
                row.put(line.substring(2, separator), value);
            }
        }
        emit(row, log);
    }
    private static void emit(Map<String, String> row, String log) {
        String check = row.get("check");
        if ("javac".equals(row.get("tool")) && check != null && check.startsWith("-Xlint:")) {
            String category = check.substring(7);
            if (log.contains("[" + category + "]")) {
                System.out.println("[" + row.get("id") + "] " + row.get("title") + " → " + row.get("rule") + " (javac " + category + ")");
            }
        }
    }
}
