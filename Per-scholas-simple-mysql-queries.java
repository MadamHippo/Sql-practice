/*

QUESTION 1:

Write a query to display the name, product line, and buy price of all products. The output columns should 
display as “Name,” “Product Line,” and “Buy Price.” The output should display the most expensive items first.

*/

SELECT productName as 'Name', productLine as 'Product Line', buyPrice as 'Buy Price'
FROM products
ORDER BY buyPrice DESC;



/*

 QUESTIONS 2:
 
Write a query to display the first name, last name, and city name of all customers from Germany. 
Columns should display as “First Name,” “Last Name,” and “City.” The output should be sorted by “Last Name” (ascending).

*/

SELECT contactLastName, contactFirstName, city = 'Germany'
FROM customers
ORDER BY contactLastName ASC;




/*

QUESTION #3
Write a query to display each of the unique values of the status field in the orders table.
The output should be sorted alphabetically, increasing. Hint: The output should show exactly six rows.
*/

SELECT DISTINCT status
FROM orders
ORDER BY status ASC;



/*

QUESTION # 4 

Select all fields from the payments table for payments made on or after 
January 1, 2005. The output should be sorted by the payment date from highest to lowest.

*/


SELECT *
FROM payments
WHERE YEAR(paymentDate) >= 2005
/* Another way to write it: paymentDate >= DATE("2005-01-01") */
ORDER BY paymentDate ASC;



/*

QUESTION #5
Write a query to display the Last Name, First Name, Email Address, and Job Title of all employees 
working out of the San Francisco office. Output should be sorted by “Last Name.”

*/

SELECT lastName, firstName, email, jobTitle, officeCode
FROM employees
WHERE  officeCode = 1
ORDER BY lastName;



/*

QUESTIONS #6

Write a query to display the Name, Product Line, Scale, and Vendor of 
all of the Car products – both classic and vintage. The output should 
display all vintage cars first (sorted alphabetically by name), and all 
classic cars last (also sorted alphabetically by name). 

*/

SELECT productName, productLine, productScale, productVendor
FROM products
WHERE productLine = 'Vintage Cars' OR productLine = 'Classic Cars' 
ORDER BY productName ASC, productLine DESC;
