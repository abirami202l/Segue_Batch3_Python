

IF DB_ID('BankLoanDB') IS NULL CREATE DATABASE BankLoanDB;
GO
USE BankLoanDB;
GO


DROP TABLE IF EXISTS Guarantees;
DROP TABLE IF EXISTS Repayments;
DROP TABLE IF EXISTS Loans;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Branches;
GO

CREATE TABLE Branches (
    BranchID   INT         PRIMARY KEY,
    BranchName VARCHAR(50) NOT NULL,
    City       VARCHAR(50) NOT NULL
);

CREATE TABLE Customers (
    CustomerID INT         PRIMARY KEY,
    CustName   VARCHAR(60) NOT NULL
);

CREATE TABLE Loans (
    LoanID        INT           PRIMARY KEY,
    CustomerID    INT           NOT NULL REFERENCES Customers(CustomerID),   
    BranchID      INT           NOT NULL REFERENCES Branches(BranchID),
    Amount        DECIMAL(12,2) NOT NULL,
    EMIAmount     DECIMAL(10,2) NOT NULL,        
    StartDate     DATE          NOT NULL,
    TenureMonths  INT           NOT NULL
);

CREATE TABLE Repayments (                         
    RepaymentID INT IDENTITY(1,1) PRIMARY KEY,
    LoanID      INT           NOT NULL REFERENCES Loans(LoanID),
    PaidDate    DATE          NOT NULL,
    Amount      DECIMAL(10,2) NOT NULL
);

CREATE TABLE Guarantees (                         
    GuaranteeID INT PRIMARY KEY,
    LoanID      INT NOT NULL REFERENCES Loans(LoanID),
    GuarantorID INT NOT NULL REFERENCES Customers(CustomerID)
);
GO


INSERT INTO Branches VALUES
 (1,'Adyar','Chennai'), (2,'Anna Nagar','Chennai'), (3,'Velachery','Chennai'), (4,'Tambaram','Chennai');

INSERT INTO Customers VALUES
 (1,'Anand'), (2,'Bhavana'), (3,'Chandru'), (4,'Deepa'), (5,'Elango'), (6,'Fathima'), (7,'Gokul');

INSERT INTO Loans (LoanID,CustomerID,BranchID,Amount,EMIAmount,StartDate,TenureMonths) VALUES
 (1,1,1, 500000, 45000,'2026-05-01',12),
 (2,1,2, 300000, 27000,'2026-07-01',12),
 (3,2,1, 800000, 72000,'2026-04-01',12),
 (4,3,2, 200000, 18000,'2026-06-01',12),
 (5,4,3,1200000,105000,'2026-08-01',12),
 (6,5,3, 450000, 40000,'2026-03-01',12),
 (7,2,3, 250000, 23000,'2026-09-01',12),
 (8,6,1, 150000, 14000,'2026-02-01',12);


INSERT INTO Repayments (LoanID, PaidDate, Amount)
SELECT p.LoanID,
       DATEADD(DAY, 4, DATEADD(MONTH, n.n - 1, l.StartDate)),
       l.EMIAmount
FROM  (VALUES (1,6),(2,4),(3,2),(4,1),(5,3),(6,6),(7,2),(8,4)) AS p(LoanID, Cnt)
JOIN   Loans l ON l.LoanID = p.LoanID
JOIN  (VALUES (1),(2),(3),(4),(5),(6)) AS n(n) ON n.n <= p.Cnt;

INSERT INTO Guarantees VALUES
 (1,3,1),   
 (2,4,7),   
 (3,5,2),   
 (4,6,7),   
 (5,8,5);   
GO



DECLARE @AsOf DATE = '2026-11-18';






SELECT l.LoanID, c.CustName, b.BranchName,
       d.InstalmentsDue,
       COUNT(r.RepaymentID)                       AS InstalmentsPaid,
       d.InstalmentsDue - COUNT(r.RepaymentID)    AS InstalmentsOverdue
FROM   Loans l
INNER JOIN Customers c ON c.CustomerID = l.CustomerID
INNER JOIN Branches  b ON b.BranchID   = l.BranchID
LEFT  JOIN Repayments r ON r.LoanID    = l.LoanID
CROSS APPLY (SELECT CASE WHEN DATEDIFF(MONTH, l.StartDate, @AsOf) > l.TenureMonths
                         THEN l.TenureMonths
                         ELSE DATEDIFF(MONTH, l.StartDate, @AsOf) END AS InstalmentsDue) d
GROUP BY l.LoanID, c.CustName, b.BranchName, d.InstalmentsDue
HAVING d.InstalmentsDue - COUNT(r.RepaymentID) > 3
ORDER BY InstalmentsOverdue DESC;




SELECT c.CustName, COUNT(DISTINCT l.BranchID) AS BranchesUsed, COUNT(*) AS Loans
FROM   Customers c
INNER JOIN Loans l ON l.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustName
HAVING COUNT(DISTINCT l.BranchID) > 1;






SELECT g.CustName AS Guarantor, b.CustName AS GuaranteedBorrower, l.LoanID, l.Amount
FROM   Guarantees gu
INNER JOIN Customers g  ON g.CustomerID = gu.GuarantorID
INNER JOIN Loans     l  ON l.LoanID     = gu.LoanID
INNER JOIN Customers b  ON b.CustomerID = l.CustomerID
INNER JOIN (SELECT DISTINCT CustomerID FROM Loans) ob ON ob.CustomerID = g.CustomerID;




SELECT b.BranchID, b.BranchName
FROM   Branches b
LEFT JOIN Loans l ON l.BranchID = b.BranchID
WHERE  l.LoanID IS NULL;




SELECT c.CustName, COUNT(l.LoanID) AS LoanCount, ISNULL(SUM(l.Amount), 0) AS TotalExposure
FROM   Customers c
LEFT JOIN Loans l ON l.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustName
ORDER BY TotalExposure DESC;




SELECT c.CustName,
       CASE WHEN bo.CustomerID IS NOT NULL AND gu.GuarantorID IS NOT NULL THEN 'Borrower + Guarantor'
            WHEN bo.CustomerID IS NOT NULL                                THEN 'Borrower only'
            ELSE                                                               'Guarantor only' END AS Role
FROM  (SELECT DISTINCT CustomerID  FROM Loans)      bo
FULL OUTER JOIN
      (SELECT DISTINCT GuarantorID FROM Guarantees) gu ON gu.GuarantorID = bo.CustomerID
INNER JOIN Customers c ON c.CustomerID = COALESCE(bo.CustomerID, gu.GuarantorID)
ORDER BY c.CustomerID;



SELECT l.LoanID, c.CustName, l.Amount,
       COUNT(r.RepaymentID)           AS InstalmentsPaid,
       ISNULL(SUM(r.Amount), 0)       AS TotalRepaid
FROM   Loans l
INNER JOIN Customers c ON c.CustomerID = l.CustomerID
LEFT  JOIN Repayments r ON r.LoanID = l.LoanID
GROUP BY l.LoanID, c.CustName, l.Amount
ORDER BY l.LoanID;



SELECT b.BranchName, COUNT(l.LoanID) AS Loans, ISNULL(SUM(l.Amount), 0) AS Portfolio
FROM   Branches b
LEFT JOIN Loans l ON l.BranchID = b.BranchID
GROUP BY b.BranchID, b.BranchName
ORDER BY Portfolio DESC;



SELECT l.LoanID, bw.CustName AS Borrower, g.CustName AS Guarantor, br.BranchName, l.Amount
FROM   Guarantees gu
INNER JOIN Loans     l  ON l.LoanID      = gu.LoanID
INNER JOIN Customers bw ON bw.CustomerID = l.CustomerID
INNER JOIN Customers g  ON g.CustomerID  = gu.GuarantorID
INNER JOIN Branches  br ON br.BranchID   = l.BranchID
ORDER BY l.LoanID;



SELECT b.BranchName, COUNT(*) AS Payments, SUM(r.Amount) AS Collected
FROM   Repayments r
INNER JOIN Loans    l ON l.LoanID   = r.LoanID
INNER JOIN Branches b ON b.BranchID = l.BranchID
WHERE  r.PaidDate >= DATEADD(DAY, -60, @AsOf)
GROUP BY b.BranchName
ORDER BY Collected DESC;







WITH Exposure AS (
    SELECT CustomerID, BranchID, SUM(Amount) AS Exposure
    FROM   Loans
    GROUP BY CustomerID, BranchID
)
SELECT c.CustName, b.BranchName, e.Exposure,
       (SELECT AVG(e2.Exposure) FROM Exposure e2 WHERE e2.BranchID = e.BranchID) AS BranchAvg
FROM   Exposure e
JOIN   Customers c ON c.CustomerID = e.CustomerID
JOIN   Branches  b ON b.BranchID   = e.BranchID
WHERE  e.Exposure > (SELECT AVG(e2.Exposure)
                     FROM   Exposure e2
                     WHERE  e2.BranchID = e.BranchID)          
ORDER BY b.BranchName;




SELECT c.CustName, SUM(l.Amount) AS TotalExposure
FROM   Customers c
JOIN   Loans l ON l.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustName
HAVING SUM(l.Amount) > (SELECT AVG(t.Total)
                        FROM  (SELECT SUM(Amount) AS Total FROM Loans GROUP BY CustomerID) t);






SELECT c.CustomerID, c.CustName
FROM   Customers c
WHERE  EXISTS (SELECT 1 FROM Loans l WHERE l.CustomerID = c.CustomerID)
  AND  NOT EXISTS (SELECT 1
                   FROM   Loans l
                   JOIN   Repayments r ON r.LoanID = l.LoanID
                   WHERE  l.CustomerID = c.CustomerID
                     AND  r.PaidDate  >= DATEADD(DAY, -60, @AsOf));



SELECT c.CustomerID, c.CustName
FROM   Customers c
WHERE  EXISTS (SELECT 1
               FROM   Loans l
               JOIN   Repayments r ON r.LoanID = l.LoanID
               WHERE  l.CustomerID = c.CustomerID
                 AND  r.PaidDate  >= DATEADD(DAY, -60, @AsOf));




SELECT b.BranchName, MAX(l.Amount) AS HighestLoan
FROM   Branches b
JOIN   Loans l ON l.BranchID = b.BranchID
GROUP BY b.BranchID, b.BranchName
HAVING MAX(l.Amount) > (SELECT AVG(m.MaxAmount)                       
                        FROM  (SELECT MAX(Amount) AS MaxAmount        
                               FROM   Loans
                               GROUP BY BranchID) m);


GO
