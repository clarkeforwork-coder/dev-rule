import java.io.IOException;
import java.nio.channels.FileChannel;
import java.nio.channels.FileLock;
import java.nio.file.*;
import java.security.MessageDigest;
import java.util.*;
import javax.tools.ToolProvider;

/** 專案內 helper 快取；Java 8 即可計算 SHA-256，不新增系統雜湊工具依賴。 */
public final class HelperCache {
    private static String digest(byte[] bytes) throws Exception {
        StringBuilder result = new StringBuilder();
        for (byte value : MessageDigest.getInstance("SHA-256").digest(bytes))
            result.append(String.format(Locale.ROOT, "%02x", value & 255));
        return result.toString();
    }
    public static void main(String[] args) throws Exception {
        if (args.length == 2 && args[0].equals("--sha256")) {
            System.out.println(digest(Files.readAllBytes(Paths.get(args[1]))));
            return;
        }
        Path source = Paths.get(args[0]);
        Path cache = Paths.get(args[1]).toAbsolutePath();
        byte[] bytes = Files.readAllBytes(source);
        String digest = digest(bytes);
        String name = source.getFileName().toString().replaceFirst("\\.java$", "");
        String key = name + "-" + digest + "-" + System.getProperty("java.version");
        Path destination = cache.resolve(key);
        Files.createDirectories(cache);
        try (FileChannel channel = FileChannel.open(cache.resolve(key + ".lock"), StandardOpenOption.CREATE, StandardOpenOption.WRITE);
             FileLock lock = channel.lock()) {
            if (!Files.isRegularFile(destination.resolve(name + ".class"))) {
                Path work = Files.createTempDirectory(cache, ".compile-");
                try {
                    // 編譯相同的 bytes，避免雜湊後來源被修改而產生錯鍵。
                    Path snapshot = work.resolve(source.getFileName());
                    Files.write(snapshot, bytes);
                    System.err.println("dev-rule helper compile: " + name + " sha256=" + digest);
                    int code = ToolProvider.getSystemJavaCompiler().run(null, System.err, System.err,
                        "-encoding", "UTF-8", "-source", "8", "-target", "8", "-d", work.toString(), snapshot.toString());
                    if (code != 0) throw new IOException("helper 編譯失敗：" + source);
                    String trace = System.getenv("DEV_RULE_HELPER_TRACE");
                    if (trace != null && !trace.isEmpty()) Files.write(Paths.get(trace),
                        (name + " sha256=" + digest + "\n").getBytes(java.nio.charset.StandardCharsets.UTF_8),
                        StandardOpenOption.CREATE, StandardOpenOption.APPEND);
                    Files.delete(snapshot);
                    Files.move(work, destination, StandardCopyOption.ATOMIC_MOVE);
                } finally {
                    if (Files.exists(work)) {
                        try (java.util.stream.Stream<Path> paths = Files.walk(work)) {
                            for (Path path : (Iterable<Path>) paths.sorted(Comparator.reverseOrder())::iterator)
                                Files.delete(path);
                        }
                    }
                }
            }
        }
        System.out.println(destination);
    }
}
