--Step 0
/*CS65_4_Huffman_Ryan.SQL*/

--Step 1A
--Create the table with the proper datatypes and default values
CREATE TABLE HRC_TABLE1
  (
    Invoice_Number        NUMBER(7),
    Customer_Number       NUMBER(4),
    Invoice_Date          date          DEFAULT SYSDATE,
    Quantity              Number(4)     DEFAULT 1,
    Region                Char(2),
    City                  varchar2(20)  DEFAULT 'Torrance',
    State                 Char(2)       DEFAULT 'CA',
    Zipcode               Number(5)     DEFAULT 90506,
    Birthdate             date          DEFAULT '01 January 1990',
    Weight                Number(5, 2)  DEFAULT 100.00
  );
  
--Step 1B
--Drop table
DROP TABLE HRC_TABLE1;

--Step 2A
--Create table, same as above, with new constraints
CREATE TABLE HRC_TABLE1
  (
    Invoice_Number        NUMBER(7),
    Customer_Number       NUMBER(4),
    Invoice_Date          date          DEFAULT SYSDATE,
    Quantity              Number(4)     DEFAULT 1,
    Region                Char(2),
    City                  varchar2(20)  DEFAULT 'Torrance',
    State                 Char(2)       DEFAULT 'CA',
    Zipcode               Number(5)     DEFAULT 90506,
    Birthdate             date          DEFAULT '01 January 1990',
    Weight                Number(5, 2)  DEFAULT 100.00,
    CONSTRAINT PK_HRC_TABLE1 PRIMARY KEY (Invoice_Number),        --Sets Invoice_Number as the PK
    CONSTRAINT UN_HRC_TABLE1_Customer UNIQUE (Customer_Number)    --Sets a unique constraint on Customer_Number
  );
  
--Step 2B
--Adds a unique constraint to the composite City and State columns
ALTER TABLE HRC_TABLE1
    ADD (CONSTRAINT UN_HRC_TABLE1_CITY_STATE UNIQUE (City, State)
  );
  
--Step 2C
--Drop table
DROP TABLE HRC_TABLE1;

--Step 3A
--Create table, same as above, but with check constraints
CREATE TABLE HRC_TABLE1
  (
    Invoice_Number        NUMBER(7),
    Customer_Number       NUMBER(4),
    Invoice_Date          date          DEFAULT SYSDATE,
    Quantity              Number(4)     DEFAULT 1,
    Region                Char(2),
    City                  varchar2(20)  DEFAULT 'Torrance',
    State                 Char(2)       DEFAULT 'CA',
    Zipcode               Number(5)     DEFAULT 90506,
    Birthdate             date          DEFAULT '01 January 1990',
    Weight                Number(5, 2)  DEFAULT 100.00,
    CONSTRAINT PK_HRC_TABLE1 PRIMARY KEY (Invoice_Number),
    CONSTRAINT CK_HRC_TABLE1_QUANTITY CHECK(Quantity > 0),                                          --Quantity must be greater than 0
    CONSTRAINT CK_HRC_TABLE1_CITY CHECK(City = 'Torrance'),                                         --City must be 'Torrance'
    CONSTRAINT CK_HRC_TABLE1_INVOICE CHECK(Invoice_Date >= TO_DATE('2010-01-01', 'yyyy-mm-dd')),    --Invoice_Date must be after January 1, 2010
    CONSTRAINT CK_HRC_TABLE1_REGION CHECK(Region IN('NE', 'NW', 'SE', 'SW', 'MW')),                 --Region must be one of the following: 'NE', 'NW', 'SE', 'SW', 'MW'
    CONSTRAINT CK_HRC_TABLE1_WEIGHT CHECK(Weight >= 50.00 AND Weight <= 200.00)                     --Weight must be between 50.00 and 200.00, inclusive
  );
  
--Step 3B
--Adds the columns Phone_Number
ALTER TABLE HRC_TABLE1
    ADD (Phone_Number     char(14)  
      CONSTRAINT CK_HRC_TABLE1_PHONE_NUMBER         --Adds a constraint, so the format of the phone number must be consistent
        CHECK(Phone_Number LIKE '(___) ___-____'));
        
--Step 3C
--Increases the number of characters of the varchar2 of the City column, from 20 to 25
ALTER TABLE HRC_TABLE1
  MODIFY (City            varchar2(25));
  
--Step 3D
--Drops the Weight column
ALTER TABLE HRC_TABLE1
  DROP COLUMN Weight;
  
--Step 3E
--Drop table
DROP TABLE HRC_TABLE1;