WITH hist1 AS (
	SELECT employee_id, MIN(start_date) AS minStDate, COUNT(*) AS chgCount
	FROM job_history
	GROUP BY employee_id),
	 hist2 AS (
	SELECT jh1.employee_id, MIN(start_date) as stDate
	FROM job_history jh1 JOIN hist1
	ON jh1.employee_id = hist1.employee_id
	WHERE chgCount >= 2
	GROUP BY jh1.employee_id)

SELECT * FROM job_history
WHERE employee_id IN (
	SELECT employee_id
	FROM hist2)
AND start_date IN (
	SELECT stDate
	FROM hist2)