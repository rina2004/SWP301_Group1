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

CREATE TABLE `Feature` (
	`id` int auto_increment,
    `name` varchar(255),
    `url` varchar(100),
    
    primary key (`id`)
);

CREATE TABLE `RoleFeature` (
	`roleID` int,
    `featureID` int,
    
    primary key (`roleID`, `featureID`),
    foreign key (`roleID`) references `Role`(`id`),
    foreign key (`featureID`) references `Feature`(`id`)
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

UPDATE Account SET password='123', name='ABC', citizenID='12345678910', dob='1988-11-20', phone='0934567891', address='Hải Phòng', email='A@gmail.com' WHERE id='e01e0a6b-fc00-11ef-96e1-e4f520bd5573';
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------

CREATE TABLE `Type` (
	`id` varchar(10),
	`name` varchar(50),
	`manufacture` varchar(50),
	`length` decimal(10,2),
	`weight` decimal(10,2),
	`height` decimal(10,2),
	  
	PRIMARY KEY (`id`)
);

CREATE TABLE `Compartment` (
	`id` char,
	`name` varchar(50),
	`typeID` varchar(10),
	`capacity` int,
	  
	PRIMARY KEY (`id`),
	foreign key (`typeID`) references `Type`(`id`) ON DELETE CASCADE
);

CREATE table `AirplaneStatus` (
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
	  
	PRIMARY KEY (`id`),
	foreign key (`statusID`) references `AirplaneStatus`(`id`),
	foreign key (`typeID`) references `Type`(`id`) ON DELETE CASCADE
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
	`compartmentID` char,
	`available` bool,
	  
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
	`Price` decimal(10,2),
	`Status` varchar(20),
	  
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
	`postID` VARCHAR(36) NOT NULL,
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