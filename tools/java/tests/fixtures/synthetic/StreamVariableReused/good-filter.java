import java.util.stream.Stream; class Probe { void work() { Stream<String> s=Stream.of("a"); s=s.filter((String x)->!x.isEmpty()); s.count(); } }
