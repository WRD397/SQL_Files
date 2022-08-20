											-- INTERSECT

-- As you think about major world cities and their corresponding country, you may ask which countries also have a city with the same name as their country name?\

-- Select fields
select code, name
  -- From countries
  from countries
	-- Set theory clause
intersect
-- Select fields
select country_code as code, name
  -- From cities
  from cities;
