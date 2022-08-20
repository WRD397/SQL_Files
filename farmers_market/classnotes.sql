-- info of the products that are sold at a higher price than the average price on each date.

select *
from (select *, avg(original_price) over (partition by market_date) as avg_cost_prod
	from vendor_inventory
	where vendor_id = 8) sub
where sub.original_price > sub.avg_cost_prod;


-- find the third highest vendor by sales value.
select x.vendor_id,x.product_id, x.total_quantity*x.total_price as sales, dense_rank() over (partition by product_id order by  x.total_quantity*x.total_price desc) as ranker
from (select vendor_id, product_id, sum(quantity) as total_quantity, sum(original_price) as total_price
	from vendor_inventory
    group by 1,2) x;
    -- modification needed...
    

--     
select x.vendor_id,x.product_id, x.total_quantity*x.total_price as sales, dense_rank() over (partition by product_id order by  x.total_quantity*x.total_price desc) as ranker
from (select vendor_id, product_id, sum(quantity) as total_quantity, sum(original_price) as total_price
	from vendor_inventory
    group by 1,2) x;
    
    
-- Find the 2 highest PRODUCT by sales value for every VENDOR: 





select vendor_id, product_id, cast (total_quantity*total_price as INT64) as sales, SUM(CAST(total_quantity*total_price AS INT))
over (partition by vendor_id order by CAST(total_quantity*x.total_price AS INT) desc RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING) as ONE_PRECED 
from (
	select vendor_id,product_id, sum(quantity) as total_quantity, sum(original_price) as total_price
	from vendor_inventory
	WHERE VENDOR_ID =7
	group by 1,2
)x

