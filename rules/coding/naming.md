# 命名與可讀性

<a id="domain-vocabulary-and-context"></a>
## 領域詞彙與上下文

同一模組內，同一概念使用一致的領域詞彙，不同業務效果使用可區分的名稱。例如「取消訂單」與「申請退貨」分別使用 `cancelOrder` 與 `requestReturn`。跨模組時依各自的語意命名，並在交界處明確對應。

名稱的詳略取決於使用處。`order.status` 已能表達訂單狀態；同時處理訂單與付款的函式則可用 `orderStatus` 與 `paymentStatus` 區分兩者。短迴圈的索引或團隊熟悉的縮寫，在小範圍內可直接辨識時可以使用。若必須回頭追查 `data` 或 `result` 的來源才能理解，就改用具體名稱。大小寫、前後綴與語法格式由專案依語言慣例統一。

<a id="operations-and-predicates"></a>
## 操作與判斷

- 函式名稱須表達呼叫者需要知道的業務效果，使人能區分查詢與狀態變更。例如 `availableQuantity` 查詢可用庫存，`reserveStock` 保留庫存。記錄日誌、計算指標與填入快取等附帶處理通常不需列入名稱。
- 布林值與判斷函式的名稱須讓讀者能說出 `true` 代表的命題。`isCancelled` 表達已取消，`canCancel` 表達允許取消，`shouldCancel` 表達策略決定應取消。若業務關心停用狀態，`isDisabled` 可以直接表達該命題。
- 一組條件共同表達明確業務概念，且名稱有助理解時，才抽取成具名判斷。名稱須涵蓋實際檢查範圍。例如只檢查訂單狀態的 `orderStateAllowsCancellation`，不能當作已完成授權等全部取消條件的判斷。

<a id="units-values-and-literals"></a>
## 單位、數值與字面值

- 優先用專屬型別表達容易混用的單位與業務含義。型別無法完整表達時，以名稱補足。例如設定以整數秒傳入，可命名為 `retryDelaySeconds`。即使型別相同，也須區分含首次呼叫的 `maxAttempts` 與只計後續重試的 `maxRetries`。專屬型別的要求見[領域建模](domain-modeling.md#dedicated-types)。
- 代表業務規則、協定約定或操作限制的字面值應有明確名稱，並由擁有該規則的元件管理。會依環境調整的值由設定提供。登入與退款的嘗試上限即使目前都是三次，仍可因各自政策獨立調整。`count == 0` 等在使用處即可理解的判斷可直接保留字面值。
