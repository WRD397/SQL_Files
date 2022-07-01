SELECT * FROM leaders_joining.states;

							-- W I T H 		C L A U S E

-- Lets first calculate the average fert_rate. Then we will subset the table with the states with only fert rate > avg fert rate
-- To do this we are gonna use W I T H 	 C L A U S E 
                           
SELECT AVG(fert_rate) FROM leaders_joining.states; 		-- This will give the avg fert rate

-- Lets subset using WITH CLAUSE

WITH fert_rate_summary(avg_fert_rate) AS 					-- Here, fert_rate_summary is a temporary table sort of thing with all the column mentioned in the bracket after the name of the table. Here the table contain only one column with one numerical value which is average of the fert rate
	(SELECT AVG(fert_rate) FROM leaders_joining.states)		-- This whole thing into the bracket is the query which actually calculate the average.	
SELECT * FROM leaders_joining.states st, fert_rate_summary fr	-- As, we have to take into account both the tables, so we used FROM table named states as well as temporary table named fert rate summary. st and fr are basically the aliases used for the two tables.
WHERE st.fert_rate > fr.avg_fert_rate;							-- Use the condition to subset.






			-- Eg: A bit more tricky example.
			-- Suppose youn gotta return only those records of the continents where the fert rate is greater than avg fert rate of all the continents
            
            
										-- W I T H O U T 	W I T H 	C L A U S E

-- 1> Average fert rate per each continent
SELECT continent, AVG(fert_rate) AS avg_fert_rate_continent
FROM leaders_joining.states st
GROUP BY st.continent;

-- 2> Again average over all the continent fertility rate. ie. this will be the average fert rate of the whole world.
SELECT AVG(avg_fert_rate_continent) AS avg_fert_rate_global
FROM (SELECT continent, AVG(fert_rate) AS avg_fert_rate_continent
		FROM leaders_joining.states st
		GROUP BY st.continent) continent_table ;		-- Here when we are making a table inside FROM clasue then we MUST use an alias for the table in the subquery.
														-- So, the table containing continents and the avg fert rate of those continents is named "continent_table"

-- 3> Now we basically subset the main table for the condition where fert rate is greater than avg_fert_rate_global
SELECT * 
FROM (SELECT continent, AVG(fert_rate) AS avg_fert_rate_continent
		FROM leaders_joining.states st
		GROUP BY st.continent) continent_table           -- We are selecting all the column of continent_table
WHERE continent_table.avg_fert_rate_continent > (SELECT AVG(avg_fert_rate_continent) AS avg_fert_rate_global
													FROM (SELECT continent, AVG(fert_rate) AS avg_fert_rate_continent
															FROM leaders_joining.states st
															GROUP BY st.continent) continent_table);   -- Here we did not need to use any alias for the table containing the global avg value, as this table is used as a single digit value in WHERE clause, NOT as a table in FROM clause.

						-- Or, we can use INNER JOIN ( or just JOIN ) for quering number 3  
SELECT *
FROM (SELECT continent, AVG(fert_rate) AS avg_fert_rate_continent
		FROM leaders_joining.states st
		GROUP BY st.continent) continent_table           -- Again selecting all from the continent_table
INNER JOIN ( SELECT AVG(avg_fert_rate_continent) AS avg_fert_rate_global
				FROM (SELECT continent, AVG(fert_rate) AS avg_fert_rate_continent
					   FROM leaders_joining.states st
					   GROUP BY st.continent) continent_table ) global_table    -- Joining it with the global_table. Here as the table containing the global avg value, is used after INNER JOIN clause as a second table, so, we needed to use an alias for it and we named it "global_table".
ON continent_table.avg_fert_rate_continent > global_table.avg_fert_rate_global;




									-- U S I N G 	W I T H 	C L A U S E
                                    
WITH continent_table(continent, avg_fert_rate_continent) AS
		(SELECT continent, AVG(fert_rate) AS avg_fert_rate_continent
			FROM leaders_joining.states st
			GROUP BY st.continent) , 					-- Here, we basically build the first temporary table "continent_table" with the continents names with their avg fert rate
	 global_table(avg_fert_rate_global) AS
		(SELECT AVG(avg_fert_rate_continent) AS avg_fert_rate_global
			FROM continent_table)						-- Here, we built the second temporary table "global_table" containing  only single column with the avg value of all the continents fert rate
														-- Here, we did not need to use the whole query to create the continent table again, instead just used "FROM continent_table". As, here we already made a temporary table named "continent table" using WITH clause unlike the first case.
SELECT *
	FROM continent_table ct
	JOIN global_table gt
	ON ct.avg_fert_rate_continent > gt.avg_fert_rate_global
    
    
    
    -- *** THUS WE CAN SEE THAT USING WITH CLAUSE WE CAN ACOMPLISH THE WHOLE TASK IN A VERY SHORT SPAN OF SPACE AND CODELINES.***
        