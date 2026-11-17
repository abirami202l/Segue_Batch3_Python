CREATE DATABASE HospitalDB;
GO
USE HospitalDB;
GO

CREATE TABLE Patients (
    PatientID INT IDENTITY(1,1) PRIMARY KEY,
    PatientName VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL
);

CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Doctors (
    DoctorID INT IDENTITY(1,1) PRIMARY KEY,
    DoctorName VARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    CONSTRAINT FK_Doctors_Departments FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);

CREATE TABLE Visits (
    VisitID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    VisitDate DATE NOT NULL,
    Diagnosis VARCHAR(200) NOT NULL,
    Prescription VARCHAR(500),
    Notes VARCHAR(MAX),
    Status VARCHAR(20) NOT NULL DEFAULT 'Open',
    CONSTRAINT CK_Visits_Date CHECK (VisitDate <= CONVERT(DATE,GETDATE())),
    CONSTRAINT CK_Visits_Status CHECK (Status IN ('Open','Completed','Cancelled')),
    CONSTRAINT FK_Visits_Patients FOREIGN KEY (PatientID)
        REFERENCES Patients(PatientID),
    CONSTRAINT FK_Visits_Doctors FOREIGN KEY (DoctorID)
        REFERENCES Doctors(DoctorID)
);

CREATE TABLE Billing (
    BillID INT IDENTITY(1,1) PRIMARY KEY,
    VisitID INT NOT NULL UNIQUE,
    BillAmount DECIMAL(10,2) NOT NULL,
    PaymentStatus VARCHAR(20) NOT NULL DEFAULT 'Pending',
    CONSTRAINT CK_Billing_Amount CHECK (BillAmount >= 0),
    CONSTRAINT CK_Billing_PaymentStatus CHECK (PaymentStatus IN ('Pending','Paid','Partially Paid')),
    CONSTRAINT FK_Billing_Visits FOREIGN KEY (VisitID)
        REFERENCES Visits(VisitID) ON DELETE CASCADE
);

INSERT INTO Patients (PatientName,Address) VALUES
('Anu','Chennai'),('Bharath','Tambaram'),('Chitra','Velachery'),
('Dinesh','Adyar'),('Eswari','Guindy'),('Fathima','Porur'),
('Ganesh','Avadi'),('Harini','OMR'),('Irfan','Anna Nagar'),('Janani','Pallavaram');

INSERT INTO Departments (DepartmentName) VALUES
('Cardiology'),('Neurology'),('Orthopedics'),('Dermatology'),('Pediatrics'),
('ENT'),('Oncology'),('General Medicine'),('Dental'),('Ophthalmology');

INSERT INTO Doctors (DoctorName,DepartmentID) VALUES
('Dr. Arun',1),('Dr. Bala',2),('Dr. Chitra',3),('Dr. Devi',4),('Dr. Ezhil',5),
('Dr. Farah',6),('Dr. Gopal',7),('Dr. Hari',8),('Dr. Indu',9),('Dr. Jaya',10);

INSERT INTO Visits (PatientID,DoctorID,VisitDate,Diagnosis,Prescription,Notes,Status) VALUES
(1,1,'2026-11-01','Hypertension','Medication A','Regular check-up','Open'),
(2,2,'2026-11-02','Migraine','Medication B','Headache review','Completed'),
(3,3,'2026-11-03','Knee pain','Medication C','Pain while walking','Open'),
(4,4,'2026-11-04','Skin allergy','Cream D','Rash on arm','Completed'),
(5,5,'2026-11-05','Fever','Medication E','Mild fever','Open'),
(6,6,'2026-11-06','Ear infection','Drops F','Ear pain','Completed'),
(7,7,'2026-11-07','Anemia','Medication G','Follow-up advised','Open'),
(8,8,'2026-11-08','Cold','Medication H','Common cold symptoms','Open'),
(9,9,'2026-11-09','Tooth decay','Treatment I','Dental consultation','Completed'),
(10,10,'2026-11-10','Eye irritation','Drops J','Eye examination','Open');

INSERT INTO Billing (VisitID,BillAmount,PaymentStatus) VALUES
(1,500,'Pending'),(2,700,'Paid'),(3,600,'Pending'),(4,450,'Paid'),
(5,300,'Pending'),(6,550,'Paid'),(7,800,'Pending'),(8,350,'Paid'),
(9,900,'Pending'),(10,400,'Paid');

SELECT * FROM Patients;
SELECT * FROM Departments;
SELECT * FROM Doctors;
SELECT * FROM Visits;
SELECT * FROM Billing;

ALTER TABLE Patients
ADD insurance_id VARCHAR(30) NULL;

EXEC sp_rename 'Visits','PatientVisits';

ALTER TABLE PatientVisits
DROP CONSTRAINT CK_Visits_Status;

SELECT COLUMN_NAME,DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='Patients';

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME IN ('Visits','PatientVisits');

INSERT INTO Patients (PatientName,Address,insurance_id)
VALUES ('Karthik','Chromepet','INS1001');

UPDATE PatientVisits
SET Status='Completed'
WHERE VisitID=1;

DELETE FROM Billing
WHERE VisitID=10;

SELECT p.PatientID,p.PatientName,v.VisitDate,v.Diagnosis
FROM Patients p
JOIN PatientVisits v ON p.PatientID=v.PatientID
WHERE v.VisitDate>='2026-11-01'
AND v.VisitDate<'2026-12-01';

SELECT d.DoctorID,d.DoctorName,dep.DepartmentName
FROM Doctors d
JOIN Departments dep ON d.DepartmentID=dep.DepartmentID
WHERE dep.DepartmentName LIKE '%Cardio%';

SELECT *
FROM PatientVisits
WHERE Diagnosis LIKE '%pain%';
