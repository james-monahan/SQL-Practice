/*Write a query to print the hacker_id, name, and the total number of 
challenges created by each student. Sort your results by the total 
number of challenges in descending order. If more than one student 
created the same number of challenges, then sort the result by hacker_id. 
If more than one student created the same number of challenges and the count 
is less than the maximum number of challenges created, then exclude those students from the result.*/


SELECT c.hacker_id, h.name ,count(c.hacker_id) as cnt
FROM Challenges AS c
JOIN Hackers AS h
ON h.hacker_id=c.hacker_id
GROUP BY c.hacker_id, h.name
HAVING  cnt = (SELECT COUNT(c1.challenge_id) 
             FROM Challenges AS c1 
             GROUP BY c1.hacker_id 
             ORDER BY COUNT(*) DESC LIMIT 1)
OR cnt in
            (SELECT s.icnt
            FROM
                (SELECT COUNT(*) AS icnt
                FROM Challenges 
                GROUP BY hacker_id) AS s
            GROUP BY s.icnt
            HAVING COUNT(s.icnt)=1)
ORDER BY cnt DESC, c.hacker_id
