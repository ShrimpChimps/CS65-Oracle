/*CS65_3_Huffman_Ryan.SQL
  10-01-15*/

--STEP 1
CREATE TABLE HRC_STUDENT		--Creating the HRC_STUDENT table, with column names and datatypes
	(
	 Student_ID      char(7),
	 Last_Name       varchar2(30),
	 First_Name      varchar2(30),
	 Street_Address  varchar2(30),
	 City		 	 varchar2(20),
	 State		 	 char(2),
	 Zipcode	 	 char(10),
	 Birthdate	 	 date,
	 Weight		 	 number(5, 2)
	);

--STEP 2
--Describing the HRC_STUDENT table
--DESCRIBE HRC_STUDENT;

--STEP 3
--Dropping the HRC_STUDENT table
DROP TABLE HRC_STUDENT;			

--STEP 4
CREATE TABLE HRC_STUDENT		--Create table HRC_STUDENT
	(
	 Student_ID	 char(7)	CONSTRAINT PK_HRC_STUDENT PRIMARY KEY,	--Sets Student_ID as the primary key
	 Last_Name	 varchar2(30),
	 First_Name	 varchar2(30)
	);

--STEP 5
--Dropping the HRC_STUDENT table
DROP TABLE HRC_STUDENT;			

--STEP 6
CREATE TABLE HRC_STUDENT		--Create table HRC_STUDENT
	(
	 Student_ID	 char(7),
	 Last_Name	 varchar2(30),
	 First_Name	 varchar2(30),
	 CONSTRAINT PK_HRC_STUDENT	--Sets Student_ID as the primary key
	   PRIMARY KEY (Student_ID)
	);

--STEP 7
CREATE TABLE HRC_Address		--Create table HRC_Address
	(
	 Student_ID	 	 char(7),
	 Address_Type    varchar2(15),
	 Street_Address  varchar2(30),
	 City		 	 varchar2(20),
	 State		 	 char(2),
	 Zipcode	 	 char(10),
	 CONSTRAINT PK_HRC_Address			--Sets Student_ID and Address_Type as a composite primary key
	   PRIMARY KEY (Student_ID, Address_Type),
	 CONSTRAINT FK_HRC_Address_Student_ID
	   FOREIGN KEY (Student_ID)			--Sets Student_ID as the foreign key, referencing Student_ID in HRC_STUDENT
	   REFERENCES HRC_STUDENT(Student_ID)
	);

--STEP 8
CREATE TABLE HRC_Geometry		--Create table HRC_Geometry
	(
	 GeometryID	 char(3),
	 Name		 varchar2(30),
	 Volume		 number(3, 2),
	 CONSTRAINT PK_HRC_Geometry
	   PRIMARY KEY (GeometryID)
	);

CREATE TABLE HRC_Material		--Create table HRC_Material
	(
	 Material	 	    varchar2(20)	CONSTRAINT PK_HRC_Material PRIMARY KEY,
	 DensityOfMaterial	number(2, 1)
	);

CREATE TABLE HRC_Inventory		--Create table HRC_Inventory
	(
	 GeometryID		char(3),
	 Material		varchar2(20),
	 QuantityOnHand number(5),
	 CONSTRAINT PK_HRC_Inventory
		PRIMARY KEY (GeometryID, Material),
	     CONSTRAINT FK_HRC_Inventory_Material	--Foreign keys must be set AFTER the table and PK it references has been created
		FOREIGN KEY (Material)			--i.e. HRC_Material must already be created, with Material as the PK
		REFERENCES HRC_Material(Material),
	     CONSTRAINT FK_HRC_Inventory_GeometryID	--And HRC_Geometry must already be created, with GeometryID as the PK
		FOREIGN KEY (GeometryID)
		REFERENCES HRC_Geometry(GeometryID)
	);

--Step 9
--Drop table HRC_Inventory
DROP TABLE HRC_Inventory;		

--Step 10
CREATE TABLE HRC_Inventory		--Create table HRC_Inventory, no PK or FK
	(
	 GeometryID		char(3),
	 Material		varchar2(20),
	 QuantityOnHand number(5)
	);

--Step 11
--Alter HRC_Inventory to add GeometryID and Material as a composite primary key
ALTER TABLE HRC_Inventory			
	ADD (CONSTRAINT PK_HRC_Inventory
		PRIMARY KEY (GeometryID, Material)
	);

--Step 12
--Alter HRC_Inventory to add Material and GeometryID as the foreign keys
ALTER TABLE HRC_Inventory				
	ADD (CONSTRAINT FK_HRC_Inventory_Material
		FOREIGN KEY (Material)
		REFERENCES HRC_Material(Material),
	     CONSTRAINT FK_HRC_Inventory_GeometryID
		FOREIGN KEY (GeometryID)
		REFERENCES HRC_Geometry(GeometryID)
	);

--Step 13
--Drop all tables, HRC_Inventory before HRC_Material and HRC_Geometry, and HRC_Address before HRC_STUDENT to maintain referential integrity
DROP TABLE HRC_Inventory;
DROP TABLE HRC_Material;
DROP TABLE HRC_Geometry;
DROP TABLE HRC_Address;
DROP TABLE HRC_STUDENT;