#Assignment 1

#Question 1
USE ischool;
    SELECT CONCAT(fname," ",lname) AS "Full Name", email, 
		department, start_date AS "Start Date"
    FROM people
    WHERE start_date > "2021-01-01" AND department IS NOT NULL
    ORDER BY start_date DESC; 
    
#Question 2
USE ischool;
	SELECT section_number AS "Section No", CONCAT (semester," ",year) AS "Term",
		start_time AS "Session start time", end_time as "Session end time", meeting_days AS "Day"
    FROM course_sections
    WHERE meeting_days = "TuTh"
	ORDER BY section_number, start_time; 

