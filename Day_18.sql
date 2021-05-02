*/Your are working for a company that wants to reward its 
top 10 customers with a free gift. You have been asked to 
generate a simple report that returns the top 10 customers 
by total amount spent ordered from highest to lowest. 
Total number of payments has also been requested. */

SELECT
  customer.customer_id,
  customer.email,
  COUNT(payment.payment_id) AS payments_count,
  CAST(SUM(payment.amount) AS float) AS total_amount
FROM customer
JOIN payment
  ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY total_amount DESC
LIMIT 10

*/For this challenge you need to create a simple query to 
display each unique clan with their total points and ranked 
by their total points. */

SELECT 
RANK() OVER (ORDER BY SUM(points) DESC) AS rank,
SUM(points) AS total_points,
COUNT(clan) AS total_people,
(CASE WHEN clan = '' THEN '[no clan specified]' ELSE clan END) AS clan
FROM people
GROUP BY clan
ORDER BY total_points DESC

*/Fix query:totaling the number of sales on a given day grouped by 
each department name and then each day. */

SELECT 
  s.transaction_date::DATE AS day,
  d.name AS department,
  COUNT(s.id) AS sale_count
  FROM department AS d
    JOIN sale s on d.id = s.department_id
  GROUP BY day, department
  ORDER BY day ASC

