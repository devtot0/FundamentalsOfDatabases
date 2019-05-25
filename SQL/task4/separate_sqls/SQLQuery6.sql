SELECT maxAvgSal.department_id, MIN(e1.salary)
FROM (
SELECT TOP 1 d1.department_id, AVG(e1.salary) as avgSal
FROM departments d1 join employees e1
ON d1.department_id = e1.department_id
GROUP BY d1.department_id
ORDER BY avgSal DESC) as maxAvgSal join employees e1
ON maxAvgSal.department_id = e1.department_id
GROUP BY maxAvgSal.department_id