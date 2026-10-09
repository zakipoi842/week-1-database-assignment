-- ============================================
-- Week 1 Assignment: School Management Database
-- Author: [Your Name]
-- Date: [Today's Date]
-- ============================================

-- 1. Create the database
CREATE DATABASE school_management;

-- 2. Select the database
USE school_management;

-- 3. Create Students table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    date_of_birth DATE,
    enrollment_date DATE DEFAULT (CURRENT_DATE)
);

-- 4. Create Courses table
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    instructor VARCHAR(100)
);

-- 5. Create Enrollments table (links students to courses)
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- 6. Insert sample data into students
INSERT INTO students (first_name, last_name, email, date_of_birth)
VALUES
('Alice', 'Johnson', 'alice@school.edu', '2004-03-12'),
('Brian', 'Smith', 'brian@school.edu', '2003-07-25'),
('Carol', 'Davis', 'carol@school.edu', '2004-11-02');

-- 7. Insert sample data into courses
INSERT INTO courses (course_name, credits, instructor)
VALUES
('Introduction to SQL', 3, 'Dr. Brown'),
('Data Structures', 4, 'Prof. Lee'),
('Web Development', 3, 'Dr. Patel');

-- 8. Insert sample enrollments
INSERT INTO enrollments (student_id, course_id, grade)
VALUES
(1, 1, 'A'),
(1, 2, 'B+'),
(2, 1, 'A-'),
(3, 3, 'B');

-- 9. Query: List all students
SELECT * FROM students;

-- 10. Query: List all courses
SELECT * FROM courses;

-- 11. Query: Show which student is enrolled in which course
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