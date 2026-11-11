class Probe { void run() { try { work(); } catch(IllegalArgumentException e) { throw e; } } void work() {} }
