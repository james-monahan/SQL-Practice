/*Query the sum of Northern Latitudes (LAT_N) from STATION having values greater
than x and less than y. Truncate your answer to  decimal places.*/

SELECT ROUND(SUM(LAT_N),4)
FROM STATION
WHERE LAT_N > 38.7880 
AND LAT_N < 137.2345
-- BETWEEN

/*Query the greatest value of the Northern Latitudes (LAT_N) from STATION 
that is less than . Truncate your answer to  decimal places*/

SELECT ROUND(MAX(LAT_N),4)
FROM STATION
WHERE LAT_N < 137.2345

/*Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) 
in STATION that is less than . Round your answer to  decimal places.*/

SELECT ROUND(LONG_W,4)
FROM STATION
WHERE LAT_N < 137.2345
ORDER BY LAT_N DESC
LIMIT 1

/*Query the smallest Northern Latitude (LAT_N) from 
STATION that is greater than . Round your answer to  decimal places.*/

SELECT ROUND(LAT_N,4)
FROM STATION
WHERE LAT_N > 38.7880
ORDER BY LAT_N 
LIMIT 1

/*Query the Western Longitude (LONG_W)where the smallest Northern Latitude 
(LAT_N) in STATION is greater than . Round your answer to  decimal places.*/

SELECT ROUND(LONG_W,4)
FROM STATION
WHERE LAT_N = 
    (SELECT MIN(LAT_N) 
    FROM STATION 
    WHERE LAT_N > 38.7780)

