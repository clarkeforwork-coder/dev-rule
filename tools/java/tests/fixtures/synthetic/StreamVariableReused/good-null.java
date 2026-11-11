import java.util.stream.Stream; class Probe { void work() { Stream<String> s=Stream.of("a"); if(s==null) return; s.count(); } }
