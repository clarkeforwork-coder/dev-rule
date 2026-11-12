class Probe { void work(java.nio.file.Path path) throws java.io.IOException { try (var r = java.nio.file.Files.newBufferedReader(path)) { System.out.println(r.readLine()); } } }
