--Task 4
--1.	Show last names and numbers of all managers together with the number of employees that are his / her subordinates.
SELECT e2.last_name, e2.employee_id, COUNT(*)
FROM employees e1 join employees e2
ON e1.manager_id = e2.employee_id
GROUP BY e2.employee_id, e2.last_name
 
--2.	Create a report that displays the department name, location name, job title and salary of those employees who work in a specific (given) location.
SELECT d1.department_name, l1.location_id, e1.last_name, e1.job_id, e1.salary
FROM employees e1 join (departments d1 join locations l1
ON d1.location_id = l1.location_id)
ON e1.department_id = d1.department_id
 
--3.	Find the number of employees who have a last name that ends with the letter n.
SELECT count(*)
FROM employees
WHERE last_name LIKE '%n'
 
--4.	Create a report that shows the name, location and the number of employees for each department. Make sure that report also includes departments without employees.
SELECT d1.department_id, d1.department_name, d1.location_id, COUNT(e1.last_name)
FROM departments d1 left join employees e1
ON d1.department_id = e1.department_id
GROUP BY d1.department_id, d1.department_name, d1.location_id
 
--5.	Show all employees who were hired in the first five days of the month (before the 6th of the month).
SELECT last_name, hire_date
FROM employees
WHERE DAY(hire_date) < 6
 
--6.	Create a report to display the department number and lowest salary of the department with the highest average salary.
SELECT maxAvgSal.department_id, MIN(e1.salary)
FROM (
	SELECT TOP 1 d1.department_id, AVG(e1.salary) AS avgSal
	FROM departments d1
	JOIN employees e1 ON d1.department_id = e1.department_id
	GROUP BY d1.department_id
	ORDER BY avgSal DESC
	) AS maxAvgSal
JOIN employees e1 ON maxAvgSal.department_id = e1.department_id
GROUP BY maxAvgSal.department_id
 
--7.	Create a report that displays department where no sales representatives work. Include the department number, department name and location in the output.
SELECT d.department_id, d.department_name, d.manager_id, d.location_id
FROM departments d
WHERE d.department_id NOT IN (
SELECT department_id
FROM employees
WHERE job_id='SA_REP' AND department_id IS NOT NULL);
 
--8.	Display the department number, department name and the number of employees for the department:
--a.	with the highest number of employees.
WITH emplTable (department_id, department_name, numOfEmpl)
AS (
	SELECT d1.department_id, d1.department_name, count(e1.last_name) AS numOfEmpl
	FROM departments d1
	JOIN employees e1 ON d1.department_id = e1.department_id
	GROUP BY d1.department_id, d1.department_name
	)
SELECT department_id, department_name, numOfEmpl
FROM emplTable
WHERE numOfEmpl = (
		SELECT MAX(numOfEmpl)
		FROM emplTable
		);
 
--b.	with the lowest number of employees
WITH emplTable (department_id, department_name, numOfEmpl)
AS (
	SELECT d1.department_id, d1.department_name, count(e1.last_name) AS numOfEmpl
	FROM departments d1
	JOIN employees e1 ON d1.department_id = e1.department_id
	GROUP BY d1.department_id, d1.department_name
	)
SELECT department_id, department_name, numOfEmpl
FROM emplTable
WHERE numOfEmpl = (
		SELECT MIN(numOfEmpl)
		FROM emplTable
		);
 
--c.	that employs fewer than three employees.
WITH emplTable (department_id, department_name, numOfEmpl)
AS (
	SELECT d1.department_id, d1.department_name, count(e1.last_name) AS numOfEmpl
	FROM departments d1
	JOIN employees e1 ON d1.department_id = e1.department_id
	GROUP BY d1.department_id, d1.department_name
	)
SELECT department_id, department_name, numOfEmpl
FROM emplTable
WHERE numOfEmpl < 3;
 
--9.	Display years and total numbers of employees that were employed in that year.
DECLARE @StartYear AS INT
DECLARE @EndYear AS INT
DECLARE @CurrentYear AS INT

--Find the year in which the first employee(s) was (were) hired
SELECT @StartYear = MIN(hireYear)
FROM (
	SELECT MIN(YEAR(start_date)) AS hireYear
	FROM job_history
	
	UNION
	
	SELECT MIN(YEAR(hire_date)) AS hireYear
	FROM employees
	) AS minYear

SET @EndYear = YEAR(GETDATE())
SET @CurrentYear = @StartYear

CREATE TABLE #yearsEmployees ([year] INT, [count] INT);

WHILE (@CurrentYear <= @EndYear)
BEGIN
	INSERT INTO #yearsEmployees
	SELECT @CurrentYear AS Year, COUNT(*) AS numOfEmpl
	FROM (
		SELECT hire_date AS hireDate, GETDATE() AS endDate
		FROM employees
		
		UNION
		
		SELECT start_date AS hireDate, end_date AS endDate
		FROM job_history
		) AS hireDates
	WHERE @CurrentYear >= YEAR(hireDate)
		AND @CurrentYear <= YEAR(endDate);

	SET @CurrentYear = @CurrentYear + 1;
END

SELECT *
FROM #yearsEmployees

DROP TABLE #yearsEmployees
  
--10.	Display countries and number of locations in that country.
SELECT country_name, count(l1.country_id)
FROM countries c1 join locations l1
ON c1.country_id = l1.country_id
GROUP BY country_name
 
 
 
 
--Additional exercises
--1A.	Create a query to display the employees who earn a salary that is higher than the salary of all the sales managers (JOB_ID = 'SA_MAN'). Sort the results from the highest to the lowest.
SELECT last_name, job_id, salary
FROM employees
WHERE salary > (SELECT MAX(salary)
		  FROM employees
			  WHERE job_id = 'SA_MAN');
 
--2A.	Display details such as the employee ID, last name, and department ID of those employees who works in cities the names of which begin with 'T'.
SELECT employee_id, last_name, e1.department_id
FROM employees e1
JOIN (
	departments d1 JOIN locations l1 ON d1.location_id = l1.location_id
	) ON e1.department_id = d1.department_id
WHERE l1.city LIKE 'T%'
 
--3A.	Write a query to find all employees who earn more than the average salary in their department.
SELECT e1.last_name, e1.salary, e1.department_id, avgSalDept.avgDept
FROM employees e1
JOIN (SELECT department_id, AVG(salary) AS avgDept
FROM employees
GROUP BY department_id
) AS avgSalDept ON e1.department_id = avgSalDept.department_id
WHERE e1.salary > avgDept
  
--4A.	Find all employees who are not supervisors (managers). Do this using the NOT EXISTS operator.
SELECT EMPL.last_name
FROM employees EMPL
WHERE NOT EXISTS (
		SELECT MGRS_TUPLE_LIST.employee_id
		FROM employees MGRS_TUPLE_LIST
		JOIN (
			SELECT e1.manager_id
			FROM employees e1
			GROUP BY e1.manager_id
			HAVING e1.manager_id IS NOT NULL
			) AS MGRS_ID_LIST ON MGRS_TUPLE_LIST.employee_id = MGRS_ID_LIST.manager_id
			AND EMPL.employee_id = MGRS_TUPLE_LIST.employee_id
		);
         
--Can it be done using NOT IN?

SELECT EMPL.last_name
FROM employees EMPL
WHERE EMPL.employee_id NOT IN (
		SELECT MGRS_TUPLE_LIST.employee_id
		FROM employees MGRS_TUPLE_LIST
		JOIN (
			SELECT e1.manager_id
			FROM employees e1
			GROUP BY e1.manager_id
			HAVING e1.manager_id IS NOT NULL
			) AS MGRS_ID_LIST ON MGRS_TUPLE_LIST.employee_id = MGRS_ID_LIST.manager_id
		);
--The result is the same as above.

--5A.	Display the last names of the employees who earn less than the average salary in their departments.
SELECT last_name
FROM employees e1
JOIN (
	SELECT department_id, AVG(salary) AS avg_dept
	FROM employees
	GROUP BY department_id
	) AS avg_dept_list ON e1.department_id = avg_dept_list.department_id
WHERE salary < avg_dept
       
--6A.	Display the last names of the employees who have one or more co-workers in their departments with later hire dates but higher salaries.
SELECT last_name
FROM (
	SELECT DISTINCT e1.last_name, e1.employee_id
	FROM employees e1
	JOIN employees e2 ON e1.department_id = e2.department_id
	WHERE e2.hire_date > e1.hire_date
		AND e2.salary > e1.salary
	) AS emplCol;
       
--7A.	Display the department names of those departments whose total salary cost is above one-eight (1/8) of the total salary cost of the whole company. Use the WITH clause to write this query. Name the query SUMMARY.
WITH Summary
AS (
	SELECT d1.department_name, SUM(e1.salary) AS dept_total
	FROM departments d1
	JOIN employees e1 ON d1.department_id = e1.department_id
	GROUP BY d1.department_name
	)
SELECT department_name, dept_total
FROM Summary
WHERE dept_total > (
		SELECT SUM(salary) / 8
		FROM employees
		);
 
--8A.	Delete the oldest JOB_HISTORY row of an employee by looking up the JOB_HISTORY table for the MIN(START_DATE) for the employee. Delete the records of only those employees who have changed at least two jobs.
WITH hist1 AS (
	SELECT employee_id, MIN(start_date) AS minStDate, COUNT(*) AS chgCount
	FROM job_history
	GROUP BY employee_id
	),
hist2 AS (
	SELECT jh1.employee_id, MIN(start_date) AS stDate
	FROM job_history jh1
	JOIN hist1 ON jh1.employee_id = hist1.employee_id
	WHERE chgCount >= 2
	GROUP BY jh1.employee_id
	)
SELECT *
FROM job_history
WHERE employee_id IN (
			SELECT employee_id
			FROM hist2
			)
	AND start_date IN (
			SELECT stDate
			FROM hist2
			);