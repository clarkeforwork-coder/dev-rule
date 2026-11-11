import java.util.concurrent.ThreadFactory; class Probe { ThreadFactory expression = r -> new Thread(r); ThreadFactory block = r -> { return new Thread(r); }; }
