# Write your MySQL query statement below
WITH boarded AS (
    SELECT *,
           SUM(weight) OVER (ORDER BY turn) AS total_weight
    FROM Queue
)
SELECT person_name
FROM boarded
WHERE total_weight <= 1000
ORDER BY total_weight DESC
LIMIT 1;
