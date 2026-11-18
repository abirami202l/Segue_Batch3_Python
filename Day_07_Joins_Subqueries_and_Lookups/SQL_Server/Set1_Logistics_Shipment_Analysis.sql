

IF DB_ID('LogisticsDB') IS NULL CREATE DATABASE LogisticsDB;
GO
USE LogisticsDB;
GO


DROP TABLE IF EXISTS DeliveryEvents;
DROP TABLE IF EXISTS Shipments;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Carriers;
DROP TABLE IF EXISTS Hubs;
GO

CREATE TABLE Hubs (
    HubID    INT         PRIMARY KEY,
    HubName  VARCHAR(50) NOT NULL,
    City     VARCHAR(50) NOT NULL
);

CREATE TABLE Carriers (
    CarrierID   INT         PRIMARY KEY,
    CarrierName VARCHAR(50) NOT NULL
);

CREATE TABLE Customers (
    CustomerID   INT         PRIMARY KEY,
    CustomerName VARCHAR(60) NOT NULL,
    City         VARCHAR(50)
);

CREATE TABLE Employees (
    EmployeeID   INT         PRIMARY KEY,
    EmpName      VARCHAR(50) NOT NULL,
    HubID        INT         NULL REFERENCES Hubs(HubID),
    SupervisorID INT         NULL REFERENCES Employees(EmployeeID)   
);

CREATE TABLE Shipments (
    ShipmentID    INT           PRIMARY KEY,
    CustomerID    INT           NOT NULL REFERENCES Customers(CustomerID),
    CarrierID     INT           NOT NULL REFERENCES Carriers(CarrierID),
    OriginHubID   INT           NOT NULL REFERENCES Hubs(HubID),
    DestHubID     INT           NOT NULL REFERENCES Hubs(HubID),
    ShipDate      DATE          NOT NULL,
    PromisedDate  DATE          NOT NULL,
    DeliveredDate DATE          NULL,            
    ShippingCost  DECIMAL(10,2) NOT NULL
);

CREATE TABLE DeliveryEvents (
    EventID    INT          PRIMARY KEY,
    ShipmentID INT          NOT NULL REFERENCES Shipments(ShipmentID),
    HubID      INT          NOT NULL REFERENCES Hubs(HubID),
    EventType  VARCHAR(30)  NOT NULL,
    EventTime  DATETIME2    NOT NULL
);
GO


INSERT INTO Hubs VALUES
 (1,'Chennai Hub','Chennai'), (2,'Mumbai Hub','Mumbai'), (3,'Delhi Hub','Delhi'),
 (4,'Bengaluru Hub','Bengaluru'), (5,'Kolkata Hub','Kolkata');

INSERT INTO Carriers VALUES
 (1,'SwiftCargo'), (2,'RoadRunner'), (3,'SkyLine Freight'), (4,'TruNorth Logistics');

INSERT INTO Customers VALUES
 (1,'Zenith Retail','Chennai'), (2,'Orion Traders','Mumbai'), (3,'Lotus Exports','Delhi'),
 (4,'Maple Foods','Bengaluru'), (5,'Nova Textiles','Kolkata'), (6,'Pioneer Tools','Pune');

INSERT INTO Employees VALUES
 (1,'Arun',1,NULL), (2,'Bala',1,1), (3,'Chitra',2,1), (4,'Dev',1,2),
 (5,'Esha',2,3),    (6,'Farid',3,1), (7,'Gita',4,2),  (8,'Hari',3,6);

INSERT INTO Shipments
 (ShipmentID,CustomerID,CarrierID,OriginHubID,DestHubID,ShipDate,PromisedDate,DeliveredDate,ShippingCost) VALUES
 ( 1,1,1,1,2,'2026-01-05','2026-01-08','2026-01-07', 450),
 ( 2,1,2,1,3,'2026-01-06','2026-01-10','2026-01-14', 900),
 ( 3,1,1,2,4,'2026-01-07','2026-01-11','2026-01-11', 600),
 ( 4,1,3,3,5,'2026-01-10','2026-01-15','2026-01-19',1200),
 ( 5,1,2,4,1,'2026-01-12','2026-01-15','2026-01-15', 300),
 ( 6,2,1,1,2,'2026-01-08','2026-01-12','2026-01-13', 500),
 ( 7,2,3,2,3,'2026-01-09','2026-01-14','2026-01-17', 800),
 ( 8,3,2,3,1,'2026-01-11','2026-01-14','2026-01-16', 700),
 ( 9,3,4,4,2,'2026-01-12','2026-01-16','2026-01-21',1500),
 (10,4,1,1,4,'2026-01-15','2026-01-19','2026-01-18', 650),
 (11,4,4,2,1,'2026-01-16','2026-01-20', NULL       , 400),
 (12,5,3,3,2,'2026-01-18','2026-01-22','2026-01-27',1100),
 (13,5,2,1,3,'2026-01-20','2026-01-24','2026-01-24', 550),
 (14,2,1,4,3,'2026-01-21','2026-01-25','2026-01-26', 480),
 (15,3,4,1,4,'2026-01-22','2026-01-26','2026-01-30',1000),
 (16,4,3,2,4,'2026-01-23','2026-01-27','2026-01-27', 700);

INSERT INTO DeliveryEvents (EventID,ShipmentID,HubID,EventType,EventTime) VALUES
 ( 1, 1,1,'Picked Up','2026-01-05 09:00'), ( 2, 1,2,'Delivered','2026-01-07 15:30'),
 ( 3, 2,1,'Picked Up','2026-01-06 10:00'), ( 4, 2,4,'At Hub'   ,'2026-01-09 08:00'),
 ( 5, 2,3,'Delivered','2026-01-14 12:00'),
 ( 6, 3,2,'Picked Up','2026-01-07 11:00'), ( 7, 3,4,'Delivered','2026-01-11 17:00'),
 ( 8, 4,3,'Picked Up','2026-01-10 09:30'), ( 9, 4,1,'At Hub'   ,'2026-01-13 14:00'),
 (10, 4,5,'Delivered','2026-01-19 10:00'),
 (11, 7,2,'Picked Up','2026-01-09 08:00'), (12, 7,3,'Delivered','2026-01-17 09:00'),
 (13, 9,4,'Picked Up','2026-01-12 08:30'), (14, 9,2,'Delivered','2026-01-21 16:45'),
 (15,11,2,'Picked Up','2026-01-16 09:00'), (16,11,3,'At Hub'   ,'2026-01-19 13:00'),
 (17,12,3,'Picked Up','2026-01-18 10:15'), (18,12,2,'Delivered','2026-01-27 11:00');
GO







SELECT s.ShipmentID, cu.CustomerName, ca.CarrierName,
       s.PromisedDate, s.DeliveredDate,
       DATEDIFF(DAY, s.PromisedDate, s.DeliveredDate) AS DelayDays
FROM   Shipments s
INNER JOIN Carriers  ca ON ca.CarrierID  = s.CarrierID
INNER JOIN Customers cu ON cu.CustomerID = s.CustomerID
WHERE  DATEDIFF(DAY, s.PromisedDate, s.DeliveredDate) > 2
ORDER BY DelayDays DESC, s.ShipmentID;





SELECT cu.CustomerName,
       COUNT(s.ShipmentID)               AS ShipmentCount,
       ISNULL(SUM(s.ShippingCost), 0)    AS TotalShippingCost
FROM   Customers cu
LEFT JOIN Shipments s ON s.CustomerID = cu.CustomerID
GROUP BY cu.CustomerID, cu.CustomerName
ORDER BY TotalShippingCost DESC;




SELECT h.HubID, h.HubName
FROM   Hubs h
LEFT JOIN Shipments s ON s.OriginHubID = h.HubID
WHERE  s.ShipmentID IS NULL;





SELECT e.EmployeeID, e.EmpName AS Employee,
       ISNULL(sup.EmpName, '
FROM   Employees e
LEFT JOIN Employees sup ON sup.EmployeeID = e.SupervisorID
ORDER BY e.EmployeeID;





SELECT h.HubName,
       ISNULL(o.Outbound, 0) AS OutboundShipments,
       ISNULL(i.Inbound , 0) AS InboundShipments
FROM  (SELECT OriginHubID AS HubID, COUNT(*) AS Outbound FROM Shipments GROUP BY OriginHubID) o
FULL OUTER JOIN
      (SELECT DestHubID   AS HubID, COUNT(*) AS Inbound  FROM Shipments GROUP BY DestHubID)   i
      ON o.HubID = i.HubID
INNER JOIN Hubs h ON h.HubID = COALESCE(o.HubID, i.HubID)
ORDER BY h.HubID;




SELECT s.ShipmentID, cu.CustomerName,
       ho.HubName AS OriginHub, hd.HubName AS DestinationHub, s.ShippingCost
FROM   Shipments s
INNER JOIN Customers cu ON cu.CustomerID = s.CustomerID
INNER JOIN Hubs      ho ON ho.HubID      = s.OriginHubID
INNER JOIN Hubs      hd ON hd.HubID      = s.DestHubID
ORDER BY s.ShipmentID;



SELECT s.ShipmentID, ca.CarrierName, COUNT(e.EventID) AS EventsLogged
FROM   Shipments s
INNER JOIN Carriers ca ON ca.CarrierID = s.CarrierID
LEFT  JOIN DeliveryEvents e ON e.ShipmentID = s.ShipmentID
GROUP BY s.ShipmentID, ca.CarrierName
ORDER BY EventsLogged, s.ShipmentID;



SELECT ca.CarrierName,
       COUNT(*)                                                           AS DeliveredShipments,
       CAST(AVG(CAST(DATEDIFF(DAY, s.PromisedDate, s.DeliveredDate) AS DECIMAL(6,2))) AS DECIMAL(6,2)) AS AvgDelayDays
FROM   Carriers ca
INNER JOIN Shipments s ON s.CarrierID = ca.CarrierID
WHERE  s.DeliveredDate IS NOT NULL
GROUP BY ca.CarrierName
ORDER BY AvgDelayDays DESC;




SELECT sup.EmpName AS Supervisor, e1.EmpName AS Employee1, e2.EmpName AS Employee2
FROM   Employees e1
INNER JOIN Employees e2  ON e1.SupervisorID = e2.SupervisorID
                        AND e1.EmployeeID  < e2.EmployeeID
INNER JOIN Employees sup ON sup.EmployeeID  = e1.SupervisorID
ORDER BY Supervisor, Employee1;



SELECT h.HubName, COUNT(e.EmployeeID) AS Headcount
FROM   Hubs h
LEFT JOIN Employees e ON e.HubID = h.HubID
GROUP BY h.HubID, h.HubName
ORDER BY Headcount DESC;
GO





SELECT CustomerName
FROM   Customers
WHERE  CustomerID IN (SELECT CustomerID
                      FROM   Shipments
                      WHERE  CarrierID IN (SELECT CarrierID FROM Carriers
                                           WHERE  CarrierName = 'SwiftCargo'));



SELECT cu.CustomerName
FROM   Customers cu
WHERE  EXISTS (SELECT 1
               FROM   Shipments s
               WHERE  s.CustomerID = cu.CustomerID
                 AND  DATEDIFF(DAY, s.PromisedDate, s.DeliveredDate) > 2);




SELECT ShipmentID, CustomerID, ShippingCost
FROM   Shipments
WHERE  ShippingCost > ANY (SELECT ShippingCost FROM Shipments WHERE CustomerID = 2)
ORDER BY ShippingCost;



SELECT ShipmentID, CustomerID, ShippingCost
FROM   Shipments
WHERE  ShippingCost > ALL (SELECT ShippingCost FROM Shipments WHERE CustomerID = 4)
ORDER BY ShippingCost;




SELECT cu.CustomerName
FROM   Customers cu
WHERE  NOT EXISTS (SELECT 1
                   FROM   Hubs h
                   WHERE  NOT EXISTS (SELECT 1
                                      FROM   Shipments s
                                      WHERE  s.CustomerID = cu.CustomerID
                                        AND  s.DestHubID  = h.HubID));



SELECT cu.CustomerName
FROM   Customers cu
JOIN   Shipments s ON s.CustomerID = cu.CustomerID
GROUP BY cu.CustomerID, cu.CustomerName
HAVING COUNT(DISTINCT s.DestHubID) = (SELECT COUNT(*) FROM Hubs);


SELECT ca.CarrierName,
       CAST(AVG(CAST(DATEDIFF(DAY, s.PromisedDate, s.DeliveredDate) AS DECIMAL(6,2))) AS DECIMAL(6,2)) AS AvgDelay
FROM   Carriers ca
JOIN   Shipments s ON s.CarrierID = ca.CarrierID
WHERE  s.DeliveredDate IS NOT NULL
GROUP BY ca.CarrierID, ca.CarrierName
HAVING AVG(CAST(DATEDIFF(DAY, s.PromisedDate, s.DeliveredDate) AS DECIMAL(6,2)))
       > (SELECT AVG(CAST(DATEDIFF(DAY, PromisedDate, DeliveredDate) AS DECIMAL(6,2)))
          FROM   Shipments
          WHERE  DeliveredDate IS NOT NULL);

GO






SELECT DISTINCT cu.CustomerName
FROM   Customers cu
INNER JOIN Shipments s ON s.CustomerID = cu.CustomerID
WHERE  DATEDIFF(DAY, s.PromisedDate, s.DeliveredDate) > 2;



WITH CarrierAvg AS (
    SELECT CarrierID,
           AVG(CAST(DATEDIFF(DAY, PromisedDate, DeliveredDate) AS DECIMAL(6,2))) AS AvgDelay
    FROM   Shipments
    WHERE  DeliveredDate IS NOT NULL
    GROUP BY CarrierID
),
OverallAvg AS (
    SELECT AVG(CAST(DATEDIFF(DAY, PromisedDate, DeliveredDate) AS DECIMAL(6,2))) AS OverallDelay
    FROM   Shipments
    WHERE  DeliveredDate IS NOT NULL
)
SELECT ca.CarrierName,
       CAST(a.AvgDelay AS DECIMAL(6,2))        AS CarrierAvgDelay,
       CAST(o.OverallDelay AS DECIMAL(6,2))    AS OverallAvgDelay
FROM   CarrierAvg a
INNER JOIN Carriers   ca ON ca.CarrierID = a.CarrierID
CROSS JOIN OverallAvg o
WHERE  a.AvgDelay > o.OverallDelay;

GO



SELECT h.HubName,
       (SELECT MAX(s.ShippingCost)
        FROM   Shipments s
        WHERE  s.OriginHubID = h.HubID
          AND  s.ShippingCost < (SELECT MAX(s2.ShippingCost)          
                                 FROM   Shipments s2
                                 WHERE  s2.OriginHubID = h.HubID)) AS SecondHighestCost
FROM   Hubs h
ORDER BY h.HubID;

GO
