INSERT INTO user_activities (user_id, activity_analysis)
VALUES (${userId}, ${chatResponse.content})
ON CONFLICT (user_id) DO UPDATE
SET activity_analysis = EXCLUDED.activity_analysis;
