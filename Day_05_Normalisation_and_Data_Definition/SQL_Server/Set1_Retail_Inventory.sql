CREATE DATABASE RetailInventoryDB;
GO
USE RetailInventoryDB;
GO

CREATE TABLE Suppliers (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL UNIQUE,
    SupplierPhone VARCHAR(15) NOT NULL
);

CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE Warehouses (
    WarehouseID INT IDENTITY(1,1) PRIMARY KEY,
    WarehouseName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    SKU VARCHAR(20) NOT NULL UNIQUE,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,
    SupplierID INT NOT NULL,
    ReorderLevel INT NOT NULL DEFAULT 10,
    CONSTRAINT CK_Products_ReorderLevel CHECK (ReorderLevel >= 0),
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Products_Suppliers FOREIGN KEY (SupplierID)
        REFERENCES Suppliers(SupplierID) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE Inventory (
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    WarehouseID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 0,
    CONSTRAINT CK_Inventory_Quantity CHECK (Quantity >= 0),
    CONSTRAINT UQ_Inventory_Product_Warehouse UNIQUE (ProductID, WarehouseID),
    CONSTRAINT FK_Inventory_Products FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Inventory_Warehouses FOREIGN KEY (WarehouseID)
        REFERENCES Warehouses(WarehouseID) ON DELETE NO ACTION ON UPDATE CASCADE
);

INSERT INTO Suppliers (SupplierName, SupplierPhone) VALUES
('ABC Distributors','9876500001'),
('Global Traders','9876500002'),
('Metro Supplies','9876500003'),
('Prime Wholesale','9876500004'),
('City Distributors','9876500005'),
('Tech Source','9876500006'),
('Fresh Stock','9876500007'),
('United Suppliers','9876500008'),
('Apex Supply','9876500009'),
('NextGen Traders','9876500010');

INSERT INTO Categories (CategoryName) VALUES
('Electronics'),('Furniture'),('Stationery'),('Grocery'),('Clothing'),
('Footwear'),('Appliances'),('Sports'),('Toys'),('Accessories');

INSERT INTO Warehouses (WarehouseName) VALUES
('Chennai Central'),('Tambaram'),('Guindy'),('Ambattur'),('Avadi'),
('Porur'),('Velachery'),('Anna Nagar'),('OMR'),('Pallavaram');

INSERT INTO Products (SKU, ProductName, CategoryID, SupplierID, ReorderLevel) VALUES
('SKU001','Wireless Mouse',1,1,10),
('SKU002','Office Chair',2,2,5),
('SKU003','Notebook',3,3,20),
('SKU004','Rice Bag',4,4,15),
('SKU005','Cotton Shirt',5,5,8),
('SKU006','Running Shoes',6,6,6),
('SKU007','Mixer Grinder',7,7,4),
('SKU008','Football',8,8,7),
('SKU009','Building Blocks',9,9,10),
('SKU010','Wrist Watch',10,10,5);

INSERT INTO Inventory (ProductID, WarehouseID, Quantity) VALUES
(1,1,100),(2,2,40),(3,3,250),(4,4,80),(5,5,60),
(6,6,35),(7,7,25),(8,8,50),(9,9,70),(10,10,30);

SELECT * FROM Suppliers;
SELECT * FROM Categories;
SELECT * FROM Warehouses;
SELECT * FROM Products;
SELECT * FROM Inventory;

BEGIN TRY
    INSERT INTO Products (SKU, ProductName, CategoryID, SupplierID)
    VALUES ('SKU001','Duplicate Mouse',1,1);
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS DuplicateKeyError;
END CATCH;

BEGIN TRY
    INSERT INTO Products (SKU, ProductName, CategoryID, SupplierID)
    VALUES ('SKU011','Invalid Product',999,1);
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS MissingParentError;
END CATCH;

BEGIN TRY
    INSERT INTO Inventory (ProductID, WarehouseID, Quantity)
    VALUES (1,1,-5);
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS NegativeQuantityError;
END CATCH;

BEGIN TRY
    INSERT INTO Suppliers (SupplierName, SupplierPhone)
    VALUES (NULL,'9000000000');
END TRY
BEGIN CATCH
    SELECT ERROR_MESSAGE() AS NullMandatoryColumnError;
END CATCH;

SELECT * FROM Suppliers WHERE SupplierID=1;

UPDATE Suppliers
SET SupplierPhone='9888800001'
WHERE SupplierID=1;

SELECT * FROM Suppliers WHERE SupplierID=1;

SELECT * FROM Products WHERE SKU='SKU010';

DELETE FROM Products
WHERE SKU='SKU010';

SELECT * FROM Products WHERE SKU='SKU010';
SELECT * FROM Inventory WHERE ProductID=10;
