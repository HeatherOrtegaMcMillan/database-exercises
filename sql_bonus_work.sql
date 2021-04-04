-- ## Bonus Questions ## -- 

-- 1. How much do the current managers of each department get paid, relative to the average salary for the department? here will operate under assumption that it is current average salary for department

/* 
Department			MngrSlry		deptavgslry
Marketing			106,491		80058.8488
Sales					101,987		88852.9695
Finance				83,457		78559.9370
Research				79,393		67913.3750
Development			74,510		67657.9196
Qt Management		72,876		65441.9934
Human Resources	65,400		63921.8998
Customer Service	58,745		67285.2302
Production			56,654		67843.3020 */


-- IS there ANY department WHERE the department manager gets paid LESS THAN the average salary? 
	-- Yes. Production department manager gets paid $56,654 and the average is $67,843.30
	-- and Customer Service department manager gets paid $58,745 and the avg is $67,285.23

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


-- compare, maybe use temp table? This did not work super well.

USE `florence12`;
CREATE TEMPORARY TABLE DepartmentAvgs
SELECT 
	d.dept_no AS dept_no, 
	d.dept_name AS dept_name,
	AVG(s.salary) AS average_salary,
FROM employees.salaries AS s
JOIN employees.dept_emp AS de USING(`emp_no`)
JOIN employees.departments AS d ON d.`dept_no` = de.`dept_no`
WHERE s.to_date > now() AND de.to_date > now()
GROUP BY d.dept_name;

SELECT * FROM DepartmentAvgs;
DESCRIBE DepartmentAvgs;
 

/* CREATE TEMPORARY TABLE ManagerSalaries
SELECT 
d.dept_name AS dept_name,
s.salary AS mngr_salary
FROM employees.salaries AS s
JOIN employees.dept_manager AS dm USING (`emp_no`)
JOIN employees.departments AS d ON d.dept_no = dm.dept_no
WHERE dm.to_date > now() AND s.to_date > now();

SELECT * FROM ManagerSalaries; */

USE employees;


-- in this part I want to try and make a tiny temp table inside my join statement that has the department number and average salary. 
-- outer query is selecting the department and it's current manager. then I join with subquery to the averages, maybe
-- THIS ONE WORKS!! 
 
SELECT 
	d.dept_name AS dept_name,
	s.salary AS mngr_salary,
	dept_avgs.average_salary AS avg_dept_salary
FROM salaries AS s
JOIN dept_manager AS dm USING (`emp_no`)
JOIN departments AS d ON d.dept_no = dm.dept_no
JOIN (
			SELECT 
			de.dept_no AS dept_no, 
			AVG(s.salary) AS average_salary
			FROM salaries AS s
			JOIN dept_emp AS de USING(`emp_no`)
			WHERE s.to_date > now() AND de.to_date > now()
			GROUP BY de.dept_no
		) AS dept_avgs ON dept_avgs.dept_no = d.dept_no
WHERE dm.to_date > now() AND s.to_date > now()
ORDER BY mngr_salary DESC;


