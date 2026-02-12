CREATE OR REPLACE VIEW user_events_raw AS 
SELECT 
      user_id
    , test_group
    , 'onboarding' as event_name
    , '2026-01-01 00:00:00'::timestamp + (most_ads_hour * interval '1 hour') AS event_time
FROM marketing_ab
UNION ALL 

SELECT 
      user_id
    , test_group
    , 'paywall' as event_name
    , '2026-01-01 00:00:00'::timestamp + (most_ads_hour * interval '1 hour') + INTERVAL '1 minutes' AS event_time
FROM marketing_ab
UNION ALL 
SELECT 
      user_id
    , test_group
    , 'purchase' as event_name
    , '2026-01-01 00:00:00'::timestamp + (most_ads_hour * interval '1 hour') + INTERVAL '15 minutes' event_time
FROM marketing_ab
WHERE converted = TRUE
