import java.io.*; import java.util.stream.*; class Probe { Stream<String> work(File file) throws IOException { try(BufferedReader r=new BufferedReader(new FileReader(file))) { return r.lines(); } } }
