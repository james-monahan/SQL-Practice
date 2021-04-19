/*Write a query to print the respective hacker_id and name of hackers 
who achieved full scores for more than one challenge. Order your output 
in descending order by the total number of challenges in which the hacker 
earned a full score. If more than one hacker received full scores in same 
number of challenges, then sort them by ascending hacker_id.*/

SELECT h.hacker_id, h.name
FROM Submissions AS s
JOIN Challenges AS c
ON c.challenge_id=s.challenge_id
JOIN Difficulty AS d
ON d.difficulty_level=c.difficulty_level
JOIN Hackers as h
ON h.hacker_id=s.hacker_id
WHERE d.score=s.score
GROUP BY h.hacker_id, h.name 
HAVING COUNT(s.challenge_id) > 1
ORDER BY COUNT(s.challenge_id) DESC, h.hacker_id ASC
