-- College Database Assignment
-- MySQL

DROP DATABASE IF EXISTS collegedb;
CREATE DATABASE collegedb;
USE collegedb;

-- 1. Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 18),
    city VARCHAR(50),
    course VARCHAR(50)
);

-- 2. Courses table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    fees INT NOT NULL
);

-- 3. Enrollements table
-- The spelling is kept the same as the teacher's output.
CREATE TABLE Enrollements (
    enrollement_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert students
INSERT INTO Students (name, email, age, city, course)
VALUES
    ('Rahul', 'rahul@gmail.com', 21, 'delhi', 'java'),
    ('Neha', 'neha@gmail.com', 20, 'Mumbai', 'Python'),
    ('Amit', 'amit@gmail.com', 23, 'Delhi', 'Java'),
    ('Priya', 'priya@gmail.com', 22, 'Chandigarh', 'Python'),
    ('Rohan', 'rohan@gmail.com', 25, 'Delhi', 'Java'),
    ('Simran', 'simran@gmail.com', 24, 'Mohali', 'DevOps'),
    ('Karan', 'karan@gmail.com', 26, 'Delhi', 'Python');

-- Insert courses
INSERT INTO Courses (course_name, fees)
VALUES
    ('Java', 30000),
    ('Python', 25000),
    ('DevOps', 40000);

-- The teacher's successful records begin at enrollement_id 8 because a failed
-- multi-row insertion consumed IDs 1-7. Set the next value to 8 to match the output.
ALTER TABLE Enrollements AUTO_INCREMENT = 8;

-- Insert enrollements
INSERT INTO Enrollements (student_id, course_id, marks)
VALUES
    (1, 1, 90),
    (2, 2, 80),
    (3, 1, 95),
    (4, 2, 70),
    (5, 1, 88),
    (6, 3, 92),
    (7, 2, 75);

-- Display all records
SELECT * FROM Students;
SELECT * FROM Courses;
SELECT * FROM Enrollements;

-- Count students city-wise
SELECT
    city,
    COUNT(*) AS TotalStudents
FROM Students
GROUP BY city;

-- Total marks city-wise
SELECT
    Students.city,
    SUM(Enrollements.marks) AS TotalMarks
FROM Students
JOIN Enrollements
    ON Students.student_id = Enrollements.student_id
GROUP BY Students.city;

-- Average marks city-wise
SELECT
    Students.city,
    AVG(Enrollements.marks) AS AverageMarks
FROM Students
JOIN Enrollements
    ON Students.student_id = Enrollements.student_id
GROUP BY Students.city;

-- Cities with average marks greater than 85
SELECT
    Students.city,
    AVG(Enrollements.marks) AS AverageMarks
FROM Students
JOIN Enrollements
    ON Students.student_id = Enrollements.student_id
GROUP BY Students.city
HAVING AVG(Enrollements.marks) > 85;
