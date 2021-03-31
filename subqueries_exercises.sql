USE `employees`;
-- 1. Find ALL the current employees WITH the same hire DATE AS employee 101010 USING a sub-query.
		-- there are 69 current employees with the hiredate of 1990-10-22
SELECT * 
FROM employees 
WHERE `hire_date` IN (
		SELECT hire_date
		FROM `employees`
		WHERE emp_no IN ('101010'));
		
SELECT hire_date -- subquery test getting the hiredate of employee 101010
		FROM `employees`
		WHERE emp_no IN ('101010');		




-- 2. Find ALL the titles ever held BY ALL current employees WITH the FIRST NAME Aamod.
	-- non unique: 168 titles held by AAMODS
	-- unique: 6 titles held by AAMODS

-- select the titles from titles table
-- find Aamod all his titles
-- select emp_no where name is aamod and who still work at company
SELECT title
FROM titles
WHERE emp_no IN
	(
		SELECT `emp_no`
		FROM `employees`
		WHERE first_name LIKE 'aamod' AND to_date > curdate() -- why does this work outside the subquery and inside? 
	) ;

SELECT DISTINCT title
FROM titles
WHERE emp_no IN
	(
		SELECT `emp_no`
		FROM `employees`
		WHERE first_name LIKE 'aamod'
	) AND to_date > curdate();



-- 3. How many people IN the employees TABLE are NO longer working FOR the company? Give the answer IN a COMMENT IN your code.

	-- 59,900 people no longer at company 

-- count emp_no in employees table
-- in WHERE clause compare emp_no to NOT IN the list made below
-- in subquery make list of employees who ARE still working for company

SELECT count(emp_no)
FROM employees
WHERE emp_no NOT IN 
	(
		SELECT `emp_no`
		FROM `dept_emp`
		WHERE to_date > curdate()
	);
	
-- 2,402,124	employees still working
SELECT `emp_no`
FROM `dept_emp`
WHERE to_date > curdate();



-- 4. Find ALL the current department managers that are female. LIST their NAMES IN a COMMENT IN your code.
	-- Female managers -- 
	/* Isamu Legleitner
	Karsten Sigstam
	Leon DasSarma
	Hilary Kambil */

-- select names from employee table
-- where gender is F
-- and in the list of managers

SELECT 
	concat(first_name, ' ', `last_name`)
FROM employees
WHERE gender = 'f'
	AND emp_no IN
	(
		SELECT `emp_no`
		FROM `dept_manager`
		WHERE to_date > now()
	);

-- creates list of current managers
SELECT `emp_no`
FROM `dept_manager`
WHERE to_date > now();




-- 5. Find ALL the employees who currently have a higher salary THAN the companies overall, historical average salary.
	-- 154,543 employees currently have salaries hire than the historical company average 

-- select emp_no from salaires table
-- where to_date (of the salary) is current AND salary is > the average 
-- write query to find the average salary of company

SELECT emp_no, salary
FROM salaries
WHERE to_date > now()
	AND salary > 
	(
		SELECT AVG(salary)
		FROM salaries
	)
ORDER BY salary;


-- query to find avg historical salary of company ($63,810)
SELECT AVG(salary)
FROM salaries;

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can USE a built IN FUNCTION TO calculate the standard deviation.) What percentage of ALL salaries IS this?

	-- 83 current salaries within 1 STD of the MAX current salary
	-- 

-- select count of salaries from salary table
-- where salary is current (to_date > now) AND salary is within 1 standard deviation of highest salary
	-- write query to find standard deviation
	-- write query to find current MAX salary
	
SELECT 
	count(salary)
FROM salaries
WHERE to_date > now()
	AND salary >
	( -- Max salary
	SELECT MAX(salary)
	FROM salaries
	WHERE to_date > now()
	) 
	-  -- max salary - standard deviation
	( -- standard deviation
	SELECT STD(salary)
	FROM salaries
	WHERE to_date > now()
	);
	
	
-- new and improved with my combined standard deviation minus max 
SELECT 
	count(salary)
FROM salaries
WHERE to_date > now()
	AND salary >
	(
		SELECT max(salary) - STD(salary)
		FROM salaries
		WHERE to_date > now()
	);
		
	
-- write query to find current MAX salary	158,220
SELECT MAX(salary)
FROM salaries
WHERE to_date > now();
-- write query to find standard deviation 17,309.96
SELECT STD(salary)
FROM salaries
WHERE to_date > now();

-- combine these two ^^
SELECT max(salary) - STD(salary)
FROM salaries
WHERE to_date > now();

-- % of All salaries in 1 STD of Max = total within 1 std / total salaries 

-- (83 / 240,124) *100 = .03% 

SELECT (
(
	(
	SELECT 
		count(salary)
	FROM salaries
	WHERE to_date > now()
		AND salary >
		(
			SELECT max(salary) - STD(salary)
			FROM salaries
			WHERE to_date > now()
		)
	)
		/
	(
		SELECT count(emp_no)
		FROM salaries
		WHERE to_date > now()
	)
)
* 100
) AS percent_std;
			
				
				
				
SELECT count(emp_no)
FROM salaries
WHERE to_date > now();


 
-- BONUS --

-- 1. Find ALL the department NAMES that currently have female managers.

SELECT d.`dept_name` AS department_name,
CONCAT(e.`first_name`, ' ', e.`last_name`) AS current_manager,
e.gender AS `gender`
FROM `dept_manager` AS dm
JOIN employees AS e ON e.`emp_no` = dm.`emp_no`
JOIN `departments` AS d USING(`dept_no`) -- alternative syntax
WHERE dm.`to_date` LIKE '9999%' 
	AND e.`gender` LIKE 'F';

-- 2. Find the FIRST AND LAST NAME of the employee WITH the highest salary.

-- select first and last name from employees table
SELECT 
Concat(first_name, ' ', last_name),
salaries.salary
-- join to salaries table
FROM employees
JOIN salaries ON salaries.emp_no = employees.emp_no
-- sub query to find max salary
WHERE salary = 
		(
			SELECT MAX(salary)
			FROM salaries
		); 

-- 3. Find the department NAME that the employee WITH the highest salary works in.

-- select first and last name from employees table
SELECT 
Concat(first_name, ' ', last_name) AS Employee_name,
salaries.salary AS salary,
departments.`dept_name` AS department_name
-- join to salaries table
FROM employees
JOIN salaries ON salaries.emp_no = employees.emp_no
JOIN dept_emp ON `dept_emp`.`emp_no` = employees.emp_no
JOIN departments ON departments.`dept_no` = `dept_emp`.dept_no
-- sub query to find max salary
WHERE salary = 
		(
			SELECT MAX(salary)
			FROM salaries
		); 