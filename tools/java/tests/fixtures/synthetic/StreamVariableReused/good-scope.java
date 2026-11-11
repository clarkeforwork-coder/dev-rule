import java.util.stream.Stream; class Probe { void work() { { Stream<String> s=Stream.of("a"); s.count(); } { Stream<String> s=Stream.of("b"); s.count(); } } }
