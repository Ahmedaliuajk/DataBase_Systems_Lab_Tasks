CREATE DATABASE ahmed_ali_lab_task_11;

USE ahmed_ali_lab_task_11;

# Creating Departments table
CREATE TABLE DEPARTMENTS (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50) NOT NULL,
    Location VARCHAR(50) NOT NULL
);

# Creating Employees table
CREATE TABLE EMPLOYEES (
    Emp_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department INT,
    Salary DECIMAL(10,2) CHECK (Salary > 0),
    Status ENUM('Active', 'Inactive'),
    FOREIGN KEY (Department) REFERENCES DEPARTMENTS(Dept_ID)
);



# Insert Departments
INSERT INTO DEPARTMENTS (Dept_ID, Dept_Name, Location)
VALUES
(1, 'Human Resources', 'Karachi'),
(2, 'Finance', 'Lahore'),
(3, 'IT', 'AJK'),
(4, 'Marketing', 'Karachi'),
(5, 'Operations', 'Multan');

# Insert Employees
INSERT INTO EMPLOYEES (Emp_ID, Name, Department, Salary, Status)
VALUES
(101, 'Ali Raza', 1, 55000, 'Active'),
(102, 'Virat Kohli', 2, 72000, 'Active'),
(103, 'Ahmed Ali', 3, 90000, 'Active'),
(104, 'Bilal Ahmed', 4, 60000, 'Inactive'),
(105, 'Ubaid Ali', 3, 85000, 'Active'),
(106, 'Usman Khan', 5, 50000, 'Inactive'),
(107, 'Babar Azam', 2, 70000, 'Active');


# 1. View for active employees only
DROP VIEW IF EXISTS Active_Employees;

CREATE VIEW Active_Employees AS
SELECT Emp_ID, Name, Department, Salary
FROM EMPLOYEES
WHERE Status = 'Active';


# 2. View joining employees with departments
CREATE VIEW Employee_Department_Details AS
SELECT e.Name AS Employee_Name, d.Dept_Name, d.Location, e.Salary, e.Status
FROM EMPLOYEES e
JOIN DEPARTMENTS d ON e.Department = d.Dept_ID;

SELECT *
FROM Employee_Department_Details
WHERE Dept_Name = 'IT' AND Status = 'Active';

SELECT AVG(Salary) AS Avg_Salary
FROM Active_Employees;

SELECT Dept_Name, SUM(Salary) AS Total_Salary
FROM Employee_Department_Details
GROUP BY Dept_Name;

# Increase Ahmed Ali's salary by 5000 using the view
# Update using PK
UPDATE Active_Employees
SET Salary = Salary + 5000
WHERE Emp_ID = 103;

# Delete using PK
DELETE FROM Active_Employees
WHERE Emp_ID = 106;


# Create index on Department column
CREATE INDEX idx_department ON EMPLOYEES(Department);
CREATE INDEX idx_status ON EMPLOYEES(Status);
DROP INDEX idx_department ON EMPLOYEES;
SHOW INDEXES FROM EMPLOYEES;



EXPLAIN SELECT * 
FROM EMPLOYEES 
WHERE Department = 3;




