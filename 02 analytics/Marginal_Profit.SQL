

WITH params AS (
    SELECT 
        (SELECT parameter_value FROM project_config WHERE parameter_name = 'cost_per_ad') as cpa,
        (SELECT parameter_value FROM project_config WHERE parameter_name = 'subscription_price') as price
),
ad_sequence AS (
    SELECT generate_series(1, (SELECT MAX(total_ads) FROM marketing_ab)) AS ad_number
),
stops AS (
    SELECT total_ads, COUNT(*) as users_stopped
    FROM marketing_ab WHERE test_group = 'ad'
    GROUP BY total_ads
),
conversions AS (
    SELECT total_ads, COUNT(*) as buyers
    FROM marketing_ab WHERE test_group = 'ad' AND converted = TRUE
    GROUP BY total_ads
),

marginal_values AS (
    SELECT 
          seq.ad_number
        , COALESCE(c.buyers, 0) * p.price AS m_revenue
        , SUM(COALESCE(s.users_stopped, 0)) OVER (ORDER BY seq.ad_number DESC) AS active_users
        , p.cpa
    FROM ad_sequence seq
    LEFT JOIN stops s ON seq.ad_number = s.total_ads
    LEFT JOIN conversions c ON seq.ad_number = c.total_ads
    CROSS JOIN params p
),

profit_flow AS (
    SELECT 
          ad_number
        , (m_revenue - (active_users * cpa)) AS m_profit
        , SUM(m_revenue - (active_users * cpa)) OVER (ORDER BY ad_number) AS cumulative_profit
    FROM marginal_values
),
optimal_point AS (
    SELECT ad_number, cumulative_profit FROM profit_flow ORDER BY cumulative_profit DESC LIMIT 1
),
final_point AS (
    SELECT ad_number, cumulative_profit FROM profit_flow ORDER BY ad_number DESC LIMIT 1
)
SELECT 
      o.ad_number AS optimal_frequency_cap
    , ROUND(o.cumulative_profit, 2) AS max_possible_profit
    , f.ad_number AS actual_max_frequency
    , ROUND(f.cumulative_profit, 2) AS actual_final_profit
    , ROUND(o.cumulative_profit - f.cumulative_profit, 2) AS potential_savings
FROM optimal_point o, final_point f;