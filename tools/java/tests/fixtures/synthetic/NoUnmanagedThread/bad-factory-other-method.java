import java.util.concurrent.ThreadFactory; class Probe implements ThreadFactory { public Thread newThread(Runnable r) { return new Thread(r); } void unmanaged(Runnable r) { new Thread(r).start(); } }
