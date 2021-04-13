/*write a query to print the company_code, founder name, 
total number of lead managers, total number of senior managers, 
total number of managers, and total number of employees. 
Order your output by ascending company_code.*/

SELECT 
lea.company_code,
MAX(founder),
COUNT(DISTINCT(lea.lead_manager_code)),
COUNT(DISTINCT(sen.senior_manager_code)),
COUNT(DISTINCT(man.manager_code)),
COUNT(DISTINCT(emp.employee_code))
FROM
COMPANY as com
JOIN Lead_Manager as lea
ON com.company_code=lea.company_code
JOIN Senior_Manager as sen
ON com.company_code=sen.company_code
JOIN Manager as man
ON com.company_code=man.company_code
JOIN Employee as emp
ON com.company_code=emp.company_code
GROUP BY 
com.company_code
ORDER BY 
com.company_code

-- from / where as multi
