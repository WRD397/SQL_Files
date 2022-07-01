
			-- C H A N G I N G 		C O L U M N  	 N A M E
ALTER TABLE monarchs
RENAME COLUMN ï»¿country TO country;

ALTER TABLE presidents
RENAME COLUMN ï»¿country TO country;

SELECT * FROM leaders_joining.monarchs;
SELECT * FROM leaders_joining.presidents;


				-- I N N E R 	J O I N
SELECT * FROM presidents;
SELECT * FROM prime_ministers;

SELECT p1.continent, p1.country, president, prime_minister
	FROM prime_ministers AS p1 
    INNER JOIN presidents AS p2
    ON p1.country = p2.country;

-- lest try to inner join other way around...
SELECT p2.continent, p2.country, president, prime_minister
	FROM presidents AS p2 
    INNER JOIN prime_ministers AS p1
    ON p1.country = p2.country;
-- basically just the common field values will be included in the resultant table.


				
                -- I N N E R 	J O I N 	U S I N G 	USE
                



