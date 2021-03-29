-- # SQL FUNCTIONS
-- ## String Functions
-- Like - Not Like
-- CONCAT(string1, string2, string 3, etc)
-- SUBSTR(subject_string, start)index, number of characters)
-- REPLACE(subjecgt_string, replacement)
-- Case conversion UPPER() LOWER()

SELECT CONCAT('Good Morning ', 'Florence');
USE `chipotle`;
SHOW TABLES;
SELECT * FROM orders;

-- how CONCAT works FOR realzies
-- pull concatenated info put into a custom column name. can combine concats with original data.

SELECT CONCAT(item_name, ': ') AS 'custom_column name', `choice_description` AS 'second_custom_column'
FROM orders;

SELECT CONCAT(item_name, ': ', item_price) FROM orders WHERE item_name LIKE '%bowl%';

-- SUBSTRINGS: SUBSTR 
-- index for substring starts at 1! not 0! #### don't forget about spaces
SELECT SUBSTR('Are you suggesting coconuts migrate', 9, 10); -- suggesting
SELECT SUBSTR('Are you suggesting coconuts migrate', 20, 4); -- coco

-- now for realzies uses
SELECT SUBSTRING(item_name, 10, 5)
FROM orders;


-- REPLACE

SELECT REPLACE('This is a STRING', 'STRING', 'NOT a STRING I am lying');
-- ##########  (The first thing,  thing you want to replace, what you want to replace it with)
-- this is a CASESENSITIVE operation

-- here come the forrealz
SELECT REPLACE(item_name, 'Bowl', 'Unburrito') FROM orders;

-- UPPER/LOWER
SELECT UPPER('yelling');
SELECT lower('HeAtHeR');

SELECT upper(`choice_description`) FROM orders;

-- combining functions, runs inner first, then outer
SELECT UPPER(
CONCAT(item_name, ': ', choice_description))
AS 'new_column_name'
FROM orders;

-- TIME functions
SELECT NOW(); -- These will be changing

SELECT CURTIME();

SELECT CURDATE();

-- you don't pass arguments into these ^^

SELECT unix_timestamp();

-- you CAN pass an arguement into the unix one ^^

SELECT unix_timestamp('2021-03-09 15:01:15');

-- if it's before Jan 1 1970 it will just return 0. before the EPOCH. 
-- also has to be a valid date format

SELECT CONCAT('Data Science Student at Codeup for: ', UNIX_TIMESTAMP() - UNIX_TIMESTAMP('2021-03-15 9:00:00'), ' seconds');
-- OUTPUT: Data Science Student at Codeup for: 1232113 seconds

-- Math functions

SELECT MAX(`quantity`) FROM orders;

SELECT MIN(`quantity`) FROM orders;

SELECT AVG(`quantity`) FROM orders;


-- Casting

SELECT CONCAT('1', ' ham sandwich');

SELECT 
	CAST(123 AS CHAR(2)), -- can add specification here
	CAST('123' AS UNSIGNED);