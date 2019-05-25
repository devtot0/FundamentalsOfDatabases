SELECT last_name, job_id, salary
FROM employees
WHERE salary > (SELECT MAX(salary)
				FROM employees
				WHERE job_id = 'SA_MAN');