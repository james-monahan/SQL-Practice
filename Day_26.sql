/* Cumulative Sum on date */

SELECT 
created_at::DATE AS date, COUNT(title) AS count,
SUM(COUNT(title)::integer) OVER (ORDER BY created_at::DATE) AS total
FROM posts 
GROUP BY 1
