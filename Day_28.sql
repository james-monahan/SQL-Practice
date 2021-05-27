/* Write a query that calculates the difference between the highest salaries 
found in the marketing and engineering departments. Output just the difference in salaries */

WITH engineering AS 
(select MAX(dbe.salary) 
from db_employee dbe
JOIN db_dept dbd
ON dbe.department_id=dbd.id
WHERE dbd.department = 'engineering'
GROUP BY dbd.department)
,
marketing AS 
(select MAX(dbe.salary) 
from db_employee dbe
JOIN db_dept dbd
ON dbe.department_id=dbd.id
WHERE dbd.department = 'marketing'
GROUP BY dbd.department)

SELECT ABS(marketing.max - engineering.max)
FROM marketing, engineering;


/* We have a table with employees and their salaries, however, some of the records 
are old and contain outdated salary information. Find the current salary of each 
employee assuming that salaries increase each year. Output their id, first name, 
last name, department ID, and current salary. Order your list by employee ID in ascending order. */

select id, first_name, last_name, department_id, MAX(salary) AS salary
from ms_employee_salary
GROUP BY id, first_name, last_name, department_id
ORDER BY id ASC;


/* Find the total cost of each customer's orders. 
Output customer's id, first name, and the total order cost. 
Order records by customer's first name alphabetically. */

select c.id, c.first_name, SUM(o.order_cost)
from customers AS c
JOIN orders AS o
ON c.id = o.cust_id
GROUP BY c.id, c.first_name
ORDER BY c.first_name;


*/ Find the total AdWords earnings for each business type. Output the business types along with the total earnings. */

select business_type, SUM(adwords_earnings) 
from google_adwords_earnings
GROUP BY 1;


*/ Write a query to find which gender gives a higher 
average review score when writing reviews as guests. 
Use the `from_type` column to identify guest reviews. 
Output the gender and their average review score. */

SELECT g.gender, AVG(r.review_score) AS average
FROM airbnb_reviews r
JOIN airbnb_guests g
on r.from_user=g.guest_id
WHERE r.from_type = 'guest'
GROUP BY g.gender
ORDER BY average DESC
LIMIT 1;
