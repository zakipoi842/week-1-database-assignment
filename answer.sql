-- ============================================
-- Week 1 Assignment: School Management Database
-- Author: Zakariye
-- Date: 2026-10-09
-- ============================================

-- 1. Create the database
CREATE DATABASE IF NOT EXISTS school_management;

-- 2. Select the database
USE school_management;

-- 3. Create Students table
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    date_of_birth DATE,
    enrollment_date DATE DEFAULT (CURRENT_DATE)
);

-- 4. Create Courses table
CREATE TABLE IF NOT EXISTS courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    instructor VARCHAR(100)
);

-- 5. Create Enrollments table
CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- 6. Insert sample students
INSERT INTO students (first_name, last_name, email, date_of_birth) VALUES
('Alice', 'Johnson', 'alice@school.edu', '2004-03-12'),
('Brian', 'Smith',   'brian@school.edu', '2003-07-25'),
('Carol', 'Davis',   'carol@school.edu', '2004-11-02');

-- 7. Insert sample courses
INSERT INTO courses (course_name, credits, instructor) VALUES
('Introduction to SQL', 3, 'Dr. Brown'),
('Data Structures',     4, 'Prof. Lee'),
('Web Development',     3, 'Dr. Patel');

-- 8. Insert sample enrollments
INSERT INTO enrollments (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(1, 2, 'B+'),
(2, 1, 'A-'),
(3, 3, 'B');

-- 9. Query: List all students
SELECT * FROM students;

-- 10. Query: List all courses
SELECT * FROM courses;

-- 11. Query: Student-course join
SELECT 
    s.first_name,
    s.last_name,
    c.course_name,
    e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id;

-- 12. Query: Count students per course
SELECT 
    c.course_name,
    COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;
-- ============================================
-- Week 2 Assignment: Introduction to SQL
-- Author: Zakariye
-- Date: 2026-10-09
-- ============================================

USE sales;

-- Question 1: Retrieve Payment Information
SELECT checkNumber, paymentDate, amount
FROM payments;

-- Question 2: Find Orders in Process
SELECT orderDate, requiredDate, status
FROM orders
WHERE status = 'In Process'
ORDER BY orderDate DESC;

-- Question 3: Find Sales Representatives
SELECT firstName, lastName, email
FROM employees
WHERE jobTitle = 'Sales Rep'
ORDER BY employeeNumber DESC;

-- Question 4: Retrieve Office Information
SELECT * FROM offices;

-- Question 5: Retrieve the Five Cheapest Products
SELECT productName, quantityInStock
FROM products
ORDER BY buyPrice ASC
LIMIT 5;
-- ============================================
-- Week 3 Assignment: SQL Transactions & Aggregate Functions
-- Author: Zakariye
-- Date: 2026-10-09
-- ============================================

-- Use a dedicated database for this week
CREATE DATABASE IF NOT EXISTS week3_transactions;
USE week3_transactions;

-- ============================================
-- Question 1: Create the student table
-- ============================================
CREATE TABLE IF NOT EXISTS student (
    id INT PRIMARY KEY,
    fullName VARCHAR(100) NOT NULL,
    age INT
);

-- ============================================
-- Question 2: Insert at least 3 records
-- ============================================
START TRANSACTION;

INSERT INTO student (id, fullName, age) VALUES
(1, 'Samatar Ali', 22),
(2, 'Amina Yusuf', 19),
(3, 'John Mwangi', 25);

COMMIT;

-- ============================================
-- Question 3: Update the age of student with ID 2 to 20
-- ============================================
START TRANSACTION;

UPDATE student
SET age = 20
WHERE id = 2;

COMMIT;

-- ============================================
-- Verification: Confirm the update worked
-- ============================================
SELECT * FROM student;

-- ============================================
-- Aggregate Function Demonstrations
-- ============================================

-- Average age of all students
SELECT AVG(age) AS average_age FROM student;

-- Total number of students
SELECT COUNT(*) AS total_students FROM student;

-- Youngest and oldest students
SELECT MIN(age) AS youngest_age, MAX(age) AS oldest_age FROM student;

-- Count of students per age
SELECT age, COUNT(*) AS students_at_age
FROM student
GROUP BY age
ORDER BY age;

-- ============================================
-- Transaction Rollback Example
-- ============================================
START TRANSACTION;

INSERT INTO student (id, fullName, age) VALUES (4, 'Test Student', 30);

-- Deliberately rollback so this row does NOT persist
ROLLBACK;

-- Confirm rollback worked (should still show only 3 students)
SELECT * FROM student;