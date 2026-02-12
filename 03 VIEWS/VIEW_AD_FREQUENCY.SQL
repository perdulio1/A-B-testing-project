CREATE OR REPLACE VIEW Group_ROAS AS
WITH frequency_buckets AS (
    SELECT 
          converted
        , total_ads
        , CASE 
            WHEN total_ads BETWEEN 1 AND 10   THEN '01. 1-10 ads'
            WHEN total_ads BETWEEN 11 AND 20  THEN '02. 11-20 ads'
            WHEN total_ads BETWEEN 21 AND 50  THEN '03. 21-50 ads'
            WHEN total_ads BETWEEN 51 AND 100 THEN '04. 51-100 ads'
            WHEN total_ads BETWEEN 101 AND 200 THEN '05. 101-200 ads'
            ELSE '06. 200+ ads'
          END AS frequency_group
    FROM marketing_ab
    WHERE test_group = 'ad'
),
params AS (
    SELECT 
        (SELECT parameter_value FROM project_config WHERE parameter_name = 'cost_per_ad') as cpa,
        (SELECT parameter_value FROM project_config WHERE parameter_name = 'subscription_price') as price
)
SELECT 
      f.frequency_group
    , COUNT(*) AS total_users
    , SUM(f.total_ads) AS total_ads_shown
    , ROUND(SUM(f.total_ads) * p.cpa, 2) AS group_costs
    , COUNT(*) FILTER (WHERE f.converted = TRUE) * p.price AS group_revenue
    , ROUND(
        (COUNT(*) FILTER (WHERE f.converted = TRUE) * p.price) / 
        NULLIF(SUM(f.total_ads) * p.cpa, 0), 2
      ) AS group_roas
FROM frequency_buckets f, params p
GROUP BY f.frequency_group, p.cpa, p.price
ORDER BY f.frequency_group;