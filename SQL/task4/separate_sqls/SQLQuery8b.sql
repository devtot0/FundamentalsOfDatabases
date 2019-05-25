WITH emplTable (department_id, department_name, numOfEmpl) AS (
				  SELECT d1.department_id, d1.department_name, count(e1.last_name) AS numOfEmpl
				  FROM departments d1
				  JOIN employees e1 ON d1.department_id = e1.department_id
				  GROUP BY d1.department_id, d1.department_name
				  )
SELECT department_id, department_name, numOfEmpl
FROM emplTable
WHERE numOfEmpl = (
                  SELECT MIN(numOfEmpl)
				  FROM emplTable
				  );