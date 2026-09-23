# $ANSEM ("The Black Bull") — On-Chain Distribution & Health Investigation

**Mint:** `9cRCn9rGT8V2imeM2BaKs13yhMEais3ruM3rPvTGpump`
**Chain:** Solana (Token-2022)
**Snapshot window:** September 21–23, 2026

## Summary

A Pump.fun launch trading under the ticker ANSEM, referencing (but not created or endorsed by) Solana trader Ansem. This investigation traces the token's supply from its launch transaction through to its current holder distribution, measures liquidity depth against the largest holder's position, and quantifies how much of the token's community airdrop has already been sold.

Full reports:
- [ANSEM_Investor_Risk_Report.docx](./reports/ANSEM_Investor_Risk_Report.docx) — two-page summary, decision-oriented
- [ANSEM_Onchain_Distribution_Health_Report.docx](./reports/ANSEM_Onchain_Distribution_Health_Report.docx) — full technical writeup

## Key findings

- The deployer transferred 650,000,000 ANSEM (65% of initial supply) to a single wallet in the same transaction that launched the token.
- That 65% is confirmed, transaction by transaction, to remain under a single party's control today, split between that original wallet and a BitGo custodial wallet it funded across three transfers in July–August 2026 (`queries/gv6uu_bitgo_ansem_transfer.sql`).
- Total identified liquidity across all trading venues (~$4.3M) is a small fraction of the largest wallet's value (~$84M at snapshot).
- Of 71.83M tokens airdropped to 1,306 traced wallets, only 12.05% is still held; 61.6% of recipient wallets are now at a zero balance (`queries/ansem_airdrop_tree_from_gv6uu.sql`, `queries/ansem_airdrop_retention_summary.sql`).
- The mint's Token-2022 extensions were checked directly: no transfer fee, no permanent delegate, no transfer hook. Mint and freeze authority are both null.

See `METHODOLOGY.md` for exactly what was verified directly on-chain versus cited from outside reporting.

## Contents

`queries/` holds each query alongside its raw result set, so findings can be checked without re-running anything:

- `ansem_balances_from_real_post_balances.sql` / `.csv` — base holder balance query, everything else builds on this
- `gv6uu_bitgo_ansem_transfer.sql` / `.csv` — the query that traced the confirmed transfer chain
- `ansem_airdrop_tree_from_gv6uu.sql` / `.csv` — traces every wallet that received an airdrop from the source wallet
- `ansem_airdrop_retention_summary.sql` / `.csv` — rolls the airdrop tree up into retention figures
- `ansem_holders_count.sql` / `.csv` — holder counts filtered by minimum USD value, separating real holders from dust

`reports/` holds the two finished writeups. `METHODOLOGY.md` (below) states what was verified directly versus cited for context.
