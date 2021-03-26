/*Pivot the Occupation column in OCCUPATIONS so that each Name is sorted 
alphabetically and displayed underneath its corresponding Occupation. 
The output column headers should be Doctor, Professor, Singer, and Actor, respectively.*/

--solution 1, but need remove null
SELECT *
FROM
(SELECT 
    (CASE WHEN Occupation = "Doctor" THEN Name END) AS Doctor,
    (CASE WHEN Occupation = "Professor" THEN Name END) AS Professor, 
    (CASE WHEN Occupation = "Singer" THEN Name END) AS Singer,
    (CASE WHEN Occupation = "Actor" THEN Name END) AS Actor 
FROM Occupations
ORDER BY Name) AS A

--solution 2, then do a join
SELECT DISTINCT(Doctor), 1 AS Value
FROM
(SELECT 
    (CASE WHEN Occupation = "Doctor" THEN Name END) AS Doctor
FROM Occupations
ORDER BY Name) A
WHERE Doctor IS NOT NULL
ORDER BY Doctor
OUTER JOIN
