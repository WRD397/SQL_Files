
-- (INTERVIEW QUESTION)
-- Return the vendor inventory information for only those records where product price was greater than the average product price of a certain date. 													

with base as
	(SELECT market_date, avg(original_price) avg_price_per_date
	FROM farmers_market.vendor_inventory
	GROUP BY market_date)
select * 
from vendor_inventory vi
join base 
on vi.market_date = base.market_date
where vi.original_price > base.avg_price_per_date
order by vi.market_date;


												-- WINDOW FUNCTION
                               
select *
from                                
	(select *,
	avg(original_price) over(partition by market_date) as avg_price_per_date
	from vendor_inventory) temp
where original_price > avg_price_per_date;


-- Fidn the third highest vendor by sales value

select vendor_id, product_id, temp.total_sales,
dense_rank() over (partition by vendor_id order by total_sales desc) as dense_ranker
from 
	(select vendor_id, product_id, sum(quantity) as total_quantity, sum(original_price) as total_price, (sum(quantity)*sum(original_price)) as total_sales
	from vendor_inventory
    group by 1,2
	)temp;


								-- UNBOUNDED PRECEEDING AND UNBOUNDED FOLLOWING
select vendor_id, product_id, temp.total_sales,
SUM(total_sales) over(partition by vendor_id order by total_sales desc) as cumsum
from 
	(select vendor_id, product_id, sum(quantity) as total_quantity, sum(original_price) as total_price, (sum(quantity)*sum(original_price)) as total_sales
	from vendor_inventory
    group by 1,2
	)temp;
							-- LEAD AND LAG 
select vendor_id, product_id, temp.total_sales,
SUM(total_sales) over(partition by vendor_id order by total_sales desc) as cumsum,
LAG(total_sales,1,0) over (partition by vendor_id order by total_sales desc) as lagger
from 
	(select vendor_id, product_id, sum(quantity) as total_quantity, sum(original_price) as total_price, (sum(quantity)*sum(original_price)) as total_sales
	from vendor_inventory
    group by 1,2
	)temp;
    
					-- ************** Percentage increase in the sales (using lagger)
select *, 
case when lagger = 0 then 'N/A'
else ((total_sales - lagger )/ lagger ) * 100
end as sales_percent_inc
from
	(select vendor_id, product_id, temp.total_sales,
	SUM(total_sales) over(partition by vendor_id order by total_sales desc) as cumsum,
	LAG(total_sales,1,0) over (partition by vendor_id order by total_sales desc) as lagger
	from 
		(select vendor_id, product_id, sum(quantity) as total_quantity, sum(original_price) as total_price, (sum(quantity)*sum(original_price)) as total_sales
		from vendor_inventory
		group by 1,2
		)temp)base
        
        
									-- 