-- join_exercises.sql

-- 1. USE the join_example_db. SELECT ALL the records FROM BOTH the users AND roles tables.

USE `join_example_db`;
SELECT *
FROM roles;
SELECT * 
FROM users;


-- 2. USE JOIN, LEFT JOIN, AND RIGHT JOIN TO combine results FROM the users AND roles TABLES AS we did IN the lesson. BEFORE you run EACH QUERY, guess the expected number of results.

-- Left join shows all names even if they don't have a role (6 records)
SELECT * 
FROM users AS u
LEFT JOIN roles AS r ON u.`role_id` = r.`id`;

-- Right join, shows all roles and only the people who have roles assigned (4 records)
SELECT * 
FROM users AS u
RIGHT JOIN roles AS r ON u.`role_id` = r.`id`;

SELECT *
FROM roles AS r
LEFT JOIN users AS u ON u.`role_id` = r.`id`; 

-- Inner Join - shows only people who have roles and what roles they have. Does not show people who don't have roles and roles that aren't filled (4 records)
SELECT * 
FROM users AS u
JOIN roles AS r ON u.`role_id` = r.id;

-- JOIN with tables swapped shows same info as above but moved around (4 records)
SELECT *
FROM roles AS r
JOIN users AS u ON r.`id` = u.`role_id`;

-- 3. Although NOT explicitly covered IN the lesson, AGGREGATE functions LIKE count can be used WITH JOIN queries. USE count AND the appropriate JOIN TYPE TO get a LIST of roles along WITH the number of users that has the role. Hint: You will also need TO USE GROUP BY IN the query.

SELECT 
	r.name AS role_name, 
	COUNT(u.`name`) AS number_people_with_role
FROM roles AS r
LEFT JOIN users AS u ON u.`role_id` = r.id
GROUP BY role_name;

-- 1. USE the employees database.

USE `employees`;

-- 2.Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.


-- DEPARTMENT -------- MANAGER.current --
-- department name ----first_name last_name -- 
/* Marketing		Vishwani Minakawa
	Finance	Isamu 	Legleitner
	Human Resources	Karsten Sigstam
	Production		Oscar Ghazalie
	Development		Leon DasSarma
	Quality 			Management	Dung Pesch
	Sales				Hauke Zhang
	Research			Hilary Kambil
	Customer 			Service	Yuchang Weedman */

SELECT d.`dept_name` AS department_name,
CONCAT(e.`first_name`, ' ', e.`last_name`) AS current_manager
FROM `dept_manager` AS dm
JOIN employees AS e ON e.`emp_no` = dm.`emp_no`
JOIN `departments` AS d ON d.`dept_no` = dm.`dept_no`
WHERE dm.`to_date` LIKE '9999%';



-- 3. Find the name of all departments currently managed by women.
	-- Finance, Human Resources, Development and Research are all currently managed by females.
SELECT d.`dept_name` AS department_name,
CONCAT(e.`first_name`, ' ', e.`last_name`) AS current_manager,
e.gender AS `gender`
FROM `dept_manager` AS dm
JOIN employees AS e ON e.`emp_no` = dm.`emp_no`
JOIN `departments` AS d USING(`dept_no`) -- alternative syntax
WHERE dm.`to_date` LIKE '9999%' 
	AND e.`gender` LIKE 'F';


-- 4. Find the current titles of employees currently working in the Customer Service department.
	-- 17,569 people currently working in the customer Service department 
	
	-- 	,de.to_date AS employed_atDepartment, uncomment to check currently employed dates
-- 	t.`to_date` AS employed_atCurrentTitle uncomment to check if currently in title dates

-- name -- title -- department -- date(maybe)

SELECT 
	t.title AS title,
	count(t.title) AS count
FROM titles AS t
JOIN employees AS e USING(emp_no)
JOIN `dept_emp` AS de USING(emp_no)
JOIN departments AS d ON d.dept_no = de.`dept_no`
WHERE d.dept_name = 'Customer Service' 
	AND de.to_date LIKE '9999%' 
	AND t.to_date LIKE '9999%'
GROUP BY t.title;


-- 5. Find the current salary of all current managers.

-- current manager salary -- name -- dept name 

SELECT 
	d.dept_name AS dept_name,
	CONCAT(e.`first_name`, ' ', e.last_name) AS manager_name,
	CONCAT('$',(FORMAT(s.salary, 0))) AS current_manager_salary
FROM dept_manager AS dm
JOIN salaries AS s USING(emp_no)
JOIN employees AS e USING(emp_no)
JOIN departments AS d USING(`dept_no`)
WHERE dm.`to_date` LIKE '9999%' AND s.`to_date` LIKE '9999%'
ORDER BY d.`dept_name`;


-- 6. Find the number of current employees in each department.
/* 	
Customer Service	17569
Development	61386
Finance	12437
Human Resources	12898
Marketing	14842
Production	53304
Quality Management	14546
Research	15441
Sales	37701 */

-- dept_no ---- department ------ number of employees

SELECT 
	d.`dept_no` AS dept_no,
	d.`dept_name` AS department, 
	count(de.emp_no) AS number_of_employees
FROM dept_emp AS de
JOIN departments AS d USING(`dept_no`)
WHERE de.`to_date` LIKE '9999%'
GROUP BY department
ORDER BY d.dept_no;


-- 7. Which department has the highest average salary? Hint: Use current not historic information.

-- dept name -- avg salary

SELECT 
	d.`dept_name` AS dept_name,
	AVG(s.salary) AS avg_salary
FROM salaries AS s  
JOIN `dept_emp` AS de USING(`emp_no`)
JOIN departments AS d ON d.dept_no = de.`dept_no`
WHERE s.`to_date` LIKE '9999%' AND de.`to_date` > curdate()
GROUP BY d.dept_name
ORDER BY avg_salary DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?
-- Akemi	Warwick making $145,128
-- first_name ---`last_name` (-- dept --- salary)

SELECT 
	e.first_name,
	e.last_name
 	,d.`dept_name`,
 	s.`salary`
FROM `employees` AS e
JOIN salaries AS s USING(`emp_no`)
JOIN `dept_emp` AS de USING(`emp_no`)
JOIN departments AS d USING(dept_no)
WHERE d.`dept_name` = 'Marketing' AND s.`to_date` > curdate()
ORDER BY s.`salary` DESC
LIMIT 1;


-- 9. Which current department manager has the highest salary?

SELECT 
	CONCAT(e.`first_name`, ' ', e.`last_name`) AS current_manager,
	s.salary AS salary,
	d.`dept_name` AS department_name
FROM `dept_manager` AS dm
JOIN employees AS e ON e.`emp_no` = dm.`emp_no`
JOIN `departments` AS d ON d.`dept_no` = dm.`dept_no`
JOIN `salaries` AS s ON s.`emp_no` = e.emp_no
WHERE dm.`to_date` LIKE '9999%' AND s.`to_date` LIKE '9999%'
LIMIT 1;


-- 10. Bonus Find the names of all current employees, their department name, and their current manager's name. *still working*

SELECT 
	CONCAT(e.first_name, ' ', e.last_name) AS employee_name, 
	d.dept_name AS department_name
	-- something AS current_manager
FROM `employees` AS e
JOIN `dept_emp` AS de USING (emp_no)
JOIN `dept_manager` AS dm ON e.emp_no = dm.emp_no
		AND dm.to_date > curdate()
JOIN departments AS d ON d.dept_no = de.`dept_no`
WHERE de.to_date > curdate();



-- 11. Bonus Who is the highest paid employee within each department. *still working*
SELECT
	d.`dept_name`,
	e.first_name,
	e.last_name
 	,
 	max(s.`salary`)
FROM `employees` AS e
JOIN salaries AS s USING(`emp_no`)
JOIN `dept_emp` AS de USING(`emp_no`)
JOIN departments AS d USING(dept_no)
WHERE s.`to_date` > curdate()
GROUP BY d.dept_name
ORDER BY s.`salary` DESC 
LIMIT 10;

SELECT 
	d.dept_name,
	s.`salary` AS salary,
	e.first_name,
	e.`last_name` 
FROM `departments` AS d
JOIN dept_emp AS de USING(dept_no)
JOIN `salaries` AS s ON s.emp_no = de.`emp_no`
JOIN `employees` AS e ON e.`emp_no` = s.`emp_no`
GROUP BY d.dept_name;

