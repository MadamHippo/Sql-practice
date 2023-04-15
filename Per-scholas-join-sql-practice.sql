/*
QUESTION #1

Joining 2 tables:

1. Create a query to return all orders made by users with the first name of “Marion”
*/

SELECT orders.*
FROM orders
INNER JOIN users
ON orders.user_id = users.user_id
WHERE first_name = 'Marion';


/*
Question #2

Outer Joins
Create a query to select all users that have not made an order

Left outer join means there will be at least 1 row for every
user but it will not have NULL users if there are no users that
have no corresponding user.


*/

SELECT users.*
FROM users
LEFT OUTER JOIN orders
ON orders.user_id = users.user_id
WHERE ORDER_ID IS NULL;

-- Another way of writing it...
-- SELECT *
-- FROM users
-- WHERE user_id NOT IN (SELECT DISTINCT user_id FROM orders);



/*
QUESTION #3
Create a Query to select the names and prices of all items that have been part of 2 or
more separate orders.

Nested query is a way to do it...
*/


SELECT name, price
FROM items
INNER JOIN order_items
ON items.item_id = order_items.item_id
GROUP BY name, price HAVING count(distinct(order_id)) > 1;


/* 

QUESTION 4

Create a query to return the Order Id, Item name, Item Price, and Quantity from orders
made at stores in the city “New York”. Order by Order Id in ascending order.

*/

SELECT order_items.order_id, items.name, items.price, order_items.quantity
FROM items
INNER JOIN order_items
ON items.item_id = order_items.item_id
INNER JOIN orders
ON order_items.order_id = orders.order_id
INNER JOIN stores
ON orders.store_id = stores.store_id
WHERE city = 'New York'
ORDER BY order_id ASC;

/*
QUESTION #5

Your boss would like you to create a query that calculates the total revenue generated
by each item. Revenue for an item can be found as (Item Price * Total Quantity
Ordered). Please return the first column as ‘ITEM_NAME’ and the second column as
‘REVENUE’.
*/

SELECT items.name AS Item_Name, SUM(items.price * order_items.quantity) AS Revenue
FROM items
INNER JOIN order_items
ON order_items.item_id = items.item_id
GROUP BY items.name



/*

QUESTION #6

Create a query with the following output:
a. Column 1 - Store Name

i. The name of each store
b. Column 2 - Order Quantity
i. The number of times an order has been made in this store
c. Column 3 - Sales Figure
i. If the store has been involved in more than 3 orders, mark as ‘High’
ii. If the store has been involved in less than 3 orders but more than 1 order,
mark as ‘Medium’
iii. If the store has been involved with 1 or less orders, mark as ‘Low’
Should be ordered by the Order Quantity in Descending order
*/


SELECT stores.name AS Name, COUNT(order_id) AS Order_Quantity, 
		CASE
			WHEN COUNT(order_id) > 3 THEN 'High'
			WHEN COUNT(order_id) >= 2 THEN 'Medium'
			WHEN COUNT(order_id) >= 1 THEN 'Low'
        END AS Sales_Figure
FROM stores
INNER JOIN orders
ON orders.store_id = stores.store_id
GROUP BY stores.name
ORDER BY Order_Quantity DESC;
