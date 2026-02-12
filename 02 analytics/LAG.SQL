WITH user_events_LOG AS(
SELECT
      user_id 
    , event_time
    , event_name
    , LAG(event_time) OVER(PARTITION BY user_id ORDER BY event_time) AS prev_event_time
    , event_time - LAG(event_time) OVER(PARTITION BY user_id ORDER BY event_time) AS time_diff 
 FROM user_events_raw
)

SELECT
      user_id 
    , event_name
    , CASE
          WHEN time_diff < INTERVAL '30 minutes' THEN 0
          ELSE 1
      END AS is_new_session
 FROM user_events_LOG
 ORDER BY user_id ASC
 LIMIT 1000