WITH price AS (SELECT 0.1714 AS usd_per_token),  -- update to current price when you run this
h AS (SELECT owner, balance FROM "query_8794192")
SELECT
  COUNT(*) AS total_holders,
  COUNT(*) FILTER (WHERE balance * (SELECT usd_per_token FROM price) >= 1)   AS holders_over_1usd,
  COUNT(*) FILTER (WHERE balance * (SELECT usd_per_token FROM price) >= 10)  AS holders_over_10usd,
  COUNT(*) FILTER (WHERE balance * (SELECT usd_per_token FROM price) >= 100) AS holders_over_100usd
FROM h