SELECT 
	first_name,
	last_name, 
    points, 
    (points + 3) * 10 AS 'discount factor'
FROM customers;


SELECT
	name,
    unit_price,
    unit_price * 1.1 AS 'new unit price'
FROM products;
    
    
SELECT *
FROM order_items
WHERE order_id = '6' AND unit_price * quantity > '30'


SELECT *
FROM customers
-- WHERE state = 'VA' OR state = 'GA' OR state = 'FL'
-- WHERE state IN ('VA', 'FL', 'GA')
WHERE state NOT IN ('VA', 'FL', 'GA')

SELECT *
FROM products
-- WHERE quantity_in_stock = '49' OR quantity_in_stock = '38' OR quantity_in_stock = '72'
WHERE quantity_in_stock IN (49, 38, 72)


-- The Between Operator Tutorial

SELECT *
FROM customers
-- WHERE points >= 1000 AND points <= 3000
WHERE points BETWEEN 1000 AND 3000

-- Excercise
SELECT *
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01'


-- Like Operator
SELECT *
FROM customers
-- WHERE last_name LIKE 'b%'
-- % indicates any number of characters after b- not case sensitive

-- WHERE last_name LIKE '%b%'
-- % indicates any number of characters before or after b- not case sensitive. they have a b somewhere in their last name

WHERE last_name LIKE '_y'
-- this matches any customer with last name thats exactly 2 character's long and ends with y. but we can change it to other _ _ _ _ etc. and it will return names like Boagey or Rumgay etc.
-- to summarize % any number of characters and _ is single character



SELECT *
FROM customers
-- WHERE address LIKE '%trail%'OR address LIKE '%avenue%'
-- getting customers whose addresses contain words like trail or avenue AND...phone numbers that ends with a 9.

WHERE phone NOT LIKE '%9'


SELECT *
FROM customers
-- searching last name of customer with 'field' in the last name.
-- WHERE last_name LIKE '%field%'
WHERE last_name REGEXP 'field' 
-- if you put a ^ in the beginning, it means you want the start of the string starting with field. The end is $. 
-- the vertical bar | is the or so they can look for possible ending of two or more strings name patterns
-- WHERE last_name REGEXP '[gim]e'
-- using square brackets and you can put in any characters to find g with e, or m with e, 
-- or i with e BEFORE. if you move the bracket after e, it will find characters after inside 
-- the bracket. You can also use a range with a simple [a-h]

-- recap
-- ^ beginning
-- $ end
-- | logical or
-- [abcd]
-- [a-f]

REGEX Practice

SELECT *
FROM customers
-- where first names are ELKA or AMBUR:
-- WHERE first_name REGEXP 'elka|ambur'

-- where last names end with EY or ON:
-- WHERE last_name REGEXP 'ey$|on$'

-- where last names start with MY or contains SE:
-- WHERE last_name REGEXP '^my|[se]'

-- where last name contain B followed by R or U:
WHERE last_name REGEXP 'b[ru]'


—--------------------------------------------------------------------------------------------------------------------------

IS NULL operator

SELECT *
FROM customers
WHERE phone IS NULL
– will get customer who’s phone is null. Can also use IS NOT NULL.

Practice/Exercise:

– get the orders not shipped…

SELECT *
FROM orders
WHERE shipper_id IS NULL


—--------------------------------------------------------------------------------------------------------------------------

ORDERS BY operator 

– Sorting order descending:

SELECT *
FROM customers
ORDER BY first_name DESC

– Sorting order by state AND first name
SELECT *
FROM customers
ORDER BY state, first_name


– Sorting order by state AND first name in descending order
SELECT *
FROM customers
ORDER BY state DESC, first_name DESC


— another example:

SELECT first_name, last_name, 10 AS points
FROM customers
ORDER BY points, first_name


– you can also sort data by position (using 1, 2) but it’s not best practice.
– Always sort by column names of the actual columns


Practice Exercise

– return order id with exactly 2 and the total price of the items in descending order.

SELECT *, quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC

—--------------------------------------------------------------------------------------------------------------------------
The LIMIT Clause 

(for if you want to only get the first 3 customers)
SELECT *
FROM customers
LIMIT 3


Another example:

SELECT *
FROM customers
LIMIT 6, 3
-- 6 is offset, 3 is telling SQL to pick the next 3. So out of 10 customers you will get 7, 8 , and 9



Who are my most loyal customers?!

SELECT *
FROM customers
ORDER BY points desc
LIMIT 3

– the limit clause should always come at the end. 


—--------------------------------------------------------------------------------------------------------------------------

INNER JOINS

In the real world, we often select columns from many kinds of tables

SELECT *
FROM orders
INNER JOIN customers 
		ON orders.customer_id = customers.customer_id
-- inner join 
-- whenever you are joining customers, make sure orders in customer id column is equal to the customers 
-- id column in the customer's table.


Cleaning it up a bit…to line up the order ID, and first name and last name.

SELECT order_id, orders.customer_id, first_name, last_name
-- you need to qualify them with a prefix if you are using 1 or more columns.
FROM orders
INNER JOIN customers 
		ON orders.customer_id = customers.customer_id
-- inner join 
-- whenever you are joining customers, make sure orders in customer id column is equal to the customers 
-- id column in the customer's table.



– Exercise! Practice!

--  write a query and join the product_id and the order_id followed by quantity and unit price WITH using of an alias.

--  write a query and join the product_id and the order_id followed by quantity and unit price WITH using of an alias.
SELECT order_id, oi.order_id, quantity, p.unit_price
-- you have to add a . to specific which table to get it from if there's 2 columns same name across different columns joined
FROM order_items oi -- oi is the alias
JOIN products p ON oi.product_id = p.product_id


—--------------------------------------------------------------------------------------------------------------------------

JOINING ACROSS Databases

-- combine multiple database tables across

USE sql_inventory;
-- you only have to prefix tables with a (.) that are not currently in the database. 
SELECT *
FROM sql_store.order_items oi
JOIN sql_inventory.products p
	ON oi.product_id = p.product_id
    


—--------------------------------------------------------------------------------------------------------------------------


SELF JOINS

– Joining a table with itself is the same as joining with another table, just use different alias and prefix every call with a prefix called self join.

-- SELF JOINS

USE sql_hr;

SELECT e.employee_id, e.first_name, m.first_name AS manager
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_i

—--------------------------------------------------------------------------------------------------------------------------

JOIN more than 2 tables:

SELECT 
o.order_id,
    	o.order_date,
c.first_name,
c.last_name,
os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id
    -- this is how you join 3 tables...


– will print out inside orders and status and customer id: order_id, order_date, first_name, last_name, and status of order.


Exercise / Practice

– payment and client id to join together. Join with payments method table too. Join with payment method and client info basically.


USE sql_invoicing;

SELECT
	p.date,
    p.invoice_id,
    p.amount,
    c.name,
    pm.name,
FROM payments p
JOIN clients c
	ON p.client_id = c.cliend_id
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id
    
—--------------------------------------------------------------------------------------------------------------------------

Compound Join Methods

-- Combining multiple tables
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id

—--------------------------------------------------------------------------------------------------------------------------
-- Explicit Join syntax:

SELECT *
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id

-- Implicit Join Syntax:
-- eqviant to, not best practice, don't reccomend. just explicit ok!--

SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id


—--------------------------------------------------------------------------------------------------------------------------

Outer Join:

When you use a left join, all the records will be returned weather the condition below of “ON” is true or not. Whereas when you use RIGHT join, it’s the opposite weather they have a order or not. 



-- using sql HR
-- join keyword = inner join
-- left/right join = outer join

SELECT 
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
RIGHT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id

Exercise / Practice: 
– Want to write query that join product table with order item table, so we can see how many times each product is ordered. BUt if we do a inner join, it wouldn’t work so we need a outer join. So your practice is to write an outer join.


-- JOIN Exercerise:

SELECT 
	p.product_id,
p.name,
oi.quantity
FROM products p
LEFT JOIN order_items oi
	ON p.product_id = oi.product_id


—--------------------------------------------------------------------------------------------------------------------------

Outer Joins between Multiple Tables

SELECT 
	c.customer_id,
c.first_name,
o.order_id,
sh.name AS shipper
-- doing a left join between customers and orders table. we will get all customers no matter if they have an order or not.
FROM customers c
-- best practice is just avoid using Right join. Avoid right, use left.
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
-- join up owners table and shippers table together
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id


Exercise / Practice: 

USE sql_store;

SELECT
	o.order_id,
    o.order_date,
    c.first_name AS ‘customer name’,
    sh.name AS shipper,
    os.name AS status
    
FROM orders o
-- using inner join since every order has a customer this....
JOIN customers c
	-- ....this condition is always valid :)
	ON o.customer_id = c.customer_id
-- joining result with shippers table
JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
-- you will see all orders that have shipped already

-- if you want to see all orders, including ones NOT shipped yet, use LEFT JOIN.

JOIN order_statuses os
	ON o.status = os.order_status_id


—--------------------------------------------------------------------------------------------------------------------------

SELF Outer Joins

USE sql_hr;

SELECT
	e.employee_id,
    e.first_name,
    m.first_name AS manager
FROM employees e
-- a Left Join will get every employee in this table, doesn't matter if they have a manager or not.
LEFT JOIN employees m
	ON e.reports_to = m.employee_id


—--------------------------------------------------------------------------------------------------------------------------

USING Clause

-- The USING clause

SELECT
	o.order_id,
    c.first_name,
    sh.name AS shipper
FROM orders o
JOIN customers c
-- join condition:
-- ON o.customer_id = c.customer_id
-- the next line is also a join condition. it's more simple and beautiful to write: (if the column name is the exactly the same)
	USING (customer_id)
    
LEFT JOIN shippers sh
	USING (shipper_id)
    
-- You can't use this techique to join things of a different name like 'order_status_id' vs 'order_id'



Another example:

SELECT *
FROM order_items oi
JOIN order_item_notes oin
– ON oi.order_id = oin.order_id AND oi.product_id = oin.product_id ← too hard to read
	USING (order_id, product_id)

<< wow so simple and clean!>>

Exercise / Practice: 

USE sql_invoicing;

SELECT 
	p.date,
    c.name AS client,
    p.amount,
    pm.name AS payment_method
FROM payments p
JOIN clients c USING (client_id)
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id


—--------------------------------------------------------------------------------------------------------------------------
-- another way to join 2 tables, it's easier to code. It's called 
-- NATURAL JOIN

SELECT
	o.order_id,
    c.first_name
FROM orders o
-- natural join doesn't specify column names, it will join the based on common columns automatically 
NATURAL JOIN customers c



—--------------------------------------------------------------------------------------------------------------------------

Cross Joins

-- Cross joins

SELECT
	c.first_name AS customer,
    p.name AS product

FROM customers c
CROSS JOIN products p
ORDER BY c.first_name
-- the result of a cross join....comes in a list of customers and every item they have ordered. 
– you can combine all these different combos and print them all
– using explicit syntax like above is more clear than implicit which looks like…..you get rid of CROSS JOIN and just fill it in at FROM.


Exercise / Practice:

– DO a cross join between shippers and products
– using implicit syntax
– and then using the explicit syntax:


Implicit syntax:

SELECT
	sh.name AS shipper,
    	p.name AS product
FROM shipper sh, products p
ORDER BY sh.name
-- combination of all shippers and products (implicit)

Explicitl syntax:

SELECT
	sh.name AS shipper,
    	p.name AS product
FROM shipper sh,
CROSS JOIN products p
ORDER BY sh.name

—--------------------------------------------------------------------------------------------------------------------------
UNIONS – combining rows from tables
(join was combining columns from tables)


-- UNION

SELECT 
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'

UNION

SELECT 
	order_id,
    order_date,
    'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01';

– combine records from multiple queries. You can combine results. Here’s another example..

—--------------------------------------------------------------------------------------------------------------------------

Column Attributes

Its a column of tables for settings of each item inside the database

—--------------------------------------------------------------------------------------------------------------------------

Inserting a Row into Table

-- Inserting a Single Row

INSERT INTO customers
VALUES (DEFAULT, 'John', 'Smith', '1990-01-01', NULL, 'address', 'city', 'CA', DEFAULT)

Another way to write it….

INSERT INTO customers (first_name, last_name, birth_date, address, city, state)
VALUES ('John', 'Smith', '1990-01-01', 'address', 'city', 'CA')


—--------------------------------------------------------------------------------------------------------------------------

Inserting Multiple Rows


-- inserting multiple rows

INSERT INTO shippers (name)
VALUES ('Shipper1'),
	   ('Shipper2'),
       	   ('Shipper3')


Excerise:

-- inserting multiple rows

USE sql_store;


INSERT INTO products (name, quantity_in_stock, unit_price)
VALUES ('Product1', 1, 24.99),
	   ('Product1', 7, 2.99),
       ('Product1', 3, 1.99)

—--------------------------------------------------------------------------------------------------------------------------
Inserting Hierarical Rows

– inserting data into multiple tables

-- Inserting data into tables with a parent/child relationship

INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-02', 1);

INSERT INTO order_items
VALUES
(LAST_INSERT_ID(), 1, 1, 2.95),
(LAST_INSERT_ID(), 2, 1, 14.95)


-- built in functions in SQL
-- SELECT LAST_INSERT_ID()
-- use this ID returned to insert the child elements

—--------------------------------------------------------------------------------------------------------------------------
Creating a Copy of a Table

– quickly copy data from 1 to another, like an orders archive

CREATE TABLE orders_archived AS
SELECT * FROM orders
-- quickly copies a copy of a table. 
-- select statement is a subquery.
-- copies everything from orders into orders_archived, but the primary key and auto-increment is not copied.

-- Copying sub-section, selective texts to another table..

INSERT INTO orders_archived

SELECT *
FROM orders
WHERE order_date < '2019-01-01'


Exercise Practice:

– something complicated and stuff at https://youtu.be/7S_tz1z_5bA?t=10425

USE sql_invoicing;

CREATE TABLE invoices_archived AS


SELECT
	i.invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.payment_date,
    i.due_date
FROM invoices i
JOIN clients c
	USING (client_id)
WHERE payment_date IS NOT NULL


—--------------------------------------------------------------------------------------------------------------------------
Updating Single Data Row

-- Updating a single row...updating data in SQL

UPDATE invoices
SET payment_total = 10, payment_date = '2019-03-01'
-- condition of the location where you want to be updated:
WHERE invoice_id = 1

(if you want to UNDO it, set the payment_total to 0, and payment_date to NULL.)
-- Updating a single row...updating data in SQL

UPDATE invoices
SET payment_total = DEFAULT, payment_date = NULL
-- condition of the location where you want to be updated:
WHERE invoice_id = 1

Note: Instead of Default, you can also say payment_total = invoice total * 0.5 to make it 50% off or something like that. The number is truncated, it rounds down basically.


—--------------------------------------------------------------------------------------------------------------------------
Updating Multiple Data Rows

> go to preferences and undo safe mode and then restart workbench



Excerise!!!

USE sql_store;

UPDATE customers
SET points = points + 50
WHERE birth_date < ‘1991-01-01’


—--------------------------------------------------------------------------------------------------------------------------
Using Subqueries in a Update Statement

– a subquery is a select statement that is within another SQL statement. But we need to put it in Parathesis so SQL will implement it first.)


UPDATE invoices
SET payment_total = DEFAULT, payment_date = NULL
WHERE client_id IN
		(SELECT client_id
       		 FROM clients
       		 WHERE state IN ('CA', 'NY'))

– using IN is for multiple subqueries with multiple client updates

Excerise!!! / Practice
USE sql_invoicing;

UPDATE orders
SET comments = 'Gold customer'
WHERE customer_id IN 
			(SELECT customer_id
			FROM customers
			WHERE points > 3000)


—--------------------------------------------------------------------------------------------------------------------------

Deleting a Record

-- DELETING ROWS


DELETE FROM invoices
WHERE client = (
	SELECT *
	FROM clients
	WHERE name = 'Myworks'
)


—--------------------------------------------------------------------------------------------------------------------------

Restoring Databases

>File
>Open SQL Script
>Open up the original script you had
>Execute the original script and bam. 

