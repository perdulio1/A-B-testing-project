WITH
counting AS(
SELECT 
        test_group,
        SUM(total_ads) as total_ads_count,
        COUNT(CASE WHEN converted = TRUE THEN 1 END) as buyers_count
    FROM marketing_ab
    GROUP BY test_group
),

cost_per_ad AS
(SELECT parameter_value FROM project_config WHERE parameter_name = 'cost_per_ad'),

subscription_price AS 
(SELECT parameter_value FROM project_config WHERE parameter_name = 'subscription_price')


SELECT 
      test_group
    , total_ads_count * cost_per_ad.parameter_value AS total_costs
    , buyers_count * subscription_price.parameter_value AS total_revenue
    , total_ads_count * cost_per_ad.parameter_value / counting.buyers_count  AS CAC
    , buyers_count * subscription_price.parameter_value / total_ads_count * 100 AS ROAS
FROM counting, cost_per_ad, subscription_price