# Step 1: Create the database
CREATE DATABASE ahmed_ali_lab_task_06;

#Step 2: Use the database
USE ahmed_ali_lab_task_06;

#Step 3: Create the PUBLISHERS table
CREATE TABLE PUBLISHERS (
    P_ID VARCHAR(4) PRIMARY KEY NOT NULL,
    Name VARCHAR(50),
    State VARCHAR(15),
    Address VARCHAR(50) NOT NULL,
    Email VARCHAR(30),
    Contact VARCHAR(20) UNIQUE
);

select * from PUBLISHERS;



# DATA  INSERTION 
INSERT INTO PUBLISHERS (P_ID, Name, State, Address, Contact, Email)
VALUES 
('PUB1', 'Hills Publications', 'Georgia', '12 Park St, Atlanta', '7134019', 'h_pub@hills.com'),
('PUB2', 'Sunshine Publishers Ltd.', 'New Jersey', '45 Second St, Newark', '6548909', NULL),
('PUB3', 'Bright Publications', 'Hawaii', '123 Main St, Honolulu', '7678985', 'bright@bp.com'),
('PUB4', 'Paramount Publishing House', 'New York', '789 Oak St, New York', '9254834', 'param_house@param.com'),
('PUB5', 'Wesley Publications', 'Nevada', '456 First St, Las Vegas', '5683452', NULL);


select * FROM PUBLISHERS;



# 1. Update contact number of Wesley Publications to 9256774

SET SQL_SAFE_UPDATES = 0;
SELECT P_ID, Name FROM PUBLISHERS;
UPDATE PUBLISHERS
SET Contact = '9256774'
WHERE P_ID = 'PUB5';
SET SQL_SAFE_UPDATES = 1;
select * from PUBLISHERS;

# 2. Retrieve all publisher details where the state is Georgia
SELECT * FROM PUBLISHERS
WHERE State = 'Georgia';

#3. Update the email of Sunshine Publishers Ltd. to s_pub@sunshine.com
SET SQL_SAFE_UPDATES = 0;
SELECT P_ID, Name FROM PUBLISHERS;
UPDATE PUBLISHERS
SET Email = 's_pub@sunshine.com'
WHERE P_ID = 'PUB2';
SET SQL_SAFE_UPDATES = 1;

SELECT * FROM PUBLISHERS;



## TASK 4


# Create BOOKS table
CREATE TABLE BOOKS (
    ISBN VARCHAR(15) PRIMARY KEY UNIQUE,
    Title VARCHAR(50) NOT NULL,
    Genre VARCHAR(20),
    Pages NUMERIC(4),
    Year_Published NUMERIC(4),
    Release_Year NUMERIC(4),
    Cost NUMERIC(6,2),
    Publisher_ID VARCHAR(4),
    FOREIGN KEY (Publisher_ID) REFERENCES PUBLISHERS(P_ID)
);

# insert book records
INSERT INTO BOOKS 
(ISBN, Title, Genre, Pages, Year_Published, Release_Year, Cost, Publisher_ID)
VALUES
('001-354921-1', 'Ransack', 'Fiction', 200, 2005, 2006, 22.00, 'PUB1'),
('001-987650-5', 'Differential Calculus', 'Academic', 450, 2003, 2003, 30.00, 'PUB1'),
('001-987760-9', 'C++', 'Academic', 800, 2004, 2005, 40.00, 'PUB1'),
('002-678880-2', 'Call Away', 'Fiction', 200, 2001, 2002, 22.00, 'PUB2'),
('002-678980-4', 'Database Systems', 'Academic', 800, 2004, 2006, 40.00, 'PUB2'),
('003-456433-6', 'German Language Basics', 'Language', 200, 2003, 2004, 22.00, 'PUB4'),
('003-456533-8', 'French Language Guide', 'Language', 500, 2005, 2006, 32.00, 'PUB4'),
('004-765359-3', 'Coordinate Geometry', 'Academic', 650, 2006, 2006, 35.00, 'PUB3'),
('004-765409-5', 'UNIX Essentials', 'Academic', 550, 2006, 2007, 26.00, 'PUB3');

# TASK 5
# 1. Change Genre of book titled ‘C++’ from Academic to Language
UPDATE BOOKS
SET Genre = 'Language'
WHERE Title = 'C++';

#  2. Retrieve ISBN and Title of all books classified under Language
SELECT ISBN, Title
FROM BOOKS
WHERE Genre = 'Language';

# 3. Fetch complete details of books released in 2006
SELECT *
FROM BOOKS
WHERE Release_Year = 2006;

# 4. List titles of books having less than 600 pages
SELECT Title
FROM BOOKS
WHERE Pages < 600;

# 5. Display all distinct genres available in the BOOKS table
SELECT DISTINCT Genre
FROM BOOKS;

# 6. Show complete records of all books in Academic category with cost ≥ 35
SELECT *
FROM BOOKS
WHERE Genre = 'Academic' AND Cost >= 35;

# 7. Delete all entries from the BOOKS table where Genre is Fiction
DELETE FROM BOOKS
WHERE Genre = 'Fiction';

