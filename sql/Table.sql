CREATE DATABASE `swp301`;
USE `swp301`;
 
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

CREATE TABLE `Role` (
	`id` INT AUTO_INCREMENT,
	`name` VARCHAR(50) unique not null,
		
	PRIMARY KEY (`id`)
);

CREATE TABLE `Account` (
	`id` VARCHAR(36) DEFAULT (UUID()),
	`username` VARCHAR(50) UNIQUE NOT NULL,
	`password` VARCHAR(50) NOT NULL,
    `roleID` int,
	`status` bool DEFAULT(TRUE),
	`citizenID` VARCHAR(12),
	`name` VARCHAR(50),
	`dob` DATE,
	`phone` VARCHAR(10),
	`address` VARCHAR(255),
	`email` VARCHAR(255),
    
    primary key (`id`),
    foreign key (`roleID`) references `Role`(`id`)
);
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

CREATE table `AirplaneStatus` (
	`id` INT auto_increment,
	`name` varchar(50),
		
	primary key (`id`)
);
	 
CREATE TABLE `Airplane` (
	`id` varchar(10),
	`name` varchar(50),
	`statusID` int,
	`maintainanceTime` datetime,
	`usedTime` datetime,
	  
	PRIMARY KEY (`id`),
	foreign key (`statusID`) references `AirplaneStatus`(`id`)
);

CREATE TABLE `Compartment` (
	`id` varchar(20),
	`name` varchar(50),
	`airplaneID` varchar(10),
	`capacity` int,
	  
	PRIMARY KEY (`id`),
	foreign key (`airplaneID`) references `Airplane`(`id`) ON DELETE CASCADE
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
	  
	PRIMARY KEY (`id`),
	foreign key (`airplaneID`) references `Airplane`(`id`)
);

CREATE TABLE `Seat` (
	`id` varchar(10),
	`compartmentID` varchar(20),
	`status` bool,
    `reason` varchar(250),
	  
	PRIMARY KEY (`id`),
	foreign key (`compartmentID`) references `Compartment`(`id`)
);

CREATE TABLE `Order` (
	`id` varchar(10),
	`customerID` varchar(36),
	`staffID` varchar(36),
	`status` varchar(50),
	`time` datetime,
	  
	PRIMARY KEY (`id`),
	foreign key (`customerID`) references `Account`(`id`),
	foreign key (`staffID`) references `Account`(`id`)
);

CREATE TABLE `Ticket` (
	`id` varchar(10),
	`orderID` varchar(10),
	`flightID` varchar(10),
	`seatID` varchar(10),
	`type` varchar(30),
	`price` decimal(10,2),
	`status` varchar(20),
	  
	PRIMARY KEY (`id`),
	foreign key (`orderID`) references `Order`(`id`),
	foreign key (`flightID`) references `Flight`(`id`),
	foreign key (`seatID`) references `Seat`(`id`)
);

CREATE TABLE `Luggage` (
	`id` varchar(10),
    `customerID` varchar(36),
	`orderID` varchar(10),
	`type` varchar(30),
	`weight` decimal(10,2),
	  
	PRIMARY KEY (`id`),
    foreign key (`customerID`) references `Account`(`id`),
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
	`authorID` VARCHAR(36) NOT NULL,
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
	`accountID` VARCHAR(36) NOT NULL,
	`content` TEXT NOT NULL,
	`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

	FOREIGN KEY (`postID`) REFERENCES `BlogPost`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`accountID`) REFERENCES `Account`(`id`) ON DELETE CASCADE
);

CREATE TABLE `PostLike` (
	`id` VARCHAR(41) PRIMARY KEY DEFAULT (CONCAT('LIKE-', UUID())),
	`postID` VARCHAR(41) NOT NULL,
	`accountID` VARCHAR(36) NOT NULL,
	`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	FOREIGN KEY (`postID`) REFERENCES `BlogPost`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`accountID`) REFERENCES `Account`(`id`) ON DELETE CASCADE
);

CREATE TABLE `Tag` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE `PostTag` (
	`postID` VARCHAR(41) NOT NULL,
	`tagID` INT NOT NULL,
	PRIMARY KEY (`postID`, `tagID`),

	FOREIGN KEY (`postID`) REFERENCES `BlogPost`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`tagID`) REFERENCES `Tag`(`id`) ON DELETE CASCADE
);

CREATE TABLE `Blog` (
	`id` VARCHAR(41) PRIMARY KEY DEFAULT (CONCAT('BLOG-', UUID())),
	`postID` VARCHAR(41) NOT NULL UNIQUE,
	`title` VARCHAR(255) NOT NULL,
	`short_description` TEXT NOT NULL,
	`thumbnail` VARCHAR(255),
	`authorID` VARCHAR(36) NOT NULL,
	`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

	FOREIGN KEY (`postID`) REFERENCES `BlogPost`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`authorID`) REFERENCES `Account`(`id`) ON DELETE CASCADE
);

-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

CREATE TABLE `ChatMessage` (
	`id` VARCHAR(36) PRIMARY KEY DEFAULT (UUID()),
	`senderAccountID` VARCHAR(36) NOT NULL,
	`receiverAccountID` VARCHAR(36) NOT NULL,
	`message` TEXT NOT NULL,
	`timestamp` DATETIME DEFAULT CURRENT_TIMESTAMP,
	`isRead` BOOLEAN DEFAULT FALSE,
	  
	FOREIGN KEY (`senderAccountID`) REFERENCES `Account`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`receiverAccountID`) REFERENCES `Account`(`id`) ON DELETE CASCADE
);