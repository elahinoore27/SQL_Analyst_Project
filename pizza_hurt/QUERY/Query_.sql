create database pizzahut;
use pizzahut;

-- Q1 Retrieve the total number of order palced

SELECT 
    COUNT(order_id) AS total_order
FROM
    orders;

-- Q2 calculate total revenue generated from pizza sales;

SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_price
FROM
    order_details AS od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id;

-- Q3 Identify the highest price of pizza

SELECT 
    pt.name, p.price
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

-- Q4 Identify most common pizza size ordered

SELECT 
    p.size, COUNT(od.order_details_id) AS order_count
FROM
    pizzas AS p
        JOIN
    order_details AS od ON p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY order_count DESC
LIMIT 1;

-- Q5 list top most ordered pizza type along with their Quantity

SELECT 
    pt.name as pizza_type, SUM(od.quantity) AS total_quantity
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY pizza_type
ORDER BY total_quantity DESC
LIMIT 5;

-- Q6 join the neccessary table to find the total quantity of each pizza category orderd.

select pt.category,sum(od.quantity) as total_quantity
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY total_quantity DESC;

-- Q7 Determine the distrubution of orders by hour of the day

SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);

-- Join relevant tables to find th category-wise distrubution of pizza

SELECT 
    category, COUNT(name) AS Total_pizza
FROM
    pizza_types
GROUP BY category;

-- group the order by date and calcucte the average number of pizza  ordered per day

SELECT 
    ROUND(AVG(quan), 0) AS Average_order_per_day
FROM
    (SELECT 
        o.order_date, SUM(od.quantity) AS quan
    FROM
        orders AS o
    JOIN order_details AS od ON o.order_id = od.order_id
    GROUP BY o.order_date) AS order_quantity;
    
-- Determin most 3 pizza type based on revenue

select pt.name ,sum(od.quantity*p.price) as revenue
from pizza_types as pt join
pizzas as p
on pt.pizza_type_id=p.pizza_type_id
join order_details as od
on od.pizza_id=p.pizza_id
group by pt.name
order by revenue desc
 limit 3;


-- analyze the cummulative revenue generated over time
-- 200 200, 300 500,450,950

select order_date,
round(sum(reveue) over(order by order_date) ,0)as cum_revnue from
(select orders.order_date,sum(order_details.quantity*pizzas.price) as reveue
from order_details 
join pizzas 
on order_details.pizza_id=pizzas.pizza_id
join orders
on orders.order_id=order_details.order_id
group by orders.order_date) as sales;

