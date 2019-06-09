--Task 3
USE HR;
--1.	Determine the structure of all database's tables.
-- PDF Only

--2.	Display names and salaries of employees.
SELECT first_name, last_name, salary
FROM employees;
   
--3.	Display the last name and salary of employees earning more than $12,000.
SELECT last_name, salary
FROM employees
WHERE salary>12000;
 
--4.	Display the last name and department number for employee number 176.
SELECT last_name, department_id
FROM employees
WHERE employee_id = 176;
 
--5.	Display the last name and salary for all employees whose salary is not in the range of $5,000 to $12,000.
SELECT last_name, salary
FROM employees
WHERE NOT(salary<=12000 AND salary>=5000);
     
--6.	Display the last name, job ID, and start date (hire date) for the employees with the last names of Matos and Taylor. Order the query in ascending order by start date.
SELECT last_name, job_id, hire_date
FROM employees
WHERE last_name='Matos' OR last_name='Taylor'
ORDER BY hire_date; 
  
--7.	Display the last name and department number of all employees in departments 20 or 50 in ascending alphabetical order by name.
SELECT last_name, department_id
FROM employees
WHERE department_id=20 OR department_id=50
ORDER BY last_name;
     
--8.	Display the last name and job title of all employees who do not have a manager.
SELECT last_name, job_title
FROM employees JOIN jobs
ON employees.job_id = jobs.job_id
WHERE manager_id IS NULL;
 
--9.	Display the last name, salary, and commission for all employees who earn commissions. Sort data in descending order of salary and commissions.
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC; 
   
--10.	Find the highest, lowest, sum, and average salary of all employees. Label the columns Maximum, Minimum, Sum, and Average, respectively.
SELECT MAX(salary) AS Maximum,
	MIN(salary) AS Minimum,
	SUM(salary) AS Sum,
	AVG(salary) AS Average
FROM employees;
  
--11.	Modify the previous query to display the minimum, maximum, sum, and average salary for each job type (job_id).
SELECT job_id,
	MAX(salary) AS Maximum,
	MIN(salary) AS Minimum,
	SUM(salary) AS Sum,
	AVG(salary) AS Average
FROM employees
GROUP BY job_id;
 
--12.	Display the number of people with the same job.
SELECT job_id, count(job_id)
FROM employees
GROUP BY job_id;
 
--13.	Determine the number of managers without listing them. Label the column Number of Managers. Hint: Use the MANAGER_ID column to determine the number of managers.
SELECT COUNT(DISTINCT manager_id) AS 'Number of Managers'
FROM employees;
  
--14.	Find the difference between the highest and lowest salaries. Label the column DIFFERENCE.
SELECT MAX(salary) - MIN(salary)
FROM employees; 
  
--15.	Find the addresses of all the departments. Use the LOCATIONS and COUNTRIES tables. Show the location ID, street address, city, state or province, and country in the output.
SELECT location_id, street_address, city, state_province, country_name
FROM locations JOIN countries
ON locations.country_id = countries.country_id;
 
--16.	Display the last name and department name for all employees.
SELECT last_name, department_name
FROM employees JOIN departments
ON employees.department_id = departments.department_id;
           
--17.	Display the last name, job, department number, and department name for all employees who work in Toronto.
SELECT last_name, e.job_id, e.department_id, department_name
FROM employees AS e
	JOIN (departments AS d
		  JOIN locations AS l
		  ON d.location_id = l.location_id)
	ON e.department_id = d.department_id
	JOIN jobs AS j
	ON e.job_id = j.job_id
WHERE city='Toronto';
 
 
 

--Additional exercises
--1A.	Create a report to display the manager number and the salary of the lowest-paid employee for that manager. Exclude and groups where the minimum salary is $6000 or less. Sort the output in descending order of salary.
SELECT manager_id, MIN(salary) AS MinSalary
FROM employees
GROUP BY manager_id
HAVING MIN(salary) > 6000 AND manager_id IS NOT NULL
ORDER BY MinSalary DESC;
 
--2A.	The HR department wants to determine the names of all employees who were hired after Davies. Create a query to display the name and hire date of any employee hired after employee Davies.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date > (
		    SELECT hire_date
		    FROM employees
		    WHERE last_name = 'Davies'
		    );
   
--3A.	The HR department needs to find the names and hire dates for all employees who were hired before their managers, along with their managers' names and hire dates.
SELECT e1.first_name, e1.last_name, e1.hire_date, e2.first_name as ManagerFirstName, e2.last_name as ManagerLastName, e2.hire_date as ManagerHireDate
FROM employees e1
	JOIN employees e2
	ON e1.manager_id = e2.employee_id
WHERE e1.hire_date < e2.hire_date;
 
--4A.	Create a report that displays the employee number, last name, and salary of all employees who earn more than the average salary. Sort the results in order of ascending salary.
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (
		SELECT AVG(salary)
		FROM employees
		)
ORDER BY salary; 

--5A.	Write a query that displays the employee number and last name of all employees who work in a department with any employee whose last name starts with "U".
SELECT DISTINCT e1.employee_id, e1.last_name
FROM employees e1 JOIN employees e2
ON e1.department_id = e2.department_id
WHERE e2.last_name LIKE 'U%';
 
--6A.	Create a report for HR that displays the last name and salary of every employee who reports to King.
SELECT e1.last_name, e1.salary
FROM employees e1 JOIN employees e2
ON e1.manager_id = e2.employee_id
WHERE e2.last_name = 'King';
 
--7A.	For budgeting purposes, the HR department needs a report on projected 10% raises. The report should display those employees who have no commissions.
SELECT 'The salary of ' + last_name + ' after a 10% raise is ' + CAST(salary*1.1 AS CHAR) AS 'New salary'
FROM employees
WHERE commission_pct IS NULL;