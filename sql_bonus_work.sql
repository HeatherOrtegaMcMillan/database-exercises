-- ## Bonus Questions ## -- 

-- 1. How much do the current managers of each department get paid, relative to the average salary for the department? here will operate under assumption that it is current average salary for department
-- IS there ANY department WHERE the department manager gets paid LESS THAN the average salary?

USE employees;

-- find average salary per department 
	
SELECT 
d.dept_name AS dept_name,
AVG(s.salary) AS average_salary
FROM salaries AS s
JOIN dept_emp AS de USING(`emp_no`)
JOIN departments AS d ON d.`dept_no` = de.`dept_no`
WHERE s.to_date > now() AND de.to_date > now()
GROUP BY d.dept_name;
	

 
-- find salaries of all CURRENT managers

SELECT 
d.dept_name AS dept_name,
s.salary AS mngr_salary
FROM salaries AS s
JOIN dept_manager AS dm USING (`emp_no`)
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE dm.to_date > now() AND s.to_date > now();



-- compare, maybe use temp table? 

USE `florence12`;
CREATE TEMPORARY TABLE DepartmentAvgs
SELECT 
d.dept_name AS dept_name,
AVG(s.salary) AS average_salary
FROM employees.salaries AS s
JOIN employees.dept_emp AS de USING(`emp_no`)
JOIN employees.departments AS d ON d.`dept_no` = de.`dept_no`
WHERE s.to_date > now() AND de.to_date > now()
GROUP BY d.dept_name;

SELECT * FROM DepartmentAvgs;

CREATE TEMPORARY TABLE ManagerSalaries
SELECT 
d.dept_name AS dept_name,
s.salary AS mngr_salary
FROM employees.salaries AS s
JOIN employees.dept_manager AS dm USING (`emp_no`)
JOIN employees.departments AS d ON d.dept_no = dm.dept_no
WHERE dm.to_date > now() AND s.to_date > now();

SELECT * FROM ManagerSalaries;



