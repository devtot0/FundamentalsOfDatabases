DECLARE @StartYear AS INT
DECLARE @EndYear AS INT
DECLARE @CurrentYear AS INT

--Find the year in which the first employee(s) was (were) hired
SELECT @StartYear = MIN(hireYear)
FROM (SELECT MIN(YEAR(start_date)) AS hireYear
	  FROM job_history
	  UNION
	  SELECT MIN(YEAR(hire_date)) AS hireYear
	  FROM employees) as minYear

SET @EndYear = YEAR(GETDATE())
SET @CurrentYear = @StartYear

WHILE (@CurrentYear <= @EndYear)
BEGIN
    SELECT @CurrentYear AS Year, COUNT(*) AS numOfEmpl
	FROM (SELECT hire_date AS hireDate, GETDATE() AS endDate
		  FROM employees
		  UNION
		  SELECT start_date AS hireDate, end_date AS endDate
		  FROM job_history
		 ) AS hireDates
	WHERE @CurrentYear >= YEAR(hireDate) AND @CurrentYear <= YEAR(endDate);

    SET @CurrentYear = @CurrentYear + 1;
END