--Step 0
--CS65_Exam2_Huffman_Ryan.sql
--11/12/15

--Begin by dropping the tables, so the script can be run multiple times
DROP TABLE HRC_Employee;
DROP TABLE HRC_Skill;

--Step 1
CREATE TABLE HRC_Skill(
    Skillcode           char(2),
    Skillname           varchar2(30),
    CONSTRAINT PK_HRC_Skill
      PRIMARY KEY (Skillcode)
  );
  
CREATE TABLE HRC_Employee(
    ID                  Number(2),
    Lastname            varchar2(10),
    Datehired           DATE,
    Skillcode           char(2),
    
  );