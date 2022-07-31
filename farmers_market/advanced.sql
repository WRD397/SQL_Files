select *
from
(
select *,
 avg(original_price) over(partition by market_date order by market_date) as avg_price_prod
from vendor_inventory
where vendor_id = 8
)temp
where original_price > temp.avg_price_prod;



-- how many diff prods each vendor brought to market on each date, and displays that copunt on each row.

select *,
count(product_id) over(partition by market_date, vendor_id) count_per_market_date
from vendor_inventory
order by vendor_id, market_date, original_price;



		-- calculate the running total of the cost of items purchasedby each customer , sorted by date and time and the product_id
select 
customer_id, market_date, round(quantity*cost_to_customer_per_qty, 2),
round(sum(quantity*cost_to_customer_per_qty) over (partition by customer_id),2) as dinal_cost_to_cust 
from customer_purchases;


		-- markt manager may want to filter
select * from
(
select
*,
lag(booth_number,1) over(partition by vendor_id order by market_date, vendor_id) as last_booth_assigned
from vendor_booth_assignments
order by market_date, vendor_di, booth_number
)temp
where temp.market_date = '2019-04-10'
and (temp.last_booth_assigned is null or temp.booth_number <> temp.last_booth_assigned);


-- total sales on each market date are higher or lower than they were on the previous market date.

select
market_date,
sum(quantiy*cost_to_customer_per_qty) as total_sales,
lag(sum(quantiy*cost_to_customer_per_qty),1)
over (order by market_date) as previous_day_sales
from customer_purchases
group by market_date;


-- profile of each customer's habits over time. eg: havent viited in last 30 days

select 
*
from
(
select distinct customer_id,
maarket_date
from cusatomer_purchases
where datediff(market_date)
)temp










