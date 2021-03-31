/*Write a query calculating the amount of error 
(average monthly salaries, zeros removed), 
and round it up to the next integer.*/

SELECT CEIL(AVG(Salary) - AVG(REPLACE(Salary, '0', ''))) 
FROM EMPLOYEES

/*Write a query to find the maximum total earnings for 
all employees as well as the total number of employees 
who have maximum total earnings. Then print these values as  
space-separated integers.*/

SET @amt := 
(SELECT 
MAX(Months*Salary)
FROM Employee);

SELECT @amt, COUNT(*)
FROM Employee
WHERE (Months*Salary) = @amt

/*Query the following two values from the STATION table:
The sum of all values in LAT_N rounded to a scale of  decimal places.
The sum of all values in LONG_W rounded to a scale of  decimal places.*/

SELECT ROUND(SUM(LAT_N),2), ROUND(SUM(LONG_W),2)
FROM STATION
