-- Week 3 Assignment: SQL Transactions & Aggregate Functions
-- File: answers.sql

USE sales;

-- Question 1: Create the student table
CREATE TABLE student (
    id INT PRIMARY KEY,
    fullName VARCHAR(100),
    age INT
);

-- Question 2: Insert at least 3 records into the student table
INSERT INTO student (id, fullName, age) VALUES
(1, 'Samatar Ali', 22),
(2, 'Amina Yusuf', 19),
(3, 'John Mwangi', 25);

-- Question 3: Update the age of the student with ID 2 to 20
UPDATE student
SET age = 20
WHERE id = 2;

-- Verification: Confirm the update worked
SELECT * FROM student;