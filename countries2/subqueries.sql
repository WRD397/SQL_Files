							-- S U B Q U E R Y
                            
SELECT local_name, subquery.lang_num
  FROM countries,
  	(SELECT code, COUNT(*) AS lang_num
  	 FROM languages
  	 GROUP BY code) AS subquery
  WHERE countries.code = subquery.code
ORDER BY lang_num DESC;



-- Q2>  	you'll need to get the country names and other 2015 data in the economies table and the countries table for Central American countries with an official language. Select unique country names. Also select the total investment and imports fields. Order by country name ascending.

-- Select fields
SELECT DISTINCT c.name, e.total_investment , e.imports
  -- From table (with alias)
  FROM countries AS c
    -- Join with table (with alias)
    LEFT JOIN economies AS e
      -- Match on code
      ON (c.code = e.code
      -- and code in Subquery
        AND c.code IN (
          SELECT l.code
          FROM languages AS l
          WHERE official = 'true'
        ) )
  -- Where region and year are correct
  WHERE region='Central America' AND e.year = 2015
-- Order by field
ORDER BY c.name;



-- ################# important
-- Q3>	In this exercise, for each of the six continents listed in 2015, you'll identify which country had the maximum inflation rate, and how high it was, using multiple subqueries. The table result of your final query should look something like the following, where anything between < > will be filled in with appropriate values:

-- +------------+---------------+-------------------+
-- | name       | continent     | inflation_rate    |
-- |------------+---------------+-------------------|
-- | <country1> | North America | <max_inflation1>  |
-- | <country2> | Africa        | <max_inflation2>  |
-- | <country3> | Oceania       | <max_inflation3>  |
-- | <country4> | Europe        | <max_inflation4>  |
-- | <country5> | South America | <max_inflation5>  |
-- | <country6> | Asia          | <max_inflation6>  |
-- +------------+---------------+-------------------+
-- Again, there are multiple ways to get to this solution using only joins, but the focus here is on showing you an introduction into advanced subqueries.


-- Select fields
SELECT name, continent, inflation_rate
  -- From countries
  FROM countries
	-- Join to economies
	INNER JOIN economies
	-- Match on code
	ON countries.code = economies.code
  -- Where year is 2015
  WHERE year = 2015
    -- And inflation rate in subquery (alias as subquery)
    AND inflation_rate IN (
        SELECT MAX(inflation_rate) AS max_inf
        FROM (
             SELECT name, continent, inflation_rate
             FROM countries
             INNER JOIN economies
             ON countries.code = economies.code
             WHERE year = 2015) AS subquery
      -- Group by continent
        GROUP BY continent);