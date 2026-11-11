# Java 併發與非同步處理

本文件只維護 Java 的具體要求；引用的共通規範同樣具有約束力。

本文件承接[錯誤處理](../../../coding/error-handling.md)與[效能與資源使用](../../../quality/performance.md)，定義 Java 併發工作的所有權、同步、結果及生命週期。中斷與資源清理另依[例外與資源管理](exceptions-and-resources.md)，具體 API 須符合[版本要求](version-policy.md)。

## 工作所有權與執行資源

本組由共通規範承接的要求：[明確的工作擁有者](../../../coding/concurrency-and-async.md#task-ownership)。

<a id="java-execution-resources"></a>

### 統一管理執行資源

依[統一管理執行資源的共通要求](../../../coding/concurrency-and-async.md#execution-resources)執行。Java 可用明確提供的 `Executor`、`ExecutorService` 或框架提交工作；虛擬執行緒也須遵守下游容量。

**違反**

```java
// 業務方法自行建立執行緒，繞過統一管理的執行資源。
class Work {
    void submit(Runnable task) {
        new Thread(task).start();
    }
}
```

**符合**

```java
// 使用由負責元件提供及管理的執行資源提交工作。
class Work {
    void submit(Executor executor, Runnable task) {
        executor.execute(task);
    }
}
```

<a id="java-visibility-sharing"></a>

### 可見性與共享資料

跨執行緒資料須透過具備可見性保證的方式交付，優先使用不可變資料或符合契約的隔離快照。需要共享可變狀態時，須明訂同步與原子性範圍，不得以單一 `volatile` 欄位或偶然成功的執行結果推定整個物件安全。

**違反**

```java
// volatile 只保證欄位可見性，不能讓遞增成為原子操作。
class Counter {
    private volatile int value;
    void increment() { value++; }
    int value() { return value; }
}
```

**符合**

```java
// 以同一物件鎖保護全部讀寫，讓遞增具備原子性。
class Counter {
    private int value;
    synchronized void increment() { value++; }
    synchronized int value() { return value; }
}
```

## 期限、取消與結果

<a id="java-deadline-budget"></a>

### 等待期限與逾時處置

依[等待期限與逾時處置的共通要求](../../../coding/concurrency-and-async.md#deadline-budget)執行。Java 非同步等待的逾時不代表底層工作已停止；等待 API 須承接整體時間預算。

**違反**

```java
// 每次等待重新取得完整預算，可能超過整體期限。
class Waiting {
    void await(Future<?> first, Future<?> second, long budgetNanos)
            throws InterruptedException, ExecutionException, TimeoutException {
        first.get(budgetNanos, TimeUnit.NANOSECONDS);
        second.get(budgetNanos, TimeUnit.NANOSECONDS);
    }
}
```

**符合**

```java
// 兩次等待共用預算，逾時交回仍持有工作控制物件的呼叫端處置。
class Waiting {
    void await(Future<?> first, Future<?> second, long budgetNanos)
            throws InterruptedException, ExecutionException, TimeoutException {
        long start = System.nanoTime();
        first.get(budgetNanos, TimeUnit.NANOSECONDS);
        long remaining = budgetNanos - (System.nanoTime() - start);
        second.get(Math.max(0, remaining), TimeUnit.NANOSECONDS);
    }
}
```

<a id="java-cancellation-propagation"></a>

### 取消傳遞與實際停止

依[取消傳遞與實際停止的共通要求](../../../coding/concurrency-and-async.md#cancellation-and-termination)執行。Java 取消訊號及中斷依任務契約傳遞，不把取消最外層 Future 視為全部子工作已停止。

**違反**

```java
// 只取消外層結果，沒有把取消要求傳給子工作。
class Cancellation {
    void request(Future<?> outer, List<Future<?>> children) {
        outer.cancel(true);
    }
}
```

**符合**

```java
// 對契約允許中斷的子工作傳遞取消，實際停止仍由擁有者追蹤。
class Cancellation {
    void request(Future<?> outer, List<Future<?>> children) {
        outer.cancel(true);
        children.forEach((Future<?> child) -> child.cancel(true));
    }
}
```

<a id="java-result-reception"></a>

### `Future` 與 `CompletableFuture` 的結果鏈

非同步任務的成功、失敗與取消結果須有明確接收及處置路徑，不得忽略回傳的工作控制物件而遺失故障。`Future`、`CompletableFuture` 等結果須由負責元件處理；結果鏈中的例外轉換須保留原因與分類，只有契約允許的恢復或降級才能轉成替代結果，不得一律以空值或預設值將失敗變為成功。

**違反**

```java
// 未約定降級卻將全部失敗轉成成功的預設結果。
class Results {
    CompletableFuture<Integer> receive(CompletableFuture<Integer> work) {
        return work.exceptionally((Throwable error) -> 0);
    }
}
```

**符合**

```java
// 負責元件記錄故障並回傳結果鏈，呼叫端仍接收原成功或失敗結果。
class Results {
    private final System.Logger logger = System.getLogger(Results.class.getName());
    CompletableFuture<Integer> receive(CompletableFuture<Integer> work) {
        return work.whenComplete((Integer value, Throwable failure) -> {
            if (failure != null) {
                logger.log(System.Logger.Level.ERROR, "背景工作未成功", failure);
            }
        });
    }
}
```

<a id="java-task-completion"></a>

### 多工作組合的完成條件

依[多工作組合的完成條件的共通要求](../../../coding/concurrency-and-async.md#task-completion-contract)執行。Java 多工作組合須驗證完成順序及剩餘任務處置，第一個完成不等於第一個成功。

**違反**

```java
// 契約要求全部成功，卻在第一個工作完成時就結束組合。
class Completion {
    CompletableFuture<Void> allSucceeded(
            CompletableFuture<?> first, CompletableFuture<?> second) {
        return CompletableFuture.anyOf(first, second).thenApply((Object value) -> null);
    }
}
```

**符合**

```java
// 組合等待兩者完成，只有兩者都成功才回報成功。
class Completion {
    CompletableFuture<Void> allSucceeded(
            CompletableFuture<?> first, CompletableFuture<?> second) {
        return CompletableFuture.allOf(first, second);
    }
}
```

## 執行位置、脈絡與同步

<a id="java-execution-location"></a>

### 執行位置與阻塞行為

依[執行位置與阻塞行為的共通要求](../../../coding/concurrency-and-async.md#execution-and-blocking)執行。Java 任務及回呼須明確安排 executor 與阻塞行為，避免占用同一受限 executor 等待其排隊工作。

**違反**

```java
// 外層工作占住單執行緒資源，等待同一資源內排隊的子工作。
class Execution {
    CompletableFuture<Integer> run(Executor singleThreadExecutor) {
        return CompletableFuture.supplyAsync(() ->
            CompletableFuture.supplyAsync(() -> 1, singleThreadExecutor).join() + 1,
            singleThreadExecutor);
    }
}
```

**符合**

```java
// 用結果鏈接續工作，不占用單執行緒資源等待排隊工作。
class Execution {
    CompletableFuture<Integer> run(Executor singleThreadExecutor) {
        return CompletableFuture.supplyAsync(() -> 1, singleThreadExecutor)
            .thenApplyAsync((Integer value) -> value + 1, singleThreadExecutor);
    }
}
```

<a id="java-context-propagation"></a>

### 明確傳遞與清理脈絡

依[明確傳遞與清理脈絡的共通要求](../../../coding/concurrency-and-async.md#context-propagation)執行。Java 不假設 `ThreadLocal` 或日誌脈絡自動沿用；共用執行緒上的脈絡須在結束時清理或還原。

**違反**

```java
// 工作結束後未清理，脈絡可能留在共用執行緒上。
class Context {
    private final ThreadLocal<String> trace = new ThreadLocal<>();
    void run(String traceId, Runnable work) {
        trace.set(traceId);
        work.run();
    }
}
```

**符合**

```java
// 明確設定傳入的脈絡，並在所有退出路徑還原原有狀態。
class Context {
    private final ThreadLocal<String> trace = new ThreadLocal<>();
    void run(String traceId, Runnable work) {
        String previous = trace.get();
        trace.set(traceId);
        try { work.run(); }
        finally {
            if (previous == null) trace.remove();
            else trace.set(previous);
        }
    }
}
```

<a id="java-lock-scope"></a>

### 鎖定範圍與取得策略

依[鎖定範圍與取得策略的共通要求](../../../coding/concurrency-and-async.md#lock-scope)執行。Java 同步與鎖的實作須涵蓋全部退出路徑，必要檢查不能為縮短持鎖而移出原子範圍。

**違反**

```java
// 提早返回時沒有釋放鎖。
class Stock {
    private final Lock lock = new ReentrantLock();
    private int count;
    boolean take() {
        lock.lock();
        if (count == 0) return false;
        count--;
        lock.unlock();
        return true;
    }
}
```

**符合**

```java
// 檢查與扣減都在鎖內，所有退出路徑均釋放鎖。
class Stock {
    private final Lock lock = new ReentrantLock();
    private int count;
    boolean take() {
        lock.lock();
        try {
            if (count == 0) return false;
            count--;
            return true;
        } finally { lock.unlock(); }
    }
}
```

## 關閉與驗證

<a id="java-controlled-shutdown"></a>

### 受控關閉

依[受控關閉的共通要求](../../../coding/resource-lifecycle.md#controlled-shutdown)執行。Java 執行元件開始關閉或發出停止要求不代表工作全數結束；實際關閉與資源釋放依共同契約驗證。

**違反**

```java
// 將發出關閉要求誤當成已終止，提前釋放工作所需資源。
class Shutdown {
    void close(ExecutorService executor, Closeable resource) throws IOException {
        executor.shutdown();
        resource.close();
    }
}
```

**符合**

```java
// 確認終止才釋放資源，逾時或中斷交回擁有者繼續追蹤。
class Shutdown {
    void close(ExecutorService executor, Closeable resource)
            throws IOException, InterruptedException, TimeoutException {
        executor.shutdown();
        if (!executor.awaitTermination(1, TimeUnit.SECONDS)) {
            throw new TimeoutException("工作尚未結束，資源仍由呼叫端持有");
        }
        resource.close();
    }
}
```

<a id="java-controlled-verification"></a>

### 可控制的併發驗收

依[可控制的併發驗收的共通要求](../../../quality/testing.md#controlled-interleaving)執行。Java 測試使用可控制的協調與完成條件，並審查同步／可見性設計，不以固定睡眠或壓力測試單獨證明安全。

**違反**

```java
// 固定睡眠不能保證背景工作已完成。
class Verification {
    void verify(Executor executor) throws InterruptedException {
        AtomicInteger value = new AtomicInteger();
        executor.execute(() -> value.set(1));
        Thread.sleep(100);
        if (value.get() != 1) throw new AssertionError();
    }
}
```

**符合**

```java
// 使用明確的完成訊號及期限驗證結果，資料以原子型別交付。
class Verification {
    void verify(Executor executor) throws InterruptedException {
        AtomicInteger value = new AtomicInteger();
        CountDownLatch done = new CountDownLatch(1);
        executor.execute(() -> { value.set(1); done.countDown(); });
        if (!done.await(1, TimeUnit.SECONDS)) throw new AssertionError("未完成");
        if (value.get() != 1) throw new AssertionError();
    }
}
```

<a id="java-closing-requirements"></a>

## 補充要求

共享集合的複合操作另依[集合與資料所有權](collections-and-ownership.md)，元件生命週期依[類別、介面與物件建立](classes-and-construction.md)，平行資料處理依[Lambda 與 Stream](lambda-and-stream.md)。身分及延後執行授權依[安全規範](../../../quality/security.md#authorization-and-data-scope)，追蹤與故障紀錄依[日誌、稽核與可觀測性](../../../quality/observability.md#diagnostic-logging-and-tracing)。

## 驗收要求

共同驗收與 Java 語言增量均須經實際採用的 Java 型別、API、版本與框架銜接路徑執行，不因引用共通驗收而略過。依變更影響及實際使用路徑選擇案例，測試層級及證據依[共通測試策略](../../../quality/testing.md#test-levels-and-cases)與[規範驗證](../../../quality/rule-verification.md#verification-coverage)。

### 共同驗收

- [明確的工作擁有者](../../../coding/concurrency-and-async.md#acceptance-task-ownership)。
- [統一管理執行資源、執行位置與阻塞行為](../../../coding/concurrency-and-async.md#acceptance-execution-resources)。
- [等待期限與逾時處置、取消傳遞與實際停止](../../../coding/concurrency-and-async.md#acceptance-deadline-cancellation)。
- [多工作組合的完成條件](../../../coding/concurrency-and-async.md#acceptance-task-composition)。
- [明確傳遞與清理脈絡](../../../coding/concurrency-and-async.md#acceptance-context-isolation)。
- [鎖定範圍與取得策略](../../../coding/concurrency-and-async.md#acceptance-lock-scope)。
- [受控關閉](../../../coding/resource-lifecycle.md#acceptance-controlled-shutdown)。
- [可控制的併發驗收](../../../quality/testing.md#acceptance-controlled-interleaving)。
- [結果接收與故障處置](../../../coding/concurrency-and-async.md#acceptance-result-reception)。

### Java 語言增量驗收

| 對應要求 | 語言增量驗收 |
| --- | --- |
| <a id="acceptance-java-visibility"></a>[可見性與共享資料](#java-visibility-sharing) | 審查 Java 跨執行緒資料交付的可見性保證、共享資料的同步範圍及適用的鎖定方式；以受控交錯核對不變條件與共享狀態，不能只以單一 `volatile` 欄位或偶然成功推定整個物件安全。 |
| <a id="acceptance-java-task-results"></a>[`Future` 與 `CompletableFuture` 的結果鏈](#java-result-reception) | 沿 Java `Future`／`CompletableFuture` 的實際接收及結果鏈路徑觸發成功、失敗與取消，核對故障可追查、原始原因與分類保留，且未以替代值把失敗變成成功。 |

既有程式碼、框架限制與必要例外依[規範治理](../../../workflow/rule-governance.md)處理，不自行降低要求。
