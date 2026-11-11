# 原始盤點來源索引

日期：2026-11-11。原始盤點是首版研究輸入，未隨庫保存；其暫存結果不是本庫可重跑證據。rule-map 每筆 note 以盤點檔名、原始筆序與目前穩定 ID 追溯，小節有多條候選時列出相關筆序；本庫驗收以 tests 與 fixtures 為準。

| 盤點檔名 | 筆數 | SHA-256 |
| --- | --- | --- |
| inventory-inv-claude-a.yml | 89 | `fb2cce6950aba3b9e01dcc03ed0926e3221d4cc9a6b021e150b2735516b2bb7a` |
| inventory-inv-claude-b.yml | 110 | `fab0d0e5477c87f4f669d490e30b751dbf8e0431d52e36a3768782032262bbb0` |
| inventory-inv-codex-a.yml | 57 | `91eb372d59548ac50440661d74e1ec55099f409b542fedc083fe4f931fba4b04` |
| inventory-inv-codex-b.yml | 62 | `7a7c73eefe96322d2c0a4e34b810836b76474e124175d9d05b2b31eb77f30dd2` |

SpotBugs 統一目標版本為 4.10.5；CA-004／CA-012 舊盤點使用 4.8.6 的歷史證據保留在 note 並註明待重驗，不能將舊結果改稱 4.10.5 實跑。
