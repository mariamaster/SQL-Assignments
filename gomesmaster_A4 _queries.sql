#Maria Gomes Master
#Assignment 4

/* Answer 1 */
USE ischool;

-- drop tables if they already exist
DROP TABLE IF EXISTS people_copy;
DROP TABLE IF EXISTS addresses_copy;

-- Like and inserting info
CREATE TABLE people_copy LIKE people; #structuring the new table
CREATE TABLE addresses_copy LIKE addresses;

-- insert data from original tables
INSERT INTO people_copy (SELECT * FROM people); #copying information into the new table
INSERT INTO addresses_copy (SELECT * FROM addresses);

-- insert new information into people_copy
INSERT INTO people_copy
VALUES (132466128, 'Smith', 'Alex', 'asmith@umd.edu', 
		'College of Information Studies', 'MIM', 'GTA', '2023-02-26 00:00:00');

-- insert new information into addresses_copy
INSERT INTO addresses_copy
VALUES (146, '4130 Campus Drive', 'College Park', 'MD', '20742', 'United States',
		'241-464-0373', NULL, NULL);

-- check the new updates
SELECT * FROM people_copy;
SELECT * FROM addresses_copy;

/* Answer 2 */

USE ischool;

SET SQL_SAFE_UPDATES = 0; 

-- drop existing table
DROP TABLE IF EXISTS course_sections_copy;

-- Create new table 
CREATE TABLE course_sections_copy LIKE course_sections;

-- insert information into the new table
INSERT INTO course_sections_copy SELECT * FROM course_sections;

-- Update the delivery information 
UPDATE course_sections_copy
SET location_id = '29', delivery_id = '1' 
	WHERE delivery_id = '3';

UPDATE course_sections_copy
SET year = '2023'
	WHERE year = '2021';

-- SELECT statement to show result	
SELECT section_number AS 'Section No.', CONCAT(semester," ",year) AS 'Term', 
		building_name AS 'Location', room_number AS 'Room No.'
FROM course_sections_copy JOIN locations USING (location_id)
WHERE semester = 'Fall' AND year = '2023'
ORDER BY section_number, building_name, room_number;


/* Answer 3 */
USE ischool;
SELECT *
FROM course_sections_copy;

SET SQL_SAFE_UPDATES = 0;

-- delete all INST 311 sections  for FALL 2023
DELETE FROM course_sections_copy
	WHERE course_id = 11;
        
SELECT section_id AS 'Section ID', CONCAT(course_code," ",course_number) AS 'Course Name',
		credits AS 'Credits', CONCAT(semester," ",year) AS 'Term'
FROM course_sections_copy JOIN courses USING(course_id)
ORDER BY section_id, course_code, course_number;

