SELECT EMPL.last_name
FROM employees EMPL
WHERE NOT EXISTS (
		SELECT MGRS_TUPLE_LIST.employee_id
		FROM employees MGRS_TUPLE_LIST
		JOIN (
			SELECT e1.manager_id
			FROM employees e1
			GROUP BY e1.manager_id
			HAVING e1.manager_id IS NOT NULL
			) AS MGRS_ID_LIST ON MGRS_TUPLE_LIST.employee_id = MGRS_ID_LIST.manager_id
			AND EMPL.employee_id = MGRS_TUPLE_LIST.employee_id
		);

SELECT EMPL.last_name
FROM employees EMPL
WHERE EMPL.employee_id NOT IN (
		SELECT MGRS_TUPLE_LIST.employee_id
		FROM employees MGRS_TUPLE_LIST
		JOIN (
			SELECT e1.manager_id
			FROM employees e1
			GROUP BY e1.manager_id
			HAVING e1.manager_id IS NOT NULL
			) AS MGRS_ID_LIST ON MGRS_TUPLE_LIST.employee_id = MGRS_ID_LIST.manager_id
		);