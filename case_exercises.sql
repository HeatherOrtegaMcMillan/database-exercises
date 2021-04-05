-- Case Exercises
-- 1. WRITE a QUERY that RETURNS ALL employees (emp_no), their department number, their START DATE, their END DATE, AND a NEW COLUMN 'is_current_employee' that IS a 1 IF the employee IS still WITH the company AND 0 IF not.
USE employees;
SELECT  
	e.emp_no	AS emp_no,
	de.dept_no	AS dept_no,
	e.hire_date 	AS start_date,
	ced.max AS end_date, -- BE CAREFUL FOR DUPLICATE VALUES
		IF(ced.max > curdate(), TRUE, FALSE)
		AS is_current_employee
FROM employees AS e
JOIN dept_emp AS de USING(emp_no)
JOIN florence12.cur_emp_dates AS ced USING(emp_no);

USE `florence12`;
CREATE TEMPORARY TABLE cur_emp_dates
SELECT emp_no, 
MAX(to_date) AS max
FROM employees.dept_emp
GROUP BY emp_no;


DROP TABLE cur_emp_dates;

SELECT * FROM cur_emp_dates;

-- #### notes on how to filter out duplicates ####
/* to_date IS 9999 = current 
	to_date IS NOT 9999 
	hire_date != from_date   */
-- hire_date = from_date AND to_date IS NOT 9999 = other
 
 
-- people who have duplicate values in the emp_no table
SELECT 
emp_no,
count(*) AS count
FROM 
dept_emp
GROUP BY emp_no
HAVING count > 1;


SELECT * FROM dept_emp
LIMIT 50; -- 331603
SELECT * FROM employees; -- 300024

SELECT * FROM dept_emp
WHERE emp_no = 10040;
 



-- 2. WRITE a QUERY that RETURNS ALL employee NAMES (previous AND current), AND a NEW COLUMN 'alpha_group' that RETURNS 'A-H', 'I-Q', OR 'R-Z' depending ON the FIRST letter of their LAST name.
DESCRIBE employees;
SELECT 
	first_name,
	last_name,
	CASE
		WHEN last_name BETWEEN 'a%' AND 'hz%' THEN 'A-H'
		WHEN last_name BETWEEN 'i%' AND 'qz%' THEN 'I-Q'
		WHEN last_name BETWEEN 'r%' AND 'zz%' THEN 'R-Z'
		ELSE 'other'
	END AS alpha_group
FROM employees;

-- 3. How many employees (current OR previous) were born IN EACH decade?
	-- Born in 50s: 182,886
	-- Born in 60s: 117,138

SELECT min(birth_date) FROM employees; -- earliest born 1952
SELECT max(birth_date) FROM employees; -- latest born 1965

SELECT 
	CASE 
		WHEN birth_date LIKE '195%' THEN 'born in 50s'
		WHEN birth_date LIKE '196%' THEN 'born in 60s'
		ELSE 'weirdo'
		END AS decade_born,
	count(*) AS 'count'
FROM employees
GROUP BY decade_born;
