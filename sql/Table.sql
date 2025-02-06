CREATE DATABASE `swp301`;
USE `swp301`;

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
  `Name` varchar(50),
  `Code` varchar(50),
  `airplaneID` varchar(10),
  `Departure` varchar(255),
  `Destination` varchar(255),
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
);