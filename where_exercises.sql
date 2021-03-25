USE employees;
describe `employees`;
-- emp_no int | birth_date date | first_name varchar | last_name var char | gender M or F | hire_date date

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 709 records returned

SELECT *
FROM `employees`
WHERE `first_name` IN ('Irena', 'Vidya', 'Maya');

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. 709 Records Return Does it match number of rows from Q2?

SELECT * 
FROM `employees`
WHERE first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya';

-- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. (180241 Records Returned)

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
		OR gender = 'M';
		
-- Find all current or previous employees whose last name starts with 'E'. (7330 Records Returned)

SELECT *
FROM employees
WHERE last_name LIKE 'e%';

-- Find all current or previous employees whose last name starts or ends with 'E'. (Returns 30723) 

SELECT *
FROM employees
WHERE last_name LIKE 'e%' 
		OR last_name LIKE '%e';	

-- How many employees have a last name that ends with E, but does not start with E? (30723 - 7330 = 23393)

SELECT *
FROM employees
WHERE last_name NOT LIKE 'e%' 
		AND last_name LIKE '%e';	

/* Find all current or previous employees employees whose last name starts and ends with 'E'. (889 records returned) 
*/

SELECT *
FROM `employees`
WHERE last_name LIKE 'e%'
	AND last_name LIKE '%e';
	
-- How many employees' last names end with E, regardless of whether they start with E? (24,292)

SELECT *
FROM `employees`
WHERE last_name LIKE '%e';

-- Find all current or previous employees hired in the 90s. (135,214 Records returned)

SELECT *
FROM `employees`
WHERE `hire_date` BETWEEN '1990-01-01' AND '1999-12-31';

-- Find all current or previous employees born on Christmas. (842 records returned)

SELECT *
FROM `employees`
WHERE `birth_date` LIKE '%-12-25';


-- Find all current or previous employees hired in the 90s and born on Christmas. (362 records returned)
SELECT *
FROM `employees`
WHERE `hire_date` BETWEEN '1990-01-01' AND '1999-12-31'
		AND `birth_date` LIKE '%-12-25';

-- Find all current or previous employees with a 'q' in their last name. (1873 reccords returned)
SELECT *
FROM `employees`
WHERE `last_name` LIKE ('%q%');

-- Find all current or previous employees with a 'q' in their last name but not 'qu'. (547 records returned)
SELECT *
FROM `employees`
WHERE `last_name` LIKE '%q%'
		AND last_name NOT LIKE '%qu%';


