--Step 0
--CS65_5_Huffman_Ryan.SQL
--10/14/15

--Step 1
--Insert script to create the four tables
/*
Chapter 01 CS65.SQL version 10-SEP-2015 by Harold Rogler

The following SQL commands drop then create the four tables on Page 5 of CS65 
Chapter 01 and inserts values into the tables.  Please copy this file and 
replace the 4 characters HRC_ with LFM_ where LFM are the Last, First, Middle 
initials of your names and _ is the underscore.  Creating tables and other 
objects with your initials beginning their names will create unique names in the 
shared database, and will group your objects together in the object browser.
*/

SET ECHO ON;
--The following two SQL Plus commands can be omitted
--SET PAGESIZE 100;
--SET LINESIZE 200;

/* If your tables don't exist, the following drop commands will cause errors, 
but don't worry about these errors.  If your tables exist, they'll be dropped. */

DROP TABLE HRC_Invoice;
DROP TABLE HRC_Customer;
DROP TABLE HRC_Inventory;
DROP TABLE HRC_Representative;


CREATE TABLE HRC_Representative (
    Representative_ID char(2),
    Last_Name         varchar2(20)  NOT NULL,
    First_Name        varchar2(20),
    Region            char(2),
    Hire_Date         date,
    Phone             varchar2(14),
    constraint PK_HRC_Representative Primary Key (Representative_ID),
    constraint CK_HRC_Representative CHECK(Region IN ('NE', 'NW', 'MW', 'SE', 'SW'))
    );

CREATE TABLE HRC_Inventory (
    Item_Number       char(2),
    Description       varchar2(50),
    Quantity_On_Hand  number(4)     NOT NULL,
    constraint PK_HRC_Inventory Primary Key (Item_Number)
    );

CREATE TABLE HRC_Customer (
    Customer_Number   char(2),
    Customer_Name     varchar2(20)  NOT NULL,
    City              varchar2(20),
    Representative_ID char(2),
    constraint PK_HRC_Customer Primary Key (Customer_Number),
    constraint FK_HRC_Customer_Rep_ID
      Foreign Key (Representative_ID) references HRC_Representative (Representative_ID)
    );

CREATE TABLE HRC_Invoice (
    Invoice_Number    char(2),
    Customer_Number   char(2)  NOT NULL,
    Invoice_date      date,
    Item_Number       char(2),
    Quantity          number(2),
    constraint PK_HRC_Invoice Primary Key (Invoice_Number),
    constraint FK_HRC_Invoice_Cust_Number
      Foreign Key (Customer_Number) references HRC_Customer (Customer_Number),
    constraint FK_HRC_Invoice_Item_Number
      Foreign Key (Item_Number) references HRC_Inventory (Item_Number)
    );


--Following commands insert values into table HRC_Representative

INSERT INTO HRC_Representative
   (Representative_ID, Last_Name, First_Name, Region, Hire_Date, Phone)
   VALUES
   ('11', 'Rogler', 'Harold', 'SW', '05-JAN-1999', '(310) 456-7890');

INSERT INTO HRC_Representative
   (Representative_ID, Last_Name, First_Name, Region, Hire_Date, Phone)
   VALUES
   ('22', 'Higgins', 'Heather', 'SE', '16-Dec-2014', '(404) 524-8472');

INSERT INTO HRC_Representative
   (Representative_ID, Last_Name, First_Name, Region, Hire_Date, Phone)
   VALUES
   ('33', 'Sullivan', 'Pat', 'NE', '21-Feb-2010', '(305) 734-2987');

INSERT INTO HRC_Representative
   (Representative_ID, Last_Name, First_Name, Region, Hire_Date, Phone)
   VALUES
   ('44', 'Speed', 'Kristen', 'MW', '14-Jun-2008', '(708) 823-8222');

INSERT INTO HRC_Representative
   (Representative_ID, Last_Name, First_Name, Region, Hire_Date, Phone)
   VALUES
   ('55', 'Sigafoos', 'Alex', 'NW', '05-MAR-2012', '(310) 123-7890');


--Following commands insert values into table HRC_Inventory

INSERT INTO HRC_Inventory
   (Item_Number, Description, Quantity_On_Hand)
   VALUES
   ('10', 'Hard drive 5 TB 15000 RPM', 191);

INSERT INTO HRC_Inventory
   (Item_Number, Description, Quantity_On_Hand)
   VALUES
   ('20', 'Solid state drive 1 TB flash', 453);

INSERT INTO HRC_Inventory
   (Item_Number, Description, Quantity_On_Hand)
   VALUES
   ('30', 'Solid state drive 500 GB DRAM with battery', 294);

INSERT INTO HRC_Inventory
   (Item_Number, Description, Quantity_On_Hand)
   VALUES
   ('40', 'RAID level 5 system', 676);

INSERT INTO HRC_Inventory
   (Item_Number, Description, Quantity_On_Hand)
   VALUES
   ('50', 'Optical drive Blu-Ray', 817);

INSERT INTO HRC_Inventory
   (Item_Number, Description, Quantity_On_Hand)
   VALUES
   ('60', 'LED/LCD 4K color monitor 30-inch', 982);

INSERT INTO HRC_Inventory
   (Item_Number, Description, Quantity_On_Hand)
   VALUES
   ('70', 'Dynamic RAM DDR', 0);

INSERT INTO HRC_Inventory
   (Item_Number, Description, Quantity_On_Hand)
   VALUES
   ('80', '3D printer', 296);

INSERT INTO HRC_Inventory
   (Item_Number, Description, Quantity_On_Hand)
   VALUES
   ('90', 'Rogler''s DSL modem', 152);


--Following commands insert values into table HRC_Customer 

INSERT INTO HRC_Customer
   (Customer_Number, Customer_Name, City, Representative_ID)
   VALUES
   ('10', 'Ballard Computer', 'Seattle', '55');

INSERT INTO HRC_Customer
   (Customer_Number, Customer_Name, City, Representative_ID)
   VALUES
   ('20', 'Computer City', 'Miami', '33');

INSERT INTO HRC_Customer
   (Customer_Number, Customer_Name, City, Representative_ID)
   VALUES
   ('30', 'Under_Score, Inc.', 'Atlanta', '22');

INSERT INTO HRC_Customer
   (Customer_Number, Customer_Name, City, Representative_ID)
   VALUES
   ('40', 'Varner User System', 'Naperville', NULL);

INSERT INTO HRC_Customer
   (Customer_Number, Customer_Name, City, Representative_ID)
   VALUES
   ('50', '100% Jargon', 'Spokane', '55');

INSERT INTO HRC_Customer
   (Customer_Number, Customer_Name, City, Representative_ID)
   VALUES
   ('60', 'Computing Solutions', 'Tucson', '11');


--Following commands insert values into table HRC_Invoice.  The year 1899 isn't a typo.

INSERT INTO HRC_Invoice
   (Invoice_Number, Customer_Number, Invoice_date, Item_Number, Quantity)
   VALUES
   ('01', '20', '12-MAY-1899', '70', 11);

--  The year in the above date is eighteen hundred and ninety nine.

INSERT INTO HRC_Invoice
   (Invoice_Number, Customer_Number, Invoice_date, Item_Number, Quantity)
   VALUES
   ('02', '30', '29-FEB-2000', '60', 15);

INSERT INTO HRC_Invoice
   (Invoice_Number, Customer_Number, Invoice_date, Item_Number, Quantity)
   VALUES
   ('03', '30', '13-SEP-2004', '20', 14);

INSERT INTO HRC_Invoice
   (Invoice_Number, Customer_Number, Invoice_date, Item_Number, Quantity)
   VALUES
   ('04', '20', '10-JUL-2012', '10', NULL);

INSERT INTO HRC_Invoice
   (Invoice_Number, Customer_Number, Invoice_date, Item_Number, Quantity)
   VALUES
   ('05', '60', '17-FEB-2015', '60', 20);


--Display all values in all tables

/*SELECT * FROM HRC_Invoice;
SELECT * FROM HRC_Customer;
SELECT * FROM HRC_Inventory;
SELECT * FROM HRC_Representative;*/

--Step 2
--Select all rows and columns from HRC_Invoice
SELECT * FROM HRC_Invoice;

--Step 3
--Select Customer_Number, Item_Number, and Quantity columns, and all rows from HRC_Invoice
SELECT Customer_Number, Item_Number, Quantity FROM HRC_Invoice;

--Step 4
--Arithmetical functions using HRC_Invoice.Quantity
SELECT Quantity, Quantity - 4, Quantity + 5, Quantity * 6, Quantity / 7, SQRT(Quantity) FROM HRC_Invoice;

--Step 5
--HRC_Invoice.Invoice_Date and date expressions
SELECT Invoice_Date, Invoice_Date + 10, Invoice_Date - 10 FROM HRC_Invoice;

--Step 6
--String concatenation
SELECT Customer_Name || ' is located in ' || City FROM HRC_Customer;

--Step 7
--Using an alias
SELECT First_Name || ' ' || Last_Name, First_Name || ' ' || Last_Name AS Fullname FROM HRC_Representative;

--Step 8
--Select all columns for rows where Quantity is greater than 14 in HRC_Invoice
SELECT * FROM HRC_Invoice WHERE Quantity > 14;

--Step 9
--Select all columns in HRC_Invoice for Invoice_Number '01'
SELECT * FROM HRC_Invoice WHERE Invoice_Number = '01';

--Step 10
--Select all columns for rows where the Invoice_Date is later than '01 Jan 2000' from HRC_Invoice 
SELECT * FROM HRC_Invoice WHERE Invoice_Date > '01 Jan 2000';

--Step 11
--Select all columns for rows where the Item_Number is either '60' or '70' from HRC_Invoice
SELECT * FROM HRC_Invoice WHERE Item_Number IN ('60', '70');

--Step 12
--Select all columns for rows where Quantity is between 11 and 15 from HRC_Invoice
SELECT * FROM HRC_Invoice WHERE Quantity >= 11 AND Quantity <= 15;

--Step 13
--Select all Customer_Name where the Customer_Name starts with a 'C' from HRC_Customer
SELECT Customer_Name FROM HRC_Customer WHERE Customer_Name LIKE 'C%';

--Step 14
--Select all Description where the Description has an 'o' as the second letter
SELECT Description FROM HRC_Inventory WHERE Description LIKE '_o%';

--Step 15
--Select all rows and columns from HRC_Representative, ordered by Last_Name, then First_Name, both in ascending order
SELECT * FROM HRC_Representative ORDER BY Last_Name, First_Name;

--Step 16
--Select all rows and columns from HRC_Representative, ordered by Last_Name, then First_Name, both in descending order
SELECT * FROM HRC_Representative ORDER BY Last_Name DESC, First_Name DESC;

--Step 17
--Select all rows and columns from HRC_Representative, ordered by Hire_Date in descending order
SELECT * FROM HRC_Representative ORDER BY Hire_Date DESC;

--Step 18
--Count the number of rows in HRC_Inventory
SELECT COUNT(*) FROM HRC_Inventory;

--Step 19
--Count the number of rows in HRC_Inventory where Quantity_On_Hand is at least 300
SELECT COUNT(*) FROM HRC_Inventory WHERE Quantity_On_Hand >= 300;

--Step 20
--Find the average Quantity_On_Hand from HRC_Inventory for rows where Quantity_On_Hand is at least 300
SELECT AVG(Quantity_On_Hand) FROM HRC_Inventory WHERE Quantity_On_Hand >= 300;

--Step 21
--Adding the Item_Number causes an error
--SELECT Item_Number, AVG(Quantity_On_Hand) FROM HRC_Inventory WHERE Quantity_On_Hand >= 300;