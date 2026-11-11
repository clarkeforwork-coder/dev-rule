class Probe { Runnable task = () -> { try { throw new IllegalStateException(); } catch (IllegalStateException e) { throw e; } }; }
