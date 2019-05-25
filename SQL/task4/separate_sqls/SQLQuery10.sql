SELECT country_name, count(l1.country_id)
FROM countries c1 join locations l1
ON c1.country_id = l1.country_id
GROUP BY country_name