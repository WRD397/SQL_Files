													-- S E M I 	 J O I N

-- use the concept of a semi-join to identify LANGUAGES  SPOKEN IN MIDDLE EAST.

SELECT DISTINCT name 							-- DISTINCT gives the unique names on the column only.
  FROM languages
-- Where in statement
where code in
  -- Query from step 1
  -- Subquery
  (SELECT code
   FROM countries
   WHERE region = 'Middle East')
-- Order by name
order by name;

						-- Example of SUBQUERIES including S E M I	 J O I N 	and		A N T I  	J O I N 

select c1.name
  -- Alias the table where city name resides
  from cities AS c1
  -- Choose only records matching the result of multiple set theory clauses
  WHERE c1.country_code IN
(
    -- Select appropriate field from economies AS e
    SELECT  DISTINCT e.code
    FROM economies AS e
    -- Get all additional (unique) values of the field from currencies AS c2  
    UNION
    SELECT DISTINCT c2.code
    FROM currencies AS c2
    -- Exclude those appearing in populations AS p
    EXCEPT
    SELECT DISTINCT p.country_code
    FROM populations AS p
    );
