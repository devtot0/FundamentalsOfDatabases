SELECT last_name
FROM employees e1 JOIN (
	SELECT department_id, AVG(salary) AS avg_dept
	FROM employees
	GROUP BY department_id) AS avg_dept_list
	ON e1.department_id = avg_dept_list.department_id
WHERE salary < avg_dept