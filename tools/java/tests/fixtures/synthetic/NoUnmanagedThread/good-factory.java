import java.util.concurrent.ThreadFactory; class Probe implements ThreadFactory { public Thread newThread(Runnable task) { return new Thread(task); } }
