-- 1. Copy the ORDER BY exercise AND save it AS functions_exercises.sql.

-- 2. WRITE a QUERY TO TO find ALL employees whose LAST NAME STARTS AND ENDS WITH 'E'. USE concat() TO combine their FIRST AND LAST NAME together AS a single COLUMN named full_name.

USE `employees`;
SHOW TABLES;
DESCRIBE employees;
SELECT * FROM employees;

SELECT CONCAT(first_name,' ',last_name) 
AS 'full_name'
FROM employees
WHERE last_name LIKE 'e%e';

-- 3. CONVERT the NAMES produced IN your LAST QUERY TO ALL uppercase.

SELECT Upper(CONCAT(first_name,' ',last_name)) 
AS 'full_name'
FROM employees
WHERE last_name LIKE 'e%e';

-- 4. Find ALL employees hired IN the 90s AND born ON Christmas. USE datediff() FUNCTION TO find how many days they have been working AT the company (Hint: You will also need TO USE NOW() OR CURDATE()),

SELECT 
	CONCAT(first_name, ' ', last_name) AS 'employee_name',
	datediff(CURDATE(), `hire_date`) AS 'days_at_company'
FROM employees
WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%-12-25'
ORDER BY days_at_company DESC;
	

-- 5. Find the smallest AND largest current salary FROM the salaries table. 
-- Smallest: $ 38,623 
-- Largest: $ 158,220

DESCRIBE `salaries`;
SELECT min(salary), max(salary)
FROM salaries;

-- 6. USE your knowledge of built IN SQL functions TO generate a username FOR ALL of the employees. A username should be ALL lowercase, AND consist of the
-- FIRST CHARACTER of the employees FIRST NAME 
-- FIRST 4 characters of the employees LAST NAME, 
-- an underscore, 
-- the MONTH the employee was born, 
-- AND the LAST two digits of the YEAR that they were born

SELECT 
	LOWER(
		CONCAT(
			SUBSTRING(first_name, 1, 1), -- FIRST CHARACTER of the employees FIRST NAME 
			SUBSTRING(last_name, 1, 4), -- FIRST 4 characters of the employees LAST NAME
			'_',                        -- an underscore
			SUBSTRING(birth_date, 6, 2), -- the MONTH the employee was born, 
			SUBSTRING(YEAR(birth_date), 3, 2) -- LAST two digits of the YEAR that they were born
			) 
		) AS 'username',
	first_name,
	last_name,
	birth_date
FROM `employees`
LIMIT 20;

	

	