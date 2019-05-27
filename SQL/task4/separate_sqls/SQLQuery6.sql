SELECT maxAvgSal.department_id, MIN(e1.salary)
FROM (
	SELECT TOP 1 d1.department_id, AVG(e1.salary) AS avgSal
	FROM departments d1
	JOIN employees e1 ON d1.department_id = e1.department_id
	GROUP BY d1.department_id
	ORDER BY avgSal DESC
	) AS maxAvgSal
JOIN employees e1 ON maxAvgSal.department_id = e1.department_id
GROUP BY maxAvgSal.department_id