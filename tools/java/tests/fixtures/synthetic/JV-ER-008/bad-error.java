class Probe { void run() { try { work(); } catch(Error e) { throw e; } } void work() {} }
