USE `albums_db`;
select database();

-- primary Key: Field: id Type: unsigned int
describe `albums`;
-- # of Total Rows: 31
SELECT *
FROM `albums`;
-- unique artist names: 23 (column with Artist name is called "artist")
SELECT DISTINCT artist
FROM `albums`;

-- oldest release date: 1967 (Sgt. Pepper's Lonely Hearts Club Band)
-- recent release date: 2011 (21)
SELECT 
	`release_date`,
	name
FROM `albums`
ORDER BY `release_date`;

-- All Albums by Pink Floyd: The Dark Side of the Moon, & The Wall
SELECT *
FROM `albums`
Where artist = 'Pink Floyd';

-- Year Sgt. Pepper's Lonely Hearts Club Band: 1967
-- Note: use \ before a ' to escape (aka ignore) if it's in the thing you want to search for
SELECT 
	`name`,
	release_date
From albums
Where `name` = "Sgt. Pepper's Lonely Hearts Club Band";


-- Nevermind Genres: Grunge, Alternative Rock
SELECT
	`name`,
	genre
FROM albums
WHERE `name` = 'Nevermind';

/* Albums Released in the 1990s: The Bodyguard	1992
Jagged Little Pill	1995
Come On Over	1997
Falling into You	1996
Let's Talk About Love	1997
Dangerous	1991
The Immaculate Collection	1990
Titanic: Music from the Motion Picture	1997
Metallica	1991
Nevermind	1991
Supernatural	1999 */ 

SELECT 
	`name`,
	release_date
FROM albums
WHERE `release_date` BETWEEN 1990 and 1999;

/* Albums had less than 20mil in sales: Sgt. Pepper's Lonely Hearts Club Band	13.1
Grease: The Original Soundtrack from the Motion Picture	14.4
Abbey Road	14.4
Dangerous	16.3
Nevermind	16.7
The Wall	17.6
Brothers in Arms	17.7
Dirty Dancing	17.9
Titanic: Music from the Motion Picture	18.1
Bad	19.3
Let's Talk About Love	19.3
The Immaculate Collection	19.4
Born in the U.S.A.	19.6 */
SELECT 
	`name`,
	sales
FROM albums
WHERE sales < 20
ORDER BY sales;

/* Albums in the Rock Genre: Sgt. Pepper's Lonely Hearts Club Band, 1, Abbey Road, Born in the U.S.A., Supernatural
Other albums don't show up because WHERE clause only shows you exact matches for what's in the quotes. In order to see "Hard Rock" you would have to type that in for WHERE or use some different clause instructions*/
SELECT
	`name`,
	genre
FROM albums
WHERE genre = 'Rock';

