CREATE DATABASE `swp301`;
USE `swp301`;

DROP database `swp301`;


CREATE TABLE `Customer` (
  `id` BINARY(16),
  
  PRIMARY KEY (`id`)
);

CREATE TABLE `Administrator` (
  `id` BINARY(16),
  `roleID` INT,
  
  PRIMARY KEY (`id`)
);

CREATE TABLE `Staff` (
  `id` BINARY(16),
  `createdDate` DATETIME,
  
  PRIMARY KEY (`id`)
);

CREATE TABLE `AirTrafficControl` (
  `id` binary(16),
  
  PRIMARY KEY (`id`)
);

CREATE TABLE `Role` (
  `id` INT AUTO_INCREMENT,
  `name` VARCHAR(50),
  `adminID` binary(16),
	
  PRIMARY KEY (`id`),
  foreign key (`adminID`) references `Administrator`(`id`)
);

CREATE TABLE `Account` (
  `username` VARCHAR(50),
  `password` VARCHAR(50) NOT NULL,
  `status` bool DEFAULT(TRUE),
  `roleID` INT,
  `id` BINARY(16) UNIQUE,
  `citizenID` VARCHAR(12),
  `name` VARCHAR(50),
  `dob` DATE,
  `phone` VARCHAR(10),
  `address` VARCHAR(255),
  `email` VARCHAR(255),
  `adminID` binary(16),
  
  PRIMARY KEY (`username`),
  FOREIGN KEY (`roleID`) REFERENCES `Role`(`id`),
  FOREIGN KEY (`id`) references `Customer`(`id`),
  FOREIGN KEY (`id`) references `Staff`(`id`),
  FOREIGN KEY (`id`) references `AirTrafficControl`(`id`),
  FOREIGN KEY (`adminID`) references `Administrator`(`id`)
);

INSERT INTO Customer (id) 
VALUES(UUID_TO_BIN(UUID())); 

INSERT INTO Administrator (id, roleID) 
VALUES(UUID_TO_BIN(UUID()), 1);

select BIN_TO_UUID(`id`) as id from customer;

INSERT INTO Account (username, password, roleID, id, citizenID, name, dob, phone, address, email, adminID)
VALUES 
('johndoe', 'password123', 2,UUID_TO_BIN('4aa13731-e62c-11ef-8179-739aa87d79e6'
)
, '123456789012', 'John Doe', '1990-01-01', '0123456789', '1234 Street, City', 'johndoe@example.com', UUID_TO_BIN('c85ccd2e-e632-11ef-8179-739aa87d79e6'
));

Select * from Customer;

Select * from Administrator;

select BIN_TO_UUID(`id`) as id from Administrator;

-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

CREATE table `Status_Airplane` (
	`id` INT auto_increment,
    `name` varchar(50),
    
    primary key (`id`)
 );
 
CREATE TABLE `Airplane` (
  `id` varchar(10),
  `name` varchar(50),
  `typeID` varchar(10),
  `statusID` int,
  `maintainanceTime` datetime,
  `usedTime` datetime,
  `atcID` binary(16),
  
  PRIMARY KEY (`id`),
  foreign key (`statusID`) references `Status_Airplane`(`id`),
  foreign key (`atcID`) references `AirTrafficControl`(`id`)
);

CREATE TABLE `Type` (
  `id` varchar(10),
  `Name` varchar(50),
  `compartmentID` char,
  `manufacture` varchar(50),
  `Length` decimal(10,2),
  `Weight` decimal(10,2),
  `Height` decimal(10,2),
  `atcID` binary(16),
  
  PRIMARY KEY (`id`),
  foreign key (`atcID`) references `AirTrafficControl`(`id`)
);

CREATE TABLE `Compartment` (
  `id` char,
  `name` varchar(50),
  `typeID` varchar(10),
  `capacity` int,
  
  PRIMARY KEY (`id`),
  foreign key (`typeID`) references `Type`(`id`)
);

CREATE TABLE `Flight` (
  `id` varchar(10),
  `name` varchar(50),
  `code` varchar(50),
  `airplaneID` varchar(10),
  `departure` varchar(255),
  `destination` varchar(255),
  `entryTime` datetime,
  `startingTime` datetime,
  `landingTime` datetime,
  `atcID` binary(16),
  
  PRIMARY KEY (`id`),
  foreign key (`airplaneID`) references `Airplane`(`id`),
  foreign key (`atcID`) references `AirTrafficControl`(`id`)
);

CREATE TABLE `Seat` (
  `id` varchar(10),
  `compartmentID` char,
  `available` bool,
  
  PRIMARY KEY (`id`),
  foreign key (`compartmentID`) references `Compartment`(`id`)
);

CREATE TABLE `Order` (
  `id` varchar(10),
  `customerID` binary(16),
  `staffID` binary(16),
  `status` varchar(50),
  `time` datetime,
  
  PRIMARY KEY (`id`),
  foreign key (`customerID`) references `Customer`(`id`),
  foreign key (`staffID`) references `Staff`(`id`)
);

CREATE TABLE `Ticket` (
  `id` varchar(10),
  `staffID` binary(16),
  `orderID` varchar(10),
  `flightID` varchar(10),
  `seatID` varchar(10),
  `Type` varchar(30),
  `Price` decimal(10,2),
  `Status` varchar(20),
  
  PRIMARY KEY (`id`),
  foreign key (`orderID`) references `Order`(`id`),
  foreign key (`staffID`) references `Staff`(`id`),
  foreign key (`flightID`) references `Flight`(`id`),
  foreign key (`seatID`) references `Seat`(`id`)
);

CREATE TABLE `Luggage` (
  `id` varchar(10),
  `customerID` binary(16),
  `orderID` varchar(10),
  `type` varchar(30),
  `weight` decimal(10,2),
  
  PRIMARY KEY (`id`),
  foreign key (`customerID`) references `Customer`(`id`),
  foreign key (`orderID`) references `Order`(`id`)
)

-- Insert data into Customer
INSERT INTO `Customer` (`id`) VALUES 
  (0x00000000000000000000000000000001),
  (0x00000000000000000000000000000002),
  (0x00000000000000000000000000000003),
  (0x00000000000000000000000000000004),
  (0x00000000000000000000000000000005),
  (0x00000000000000000000000000000006),
  (0x00000000000000000000000000000007),
  (0x00000000000000000000000000000008),
  (0x00000000000000000000000000000009),
  (0x0000000000000000000000000000000A);

-- Insert data into Administrator
INSERT INTO `Administrator` (`id`, `roleID`) VALUES 
  (0x00000000000000000000000000000001, 1),
  (0x00000000000000000000000000000002, 2),
  (0x00000000000000000000000000000003, 1),
  (0x00000000000000000000000000000004, 3),
  (0x00000000000000000000000000000005, 2),
  (0x00000000000000000000000000000006, 3),
  (0x00000000000000000000000000000007, 1),
  (0x00000000000000000000000000000008, 2),
  (0x00000000000000000000000000000009, 3),
  (0x0000000000000000000000000000000A, 1);

-- Insert data into Staff
INSERT INTO `Staff` (`id`, `createdDate`) VALUES 
  (0x00000000000000000000000000000001, NOW()),
  (0x00000000000000000000000000000002, NOW()),
  (0x00000000000000000000000000000003, NOW()),
  (0x00000000000000000000000000000004, NOW()),
  (0x00000000000000000000000000000005, NOW()),
  (0x00000000000000000000000000000006, NOW()),
  (0x00000000000000000000000000000007, NOW()),
  (0x00000000000000000000000000000008, NOW()),
  (0x00000000000000000000000000000009, NOW()),
  (0x0000000000000000000000000000000A, NOW());

-- Insert data into AirTrafficControl
INSERT INTO `AirTrafficControl` (`id`) VALUES 
  (0x00000000000000000000000000000001),
  (0x00000000000000000000000000000002),
  (0x00000000000000000000000000000003),
  (0x00000000000000000000000000000004),
  (0x00000000000000000000000000000005),
  (0x00000000000000000000000000000006),
  (0x00000000000000000000000000000007),
  (0x00000000000000000000000000000008),
  (0x00000000000000000000000000000009),
  (0x0000000000000000000000000000000A);

-- Insert data into Role
INSERT INTO `Role` (`name`, `adminID`) VALUES 
  ('Role1', 0x00000000000000000000000000000001),
  ('Role2', 0x00000000000000000000000000000002),
  ('Role3', 0x00000000000000000000000000000003),
  ('Role4', 0x00000000000000000000000000000004),
  ('Role5', 0x00000000000000000000000000000005),
  ('Role6', 0x00000000000000000000000000000006),
  ('Role7', 0x00000000000000000000000000000007),
  ('Role8', 0x00000000000000000000000000000008),
  ('Role9', 0x00000000000000000000000000000009),
  ('Role10', 0x0000000000000000000000000000000A);

-- Insert data into Account
INSERT INTO `Account` (`username`, `password`, `status`, `roleID`, `id`, `citizenID`, `name`, `dob`, `phone`, `address`, `email`, `adminID`) VALUES 
  ('user1', 'pass1', TRUE, 1, 0x00000000000000000000000000000001, '123456789', 'John Doe', '1990-01-01', '0123456789', '123 Street', 'john@example.com', 0x00000000000000000000000000000001),
  ('user2', 'pass2', TRUE, 2, 0x00000000000000000000000000000002, '123456780', 'Jane Doe', '1992-02-02', '0123456788', '124 Street', 'jane@example.com', 0x00000000000000000000000000000002),
  ('user3', 'pass3', TRUE, 3, 0x00000000000000000000000000000003, '123456781', 'Alice', '1991-03-03', '0123456787', '125 Street', 'alice@example.com', 0x00000000000000000000000000000003),
  ('user4', 'pass4', TRUE, 1, 0x00000000000000000000000000000004, '123456782', 'Bob', '1989-04-04', '0123456786', '126 Street', 'bob@example.com', 0x00000000000000000000000000000004),
  ('user5', 'pass5', TRUE, 2, 0x00000000000000000000000000000005, '123456783', 'Charlie', '1988-05-05', '0123456785', '127 Street', 'charlie@example.com', 0x00000000000000000000000000000005),
  ('user6', 'pass6', TRUE, 3, 0x00000000000000000000000000000006, '123456784', 'David', '1993-06-06', '0123456784', '128 Street', 'david@example.com', 0x00000000000000000000000000000006),
  ('user7', 'pass7', TRUE, 1, 0x00000000000000000000000000000007, '123456785', 'Eve', '1987-07-07', '0123456783', '129 Street', 'eve@example.com', 0x00000000000000000000000000000007),
  ('user8', 'pass8', TRUE, 2, 0x00000000000000000000000000000008, '123456786', 'Frank', '1994-08-08', '0123456782', '130 Street', 'frank@example.com', 0x00000000000000000000000000000008),
  ('user9', 'pass9', TRUE, 3, 0x00000000000000000000000000000009, '123456787', 'Grace', '1995-09-09', '0123456781', '131 Street', 'grace@example.com', 0x00000000000000000000000000000009),
  ('user10', 'pass10', TRUE, 1, 0x0000000000000000000000000000000A, '123456788', 'Hank', '1996-10-10', '0123456780', '132 Street', 'hank@example.com', 0x0000000000000000000000000000000A);

-- Insert data into Status_Airplane
INSERT INTO `Status_Airplane` (`name`) VALUES 
  ('On Ground'),
  ('In Air'),
  ('Under Maintenance'),
  ('Scheduled'),
  ('Delayed'),
  ('Cancelled'),
  ('Completed'),
  ('Boarding'),
  ('Departed'),
  ('Arrived');

-- Insert data into Airplane
INSERT INTO `Airplane` (`id`, `name`, `typeID`, `statusID`, `maintainanceTime`, `usedTime`, `atcID`) VALUES 
  ('A001', 'Boeing 737', 'T001', 1, NOW(), NOW(), 0x00000000000000000000000000000001),
  ('A002', 'Airbus A320', 'T002', 2, NOW(), NOW(), 0x00000000000000000000000000000002),
  ('A003', 'Boeing 777', 'T001', 1, NOW(), NOW(), 0x00000000000000000000000000000003),
  ('A004', 'Airbus A380', 'T003', 3, NOW(), NOW(), 0x00000000000000000000000000000004),
  ('A005', 'Boeing 747', 'T002', 1, NOW(), NOW(), 0x00000000000000000000000000000005),
  ('A006', 'Embraer E195', 'T001', 2, NOW(), NOW(), 0x00000000000000000000000000000006),
  ('A007', 'Bombardier CRJ900', 'T003', 1, NOW(), NOW(), 0x00000000000000000000000000000007),
  ('A008', 'Boeing 787', 'T001', 4, NOW(), NOW(), 0x00000000000000000000000000000008),
  ('A009', 'Airbus A350', 'T002', 1, NOW(), NOW(), 0x00000000000000000000000000000009),
  ('A010', 'McDonnell Douglas MD-80', 'T003', 2, NOW(), NOW(), 0x0000000000000000000000000000000A);


-- Insert data into Type
INSERT INTO `Type` (`id`, `Name`, `compartmentID`, `manufacture`, `Length`, `Weight`, `Height`, `atcID`) VALUES 
  ('T001', 'Passenger', 'A', 'Boeing', 30.00, 40000.00, 10.00, 0x00000000000000000000000000000001),
  ('T002', 'Cargo', 'B', 'Airbus', 25.00, 50000.00, 9.00, 0x00000000000000000000000000000002),
  ('T003', 'VIP', 'C', 'Embraer', 20.00, 30000.00, 8.00, 0x00000000000000000000000000000003);

-- Insert data into Compartment
INSERT INTO `Compartment` (`id`, `name`, `typeID`, `capacity`) VALUES 
  ('A', 'First Class', 'T001', 10),
  ('B', 'Economy Class', 'T001', 100),
  ('C', 'Cargo Hold', 'T002', 50);

-- Insert data into Flight
INSERT INTO `Flight` (`id`, `Name`, `Code`, `airplaneID`, `Departure`, `Destination`, `entryTime`, `startingTime`, `landingTime`, `atcID`) VALUES 
  ('F001', 'Flight 101', 'FL101', 'A001', 'New York', 'London', NOW(), NOW(), NOW() + INTERVAL 8 HOUR, 0x00000000000000000000000000000001),
  ('F002', 'Flight 102', 'FL102', 'A002', 'Los Angeles', 'Tokyo', NOW(), NOW(), NOW() + INTERVAL 12 HOUR, 0x00000000000000000000000000000002),
  ('F003', 'Flight 103', 'FL103', 'A003', 'Chicago', 'Paris', NOW(), NOW(), NOW() + INTERVAL 9 HOUR, 0x00000000000000000000000000000003),
  ('F004', 'Flight 104', 'FL104', 'A004', 'Miami', 'Dubai', NOW(), NOW(), NOW() + INTERVAL 14 HOUR, 0x00000000000000000000000000000004),
  ('F005', 'Flight 105', 'FL105', 'A005', 'San Francisco', 'Sydney', NOW(), NOW(), NOW() + INTERVAL 16 HOUR, 0x00000000000000000000000000000005),
  ('F006', 'Flight 106', 'FL106', 'A006', 'Seattle', 'Toronto', NOW(), NOW(), NOW() + INTERVAL 6 HOUR, 0x00000000000000000000000000000006),
  ('F007', 'Flight 107', 'FL107', 'A007', 'Dallas', 'London', NOW(), NOW(), NOW() + INTERVAL 10 HOUR, 0x00000000000000000000000000000007),
  ('F008', 'Flight 108', 'FL108', 'A008', 'Boston', 'Berlin', NOW(), NOW(), NOW() + INTERVAL 11 HOUR, 0x00000000000000000000000000000008),
  ('F009', 'Flight 109', 'FL109', 'A009', 'Orlando', 'Madrid', NOW(), NOW(), NOW() + INTERVAL 7 HOUR, 0x00000000000000000000000000000009),
  ('F010', 'Flight 110', 'FL110', 'A010', 'Vancouver', 'Singapore', NOW(), NOW(), NOW() + INTERVAL 15 HOUR, 0x0000000000000000000000000000000A);

-- Insert data into Seat
INSERT INTO `Seat` (`id`, `compartmentID`, `available`) VALUES 
  ('S001', 'A', TRUE),
  ('S002', 'A', TRUE),
  ('S003', 'A', FALSE),
  ('S004', 'B', TRUE),
  ('S005', 'B', FALSE),
  ('S006', 'B', TRUE),
  ('S007', 'C', TRUE),
  ('S008', 'C', FALSE),
  ('S009', 'C', TRUE),
  ('S010', 'C', FALSE);

-- Insert data into Order
INSERT INTO `Order` (`id`, `customerID`, `staffID`, `status`, `time`) VALUES 
  ('O001', 0x00000000000000000000000000000001, 0x00000000000000000000000000000001, 'Pending', NOW()),
  ('O002', 0x00000000000000000000000000000002, 0x00000000000000000000000000000002, 'Confirmed', NOW()),
  ('O003', 0x00000000000000000000000000000003, 0x00000000000000000000000000000003, 'Cancelled', NOW()),
  ('O004', 0x00000000000000000000000000000004, 0x00000000000000000000000000000004, 'Completed', NOW()),
  ('O005', 0x00000000000000000000000000000005, 0x00000000000000000000000000000005, 'Pending', NOW()),
  ('O006', 0x00000000000000000000000000000006, 0x00000000000000000000000000000006, 'Confirmed', NOW()),
  ('O007', 0x00000000000000000000000000000007, 0x00000000000000000000000000000007, 'Cancelled', NOW()),
  ('O008', 0x00000000000000000000000000000008, 0x00000000000000000000000000000008, 'Completed', NOW()),
  ('O009', 0x00000000000000000000000000000009, 0x00000000000000000000000000000009, 'Pending', NOW()),
  ('O010', 0x0000000000000000000000000000000A, 0x0000000000000000000000000000000A, 'Confirmed', NOW());

-- Insert data into Ticket
INSERT INTO `Ticket` (`id`, `staffID`, `orderID`, `flightID`, `seatID`, `Type`, `Price`, `Status`) VALUES 
  ('T001', 0x00000000000000000000000000000001, 'O001', 'F001', 'S001', 'Economy', 100.00, 'Booked'),
  ('T002', 0x00000000000000000000000000000002, 'O002', 'F002', 'S002', 'Business', 250.00, 'Booked'),
  ('T003', 0x00000000000000000000000000000003, 'O003', 'F003', 'S003', 'First Class', 500.00, 'Cancelled'),
  ('T004', 0x00000000000000000000000000000004, 'O004', 'F004', 'S004', 'Economy', 150.00, 'Booked'),
  ('T005', 0x00000000000000000000000000000005, 'O005', 'F005', 'S005', 'Business', 300.00, 'Booked'),
  ('T006', 0x00000000000000000000000000000006, 'O006', 'F006', 'S006', 'Economy', 120.00, 'Booked'),
  ('T007', 0x00000000000000000000000000000007, 'O007', 'F007', 'S007', 'First Class', 400.00, 'Cancelled'),
  ('T008', 0x00000000000000000000000000000008, 'O008', 'F008', 'S008', 'Economy', 130.00, 'Booked'),
  ('T009', 0x00000000000000000000000000000009, 'O009', 'F009', 'S009', 'Business', 250.00, 'Booked'),
  ('T010', 0x0000000000000000000000000000000A, 'O010', 'F010', 'S010', 'Economy', 110.00, 'Booked');

-- Insert data into Luggage
INSERT INTO `Luggage` (`id`, `customerID`, `orderID`, `type`, `weight`) VALUES 
  ('L001', 0x00000000000000000000000000000001, 'O001', 'Checked', 23.50),
  ('L002', 0x00000000000000000000000000000002, 'O002', 'Carry-On', 10.00),
  ('L003', 0x00000000000000000000000000000003, 'O003', 'Checked', 15.00),
  ('L004', 0x00000000000000000000000000000004, 'O004', 'Carry-On', 8.00),
  ('L005', 0x00000000000000000000000000000005, 'O005', 'Checked', 25.00),
  ('L006', 0x00000000000000000000000000000006, 'O006', 'Carry-On', 5.00),
  ('L007', 0x00000000000000000000000000000007, 'O007', 'Checked', 30.00),
  ('L008', 0x00000000000000000000000000000008, 'O008', 'Carry-On', 12.00),
  ('L009', 0x00000000000000000000000000000009, 'O009', 'Checked', 20.00),
  ('L010', 0x0000000000000000000000000000000A, 'O010', 'Carry-On', 7.00);
 
