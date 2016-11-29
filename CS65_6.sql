--Step 0
--CS65_6_Huffman_Ryan.sql
--10/15/15

--Step 1
--Create table from Project 4 Step 2A
CREATE TABLE HRC_TABLE1
  (
    Invoice_Number        NUMBER(7),
    Customer_Number       NUMBER(4),
    Invoice_Date          date          DEFAULT SYSDATE,
    Quantity              Number(4)     DEFAULT 1,
    Region                Char(2)       DEFAULT 'SW',
    City                  varchar2(20)  DEFAULT 'Torrance',
    State                 Char(2)       DEFAULT 'CA',
    Zipcode               Number(5)     DEFAULT 90506,
    Birthdate             date          DEFAULT '01 January 2010',
    Weight                Number(5, 2)  DEFAULT 100.00,
    CONSTRAINT PK_HRC_TABLE1 PRIMARY KEY (Invoice_Number),        --Sets Invoice_Number as the PK
    CONSTRAINT UN_HRC_TABLE1_Customer UNIQUE (Customer_Number),    --Sets a unique constraint on Customer_Number
    --CONSTRAINT CK_HRC_TABLE1_City CHECK (City IN ('Torrance', 'Santa Monica', 'West LA')),    --City must be one of the three listed
    CONSTRAINT CK_HRC_TABLE1_State CHECK (State = 'CA'),          --State must be 'CA'
    CONSTRAINT CK_HRC_TABLE1_Weight CHECK (Weight > 0)            --Weight must be greater than 0
  );
  
--Step 2
--Insert without listing column names
INSERT INTO HRC_TABLE1 
  VALUES (1234567, 1000, '01-JAN-2000', 1000, 'SE', 'Torrance', 'CA', 90506, '01-JAN-1980', 123.45);

--Insert using a list of column names
INSERT INTO HRC_TABLE1 
  (Invoice_Number, Customer_Number, Invoice_Date, Quantity, Region, City, State, Zipcode, Birthdate, Weight)
  VALUES (2345678, 2000, DEFAULT, 2000, DEFAULT, NULL, DEFAULT, NULL, TO_DATE('January 2, 2010 12:15:35 AM', 'Month DD, YYYY HH:MI:SS AM'), 100);

--Insert, allowing defaults to fill in some fields
INSERT INTO HRC_TABLE1
  (Invoice_Number, City, State, Zipcode, Birthdate, Weight)
  VALUES (3456789, 'Santa Monica', NULL, 90405, TO_DATE('02-JAN-2010 12:15:35 AM', 'DD-MON-YYYY HH:MI:SS AM'), 200.5);
  
--Step 3
--Commit changes
COMMIT;

--Step 4
--Insert more rows into the table
INSERT INTO HRC_TABLE1
  (Invoice_Number, Customer_Number, Invoice_Date, Quantity, Region, City, State, Zipcode, Birthdate, Weight)
  VALUES (4567890, NULL, SYSDATE, 3000, 'SW', 'West LA', 'CA', 90000, SYSDATE, 300);
INSERT INTO HRC_TABLE1
  (Invoice_Number, Customer_Number, Invoice_Date, Quantity, Region, City, State, Zipcode, Birthdate, Weight)
  VALUES (5678901, 3000, '01-FEB-2000', 4000, 'SW', 'Torrance', 'CA', 90506, SYSDATE, 300);

--Step 5
--Rollback, then select to see the table
ROLLBACK;
SELECT * FROM HRC_TABLE1;

--Step 6
--Insert the first row of Step 4 again
INSERT INTO HRC_TABLE1
  VALUES (4567890, NULL, SYSDATE, 3000, 'SW', 'West LA', 'CA', 90000, SYSDATE, 300);
--Create a Savepoint
SAVEPOINT AFTER_ROW_4;

--Step 7
--Insert the second row of Step 4 again
INSERT INTO HRC_TABLE1
  (Invoice_Number, Customer_Number, Invoice_Date, Quantity, Region, City, State, Zipcode, Birthdate, Weight)
  VALUES (5678901, 3000, '01-FEB-2000', 4000, 'SW', 'Torrance', 'CA', 90506, SYSDATE, 300);

--Step 8
--Rollback to Savepoint AFTER_ROW_4
ROLLBACK TO AFTER_ROW_4;
--Select all rows
SELECT * FROM HRC_TABLE1;
--Commit changes
COMMIT;

--Step 9
--Change Customer_Number to 1500 in the row where Invoice_Number is 1234567
UPDATE HRC_TABLE1
  SET Customer_Number = 1500
  WHERE Invoice_Number = 1234567;
--Select the row where Invoice_Number is 1234567 to check the update
SELECT * FROM HRC_TABLE1 WHERE Invoice_Number = 1234567;

--Step 10
--Change Invoice_Date to February 1, 2000 and Weight to 250 in the row where Invoice_Number is 2345678
UPDATE HRC_TABLE1
  SET Invoice_Date = '01-FEB-2000', Weight = 250
  WHERE Invoice_Number = 2345678;
--Select the row where Invoice_Number is 2345678 to check the update
SELECT * FROM HRC_TABLE1 WHERE Invoice_Number = 2345678;

--Step 11
--Set the weight for all rows to 567.89
UPDATE HRC_TABLE1
  SET Weight = 567.89;

--Step 12
--Rollback updates
ROLLBACK;

--Step 13
--Set the region to 'NW' in the row where Invoice_Number is 3456789
UPDATE HRC_TABLE1
  SET Region = 'NW' WHERE Invoice_Number = 3456789;
--Select all rows
SELECT * FROM HRC_TABLE1;
--Commit changes
COMMIT;

--Step 14
--Delete the first row of the table
DELETE FROM HRC_TABLE1 WHERE Invoice_Number = 1234567;

--Step 15
--Delete all rows where the weight is less than 200
DELETE FROM HRC_TABLE1 WHERE Weight < 200;

--Step 16
--Rollback deletes
ROLLBACK;

--Step 17
--Delete all rows from the table where Quantity is between 2000 and 3000
DELETE FROM HRC_TABLE1 WHERE Quantity >= 2000 AND Quantity <= 3000;

--Step 18
--Delete all rows from the table where City starts with a 'T'
DELETE FROM HRC_TABLE1 WHERE City LIKE 'T%';

--Step 19
--Rollback deletes
ROLLBACK;
--Select all rows
SELECT * FROM HRC_TABLE1;
--Commit changes
COMMIT;

--Step 20
--Drop table
DROP TABLE HRC_TABLE1;