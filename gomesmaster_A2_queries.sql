#Assignment 2

#Question 1
USE ischool;
	SELECT CONCAT(fname, " ",lname) AS Name, department, start_date, title, main_phone
	FROM people LEFT JOIN person_addresses
    USING (person_id)
	LEFT JOIN addresses USING (address_id)
	WHERE title > "E" AND main_phone IS NOT NULL 
	UNION
SELECT CONCAT(fname, " ",lname) AS Name, department, start_date, title, 
	"Missing Phone Number" AS main_phone
    FROM people LEFT JOIN person_addresses
    USING (person_id)
	LEFT JOIN addresses USING (address_id)
    WHERE title > "E" AND main_phone IS NULL
    ORDER BY department, start_date;

#Question 2 
USE ischool;
SELECT CONCAT(fname," ",lname) AS Name, college, department, 
	CONCAT(street,",",city,",",state,",",zipcode,",",country) AS address,
	main_phone AS Primary_Phone, classification
    
    FROM people JOIN person_addresses
    USING (person_id)
	JOIN addresses USING (address_id)
    JOIN person_classifications USING (person_id)
    JOIN classification USING (classification_id)
    
	WHERE classification > "Stb" AND department < "C" AND country > "T" 
	ORDER BY lname, fname;