CREATE DATABASE BankBranchDB;
GO
USE BankBranchDB;
GO

CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL
);

CREATE TABLE Branches (
    BranchID INT IDENTITY(1,1) PRIMARY KEY,
    BranchName VARCHAR(100) NOT NULL UNIQUE,
    BranchAddress VARCHAR(200) NOT NULL
);

CREATE TABLE Managers (
    ManagerID INT IDENTITY(1,1) PRIMARY KEY,
    ManagerName VARCHAR(100) NOT NULL,
    BranchID INT NOT NULL,
    CONSTRAINT FK_Managers_Branches FOREIGN KEY (BranchID)
        REFERENCES Branches(BranchID) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE Accounts (
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    AccountNo VARCHAR(20) NOT NULL UNIQUE,
    CustomerID INT NOT NULL,
    AccountType VARCHAR(20) NOT NULL,
    BranchID INT NOT NULL,
    ManagerID INT NOT NULL,
    Balance DECIMAL(12,2) NOT NULL DEFAULT 0,
    OpenedDate DATE NOT NULL DEFAULT (CONVERT(DATE,GETDATE())),
    CONSTRAINT CK_Accounts_Type CHECK (AccountType IN ('Savings','Current','Salary')),
    CONSTRAINT CK_Accounts_Balance CHECK (Balance >= 0),
    CONSTRAINT FK_Accounts_Customers FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Accounts_Branches FOREIGN KEY (BranchID)
        REFERENCES Branches(BranchID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Accounts_Managers FOREIGN KEY (ManagerID)
        REFERENCES Managers(ManagerID) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT NOT NULL,
    TransactionText VARCHAR(300) NOT NULL,
    TransactionDate DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    CONSTRAINT FK_Transactions_Accounts FOREIGN KEY (AccountID)
        REFERENCES Accounts(AccountID) ON DELETE CASCADE
);

INSERT INTO Customers (CustomerName, Address) VALUES
('Arun Kumar','Chennai'),('Bala','Tambaram'),('Charu','Velachery'),
('Deepa','Adyar'),('Ezhil','Guindy'),('Farah','Porur'),
('Gokul','Avadi'),('Hari','OMR'),('Indu','Anna Nagar'),('Jaya','Pallavaram');

INSERT INTO Branches (BranchName, BranchAddress) VALUES
('Chennai Main','Mount Road'),('Tambaram Branch','Tambaram'),
('Velachery Branch','Velachery'),('Adyar Branch','Adyar'),
('Guindy Branch','Guindy'),('Porur Branch','Porur'),
('Avadi Branch','Avadi'),('OMR Branch','OMR'),
('Anna Nagar Branch','Anna Nagar'),('Pallavaram Branch','Pallavaram');

INSERT INTO Managers (ManagerName, BranchID) VALUES
('Manager One',1),('Manager Two',2),('Manager Three',3),('Manager Four',4),
('Manager Five',5),('Manager Six',6),('Manager Seven',7),('Manager Eight',8),
('Manager Nine',9),('Manager Ten',10);

INSERT INTO Accounts (AccountNo, CustomerID, AccountType, BranchID, ManagerID, Balance, OpenedDate) VALUES
('ACC1001',1,'Savings',1,1,25000,'2026-08-01'),
('ACC1002',2,'Current',2,2,50000,'2026-08-10'),
('ACC1003',3,'Savings',3,3,18000,'2026-09-01'),
('ACC1004',4,'Salary',4,4,42000,'2026-09-05'),
('ACC1005',5,'Savings',5,5,35000,'2026-09-15'),
('ACC1006',6,'Current',6,6,80000,'2026-10-01'),
('ACC1007',7,'Savings',7,7,12000,'2026-10-05'),
('ACC1008',8,'Salary',8,8,60000,'2026-10-12'),
('ACC1009',9,'Savings',9,9,29000,'2026-10-20'),
('ACC1010',10,'Current',10,10,95000,'2026-11-01');

INSERT INTO Transactions (AccountID, TransactionText, TransactionDate) VALUES
(1,'ATM cash withdrawal','2026-11-01'),
(2,'NEFT credit','2026-11-02'),
(3,'UPI payment','2026-11-03'),
(4,'Salary credit','2026-11-04'),
(5,'POS purchase','2026-11-05'),
(6,'Cheque deposit','2026-11-06'),
(7,'UPI payment','2026-11-07'),
(8,'Salary credit','2026-11-08'),
(9,'ATM cash withdrawal','2026-11-09'),
(10,'NEFT transfer','2026-11-10');

SELECT * FROM Customers;
SELECT * FROM Branches;
SELECT * FROM Managers;
SELECT * FROM Accounts;
SELECT * FROM Transactions;

CREATE TABLE IdentityTest (
    TestID INT IDENTITY(1,1) PRIMARY KEY,
    TestValue VARCHAR(30)
);

INSERT INTO IdentityTest (TestValue) VALUES ('A'),('B'),('C');
SELECT * FROM IdentityTest;

DELETE FROM IdentityTest WHERE TestID=2;
SELECT * FROM IdentityTest;

INSERT INTO IdentityTest (TestValue) VALUES ('After DELETE');
SELECT * FROM IdentityTest;

TRUNCATE TABLE IdentityTest;
SELECT * FROM IdentityTest;

INSERT INTO IdentityTest (TestValue) VALUES ('After TRUNCATE');
SELECT * FROM IdentityTest;

BEGIN TRANSACTION;
INSERT INTO IdentityTest (TestValue) VALUES ('Rollback test');
ROLLBACK TRANSACTION;
SELECT * FROM IdentityTest;

DROP TABLE IdentityTest;

INSERT INTO Customers (CustomerName, Address)
VALUES ('Kavin','Chromepet');

UPDATE Accounts
SET Balance=Balance+5000
WHERE AccountNo='ACC1001';

DELETE FROM Transactions
WHERE AccountID=1 AND TransactionText='Test transaction';

SELECT * FROM Accounts
WHERE AccountType='Savings' AND Balance>20000;

SELECT * FROM Accounts
WHERE BranchID=1 OR BranchID=2;

SELECT * FROM Accounts
WHERE AccountType IN ('Savings','Salary');

SELECT * FROM Accounts
WHERE OpenedDate BETWEEN '2026-07-01' AND '2026-09-30'
AND Balance>20000;

SELECT a.AccountNo,c.CustomerName,a.AccountType,a.Balance,a.OpenedDate
FROM Accounts a
JOIN Customers c ON a.CustomerID=c.CustomerID
WHERE a.OpenedDate>='2026-07-01'
AND a.OpenedDate<'2026-10-01'
AND a.Balance>20000;
