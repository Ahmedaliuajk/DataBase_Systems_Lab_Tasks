# CREATING THE DATABASE

CREATE DATABASE ahmed_ali_lab_task_04;
USE ahmed_ali_lab_task_04;

# Now create the PUBLISHERS table with the specified attributes

CREATE TABLE PUBLISHERS (
    P_ID VARCHAR(4),
    P_Name VARCHAR(30),
    Address VARCHAR(40),
    State VARCHAR(20),
    Phone VARCHAR(20)
);


# Add the Email_ID column:
ALTER TABLE PUBLISHERS ADD Email_ID VARCHAR(20);

#Change the data type of P_ID from VARCHAR to INT:
ALTER TABLE PUBLISHERS MODIFY P_ID INT;

#Change the data type of Phone from VARCHAR to INT:
ALTER TABLE PUBLISHERS MODIFY Phone INT;


# Rename the table from PUBLISHERS to PUBLISHER:
ALTER TABLE PUBLISHERS RENAME TO PUBLISHER;

# Delete the renamed table PUBLISHER:
DROP TABLE PUBLISHER;

# CREATING ANOTHER TABLE
CREATE TABLE BOOKS (
    ISBN VARCHAR(4),
    Book_Title VARCHAR(30),
    Category VARCHAR(15),
    Price NUMERIC(6,2),
    Copyright_Date NUMERIC(4),
    Year NUMERIC(4),
    P_ID VARCHAR(4)
);

#Add a new column Page_Count with type NUMERIC(4):
ALTER TABLE BOOKS ADD Page_Count NUMERIC(4);

# Change the data type of ISBN from VARCHAR to INT:
ALTER TABLE BOOKS MODIFY ISBN INT;

# Change the data type of Copyright_Date from NUMERIC to VARCHAR:
ALTER TABLE BOOKS MODIFY Copyright_Date VARCHAR(4);


# DROPING THE BOOK TABLE
DROP TABLE BOOKS;

# DELETE THE ENTIRE DATABASE
DROP DATABASE your_full_name_lab_task_04;

