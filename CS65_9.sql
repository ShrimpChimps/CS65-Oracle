--Step 0
--CS65_9_Huffman_Ryan.sql
--12/03/15

--Drop HRC_Student, if it's already created
DROP TABLE HRC_Student;

--Step 1
--Create HRC_Student Table
CREATE TABLE HRC_Student
(
  ID                char(1),
  Lastname          varchar2(10),
  Firstname         varchar2(10),
  DateOfEnrollment  date
);

--Insert data
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
  
--Step 2a
--Create stored procedure
CREATE OR REPLACE PROCEDURE HRC_NUMBER_STUDENTS
  ( 
    ID_input IN char,
    number_students OUT Number
  )
  IS
    --Stores the last name of the student with ID ID_input
    var_last_name varchar(10) := '';
  BEGIN
    SELECT Lastname                         --Finds the last name of the person with ID ID_input and stores it in the variable
      INTO var_last_name
      FROM HRC_Student
      WHERE ID = ID_input;
                                   
    SELECT COUNT(Lastname)                  --Counts the number of students with var_last_name
      INTO number_students
      FROM HRC_Student
      WHERE Lastname = var_last_name;
      
    EXCEPTION                               --If student is not found, return 0
      WHEN NO_DATA_FOUND THEN
      number_students := 0;
END HRC_NUMBER_STUDENTS;
/

--Step 2b
--Anonymous Program
DECLARE
  var_ID Number(1);
  number_students Number(1);
BEGIN
  var_ID := 1;
  HRC_NUMBER_STUDENTS(var_ID, number_students);
  dbms_output.put_line('Number of students with the same last name as ID ''' 
    || var_ID || ''': ' || number_students);
  
  var_ID := 6;
  HRC_NUMBER_STUDENTS(var_ID, number_students);
  dbms_output.put_line('Number of students with the same last name as ID ''' 
    || var_ID || ''': ' || number_students);
  
  var_ID := 7;
  HRC_NUMBER_STUDENTS(var_ID, number_students);
  dbms_output.put_line('Number of students with the same last name as ID ''' 
    || var_ID || ''': ' || number_students);
END;
/

--Step 3
--Anonymous Program
DECLARE
  input_date DATE;
  
  --Create the function
  FUNCTION HRC_DAYS_IN_MONTH (date_input IN DATE)
    RETURN Number IS
      date_loop       DATE;                     --Date used to loop through the month
      previous_month  char(2);             --Stores the month before the month of the date_input, as a char(2)
      days_in_month   Number(2);
    BEGIN
      --Set date_loop equal to the last day of the month
      date_loop := LAST_DAY(date_input);
      --Find the previous month
      previous_month := TO_CHAR(ADD_MONTHS(date_loop, -1), 'mm');
      --Set the days_in_month to 0, so it can start counting
      days_in_month := 0;
      
      --Count backwards from the last day of the month, until it reaches the previous month
      --This will give you the number of days in the month
      WHILE TO_CHAR(date_loop, 'mm') != previous_month LOOP
        days_in_month := days_in_month + 1;
        date_loop := date_loop - 1;
      END LOOP;
      
      RETURN days_in_month;
  END HRC_DAYS_IN_MONTH;
BEGIN
  dbms_output.enable;
  
  --Call the function
  input_date := SYSDATE;
  dbms_output.put_line('Days in the month of date ' 
    || TO_CHAR(input_date, 'MM-DD-YYYY BC') || ': ' || HRC_DAYS_IN_MONTH(input_date));
  
  input_date := '01-FEB-2013';
  dbms_output.put_line('Days in the month of date ' 
    || TO_CHAR(input_date, 'MM-DD-YYYY BC') || ': ' || HRC_DAYS_IN_MONTH(input_date));
  
  input_date := '01-FEB-2016';
  dbms_output.put_line('Days in the month of date ' 
    || TO_CHAR(input_date, 'MM-DD-YYYY BC') || ': ' || HRC_DAYS_IN_MONTH(input_date));
  
  input_date := '01-OCT-1582';
  dbms_output.put_line('Days in the month of date ' 
    || TO_CHAR(input_date, 'MM-DD-YYYY BC') || ': ' || HRC_DAYS_IN_MONTH(input_date));
  
  input_date := '01-FEB-2100';
  dbms_output.put_line('Days in the month of date ' 
    || TO_CHAR(input_date, 'MM-DD-YYYY BC') || ': ' || HRC_DAYS_IN_MONTH(input_date));
  
  input_date := '01-FEB-2300';
  dbms_output.put_line('Days in the month of date ' 
    || TO_CHAR(input_date, 'MM-DD-YYYY BC') || ': ' || HRC_DAYS_IN_MONTH(input_date));
  
  input_date := TO_DATE('29-FEB-4000 BC', 'DD-MON_YYYY BC');
  dbms_output.put_line('Days in the month of date ' 
    || TO_CHAR(input_date, 'MM-DD-YYYY BC') || ': ' || HRC_DAYS_IN_MONTH(input_date));
END;
/