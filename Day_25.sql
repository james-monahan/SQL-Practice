/* SQL Statistics: MIN, MEDIAN, MAX */

SELECT MIN(score), MAX(score),
  PERCENTILE_CONT(0.5) 
  WITHIN GROUP (ORDER BY score) 
  AS median
FROM result
