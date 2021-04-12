/*
Query the Manhattan Distance between points  and  and round it to a scale of  decimal places.
*/

SELECT ROUND(ABS(MAX(LAT_N) - MIN(LAT_N)) + ABS(MAX(LONG_W) - MIN(LONG_W)),4)
FROM STATION

/*
Query the Euclidian Distance between points  and  and round it to a scale of  decimal places.
*/

SELECT ROUND(POWER(   POWER(MAX(LAT_N) - MIN(LAT_N),2) + POWER(MAX(LONG_W) - MIN(LONG_W),2   ),.5),4)
FROM STATION

/*
Given the CITY and COUNTRY tables, 
query the sum of the populations of all cities where the CONTINENT is 'Asia'.
*/

SELECT SUM(cy.POPULATION)
FROM CITY as cy
JOIN COUNTRY as ct
ON ct.Code=cy.CountryCode 
WHERE ct.CONTINENT = 'Asia'

/*
Given the CITY and COUNTRY tables, 
query the names of all cities where the CONTINENT is 'Africa'.
*/

SELECT DISTINCT(cy.NAME)
FROM CITY as cy
JOIN COUNTRY as ct
ON ct.Code=cy.CountryCode 
WHERE ct.CONTINENT = 'Africa'

/*
Given the CITY and COUNTRY tables, 
query the names of all the continents (COUNTRY.Continent) 
and their respective average city populations (CITY.Population) 
rounded down to the nearest integer.
*/

SELECT ct.CONTINENT, FLOOR(AVG(cy.POPULATION))
FROM CITY as cy
JOIN COUNTRY as ct
ON ct.Code=cy.CountryCode 
GROUP BY ct.CONTINENT
