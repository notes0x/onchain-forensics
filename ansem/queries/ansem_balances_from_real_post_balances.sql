WITH transfers AS (
    SELECT "to" AS wallet, DATE_TRUNC('day', evt_block_time) AS day, value / POW(10, 18) AS amount
    FROM erc20_ethereum.evt_Transfer
    WHERE contract_address = 0x4c5fc2efd7f9fba2c6a9227abd9d1c3eefd6bdd7
    UNION ALL
    SELECT "from" AS wallet, DATE_TRUNC('day', evt_block_time) AS day, -value / POW(10, 18) AS amount
    FROM erc20_ethereum.evt_Transfer
    WHERE contract_address = 0x4c5fc2efd7f9fba2c6a9227abd9d1c3eefd6bdd7
),
wallet_daily_net AS (
    SELECT wallet, day, SUM(amount) AS net_change
    FROM transfers
    GROUP BY 1, 2
),
wallet_running AS (
    SELECT
        wallet,
        day,
        SUM(net_change) OVER (PARTITION BY wallet ORDER BY day) AS running_balance
    FROM wallet_daily_net
),
wallet_crossings AS (
    SELECT
        wallet,
        day,
        running_balance,
        LAG(running_balance) OVER (PARTITION BY wallet ORDER BY day) AS prev_balance
    FROM wallet_running
),
holder_deltas AS (
    SELECT
        day,
        CASE
            WHEN (prev_balance IS NULL OR prev_balance <= 0.00000001) AND running_balance > 0.00000001 THEN 1
            WHEN prev_balance > 0.00000001 AND running_balance <= 0.00000001 THEN -1
            ELSE 0
        END AS holder_delta
    FROM wallet_crossings
)
SELECT
    day,
    SUM(holder_delta) AS net_holder_change,
    SUM(SUM(holder_delta)) OVER (ORDER BY day) AS cumulative_holder_count
FROM holder_deltas
GROUP BY day
ORDER BY day