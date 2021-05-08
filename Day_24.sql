/* You need to build a pivot table WITHOUT using 
CROSSTAB function. Having two tables products 
and details you need to select a pivot table of 
products with counts of details occurrences 
(possible details values are ['good', 'ok', 'bad'].*/

SELECT p.name, 
SUM(CASE 
  WHEN d.detail = 'good' THEN 1
  END) AS good,
SUM(CASE 
  WHEN d.detail = 'ok' THEN 1
  END) AS ok,
SUM(CASE 
  WHEN d.detail = 'bad' THEN 1
  END) AS bad
FROM
products AS p
JOIN
details AS d
ON p.id=d.product_id
GROUP BY p.name
ORDER BY p.name


/*  filter the name field to only 
show "trained" events. Events should be 
grouped by the day they happened and counted.*/

SELECT
e.created_at::DATE AS day, e.description, COUNT(*)
FROM
events as e
WHERE e.name = 'trained'
GROUP BY e.created_at::DATE, e.description
