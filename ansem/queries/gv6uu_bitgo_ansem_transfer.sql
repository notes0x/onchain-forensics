SELECT block_time, tx_id, from_owner, to_owner, amount_display
FROM tokens_solana.transfers
WHERE token_mint_address = '9cRCn9rGT8V2imeM2BaKs13yhMEais3ruM3rPvTGpump'
  AND (from_owner = 'GV6UUmNxz2RpKxmNAPadYKb7uQpszwqQAu3qLJxVdC52'
       OR from_owner = '2U9XFtekYTstzMYXmuyDCNdFxRYB91dMtSKxtUB5rVct')
  AND to_owner = '7oU9nR9VEvFPwvp2PpXo2LQc6A92QRhcUTwhLWT7MsDM'
  AND block_time BETWEEN DATE '2026-07-29' AND DATE '2026-08-02'