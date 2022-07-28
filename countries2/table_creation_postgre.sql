							-- CREATING A NEW TABLE FROM A EXISTING TABLE.
                            -- ( this method is for PostGre SQL only )
                            
-- first we simply categorize the population size of the countries as large medium amnd small.
SELECT country_code, size,
  CASE WHEN size > 50000000
            THEN 'large'
       WHEN size > 1000000
            THEN 'medium'
       ELSE 'small' END
       AS popsize_group
INTO 'pop_plus'                        -- Thus we basically store the 'select' columns into a new table called pop_plus.   

FROM populations
WHERE year = 2015; -- we just focused on a single year - 2015;


select * from pop_plus