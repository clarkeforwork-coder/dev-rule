import java.util.concurrent.Future; class Probe { Runnable task(Future<?> f) { return () -> { try { f.get(); } catch (Exception e) { f.cancel(true); } }; } }
