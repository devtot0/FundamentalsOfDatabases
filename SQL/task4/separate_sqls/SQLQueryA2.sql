SELECT employee_id, last_name, e1.department_id
FROM employees e1 join
(departments d1 join locations l1
 ON d1.location_id = l1.location_id)
ON e1.department_id = d1.department_id
WHERE l1.city LIKE 'T%'
