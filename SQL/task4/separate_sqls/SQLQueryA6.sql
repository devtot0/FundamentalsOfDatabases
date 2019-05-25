SELECT last_name
FROM (
SELECT DISTINCT e1.last_name, e1.employee_id
FROM employees e1 JOIN employees e2
ON e1.department_id = e2.department_id
WHERE e2.hire_date > e1.hire_date AND e2.salary > e1.salary
) AS emplCol;