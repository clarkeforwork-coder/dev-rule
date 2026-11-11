import java.util.List; class Probe { long count(List<String> xs) { return xs.parallelStream().count(); } }
