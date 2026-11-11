class Probe { void run() { try { work(); } catch(Throwable e) { System.out.println(e); } } void work() {} }
