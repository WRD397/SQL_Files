-- self join is just a form of inner join. its used to match one column with another column of the same table.
-- So, basically all the countries in the same continent will  get paired up
select p1.country as country1, p2.country as country2, p1.continent
from prime_ministers p1
inner join prime_ministers p2
on p1.continent = p2.continent and p1.country <> p2.country;


						-- Calculationg		 P O P U L A T I O N 	G R O W T H
                        
                        -- In this exercise, you'll use the populations table to perform a self-join to calculate the percentage increase in population from 2010 to 2015 for each country code!
SELECT p1.country_code,
       p1.size AS size2010, 
       p2.size AS size2015,
       -- Calculate growth_perc
       ((p2.size - p1.size)/p1.size) * 100.0 AS growth_perc
FROM populations AS p1
  INNER JOIN populations AS p2
    ON p1.country_code = p2.country_code
        AND p1.year = p2.year-5