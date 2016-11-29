--Step 0
--CS65_10E_Huffman_Ryan.sql
--12/03/15

--Step 1
--Drop HRC_earthquake_table
DROP TABLE HRC_earthquake_table;

--Create HRC_earthquake_table
CREATE TABLE HRC_earthquake_table
(
  Horizontal_radius         Number(3),
  Diagonal_distance         Number(8, 3),
  Time_P_wave               Number(6, 3),
  Time_S_wave               Number(6, 3),
  Time_L_wave               Number(6, 3)
);

--Step 2
--Create (or replace) HRC_Earthquake_Procedure
CREATE OR REPLACE PROCEDURE HRC_Earthquake_Procedure
  (
    depth_of_earthquake IN Number,
    radius_of_student IN Number,
    time_p_wave_hits OUT Number,
    s_and_p_lag_time OUT Number,
    l_and_s_lag_time OUT Number,
    advance_warning OUT Number
  )
  IS
    test_if_data_exists Number(3);
    diagonal_distance NUMBER;
    s_time Number(6, 3);
    l_time Number(6, 3);
    p_time_at_0 Number(6, 3);
  BEGIN
  
    --Counts the rows, to check if the data already exists in the table
    SELECT COUNT(*) INTO test_if_data_exists FROM HRC_earthquake_table;
    
    IF test_if_data_exists = 0 THEN             --Insert the data only if it has not been inserted already, to make it easier to test the script repeatedly (same depth only)
      FOR i IN 0..100 LOOP                      --Loop through the values 0 to 100 km
      
        --Calculate the diagonal distance, to simplify the calculations later on
        diagonal_distance := POWER(POWER(depth_of_earthquake, 2) + POWER(i, 2), 0.5);
        
        --Insert all the data into the table
        INSERT INTO HRC_earthquake_table
          (Horizontal_radius, Diagonal_distance, Time_P_wave, Time_S_wave, Time_L_wave)
          VALUES
          (i, diagonal_distance, diagonal_distance / 8, diagonal_distance / 4.75, (depth_of_earthquake / 8) + (i / 3));
      END LOOP;
    END IF;
    
    --Select the time the S-wave hits at the student's location
    SELECT Time_S_wave
      INTO s_time
      FROM HRC_earthquake_table
      WHERE Horizontal_radius = radius_of_student;
    
    --Select the time the L-wave hits at the student's location
    SELECT Time_L_wave
      INTO l_time
      FROM HRC_earthquake_table
      WHERE Horizontal_radius = radius_of_student;
    
    --Select the time the P-wave hits the epicenter
    SELECT Time_P_wave
      INTO p_time_at_0
      FROM HRC_earthquake_table
      WHERE Horizontal_radius = 0;
    
    --Select the time the P-wave hits at the student's location
    SELECT Time_P_wave
      INTO time_p_wave_hits
      FROM HRC_earthquake_table
      WHERE Horizontal_radius = radius_of_student;
    
    --Calculate the difference between the time the S-wave and the P-wave hits
    s_and_p_lag_time := s_time - time_p_wave_hits;
    
    --Calculate the difference between the time the L-wave and the S-wave hits
    l_and_s_lag_time := l_time - s_time;
    
    --Calculate the advance warning (the time between the P-wave hits the epicenter and the P-wave hits the student's location)
    advance_warning := time_p_wave_hits - p_time_at_0;
    
END HRC_Earthquake_Procedure;
/

--Step 3
--Anonymous Program
--SET serveroutput ON;

DECLARE
  depth_of_earthquake Number(3);
  radius_of_student Number(3);
  time_p_wave_hits Number(6, 3);
  s_and_p_lag_time Number(6, 3);
  l_and_s_lag_time Number(6, 3);
  advance_warning Number(6, 3);
BEGIN
  --Set the depth of the earthquake and the radius of the student
  depth_of_earthquake := 30;
  radius_of_student := 25;

  --Call the stored procedure
  HRC_Earthquake_Procedure(depth_of_earthquake, radius_of_student, time_p_wave_hits, s_and_p_lag_time, l_and_s_lag_time, advance_warning);
  
  dbms_output.enable;
  dbms_output.put_line('Ryan Huffman');
  dbms_output.put_line('Student ID: 1552858');
  dbms_output.put_line('CS65 Fall 2015');
  dbms_output.put_line('Completed 12/03/15');
  
  dbms_output.put_line('Depth of the focus = ' || depth_of_earthquake || ' kilometers');
  dbms_output.put_line('Radius where the CS65 student is coding = ' || radius_of_student || ' kilometers');
  dbms_output.put_line('Time for P-wave to reach radius = ' || time_p_wave_hits || ' seconds');
  dbms_output.put_line('Lag of S-wave behind P-wave = ' || s_and_p_lag_time || ' seconds');
  dbms_output.put_line('Lag of L-wave behind S-wave = ' || l_and_s_lag_time || ' seconds');
  dbms_output.put_line('Advance warning time = ' || advance_warning || ' seconds');
  dbms_output.put_line('Approximate number of combinations of focus depth and radius used to test program: 15');
  dbms_output.put_line('How I''m backing up the script: Flash drives, home computer');
END;
/