*/Timmy works for a statistical analysis company and has been given 
a task of calculating the highest average salary for a given job, 
the sample is compiled of 100 applicants each with a job and a salary. 
Timmy must display each unique job, the total average salary, the 
total people and the total salary and order by highest average salary.*/

SELECT 
  j.job_title,
  ROUND(AVG(j.salary),2)::FLOAT as average_salary,
  COUNT(j.people_id) as total_people,
  ROUND(SUM(j.salary),2)::FLOAT as total_salary
  FROM people p
    JOIN job j
    ON j.people_id = p.id
  GROUP BY j.job_title
  ORDER BY average_salary DESC
  
  
  */For this challenge you need to create a SELECT statement, 
  this SELECT statement will use an IN to check whether a department 
  has had a sale with a price over 90.00 dollars BUT the sql MUST 
  use the WITH statement which will be used to select all columns 
  from sales where the price is greater than 90.00, you must call 
  this sub-query special_sales./*
  
WITH special_sales AS
(SELECT department_id
FROM sales
WHERE price > 90)
SELECT id, name 
FROM departments
WHERE id IN (SELECT department_id FROM special_sales)
