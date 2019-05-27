SELECT e1.last_name, e1.salary, e1.department_id, avgSalDept.avgDept
FROM employees e1
JOIN (
	SELECT department_id, AVG(salary) AS avgDept
	FROM employees
	GROUP BY department_id
	) AS avgSalDept ON e1.department_id = avgSalDept.department_id
WHERE e1.salary > avgDept