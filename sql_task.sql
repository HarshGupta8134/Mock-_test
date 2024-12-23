CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255),
    Age INT,
    Gender VARCHAR(10),
    Region VARCHAR(50),
    Email VARCHAR(255)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT
);

CREATE TABLE Returns (
    ReturnID INT PRIMARY KEY,
    SaleID INT,
    ReturnDate DATE,
    Reason VARCHAR(255)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    Date DATE,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

select * from customers
select * from products
select * from returns
select * from sales


COPY Customers (CustomerID, Name, Age, Gender, Region, Email)
FROM 'D:\New folder\customers.csv'
DELIMITER ','
CSV HEADER;

select * from customers 
	

COPY Products (ProductID, ProductName, Category, Price, StockQuantity)
FROM 'D:\New folder\products.csv'
DELIMITER ','
CSV HEADER;

select * from products

COPY Returns (ReturnID, SaleID, ReturnDate, Reason)
FROM 'D:\New folder\returns.csv'
DELIMITER ','
CSV HEADER;

select * from Returns

COPY Sales (SaleID, Date, CustomerID, ProductID, Quantity, TotalAmount)
FROM 'D:\New folder\sales.csv'
DELIMITER ','
CSV HEADER;

select * from sales

WITH CustomerRevenue AS (
    SELECT 
        CustomerID,
        SUM(TotalAmount) AS TotalRevenue
    FROM Sales
    GROUP BY CustomerID
),
RankedCustomers AS (
    SELECT 
        CustomerID,
        TotalRevenue,
        RANK() OVER (ORDER BY TotalRevenue DESC) AS RevenueRank
    FROM CustomerRevenue
)SELECT 
    CustomerID,
    TotalRevenue
FROM RankedCustomers
WHERE RevenueRank <= 5
ORDER BY RevenueRank;

--RANK 
SELECT 
    CustomerID,
    Name,
    Age,
    RANK() OVER (ORDER BY Age DESC) AS age_rank
FROM 
    Customers
ORDER BY 
    age_rank;

-- DENSE RANK
SELECT 
    CustomerID,
    Name,
    Age,
    DENSE_RANK() OVER (ORDER BY Age DESC) AS age_dense_rank
FROM 
    Customers
ORDER BY 
    age_dense_rank;

