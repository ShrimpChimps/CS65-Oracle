--Step 0
--CS65_11_Huffman_Ryan.sql
--12/10/15

--Step 1a
--Drop the table first, in case it exists
DROP TABLE HRC_Student;

--Create the table HRC_Student
CREATE TABLE HRC_Student
(
  ID                  char(1),
  Lastname            varchar2(10),
  Firstname           varchar2(10),
  DateOfEnrollment    DATE
);

--Step 1b
--Drop the copy table, in case it exists
DROP TABLE HRC_Student_Copy;

--Create the table HRC_Student_Copy
CREATE TABLE HRC_Student_Copy
(
  ID                  char(1),
  Lastname            varchar2(10),
  Firstname           varchar2(10),
  DateOfEnrollment    DATE
);

--Step 2
--Create the trigger
CREATE OR REPLACE TRIGGER HRC_Student_After_ALL_Row
  AFTER INSERT OR
        DELETE OR
        UPDATE OF ID, Lastname, Firstname, DateOfEnrollment
  ON HRC_Student
  FOR EACH ROW
  
BEGIN
  --Inserting code block
  IF INSERTING THEN
    INSERT INTO HRC_Student_Copy
      (ID, Lastname, Firstname, DateOfEnrollment)
      VALUES
      (:new.ID, :new.Lastname, :new.Firstname, :new.DateOfEnrollment);
      
  --Deleting code block
  ELSIF DELETING THEN
    DELETE FROM HRC_Student_Copy
      WHERE ID = :old.ID;
      
  --Updating code block
  ELSIF UPDATING THEN
    UPDATE HRC_Student_Copy
      SET ID = :new.ID,
          Lastname = :new.Lastname,
          Firstname = :new.Firstname,
          DateOfEnrollment = :new.DateOfEnrollment
      WHERE
        ID = :old.ID;
  END IF;
End;
/

--Step 3a
--Insert values into table
INSERT INTO HRC_Student
  (ID, Lastname, Firstname, DateOfEnrollment)
  VALUES
  (1, 'Hers', 'Barry', TO_DATE('12-04-15 08:00:00 AM', 'MM-DD-YY HH:MI:SS AM'));

INSERT INTO HRC_Student
  (ID, Lastname, Firstname, DateOfEnrollment)
  VALUES
  (2, 'Hers', 'Mary', TO_DATE('12-05-15 03:00:00 PM', 'MM-DD-YY HH:MI:SS AM'));
  
INSERT INTO HRC_Student
  (ID, Lastname, Firstname, DateOfEnrollment)
  VALUES
  (3, 'Mes', 'Maxi', TO_DATE('12-06-15 12:00:00 PM', 'MM-DD-YY HH:MI:SS AM'));
  
INSERT INTO HRC_Student
  (ID, Lastname, Firstname, DateOfEnrollment)
  VALUES
  (4, 'Mes', 'Mini', TO_DATE('12-07-15 06:45:00 PM', 'MM-DD-YY HH:MI:SS AM'));
  
INSERT INTO HRC_Student
  (ID, Lastname, Firstname, DateOfEnrollment)
  VALUES
  (5, 'It', 'John', SYSDATE);
  
INSERT INTO HRC_Student
  (ID, Lastname, Firstname, DateOfEnrollment)
  VALUES
  (6, 'Huffman', 'Ryan', SYSDATE + 20 + 1 / 48);
  
--Select tables to check values are the same
SELECT * FROM HRC_Student;
SELECT * FROM HRC_Student_Copy;



--Step 3b
--Test delete statement by deleting the first row
DELETE FROM HRC_Student
  WHERE ID = '1';

--Test with two rows deleted
DELETE FROM HRC_Student
  WHERE ID = '3' OR ID = '4';

--Test with no rows deleted
DELETE FROM HRC_Student
  WHERE ID = '7';

--Select tables to check values are the same
SELECT * FROM HRC_Student;
SELECT * FROM HRC_Student_Copy;



--Step 3c
--Test update statement by updating the first remaining row
--Also tests that updating the ID column works properly
UPDATE HRC_Student
  SET ID = '7',
      Lastname = 'Another',
      Firstname = 'Bob'
  WHERE ID = '2';

--Test with multiple row updates
UPDATE HRC_Student
  SET DateOfEnrollment = '01-OCT-15'
  WHERE ID = '5' OR ID = '6';

--Test with no row updates
UPDATE HRC_Student
  SET ID = '5',
      Lastname = 'Someone',
      Firstname = 'John'
  WHERE ID = '8';

--Select tables to check values are the same
SELECT * FROM HRC_Student;
SELECT * FROM HRC_Student_Copy;




--Test if delete all rows works
DELETE FROM HRC_Student;

--Select tables to check if both tables have no data
SELECT * FROM HRC_Student;
SELECT * FROM HRC_Student_Copy;

--Step 4
--Drop the trigger
DROP TRIGGER HRC_Student_After_ALL_Row;

--Drop the tables
DROP TABLE HRC_Student;
DROP TABLE HRC_Student_Copy;