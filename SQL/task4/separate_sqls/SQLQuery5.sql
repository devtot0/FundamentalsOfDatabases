SELECT last_name, hire_date
FROM employees
WHERE DAY(hire_date) < 6