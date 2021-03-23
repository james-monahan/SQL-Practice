/*Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) 
as both their first and last characters. Your result cannot contain duplicates.*/

SELECT DISTINCT(CITY)
FROM 
STATION
WHERE LOWER(CITY) REGEXP '^[aeiou].*[aeiou]$'


/*Query the list of CITY names starting with vowels 
(i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.*/

SELECT DISTINCT(CITY)
FROM 
STATION
WHERE LOWER(CITY) REGEXP '^[aeiou]'

/*Query the two cities in STATION with the shortest 
and longest CITY names, as well as their respective lengths*/

(SELECT CITY, LENGTH(CITY) AS Chars
FROM STATION
ORDER BY Chars DESC, CITY
LIMIT 1)
UNION
(SELECT CITY, LENGTH(CITY) AS Chars
FROM STATION
ORDER BY Chars, CITY
LIMIT 1)
