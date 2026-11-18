

IF DB_ID('RetailReturnsDB') IS NULL CREATE DATABASE RetailReturnsDB;
GO
USE RetailReturnsDB;
GO


DROP VIEW  IF EXISTS vw_StoreRefund;
DROP TABLE IF EXISTS Refunds;
DROP TABLE IF EXISTS Returns;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Stores;
GO

CREATE TABLE Stores (
    StoreID   INT         PRIMARY KEY,
    StoreName VARCHAR(60) NOT NULL,
    Region    VARCHAR(20) NOT NULL
);

CREATE TABLE Customers (
    CustomerID INT         PRIMARY KEY,
    CustName   VARCHAR(60) NOT NULL
);

CREATE TABLE Products (
    ProductID   INT           PRIMARY KEY,
    ProductName VARCHAR(60)   NOT NULL,
    Category    VARCHAR(30)   NOT NULL,
    UnitPrice   DECIMAL(10,2) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INT         PRIMARY KEY,
    EmpName    VARCHAR(50) NOT NULL,
    StoreID    INT         NULL REFERENCES Stores(StoreID),      
    ManagerID  INT         NULL REFERENCES Employees(EmployeeID) 
);

CREATE TABLE Sales (
    SaleID     INT  PRIMARY KEY,
    StoreID    INT  NOT NULL REFERENCES Stores(StoreID),
    CustomerID INT  NULL     REFERENCES Customers(CustomerID),   
    ProductID  INT  NOT NULL REFERENCES Products(ProductID),
    Qty        INT  NOT NULL,
    SaleDate   DATE NOT NULL
);

CREATE TABLE Returns (
    ReturnID   INT         PRIMARY KEY,
    SaleID     INT         NOT NULL REFERENCES Sales(SaleID),
    Qty        INT         NOT NULL,
    ReturnDate DATE        NOT NULL,
    Reason     VARCHAR(30) NOT NULL
);

CREATE TABLE Refunds (                                  
    RefundID   INT           PRIMARY KEY,
    ReturnID   INT           NOT NULL UNIQUE REFERENCES Returns(ReturnID),
    Amount     DECIMAL(10,2) NOT NULL,
    RefundDate DATE          NOT NULL,
    Method     VARCHAR(20)   NOT NULL
);
GO


INSERT INTO Stores VALUES
 (1,'Chennai Central','South'), (2,'Coimbatore Mall','South'), (3,'Bengaluru Indiranagar','South'),
 (4,'Mumbai Andheri','West'),   (5,'Pune Camp','West'),        (6,'Delhi Saket','North');

INSERT INTO Customers VALUES
 (1,'Anitha'), (2,'Bharath'), (3,'Charan'), (4,'Divya'), (5,'Eswar'), (6,'Farhan');

INSERT INTO Products VALUES
 (1,'Wireless Headphones','Electronics',2500), (2,'Smartwatch','Electronics',8000),
 (3,'Cotton T-Shirt','Apparel',600),           (4,'Running Sneakers','Footwear',3500),
 (5,'Laptop Backpack','Accessories',1800),     (6,'Mixer Grinder','Home',4000);

INSERT INTO Employees VALUES
 (1,'Meena',   NULL,NULL), (2,'Karthik',1,1), (3,'Lakshmi',1,2), (4,'Nikhil',2,1),
 (5,'Oviya',2,4),          (6,'Prakash',3,1), (7,'Rani',4,1),    (8,'Suresh',6,1);

INSERT INTO Sales VALUES
 ( 1,1,   1,1, 2,'2026-02-03'),
 ( 2,1,   2,2, 1,'2026-02-04'),
 ( 3,1,   3,3,20,'2026-02-05'),
 ( 4,2,   1,4, 2,'2026-02-06'),
 ( 5,2,   4,1, 3,'2026-02-07'),
 ( 6,3,   5,2, 2,'2026-02-08'),
 ( 7,3,   2,5, 1,'2026-02-09'),
 ( 8,4,   3,6, 1,'2026-02-10'),
 ( 9,4,NULL,1, 1,'2026-02-11'),    
 (10,5,   4,3, 4,'2026-02-12'),
 (11,5,   5,4,10,'2026-02-13'),
 (12,6,   1,2, 1,'2026-02-14'),
 (13,1,   4,1, 5,'2026-02-15'),
 (14,2,   6,6, 2,'2026-02-16');

INSERT INTO Returns VALUES
 ( 1, 1,1,'2026-02-20','Defective'),   ( 2, 5,1,'2026-02-21','Changed mind'),
 ( 3, 9,1,'2026-02-22','Defective'),   ( 4, 2,1,'2026-02-23','Defective'),
 ( 5, 6,1,'2026-02-24','Damaged'),     ( 6, 3,1,'2026-02-25','Wrong size'),
 ( 7, 4,1,'2026-02-26','Wrong size'),  ( 8, 7,1,'2026-02-27','Changed mind'),
 ( 9,13,1,'2026-02-28','Defective'),   (10,10,1,'2026-03-01','Wrong size'),
 (11,12,1,'2026-03-02','Damaged');

INSERT INTO Refunds VALUES
 (1, 1,2500,'2026-02-22','UPI'),   (2, 3,2500,'2026-02-24','Card'),
 (3, 4,8000,'2026-02-25','Card'),  (4, 6, 600,'2026-02-27','Cash'),
 (5, 7,3500,'2026-02-28','UPI'),   (6, 9,2500,'2026-03-02','UPI'),
 (7,10, 600,'2026-03-03','Cash'),  (8,11,8000,'2026-03-04','Card');
GO



CREATE VIEW vw_StoreRefund AS
SELECT st.StoreID, st.StoreName, st.Region,
       ISNULL(SUM(f.Amount), 0) AS TotalRefund
FROM   Stores st
LEFT JOIN Sales   s ON s.StoreID = st.StoreID
LEFT JOIN Returns r ON r.SaleID  = s.SaleID
LEFT JOIN Refunds f ON f.ReturnID = r.ReturnID
GROUP BY st.StoreID, st.StoreName, st.Region;
GO








WITH Sold AS (
    SELECT ProductID, SUM(Qty) AS SoldQty FROM Sales GROUP BY ProductID
), Ret AS (
    SELECT s.ProductID, SUM(r.Qty) AS RetQty
    FROM   Returns r JOIN Sales s ON s.SaleID = r.SaleID
    GROUP BY s.ProductID
)
SELECT p.ProductName, so.SoldQty, ISNULL(rt.RetQty, 0) AS ReturnedQty,
       CAST(100.0 * ISNULL(rt.RetQty, 0) / so.SoldQty AS DECIMAL(5,2)) AS ReturnRatePct
FROM   Products p
INNER JOIN Sold so ON so.ProductID = p.ProductID
LEFT  JOIN Ret  rt ON rt.ProductID = p.ProductID
WHERE  100.0 * ISNULL(rt.RetQty, 0) / so.SoldQty > 10
ORDER BY ReturnRatePct DESC;






SELECT r.ReturnID, c.CustName, p.ProductName, r.ReturnDate, r.Reason
FROM   Returns r
INNER JOIN Sales    s ON s.SaleID    = r.SaleID
INNER JOIN Products p ON p.ProductID = s.ProductID
LEFT  JOIN Customers c ON c.CustomerID = s.CustomerID
LEFT  JOIN Refunds  f ON f.ReturnID  = r.ReturnID
WHERE  f.RefundID IS NULL;




SELECT TOP (1) WITH TIES StoreName, Region, TotalRefund
FROM   vw_StoreRefund
ORDER BY TotalRefund DESC;




SELECT e.EmpName AS Employee, ISNULL(m.EmpName, '
FROM   Employees e
LEFT JOIN Employees m ON m.EmployeeID = e.ManagerID
ORDER BY e.EmployeeID;




SELECT st.StoreName, e.EmpName
FROM   Stores st
FULL OUTER JOIN Employees e ON e.StoreID = st.StoreID
WHERE  st.StoreID IS NULL OR e.EmployeeID IS NULL;




SELECT p.ProductName
FROM   Products p
LEFT JOIN Sales   s ON s.ProductID = p.ProductID
LEFT JOIN Returns r ON r.SaleID    = s.SaleID
GROUP BY p.ProductID, p.ProductName
HAVING COUNT(r.ReturnID) = 0;




SELECT r.ReturnID, p.ProductName, st.StoreName, r.Reason,
       ISNULL(f.Amount, 0) AS RefundAmount,
       CASE WHEN f.RefundID IS NULL THEN 'Pending' ELSE 'Refunded' END AS Status
FROM   Returns r
INNER JOIN Sales    s  ON s.SaleID    = r.SaleID
INNER JOIN Products p  ON p.ProductID = s.ProductID
INNER JOIN Stores   st ON st.StoreID  = s.StoreID
LEFT  JOIN Refunds  f  ON f.ReturnID  = r.ReturnID
ORDER BY r.ReturnID;



SELECT r.Reason, COUNT(*) AS Returns, COUNT(f.RefundID) AS Refunded,
       ISNULL(SUM(f.Amount), 0) AS RefundValue
FROM   Returns r
LEFT JOIN Refunds f ON f.ReturnID = r.ReturnID
GROUP BY r.Reason
ORDER BY RefundValue DESC;




SELECT c.CustName, COUNT(*) AS ReturnsMade
FROM   Customers c
INNER JOIN Sales   s ON s.CustomerID = c.CustomerID
INNER JOIN Returns r ON r.SaleID     = s.SaleID
GROUP BY c.CustomerID, c.CustName
HAVING COUNT(*) > 1;




SELECT s.SaleID, st.StoreName, p.ProductName, s.Qty
FROM   Sales s
INNER JOIN Stores   st ON st.StoreID  = s.StoreID
INNER JOIN Products p  ON p.ProductID = s.ProductID
LEFT  JOIN Returns  r  ON r.SaleID    = s.SaleID
WHERE  r.ReturnID IS NULL
ORDER BY s.SaleID;
GO





SELECT CustomerID, CustName
FROM   Customers
WHERE  CustomerID IN (SELECT s.CustomerID
                      FROM   Returns r JOIN Sales s ON s.SaleID = r.SaleID);




SELECT s.CustomerID
FROM   Returns r JOIN Sales s ON s.SaleID = r.SaleID;


SELECT CustomerID, CustName
FROM   Customers
WHERE  CustomerID NOT IN (SELECT s.CustomerID
                          FROM   Returns r JOIN Sales s ON s.SaleID = r.SaleID);






SELECT c.CustomerID, c.CustName
FROM   Customers c
WHERE  NOT EXISTS (SELECT 1
                   FROM   Returns r
                   JOIN   Sales   s ON s.SaleID = r.SaleID
                   WHERE  s.CustomerID = c.CustomerID);




SELECT CustomerID, CustName
FROM   Customers
WHERE  CustomerID NOT IN (SELECT s.CustomerID
                          FROM   Returns r JOIN Sales s ON s.SaleID = r.SaleID
                          WHERE  s.CustomerID IS NOT NULL);

GO





SELECT s.StoreName, s.Region, s.TotalRefund
FROM   vw_StoreRefund s
WHERE  s.TotalRefund > ALL (SELECT o.TotalRefund
                            FROM   vw_StoreRefund o
                            WHERE  o.Region = s.Region AND o.StoreID <> s.StoreID);





SELECT s.StoreName, s.Region, s.TotalRefund
FROM   vw_StoreRefund s
WHERE  s.TotalRefund > ANY (SELECT o.TotalRefund
                            FROM   vw_StoreRefund o
                            WHERE  o.Region = s.Region AND o.StoreID <> s.StoreID);


GO



SET STATISTICS IO ON;
SET STATISTICS TIME ON;



SELECT p.ProductName, x.ReturnedQty
FROM  (SELECT s.ProductID, SUM(r.Qty) AS ReturnedQty
       FROM   Returns r JOIN Sales s ON s.SaleID = r.SaleID
       GROUP BY s.ProductID) x
JOIN   Products p ON p.ProductID = x.ProductID
WHERE  x.ReturnedQty > (SELECT AVG(CAST(y.ReturnedQty AS DECIMAL(10,2)))
                        FROM  (SELECT SUM(r2.Qty) AS ReturnedQty
                               FROM   Returns r2 JOIN Sales s2 ON s2.SaleID = r2.SaleID
                               GROUP BY s2.ProductID) y);




SELECT c.CustName, SUM(f.Amount) AS TotalRefund
FROM   Customers c
JOIN   Sales   s ON s.CustomerID = c.CustomerID
JOIN   Returns r ON r.SaleID     = s.SaleID
JOIN   Refunds f ON f.ReturnID   = r.ReturnID
GROUP BY c.CustomerID, c.CustName
HAVING SUM(f.Amount) > (SELECT AVG(t.CustTotal)
                        FROM  (SELECT SUM(f2.Amount) AS CustTotal
                               FROM   Refunds f2
                               JOIN   Returns r2 ON r2.ReturnID = f2.ReturnID
                               JOIN   Sales   s2 ON s2.SaleID   = r2.SaleID
                               WHERE  s2.CustomerID IS NOT NULL
                               GROUP BY s2.CustomerID) t);


SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO
