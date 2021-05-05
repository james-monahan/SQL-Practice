/* produce a result set for the report that shows a side-by-side 
comparison of the number and total amounts of payments made in 
Mike's and Jon's stores broken down by months. */

SELECT 
EXTRACT(MONTH FROM payment_date) AS month,
COUNT(*) AS total_count,
SUM (amount) AS total_amount,
SUM (CASE WHEN staff_id = 1 THEN 1 ELSE 0 END) AS mike_count,
SUM (CASE WHEN staff_id = 2 THEN 1 ELSE 0 END) AS jon_count,
SUM (CASE WHEN staff_id = 1 THEN amount ELSE 0 END) AS mike_amount,
SUM (CASE WHEN staff_id = 2 THEN amount ELSE 0 END) AS jon_amount
FROM
payment
GROUP BY month
ORDER BY month


/*For this challenge you need to create a simple SELECT statement. 
Your task is to create a query and do a FULL TEXT SEARCH. You must 
search the product table on the field name for the word Awesome and 
return each row with the given word. Your query MUST contain 
to_tsvector and to_tsquery PostgreSQL functions. */

SELECT *
FROM product
WHERE to_tsvector('english', name) @@ to_tsquery('english', 'Awesome')
