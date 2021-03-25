USE `albums_db`;

SELECT *
FROM albums;

SELECT name
FROM albums
WHERE `release_date` = 1990;

-- the % put for any number of chars before or after depending on where you put it. 
-- use LIKE in similarity searches. very popular
SELECT genre
FROM albums
WHERE genre LIKE '%rock%';

SELECT name
FROM albums
WHERE name LIKE '%at%';

SELECT name
FROM albums
WHERE name LIKE '%the%';

-- end with a
SELECT name
FROM albums
WHERE name LIKE '%a';

-- begin with a
SELECT name
FROM albums
WHERE name LIKE 'a%';

-- IN operator. specific set of search criteria

SELECT * 
FROM albums
Where artist IN ('Michael Jackson', 'Madonna');

USE `chipotle`;

describe orders;

SELECT DISTINCT `item_name`
FROM orders
WHERE `item_name` LIKE '%chicken%';

SELECT *
FROM orders
WHERE `item_name` IN ('Veggie Soft Taco', 'Steak Bowl', 'Crispy Tacos');

USE `join_example_db`;

-- For selecting records that don't have a NULL in a specific column 
SELECT * 
FROM users
WHERE `role_id` IS NOT NULL;

-- For selecting records that DO have a NULL in a specific column

Select *
FROM users
WHERE `role_id` IS NULL;

-- WHERE with AND & OR operators
/* NOT has a higher precedence than AND which has a higher precedence than OR
NOT AND OR
*/

USE chipotle;

-- Return only the records that have Chicken in the name OR are a part of order 10. (returns 1561 records)
SELECT *
FROM orders
WHERE item_name LIKE '%chicken%'
    OR order_id = 10;

/*    
Return only the records that have the name 'Veggie Soft Tacos' AND have order_id 304 or 322
OR any items that have the name 'Crispy Tacos'.
(returns 4 records)
*/
SELECT *
FROM orders
WHERE item_name = 'Veggie Soft Tacos'
    AND order_id IN (304, 322)
    OR item_name = 'Crispy Tacos';
    
/*
The records returned have red in the description AND tacos in the name as well as any records that have soft in the name.
(returns 618 records)
*/
SELECT *
FROM orders
WHERE choice_description LIKE '%red%'
    AND item_name LIKE '%tacos%'
    OR item_name LIKE '%soft%';


