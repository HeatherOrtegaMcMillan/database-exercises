-- Practice on Temp Tables

-- here I am reworking through number 3 for temporary tables to see if I can rereate what I originally did. Maybe improve the process a little bit.

-- Find OUT how the current average pay IN EACH department compares TO the overall, historical average pay. IN order TO make the comparison easier, you should USE the Z-score FOR salaries. IN terms of salary, what IS the best department RIGHT now TO WORK FOR? The worst?

USE employees;

-- find historical average and standard deviation
-- query for average of each department
		-- use temp table to store those averages 
-- write query to get z scores

-- experimental query to find department averages
SELECT 
d.dept_name AS dept_name,
AVG(s.salary) AS dept_salary_avg
FROM dept_emp AS de
JOIN `departments` AS d ON d.dept_no = de.`dept_no`
JOIN salaries AS s USING(emp_no)
	WHERE de.to_date > now() AND s.to_date > NOW()
GROUP BY d.dept_name;


-- query to get historical salary averae and standard deviation
SELECT AVG(salaries.salary) AS historical_AVG,
	STDDEV(salaries.salary) AS historical_STDDV
FROM salaries;

USE `florence12`;


-- create temp table to store department averages
CREATE TEMPORARY TABLE dept_avgs_table
SELECT 
d.dept_name AS dept_name,
AVG(s.salary) AS dept_salary_avg
FROM employees.dept_emp AS de
JOIN employees.`departments` AS d ON d.dept_no = de.`dept_no`
JOIN employees.salaries AS s USING(emp_no)
	WHERE de.to_date > now() AND s.to_date > NOW()
GROUP BY d.dept_name;

SELECT * FROM dept_avgs_table;

-- query from employees database and my temp table in florence12 db in order to calculate z scores

SELECT 
	dept_name,
	round(dept_salary_avg, 2) AS dept_salary_avg,
	round((dept_salary_avg - (SELECT AVG(s.salary) FROM employees.salaries AS s)) / (SELECT STDDEV(s.salary) FROM employees.salaries AS s), 4) /* subqueries pulling from employees tables */
	AS z_score
FROM dept_avgs_table AS dat
ORDER BY z_score;


/* 
Output
dept_name					dept_salary_avg	z_score

Human Resources			63921.90			0.0066
Quality Management		65441.99			0.0965
Customer Service		67285.23			0.2055
Development				67657.92			0.2276
Production					67843.30			0.2385
Research					67913.38			0.2427
Finance						78559.94			0.8725
Marketing					80058.85			0.9612
Sales							88852.97			1.4814
*/

-- note about performance, it seems to run fairly quickly. is it better to not run as many subqueries referencing other databases or does it not matter? Is there best practice for structring how you pull your data from wherever it is that is for good performance? 