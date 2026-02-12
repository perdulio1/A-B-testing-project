WITH step_counts AS (
SELECT
      test_group
    , event_name
    , COUNT(DISTINCT user_id) as user_count
FROM user_events_raw
GROUP BY test_group, event_name
)
SELECT 
      curr.test_group
    , curr.event_name
    , curr.user_count
    , ROUND(curr.user_count::numeric / base.user_count * 100, 2) AS conversion_rate
FROM step_counts curr
JOIN step_counts base 
    ON curr.test_group = base.test_group
    AND base.event_name = 'onboarding'
ORDER BY curr.test_group, curr.user_count DESC;
