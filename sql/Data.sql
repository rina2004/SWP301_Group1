INSERT INTO Customer VALUES (NULL), (NULL), (NULL), (NULL), (NULL);
INSERT INTO Administrator VALUES (NULL, NULL), (NULL, NULL), (NULL, NULL), (NULL, NULL), (NULL, NULL);
INSERT INTO Staff VALUES (NULL, NOW()), (NULL, NOW()), (NULL, NOW()), (NULL, NOW()), (NULL, NOW());
INSERT INTO AirTrafficControl VALUES (NULL, NOW()), (NULL, NOW()), (NULL, NOW()), (NULL, NOW()), (NULL, NOW());
INSERT INTO airplane_status (name) VALUES 
('Active'), ('Maintenance'), ('Retired'), ('In Use'), ('Under Repair');

INSERT INTO `Compartment` (`id`, `name`, `airplaneID`, `capacity`) 
VALUES ('C001', 'Business Class', 'A001', 30);

INSERT INTO `Compartment` (`id`, `name`, `airplaneID`, `capacity`) 
VALUES ('C002', 'Economy', 'A001', 50);
Delete  From Compartment where id = 'C002';

Select * From airplane;
select * From compartment;
Delete  From Seat;
Update  Airplane Set numberOfCompartments = '4' where id = 'A001'; 
ALTER TABLE Seat CHANGE COLUMN available status VARCHAR(50);
-- Insert into Account
INSERT INTO Account (username, password, citizenID, name, dob, phone, address, email) VALUES
('admin1', 'pass123', '123456789012', 'John Doe', '1990-05-15', '0987654321', '123 Street, City', 'john@example.com'),
('admin2', 'pass123', '123456789013', 'Jane Smith', '1985-08-21', '0976543210', '456 Avenue, City', 'jane@example.com');

-- Insert dữ liệu cho bảng Role
-- INSERT INTO Role (name) VALUES 
-- ('Admin'), ('Staff'), ('Customer');

-- Insert dữ liệu cho bảng Account
-- INSERT INTO Account (username, password, citizenID, name, dob, phone, address, email) VALUES 
-- ('admin01', 'password', '123456789012', 'Admin User', '1985-06-15', '0123456789', 'Hanoi', 'admin@example.com'),
-- ('staff01', 'password', '234567890123', 'Staff User', '1990-08-22', '0987654321', 'HCM City', 'staff@example.com'),
-- ('customer01', 'password', '345678901234', 'Customer User', '1995-03-10', '0901234567', 'Da Nang', 'customer@example.com');

-- Insert dữ liệu cho bảng AccountUserRole
-- INSERT INTO AccountUserRole (accountID, entityID, roleID) VALUES 
-- ('admin01', 1, 1),
-- ('staff01', 2, 2),
-- ('customer01', 3, 3);

-- Insert dữ liệu cho bảng Administrator
-- INSERT INTO Administrator (id, roleID) VALUES 
-- ('admin01', 1);
-- Thêm dữ liệu vào bảng Role
INSERT INTO `Role` (`name`) VALUES
('Administrator'),
('Customer'),
('Staff'),
('AirTrafficControl');

-- Thêm dữ liệu vào bảng Feature
INSERT INTO `Feature` (`name`, `url`) VALUES
('Quản lý tài khoản', '/admin/accounts'),
('Xem lịch bay', '/customer/flights'),
('Quản lý chuyến bay', '/staff/flights'),
('Điều phối không lưu', '/atc/control');

-- Thêm dữ liệu vào bảng RoleFeature (Phân quyền cho vai trò)
INSERT INTO `RoleFeature` (`roleID`, `featureID`) VALUES
(1, 1), -- Admin có quyền quản lý tài khoản
(2, 2), -- Customer có quyền xem lịch bay
(3, 3), -- Staff có quyền quản lý chuyến bay
(4, 4), -- AirTrafficControl có quyền điều phối không lưu
(1, 2), -- Admin cũng có thể xem lịch bay
(3, 2); -- Staff cũng có thể xem lịch bay

-- Thêm dữ liệu vào bảng Account (Người dùng mẫu)
INSERT INTO `Account` (`username`, `password`, `roleID`, `status`, `citizenID`, `name`, `dob`, `phone`, `address`, `email`)
VALUES
('admin', 'admin123', 1, TRUE, '123456789012', 'Nguyễn Văn A', '1985-07-10', '0901234567', 'Hà Nội', 'admin@example.com'),
('john_doe', 'password123', 2, TRUE, '987654321012', 'John Doe', '1990-03-15', '0912345678', 'TP. Hồ Chí Minh', 'john.doe@example.com'),
('staff01', 'staffpass', 3, TRUE, '112233445566', 'Trần Thị B', '1988-11-20', '0923456789', 'Đà Nẵng', 'staff01@example.com'),
('atc01', 'atcpass', 4, TRUE, '667788990011', 'Lê Văn C', '1992-05-25', '0934567890', 'Hải Phòng', 'atc01@example.com');

Select * From `Account`;

Select * From `Role`;

-- Insert dữ liệu cho bảng Staff
-- INSERT INTO Staff (id, createdDate) VALUES 
-- ('staff01', '2023-05-01 09:00:00');

-- Insert dữ liệu cho bảng AirTrafficControl
-- INSERT INTO AirTrafficControl (id, name, createdDate) VALUES 
-- ('ATC001', 'Control Tower 1', '2023-01-01 08:00:00');

-- Insert dữ liệu cho bảng Type
-- INSERT INTO Type (id, Name, manufacture, length, weight, height, atcID) VALUES 
-- ('TYP001', 'Boeing 737', 'Boeing', 39.5, 41.4, 12.5, 'ATC001');
-- Insert into Flight
INSERT INTO Flight (id, name, code, airplaneID, departure, destination, entryTime, startingTime, landingTime, atcID) VALUES
(NULL, 'Flight 101', 'FL101', 'PL1', 'Hanoi', 'Ho Chi Minh City', '2024-03-10 08:00:00', '2025-03-10 09:00:00', '2025-03-10 11:00:00', 'ATC1'),
(NULL, 'Flight 202', 'FL202', 'PL2', 'Da Nang', 'Singapore', '2024-04-15 10:30:00', '2025-04-15 11:30:00', '2025-04-15 14:00:00', 'ATC2');
-- Insert dữ liệu cho bảng Compartment
-- INSERT INTO Compartment (id, name, typeID, capacity) VALUES 
-- ('C001', 'Business Class', 'TYP001', 50);

-- Insert dữ liệu cho bảng Airplane_Status
-- INSERT INTO Airplane_Status (name) VALUES 
-- ('Available'), ('Maintenance'), ('In Use');

-- Insert dữ liệu cho bảng Airplane
-- INSERT INTO Airplane (id, name, typeID, statusID, maintainanceTime, usedTime, atcID) VALUES 
-- ('PL001', 'Plane 001', 'TYP001', 1, '2024-02-01 10:00:00', '2024-02-15 10:00:00', 'ATC001');

select * from Flight;
Select * From Ticket;
Select * From Luggage;
Select * From Account ;
delete from Luggage where id = 'L289' ;
INSERT INTO Ticket ( flightID, type, Price, Status) 
VALUES ('F001', 'Business', 200.00, 'Available');
DELETE FROM Type WHERE id IN ('A115', 'A116');
SET SQL_SAFE_UPDATES = 0;
INSERT INTO `AirplaneStatus` (`name`) VALUES 
('Active'), 
('Maintenance'), 
('Decommissioned');
ALTER TABLE Luggage ADD COLUMN price DECIMAL(10,2) NOT NULL DEFAULT 0;
Select * From Luggage;

Select s.id, c.name,s.compartmentID,s.available,c.typeID From Seat s Join Compartment c On c.id = s.compartmentID Where s.compartmentID = 'E' And c.typeID = 'A110';
delete From Account where username = 'khanhtungnguyen';
INSERT INTO `Type` (`id`, `Name`, `manufacture`, `length`, `weight`, `height`) VALUES 
('B737', 'Boeing 737-800', 'Boeing', 39.50, 41413.00, 12.50),
('A320', 'Airbus A320', 'Airbus', 37.57, 42200.00, 11.76);

INSERT INTO `Type` (`id`, `Name`, `manufacture`, `length`, `weight`, `height`) VALUES 
('B737', 'Boeing 737-800', 'Boeing', 39.50, 41413.00, 12.50);

-- Thêm dữ liệu vào bảng Airplane (giả sử có sẵn Type ID là 'B737' và 'A320')
INSERT INTO `Airplane` (`id`, `name`, `typeID`, `statusID`, `maintainanceTime`, `usedTime`) VALUES 
('VN001', 'Boeing 737-800', 'B737', 1, '2025-06-15 12:00:00', '2015-03-10 08:00:00'),
('VN002', 'Airbus A320', 'A320', 2, '2025-04-10 10:00:00', '2017-07-22 09:30:00');

Select * From AirplaneStatus;

-- Thêm máy bay
INSERT INTO `Airplane` (`id`, `name`, `statusID`, `maintainanceTime`, `usedTime`) VALUES 
('A003', 'Airbus A320', 2, '2025-03-12 10:00:00', '2022-09-15 14:20:00');

-- Thêm chuyến bay
INSERT INTO `Flight` (`id`, `name`, `code`, `airplaneID`, `departure`, `destination`, `entryTime`, `startingTime`, `landingTime`) VALUES 
('F001', 'VN001', 'VN001-2025', 'A001', 'Ho Chi Minh', 'Hanoi', '2025-03-15 06:00:00', '2025-03-15 07:00:00', '2025-03-15 09:00:00'),
('F002', 'VN002', 'VN002-2025', 'A002', 'Hanoi', 'Da Nang', '2025-03-16 10:00:00', '2025-03-16 11:00:00', '2025-03-16 12:30:00');

INSERT INTO Airplane (id, name, statusID, maintainanceTime, usedTime) VALUES
('VN-A001', 'Sky Dragon', 1, '2024-06-15 08:00:00', '2023-12-01 00:00:00'),
('VN-A002', 'Ocean Star', 2, '2024-07-20 10:30:00', '2024-01-15 00:00:00');

INSERT INTO Compartment (id, name, airplaneID, capacity) VALUES
('VN-A001-B1', 'Business','VN-A001',20),
('VN-A001-B2', 'Business','VN-A001',20),
('VN-A001-B3', 'Business','VN-A001',20),
('VN-A001-E1', 'Economy','VN-A001',20),
('VN-A001-E2', 'Economy','VN-A001',20),
('VN-A001-E3', 'Economy','VN-A001',20),
('VN-A001-F1','First Class','VN-A001',20),
('VN-A001-F2', 'First Class','VN-A001',20),
('VN-A001-F3', 'First Class','VN-A001',20),
('VN-A002-B1', 'Business','VN-A002',20);

SELECT c.*, t.name AS type_name FROM Compartment c JOIN Type t ON c.typeID = t.id;
Select * From Compartment ;
ALTER TABLE Compartment DROP PRIMARY KEY, ADD PRIMARY KEY (id, typeID);
Select id From `Type` Where id = 'A109';
Select Name From `Type` Where Name = 'Airbus A109';
Select * From Seat ;

Select * From Flight;

Select * From Ticket;
DELETE FROM `Seat` WHERE `id` = 'B1';
Delete From `Compartment` Where `id` = 'E';

SELECT * FROM Flight;
SELECT * FROM Seat;
SELECT * FROM `Order`;

SELECT c.id, c.name AS compartment_name, t.id AS type_id, t.name AS type_name, c.capacity
FROM Compartment c
JOIN Type t ON c.typeID = t.id;

ALTER TABLE `Seat` DROP FOREIGN KEY `seat_ibfk_1`;
ALTER TABLE `Seat` ADD CONSTRAINT `seat_ibfk_1` 
FOREIGN KEY (`compartmentID`) REFERENCES `Compartment`(`id`) ON DELETE CASCADE;

SELECT * FROM Compartment;

SELECT * FROM Seat Where typeID = 'A112' and compartmentID = 'F';
Select * FROM Flight;
DELETE FROM Type;
drop table type;
DESCRIBE Type;
DESCRIBE Compartment;
DESCRIBE Seat;
SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'Compartment' AND COLUMN_NAME = 'typeID';
ALTER TABLE Compartment DROP FOREIGN KEY compartment_ibfk_1;
drop table Type;
DESC AirPlane;
DESC Compartment;
Select s.id, c.name, s.compartmentID, s.status, c.typeID
From Seat s
Join Compartment c On c.id = s.compartmentID
Where s.compartmentID = 'B739' And c.typeID = 'Economy';

SELECT COLUMN_NAME, CONSTRAINT_NAME, TABLE_NAME 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
WHERE TABLE_NAME = 'Seat';

Select * From Seat s join Compartment c On c.id = s.compartmentID  Where s.id = 'A115_B_10';

SET SQL_SAFE_UPDATES = 0;
ALTER TABLE Seat ADD COLUMN typeID VARCHAR(10);
ALTER TABLE Seat ADD CONSTRAINT fk_seat_type FOREIGN KEY (typeID) REFERENCES Type(id) ON DELETE CASCADE;
INSERT INTO Type (id, Name, manufacture, length, weight, height) 
VALUES ('B730', 'Boeing 737-800', 'Boeing', 39.50, 41413.00, 12.50);

INSERT INTO `Airplane` (`id`, `name`, `typeID`, `statusID`, `maintainanceTime`, `usedTime`) VALUES
('VN-A123', 'Boeing 737-800', 'B738', 1, '2025-06-01 12:00:00', '2023-03-15 08:30:00');

INSERT INTO `Flight` (`id`, `name`, `code`, `airplaneID`, `departure`, `destination`, `entryTime`, `startingTime`, `landingTime`) VALUES
('FL001', 'VN123', 'VN123-B738', 'VN-A123', 'Hà Nội', 'TP.HCM', '2025-03-20 06:00:00', '2025-03-20 07:30:00', '2025-03-20 09:00:00');

insert into `ticket` (`id`,`flightID`,`type`,`Price`,`Status`) Value('T001','FL001','available','9000','Available');

Select id From `Type` Where id = 'A115';
ALTER TABLE Seat CHANGE status status VARCHAR(20);
UPDATE Seat SET status = 'Maintained' WHERE id ='A115_B_2';
UPDATE Seat SET status = 'Booked' WHERE status = '0'; -- Nếu trước đó 0 là false  
ALTER TABLE Compartment MODIFY COLUMN id VARCHAR(20);
ALTER TABLE Seat MODIFY COLUMN compartmentID VARCHAR(20);
ALTER TABLE Seat ADD CONSTRAINT fk_seat_compartment 
FOREIGN KEY (compartmentID) REFERENCES Compartment(id) ON DELETE CASCADE;
INSERT INTO AirplaneStatus (id, name) 

VALUES 
(1, 'Active'), 
(2, 'Maintenance'), 
(3, 'Out of Service');
ALTER TABLE Airplane ADD COLUMN numberOfCompartments INT NOT NULL DEFAULT 0;

INSERT INTO Airplane (id, name, statusID, maintainanceTime, usedTime)
VALUES 
('A001', 'Boeing 747', 1, '2025-03-18 12:00:00', '2025-03-10 08:00:00'),
('A002', 'Airbus A320', 2, '2025-03-19 14:00:00', '2025-03-11 10:00:00');
UPDATE Airplane SET numberOfCompartments = 4 WHERE id = 'A002';
Select * From Airplane;

-- Insert into Luggage
INSERT INTO Luggage (id, customerID, orderID, type, weight) VALUES
('O1', 'C1', (SELECT id FROM `Order` ORDER BY time DESC LIMIT 1), 'Checked', 20.5),
('O2', 'C2', (SELECT id FROM `Order` ORDER BY time DESC LIMIT 1 OFFSET 1), 'Cabin', 7.0);

-- Insert dữ liệu cho bảng Flight
-- INSERT INTO Flight (id, name, code, airplaneID, departure, destination, entryTime, startingTime, landingTime, atcID) VALUES 
-- ('FL001', 'Hanoi to HCM', 'VN123', 'PL001', 'Hanoi', 'HCM City', '2024-02-25 06:00:00', '2024-02-25 07:00:00', '2024-02-25 09:00:00', 'ATC001');

-- Insert dữ liệu cho bảng Seat
-- INSERT INTO Seat (id, compartmentID, available) VALUES 
-- ('S001', 'C001', TRUE);

-- Insert dữ liệu cho bảng Order
-- INSERT INTO Order (id, customerID, staffID, status, time) VALUES 
-- ('O001', 'customer01', 'staff01', 'Confirmed', '2024-02-20 14:30:00');

-- Insert dữ liệu cho bảng Ticket
-- INSERT INTO Ticket (id, staffID, orderID, flightID, seatID, type, Price, Status) VALUES 
-- ('T001', 'staff01', 'O001', 'FL001', 'S001', 'Economy', 150.00, 'Booked');

-- Insert dữ liệu cho bảng Luggage
-- INSERT INTO Luggage (id, customerID, orderID, type, weight) VALUES 
-- ('L001', 'customer01', 'O001', 'Checked', 20.5);

-- Insert dữ liệu cho bảng BlogCategory
-- INSERT INTO BlogCategory (name) VALUES 
-- ('Technology'), ('Aviation'), ('Travel');

-- Insert dữ liệu cho bảng BlogPost
-- INSERT INTO BlogPost (title, content, image, authorID) VALUES 
-- ('Tech Innovations', 'Latest in aviation technology...', 'tech.jpg', '5394ac40-f85c-11ef-86fb-3c2c30e1270f'),
-- ('New Flight Routes', 'Exciting new travel destinations...', 'travel.jpg', '5394ac40-f85c-11ef-86fb-3c2c30e1270f'),
-- ('Pilot Training', 'Understanding the new pilot training process...', 'pilot.jpg', '5394ac40-f85c-11ef-86fb-3c2c30e1270f'),
-- ('Airplane Maintenance', 'How maintenance is conducted...', 'maintenance.jpg', '5394ac40-f85c-11ef-86fb-3c2c30e1270f'),
-- ('Flight Safety', 'Ensuring passenger safety...', 'safety.jpg', '5394ac40-f85c-11ef-86fb-3c2c30e1270f'),
-- ('Airport Operations', 'Behind the scenes at the airport...', 'operations.jpg', '5394ac40-f85c-11ef-86fb-3c2c30e1270f'),
-- ('Customer Experience', 'Enhancing customer journeys...', 'customer.jpg', '5394ac40-f85c-11ef-86fb-3c2c30e1270f');

-- Insert dữ liệu cho bảng Blog
INSERT INTO Blog (postID, title, description, image, categoryID) VALUES 
('POST-950d0b80-f86d-11ef-86fb-3c2c30e1270f', 'Tech Innovations', 'A deep dive into the latest aviation tech.', 'deal1.jpg', 1),
('POST-950d1027-f86d-11ef-86fb-3c2c30e1270f', 'New Flight Routes', 'Discover new airline routes worldwide.', 'deal2.jpg', 2),
('POST-950d116d-f86d-11ef-86fb-3c2c30e1270f', 'Pilot Training', 'How pilots are trained for modern aircraft.', 'deal3.jpg', 2),
('POST-950d12df-f86d-11ef-86fb-3c2c30e1270f', 'Airplane Maintenance', 'The crucial process of airplane maintenance.', 'deal4.jpg', 1),
('POST-950d1513-f86d-11ef-86fb-3c2c30e1270f', 'Flight Safety', 'Measures taken to ensure safe flights.', 'deal2.jpg', 2),
('POST-950d162f-f86d-11ef-86fb-3c2c30e1270f', 'Airport Operations', 'Insights into daily airport operations.', 'deal3.jpg', 3),
('POST-950d1729-f86d-11ef-86fb-3c2c30e1270f', 'Customer Experience', 'Improving passenger satisfaction in aviation.', 'deal1.jpg', 3);

-- Insert dữ liệu cho bảng Comment
INSERT INTO Comment (postID, accountID, content) VALUES 
('POST-950d0b80-f86d-11ef-86fb-3c2c30e1270f', '5394adb9-f85c-11ef-86fb-3c2c30e1270f', 'Great article!'),
('POST-950d1027-f86d-11ef-86fb-3c2c30e1270f', '5394adb9-f85c-11ef-86fb-3c2c30e1270f', 'Very informative!');

-- Insert dữ liệu cho bảng PostLike
INSERT INTO PostLike (postID, accountID) VALUES 
('POST-950d0b80-f86d-11ef-86fb-3c2c30e1270f', '5394adb9-f85c-11ef-86fb-3c2c30e1270f'),
('POST-950d1027-f86d-11ef-86fb-3c2c30e1270f', '5394adb9-f85c-11ef-86fb-3c2c30e1270f');