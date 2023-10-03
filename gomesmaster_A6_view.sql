-- Assignment 6

/* Answer 1 */
USE ischool;
DROP VIEW IF EXISTS student_enrollment_details;
CREATE VIEW student_enrollment_details AS
	SELECT CONCAT(fname,' ',lname) AS "name", CONCAT(semester,' ',year) AS "term", 
		COUNT(course_id) AS "no_of_courses_enrolled", 
        SUM(credits) AS "credits_taken", 
        COUNT(course_prereq) AS "courses_with_prerequisites"
	FROM people JOIN enrollments USING(person_id)
        JOIN course_sections USING(section_id)
        JOIN courses USING(course_id)
	WHERE meeting_days != "ONLINE"
    GROUP BY name, semester, year
    HAVING semester = 'Fall' AND year = 2021
    ORDER BY name;