DELIMITER $$
CREATE TRIGGER before_insert_customer
BEFORE INSERT ON Customer
FOR EACH ROW
BEGIN
    DECLARE max_id INT;
    DECLARE new_id VARCHAR(10);

    SELECT COALESCE(MAX(CAST(SUBSTRING(id, 2) AS UNSIGNED)), 0) INTO max_id FROM Customer;

	SET new_id = CONCAT('C', max_id + 1);
    SET NEW.id = new_id;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER before_insert_staff
BEFORE INSERT ON Staff
FOR EACH ROW
BEGIN
    DECLARE max_id INT;
    DECLARE new_id VARCHAR(10);

    SELECT COALESCE(MAX(CAST(SUBSTRING(id, 2) AS UNSIGNED)), 0) INTO max_id FROM Staff;

    SET new_id = CONCAT('S', max_id + 1);
    SET NEW.id = new_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER before_insert_airtrafficcontrol
BEFORE INSERT ON AirTrafficControl
FOR EACH ROW
BEGIN
    DECLARE max_id INT;
    DECLARE new_id VARCHAR(10);

    SELECT COALESCE(MAX(CAST(SUBSTRING(id, 2) AS UNSIGNED)), 0) INTO max_id FROM Staff;

    SET new_id = CONCAT('ATC', max_id + 1);
    SET NEW.id = new_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER before_insert_admin
BEFORE INSERT ON Administrator
FOR EACH ROW
BEGIN
    DECLARE max_id INT;
    DECLARE new_id VARCHAR(10);

    SELECT COALESCE(MAX(CAST(SUBSTRING(id, 2) AS UNSIGNED)), 0) INTO max_id FROM Staff;

    SET new_id = CONCAT('ADMIN', max_id + 1);
    SET NEW.id = new_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER before_insert_airplane
BEFORE INSERT ON Airplane
FOR EACH ROW
BEGIN
    DECLARE max_id INT;
    DECLARE new_id VARCHAR(10);

    SELECT COALESCE(MAX(CAST(SUBSTRING(id, 2) AS UNSIGNED)), 0) INTO max_id FROM Staff;

    SET new_id = CONCAT('PL', max_id + 1);
    SET NEW.id = new_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER before_insert_flight
BEFORE INSERT ON Flight
FOR EACH ROW
BEGIN
    DECLARE max_id INT;
    DECLARE new_id VARCHAR(10);

    SELECT COALESCE(MAX(CAST(SUBSTRING(id, 2) AS UNSIGNED)), 0) INTO max_id FROM Staff;

    SET new_id = CONCAT('F', max_id + 1);
    SET NEW.id = new_id;
END$$
DELIMITER ;