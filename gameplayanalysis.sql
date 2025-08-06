WITH FirstLogins AS (
    SELECT player_id, MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
),
NextDayLogins AS (
    SELECT a.player_id
    FROM Activity a
    JOIN FirstLogins f
      ON a.player_id = f.player_id
    WHERE a.event_date = DATE_ADD(f.first_login, INTERVAL 1 DAY)
)

SELECT 
    ROUND(
        COUNT(DISTINCT n.player_id) * 1.0 / (SELECT COUNT(*) FROM FirstLogins),
        2
    ) AS fraction
FROM NextDayLogins n;
