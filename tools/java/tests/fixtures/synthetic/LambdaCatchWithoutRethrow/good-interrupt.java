class Probe { Runnable task = () -> { try { Thread.sleep(1); } catch (InterruptedException e) { Thread.currentThread().interrupt(); } }; }
