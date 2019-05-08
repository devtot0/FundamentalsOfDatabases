--0.	Use test_empl schema: Run test_empl_schema.sql script to create the database and tables. Then run test_empl_data.sql to populate this database with data.
 
--1.	Get names and salaries of employees.
SELECT name, salary
FROM employees;
 
--2.	Get names and daily salaries of employees.
SELECT name, salary/30
FROM employees;
 
--3.	Get names and yearly salaries of employees.
SELECT name, salary*12
FROM employees;
 
--4.	Get the minimal salary in the table employees.
SELECT MIN(salary)
FROM employees;
 
--5.	Get the name, job, and salary of the employee with the smallest salary.
SELECT name, job, salary
FROM employees
WHERE salary = (
			   SELECT MIN(salary)
			   FROM employees
			   );
 
--6.	Get names, jobs and salaries of employees who earn less than the average salary in the enterprise.
SELECT name, job, salary
FROM employees
WHERE salary < (
		 SELECT AVG(salary)
		 FROM employees
		 );
 
--7.	For each department get the number of employees.
SELECT id_dep, COUNT(*)
FROM employees
GROUP BY id_dep;
 
--8.	For each department and for each job get the number of employees.
ORDER BY is optional here, but makes the results easier to read.
SELECT id_dep, job, COUNT(*)
FROM employees
GROUP BY id_dep, job
ORDER BY id_dep;
 
--9.	Get names and salaries of employees who earn more than any employee working in department 30.
SELECT name, salary
FROM employees
WHERE salary > (
		 SELECT MAX(salary)
		 FROM employees
		 WHERE id_dep = 30
		 );
 
--10.	For every employee get his name, salary and the difference between his salary and the average salary in the enterprise.
SELECT name, salary, salary - (
		SELECT AVG(salary)
		FROM employees
		)
FROM employees;