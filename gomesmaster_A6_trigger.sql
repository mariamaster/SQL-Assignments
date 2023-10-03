-- Assignment 6

/* Answer 3 */

USE ischool;

## Run the code below before working on the trigger
DROP TABLE IF EXISTS enrollment_records;
CREATE TABLE enrollment_records AS
SELECT * FROM student_enrollment_details;
ALTER TABLE enrollment_records ADD PRIMARY KEY (Name);

DROP TABLE IF EXISTS new_student_enrollment_records;
CREATE TABLE new_student_enrollment_records(
new_student_Name varchar(45) NOT NULL,
new_student_enrollment_record_text varchar(300) DEFAULT NULL,
new_student_enrollment_record_timestamp datetime DEFAULT NULL,
PRIMARY KEY (new_student_Name))

ENGINE=InnoDB;
# ----------------------

# The process for creating the trigger begins here
DROP TRIGGER IF EXISTS ischool.new_student_enrollments;
DELIMITER //
CREATE TRIGGER new_student_enrollments AFTER INSERT ON enrollment_records
FOR EACH ROW
BEGIN
	DECLARE student_name_var VARCHAR(45);
    DECLARE no_of_courses_enrolled_var INT;
    DECLARE credits_taken_var INT;
    DECLARE term_var VARCHAR(45);
    
    SET student_name_var = NEW.Name;
    SET no_of_courses_enrolled_var = NEW.no_of_courses_enrolled;
    SET credits_taken_var = NEW.credits_taken;
    SET term_var = NEW.term;
    
    INSERT INTO new_student_enrollment_records 
				(new_student_Name, 
				new_student_enrollment_record_text, 
                new_student_enrollment_record_timestamp) 
    VALUES (student_name_var, CONCAT('You have added a new student, ', 
			student_name_var, ', who registered for ', no_of_courses_enrolled_var, 
            ' courses this ', term_var, ' and will be taking ', credits_taken_var, 
            ' credits.'), NOW());
END//
DELIMITER ;

-- Test code
INSERT INTO enrollment_records VALUES ('Alex Smith', 'Fall 2022', 4, 12, 1);
SELECT * FROM new_student_enrollment_records;