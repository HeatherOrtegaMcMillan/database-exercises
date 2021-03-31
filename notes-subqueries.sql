USE `join_example_db`;
SELECT * FROM users;
SELECT * FROM roles;

-- subqueries are better use than JOIN when you don't need to see all the data from the other table.

SELECT * FROM users
WHERE role_id IN ( -- this is where the subuery is
		SELECT id
		FROM roles
		WHERE NAME = 'admin'	
		);
		
-- subquery by itself
SELECT id
FROM roles
WHERE NAME = 'admin';

SELECT * FROM users
WHERE role_id IN -- here there is 1 condition
		(
		SELECT id -- there must also only be 1 condition here 
		FROM roles
		WHERE NAME = 'reviewer'	
		);


USE chipotle;


SELECT `item_name`, MAX(`quantity`)
FROM orders
GROUP BY `item_name`; 

-- but I want to see all the details in max order maybe
-- so take the MAX part (the aggrigated part) and put it in a subquery

SELECT *
FROM orders
WHERE quantity = (
		SELECT MAX(quantity)
		FROM orders
		);
-- this pulls only the items that have the MAX quantity value. in this case only one thing sold 15 things at once 

SELECT *
FROM orders
WHERE quantity = (
		SELECT MIN(quantity)
		FROM orders
		);
		
-- this pulls only the items that have the MIN quantity value. which is 1. and there's a big list


