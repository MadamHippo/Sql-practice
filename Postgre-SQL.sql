-- TABLE 1:


-- Drop table for "employee"
DROP TABLE IF EXISTS employee;


-- Drop table "contact"
DROP TABLE IF EXISTS contact;


-- Drop table call "address"
DROP TABLE IF EXISTS address;


-- Creating employee table
CREATE TABLE employee (
    -- Serial is the type, and an auto-incrementing integer, since no id number is provided the database must create its own serial incrementor
    -- Primary Key is the unique id for the row. *Not sure why its highlighted different colors
    id INT PRIMARY KEY,


    -- Any unspecified field type is text.
    -- Per instructors, text is unlimited length
    fname TEXT,
    lname TEXT,
    age INT,
    hiredate DATE
);


-- Inserting data into employee table
INSERT INTO employee(id, fname, lname, age, hiredate)
VALUES (01, 'James', 'B', 32, '12/15/2019'),
       (02, 'Susan', 'Shepard', 28, '07/21/2015'),
       (03, 'Justin', 'Ward', 43, '08/24/2017'),




-- TABLE 2:


CREATE TABLE address (
    -- Didn't specify type for anything besides id so...text it is.
    id INT PRIMARY KEY,
    address1 TEXT,
    address2 TEXT,
    city TEXT,
    state TEXT,
    zip TEXT
);


-- putting data into the address table
INSERT INTO address (id, address1, address2, city, state, zip)
VALUES (01, '1211 Sudan St', 'n/a', 'Mobile', 'AL', '36609'),
       (02, '4800 Barkshire Dr', 'n/a', 'Pace', 'FL', '32571'),
       (03, '12 Nutmeg Ct', 'n/a', 'Culver City', 'CA', '90211'),
       (04, '2142 Elmwood Pl', 'n/a', 'Johnson City', 'TN', '37112'),
       (05, '777 Heavenly Ln', 'Box 13', 'Pike City', 'MN', '50877');






-- TABLE 3
CREATE TABLE contact (
    id INT PRIMARY KEY,
    cellphone TEXT,
    homephone TEXT,
    email TEXT
);


-- Insert data into "contact" table
INSERT INTO contact (id, cellphone, homephone, email)
VALUES (01, '8880345966', '8888567987', 'james.betternot@hotmail.com'),
       (02, '5129739834', '5129847873', 'sshepard@yorkdevtraining.com'),
       (03, '6453898502', '6459872345', 'jsward2007@yahoo.com'),





-- SECTION 2:


-- Inner join using id...odd but ok, usually use mapping table or address id or employee id
SELECT e.fname, e.lname, e.age, a.city, a.state
FROM employee e
JOIN address a ON e.id = a.id
WHERE e.fname = 'Susan';




-- Second inner join
-- Two inner joins to make one big table to find this email...
-- Think of it as a temporary table under the hood...maybe it reads contact enmail first, then matches it to address and finally finds the address
SELECT e.fname, e.lname, e.age, a.city, a.state, c.email
FROM employee e
JOIN address a ON e.id = a.id
JOIN contact c ON e.id = c.id
WHERE c.email = 'james.betternot@hotmail.com';





-- Changing shepherd's phone number:
UPDATE contact
SET cellphone = '4383991212'
-- can't do join in an update. we're updating a single table.
-- must use subquery:
WHERE id = (SELECT id FROM employee WHERE fname = 'Susan' AND lname = 'Shepard');




-- Creating a query that has all of susan's info
SELECT *
FROM employee e
JOIN address a ON e.id = a.id
JOIN contact c ON e.id = c.id
WHERE e.fname = 'Susan' AND e.lname = 'Shepard';
