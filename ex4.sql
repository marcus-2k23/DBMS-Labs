-- Ex4_M.SQL
-- Fall 2023 Exercise 4
-- , Section 1, 2023.11.25: Created
-- , Section 1, 2023.11.25: Updated

Print 'F23 PROG8080 Section 01';
Print 'Exercise 04';
Print '';
Print ' - 8829569';
Print '';
Print GETDATE();
Print '';

USE AP;



-- Question 1
Print '';
Print 'Question 1';
Print '';
IF OBJECT_ID('VendorCopyM') IS NOT NULL
   DROP TABLE VendorCopyM;
SELECT *
INTO VendorCopyM
FROM Vendors;
Select COUNT(*) as "Number of rows in VendorCopyM" from VendorCopyM;


-- Question 2
Print '';
Print 'Question 2';
Print '';
IF OBJECT_ID('InvoiceBalancesM') IS NOT NULL
   DROP TABLE InvoiceBalancesM;
SELECT *
INTO InvoiceBalancesM
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal <> 0

Select COUNT(*) AS "Total Number of rows in InvoiceBalancesM" FROM InvoiceBalancesM;


-- Question 3
Print '';
Print 'Question 3 ';
Print '';
INSERT INTO InvoiceBalancesM VALUES (  86, 4591178, '2022-01-09', 9345.60, 0, 0, 1, '2022-01-10', NULL  );
SELECT * 
FROM InvoiceBalancesM
WHERE InvoiceID = (SELECT MAX(InvoiceID) FROM InvoiceBalancesM) 
AND InvoiceBalancesM.VendorID = 86;



-- Question 4
Print '';
Print 'Question 4';
Print '';
INSERT INTO InvoiceBalancesM (VendorID, 
								InvoiceNumber, 
								InvoiceTotal, 
								PaymentTotal, 
								CreditTotal, 
								TermsID, 
								InvoiceDate,
								InvoiceDueDate ) 
					VALUES ( 30,
							'COSTCO345',
							2800.00,
							0,
							0,
							1,
							GETDATE(),
							GETDATE()+30);
SELECT * FROM InvoiceBalancesM
WHERE InvoiceID = (SELECT MAX(InvoiceID) FROM InvoiceBalancesM) 
AND InvoiceBalancesM.VendorID = 30;



-- Question 5
Print '';
Print 'Question 5';
Print '';
UPDATE InvoiceBalancesM
	SET CreditTotal = 300.00 
	WHERE InvoiceNumber = 'COSTCO345' 

SELECT * FROM InvoiceBalancesM WHERE InvoiceNumber = 'COSTCO345';


-- Question 6
Print 'Question 6';
UPDATE TOP (5) InvoiceBalancesM
SET CreditTotal = CreditTotal + 90
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 900;

SELECT InvoiceID, InvoiceNumber, VendorID, InvoiceTotal, CreditTotal
FROM InvoiceBalancesM;



-- Question 7
Print 'Question 7';
DELETE FROM InvoiceBalancesM
WHERE InvoiceNumber = '4591178';

SELECT * FROM InvoiceBalancesM;




-- Question 8
Print '';
Print 'Question 8';
Print ''; 

SELECT COUNT(*) AS "Total Count before Deleting" FROM VendorCopyM;

DELETE FROM VendorCopyM
WHERE VendorID  NOT IN (SELECT DISTINCT VendorID FROM InvoiceBalancesM)

SELECT COUNT(*) AS "Total Count after Deleting" FROM VendorCopyM;



-- Question 9
Print '';
Print 'Question 9 ';
Print ''; 
DECLARE @VendorID INT = '123'; 
BEGIN TRAN;
DELETE FROM InvoiceBalancesM
WHERE VendorID = @VendorID;

IF @@ROWCOUNT > 1
    BEGIN
        ROLLBACK TRAN;
        PRINT 'More invoices than expected. Deletions rolled back.';
    END;
ELSE
    BEGIN
        COMMIT TRAN;
        PRINT 'Deletions committed to the database.';
    END;

SELECT COUNT(*) AS "Number of FedEx invoices" FROM InvoiceBalancesM WHERE VENDORID = 123;



-- Question 10
Print '';
Print 'Question 10 ';
Print '';

SELECT COUNT(*) as "Number of Invoices" FROM Invoices;

SELECT COUNT(*) as "Number of InvoiceLineItems" FROM InvoiceLineItems;

DECLARE @InvoiceID int;
BEGIN TRY
    BEGIN TRAN;
    INSERT Invoices
      VALUES (34,'ZXA-080','2020-03-01',14092.59,0,0,3,'2020-03-31',NULL);
    SET @InvoiceID = @@IDENTITY;
    INSERT InvoiceLineItems VALUES (@InvoiceID,1,160,4447.23,'HW upgrade');
    INSERT InvoiceLineItems
      VALUES (@InvoiceID,2,167,9645.36,'OS upgrade');
    COMMIT TRAN;
END TRY
BEGIN CATCH
    ROLLBACK TRAN;
END CATCH;

SELECT COUNT(*) as "Number of Invoices" FROM Invoices;

SELECT COUNT(*) as "Number of InvoiceLineItems" FROM InvoiceLineItems;
