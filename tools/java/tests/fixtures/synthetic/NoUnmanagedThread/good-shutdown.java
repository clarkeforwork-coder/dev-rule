class Probe { void work(Runnable task) { Runtime.getRuntime().addShutdownHook(new Thread(task)); } }
