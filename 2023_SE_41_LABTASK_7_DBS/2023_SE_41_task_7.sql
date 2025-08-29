CREATE DATABASE ahmed_ali_lab_task_07;
USE ahmed_ali_lab_task_07;


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



INSERT INTO PRODUCTS (Product_ID, Name, Category, Price, Stock, Supplier)
VALUES
('P101', 'HP Laptop', 'Electronics', 85000.00, 15, 'HP Official'),
('P102', 'USB Cable', 'Accessories', 500.00, 150, 'Access Corp'),
('P103', 'Samsung Galaxy', 'Electronics', 95000.00, 10, 'Samsung Pvt Ltd'),
('P104', 'Notebook A5', 'Stationery', 100.00, 500, 'Papers Co.'),
('P105', 'Flash Drive 64GB', 'Accessories', 1200.00, 100, 'Access Corp'),
('P106', 'Wireless Mouse', 'Accessories', 900.00, 200, 'Logitech Distributors');

SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;
SELECT * FROM PRODUCTS;

# This requires an INNER JOIN (because we only need customers that actually have orders)
SELECT C.Name, O.Order_ID, O.Total_Amount
FROM CUSTOMERS C
INNER JOIN ORDERS O
    ON C.Cust_ID = O.Cust_ID;

# This requires a LEFT JOIN (keep all customers, even if they don’t have orders)
SELECT C.Name, O.Order_ID, O.Total_Amount
FROM CUSTOMERS C
LEFT JOIN ORDERS O
    ON C.Cust_ID = O.Cust_ID;

#This requires a RIGHT JOIN (all orders must appear, even if no matching customer exists)
SELECT O.Order_ID, O.Total_Amount, C.Name
FROM CUSTOMERS C
RIGHT JOIN ORDERS O
    ON C.Cust_ID = O.Cust_ID;

# This requires a FULL JOIN (show all customers and all orders, matched or unmatched)

SELECT C.Name, O.Order_ID, O.Total_Amount
FROM CUSTOMERS C
FULL JOIN ORDERS O
    ON C.Cust_ID = O.Cust_ID;

# This is still an INNER JOIN (since only customers with valid orders and non-null remarks are needed).
SELECT C.Name, O.Order_ID, O.Remarks
FROM CUSTOMERS C
INNER JOIN ORDERS O
    ON C.Cust_ID = O.Cust_ID
WHERE O.Remarks IS NOT NULL;


# 4.1
SELECT C.Name AS Customer_Name, 
       C.City, 
       O.Order_Date, 
       O.Total_Amount
FROM CUSTOMERS C
INNER JOIN ORDERS O
    ON C.Cust_ID = O.Cust_ID;

#4.2


###


###
ORDER_DETAILS (
    Order_ID   VARCHAR(6) FOREIGN KEY REFERENCES ORDERS(Order_ID),
    Product_ID VARCHAR(5) FOREIGN KEY REFERENCES PRODUCTS(Product_ID),
    Quantity   INT
)

SELECT P.Name AS Product_Name, 
       P.Supplier, 
       C.Name AS Customer_Name
FROM PRODUCTS P
INNER JOIN ORDER_DETAILS OD
    ON P.Product_ID = OD.Product_ID
INNER JOIN ORDERS O
    ON OD.Order_ID = O.Order_ID
INNER JOIN CUSTOMERS C
    ON O.Cust_ID = C.Cust_ID;
    
    
#4.3
SELECT C.Name, C.City, O.Order_ID, O.Total_Amount
FROM CUSTOMERS C
INNER JOIN ORDERS O
    ON C.Cust_ID = O.Cust_ID
WHERE C.City = 'Karachi'
  AND O.Total_Amount > 2000;

# 4.4
SELECT C.City, COUNT(DISTINCT C.Cust_ID) AS Total_Customers
FROM CUSTOMERS C
INNER JOIN ORDERS O
    ON C.Cust_ID = O.Cust_ID
GROUP BY C.City;


#4.5

SELECT C.Name AS Customer_Name, 
       AVG(O.Total_Amount) AS Avg_Order_Amount
FROM CUSTOMERS C
INNER JOIN ORDERS O
    ON C.Cust_ID = O.Cust_ID
GROUP BY C.Name;



