SELECT d1.department_id, d1.department_name, d1.location_id, COUNT(e1.last_name)
FROM departments d1 left join employees e1
ON d1.department_id = e1.department_id
GROUP BY d1.department_id, d1.department_name, d1.location_id