/*Query the list of CITY names from STATION that do not start with vowels. 
Your result cannot contain duplicates.*/

SELECT DISTINCT(CITY)
FROM 
STATION
WHERE LOWER(CITY) REGEXP '^[^aeiou]'

/*Query the list of CITY names from STATION that do not end with vowels. 
Your result cannot contain duplicates.*/

SELECT DISTINCT(CITY)
FROM 
STATION
WHERE LOWER(CITY) REGEXP '^[^aeiou].*[^aeiou]$'

/*Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. 
Your result cannot contain duplicates.*/

SELECT DISTINCT(CITY)
FROM 
STATION
WHERE LOWER(CITY) REGEXP '^[^aeiou]'
OR  LOWER(CITY) REGEXP '[^aeiou]$'

/*Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. 
Your result cannot contain duplicates.*/

SELECT DISTINCT(CITY)
FROM 
STATION
WHERE LOWER(CITY) REGEXP '^[^aeiou].*[^aeiou]$'

/*Query the Name of any student in STUDENTS who scored higher than  Marks. 
Order your output by the last three characters of each name. 
If two or more students both have names ending in the same last three characters 
(i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.*/

SELECT Name
FROM
(SELECT *, RIGHT(Name, 3) As chars 
FROM STUDENTS
WHERE Marks > 75
ORDER BY chars, ID ASC) AS query

/*Write a query that prints a list of employee names 
(i.e.: the name attribute) from the Employee table in alphabetical order.*/

SELECT Name
FROM Employee
Order By Name

/*Write a query that prints a list of employee names (i.e.: the name attribute) 
for employees in Employee having a salary greater than  per month who have been 
employees for less than  months. Sort your result by ascending employee_id.*/

SELECT Name
FROM Employee
WHERE salary > 2000
AND
months < 10
Order By employee_id

