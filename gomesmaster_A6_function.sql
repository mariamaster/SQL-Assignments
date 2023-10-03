-- Assignment 6

/* Answer 2 */
USE ischool;

DROP FUNCTION IF EXISTS get_person_address;
DELIMITER //
CREATE FUNCTION get_person_address (
    first_name VARCHAR(50),
    last_name VARCHAR(50)
)
RETURNS VARCHAR(100)
DETERMINISTIC READS SQL DATA
BEGIN
    DECLARE address VARCHAR(100);
    SELECT CONCAT_WS(', ', street, city, COALESCE(state, '[Not Available]'), 
					zipcode, country) INTO address
    FROM people JOIN person_addresses USING(person_id)
    JOIN addresses USING(address_id)
    WHERE fname = first_name AND lname = last_name;
    RETURN address;
END //
DELIMITER ;

-- Test code
SELECT get_person_address('Kamala','Khan');
SELECT get_person_address('Jessica','Jones');