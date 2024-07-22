-- ex3_M.sql
-- In Class Task3 Exercise3
-- Revision History:
-- , Section 1 - MSD, 2023.11.09: Created
-- , Section 1 - MSD, 2023.11.09: Updated


Print 'In Class Exercise 3';
Print '';
Print ' - 8829569';
Print '';
Print GETDATE();
Print '';

USE AP;

-- Question 1
-- List the Invoice Number and Vendor Name columns for invoices with a Vendor Name of �Compuserve�. Use implicit syntax for the inner join.
Print '  Question 1  ';
Print 'List the Invoice Number and Vendor Name columns for invoices with a Vendor Name of �Compuserve�.';
Print '';
SELECT InvoiceNumber, VendorName FROM Invoices
JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
WHERE VendorName = 'Compuserve';


-- Question 2
-- List the 5 columns (Invoice Number, Vendor ID, Vendor Name, Invoice Due Date and Balance Due) for invoices with �Balance Due� greater than $500. Use explicit syntax for the inner join. Sort the result by �Balance Due� in ascending order
Print '  Question 2  ';
Print 'List the 5 columns for invoices with �Balance Due� greater than $500.';
Print '';
SELECT Invoices.InvoiceNumber, Vendors.VendorID, Vendors.VendorName,
Invoices.InvoiceDueDate, Invoices.InvoiceTotal
FROM Invoices
INNER JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
WHERE Invoices.InvoiceTotal > 500
ORDER BY Invoices.InvoiceTotal ASC;


-- Question 3
-- List the 4 columns: Vendor ID and Vendor Name of vendors, along with the Invoice Number and Invoice Total of the vendors with vendor name that starts with �in�. Display the vendor even if they do not have any invoices. Use explicit syntax for the outer join. Sort the result by Vendor Name in descending order. Do not use any correlation name or table alias.
Print '  Question 3  ';
Print 'List the 4 columns: Vendor ID and Vendor Name of vendors, along with the Invoice Number and Invoice Total of the vendors';
Print '';
SELECT Vendors.VendorID, Vendors.VendorName, Invoices.InvoiceNumber, Invoices.InvoiceTotal
FROM Vendors
LEFT OUTER JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
WHERE Vendors.VendorName LIKE 'in%'
ORDER BY Vendors.VendorName DESC;


-- Question 4
-- List the 3 columns for invoices with Invoice Date after Dec. 31, 2018. The first column displays �After 12/31/2018� followed by 2 columns using MIN() and MAX() aggregate functions with the Invoice Total column as the argument.
Print '  Question 4  ';
Print 'List the 3 columns for invoices with Invoice Date after Dec. 31, 2018. The first column displays �After 12/31/2018� followed by 2 columns using MIN() and MAX() aggregate functions with the Invoice Total column as the argument.';
Print '';
SELECT 'After 12/31/2018' AS SelectionDate,
       MIN(InvoiceTotal) AS LowestInvoiceTotal,
       MAX(InvoiceTotal) AS HighestInvoiceTotal
FROM Invoices
WHERE InvoiceDate > '2018-12-31';


-- Question 5
-- Construct a summary query that groups by two columns (Vendor State and Vendor City). List the same two columns followed by the COUNT() and AVG() aggregate functions with the Invoice Total column as the argument. Use FORMAT() to display the Average Amount column in currency format. Sort the result by Vendor State and Vendor City columns.
Print '  Question 5  ';
Print 'Construct a summary query that groups by two columns (Vendor State and Vendor City). ';
Print '';
SELECT Vendors.VendorState, Vendors.VendorCity,
       COUNT(Invoices.InvoiceTotal) AS InvoiceQty,
       FORMAT(AVG(Invoices.InvoiceTotal), 'C') AS AvgAmount
FROM Invoices
INNER JOIN Vendors ON Invoices.VendorID = Vendors.VendorID
GROUP BY Vendors.VendorState, Vendors.VendorCity
ORDER BY Vendors.VendorState, Vendors.VendorCity;

-- Question 6
-- Construct a summary query with a search condition in the WHERE clause for invoices in December, 2019. The query displays the Invoice Date followed by the �Invoice Qty� and �Invoice Sum�. Only display the result with �Invoices Qty� above 2 and �Invoice Sum� of over $1,000. Sort the result by �Invoice Date� in descending order.
Print '  Question 6  ';
Print 'Construct a summary query with a search condition in the WHERE clause for invoices in December, 2019.  ';
Print '';
SELECT InvoiceDate, COUNT(*) AS InvoiceQty, SUM(InvoiceTotal) AS InvoiceSum
FROM Invoices
WHERE YEAR(InvoiceDate) = 2019 AND MONTH(InvoiceDate) = 12
GROUP BY InvoiceDate
HAVING COUNT(*) > 2 AND SUM(InvoiceTotal) > 1000
ORDER BY InvoiceDate DESC;


-- Question 7
-- Construct a nested subquery that returns a list of Invoice Number, Invoice Date and Invoice Total columns for vendors in the state of Texas (TX). The inner query must use the Vendors table. Sort the result by Invoice Date in descending order.
Print '  Question 7  ';
Print 'Construct a nested subquery that returns a list of Invoice Number, Invoice Date and Invoice Total columns for vendors in the state of Texas (TX).';
Print '';
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices
WHERE VendorID IN (
  SELECT VendorID
  FROM Vendors
  WHERE VendorState = 'TX'
)
ORDER BY InvoiceDate DESC;


-- Question 8
-- Construct a nested subquery that returns a list of invoices for a vendor with Invoice Total above the Average Invoice Total for that vendor. Use a correlated subquery in the WHERE clause. Only include invoices with Invoice Total above $1,000. Order the results by Vendor ID in ascending order, followed by Invoice Total in descending order.
Print '  Question 8  ';
Print 'Construct a nested subquery that returns a list of invoices for a vendor with Invoice Total above the Average Invoice Total for that vendor';
Print '';
SELECT InvoiceNumber, VendorID, InvoiceTotal
FROM Invoices i1
WHERE InvoiceTotal > 1000 AND InvoiceTotal > (
  SELECT AVG(InvoiceTotal)
  FROM Invoices i2
  WHERE i2.VendorID = i1.VendorID
) 
ORDER BY VendorID ASC, InvoiceTotal DESC;

-- Question 9
-- Construct a correlated subquery in the SELECT clause. Display the Vendor Name from the Vendors table and the �Latest Invoice Date� from the Invoices table. Show the Vendor Name and �Latest Invoice Date� only once (i.e., no duplicates). Only display rows with Vendor Name that starts with �C�. Sort the result by the �Latest Invoice Date� in ascending order.
Print '  Question 9  ';
Print 'Construct a correlated subquery in the SELECT clause. Display the Vendor Name from the Vendors table and the �Latest Invoice Date� from the Invoices table.';
Print '';
SELECT Vendors.VendorName, 
  (SELECT MAX(InvoiceDate) FROM Invoices WHERE Invoices.VendorID = Vendors.VendorID) AS 'Latest Invoice Date'
FROM Vendors
WHERE VendorName LIKE 'C%'
