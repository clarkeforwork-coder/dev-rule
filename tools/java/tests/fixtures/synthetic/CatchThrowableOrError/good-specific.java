class Probe { void run() { try { work(); } catch(IllegalArgumentException e) { System.out.println(e); } } void work() {} }
