-- SELECT * FROM sql_store.customers;

SELECT CAST(points AS FLOAT) AS points_float, points 
	FROM sql_store.customers
    LIMIT 3;