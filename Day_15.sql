/*
print the id, age, MIN coins_needed, and power of the wands that Ron's interested in, 
sorted in order of descending power. If more than one wand has same power, 
sort the result in order of descending age.
Wands id, code, coins_needed, power
Wands_Property code, age, is_evil
*/

SELECT w.id, wp.age, w.coins_needed, w.power
FROM Wands AS w
JOIN
    (SELECT code, MIN(coins_needed) AS mc, power
    FROM Wands
    GROUP BY code, power) AS mw
ON mw.code = w.code AND mw.mc = w.coins_needed AND mw.power = w.power
JOIN 
    (SELECT age, code
    FROM Wands_Property
    WHERE is_evil = 0) AS wp
ON wp.code = w.code

ORDER BY w.power DESC, wp.age DESC
