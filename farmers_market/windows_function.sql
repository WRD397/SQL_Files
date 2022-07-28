select *,
sum(cost_to_customer_per_qty) over() as total_cost
from customer_purchases;

-- another
select *,
cost_to_customer_per_qty*quantity as final_cost,
sum(cost_to_customer_per_qty*quantity) over(partition by vendor_id) as total_cost
from customer_purchases;


-- another
select *,
cost_to_customer_per_qty*quantity as final_cost,
row_number() over(partition by vendor_id order by vendor_id) as sequence
from customer_purchases
