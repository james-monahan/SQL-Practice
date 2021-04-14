/*
Write a query to print the hacker_id, name, and total score of the hackers ordered 
by the descending score. If more than one hacker achieved the same total score, 
then sort the result by ascending hacker_id. Exclude all hackers with a total score of  from your result.
*/

SELECT hacker_id, name, SUM(Scores)
FROM
(SELECT h.hacker_id, h.name, s.challenge_id, MAX(s.score) AS Scores
FROM
Hackers AS h
JOIN Submissions AS s
ON s.hacker_id=h.hacker_id
GROUP BY h.hacker_id, h.name, s.challenge_id) AS q1
GROUP BY
hacker_id, name
HAVING SUM(Scores) > 0
ORDER BY SUM(Scores) DESC, hacker_id
