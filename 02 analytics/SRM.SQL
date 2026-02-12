
SELECT
      test_group
    , COUNT(DISTINCT user_id) as counting
    , ROUND(COUNT(DISTINCT user_id) / SUM(COUNT(DISTINCT user_id)) OVER() * 100, 4) as diff
FROM marketing_ab
GROUP BY test_group