CREATE DATABASE ahmed_ali_lab_task_12;
USE ahmed_ali_lab_task_12;


CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Program VARCHAR(50),
    AdmissionYear INT,
    CGPA DECIMAL(3,2)
);


INSERT INTO Students (StudentID, FullName, Program, AdmissionYear, CGPA)
VALUES
(1, 'Ali Raza', 'BS Computer Science', 2021, 3.45),
(2, 'Ahmed Hassan', 'BS Software Engineering', 2020, 3.10),
(3, 'Ahmed Ali', 'BS Data Science', 2022, 3.75),
(4, 'Mehdi Ali', 'BS Information Technology', 2019, 2.95),
(5, 'Bilal ALi', 'BS Artificial Intelligence', 2021, 3.88),
(6, 'Tayyab Hanif', 'BS Cyber Security', 2023, 3.20);



DELIMITER $$

CREATE FUNCTION YearsSinceAdmission(admissionYear INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE years_passed INT;
    SET years_passed = YEAR(CURDATE()) - admissionYear;
    RETURN years_passed;
END $$

DELIMITER ;


# query 1

SELECT 
    FullName AS StudentName,
    AdmissionYear,
    YearsSinceAdmission(AdmissionYear) AS Years_Since_Admission
FROM Students;




# Multiparameter Function

DELIMITER $$

CREATE FUNCTION CalculateGrade(mark1 INT, mark2 INT, mark3 INT)
RETURNS CHAR(1)
DETERMINISTIC
BEGIN
    DECLARE avg_marks DECIMAL(5,2);
    DECLARE grade CHAR(1);

    #Step 1: Calculate average
    SET avg_marks = (mark1 + mark2 + mark3) / 3;

    # Step 2: Decide grade
    IF avg_marks >= 85 THEN
        SET grade = 'A';
    ELSEIF avg_marks >= 70 THEN
        SET grade = 'B';
    ELSEIF avg_marks >= 50 THEN
        SET grade = 'C';
    ELSE
        SET grade = 'F';
    END IF;
    #Step 3: Return grade
    RETURN grade;
END $$
DELIMITER ;

SELECT CalculateGrade(90, 88, 92) AS Grade;
SELECT CalculateGrade(65, 72, 60) AS Grade;
SELECT CalculateGrade(40, 45, 48) AS Grade;











DELIMITER $$

DROP PROCEDURE IF EXISTS GetStudentsByProgramAndCGPA $$
CREATE PROCEDURE GetStudentsByProgramAndCGPA(
    IN p_program VARCHAR(100),
    IN p_minCGPA DECIMAL(3,2)
)
BEGIN
    SELECT StudentID, FullName, Program, AdmissionYear, CGPA
    FROM Students
    WHERE Program = p_program
      AND CGPA > p_minCGPA;
END $$
DELIMITER ;

# all students in BS Computer Science with CGPA > 3.0
CALL GetStudentsByProgramAndCGPA('BS Computer Science', 3.0);

# all students in BS Software Engineering with CGPA > 3.5
CALL GetStudentsByProgramAndCGPA('BS Software Engineering', 3.5);


## Task 5

DELIMITER $$

DROP PROCEDURE IF EXISTS InsertStudent $$
CREATE PROCEDURE InsertStudent(
    IN p_StudentID INT,
    IN p_FullName VARCHAR(100),
    IN p_Program VARCHAR(50),
    IN p_AdmissionYear INT,
    IN p_CGPA DECIMAL(3,2)
)
BEGIN
    INSERT INTO Students (StudentID, FullName, Program, AdmissionYear, CGPA)
    VALUES (p_StudentID, p_FullName, p_Program, p_AdmissionYear, p_CGPA);
END $$
DELIMITER ;

CALL InsertStudent(7, 'Ali Raza', 'BS Software Engineering', 2023, 3.45);
### task 5 B part

DELIMITER $$

DROP PROCEDURE IF EXISTS GetStudentsByProgram $$
CREATE PROCEDURE GetStudentsByProgram(
    IN p_Program VARCHAR(50)
)
BEGIN
    IF p_Program IS NULL OR p_Program = '' THEN
        -- Case 1: No program given → return all students
        SELECT * FROM Students;
    ELSE
        -- Case 2: Program specified → return only matching program
        SELECT * FROM Students WHERE Program = p_Program;
    END IF;
END $$
DELIMITER ;

# Get ALL students (no program filter)
CALL GetStudentsByProgram(NULL);

# Or I can pass an empty string instead of NULL
CALL GetStudentsByProgram('');

# Get only BS Software Engineering students
CALL GetStudentsByProgram('BS Software Engineering');

# Get only BS Computer Science students
CALL GetStudentsByProgram('BS Computer Science');



