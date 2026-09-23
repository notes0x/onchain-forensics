SELECT
  COUNT(*) AS recipients,
  SUM(received) AS total_received,
  SUM(LEAST(dex_sold, received)) AS total_sold_capped,
  SUM(balance_now) AS total_still_held,
  SUM(balance_now) / NULLIF(SUM(received), 0) * 100 AS pct_retained,
  COUNT(*) FILTER (WHERE balance_now = 0) AS wallets_fully_exited,
  COUNT(*) FILTER (WHERE balance_now = 0) * 1.0 / COUNT(*) * 100 AS pct_wallets_zeroed
FROM "query_8800714"
WHERE recipient <> '7oU9nR9VEvFPwvp2PpXo2LQc6A92QRhcUTwhLWT7MsDM'  -- exclude the main wallet itself