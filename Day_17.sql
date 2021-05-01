/* For this challenge you need to create a UNION statement, 
there are two tables ussales and eusales the parent company 
tracks each sale at its respective location in each table, 
you must all filter the sale price so it only returns rows 
with a sale greater than 50.00. You have been tasked with 
combining that data for future analysis. Order by location (US before EU), then by id. */

SELECT 'US' AS location, id, name, 
price, card_name, card_number, transaction_date
FROM ussales
WHERE price > 50.00
UNION ALL
SELECT 'EU' AS location, id, name, 
price, card_name, card_number, transaction_date
FROM eusales
WHERE price > 50.00


/* For this challenge you need to create a simple SELECT statement 
that will return all columns from the people table, and join to the 
sales table so that you can return the COUNT of all sales and 
RANK each person by their sale_count. */

WITH q1 AS
(SELECT people_id,
COUNT(*) AS sale_count 
FROM sales 
GROUP BY people_id )
SELECT p.*, s.sale_count,
RANK() OVER (ORDER BY sale_count) AS sale_rank
FROM people as p
JOIN q1 AS s
ON p.id=s.people_id
