CREATE DATABASE `swp301`;
USE `swp301`;

DROP DATABASE `swp301`;

CREATE TABLE `Customer` (
  `id` varchar(10),
  
  PRIMARY KEY (`id`)
);

CREATE TABLE `Administrator` (
  `id` varchar(10),
  `roleID` INT,
  
  PRIMARY KEY (`id`)
);

CREATE TABLE `Staff` (
  `id` varchar(10),
  `createdDate` DATETIME,
  
  PRIMARY KEY (`id`)
);

CREATE TABLE `AirTrafficControl` (
  `id` varchar(10),
  `createdDate` DATETIME,
  
  PRIMARY KEY (`id`)
);

CREATE TABLE `Role` (
  `id` INT AUTO_INCREMENT,
  `name` VARCHAR(50),
  `adminID` varchar(10),
	
  PRIMARY KEY (`id`),
  foreign key (`adminID`) references `Administrator`(`id`)
);

CREATE TABLE `Account` (
  `username` VARCHAR(50),
  `password` VARCHAR(50) NOT NULL,
  `status` bool DEFAULT(TRUE),
  `roleID` INT,
  `id` varchar(10) UNIQUE,
  `citizenID` VARCHAR(12),
  `name` VARCHAR(50),
  `dob` DATE,
  `phone` VARCHAR(10),
  `address` VARCHAR(255),
  `email` VARCHAR(255),
  `adminID` varchar(10),
  
  PRIMARY KEY (`username`),
  FOREIGN KEY (`roleID`) REFERENCES `Role`(`id`),
  FOREIGN KEY (`id`) references `Customer`(`id`),
  FOREIGN KEY (`adminID`) references `Administrator`(`id`)
);

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
  `atcID` varchar(10),
  
  PRIMARY KEY (`id`),
  foreign key (`statusID`) references `Status_Airplane`(`id`),
  foreign key (`atcID`) references `AirTrafficControl`(`id`)
);

CREATE TABLE `Type` (
  `id` varchar(10),
  `Name` varchar(50),
  `compartmentID` char,
  `manufacture` varchar(50),
  `length` decimal(10,2),
  `weight` decimal(10,2),
  `height` decimal(10,2),
  `atcID` varchar(10),
  
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
  `atcID` varchar(10),
  
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
  `customerID` varchar(10),
  `staffID` varchar(10),
  `status` varchar(50),
  `time` datetime,
  
  PRIMARY KEY (`id`),
  foreign key (`customerID`) references `Customer`(`id`),
  foreign key (`staffID`) references `Staff`(`id`)
);

CREATE TABLE `Ticket` (
  `id` varchar(10),
  `staffID` varchar(10),
  `orderID` varchar(10),
  `flightID` varchar(10),
  `seatID` varchar(10),
  `type` varchar(30),
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
  `customerID` varchar(10),
  `orderID` varchar(10),
  `type` varchar(30),
  `weight` decimal(10,2),
  
  PRIMARY KEY (`id`),
  foreign key (`customerID`) references `Customer`(`id`),
  foreign key (`orderID`) references `Order`(`id`)
);

CREATE TABLE `Blog_Category` (
	`id` int auto_increment,
    `name` varchar(255),
    
    primary key (`id`)
);

CREATE TABLE `Blog` (
	`id` varchar(10),
    `title` varchar(255),
    `categoryID` int,
    `image` varchar(100),
    `description` text,
    
    primary key (`id`),
    foreign key (`categoryID`) references `Blog_Category`(`id`)
);

INSERT INTO `Administrator` (`id`, `roleID`) VALUES 
('ADMIN001', 1);

INSERT INTO `Staff` (`id`, `createdDate`) VALUES 
('STAFF001', '2023-01-01 10:00:00'),
('STAFF002', '2023-02-15 14:30:00');

INSERT INTO `AirTrafficControl` (`id`, `createdDate`) VALUES 
('ATC001', '2022-05-20 09:00:00');

INSERT INTO `Customer` (`id`) VALUES 
('CUST001'),
('CUST002'),
('CUST003'),
('CUST004');

INSERT INTO `Role` (`name`, `adminID`) VALUES 
('Administrator', 'ADMIN1'),
('Staff', Null),
('Customer', NULL),
('AirTrafficControl', NULL);

SELECT * FROM `Role`;

SELECT * FROM `Administrator`;

SELECT * FROM `Staff`;

SELECT * FROM `Customer`;

SELECT * FROM `AirTrafficControl`;

SELECT * FROM `Account`;

INSERT INTO `Account` 
(`username`, `password`, `status`, `roleID`, `id`, `citizenID`, `name`, `dob`, `phone`, `address`, `email`, `adminID`) 
VALUES 
('customer_user1', 'cust123', TRUE, 3, 'C1', '123456789012', 'Customer One', '2000-04-05', '0956789012', '202 Customer Ave', 'cust1@example.com', NULL),
('customer_user2', 'cust456', FALSE, 3, 'C2', '987654321098', 'Customer Two', '1995-08-25', '0967890123', '303 Customer Blvd', 'cust2@example.com', NULL),
('customer_user3', 'cust456', FALSE, 3, 'C3', '987654321095', 'Customer Three', '1995-08-25', '0967890123', '304 Customer Blvd', 'cust3@example.com', NULL),
('customer_user4', 'cust456', FALSE, 3, 'C4', '987654321096', 'Customer Four', '1995-08-25', '0967890123', '305 Customer Blvd', 'cust3@example.com', NULL);

SELECT * FROM Account WHERE RoleID <> 1;

DROP TABLE `Account`;
UPDATE Account SET password = 123, roleID = 3, status = TRUE WHERE id = 'C1';