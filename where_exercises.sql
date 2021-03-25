USE employees;
describe `employees`;
-- emp_no int | birth_date date | first_name varchar | last_name var char | gender M or F | hire_date date

-- 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 709 records returned

SELECT *
FROM `employees`
WHERE `first_name` IN ('Irena', 'Vidya', 'Maya');

-- 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. 709 Records Return Does it match number of rows from Q2?

SELECT * 
FROM `employees`
WHERE first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya';

-- 4. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. (180241 Records Returned)

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
		OR gender = 'M';
		
-- 5. Find all current or previous employees whose last name starts with 'E'. (7330 Records Returned)

SELECT *
FROM employees
WHERE last_name LIKE 'e%';

-- 6. Find all current or previous employees whose last name starts or ends with 'E'. (Returns 30723) 

SELECT *
FROM employees
WHERE last_name LIKE 'e%' 
		OR last_name LIKE '%e';	

-- 6b. How many employees have a last name that ends with E, but does not start with E? (30723 - 7330 = 23393)

SELECT *
FROM employees
WHERE last_name NOT LIKE 'e%' 
		AND last_name LIKE '%e';	

/* 7. Find all current or previous employees employees whose last name starts and ends with 'E'. (899 records returned) 
*/

SELECT *
FROM `employees`
WHERE last_name LIKE 'e%'
	AND last_name LIKE '%e';
	
-- 7b. How many employees' last names end with E, regardless of whether they start with E? (24,292)

SELECT *
FROM `employees`
WHERE last_name LIKE '%e';

-- 8. Find all current or previous employees hired in the 90s. (135,214 Records returned)

SELECT *
FROM `employees`
WHERE `hire_date` BETWEEN '1990-01-01' AND '1999-12-31';

-- 9. Find all current or previous employees born on Christmas. (842 records returned)

SELECT *
FROM `employees`
WHERE `birth_date` LIKE '%-12-25';


-- 10. Find all current or previous employees hired in the 90s and born on Christmas. (362 records returned)
SELECT *
FROM `employees`
WHERE `hire_date` BETWEEN '1990-01-01' AND '1999-12-31'
		AND `birth_date` LIKE '%-12-25';

-- 11. Find all current or previous employees with a 'q' in their last name. (1873 reccords returned)
SELECT *
FROM `employees`
WHERE `last_name` LIKE ('%q%');

-- 12. Find all current or previous employees with a 'q' in their last name but not 'qu'. (547 records returned)
SELECT *
FROM `employees`
WHERE `last_name` LIKE '%q%'
		AND last_name NOT LIKE '%qu%';


