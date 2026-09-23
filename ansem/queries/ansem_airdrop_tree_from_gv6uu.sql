WITH sent AS (
  SELECT to_owner AS recipient, SUM(amount_display) AS received,
         MIN(block_time) AS first_received, COUNT(*) AS transfers
  FROM tokens_solana.transfers
  WHERE token_mint_address = '{{token}}'
    AND block_time >= TIMESTAMP '{{start_date}}'
    AND from_owner = 'GV6UUmNxz2RpKxmNAPadYKb7uQpszwqQAu3qLJxVdC52'
    AND to_owner <> from_owner
  GROUP BY 1
),
sells AS (
  SELECT trader_id, SUM(token_sold_amount) AS dex_sold
  FROM dex_solana.trades
  WHERE block_time >= TIMESTAMP '{{start_date}}'
    AND token_sold_mint_address = '{{token}}'
  GROUP BY 1
)
SELECT s.recipient, s.received, s.first_received,
       COALESCE(b.balance,0) AS balance_now,
       COALESCE(x.dex_sold,0) AS dex_sold,
       COALESCE(b.balance,0) / s.received AS pct_still_held
FROM sent s
LEFT JOIN "query_8794192" b ON b.owner = s.recipient
LEFT JOIN sells x ON x.trader_id = s.recipient
ORDER BY s.received DESC