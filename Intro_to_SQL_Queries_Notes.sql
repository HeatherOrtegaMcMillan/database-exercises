-- INTRO to SQL
-- pick the database 
use `fruits_db`;
-- both of these can be used to see what's going on in your table
Describe `fruits`;
Show columns
FROM `fruits`;
-- see everything from the table
SELECT * from `fruits`;
-- DISTINCT will let you pick values that are different
SELECT DISTINCT name
FROM `fruits`;
-- to select multipul rows you sperate them by commas
SELECT
	name,
	quantity
FROM `fruits`;

USE chipotle;
Describe `orders`;
-- proTip, double check result set number to confirm 
SELECT * from `orders`;
SELECT `item_name` from `orders`;
-- this will do a character for character match
SELECT DISTINCT `item_name` from orders;

-- capital letters won't matter so much here
SELECT *
From `orders`
WHERE `item_name` = 'Chicken Bowl';

SELECT *
From `orders`
WHERE item_price = '$4.45'; -- without quotes will produce error. Why? WRONG DATA TYPE! 

SELECT *
From `orders`
Where `id` = 15;

SELECT * from `orders`
WHERE `quantity` BETWEEN 3 and 5;

SELECT * from orders 
WHERE `order_id` > 1500;

SELECT * from `orders`
WHERE `quantity` != 1;

-- Aliases. If you have spaces, gotta use quotes. if not you don't. Use a comma inbetween the coumn names
SELECT 
	`item_name` AS 'Multiple Item Order',
	`quantity` AS Number
FROM `orders`
Where `quantity` >= 2;

