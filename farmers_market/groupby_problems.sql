select concat(e1.first_name,' ',e1.last_name) 'full_name' 
from employees e1 
where salary > (select SUM(salary)*0.4 
				from employees e2 
                where e1.department_id = e2.department_id);
                

-- get the most and least expensi
SELECT MIN(original_price),max(original_price)
from vendor_inventory vi, product p, product_category pc
where vi.product_id = p.product_id
and p.product_category_id = pc.product_category_id
group by pc.product_category_name;


-- how many diff products each vendors offer
select market_date, vendor_id, count(distinct product_id) as total_count
from vendor_inventory
group by market_date
order by market_date;


-- avg original price of a product per vendor
select vendor_id, product_id, count(distinct product_id) as total__unique_prod, avg(original_price) as avg_price
from vendor_inventory 									-- vendor having a particular product and sell price avg original price
 group by vendor_id product_id
 order by vendor_id;


-- vendor bought atlst 10 items within mentioned date
select vendor_id, sum(quantity) as total_quantity
from vendor_inventory
where market_date between '2019-05-02' and '2019-05-16'
group by vendor_id
having total_quantity >= 100
order by vendor_id