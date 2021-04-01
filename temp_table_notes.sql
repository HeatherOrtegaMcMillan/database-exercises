-- Tempoar Tables

-- to use temp tables for exercises we will be using our own database
USE `florence12`;

-- to run a query on a different table you have to provide a fully qualified path. basically the full address

SELECT employees.`employees`.first_name, 
`employees`.employees.last_name, 
employees.salaries.salary
FROM employees.salaries
JOIN employees.employees USING (emp_no)
WHERE to_date > curdate();

-- to create a temp table, with the following command and a name

CREATE TEMPORARY TABLE current_salary
SELECT employees.`employees`.first_name, 
`employees`.employees.last_name, 
employees.salaries.salary
FROM employees.salaries
JOIN employees.employees USING (emp_no)
WHERE to_date > curdate();

-- this temp table will be gone when you close sql pro

-- updating table structure: UPDATE "table name" SET "however you want to manipulate" ex n = n + 1

-- in this example 5% raise to every employee
UPDATE current_salary SET salary = salary + salary * .05;

SELECT * FROM current_salary;


-- you can join temp tables with either other temp tables or with tables that already exist. use full path address

