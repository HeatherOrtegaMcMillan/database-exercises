-- GROUP BY NOTES
USE `titanic_db`;
DESCRIBE `passengers`;
SELECT * FROM passengers
LIMIT 	10;

SELECT DISTINCT class  
FROM passengers; 

-- does the same thing as above but with GROUP BY

SELECT class
FROM passengers
GROUP BY class;

-- group by two things. there are females from first class, males from first class, etc
SELECT sex, class
FROM passengers
GROUP BY sex, class;

-- COUNT look at nubmer of rows that have a unique value
-- this function counts all non null values in a column

SELECT sex, COUNT(*) AS number_of_passengers
FROM passengers
GROUP BY sex;

-- how COUNT works with NULL values
SELECT 
	deck,
	count(deck) AS 'non-NULL-VALUES',
	count(*) AS 'all_rows'
	FROM passengers
	GROUP BY deck; 
	
-- look at number of rows for each unique combination of values in multiple columns?
SELECT 
	sex, -- first dimension
	class, -- sub dimension
	count(*) AS passenger_count -- aggregate functions (aka extra columns with more data)
FROM passengers
GROUP BY sex, class;

-- 
