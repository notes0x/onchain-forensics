# Methodology

Snapshot dates for balances, prices, and pool reserves range from September 21–23, 2026 (UTC), as cited alongside each figure in the reports. On-chain state changes continuously; treat every figure as accurate as of its cited timestamp, not as live.

## Verified directly on-chain

- The mint's token program (Token-2022 / Token Extensions), its enabled extensions, and the absence of a transfer fee, permanent delegate, or transfer hook extension.
- Current holder balances and their share of supply (`ansem_balances_from_real_post_balances.sql`).
- The launch transaction: a 650,000,000 ANSEM transfer from the deployer to the wallet publicly tagged "ansemconzimp" on Pump.fun, in the same transaction that created the token.
- Three subsequent transfers from that same wallet to the current largest holder, totaling exactly 491,000,100 ANSEM, dated July 31–August 1, 2026 (`gv6uu_bitgo_ansem_transfer.sql`).
- Reserves of the two largest liquidity pools.
- A full market breakdown across all trading venues for this token, reconciling closely with the token's reported aggregate liquidity figure.
- Airdrop retention, tracing 1,306 recipient wallets against their current balances and subsequent DEX sell activity (`ansem_airdrop_tree_from_gv6uu.sql`, `ansem_airdrop_retention_summary.sql`).
- Holder counts filtered by minimum USD value, to separate economically meaningful holders from dust (`ansem_holders_count.sql`).

## Cross-checked directly against a public source

- A public statement describing the airdrops as a redistribution of Pump.fun creator fees, read directly from the relevant account.
- A separate on-chain monitoring report claiming seven wallets received roughly 50 million tokens in early distribution, checked directly against the source post.
- A publicly stated goal of reaching 1,000,000 holders.

## Cited from outside reporting, not independently re-verified

- The deployer's initial bonding curve purchase and sale, and the approximate profit realized, as reported by third-party on-chain monitoring accounts shortly after launch.

## Wallet attribution

The identification of the wallets involved as linked to a specific public figure rests on public platform tags and a cited third-party post, not on a signed statement from that figure's own verified account. The transaction-level flow of funds between the wallets is independently confirmed regardless of that attribution.

## Known limitations

- The second-largest pool's own liquidity lock status was not checked, only the primary pool's was.
- The long tail of the token's trading pairs was not individually reviewed beyond the ten largest by volume; assumed economically negligible given permissionless pool creation on Solana, but not exhaustively confirmed.
- Price-impact modeling uses a constant-product approximation, which is exact for one pool's design and only an approximation for the other.
