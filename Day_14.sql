/*
Write a query to output the names of those students whose best friends 
got offered a higher salary than them. Names must be ordered by the 
salary amount offered to the best friends. It is guaranteed that no 
two students got same salary offer.
*/
SELECT Name
FROM
(SELECT s.ID, s.Name, f.Friend_ID, 
 p.Salary AS S1, p1.Salary AS S2
FROM Students s
JOIN Friends f ON s.id=f.id
JOIN Packages p ON s.id=p.id
JOIN Packages p1 ON f.Friend_ID = p1.id
HAVING S2 > S1
ORDER BY S2) Q1
