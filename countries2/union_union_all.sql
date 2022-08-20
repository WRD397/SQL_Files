								-- U N I O N

-- TO inlcude all the non duplicates just like set

-- Determine all (non-duplicated) country codes in either the cities or the currencies table. The result should be a table with only one field called country_code.

-- Select field
select country_code
  -- From cities
  from cities
	-- Set theory clause
	union
-- Select field
select code as country_code
  -- From currencies
  from currencies
-- Order by country_code
order by country_code;




								-- 	U N I O N 	A L L


-- to include all the entries including the duplicates we use union all

-- Determine all combinations (include duplicates) of country code and year that exist in either the economies or the populations tables. Order by code then year.
-- The result of the query should only have two columns/fields. Think about how many records this query should result in.

-- Select fields
SELECT code,year
  -- From economies
  FROM economies
	-- Set theory clause
	union all
-- Select fields
SELECT country_code as code, year
  -- From populations
  FROM populations
-- Order by code, year
ORDER BY code, year;