CREATE DATABASE ahmed_ali_lab_task_08;
USE ahmed_ali_lab_task_08;


# CREATING CUSTOMERS TABLE
CREATE TABLE CUSTOMERS (
    Cust_ID     VARCHAR(5)  PRIMARY KEY NOT NULL,
    Name        VARCHAR(50) NOT NULL,
    City        VARCHAR(30),
    Email       VARCHAR(50) UNIQUE,
    Phone       VARCHAR(15),
    Status      VARCHAR(10)
);


# CREATING ORDERS TABLE

CREATE TABLE ORDERS (
    Order_ID     VARCHAR(6)  PRIMARY KEY NOT NULL,
    Order_Date   DATE        NOT NULL,
    Cust_ID      VARCHAR(5)  NOT NULL,
    Total_Amount NUMERIC(8,2),
    Status       VARCHAR(15),
    Remarks      VARCHAR(50),
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (Cust_ID) 
        REFERENCES CUSTOMERS(Cust_ID)
);

# CREATING PRODUCTS TABLE

CREATE TABLE PRODUCTS (
    Product_ID  VARCHAR(5)  PRIMARY KEY NOT NULL,
    Name        VARCHAR(50) NOT NULL,
    Category    VARCHAR(20),
    Price       NUMERIC(6,2),
    Stock       NUMERIC(5),
    Supplier    VARCHAR(50)
);


INSERT INTO CUSTOMERS (Cust_ID, Name, City, Email, Phone, Status)
VALUES
('C001', 'Sarah Khan', 'Lahore', 'sarah@xyz.com', '0345123456', 'Active'),
('C002', 'Ali Raza', 'Karachi', 'ali@abc.com', '0322123456', 'Active'),
('C003', 'Farah Malik', 'Islamabad', 'farah@abc.com', '0333456789', 'Inactive'),
('C004', 'Bilal Ahmed', 'Multan', 'bilal@xyz.com', '0300123456', 'Active'),
('C005', 'Amna Saeed', 'Peshawar', 'amna@xyz.com', '0311123456', 'Active'),
('C006', 'Zain Shah', 'Quetta', 'zain@xyz.com', '0344456789', 'Inactive');



INSERT INTO ORDERS (Order_ID, Order_Date, Cust_ID, Total_Amount, Status, Remarks)
VALUES
('O1001', '2024-05-01', 'C001', 1200.00, 'Delivered', 'On time'),
('O1002', '2024-05-03', 'C003', 3000.00, 'Cancelled', 'Customer request'),
('O1003', '2024-05-05', 'C002', 2500.00, 'Delivered', NULL),
('O1004', '2024-05-06', 'C005', 1750.00, 'Processing', 'Urgent delivery'),
('O1005', '2024-05-10', 'C001', 4500.00, 'Delivered', 'Gift included'),
('O1006', '2024-05-12', 'C004', 800.00, 'Processing', NULL);


ALTER TABLE PRODUCTS
MODIFY Price DECIMAL(10,2);




INSERT INTO PRODUCTS (Product_ID, Name, Category, Price, Stock, Supplier)
VALUES
('P101', 'HP Laptop', 'Electronics', 85000.00, 15, 'HP Official'),
('P102', 'USB Cable', 'Accessories', 500.00, 150, 'Access Corp'),
('P103', 'Samsung Galaxy', 'Electronics', 95000.00, 10, 'Samsung Pvt Ltd'),
('P104', 'Notebook A5', 'Stationery', 100.00, 500, 'Papers Co.'),
('P105', 'Flash Drive 64GB', 'Accessories', 1200.00, 100, 'Access Corp'),
('P106', 'Wireless Mouse', 'Accessories', 900.00, 200, 'Logitech Distributors');


# Calculate the total number of customers
SELECT COUNT(*) AS Total_Customers
FROM CUSTOMERS;

# Count how many orders have been placed in total
SELECT COUNT(*) AS Total_Orders
FROM ORDERS;

# Calculate the average order amount
SELECT AVG(Total_Amount) AS Average_Order_Amount
FROM ORDERS;

# Find the maximum and minimum order amount in the ORDERS table
SELECT 
    MAX(Total_Amount) AS Max_Order_Amount,
    MIN(Total_Amount) AS Min_Order_Amount
FROM ORDERS;


# Count how many products are available in stock > 100
SELECT COUNT(*) AS Products_Stock_GT_100
FROM PRODUCTS
WHERE Stock > 100;

# task 3

# Group orders by customer ID and calculate the total order amount per customer
SELECT Cust_ID, SUM(Total_Amount) AS Total_Order_Amount
FROM ORDERS
GROUP BY Cust_ID;


# Group products by category and show average price in each category
SELECT Category, AVG(Price) AS Average_Price
FROM PRODUCTS
GROUP BY Category;

# Count how many customers belong to each status (Active/Inactive)
SELECT Status, COUNT(*) AS Total_Customers
FROM CUSTOMERS
GROUP BY Status;

# Find the total stock of products grouped by their supplier
SELECT Supplier, SUM(Stock) AS Total_Stock
FROM PRODUCTS
GROUP BY Supplier;


# Task 4

# Show customers who have placed more than one order (group by customer)
SELECT Cust_ID, COUNT(Order_ID) AS Total_Orders
FROM ORDERS
GROUP BY Cust_ID
HAVING COUNT(Order_ID) > 1;

# Show suppliers whose total stock is greater than 200 units
SELECT Supplier, SUM(Stock) AS Total_Stock
FROM PRODUCTS
GROUP BY Supplier
HAVING SUM(Stock) > 200;

# List cities that have more than one active customer
SELECT City, COUNT(*) AS Active_Customers
FROM CUSTOMERS
WHERE Status = 'Active'
GROUP BY City
HAVING COUNT(*) > 1;

# Find product categories with average price above 1000

SELECT Category, AVG(Price) AS Avg_Price
FROM PRODUCTS
GROUP BY Category
HAVING AVG(Price) > 1000;


