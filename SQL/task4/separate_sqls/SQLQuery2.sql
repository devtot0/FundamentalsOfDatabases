SELECT d1.department_name, l1.location_id, e1.last_name, e1.job_id, e1.salary
FROM employees e1 join (departments d1 join locations l1
ON d1.location_id = l1.location_id)
ON e1.department_id = d1.department_id