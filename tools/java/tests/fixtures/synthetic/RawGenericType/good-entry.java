import java.util.*; class Probe { Set<Map.Entry<String,Integer>> entries; void visit(Map<String,Integer> map) { for (Map.Entry<String,Integer> e : map.entrySet()) { System.out.println(e); } } }
