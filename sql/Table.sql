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
    `seatID` VARCHAR(10),
    `type` VARCHAR(30),
    `status` VARCHAR(20),
    
    PRIMARY KEY (`id`),
    FOREIGN KEY (`orderID`) REFERENCES `Order`(`id`),
    FOREIGN KEY (`seatID`) REFERENCES `Seat`(`id`),
    FOREIGN KEY (`type`) REFERENCES `TicketType`(`type`)
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

-- Keep the original Role data
INSERT INTO Role (name) VALUES 
('Administrator'),
('Customer'),
('Staff'),
('AirTrafficControl');

-- Account table (10 records)
INSERT INTO Account (username, password, roleID, status, citizenID, name, dob, phone, address, email) VALUES
('admin1', '123', 1, TRUE, '123456789012', 'Admin 1', '1990-05-15', '0987654321', '123 Main Street, Hanoi', 'admin1@example.com'),
('admin2', '123', 1, TRUE, '234567890123', 'Admin 2', '1985-08-21', '0976543210', '456 Oak Avenue, Ho Chi Minh City', 'admin2@example.com'),
('atc1', '123', 4, TRUE, '345678901234', 'Atc 1', '1988-11-30', '0912345678', '789 Pine Road, Da Nang', 'atc1@example.com'),
('atc2', '123', 4, TRUE, '456789012345', 'Atc 2', '1992-04-12', '0923456789', '101 Maple Lane, Hue', 'atc2@example.com'),
('staff1', '123', 3, TRUE, '567890123456', 'Staff 1', '1979-07-25', '0934567890', '202 Cedar Street, Nha Trang', 'staff1@example.com'),
('staff2', '123', 3, FALSE, '678901234567', 'Staff 2', '1995-02-18', '0945678901', '303 Birch Boulevard, Hai Phong', 'staff2@example.com'),
('user1', '123', 2, TRUE, '789012345678', 'A', '1983-09-09', '0956789012', '404 Elm Circle, Can Tho', 'user1@example.com'),
('user2', '123', 2, TRUE, '890123456789', 'B', '1991-12-05', '0967890123', '505 Willow Drive, Vung Tau', 'user2@example.com'),
('user3', '123', 2, TRUE, '901234567890', 'C', '1987-06-28', '0978901234', '606 Spruce Court, Phu Quoc', 'user3@example.com'),
('user4', '123', 2, TRUE, '012345678901', 'Nguyen Van A', '1994-03-17', '0989012345', '707 Redwood Place, Da Lat', 'abc@example.com'),
('author1', '123', 2, TRUE, '012345678901', 'Nguyen Van A', '1994-03-17', '0989012345', '707 Redwood Place, Da Lat', 'abc@example.com');

INSERT INTO `Location` (name) VALUES
('Hà Nội-Sân bay Nội Bài'),
('TP. Hồ Chí Minh-Sân bay Tân Sơn Nhất'),
('Đà Nẵng-Sân bay Quốc tế Đà Nẵng'),
('Nha Trang-Sân bay Cam Ranh'),
('Phú Quốc-Sân bay Quốc tế Phú Quốc'),
('Huế-Sân bay Phú Bài'),
('Hải Phòng-Sân bay Cát Bi'),
('Đà Lạt-Sân bay Liên Khương'),
('Cần Thơ-Sân bay Quốc tế Cần Thơ'),
('Quảng Ninh-Sân bay Vân Đồn'),
('Nghệ An-Sân bay Vinh'),
('Buôn Ma Thuột-Sân bay Buôn Ma Thuột'),
('Quy Nhơn-Sân bay Phù Cát'),
('Thanh Hóa-Sân bay Thọ Xuân'),
('Quảng Bình-Sân bay Đồng Hới'),
('Điện Biên-Sân bay Điện Biên Phủ'),
('Pleiku-Sân bay Pleiku'),
('Côn Đảo-Sân bay Côn Sơn'),
('Tuy Hòa-Sân bay Tuy Hòa'),
('Cà Mau-Sân bay Cà Mau');

INSERT INTO Nation (name) VALUES
('Vietnam'),
('United States'),
('Japan'),
('South Korea'),
('China'),
('Singapore'),
('Thailand'),
('Malaysia'),
('Australia'),
('United Kingdom');

-- AirplaneStatus table already has 5 records, adding 5 more to reach 10
INSERT INTO AirplaneStatus (name) VALUES 
('Active'), ('Maintenance'), ('Retired'), ('In Use'), ('Under Repair');

-- Airplane table (10 records)
INSERT INTO Airplane (id, name, statusID, maintainanceTime, usedTime) VALUES
('VN-A001', 'Sky Dragon', 1, '2024-06-15 08:00:00', '2023-12-01 00:00:00'),
('VN-A002', 'Ocean Star', 2, '2024-07-20 10:30:00', '2024-01-15 00:00:00'),
('VN-A003', 'Cloud Runner', 3, '2024-05-10 09:15:00', '2023-11-05 00:00:00'),
('VN-A004', 'Wind Rider', 4, '2024-08-05 11:45:00', '2024-02-20 00:00:00'),
('VN-A005', 'Sun Chaser', 5, '2024-06-30 13:20:00', '2023-12-25 00:00:00'),
('VN-A006', 'Moon Walker', 1, '2024-07-12 14:00:00', '2024-01-30 00:00:00'),
('VN-A007', 'Star Gazer', 2, '2024-05-25 15:30:00', '2023-11-20 00:00:00'),
('VN-A008', 'Air Master', 3, '2024-08-18 16:45:00', '2024-02-10 00:00:00'),
('VN-A009', 'Sky Voyager', 4, '2024-06-05 08:30:00', '2023-12-15 00:00:00'),
('VN-A010', 'Cloud Dancer', 5, '2024-07-28 09:45:00', '2024-01-05 00:00:00');

INSERT INTO `TicketType` (`type`, `description`, `price`, `checkedweightneed`, `handedweightneed` ) VALUES
('Economy', 'Standard seating and basic amenities. Additional services: Priority boarding, extra legroom, complimentary beverage service.', 200000.00, 23.0, 7.0),
('Business', 'Full business class experience. Additional services: Lie-flat seats, lounge access, premium meals and beverages.', 800000.00, 40.0, 10.0),
('First Class', 'Luxury air travel experience. Additional services: Private suites, personalized service, gourmet dining, exclusive lounge access.', 1500000.00, 50.0, 10.0);

-- Compartment table (10 records)
INSERT INTO Compartment (id, type, airplaneID, capacity) VALUES
('VN-A001-B', 'Business','VN-A001', 40),
('VN-A001-E', 'Economy','VN-A001', 40),
('VN-A001-F','First Class','VN-A001', 40),
('VN-A002-B', 'Business','VN-A002', 40),
('VN-A002-E', 'Economy','VN-A002', 40),
('VN-A002-F','First Class','VN-A002', 40),
('VN-A003-B', 'Business','VN-A003', 40),
('VN-A003-E', 'Economy','VN-A003', 40),
('VN-A003-F','First Class','VN-A003', 40),
('VN-A004-B', 'Business','VN-A004', 40),
('VN-A004-E', 'Economy','VN-A004', 40),
('VN-A004-F','First Class','VN-A004', 40),
('VN-A005-B', 'Business','VN-A005', 40),
('VN-A005-E', 'Economy','VN-A005', 40),
('VN-A005-F','First Class','VN-A005', 40),
('VN-A006-B', 'Business','VN-A006', 40),
('VN-A006-E', 'Economy','VN-A006', 40),
('VN-A006-F','First Class','VN-A006', 40),
('VN-A007-B', 'Business','VN-A007', 40),
('VN-A007-E', 'Economy','VN-A007', 40),
('VN-A007-F','First Class','VN-A007', 40),
('VN-A008-B', 'Business','VN-A008', 40),
('VN-A008-E', 'Economy','VN-A008', 40),
('VN-A008-F','First Class','VN-A008', 40),
('VN-A009-B', 'Business','VN-A009', 40),
('VN-A009-E', 'Economy','VN-A009', 40),
('VN-A009-F','First Class','VN-A009', 40),
('VN-A010-B', 'Business','VN-A010', 40),
('VN-A010-E', 'Economy','VN-A010', 40),
('VN-A010-F','First Class','VN-A010', 40);

-- Seat table (10 records)
INSERT INTO Seat (id, compartmentID, status, reason) VALUES
('VN-A001-1', 'VN-A001-B', 'Active', null),
('VN-A001-2', 'VN-A001-B', 'Active', null),
('VN-A001-3', 'VN-A001-B', 'Active', null),
('VN-A001-4', 'VN-A001-E', 'Active', null),
('VN-A001-5', 'VN-A001-E', 'In Maintenance', 'SUPAIGA'),
('VN-A001-6', 'VN-A001-E', 'Retired', 'SUPANIGA'),
('VN-A001-7', 'VN-A001-F', 'Active', null),
('VN-A001-8', 'VN-A001-F', 'Active', 'SUPAIGA'),
('VN-A001-9', 'VN-A001-F', 'Active', 'SUPANIGA'),
('VN-A002-1', 'VN-A002-B', 'Active', null),
('VN-A002-2', 'VN-A002-B', 'Active', 'SUPAIGA'),
('VN-A002-3', 'VN-A002-B', 'Active', 'SUPANIGA'),
('VN-A002-4', 'VN-A002-E', 'Active', null),
('VN-A002-5', 'VN-A002-E', 'Active', 'SUPAIGA'),
('VN-A002-6', 'VN-A002-E', 'Active', 'SUPANIGA'),
('VN-A002-7', 'VN-A002-F', 'Active', null),
('VN-A002-8', 'VN-A002-F', 'Active', 'SUPAIGA'),
('VN-A002-9', 'VN-A002-F', 'Active', 'SUPANIGA'),
('VN-A003-1', 'VN-A003-B', 'Active', null),
('VN-A003-2', 'VN-A003-B', 'Active', 'SUPAIGA'),
('VN-A003-3', 'VN-A003-B', 'Active', 'SUPANIGA'),
('VN-A003-4', 'VN-A003-E', 'Active', null),
('VN-A003-5', 'VN-A003-E', 'Active', 'SUPAIGA'),
('VN-A003-6', 'VN-A003-E', 'Active', 'SUPANIGA'),
('VN-A003-7', 'VN-A003-F', 'Active', null),
('VN-A003-8', 'VN-A003-F', 'Active', 'SUPAIGA'),
('VN-A003-9', 'VN-A003-F', 'Active', 'SUPANIGA');

-- Flight table (10 records)
INSERT INTO Flight (id, name, code, airplaneID, departure, destination, entryTime, startingTime, landingTime) VALUES 
    ('FL001', 'Morning Express', 'VN001', 'VN-A001', 1, 2, '2025-05-1 06:00:00', '2025-05-2 07:00:00', '2025-05-2 09:00:00'),
    ('FL002', 'Afternoon Shuttle', 'VN002', 'VN-A002', 2, 3, '2024-04-11 12:30:00', '2024-04-11 13:30:00', '2024-04-11 14:45:00'),
    ('FL003', 'Evening Direct', 'VN003', 'VN-A003', 3, 1, '2024-04-12 18:00:00', '2024-04-12 19:00:00', '2024-04-12 20:30:00'),
    ('FL004', 'International Route', 'VN004', 'VN-A004', 2, 11, '2024-04-13 09:15:00', '2024-04-13 10:15:00', '2024-04-13 12:45:00'),
    ('FL005', 'Night Flight', 'VN005', 'VN-A005', 1, 12, '2024-04-14 22:00:00', '2024-04-14 23:00:00', '2024-04-15 00:30:00'),
    ('FL006', 'Weekend Special', 'VN006', 'VN-A006', 3, 5, '2024-04-15 10:45:00', '2024-04-15 11:45:00', '2024-04-15 13:00:00'),
    ('FL007', 'Business Express', 'VN007', 'VN-A007', 1, 13, '2024-04-16 08:30:00', '2024-04-16 09:30:00', '2024-04-16 14:00:00'),
    ('FL008', 'Tourist Delight', 'VN008', 'VN-A008', 2, 14, '2024-04-17 14:15:00', '2024-04-17 15:15:00', '2024-04-17 19:45:00'),
    ('FL009', 'Express Connection', 'VN009', 'VN-A009', 3, 15, '2024-04-18 11:30:00', '2024-04-18 12:30:00', '2024-04-18 15:15:00'),
    ('FL010', 'Domestic Link', 'VN010', 'VN-A010', 4, 7, '2024-04-19 16:45:00', '2024-04-19 17:45:00', '2024-04-19 19:30:00');

INSERT INTO PassengerType (name, ageMin, ageMax, discountPercentage) VALUES
('Người lớn', 12, 100, 0),
('Trẻ em', 2, 11, 25),
('Em bé', 0, 1, 90);

INSERT INTO `Order` (id, customerID, staffID, status, time, finalPrice, finalNum) VALUES
('ORD001', (SELECT id FROM Account WHERE username = 'user1'), (SELECT id FROM Account WHERE username = 'staff1'), 'Confirmed', '2024-03-15 09:30:00', 0.0, 1),
('ORD002', (SELECT id FROM Account WHERE username = 'user2'), (SELECT id FROM Account WHERE username = 'staff1'), 'Processing', '2024-03-16 11:45:00', 0.0, 3),
('ORD003', (SELECT id FROM Account WHERE username = 'user3'), (SELECT id FROM Account WHERE username = 'staff1'), 'Confirmed', '2024-03-17 14:20:00', 0.0, 1),
('ORD004', (SELECT id FROM Account WHERE username = 'user4'), (SELECT id FROM Account WHERE username = 'staff1'), 'Cancelled', '2024-03-18 16:35:00', 0.0, 1);

INSERT INTO OrderPassenger (id, orderID, passengerTypeID, fullName, dob, nationID)
VALUES
('ORD001-1', 'ORD001', 1, 'John Doe', '1990-05-15', 1),
('ORD002-1', 'ORD002', 1, 'Mary Johnson', '1992-07-22', 2),
('ORD002-2', 'ORD002', 1, 'Jane Smith', '1985-08-21', 1),
('ORD002-3', 'ORD002', 2, 'Emily Smith', '2015-03-14', 1),
('ORD003-1', 'ORD003', 1, 'Robert Johnson', '1988-11-30', 3),
('ORD004-1', 'ORD004', 1, 'Sarah Williams', '1992-04-12', 4);

INSERT INTO Ticket (orderID, seatID, type, status) VALUES
('ORD001', 'VN-A001-1', 'Business', 'Confirmed'),
('ORD002', 'VN-A001-4', 'Economy', 'Pending'),
('ORD002', 'VN-A001-5', 'Economy', 'Confirmed'),
('ORD002', 'VN-A001-6', 'Economy', 'Cancelled'),
('ORD003', 'VN-A001-7', 'First Class', 'Checked-In'),
('ORD004', 'VN-A001-8', 'First Class', 'Confirmed');

INSERT INTO Luggage (id, customerID, orderID, type, checkedweight , handedweight) VALUES
('ORD001-1', (SELECT id FROM Account WHERE username = 'user1'), 'ORD001', 'Checked', 20.0, 5.0),
('ORD002-1', (SELECT id FROM Account WHERE username = 'user2'), 'ORD002', 'Cabin', 7.0, 3.0),
('ORD002-2', (SELECT id FROM Account WHERE username = 'user2'), 'ORD002', 'Checked', 18.2, 3.0),
('ORD002-3', (SELECT id FROM Account WHERE username = 'user2'), 'ORD002', 'Checked', 25.0, 3.0),
('ORD003-1', (SELECT id FROM Account WHERE username = 'user3'), 'ORD003', 'Cabin', 8.5, 3.0),
('ORD004-1', (SELECT id FROM Account WHERE username = 'user4'), 'ORD003', 'Checked', 20.7, 3.0);

-- BlogCategory table (10 records)
INSERT INTO BlogCategory (name) VALUES 
('Aviation Technology'),
('Travel Tips'),
('Flight Experience'),
('Airline News'),
('Destination Guides'),
('Safety & Security'),
('Aircraft Reviews'),
('Customer Service'),
('Pilot Stories'),
('Airport Features');

-- BlogPost table (10 records)
INSERT INTO BlogPost (title, content, image, authorID, categoryID, published) VALUES
('The Future of Aviation Technology', 'Exploring the latest innovations in aviation technology that are reshaping the industry...', 'deal1.jpg', (SELECT id FROM Account WHERE username = 'staff1'), 1, TRUE),
('Top 10 Travel Tips for First-Time Flyers', 'Essential advice for those taking their first flight, covering everything from booking to landing...', 'deal2.jpg', (SELECT id FROM Account WHERE username = 'staff1'), 2, TRUE),
('Business Class Experience: Worth the Upgrade?', 'A detailed review of the business class experience and whether the premium price justifies the benefits...', 'deadl3.jpg', (SELECT id FROM Account WHERE username = 'staff1'), 3, TRUE),
('New Routes Announced for Summer 2024', 'Breaking news about exciting new flight routes being launched for the upcoming summer season...', 'deal4.jpg', (SELECT id FROM Account WHERE username = 'staff1'), 4, TRUE);

-- Comment table (10 records)
INSERT INTO Comment (postID, accountID, content) VALUES
((SELECT id FROM BlogPost WHERE title = 'The Future of Aviation Technology'), (SELECT id FROM Account WHERE username = 'staff1'), 'This article opened my eyes to the amazing innovations coming to aviation!'),
((SELECT id FROM BlogPost WHERE title = 'Top 10 Travel Tips for First-Time Flyers'), (SELECT id FROM Account WHERE username = 'staff1'), 'Wish I had read this before my first flight. Great advice!'),
((SELECT id FROM BlogPost WHERE title = 'Business Class Experience: Worth the Upgrade?'), (SELECT id FROM Account WHERE username = 'staff1'), 'Just upgraded on my last flight based on this review and completely agree with your assessment.'),
((SELECT id FROM BlogPost WHERE title = 'New Routes Announced for Summer 2024'), (SELECT id FROM Account WHERE username = 'staff1'), 'Excited about the new route to Phu Quoc! Already planning my trip.');

-- Blog table (10 records)
INSERT INTO Blog (postID, title, description, image, categoryID, authorID) VALUES
((SELECT id FROM BlogPost WHERE title = 'The Future of Aviation Technology'), 'Aviation Tech Trends', 'Discover the cutting-edge technologies shaping the future of air travel', 'tech_thumb.jpg', 1, (SELECT id FROM Account WHERE username = 'staff1')),
((SELECT id FROM BlogPost WHERE title = 'Top 10 Travel Tips for First-Time Flyers'), 'First-Time Flyer Guide', 'Essential advice for anyone taking their first flight', 'firstflight_thumb.jpg', 2, (SELECT id FROM Account WHERE username = 'staff1')),
((SELECT id FROM BlogPost WHERE title = 'Business Class Experience: Worth the Upgrade?'), 'Business Class Analysis', 'Is the premium price worth the luxury experience?', 'business_thumb.jpg', 3, (SELECT id FROM Account WHERE username = 'staff1')),
((SELECT id FROM BlogPost WHERE title = 'New Routes Announced for Summer 2024'), 'Summer 2024 Routes', 'Exciting new destinations for your summer travel plans', 'routes_thumb.jpg', 4, (SELECT id FROM Account WHERE username = 'staff1'));

-- ChatMessage table (10 records)
INSERT INTO ChatMessage (senderAccountID, receiverAccountID, message, timestamp, isRead) VALUES
((SELECT id FROM Account WHERE username = 'staff1'), (SELECT id FROM Account WHERE username = 'user1'), 'Hi Jane, I have a question about my upcoming flight.', '2024-03-15 10:15:00', TRUE),
((SELECT id FROM Account WHERE username = 'staff1'), (SELECT id FROM Account WHERE username = 'user2'), 'Sure John, how can I help you?', '2024-03-15 10:18:00', TRUE),
((SELECT id FROM Account WHERE username = 'staff1'), (SELECT id FROM Account WHERE username = 'user3'), 'Sarah, could you check if there are any window seats available on flight VN303?', '2024-03-16 14:30:00', TRUE),
((SELECT id FROM Account WHERE username = 'staff1'), (SELECT id FROM Account WHERE username = 'user4'), 'I just checked and there are 3 window seats available. Would you like me to book one for you?', '2024-03-16 14:45:00', TRUE);