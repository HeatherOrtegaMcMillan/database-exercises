-- 1. Create a new file named group_by_exercises.sql

-- 2. IN your script, USE DISTINCT TO find the UNIQUE titles IN the titles table. How many UNIQUE titles have there ever been? Answer that IN a COMMENT IN your SQL file.
-- 7 unique titles
	/* 
	Senior Engineer
	Staff
	Engineer
	Senior Staff
	Assistant Engineer
	Technique Leader
	Manager 
	*/
USE `employees`;
DESCRIBE `titles`;

SELECT DISTINCT title
FROM titles;

-- 3. WRITE a QUERY TO TO find a LIST of ALL UNIQUE LAST NAMES of ALL employees that START AND END WITH 'E' USING GROUP BY.
	-- 5 records returned

SELECT last_name
FROM `employees`
WHERE last_name LIKE 'e%e'
GROUP BY last_name; 

-- 4. WRITE a QUERY TO TO find ALL UNIQUE combinations of FIRST AND LAST NAMES of ALL employees whose LAST NAMES START AND END WITH 'E'.
	-- 846 records returned

SELECT last_name, first_name
FROM `employees`
WHERE last_name LIKE 'e%e'
GROUP BY last_name, first_name;

-- 5. WRITE a QUERY TO find the UNIQUE LAST NAMES WITH a 'q' but NOT 'qu'. Include those NAMES IN a COMMENT IN your SQL code.
	-- Chleq
	-- Lindqvist
	-- Qiwen

SELECT last_name
FROM `employees`
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

-- 6. ADD a COUNT() TO your results (the QUERY above) AND USE ORDER BY TO make it easier TO find employees whose unusual NAME IS shared WITH others.

SELECT last_name, first_name,
count(*) AS employee_count
FROM `employees`
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name, first_name
ORDER BY count(*) DESC, last_name;

-- 7. Find ALL ALL employees WITH FIRST NAMES 'Irena', 'Vidya', OR 'Maya'. USE COUNT(*) AND GROUP BY TO find the number of employees FOR EACH gender WITH those names.
 	-- Irena	M	144
	-- Irena	F	97
	-- Maya	M	146
	-- Maya	F	90
	-- Vidya	M	151
	-- Vidya	F	81

SELECT first_name,
	gender,
	count(*)
FROM `employees`
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender;


-- 8. USING your QUERY that generates a username FOR ALL of the employees, generate a count employees FOR EACH UNIQUE username. Are there ANY DUPLICATE usernames? BONUS: How many DUPLICATE usernames are there?

	-- there are 285,872 unique usernames.
	-- there are 13,251 dplicated usernames

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
	count(*) AS count
FROM `employees` 
GROUP BY username
HAVING count > 1 
ORDER BY count desc;