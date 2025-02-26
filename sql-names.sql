--## SQL Names
--
--Save a script containing the query you used to answer each question.
--
--1. How many rows are in the names table?
SELECT
	COUNT(*)
FROM
	NAMES;

-- Answer: There are total 1957046 rows
--2. How many total registered people appear in the dataset?
SELECT
	SUM(NUM_REGISTERED)
FROM
	NAMES
WHERE
	NUM_REGISTERED IS NOT NULL
	AND NUM_REGISTERED > 0;

-- Answer: There are total 351,653,025 people registered.
--3. Which name had the most appearances in a single year in the dataset?
SELECT
	*
FROM
	NAMES
ORDER BY
	NUM_REGISTERED DESC
LIMIT
	5;

-- Answer: Name - "Linda" appeared 99,689 in year 1947
--4. What range of years are included?
SELECT
	MIN(YEAR) AS YEAR_FROM,
	MAX(YEAR) AS TO_YEAR
FROM
	NAMES;

-- Answer: The range of years is from 1880 and 2018
--5. What year has the largest number of registrations?
SELECT
	YEAR,
	SUM(NUM_REGISTERED) AS NUM_REGITERED
FROM
	NAMES
GROUP BY
	YEAR
ORDER BY
	NUM_REGITERED DESC
LIMIT
	10;

-- Answer: Year 1947  has most number of names registered.
--6. How many different (distinct) names are contained in the dataset?
SELECT
	COUNT(DISTINCT NAME)
FROM
	NAMES;

-- Answer: There are total 98,400 distinct names in the dataset.
--7. Are there more males or more females registered?
SELECT
	GENDER,
	SUM(NUM_REGISTERED)
FROM
	NAMES
GROUP BY
	GENDER
ORDER BY
	SUM(NUM_REGISTERED) DESC
LIMIT
	1;

-- Answer: There are more females. Total - 1,156,527
--8. What are the most popular male and female names overall (i.e., the most total registrations)?
SELECT
	NAME,
	SUM(NUM_REGISTERED) AS MAX_POPULAR
FROM
	NAMES
WHERE
	GENDER = 'F'
GROUP BY
	NAME
ORDER BY
	MAX_POPULAR DESC
LIMIT
	1;

-- Answer: Female most popular - "Mary"	4,125,675
SELECT
	NAME,
	SUM(NUM_REGISTERED) AS MAX_POPULAR
FROM
	NAMES
WHERE
	GENDER = 'M'
GROUP BY
	NAME
ORDER BY
	MAX_POPULAR DESC
LIMIT
	1;

-- Answer - Male Most popular "James"	5,164,280
SELECT
	*
FROM
	(
		SELECT
			NAME,
			SUM(NUM_REGISTERED) AS MAX_POPULAR
		FROM
			NAMES
		WHERE
			GENDER = 'F'
		GROUP BY
			NAME
		ORDER BY
			MAX_POPULAR DESC
		LIMIT
			1
	)
UNION
SELECT
	*
FROM
	(
		SELECT
			NAME,
			SUM(NUM_REGISTERED) AS MAX_POPULAR
		FROM
			NAMES
		WHERE
			GENDER = 'M'
		GROUP BY
			NAME
		ORDER BY
			MAX_POPULAR DESC
		LIMIT
			1
	);

SELECT DISTINCT
	ON (GENDER) NAME,
	GENDER,
	SUM(NUM_REGISTERED)
FROM
	NAMES
GROUP BY
	NAME,
	GENDER
ORDER BY
	GENDER,
	SUM(NUM_REGISTERED) DESC;

--9. What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?
SELECT
	NAME,
	SUM(NUM_REGISTERED) AS MAX_POPULAR
FROM
	NAMES
WHERE
	GENDER = 'F'
	AND YEAR BETWEEN 2000 AND 2009
GROUP BY
	NAME
ORDER BY
	MAX_POPULAR DESC
LIMIT
	1;

-- Answer: Girl most popular - "Emily"	223,690
SELECT
	NAME,
	SUM(NUM_REGISTERED) AS MAX_POPULAR
FROM
	NAMES
WHERE
	GENDER = 'M'
	AND YEAR BETWEEN 2000 AND 2009
GROUP BY
	NAME
ORDER BY
	MAX_POPULAR DESC
LIMIT
	1;

-- Answer - Boy Most popular "Jacob"	273,844
SELECT DISTINCT
	ON (GENDER) NAME,
	GENDER,
	SUM(NUM_REGISTERED)
FROM
	NAMES
WHERE
	YEAR BETWEEN 2000 AND 2009
GROUP BY
	NAME,
	GENDER
ORDER BY
	GENDER,
	SUM(NUM_REGISTERED) DESC;

--10. Which year had the most variety in names (i.e. had the most distinct names)?
SELECT
	YEAR,
	COUNT(DISTINCT NAME) AS COUNT_NAMES
FROM
	NAMES
GROUP BY
	YEAR
ORDER BY
	COUNT_NAMES DESC
LIMIT
	1;

-- Answer: Year - 2008	, Distinct names - 32,518
--11. What is the most popular name for a girl that starts with the letter X?
SELECT
	NAME,
	SUM(NUM_REGISTERED) AS MAX_POPULAR
FROM
	NAMES
WHERE
	GENDER = 'F'
	AND NAME LIKE 'X%'
GROUP BY
	NAME
ORDER BY
	MAX_POPULAR DESC;

-- Answer : Girl name "Ximena" , total regristered - 26,145
SELECT DISTINCT
	ON (GENDER) NAME,
	GENDER,
	SUM(NUM_REGISTERED)
FROM
	NAMES
WHERE
	GENDER = 'F'
	AND NAME LIKE 'X%'
GROUP BY
	NAME,
	GENDER
ORDER BY
	GENDER,
	SUM(NUM_REGISTERED) DESC;

--12. Write a query to find all (distinct) names that start with a 'Q' but whose second letter is not 'u'.
SELECT DISTINCT
	NAME
FROM
	NAMES NM
WHERE
	NAME LIKE 'Q%'
	AND SUBSTRING(NAME, 2, 1) <> 'u';

--
--13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.
--
SELECT
	NAME,
	SUM(NUM_REGISTERED) AS MORE_POPULAR
FROM
	NAMES
WHERE
	NAME IN ('Stephen', 'Steven')
GROUP BY
	NAME
ORDER BY
	MORE_POPULAR DESC
LIMIT
	1;

-- Answer : Stephen is more popular
--14. Find all names that are "unisex" - that is all names that have been used both for boys and for girls.
SELECT DISTINCT
	N1.NAME
FROM
	NAMES N1
WHERE
	GENDER = 'M'
	AND EXISTS (
		SELECT
			'x'
		FROM
			NAMES N2
		WHERE
			N2.NAME = N1.NAME
			AND N2.GENDER = 'F'
	);

--Alternative
SELECT
	NAME,
	COUNT(DISTINCT GENDER)
FROM
	NAMES
GROUP BY
	NAME
HAVING
	COUNT(DISTINCT GENDER) > 1;

--15. Find all names that have made an appearance in every single year since 1880.
SELECT DISTINCT
	NAME
FROM
	NAMES
GROUP BY
	NAME
HAVING
	COUNT(DISTINCT YEAR) >= 139
ORDER BY
	NAME;

--16. Find all names that have only appeared in one year.
SELECT DISTINCT
	NAME,
	GENDER,
	COUNT(YEAR) AS YEARCOUNT
FROM
	NAMES
GROUP BY
	NAME,
	GENDER
HAVING
	COUNT(YEAR) = 1
ORDER BY
	NAME;

--17. Find all names that only appeared in the 1950s.
SELECT
	NAME,
	GENDER,
	MIN(YEAR),
	MAX(YEAR)
FROM
	NAMES
GROUP BY
	NAME,
	GENDER
HAVING
	MIN(YEAR) >= 1950
	AND MAX(YEAR) <= 1959;

--18. Find all names that made their first appearance in the 2010s.
SELECT
	NAME,
	GENDER,
	MIN(YEAR)
FROM
	NAMES
GROUP BY
	NAME,
	GENDER
HAVING
	MIN(YEAR) = 2010;

--19. Find the names that have not be used in the longest.
SELECT
	NAME,
	GENDER,
	MAX(YEAR)
FROM
	NAMES
GROUP BY
	NAME,
	GENDER
ORDER BY
	MAX(YEAR);

--20. Come up with a question that you would like to answer using this dataset. Then write a query to answer this question.
SELECT
	*
FROM
	NAMES;