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



/*
Enter your query here.


# 7

Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.

*/

SELECT DISTINCT city
FROM station
WHERE city LIKE '%a' OR city LIKE '%e' OR city LIKE '%i' OR city LIKE '%o' OR city LIKE '%u';




/*
Enter your query here.

#8

Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.


Kinda brute force long way to solution: 

SELECT DISTINCT city from STATION where (CITY LIKE 'a%' 
    OR CITY LIKE 'e%' 
    OR CITY LIKE 'i%' 
    OR CITY LIKE 'o%'
    OR CITY LIKE 'u%'
)
AND (CITY LIKE '%a' 
    OR CITY LIKE '%e' 
    OR CITY LIKE '%i' 
    OR CITY LIKE '%o'
    OR CITY LIKE '%u'
   );


And 2 random notes: 

dot (.) represents one single character. It means that two dots (..) take two characters. Three dots (...) take three characters.

.* represents any string no matter the number of characters.

*/

SELECT DISTINCT city
FROM station
WHERE left(city,1) in ('a','e','i','o','u')
      AND right(city, 1) in ('a','e','i','o','u');
      
      
/*
Enter your query here.

#9

Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.

*/


SELECT DISTINCT city 
FROM STATION
WHERE NOT (CITY LIKE 'a%' 
    OR CITY LIKE 'e%' 
    OR CITY LIKE 'i%' 
    OR CITY LIKE 'o%'
    OR CITY LIKE 'u%'
   );





/*
Enter your query here.

#10

Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.

*/


SELECT DISTINCT city 
FROM STATION
WHERE NOT (CITY LIKE '%a' 
    OR CITY LIKE '%e' 
    OR CITY LIKE '%i' 
    OR CITY LIKE '%o'
    OR CITY LIKE '%u'
   );



/*
Enter your query here.

# 11

Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.

*/

SELECT DISTINCT city
FROM station
WHERE left(city, 1) NOT IN ('a','e','i','o','u')
      OR right(city, 1) NOT IN ('a','e','i','o','u');
      
      
/*
Enter your query here.

# 12

Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.

*/

select distinct city from station where (left(city,1) not in ('a','e','i','o','u') and  right(city,1) not in ('a','e','i','o','u'));



/*
Enter your query here.

# 13

Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345. Truncate your answer to  decimal places.


First solution:

SELECT ROUND(SUM(LAT_N),4)
FROM Station
WHERE LAT_N BETWEEN 38.7880 AND 137.2345;

*/


SELECT TRUNCATE(SUM(LAT_N), 4)
FROM station
WHERE lat_n > 38.7880 AND lat_n < 137.2345;



/*
Bonus question: Revising the Select Query I

Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.

*/
SELECT *
FROM city
WHERE population > 100000 AND countrycode = 'usa';



/*
Bonus question: Revising the Select Query II

Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.
*/

SELECT name
FROM city
WHERE population > 120000 and countrycode = 'usa';
