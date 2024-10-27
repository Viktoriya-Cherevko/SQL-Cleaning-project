select * from car_orders;
select * from customers;

-- create a table car_orders_cleaned (never use raw table)
create table car_orders_cleaned
Like car_orders;

Select *
FROM car_orders_cleaned;

-- copy data to the table
INSERT car_orders_cleaned
SELECT *
FROM car_orders;

-- cleaning data

-- trim and replace '_' 
select trim(replace(product, '_', ''))
from car_orders_cleaned;

update car_orders_cleaned set product = trim(replace(product, '_', ''));

-- create a table customers_cleaned (never use raw table)
create table customers_cleaned
Like customers;

Select *
FROM customers_cleaned;

-- copy data to the table
INSERT customers_cleaned
SELECT *
FROM customers;

-- clean first name and last name
select trim(replace(first_name, '/', '')), trim(upper(last_name))
from customers_cleaned;

update customers_cleaned
set
first_name = trim(replace(first_name, '/', '')),
last_name = trim(upper(last_name));

-- delete column that we don't need
alter table customers_cleaned
drop customer_address;

-- delete rows where the country value is null or empty
delete from customers_cleaned
where country is null
or country = '';

-- how many cars of different type were sold
select product, sum(quantity)
from car_orders_cleaned
group by product;

-- table that shows purchases in different countries
select order_id, product, country
from car_orders_cleaned
join customers_cleaned
on car_orders_cleaned.customer_id = customers_cleaned.customer_id
order by country;

-- table that shows how much money was spent by every customer, empty gender filled in with 'no data' value
select customers_cleaned.customer_id, first_name, last_name, coalesce(nullif(gender, ''), 'no data') as gender, total_order
from customers_cleaned
left join 
(select car_orders_cleaned.customer_id, sum(quantity*price) as total_order
from car_orders_cleaned
group by customer_id) as total_orders
on customers_cleaned.customer_id = total_orders.customer_id
order by total_order desc;

-- rolling sum - total orders
select a.order_id, customers_cleaned.customer_id, first_name, last_name, total_order,
sum(total_order) over(order by a.order_id) as sum_all_orders
from car_orders_cleaned a
join 
(select order_id, car_orders_cleaned.customer_id, order_date, quantity*price as total_order
from car_orders_cleaned) as total_orders
on a.order_id = total_orders.order_id
left join customers_cleaned
on customers_cleaned.customer_id = a.customer_id
order by a.order_id;


-- rolling sum - total orders by customer
select a.order_id, customers_cleaned.customer_id, first_name, last_name, total_order,
sum(total_order) over(partition by a.customer_id order by a.order_id) as total_order_customer
from car_orders_cleaned a
join 
(select order_id, car_orders_cleaned.customer_id, order_date, quantity*price as total_order
from car_orders_cleaned) as total_orders
on a.order_id = total_orders.order_id
left join customers_cleaned
on customers_cleaned.customer_id = a.customer_id
order by a.customer_id, a.order_id;
