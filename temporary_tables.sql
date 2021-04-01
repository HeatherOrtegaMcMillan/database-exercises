-- 1. USING the example FROM the lesson, CREATE the employees_with_departments table.
USE `florence12`;

CREATE TEMPORARY TABLE employees_with_departments
SELECT employees.employees.emp_no, employees.employees.first_name, employees.employees.last_name, employees.departments.dept_no, employees.departments.dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

		-- a ADD a COLUMN named full_name TO this table. It should be a VARCHAR whose length IS the sum of the lengths of the FIRST NAME AND LAST NAME COLUMNS
		
ALTER TABLE employees_with_departments ADD full_name VARCHAR(31);
SELECT * FROM employees_with_departments;

DESCRIBE employees_with_departments;

		-- b. UPDATE the TABLE so that FULL NAME COLUMN CONTAINS the correct DATA
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

		-- c Remove the first_name AND last_name COLUMNS FROM the table.
ALTER TABLE  employees_with_departments
DROP COLUMN first_name, 
DROP COLUMN last_name;

		-- d. What IS another way you could have ended up WITH this same TABLE?
			-- by putting a CONCAT statment when creating the table and naming that new column full_name
		
CREATE TEMPORARY TABLE employees_with_departments_copy
SELECT employees.employees.emp_no, 
employees.departments.dept_no, 
employees.departments.dept_name,
CONCAT(employees.employees.first_name, ' ', employees.employees.last_name) AS full_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;		
		
SELECT * FROM employees_with_departments_copy;

 
-- 2.a. CREATE a TEMPORARY TABLE based ON the payment TABLE FROM the sakila database.
USE `florence12`;
CREATE TEMPORARY TABLE sakila_payment_temp
SELECT *
FROM sakila.payment;

SELECT * FROM sakila_payment_temp;

DESCRIBE sakila_payment_temp;

-- 2.b. WRITE the SQL necessary TO transform the amount COLUMN such that it IS stored AS an INTEGER representing the number of cents of the payment. FOR example, 1.99 should become 199.
		-- amount is a decimal change to INT
		
ALTER TABLE sakila_payment_temp
ADD COLUMN amount_copy INT;

UPDATE sakila_payment_temp
SET amount_copy = amount * 100;

ALTER TABLE sakila_payment_temp
DROP COLUMN amount;

ALTER TABLE sakila_payment_temp
ADD COLUMN amount INT;

UPDATE sakila_payment_temp
SET amount = amount_copy;

ALTER TABLE sakila_payment_temp
DROP COLUMN amount_copy;


-- 3. Find OUT how the current average pay IN EACH department compares TO the overall, historical average pay. IN order TO make the comparison easier, you should USE the Z-score FOR salaries. 
-- IN terms of salary, what IS the best department RIGHT now TO WORK FOR? The worst?

USE employees;

-- query to find current average salary per department 
SELECT
	de.dept_no,
	AVG(s.salary)
FROM dept_emp AS de 
JOIN salaries AS s USING(emp_no) 
		WHERE s.to_date > now() AND de.`to_date` > now()
GROUP BY de.dept_no
LIMIT 50;

-- query to find historical average salary per department 63810.7448
SELECT AVG(s.`salary`)
FROM salaries AS s;

-- query to find sandard deviation 16904.82828800014
SELECT Stddev(s.salary)
FROM salaries AS s;

-- query both together
SELECT AVG(s.`salary`), Stddev(s.salary)
FROM salaries AS s;




USE `florence12`;

-- Department no -- average per department -- z score (avg per department-avg/stddev)

CREATE TEMPORARY TABLE dept_salary_comp
SELECT
	de.dept_no AS new_dno,
	AVG(s.salary) AS new_ds
FROM employees.dept_emp AS de 
JOIN employees.salaries AS s USING(emp_no) 
		WHERE s.to_date > now() AND de.`to_date` > now()
GROUP BY de.dept_no;

SELECT * FROM dept_salary_comp;
DESCRIBE dept_salary_comp;

-- create temporary table with standard dev and avg
CREATE TEMPORARY TABLE avg_stddv_table
SELECT 
AVG(s.`salary`) AS co_AVG, 
Stddev(s.salary) AS co_STDDV
FROM employees.salaries AS s;

SELECT * FROM avg_stddv_table;

-- create second table to pull stddv from
CREATE TEMPORARY TABLE avg_stddv_table2
SELECT 
AVG(s.`salary`) AS co_AVG, 
Stddev(s.salary) AS co_STDDV
FROM employees.salaries AS s;


-- FINAL QUERY TO GET THE ANSWERS
SELECT 
	new_dno,
	new_ds,
	(new_ds - (SELECT co_AVG FROM avg_stddv_table)) / (SELECT co_STDDV FROM avg_stddv_table2)
		 AS z_score
FROM dept_salary_comp;


-- IMPROVED FINAL QUERY NOT USING MY RANDOM CREATED TABLE
SELECT 
	new_dno,
	new_ds,
	(new_ds - (SELECT AVG(`salary`) FROM employees.salaries)) / (SELECT STDDEV(salary) FROM employees.salaries)
		 AS z_score
FROM dept_salary_comp;