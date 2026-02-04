-- Question 1
WITH avg_salary AS (
	SELECT department, 
		job_title, 
		ROUND(AVG(base_salary)) AS avg_base_salary
	FROM employee_compensation
	GROUP BY department, 
		job_title
),
ranked_titles AS (
	SELECT department, 
		job_title, 
		avg_base_salary,
	RANK() OVER (
		PARTITION BY department
		ORDER BY avg_base_salary DESC
	) AS rnk
	FROM avg_salary
)

SELECT department, 
	job_title, 
	avg_base_salary
FROM ranked_titles
WHERE rnk = 1
ORDER BY avg_base_salary DESC;


-- Question 2
SELECT job_title, 
    MAX(base_salary) - MIN(base_salary) AS salary_range,
    ROUND(AVG(base_salary)) AS avg_salary,
    ROUND(STDDEV(base_salary)) AS salary_std_dev
FROM employee_compensation
WHERE lower(job_title) = 'data engineer'
GROUP BY job_title;

-- Query to review min & max salary
SELECT job_title,
	MIN(base_salary) AS min_base,
	MAX(base_salary) AS max_salary
FROM employee_compensation
WHERE job_title = 'data engineer'
GROUP BY job_title;
