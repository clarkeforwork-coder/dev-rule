import java.util.concurrent.ThreadFactory; class Probe { ThreadFactory factory = new ThreadFactory() { public Thread newThread(Runnable r) { return new Thread(r); } }; }
