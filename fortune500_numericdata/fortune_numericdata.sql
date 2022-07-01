			-- T r u n c a t i n g  numeric values 
            
SELECT truncate(42.356,2);  -- This will truncate a the decimal values to  2 values
SELECT truncate(253645,-3);  -- This will turn last 3 diigits into 0

SELECT * FROM fortune500_numericdata.fortune;
SELECT truncate(employees, -4) AS employee_bin,
       -- Count number of companies with each truncated value
       count(*)
  FROM fortune500_numericdata.fortune
  WHERE employees < 100000
 -- Use alias to group
  GROUP BY employee_bin
--  Use alias to order
--  ORDER BY employee_bin;