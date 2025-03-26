CREATE DATABASE `swp301`;
USE `swp301`;
 
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

CREATE TABLE `Role` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(50) UNIQUE NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `Account` (
    `id` VARCHAR(36) DEFAULT (UUID()),
    `username` VARCHAR(50) UNIQUE NOT NULL,
    `password` VARCHAR(50) NOT NULL,
    `roleID` INT,
    `status` BOOL DEFAULT(TRUE),
    `citizenID` VARCHAR(12),
    `name` VARCHAR(50),
    `dob` DATE,
    `phone` VARCHAR(10),
    `address` VARCHAR(255),
    `email` VARCHAR(255),
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (`roleID`) REFERENCES `Role`(`id`)
);

-- Location and Geography Related Tables
CREATE TABLE `Location` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    
    PRIMARY KEY (`id`)
);

CREATE TABLE `Nation` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    
    PRIMARY KEY (`id`)
);

-- Flight and Airplane Related Tables
CREATE TABLE `AirplaneStatus` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(50),
    
    PRIMARY KEY (`id`)
);

CREATE TABLE `Airplane` (
    `id` VARCHAR(10),
    `name` VARCHAR(50),
    `statusID` INT,
    `maintainanceTime` DATETIME,
    `usedTime` DATETIME,
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (`statusID`) REFERENCES `AirplaneStatus`(`id`)
);

CREATE TABLE `TicketType` (
    `type` VARCHAR(30) PRIMARY KEY,
    `description` TEXT,
    `price` DECIMAL(10,2),
    `checkedweightneed` decimal(10,2),
    `handedweightneed` decimal(10,2)
);

CREATE TABLE `Compartment` (
    `id` VARCHAR(20),
    `type` VARCHAR(30),
    `airplaneID` VARCHAR(10),
    `capacity` INT,
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (`type`) REFERENCES `TicketType`(`type`),
    FOREIGN KEY (`airplaneID`) REFERENCES `Airplane`(`id`) ON DELETE CASCADE
); 

CREATE TABLE `Seat` (
    `id` VARCHAR(10),
    `compartmentID` VARCHAR(20),
    `status` VARCHAR(50),
    `reason` VARCHAR(250),
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (`compartmentID`) REFERENCES `Compartment`(`id`)
);

CREATE TABLE `Flight` (
    `id` VARCHAR(10),
    `name` VARCHAR(50),
    `code` VARCHAR(50),
    `airplaneID` VARCHAR(10),
    `departure` INT NOT NULL,
    `destination` INT NOT NULL,
    `entryTime` DATETIME,
    `startingTime` DATETIME,
    `landingTime` DATETIME,
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (`airplaneID`) REFERENCES `Airplane`(`id`),
    FOREIGN KEY (`departure`) REFERENCES `Location`(`id`),
    FOREIGN KEY (`destination`) REFERENCES `Location`(`id`)
);

-- Passenger and Ticket Related Tables
CREATE TABLE `PassengerType` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `ageMin` INT,
    `ageMax` INT, 
    `discountPercentage` DECIMAL(5,2) DEFAULT 0, 
    
    PRIMARY KEY (`id`)
);

-- Order and Passenger Details Tables
CREATE TABLE `Order` (
    `id` VARCHAR(10),
    `customerID` VARCHAR(36),
    `staffID` VARCHAR(36),
    `status` VARCHAR(50),
    `time` DATETIME,
    `finalPrice` DECIMAL(10,2),
    `finalNum` INT,
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (`customerID`) REFERENCES `Account`(`id`),
    FOREIGN KEY (`staffID`) REFERENCES `Account`(`id`)
);

CREATE TABLE `OrderPassenger` (
    `id` VARCHAR(36) DEFAULT (UUID()),
    `orderID` VARCHAR(10),
    `passengerTypeID` INT,
    `fullName` VARCHAR(100) NOT NULL,
    `dob` DATE,
    `nationID` INT,
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (`orderID`) REFERENCES `Order`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`passengerTypeID`) REFERENCES `PassengerType`(`id`),
    FOREIGN KEY (`nationID`) REFERENCES `Nation`(`id`)
);

CREATE TABLE `Ticket` (
    `id` VARCHAR(50) DEFAULT (UUID()),
    `orderID` VARCHAR(10),
    `flightID` VARCHAR(10),
    `seatID` VARCHAR(10),
    `status` VARCHAR(20),
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (`orderID`) REFERENCES `Order`(`id`),
    FOREIGN KEY (`flightID`) REFERENCES `Flight`(`id`),
    FOREIGN KEY (`seatID`) REFERENCES `Seat`(`id`)
);

CREATE TABLE `Luggage` (
    `id` VARCHAR(10),
    `customerID` VARCHAR(36),
    `orderID` VARCHAR(10),
    `type` VARCHAR(30),
    `checkedweight` DECIMAL(10,2),
    `handedweight` DECIMAL(10,2),
    `existed` BOOL DEFAULT TRUE,
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (`customerID`) REFERENCES `Account`(`id`),
    FOREIGN KEY (`orderID`) REFERENCES `Order`(`id`)
);

-- Blog and Communication Related Tables
CREATE TABLE `BlogCategory` (
    `id` INT AUTO_INCREMENT,
    `name` VARCHAR(255) UNIQUE,
    
    PRIMARY KEY (`id`)
);

CREATE TABLE `BlogPost` (
    `id` VARCHAR(41) PRIMARY KEY DEFAULT (CONCAT('POST-', UUID())), 
    `title` VARCHAR(255) NOT NULL,
    `content` TEXT NOT NULL,
    `image` TEXT NOT NULL,
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

CREATE TABLE `Blog` (
    `id` VARCHAR(41) PRIMARY KEY DEFAULT (CONCAT('BLOG-', UUID())),
    `postID` VARCHAR(41) NOT NULL UNIQUE,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    `image` VARCHAR(255),
    `categoryID` int,
    `authorID` VARCHAR(36) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (`postID`) REFERENCES `BlogPost`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`categoryID`) REFERENCES `BlogCategory`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`authorID`) REFERENCES `Account`(`id`) ON DELETE CASCADE
);

-- Chat and Messaging Related Tables
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

