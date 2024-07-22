-- assignment04.sql
-- Activity 04 Fall 2023
-- Revision History:
-- , Section 01, 02-12-2023


Print 'F23 PROG8080 Section 1';
Print 'Activity 4';
Print '';
Print '';
Print '';
Print GETDATE();
Print '';



--- Question 1 ---
Print 'Question 1';

IF DB_ID('SWC_M') IS NOT NULL
BEGIN
    PRINT 'Dropping existing database';
    USE master;
    DROP DATABASE SWC_M;
END
CREATE DATABASE SWC_M;

USE SWC_M;


---Question 2 ---
Print 'Question 2';
CREATE TABLE PartType(
  PartTypeId INT IDENTITY(1,1) PRIMARY KEY,
  PartTypeName varchar(50) NOT NULL
);


CREATE TABLE Supplier(
  SupplierID int IDENTITY(1,1) PRIMARY KEY,
  SupplierName varchar(50) NOT NULL
);


CREATE TABLE Part(
  PartID int IDENTITY(1,1) PRIMARY KEY,
  PartNumber varchar(50) NOT NULL,
  PartDescription varchar(100) NOT NULL,
  UnitPrice decimal(10,2) NOT NULL,
  SupplierID int NOT NULL,
  PartTypeID int NOT NULL,
  Quantity INT NOT NULL,
  FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
  FOREIGN KEY (PartTypeID) REFERENCES PartType(PartTypeID),
  CHECK (UnitPrice >= 0),
  CHECK (LEN(PartDescription)>=3 AND Quantity>0)
);

CREATE TABLE Purchaser(
  PurchaserID int IDENTITY(1,1) PRIMARY KEY,
  FirstName varchar(100) NOT NULL,
  LastName varchar(100) NOT NULL,
  Email varchar(150) NOT NULL,
  StreetNumber varchar(25) NOT NULL,
  StreetName varchar(190) NOT NULL,
  City varchar(99) NOT NULL,
  Province varchar(99) NOT NULL,
  Country varchar(99) NOT NULL,
  PostalCode varchar(50) NOT NULL,
  Phone varchar(90) NOT NULL,
  CHECK (LEN(FirstName) >= 3),
  CHECK (LEN(LastName) >= 3)
);

CREATE TABLE DesktopBundle(
  DesktopBundleID int IDENTITY(1,1) PRIMARY KEY,
  BundleName varchar(50) NOT NULL
);


CREATE TABLE Purchase(
  PurchaseID int IDENTITY(1,1) PRIMARY KEY,
  PurchaseDate date NOT NULL,
  Quantity int NOT NULL,
  PurchaserID int NOT NULL,
  PartID int NOT NULL,
  DesktopBundleID int,
  FOREIGN KEY (PurchaserID) REFERENCES Purchaser(PurchaserID),
  FOREIGN KEY (PartID) REFERENCES Part(PartID),
  FOREIGN KEY (DesktopBundleID) REFERENCES DesktopBundle(DesktopBundleID),
  CHECK (Quantity > 0)
);

--Question 5
Print 'Question 5';
ALTER TABLE Part
ADD CONSTRAINT FK_Supplier
FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID);

ALTER TABLE Part
ADD CONSTRAINT FK_PartType
FOREIGN KEY (PartTypeID) REFERENCES PartType(PartTypeID);

ALTER TABLE Purchase
ADD CONSTRAINT FK_Purchaser
FOREIGN KEY (PurchaserID) REFERENCES Purchaser(PurchaserID);


--Question 6
Print 'Question 6';
ALTER TABLE Purchaser
ADD CONSTRAINT CK_Purchaser CHECK (LEN(FirstName)>=3 AND LEN(LastName)>=3);

ALTER TABLE Part
ADD CONSTRAINT CK_Part CHECK (LEN(PartDescription)>=3 AND UnitPrice>=0 AND Quantity>0);


--Question 7
Print 'Question 7';
ALTER TABLE Purchaser
ADD CONSTRAINT DF_Purchaser_Country DEFAULT 'Canada' FOR Country;

--Question 8
Print 'Question 8';
INSERT INTO PartType (PartTypeName)
VALUES ('Desktop'),
       ('Tablet'),
       ('Mouse'),
       ('Keyboard'),
	   ('Camera'),
	   ('Monitor')

INSERT INTO Supplier (SupplierName)
VALUES ('Dell'),
       ('HP'),
	   ('Samsung'),
	   ('Lenovo'),
	   ('Max')


INSERT INTO Part (SupplierID, PartTypeID,PartNumber, PartDescription, UnitPrice,Quantity)
VALUES (1, 1, 'DL1010', 'Dell Optiplex 1010', 40.00,25),
       (1, 1,  'DL5040','Dell Optiplex 5040 ', 150.00,50),
       (4, 6,  'DLM190','Dell 19-inch Monitor ', 35.00,25),
       (3, 1,  'HP400','HP Desktop Tower', 60.00,15),
       (2, 1,  'HP800','HP EliteDesk 800G1 ', 200.00,20),
       (2, 6,  'HPM270','HP 27-inch Monitor', 120.00,20),
       (3, 2,  'SM330','Samsung Galaxy Tab 7� Android Tablet', 110.00,10),
       (1, 4,  'LEN101','Lenovo 101-Key Computer Keyboard', 7.00,50),
       (3, 3,  'LEN102','Lenovo Mouse', 5.00,50),
	   (3, 6,  'DLM240','Dell 24-inch Monitor', 80.00,80),
	   (3, 6,  'HPM220','HP 22-inch Monitor ', 45.00,30),
	   (2, 3,  'LEN102','Lenovo Mouse', 5.00,100),
	   (2, 5,  'MAX901','Max Web Camera', 20.00,40),
	   (2, 4,  'HP501','HP 101-Key Computer Keyboard', 9.00,100),
	   (2, 3,  'HP502','HP Mouse', 6.00,100);


INSERT INTO Purchaser (FirstName, LastName, Email, StreetNumber, StreetName, City, Province, Country, PostalCode, Phone)
VALUES ('Joey', 'Holt', 'joey.holt@example.com', '123 Avenue', 'Waterloo', 'Waterloo', 'ON', 'Canada', 'N2N 3C3', '519-555-1111'),
       ('Klaus', 'Rob', 'klaus.rob@example.com', '456 Avenue', 'Kitchener', 'Kitchener', 'ON', 'Canada', 'N2N 3C3', '519-555-2222'),
       ('Guntar', 'Boyul', 'guntarboyul@example.com', 'Random St', 'Waterloo', 'Waterloo', 'ON', 'Canada', 'N1R 2C2', '519-555-3333'),
       ('Jack', 'Danger', 'jackdanger@example.com', '101 clover St', 'Toronto', 'Toronto', 'ON', 'Canada', 'N1G 2W2', '519-555-4444');

INSERT INTO Purchaser (FirstName, LastName, Email, StreetNumber, StreetName, City, Province, PostalCode, Phone)
VALUES ('', '', '@gmail.com', '123 Waterloo St', 'Waterloo', 'Waterloo', 'ON', 'N2L 3C3', '519-555-9999');


INSERT INTO DesktopBundle (BundleName)
VALUES ('HP Eco bundle'),
       ('Dell Standard bundle');



INSERT INTO Purchase (PartID, PurchaserID, DesktopBundleID, PurchaseDate, Quantity)
VALUES (1, 1,1 , '2022-10-31',  4),
       (6, 2,2, '2022-11-10',  3),
       (8, 3, 1, '2022-11-15',  10),
       (11, 4, 2, '2022-11-30',  15);




--Question 9
Print 'Question 9';
CREATE INDEX idx_purchaser_phone ON Purchaser(Phone);


-- Create unique index for purchaser's email
CREATE UNIQUE INDEX idx_purchaser_email ON Purchaser(Email);

--INSERT INTO Purchaser (FirstName, LastName, Email, StreetNumber, StreetName, City, Province, Country, PostalCode, Phone)
--VALUES ('John', 'Smith', 'johnsmith@email.com', '123 Northmanor St', 'Waterloo', 'Waterloo', 'ON', 'Canada', 'N2L 3M1', '519-555-1111');




--Question 10
Print 'Question 10';
GO

CREATE VIEW purchase_details_extended_amount AS
SELECT pt.PartNumber, pt.SupplierID, pt.PartTypeID, pt.PartDescription, pu.FirstName, pu.LastName, pu.Email, pu.StreetNumber, pu.StreetName, pu.City, pu.Province, pu.Country, pu.PostalCode, pu.Phone, p.PurchaseDate, pt.UnitPrice, pt.Quantity, (pt.UnitPrice * pt.Quantity) AS extended_amount
FROM Purchase p
JOIN Part pt ON p.PartID = pt.PartID
JOIN Purchaser pu ON p.PurchaserID = pu.PurchaserID;

GO
SELECT * FROM purchase_details_extended_amount ORDER BY FirstName, PurchaseDate, PartNumber;

--Question 11
Print 'Question 11';
GO

CREATE VIEW desktop_bundle_total_cost_2 AS
SELECT  db.BundleName, SUM(pt.UnitPrice * p.Quantity) AS total_cost
FROM Purchase p
JOIN DesktopBundle db ON p.DesktopBundleID = db.DesktopBundleID
JOIN Part pt ON p.PartID = pt.PartID
GROUP BY db.BundleName;
--Ordering using DesktopBundleID

Go
SELECT * FROM desktop_bundle_total_cost_2 order by BundleName;


GO
CREATE TRIGGER update_quantity_trigger
ON Purchase AFTER INSERT
AS BEGIN
UPDATE Part
SET Quantity = p.Quantity - i.Quantity FROM Part p
INNER JOIN inserted i ON p.PartID = i.PartID;
END;

INSERT INTO Purchase (PartID, PurchaserID, DesktopBundleID, PurchaseDate, Quantity)
VALUES (2, 1,1 , '2022-10-31',  15);

Select * from Part;


print('Part');
Select * from Part;

print('Parttype');
Select * from PartType;

print('Purchase');
Select * From Purchase;

print('Purchaser');
Select * from Purchaser;

print('Supplier');
Select * from Supplier;

print('Desktop Bundles');
Select * from DesktopBundle;

