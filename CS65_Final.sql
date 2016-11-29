--Step 0
--CS65_Final_Huffman_Ryan.sql
--12/17/15

--Step 1
--Drop the table, in case it exists
DROP TABLE HRC_FacultyAtSMC;

--Create the table
CREATE TABLE HRC_FacultyAtSMC
(
  ID              NUMBER(1),
  Lastname        varchar2(10)    NOT NULL,
  Firstname       varchar2(10)    UNIQUE,
  Hiredate        DATE,
  IDspouse        NUMBER(1),
  CONSTRAINT PK_HRC_FacultyAtSMC_ID
    PRIMARY KEY (ID),
  CONSTRAINT FK_HRC_FacultyAtSMC_IDspouse
    FOREIGN KEY (IDspouse)
    REFERENCES HRC_FacultyAtSMC (ID),
  CONSTRAINT CK_HRC_FacultyAtSMC_Hiredate
    CHECK(Hiredate >= TO_DATE('01-DEC-2015', 'DD-MON-YYYY')
      AND Hiredate < TO_DATE('01-JAN-2016', 'DD-MON-YYYY'))
);

--Insert the data
--To maintain referential integrity, data will be input first without entering the IDspouse
--This will be handled by UPDATE statements afterward.
INSERT INTO HRC_FacultyAtSMC
  (ID, Lastname, Firstname, Hiredate)
  VALUES
  (1, 'Hers', 'Barry', TO_DATE('12-05-2015 08:00:00 AM', 'MM-DD-YYYY HH:MI:SS AM'));
  
INSERT INTO HRC_FacultyAtSMC
  (ID, Lastname, Firstname, Hiredate)
  VALUES
  (2, 'Hers', 'Mary', TO_DATE('12-06-2015 03:00:00 PM', 'MM-DD-YYYY HH:MI:SS AM'));
  
INSERT INTO HRC_FacultyAtSMC
  (ID, Lastname, Firstname, Hiredate)
  VALUES
  (3, 'Mes', 'Maxi', TO_DATE('12-07-2015 12:00:00 PM', 'MM-DD-YYYY HH:MI:SS AM'));
  
INSERT INTO HRC_FacultyAtSMC
  (ID, Lastname, Firstname, Hiredate)
  VALUES
  (4, 'Mes', 'Mini', TO_DATE('12-08-2015 06:45:00 PM', 'MM-DD-YYYY HH:MI:SS AM'));
  
INSERT INTO HRC_FacultyAtSMC
  (ID, Lastname, Firstname, Hiredate)
  VALUES
  (5, 'It', 'Tom', SYSDATE);
  
INSERT INTO HRC_FacultyAtSMC
  (ID, Lastname, Firstname, Hiredate)
  VALUES
  (6, 'Moore', 'Les', SYSDATE + 2 + ((3 * 60 + 4) / 86400));
  
--Update the rows to enter the IDspouse data afterwards, so referential integrity is maintained
UPDATE HRC_FacultyAtSMC
  SET IDspouse = 2
  WHERE ID = 1;
  
UPDATE HRC_FacultyAtSMC
  SET IDspouse = 1
  WHERE ID = 2;
  
UPDATE HRC_FacultyAtSMC
  SET IDspouse = 3
  WHERE ID = 4;
  
UPDATE HRC_FacultyAtSMC
  SET IDspouse = 4
  WHERE ID = 3;
  
--Step 2
--Use a select statement and group by Lastname to output the number of faculty with each last name
SELECT Lastname, COUNT(*) AS Number_Faculty_With_Lastname
  FROM HRC_FacultyAtSMC
  WHERE LENGTH(Lastname) >= 3           --Only select Lastname that is three characters or longer
  GROUP BY Lastname;
  
--Step 3
--Use a self join to output the names of faculty with spouses
SELECT t1.Firstname || ' ' || t1.Lastname || ' is married to ' ||
  t2.Firstname || ' ' || t2.Lastname AS SPOUSES
  FROM HRC_FacultyAtSMC t1, HRC_FacultyAtSMC t2         --Same table with different aliases.
  WHERE t1.ID = t2.IDspouse;
  
--Step 4a
--Oracle date to string temporal function
DECLARE
  my_date     DATE;
  FUNCTION HRC_DATE_TO_STRING (date_input IN DATE)
    RETURN varchar2 IS
      return_string     varchar2(60);
    BEGIN
      --Concatenates the month, day, year, and day of the week (in parentheses) to return_string
      return_string := TO_CHAR(date_input, 'FMMonth DD, YYYY (Day)');
      --Concatenates the string 'at time', then the hour , minutes, and seconds
      --The hour is formatted separately, because adding 'FM' to the minutes and seconds changes midnight to 12:0:0a.
      --The FM eliminates the leading 0 from the hour.
      return_string := return_string || ' at time ' || TO_CHAR(date_input, 'FMHH:') || TO_CHAR(date_input, 'MI:SS');
      
      --If the time is PM, add 'p.' to the return_string, otherwise add 'a.'
      IF TO_CHAR(date_input, 'PM') = 'PM' THEN
        return_string := return_string || 'p.';
      ELSE
        return_string := return_string || 'a.';
      END IF;
      
      RETURN return_string;
  END;
BEGIN
  dbms_output.enable;
  
  --Test the function with the date given in step 4a
  my_date := TO_DATE('December 17, 2015 06:45:30 PM', 'Month DD, YYYY HH:MI:SS PM');
  dbms_output.put_line(HRC_DATE_TO_STRING(my_date));
  
  --Step 4b
  --Test the function with two dates
  my_date := SYSDATE;
  dbms_output.put_line(HRC_DATE_TO_STRING(my_date));
  
  my_date := '17-DEC-2015';
  dbms_output.put_line(HRC_DATE_TO_STRING(my_date));
END;
/

--Step 5a
--Create the stored procedure
CREATE OR REPLACE PROCEDURE HRC_AFTER_HIREDATE
  (input_ID IN           NUMBER,
   return_number OUT     NUMBER)
IS
  hire_date_from_ID     DATE;
BEGIN
  --Find the hire date of faculty with input_ID, and store it into hire_date_from_ID
  SELECT Hiredate INTO hire_date_from_ID
    FROM HRC_FacultyAtSMC
    WHERE ID = input_ID;

  --Count the number of faculty hired after the hire_date_from_ID
  SELECT COUNT(*) INTO return_number
    FROM HRC_FacultyAtSMC
    WHERE Hiredate > hire_date_from_ID;
END;
/
 
--Step 5b
--Create an anonymous procedure to call the stored procedure
DECLARE
  my_ID                 NUMBER;
  return_hired_after    NUMBER;
BEGIN
  dbms_output.enable;
  
  my_ID := 1;
  
  --For loop, so the if-then-else statement does not have to be repeated over and over
  FOR i IN 0..2 LOOP
    HRC_AFTER_HIREDATE(my_ID, return_hired_after);
    IF return_hired_after = 0 THEN
      dbms_output.put_line('For ID = ' || my_ID || ', no faculty were hired afterwards.');
    ELSE
      dbms_output.put_line('For ID = ' || my_ID || ', ' || return_hired_after || ' faculty were hired afterwards.');
    END IF;
    
    --Changes the value stored in my_ID each time the loop is run, to test the three cases
    CASE my_ID
      WHEN 1 THEN my_ID := 4;
      WHEN 4 THEN my_ID := 6;
      ELSE my_ID := 0;
    END CASE;
  END LOOP;
END;
/

--Step 6a
--Drop the table, in case it has already been created
DROP TABLE HRC_FacultyAtBerkeley;

--Create the table
CREATE TABLE HRC_FacultyAtBerkeley
(
  ID            NUMBER(1),
  Lastname      varchar2(10),
  Firstname     varchar2(10),
  CONSTRAINT PK_HRC_FacultyAtBerkeley
    PRIMARY KEY (ID)
);

--Insert the data
INSERT INTO HRC_FacultyAtBerkeley
  (ID, Lastname, Firstname)
  VALUES
  (5, 'Hers', 'Barry');
  
INSERT INTO HRC_FacultyAtBerkeley
  (ID, Lastname, Firstname)
  VALUES
  (4, 'Hers', 'Helen');
  
INSERT INTO HRC_FacultyAtBerkeley
  (ID, Lastname, Firstname)
  VALUES
  (3, 'Mes', 'Maxi');
  
INSERT INTO HRC_FacultyAtBerkeley
  (ID, Lastname, Firstname)
  VALUES
  (2, 'Mes', 'Mini');
  
INSERT INTO HRC_FacultyAtBerkeley
  (ID, Lastname, Firstname)
  VALUES
  (1, 'Its', 'Jack');
  
INSERT INTO HRC_FacultyAtBerkeley
  (ID, Lastname, Firstname)
  VALUES
  (0, 'Moore', 'Les');
  
--Select all columns and rows
SELECT * FROM HRC_FacultyAtBerkeley;

--Step 6b
--Select professors that teach at both schools (same first and last names)
SELECT s.Firstname, s.Lastname
  FROM HRC_FacultyAtSMC s INNER JOIN HRC_FacultyAtBerkeley b
  ON s.Firstname = b.Firstname AND s.Lastname = b.Lastname;
  
--Step 6c
--Select faculty that teach at Berkeley but not at SMC
SELECT Firstname, Lastname
  FROM HRC_FacultyAtBerkeley
MINUS
SELECT Firstname, Lastname
  FROM HRC_FacultyAtSMC;
  
--Drop all objects
DROP TABLE HRC_FacultyAtSMC;
DROP TABLE HRC_FacultyAtBerkeley;
DROP PROCEDURE HRC_AFTER_HIREDATE;