/* SQL Statistics: MIN, MEDIAN, MAX */

SELECT MIN(score), MAX(score),
  PERCENTILE_CONT(0.5) 
  WITHIN GROUP (ORDER BY score) 
  AS median
FROM result



/* For this challenge you need to create a VIEW. This VIEW is used by a sales 
store to give out vouches to members who have spent over $1000 in departments 
that have brought in more than $10000 total ordered by the members id. 
The VIEW must be called members_approved_for_voucher then you must create a 
SELECT query using the view. */

CREATE OR REPLACE VIEW members_approved_for_voucher AS 
SELECT 
p.price, m.name, m.email, m.id
FROM sales AS s
JOIN members AS m
on m.id=s.member_id
JOIN products as p
ON p.id=s.product_id
WHERE s.department_id IN (SELECT s.department_id 
                          FROM sales AS s
                          JOIN products AS p
                          ON p.id=s.product_id
                          GROUP BY s.department_id
                          HAVING SUM(p.price) > 10000)

;

SELECT id, name, email, SUM(price) AS total_spending
FROM members_approved_for_voucher
GROUP BY id, name, email
HAVING SUM(price)>1000
ORDER BY id
