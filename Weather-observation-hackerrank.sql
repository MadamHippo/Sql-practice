/*

#1  Query a list of CITY and STATE from the STATION table.


    Enter your query here and follow these instructions:
    1. Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
    2. The AS keyword causes errors, so follow this convention: "Select t.Field From table1 t" instead of "select t.Field From table1 AS t"
    3. Type your code immediately after comment. Don't leave any blank line.
    
    
*/

SELECT city, state
FROM station;






/*

# 2
Enter your query here.

Query the following two values from the STATION table:

The sum of all values in LAT_N rounded to a scale of 2 decimal places.
The sum of all values in LONG_W rounded to a scale of 2 decimal places.

*/

SELECT ROUND(SUM(LAT_N), 2), ROUND(SUM(long_w), 2)
FROM station;




/*

# 3
Enter your query here.

Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
(Use Mod)
*/

SELECT DISTINCT city
FROM station
WHERE MOD(id, 2)=0;




/*

# 4

Enter your query here.

Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
The STATION table is described as follows:

Write a query to find the difference between the total number of cities and the unique number of cities in the table STATION.

*/

SELECT count(city) - count(DISTINCT city)
FROM station;



/*
Enter your query here.

# 5

Get the longest city name, and the shortest city name. If multiple shortest and longest....return the first one from ABC order.

You can use more than 1 query, here I used 2 separate queries.
*/

SELECT city, length(city)
FROM station
ORDER BY length(city) asc, city asc limit 1;

SELECT city, length(city)
FROM station
ORDER BY length(city) desc, city asc limit 1;




/*

#6

Enter your query here.

Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.


*/

SELECT DISTINCT city
FROM station
WHERE city LIKE 'a%' OR city LIKE 'e%' OR city LIKE 'i%' OR city LIKE 'o%' OR city LIKE 'u%';
