-- create a simple HAVING statement, you want to count how many people 
-- have the same age and return the groups with 10 or more people who have that age.

SELECT age, COUNT(age) AS total_people
FROM people
GROUP BY age
HAVING COUNT(age) >= 10


-- create a SELECT statement, this SELECT statement will use an 
-- IN to check whether a department has had a sale with a price over 98.00 dollars

SELECT id, name
FROM departments
WHERE id IN (SELECT department_id FROM sales WHERE price > 98.0)

-- create a SELECT statement that will contain data about departments 
-- that had a sale with a price over 98.00 dollars. This SELECT statement 
-- will have to use an EXISTS to achieve the task

SELECT id, name
FROM departments
WHERE EXISTS (SELECT department_id FROM sales 
              WHERE sales.department_id = departments.id
              AND price > 98.00)
