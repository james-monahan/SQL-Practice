/*Write a query identifying the type of each 
record in the TRIANGLES table using its three side lengths*/

SELECT
CASE
    WHEN A + B <= C OR A + C <= B OR B + C <= A THEN "Not A Triangle"
    WHEN A = B AND B = C THEN "Equilateral"
    WHEN A != B AND B != C AND A != C THEN "Scalene"
    ELSE "Isosceles"
END
FROM Triangles

/*Query an alphabetically ordered list of all names in OCCUPATIONS, 
immediately followed by the first letter of each profession as a 
parenthetical (i.e.: enclosed in parentheses).
Query the number of ocurrences of each occupation in OCCUPATIONS. 
Sort the occurrences in ascending order, and output them in the following format:*/

SELECT CONCAT(Name,"(",SUBSTR(Occupation, 1, 1),")")
FROM Occupations
ORDER BY Name;
SELECT CONCAT ("There are a total of ", COUNT(Occupation)," ", LOWER(Occupation),"s." )
FROM Occupations
GROUP BY Occupation
ORDER BY COUNT(Occupation)

