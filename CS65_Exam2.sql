--Step 0
--CS65_Exam2_Huffman_Ryan.sql
--11/12/15

--Step 1
--Begin by dropping the tables, just in case the tables have already been created
DROP TABLE HRC_Employee;
DROP TABLE HRC_Skill;

--Create table HRC_Skill first, as HRC_Employee has a FK that references HRC_Skill
CREATE TABLE HRC_Skill(
    Skillcode           char(2),
    Skillname           varchar2(30)    UNIQUE,     --Add unique constraint to Skillname
    CONSTRAINT PK_HRC_Skill
      PRIMARY KEY (Skillcode)                       --Set Skillcode as the PK
  );

--Create table HRC_Employee
CREATE TABLE HRC_Employee(
    ID                  Number(2),
    Lastname            varchar2(10)    NOT NULL,   --Add not null constraint to Lastname
    Datehired           DATE            DEFAULT TO_DATE('November 12, 2015 6:45 pm', 'Month DD, YYYY HH:MI pm'),    --Set the default for Datehired
    Skillcode           char(2),
    CONSTRAINT PK_HRC_Employee
      PRIMARY KEY (ID),                             --Set ID as the PK
    CONSTRAINT FK_HRC_Employee_Skillcode
      FOREIGN KEY (Skillcode)                       
        references HRC_Skill (Skillcode),           --Create the FK where HRC_Employee.Skillcode references HRC_Skill.Skillcode
    CONSTRAINT CK_HRC_Employee_Lastname
      CHECK(Lastname LIKE 'O%' OR Lastname LIKE 'A%')    --Add a check constraint to Lastname, so it must begin with an O or an A
  );
  
--Step 2
--Insert data into HRC_Skill
INSERT INTO HRC_Skill
  (Skillcode, Skillname)
  VALUES
  ('BD', 'Build Databases');
  
INSERT INTO HRC_Skill
  (Skillcode, Skillname)
  VALUES
  ('DD', 'Design Databases');

INSERT INTO HRC_Skill
  (Skillcode, Skillname)
  VALUES
  ('MR', 'Mobile Robotics');

INSERT INTO HRC_Skill
  (Skillcode, Skillname)
  VALUES
  ('AI', 'Artificial Intelligence');

INSERT INTO HRC_Skill
  (Skillcode, Skillname)
  VALUES
  ('CS', 'Cognitive Science');
  
--Set a savepoint
Savepoint SP_HRC_AFTER_INSERT_SKILL;

--Insert the first six rows into HRC_Employee
INSERT INTO HRC_Employee
  (ID, Lastname, Datehired, Skillcode)
  VALUES
  (5, 'Ow', TO_DATE('July 4, 1776', 'Month DD, YYYY'), 'BD');
  
INSERT INTO HRC_Employee
  (ID, Lastname, Datehired, Skillcode)
  VALUES
  (10, 'Ogen', TO_DATE('February 28, 2000', 'Month DD, YYYY'), 'DD');
  
INSERT INTO HRC_Employee
  (ID, Lastname, Datehired, Skillcode)
  VALUES
  (15, 'One', TO_DATE('February 29, 2000', 'Month DD, YYYY'), 'BD');
  
INSERT INTO HRC_Employee
  (ID, Lastname, Datehired, Skillcode)
  VALUES
  (20, 'Arith', TO_DATE('August 31, 2015', 'Month DD, YYYY'), 'MR');
  
INSERT INTO HRC_Employee
  (ID, Lastname, Datehired, Skillcode)
  VALUES
  (25, 'Oee', SYSDATE + (((5 * 3600) + (4 * 60) + 3) / 86400), NULL);

/* The present date and time + 5 hours, 4 minutes, and 3 seconds is calculated by
  the SYSDATE plus the fraction of the day that is 5 hours, 4 minutes and 3 seconds.
  That fraction is calculated by dividing the seconds in 5 hours, 4 minutes and 3 seconds by
  the total number of seconds in a day. */
  
INSERT INTO HRC_Employee
  (ID, Lastname, Skillcode)
  VALUES
  (30, 'O''Ryan', 'AI');

--Set a savepoint
SAVEPOINT SP_HRC_AFTER_INSERT_EMPLOYEE;

--Insert the last row
INSERT INTO HRC_Employee
  (ID, Lastname, Datehired, Skillcode)
  VALUES
  (35, 'Apophis', TO_DATE('04-13-2036', 'MM-DD-YYYY'), 'CS');
  
--Rollback to savepoint HRC_AFTER_INSERT_EMPLOYEE
ROLLBACK TO SP_HRC_AFTER_INSERT_EMPLOYEE;

--Commit changes
COMMIT;

--Step 3
--Create an index for Datehired in HRC_Employee
CREATE INDEX IND_HRC_Employee_Datehired
  ON HRC_Employee (Datehired);
  
--Drop the index
DROP INDEX IND_HRC_Employee_Datehired;
  
--Step 4a
--Add column SkillLevel to HRC_Skill
ALTER TABLE HRC_Skill ADD(
    SkillLevel           Number(1)
  );
  
--Step 4b
--Enter the value 8 into SkillLevel for all rows
UPDATE HRC_Skill
  SET SkillLevel = 8;
  
--Step 4c
--Select all columns and rows from HRC_Skill
SELECT * FROM HRC_Skill;

--Step 4d
--Remove column SkillLevel
ALTER TABLE HRC_Skill
  DROP COLUMN SkillLevel;
  
--Step 5a
--Select all columns from HRC_Employee with Skillcode DD or BD
SELECT * FROM HRC_Employee
  WHERE Skillcode = 'DD' OR Skillcode = 'BD';
  
--Step 5b
--Delete the same rows selected in Step 5a
DELETE FROM HRC_Employee
  WHERE Skillcode = 'DD' OR Skillcode = 'BD';
  
--Step 5c
--Check to see if the rows remain
SELECT * FROM HRC_Employee;

--Step 5d
--Rollback the deletions in Step 5b
ROLLBACK;

--Step 5e
--Check to see if the rows are still stored
SELECT * FROM HRC_Employee;

--Step 6
--Select the Skillcode and Skillname from HRC_Skill if an employee has that skill
SELECT * FROM HRC_Skill s
  WHERE EXISTS
    (SELECT Skillcode FROM HRC_Employee e
      WHERE s.Skillcode = e.Skillcode);
      
--Step 7
--Count the number of employees hired each year, for years 1900 and later
SELECT TO_CHAR(Datehired, 'YYYY') Year, COUNT(*) Number_Of_Employees FROM HRC_Employee
  GROUP BY TO_CHAR(Datehired, 'YYYY')
  HAVING TO_NUMBER(TO_CHAR(Datehired, 'YYYY')) >= 1900;
  
--Step 8
--Full outer join of both tables
SELECT * FROM HRC_Skill s FULL OUTER JOIN HRC_Employee e
  ON s.Skillcode = e.Skillcode;
  
--Step 9
--Drop both tables, maintaining referential integrity
DROP TABLE HRC_Employee;
DROP TABLE HRC_Skill;