class Probe { void work(Runnable task) { new Thread(task).start(); } }
