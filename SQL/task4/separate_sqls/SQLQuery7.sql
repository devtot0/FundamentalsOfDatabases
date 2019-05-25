SELECT d.department_id, d.department_name, d.manager_id, d.location_id
FROM departments d
WHERE d.department_id NOT IN (
SELECT department_id
FROM employees
WHERE job_id='SA_REP' AND department_id IS NOT NULL);