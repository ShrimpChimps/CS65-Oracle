--Step 0
--CS65_7_Huffman_Ryan.sql
--10/29/15


--Create the four tables from chapter 01 and insert data


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
    Customer_Name     varchar2(40)  NOT NULL,
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




--Group A
--SELECT functions
--Meaningless nested functions (15: POWER, 18: ROUND, 21: SQRT, 24: TRANSLATE, 27: LOWER)
SELECT 
    ROUND(
          POWER(
              SQRT(
               TRANSLATE(
                          LOWER(City), ' abcdefghijklmnopqrstuvwxyz', '018379561364975862487964315'
                        )
                  )
          , 1.35)
    , -1) AS Meaningless FROM HRC_Customer;
  
--Practice with a group function for an even more complete life, 32: MIN
SELECT MIN(Quantity) from HRC_Invoice;



--INSERT functions
--3: ASCII, 10: LPAD, 11: LTRIM, 13: NEXT_DAY, 23: SYSDATE
INSERT INTO HRC_Invoice
   (Invoice_Number, Customer_Number, Invoice_date, Item_Number, Quantity)
   VALUES
   (LPAD(LTRIM('     6'), 2, '0'), ASCII('<'), NEXT_DAY(SYSDATE, 'Monday'), '10', 5);

--Check to see if the insert worked properly   
SELECT * FROM HRC_Invoice;



--UPDATE functions
--1: ABS, 8: LENGTH, 9: LOG, 16: REPLACE, 28: INITCAP, 
UPDATE HRC_Customer
   SET
     Customer_Name = INITCAP('shady business practices, inc.'),
     City = REPLACE('Tucson', 'Tuc', 'Car'),
     Representative_ID = ABS(LOG(10, 1000) - LENGTH('abcdefghijklmn'))
   WHERE
     Customer_Number = '40';
   
--Check to see if the update worked properly
SELECT * FROM HRC_Customer;


--Group B
--TO_CHAR(date_value, date_format)
--Displays the date in the given format
SELECT TO_CHAR(SYSDATE, 'YY-MM-DD') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'FMMonth DD, YYYY HH24:MI:SS') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'FMRM DDth YEAR AD, SSSSS') FROM DUAL;


--TO_CHAR(number, string_format)
--Converts numbers to strings
SELECT TO_CHAR(63.6, '9999.99') FROM DUAL;

SELECT TO_CHAR(438.2, '000999') FROM DUAL;

SELECT TO_CHAR(0.0004783, 'FM9.99EEEE') FROM DUAL;


--TO_DATE(string_value, date_format)
--Converts strings to dates
SELECT TO_DATE('May 20, 1999', 'Mon DD, YYYY') FROM DUAL;

SELECT TO_DATE('13-12-25 12:15', 'YY-MM-DD HH:MI') FROM DUAL;

SELECT TO_DATE('11:13:46 22 SEP, 55', 'HH:MI:SS DD MON, YY') FROM DUAL;


--TO_NUMBER(string [, format])
--Converts strings to numbers
SELECT TO_NUMBER('1029831423') + 1 FROM DUAL;

SELECT TO_NUMBER('44,293,001', '99,999,999') * 2 FROM DUAL;

SELECT TO_NUMBER('1,483.47293', '9,999.99999') / 0.006 FROM DUAL;

--Drop all tables
DROP TABLE HRC_Invoice;
DROP TABLE HRC_Customer;
DROP TABLE HRC_Inventory;
DROP TABLE HRC_Representative;