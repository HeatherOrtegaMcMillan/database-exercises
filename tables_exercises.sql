use employees;
select database();
show tables;
describe employees;
-- emp_no seems to be the only numeric type of data in the employee table
-- first_name, last_name, and gender are string types
-- the birth and hire dates are date types
-- salaries table probably has some numeric data types in it (int or doubles depending on how they're storing it)
-- titles table probably has some strings 
describe departments;
-- departments table and employees table don't have any data that overlaps directly from what I cansee, but it seems that the dept_no is referenced in the dept_emp table. where emp_no and dept_no come in contact. employees stores the key for the employee and all their info. and departments is storing the info about the company's departments. 
describe `dept_emp`;
show create table `dept_manager`;
