WITH params AS (
    SELECT 
        0.05 as cpa,
        50.0 as price
),
caps AS (
    SELECT unnest(ARRAY[1, 5, 10, 20, 50, 100, 250, 500, 1000, 2000]) AS n_limit
),
simulation AS (
    SELECT 
        c.n_limit,
        COUNT(CASE WHEN m.converted = TRUE AND m.total_ads <= c.n_limit THEN 1 END) * p.price AS simulated_revenue,
        SUM(CASE 
            WHEN m.total_ads <= c.n_limit THEN m.total_ads 
            ELSE c.n_limit 
        END) * p.cpa AS simulated_cost
    FROM marketing_ab m
    CROSS JOIN caps c
    CROSS JOIN params p
    WHERE m.test_group = 'ad'
    GROUP BY c.n_limit, p.price, p.cpa
)
SELECT 
    n_limit AS frequency_cap,
    ROUND(simulated_revenue, 2) AS revenue,
    ROUND(simulated_cost, 2) AS cost,
    ROUND(simulated_revenue - simulated_cost, 2) AS net_profit,
    ROUND((simulated_revenue / NULLIF(simulated_cost, 0)) * 100, 2) AS roas_percent
FROM simulation
ORDER BY n_limit;