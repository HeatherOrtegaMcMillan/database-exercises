# Extra Exercises with WORLD database

USE `world`;
SHOW TABLES;
DESCRIBE country;
SELECT * FROM country;
DESCRIBE city;
SELECT * FROM city;
DESCRIBE `countrylanguage`;
SELECT * FROM countrylanguage;

# What languages are spoken in Santa Monica?
	# find what table santa monica is on - City
	# get language from language table
	# join on country somehow (maybe country code) 
# ------- Santa Monica, California, USA 
# ------- The languages spoken in the USA are as follows (in percentage decending order
			/* English
			Spanish
			French
			German
			Chinese
			Italian
			Tagalog
			Korean
			Polish
			Portuguese
			Vietnamese
			Japanese */
	
SELECT * 
FROM city AS c
JOIN `countrylanguage` AS cl USING(countrycode)
WHERE c.Name LIKE 'santa monica'
ORDER BY `Percentage` DESC; 


# How many different countries are in each region?
	# region ins in the country table
/* 		Micronesia/Caribbean	1
		British Islands	2
		Baltic Countries	3
		Antarctica	5
		North America	5
		Australia and New Zealand	5
		Melanesia	5
		Southern Africa	5
		Northern Africa	7
		Micronesia	7
		Nordic Countries	7
		Central America	8
		Eastern Asia	8
		Central Africa	9
		Western Europe	9
		Polynesia	10
		Eastern Europe	10
		Southeast Asia	11
		Southern and Central Asia	14
		South America	14
		Southern Europe	15
		Western Africa	17
		Middle East	18
		Eastern Africa	20
		Caribbean	24 */
	
SELECT 
region,
COUNT(NAME) AS country_count
FROM country
GROUP BY region
ORDER BY country_count;

# What IS the population FOR EACH region?
/*
		Eastern Asia			1507328000
		Southern AND Central Asia	1490776000
		Southeast Asia		518541000
		South America			345780000
		North America			309632000
		Eastern Europe		307026000
		Eastern Africa		246999000
		Western Africa		221672000
		Middle East			188380700
		Western Europe		183247600
		Northern Africa		173266000
		Southern Europe		144674200
		Central America		135221000
		Central Africa		95652000
		British Islands		63398500
		Southern Africa		46886000
		Caribbean				38140000
		Nordic Countries		24166400
		Australia AND NEW Zealand	22753100
		Baltic Countries		7561900
		Melanesia				6472000
		Polynesia				633050
		Micronesia			543000
		Antarctica				0
		Micronesia/Caribbean	0
*/

SELECT
	region,
	sum(population) AS total_pop
FROM country
GROUP BY region
ORDER BY total_pop DESC;

# What is the population for each continent?
/*
	Asia			3705025700
	Africa			784475000
	Europe			730074600
	North America	482993000
	South America	345780000
	Oceania		30401150
	Antarctica	0
*/

SELECT
	continent,
	sum(population) AS total_pop
FROM country
GROUP BY continent
ORDER BY total_pop DESC;


# What is the average life expectancy globally?
	# 66.48604 years
	
SELECT 
	AVG(`LifeExpectancy`)
FROM country;


# What is the average life expectancy for each region, each continent? Sort the results from shortest to longest
/*
---- average life expectancy by Continent 
	Antarctica	NULL
	Africa	52.57193
	Asia	67.44118
	Oceania	69.71500
	South America	70.94615
	North America	72.99189
	Europe	75.14773
---- average life expectancy by region
	Antarctica	NULL
	Micronesia/Caribbean	NULL
	Southern Africa	44.82000
	Central Africa	50.31111
	Eastern Africa	50.81053
	Western Africa	52.74118
	Southern and Central Asia	61.35000
	Southeast Asia	64.40000
	Northern Africa	65.38571
	Melanesia	67.14000
	Micronesia	68.08571
	Baltic Countries	69.00000
	Eastern Europe	69.93000
	Middle East	70.56667
	Polynesia	70.73333
	South America	70.94615
	Central America	71.02500
	Caribbean	73.05833
	Eastern Asia	75.25000
	North America	75.82000
	Southern Europe	76.52857
	British Islands	77.25000
	Western Europe	78.25556
	Nordic Countries	78.33333
	Australia and New Zealand	78.80000
*/

SELECT
	`Continent`,
	AVG(`LifeExpectancy`) AS average_life
FROM country
GROUP BY `Continent` 
ORDER BY average_life; 


SELECT
	region,
	AVG(`LifeExpectancy`) AS average_life
FROM country
GROUP BY region
ORDER BY average_life; 


# Find all the countries whose local name is different from the official name
	# ---- 135 records returned (some are merely a little bit different or have 'the' in the front) 
SELECT
	`Name`,
	`LocalName`
FROM country
WHERE `Name` != `LocalName`;


# How many countries have a life expectancy less than x?
# I will use 50 for testing here
# to change the value alter the 50

SELECT 
	`Name`,
	`LifeExpectancy`
FROM `country`
WHERE `LifeExpectancy` < 50 #<----- alter this to change the value
ORDER BY `LifeExpectancy` DESC;


# What state (aka district) is city x located in?
# As a placeholder I will be using Rome ('Roma')
	# ---- Roma is in the disctirct named 'Latium' 

SELECT 
	`Name`,
	`District`
FROM city
WHERE `Name` LIKE 'rom%'; #<-- insert city you wish to search for here ('in place of 'rom%')


# What region of the world is city x located in?
# here I am using Roma as an example again
	# ---- Roma is in Sourthern Europe
SELECT 
	city.name AS city,
	country.region AS region
FROM city
JOIN country ON country.Code = city.`CountryCode`
WHERE city.name LIKE 'roma'; #<-- enter city you wish to search for here (where 'roma' is)


# What country (use the human readable name, aka the actual name not the country code) is city x located in?
# Here I am using Roma as an example again
# ---- Roma is located in Italy

SELECT 
	city.name AS city,
	country.name AS country
FROM city
JOIN country ON country.Code = city.`CountryCode`
WHERE city.name LIKE 'roma'; #<-- enter city you wish to search for here (where 'roma' is)

# What is the life expectancy in city x?
# here I am using Roma as an example again
# Life expectancy of the city in this case will be the Life expectancy of the country where city x is located 

SELECT 
	city.name AS city,
	country.LifeExpectancy AS LifeExpectancy
FROM city
JOIN country ON country.Code = city.`CountryCode`
WHERE city.name LIKE 'roma'; #<-- enter city you wish to search for here (where 'roma' is)