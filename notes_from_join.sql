USE `join_example_db`;

-- Default Join is Inner Join
	-- inner joines filter out nulls from the joined tables
	-- so if someone doesn't have (in this case) a role in the compnay, they won't be in the new join table
	-- inner join = intersection 
SELECT *
FROM users
JOIN roles ON users.`role_id` = roles.id;

SELECT *
FROM roles
JOIN users ON roles. `id` = users.`role_id`;

-- Left Join
	-- give all records from table A even if there's no relation
SELECT *
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

-- Right Join
	-- give all records from table B  (can flip flop table A to get same result)
SELECT *
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

