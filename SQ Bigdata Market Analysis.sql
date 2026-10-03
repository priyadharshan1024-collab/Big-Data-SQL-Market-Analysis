# Cleaned all tables
USE project_orders

#1 - which aisel_id has highest number of products?
SELECT aisle_id,count(*) as product_count
FROM products
GROUP BY aisle_id 
ORDER BY product_count DESC
LIMIT 10 

#2 -How many unique departments are there in the dataset? 
SELECT COUNT(*) FROM departments 

#3 - What is the distribution of products across departments?
SELECT department_id , COUNT(*) as product_count 
FROM products 
GROUP BY department_id
ORDER BY product_count DESC

#4 - What are the top 10 products with the highest reorder rates?
SELECT p.product_name , sum(op.reordered) AS reorder_count
FROM products p
JOIN order_products_train op ON p.product_id = op.product_id
GROUP BY product_name
ORDER BY reorder_count DESC

#5 - How many unique users have placed orders in the dataset?
SELECT COUNT(DISTINCT user_id) AS unique_users
FROM orders 

#6 - What is the average number of days between orders for each user?
SELECT user_id,count(*) AS total_orders,AVG(days_since_prior_order) as avg_order_days
FROM orders
GROUP BY user_id

#7 - What are the peak hours of order placement during the day?
SELECT order_hour_of_day , count(*) AS order_count
FROM orders
GROUP BY order_hour_of_day
ORDER BY order_count DESC

#8 - How does order volume vary by day of the week?
SELECT order_dow , count(*) AS order_count
FROM orders
GROUP BY order_dow
ORDER BY order_count DESC

#9 - What are the top 10 most ordered products?
SELECT p.product_name , count(*) AS order_count
FROM products p
JOIN order_products_train op ON p.product_id = op.product_id
GROUP BY p.product_id 
ORDER BY order_count DESC
limit 10

#10	- How many users have placed orders in each department?
SELECT d.department_id,count(distinct o.user_id) as user_count
FROM orders o
JOIN order_products_train op ON o.order_id = op.order_id
JOIN products p ON p.product_id = op.product_id
JOIN departments d ON d.department_id = p.department_id
GROUP BY d.department_id
ORDER BY user_count DESC

#11 - What is the average number of products per order?
SELECT AVG(product_count) AS AVERAGE_PRODUCT
FROM(
	SELECT order_id,count(*) as product_count
    FROM order_products_train
    GROUP BY order_id
    ) AS order_size
    
#12 - What are the most reordered products in each department?
SELECT p.product_name,count(op.reordered) as reorder_count
FROM products p
JOIN order_products_train op ON p.product_id = op.product_id
GROUP BY op.product_id
ORDER BY reorder_count

#13 - How many products have been reordered more than once?
SELECT product_id,count(*) AS reorder_count
FROM order_products_train
WHERE reordered = 1
GROUP BY product_id
ORDER BY reorder_count DESC

#14 - What is the average number of products added to the cart per order?
SELECT AVG(count) as average_product_per_cart
FROM(
SELECT order_id , count(*) as count
FROM order_products_train
GROUP BY order_id
ORDER BY order_id ASC
)AS order_cart_avg

#15 - How does the number of orders vary by hour of the day?
SELECT order_hour_of_day, COUNT(*) AS total_orders
FROM orders
GROUP BY order_hour_of_day
ORDER BY order_hour_of_day;

#16 - What is the distribution of order sizes (number of products per order)?
SELECT product_count, COUNT(*) AS num_orders
FROM (
    SELECT order_id, COUNT(*) AS product_count
    FROM order_products_train
    GROUP BY order_id
) AS order_sizes
GROUP BY product_count
ORDER BY product_count;

# 17 - What is the average reorder rate for products in each aisle?
SELECT AVG(reorder_count)
FROM(
SELECT a.aisle ,count(*) as reorder_count
FROM aisles a 
JOIN products p ON a.aisle_id = p.aisle_id
JOIN order_products_train op ON p.product_id = op.product_id
WHERE reordered=1 
GROUP BY aisle
ORDER BY reorder_count DESC) AS aisle_reorder

# 18 - How does the average order size vary by day of the week?
SELECT o.order_dow, AVG(order_sizes.product_count) AS avg_order_size
FROM orders o
JOIN (
    SELECT order_id, COUNT(*) AS product_count
    FROM order_products_train
    GROUP BY order_id
) AS order_sizes ON o.order_id = order_sizes.order_id
GROUP BY o.order_dow
ORDER BY o.order_dow;

#19 - What are the top 10 users with the highest number of orders?
SELECT user_id,COUNT(*) AS order_count
FROM orders
GROUP BY user_id
ORDER BY order_count DESC

#20 - How many products belong to each aisle and department?
#aisle'
SELECT aisle_id,count(*) as product_count
FROM products
GROUP BY aisle_id
ORDER BY aisle_id

#department

SELECT department_id,count(*) as product_count
FROM products
GROUP BY department_id
ORDER BY department_id





