								-- E X C E P T		 

-- The cities table contains information about 236 of the world's most populous cities. The result of your query may surprise you in terms of the number of capital cities that do not appear in this list!

-- Select field
SELECT capital
  -- From countries
  FROM countries
	-- Set theory clause
	EXCEPT
-- Select field
SELECT name
  -- From cities
  FROM cities
-- Order by ascending capital
ORDER BY capital;