class Probe { Object factory = new Object() { public Thread newThread(Runnable r) { return new Thread(r); } }; }
