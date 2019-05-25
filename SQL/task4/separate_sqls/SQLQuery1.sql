SELECT e2.last_name, e2.employee_id, COUNT(*)
FROM employees e1 join employees e2
ON e1.manager_id = e2.employee_id
GROUP BY e2.employee_id, e2.last_name