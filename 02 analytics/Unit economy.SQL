WITH 
counting AS (
    SELECT 
        test_group,
        SUM(total_ads) as total_ads_count,
        COUNT(CASE WHEN converted = TRUE THEN 1 END) as buyers_count
    FROM marketing_ab
    GROUP BY test_group
),

params AS (
    SELECT 
        (SELECT parameter_value FROM project_config WHERE parameter_name = 'cost_per_ad') as cpa,
        (SELECT parameter_value FROM project_config WHERE parameter_name = 'subscription_price') as price
),

base_metrics AS (
    SELECT 
        c.test_group,
        c.buyers_count,
        c.total_ads_count * p.cpa AS total_costs,
        c.buyers_count * p.price  AS total_revenue
    FROM counting c
    CROSS JOIN params p
)


SELECT 
      test_group
    , total_costs
    , total_revenue
    , ROUND(total_costs / buyers_count, 2) AS cac
    , ROUND(total_revenue / total_costs * 100, 2) || ' %' AS roas
FROM base_metrics;