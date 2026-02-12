WITH counting AS(
SELECT
      test_group
    , COUNT(DISTINCT user_id) AS total_users
    , COUNT(*) FILTER (WHERE converted = true) AS converted_count
FROM marketing_ab
GROUP BY test_group
),
counting2 AS (
SELECT 
      test_group
    , total_users as "n"
    , converted_count / total_users::NUMERIC as "p"
FROM counting
),
group_stats AS (SELECT
      test_group
    , "n"
    , "p"
    , ("p"*(1-"p"))/"n" AS variance
FROM counting2
),
pivoted AS (
    SELECT 
        MAX(CASE WHEN test_group = 'ad' THEN p END) as p_ad,
        MAX(CASE WHEN test_group = 'ad' THEN variance END) as var_ad,
        MAX(CASE WHEN test_group = 'psa' THEN p END) as p_psa,
        MAX(CASE WHEN test_group = 'psa' THEN variance END) as var_psa
    FROM group_stats
)
SELECT 
      p_ad, p_psa
    , (p_ad - p_psa) as lift 
    , (p_ad - p_psa) / SQRT(var_ad + var_psa) AS z_score
FROM pivoted;