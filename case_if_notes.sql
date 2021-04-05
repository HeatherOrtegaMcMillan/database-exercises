-- NOTES FROM CASE WHEN / IF LECTURE


-- Use a `CASE` statement to create bins or buckets called item_type using item names.
-- will run through each condition and when one is true it will stop and go to the next record
USE chipotle;
SELECT 
    item_name,
    CASE
        WHEN item_name LIKE '%chicken%' THEN 'Chicken Item'
        WHEN item_name LIKE '%veggie%' THEN 'Veggie Item'
        WHEN item_name LIKE '%beef%' THEN 'Beef Item'
        WHEN item_name LIKE '%barbacoa%' 
            OR item_name LIKE '%carnitas%' 
            OR item_name LIKE '%steak%' THEN 'Specialty Item'       
        WHEN item_name LIKE '%chips%' THEN 'Side'
        ELSE 'Other'. -- use an else clause as a catch all or maybe an error check
        END AS item_type
FROM orders;


-- THIS IS SO HELPFUL!! 
SELECT 
    CASE
        WHEN item_name LIKE '%chicken%' THEN 'Chicken Item'
        WHEN item_name LIKE '%veggie%' THEN 'Veggie Item'
        WHEN item_name LIKE '%beef%' THEN 'Beef Item'
        WHEN item_name LIKE '%barbacoa%' 
            OR item_name LIKE '%carnitas%' 
            OR item_name LIKE '%steak%' THEN 'Specialty Item'       
        WHEN item_name LIKE '%chips%' THEN 'Side'
        ELSE 'Other'
        END AS item_type,
    COUNT(*) AS count_of_records
FROM orders
GROUP BY item_type
ORDER BY count_of_records DESC;

-- count(*) counts the number of ROWS returned BY your query
-- count(*) with a group by gives a count for each group by result


-- adding a filter of 'specialty item' use HAVING, and don't forget to add a comma and a second filter in the group by clause. 
SELECT 
	item_name,
    CASE
        WHEN item_name LIKE '%chicken%' THEN 'Chicken Item'
        WHEN item_name LIKE '%veggie%' THEN 'Veggie Item'
        WHEN item_name LIKE '%beef%' THEN 'Beef Item'
        WHEN item_name LIKE '%barbacoa%' 
            OR item_name LIKE '%carnitas%' 
            OR item_name LIKE '%steak%' THEN 'Specialty Item'       
        WHEN item_name LIKE '%chips%' THEN 'Side'
        ELSE 'Other'
        END AS item_type,
    COUNT(*) AS count_of_records
FROM orders
GROUP BY item_type, item_name -- don't forget to add all the ones you want, will sort by columns that aren't selected as well
HAVING item_type = 'Specialty Item'
ORDER BY count_of_records DESC;


-- Create buckets for quantity to create a new categorical variable.
SELECT
    item_name,
    CASE
        WHEN quantity = 1 THEN 'single_item'
        WHEN quantity BETWEEN 2 AND 5 THEN 'family_and_friends'
        WHEN quantity BETWEEN 6 AND 9 THEN 'small_gathering'
        WHEN quantity > 9 THEN 'party'
        ELSE 'other'
        END AS quant_cats
FROM orders;

-- THIS!!! Add a GROUP BY Clause to Zoom Out and take a look at my new categorical variables quant_cats
SELECT
    COUNT(*) AS count_of_records,
    CASE
        WHEN quantity = 1 THEN 'single_item'
        WHEN quantity BETWEEN 2 AND 5 THEN 'family_and_friends'
        WHEN quantity BETWEEN 6 AND 9 THEN 'small_gathering'
        WHEN quantity > 9 THEN 'party'
        ELSE 'other'
        END AS quant_cats
FROM orders
GROUP BY quant_cats
ORDER BY count_of_records DESC;

-- Zoom Out by adding a Group By Clause and a COUNT() function.

USE `mall_customers`;
SELECT
    CASE
        WHEN gender = 'Male' AND age < 20 THEN 'Teen Male'
        WHEN gender = 'Male' AND age < 30 THEN 'Twenties Male'
        WHEN gender = 'Male' AND age < 40 THEN 'Thirties Male'
        WHEN gender = 'Male' AND age < 50 THEN 'Forties Male'
        WHEN gender = 'Male' AND age < 60 THEN 'Fifties Male'
        WHEN gender = 'Male' AND age < 70 THEN 'Sixties Male'
        WHEN gender = 'Male' AND age >= 70 THEN 'Older Male'
        WHEN gender = 'Female' AND age < 20 THEN 'Teen Female'
        WHEN gender = 'Female' AND age < 30 THEN 'Twenties Female'
        WHEN gender = 'Female' AND age < 40 THEN 'Thirties Female'
        WHEN gender = 'Female' AND age < 50 THEN 'Forties Female'
        WHEN gender = 'Female' AND age < 60 THEN 'Fifties Female'
        WHEN gender = 'Female' AND age < 70 THEN 'Sixties Female'
        WHEN gender = 'Female' AND age >= 70 THEN 'Older Female'
        ELSE 'Other'
        END AS gen_age_cat,
    COUNT(*) AS count_of_customers
FROM customers
-- WHERE gender = 'Female' # can add filter here 
GROUP BY gen_age_cat
ORDER BY count_of_customers DESC;


-- this 
-- Use an IF Function to create a dummy variable for gender.
SELECT
    gender,
    IF(gender = 'Female', TRUE, FALSE) AS is_female
FROM customers;

-- and this, give similar results
-- I can create this new boolean column in another simple way, just evaulate the equality statement to True or False.
SELECT
    gender,
    gender = 'Female' AS is_female
FROM customers;
