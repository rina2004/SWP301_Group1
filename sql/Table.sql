CREATE DATABASE `swp301`;
USE `swp301`;

-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

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
  `name` varchar(50),
  `createdDate` DATETIME,
  
  PRIMARY KEY (`id`)
);

CREATE TABLE `Role` (
  `id` INT AUTO_INCREMENT,
  `name` VARCHAR(50) unique not null,
	
  PRIMARY KEY (`id`)
);

CREATE TABLE `Account` (
  `id` VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
  `username` VARCHAR(50) UNIQUE NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `status` bool DEFAULT(TRUE),
  `citizenID` VARCHAR(12),
  `name` VARCHAR(50),
  `dob` DATE,
  `phone` VARCHAR(10),
  `address` VARCHAR(255),
  `email` VARCHAR(255)
);

CREATE TABLE `AccountUserRole` (
    `accountID` VARCHAR(36) NOT NULL,
    `entityID` INT NOT NULL,
    `roleID` INT NOT NULL,
    PRIMARY KEY (`accountID`, `entityID`, `roleID`),

    FOREIGN KEY (`accountID`) REFERENCES Account(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`roleID`) REFERENCES Role(`id`) ON DELETE CASCADE
);

-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

CREATE TABLE `Type` (
  `id` varchar(10),
  `Name` varchar(50),
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

CREATE table `Airplane_Status` (
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
  foreign key (`statusID`) references `Airplane_Status`(`id`),
  foreign key (`typeID`) references `Type`(`id`),
  foreign key (`atcID`) references `AirTrafficControl`(`id`)
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

-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

CREATE TABLE `BlogCategory` (
	`id` int auto_increment,
    `name` varchar(255) unique,
    
    primary key (`id`)
);

CREATE TABLE `BlogPost` (
    `id` VARCHAR(41) PRIMARY KEY DEFAULT (CONCAT('POST-', UUID())), 
    `title` VARCHAR(255) NOT NULL,
    `content` TEXT NOT NULL,
    `authorID` VARCHAR(41) NOT NULL,
    `categoryID` INT NOT NULL,
    `published` BOOLEAN DEFAULT FALSE,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (`authorID`) REFERENCES `Account`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`categoryID`) REFERENCES `BlogCategory`(`id`) ON DELETE CASCADE
);

CREATE TABLE `Comment` (
    `id` VARCHAR(41) PRIMARY KEY DEFAULT (CONCAT('CMT-', UUID())),
    `postID` VARCHAR(41) NOT NULL,
    `accountID` VARCHAR(41) NOT NULL,
    `content` TEXT NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (`postID`) REFERENCES `BlogPost`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`accountID`) REFERENCES `Account`(`id`) ON DELETE CASCADE
);

CREATE TABLE `PostLike` (
    `id` VARCHAR(41) PRIMARY KEY DEFAULT (CONCAT('LIKE-', UUID())),
    `postID` VARCHAR(41) NOT NULL,
    `accountID` VARCHAR(41) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (`postID`) REFERENCES `BlogPost`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`accountID`) REFERENCES `Account`(`id`) ON DELETE CASCADE
);

CREATE TABLE `Tags` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE `PostTags` (
    `postID` VARCHAR(36) NOT NULL,
    `tagID` INT NOT NULL,
    PRIMARY KEY (`post_id`, `tag_id`),

    FOREIGN KEY (`postID`) REFERENCES `BlogPosts`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`tagID`) REFERENCES `Tags`(`id`) ON DELETE CASCADE
);


CREATE TABLE `Blog` (
    `id` VARCHAR(41) PRIMARY KEY DEFAULT (CONCAT('BLOG-', UUID())),
    `postID` VARCHAR(41) NOT NULL UNIQUE,
    `title` VARCHAR(255) NOT NULL,
    `short_description` TEXT NOT NULL,
    `thumbnail` VARCHAR(255),
    `authorID` VARCHAR(41) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (`postID`) REFERENCES `BlogPost`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`authorID`) REFERENCES `Account`(`id`) ON DELETE CASCADE
);