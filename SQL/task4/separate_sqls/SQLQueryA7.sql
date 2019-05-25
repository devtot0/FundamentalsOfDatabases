WITH Summary AS (
	SELECT d1.department_name, SUM(e1.salary) AS dept_total
	FROM departments d1 JOIN employees e1
	ON d1.department_id = e1.department_id
	GROUP BY d1.department_name)
SELECT department_name, dept_total
FROM Summary
WHERE dept_total > (
	SELECT SUM(salary)/8
	FROM employees)