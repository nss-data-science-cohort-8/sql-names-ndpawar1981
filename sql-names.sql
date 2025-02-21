--## SQL Names
--
--Save a script containing the query you used to answer each question.
--
--1. How many rows are in the names table?
select count(*) from names;
-- Answer: There are total 1957046 rows

--2. How many total registered people appear in the dataset?

select sum(num_registered) from names where num_registered is not null and num_registered > 0;
-- Answer: There are total 351,653,025 people registered.

--3. Which name had the most appearances in a single year in the dataset?
select * from names order by num_registered desc limit 1;
-- Answer: Name - "Linda" appeared 99,689 in year 1947

--4. What range of years are included?
select min(year) as Year_FROM,max(year) as TO_YEAR from names;
-- Answer: The range of years is from 1880 and 2018

--5. What year has the largest number of registrations?
select year from names order by num_registered desc limit 1;
-- Answer: Year 1947  has most number of names registered.

--6. How many different (distinct) names are contained in the dataset?
select count(distinct name) from names;
-- Answer: There are total 98,400 distinct names in the dataset.

--7. Are there more males or more females registered?
select gender,count(*) from names group by gender order by count(*) desc limit 1;
-- Answer: There are more females. Total - 1,156,527

--8. What are the most popular male and female names overall (i.e., the most total registrations)?
select name,sum(num_registered) as MAX_POPULAR from names where gender = 'F' group by name order by MAX_POPULAR DESC limit 1;
-- Answer: Female most popular - "Mary"	4,125,675
select name,sum(num_registered) as MAX_POPULAR from names where gender = 'M' group by name order by MAX_POPULAR DESC limit 1;
-- Answer - Male Most popular "James"	5,164,280

--9. What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?
select name,sum(num_registered) as MAX_POPULAR from names where gender = 'F' and year between 2000 and 2009 group by name order by MAX_POPULAR DESC limit 1;
-- Answer: Girl most popular - "Emily"	223,690
select name,sum(num_registered) as MAX_POPULAR from names where gender = 'M' and year between 2000 and 2009 group by name order by MAX_POPULAR DESC limit 1;
-- Answer - Boy Most popular "Jacob"	273,844

--10. Which year had the most variety in names (i.e. had the most distinct names)?
select year,count(distinct name) as count_names from names group by year order by count_names desc limit 1;
-- Answer: Year - 2008	, Distinct names - 32,518

--11. What is the most popular name for a girl that starts with the letter X?
select name,sum(num_registered) as MAX_POPULAR from names where gender = 'F' and name like 'X%' group by name order by MAX_POPULAR DESC ;
-- Answer : Girl name "Ximena" , total regristered - 26,145

--12. Write a query to find all (distinct) names that start with a 'Q' but whose second letter is not 'u'.
select distinct name from names nm WHERE name LIKE 'Q%' AND SUBSTRING(name, 2, 1) <> 'u';
--
--13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.
--
select name,sum(num_registered) as More_popular from names where name in ('Stephen','Steven') group by name order by More_popular desc limit 1;
-- Answer : Stephen is more popular

--14. Find all names that are "unisex" - that is all names that have been used both for boys and for girls.
select distinct n1.name from names n1 where gender = 'M' and exists (select 'x' from names n2 where n2.name = n1.name and n2.gender = 'F');

--Alternative
select name, count(distinct gender) from names group by name having count(distinct gender) > 1;

--15. Find all names that have made an appearance in every single year since 1880.
select distinct name,gender,count(year) as yearCount from names group by name,gender having count(year) >= 139 order by name;

--16. Find all names that have only appeared in one year.
select distinct name,gender,count(year) as yearCount from names group by name,gender having count(year) =1 order by name;

--17. Find all names that only appeared in the 1950s.
select name,gender,min(year),max(year) from names group by name,gender having min(year) >= 1950 and max(year) <= 1959;

--18. Find all names that made their first appearance in the 2010s.
select name,gender,min(year) from names group by name,gender having min(year) = 2010;

--19. Find the names that have not be used in the longest.
select name,gender,max(year) from names group by name,gender order by max(year) ;

--20. Come up with a question that you would like to answer using this dataset. Then write a query to answer this question.
