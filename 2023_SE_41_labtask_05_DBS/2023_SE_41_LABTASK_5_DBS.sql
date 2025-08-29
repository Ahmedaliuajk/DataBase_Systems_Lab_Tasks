# Create the database
CREATE DATABASE your_full_name_lab_task_05;

#  Use the created database
USE your_full_name_lab_task_05;

# Create the PUBLISHERS table with constraints
CREATE TABLE PUBLISHERS (
    P_ID INT PRIMARY KEY,
    P_Name VARCHAR(30) NOT NULL,
    Address VARCHAR(50),
    State VARCHAR(12) DEFAULT 'Unknown',
    Phone VARCHAR(18) NOT NULL,
    Email_ID VARCHAR(20)
);


# Task 2

# Create the BOOKS table with initial constraints
CREATE TABLE BOOKS (
    ISBN INT PRIMARY KEY,
    Book_Title VARCHAR(50) NOT NULL,
    Category VARCHAR(20),
    Price NUMERIC(6,2),
    Copyright_Date VARCHAR(4),
    Year NUMERIC(4),
    Page_Count NUMERIC(4),
    P_ID INT NOT NULL
);

# Add a Foreign Key constraint to P_ID
ALTER TABLE BOOKS ADD CONSTRAINT fk_publishers FOREIGN KEY (P_ID) REFERENCES PUBLISHERS(P_ID);

# Add a CHECK constraint to ensure Price is greater than 20
ALTER TABLE BOOKS ADD CONSTRAINT chk_price CHECK (Price > 20);

# Add a UNIQUE constraint on Book_Title
ALTER TABLE BOOKS ADD CONSTRAINT unq_book_title UNIQUE (Book_Title);


# Task 3
# query to list all constraints
SELECT 
    TABLE_NAME, 
    CONSTRAINT_NAME, 
    CONSTRAINT_TYPE 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE TABLE_NAME IN ('PUBLISHERS', 'BOOKS');

# Query to Display Columns Associated with Each Constraint
SELECT 
    TABLE_NAME, 
    CONSTRAINT_NAME, 
    COLUMN_NAME 
FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE 
WHERE TABLE_NAME IN ('PUBLISHERS', 'BOOKS');

# Task 4
# Drop the DEFAULT Constraint on the State Column
#1. First, find the name of the default constraint:
SELECT name 
FROM sys.default_constraints 
WHERE parent_object_id = OBJECT_ID('PUBLISHERS') 
AND parent_column_id = COLUMNPROPERTY(OBJECT_ID('PUBLISHERS'), 'State', 'ColumnId');

#2. Then, use the constraint name in the following command:
ALTER TABLE PUBLISHERS 
DROP CONSTRAINT constraint_name;

#Drop the CHECK Constraint on the Price Column
# 1 Find the name of the CHECK constraint:
SELECT name 
FROM sys.check_constraints 
WHERE parent_object_id = OBJECT_ID('BOOKS');

# 2 Use the constraint name in the following command:
ALTER TABLE BOOKS DROP CONSTRAINT constraint_name;

# Task 5
# Step 1: Attempt to Delete the PUBLISHERS Table
DROP TABLE PUBLISHERS;

# Step 2: Observe the Error Message
# The error should mention that a foreign key constraint prevents the deletion of the PUBLISHERS table.

# Step 3: Remove the Foreign Key Constraint from the BOOKS Table
# First, find the name of the foreign key constraint:
SELECT name 
FROM sys.foreign_keys 
WHERE parent_object_id = OBJECT_ID('BOOKS');

#s4
ALTER TABLE BOOKS 
DROP CONSTRAINT constraint_name;
 # Step 4: Successfully Delete the PUBLISHERS Table
# Now that the dependency is removed, you can delete the table:
DROP TABLE PUBLISHERS;




