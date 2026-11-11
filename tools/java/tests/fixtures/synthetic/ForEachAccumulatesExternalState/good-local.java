import java.util.*; class Probe { void work(List<String> source) { source.forEach((String x) -> { List<String> local=new ArrayList<>(); local.add(x); System.out.println(local); }); } }
