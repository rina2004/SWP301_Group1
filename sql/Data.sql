USE `swp301`;

-- Keep the original Role data
INSERT INTO Role (name) VALUES 
('Administrator'),
('Customer'),
('Staff'),
('AirTrafficControl');

-- Account table (10 records)
INSERT INTO Account (username, password, roleID, status, citizenID, name, dob, phone, address, email) VALUES
('johndoe', 'password123', 1, TRUE, '123456789012', 'John Doe', '1990-05-15', '0987654321', '123 Main Street, Hanoi', 'john.doe@example.com'),
('janesmith', 'securepass', 2, TRUE, '234567890123', 'Jane Smith', '1985-08-21', '0976543210', '456 Oak Avenue, Ho Chi Minh City', 'jane.smith@example.com'),
('robertjohnson', 'pass1234', 3, TRUE, '345678901234', 'Robert Johnson', '1988-11-30', '0912345678', '789 Pine Road, Da Nang', 'robert.johnson@example.com'),
('sarahwilliams', 'sarahpass', 4, TRUE, '456789012345', 'Sarah Williams', '1992-04-12', '0923456789', '101 Maple Lane, Hue', 'sarah.williams@example.com'),
('michaelbrown', 'brownie22', 1, TRUE, '567890123456', 'Michael Brown', '1979-07-25', '0934567890', '202 Cedar Street, Nha Trang', 'michael.brown@example.com'),
('emilydavis', 'emily1995', 2, FALSE, '678901234567', 'Emily Davis', '1995-02-18', '0945678901', '303 Birch Boulevard, Hai Phong', 'emily.davis@example.com'),
('davidmiller', 'miller2023', 3, TRUE, '789012345678', 'David Miller', '1983-09-09', '0956789012', '404 Elm Circle, Can Tho', 'david.miller@example.com'),
('oliviawilson', 'olivia123', 4, TRUE, '890123456789', 'Olivia Wilson', '1991-12-05', '0967890123', '505 Willow Drive, Vung Tau', 'olivia.wilson@example.com'),
('williamtaylor', 'taylor888', 1, TRUE, '901234567890', 'William Taylor', '1987-06-28', '0978901234', '606 Spruce Court, Phu Quoc', 'william.taylor@example.com'),
('sophiaanderson', 'sophia999', 2, TRUE, '012345678901', 'Sophia Anderson', '1994-03-17', '0989012345', '707 Redwood Place, Da Lat', 'sophia.anderson@example.com');

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
('Grounded'), ('Out of Service'), ('Scheduled'), ('Reserved'), ('Standby');

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

-- Compartment table (10 records)
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

-- Seat table (10 records)
INSERT INTO Seat (id, compartmentID, status, reason) VALUES
('S001A', 'VN-A001-B1', TRUE, null),
('S002B', 'VN-A001-B2', TRUE, null),
('S003C', 'VN-A001-B3', TRUE, null),
('S004D', 'VN-A001-E1', FALSE, 'In Maintenance'),
('S005E', 'VN-A001-E2', TRUE, null),
('S006F', 'VN-A001-E3', TRUE, null),
('S007G', 'VN-A001-F1', FALSE, 'In Maintenance'),
('S008H', 'VN-A001-F2', TRUE, null),
('S009I', 'VN-A001-F3', TRUE, null),
('S010J', 'VN-A002-B1', FALSE, 'In Reparing');

-- Flight table (10 records)
INSERT INTO Flight (id, name, code, airplaneID, departure, destination, entryTime, startingTime, landingTime) VALUES 
    ('FL001', 'Morning Express', 'VN001', 'VN-A001', 1, 2, '2024-04-10 06:00:00', '2024-04-10 07:00:00', '2024-04-10 09:00:00'),
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

INSERT INTO `TicketType` (`type`, `description`, `checkedLuggageWeight`, `handLuggageWeight`, `luggageQuantity`, `additionalServices`) VALUES
('Economy Class', 'Standard seating and basic amenities', 23.00, 7.00, 1, 'Complimentary beverage service'),
('Economy Plus', 'Economy with additional legroom', 23.00, 7.00, 1, 'Priority boarding, extra legroom, complimentary beverage service'),
('Premium Economy', 'Enhanced economy experience', 32.00, 7.00, 2, 'Wider seats, enhanced meal service, amenity kit'),
('Business Class', 'Full business class experience', 40.00, 10.00, 2, 'Lie-flat seats, lounge access, premium meals and beverages'),
('First Class', 'Luxury air travel experience', 50.00, 10.00, 3, 'Private suites, personalized service, gourmet dining, exclusive lounge access');

INSERT INTO `Order` (id, customerID, staffID, status, time, finalPrice, finalNum, ordername, phone, email) VALUES
('ORD001', (SELECT id FROM Account WHERE username = 'johndoe'), (SELECT id FROM Account WHERE username = 'sarahwilliams'), 'Confirmed', '2024-03-15 09:30:00', 2500000.00, 2, 'John Doe Family Trip', '0987654321', 'john.doe@example.com'),
('ORD002', (SELECT id FROM Account WHERE username = 'janesmith'), (SELECT id FROM Account WHERE username = 'michaelbrown'), 'Processing', '2024-03-16 11:45:00', 3600000.00, 2, 'Smith Family Vacation', '0976543210', 'jane.smith@example.com'),
('ORD003', (SELECT id FROM Account WHERE username = 'robertjohnson'), (SELECT id FROM Account WHERE username = 'emilydavis'), 'Confirmed', '2024-03-17 14:20:00', 1200000.00, 1, 'Robert Johnson Business Trip', '0912345678', 'robert.johnson@example.com'),
('ORD004', (SELECT id FROM Account WHERE username = 'sarahwilliams'), (SELECT id FROM Account WHERE username = 'davidmiller'), 'Cancelled', '2024-03-18 16:35:00', 2000000.00, 1, 'Sarah Williams Vacation', '0923456789', 'sarah.williams@example.com'),
('ORD005', (SELECT id FROM Account WHERE username = 'michaelbrown'), (SELECT id FROM Account WHERE username = 'oliviawilson'), 'Completed', '2024-03-19 10:10:00', 1650000.00, 2, 'Brown Family Trip', '0934567890', 'michael.brown@example.com'),
('ORD006', (SELECT id FROM Account WHERE username = 'emilydavis'), (SELECT id FROM Account WHERE username = 'williamtaylor'), 'Confirmed', '2024-03-20 13:25:00', 2800000.00, 1, 'Emily Davis Vacation', '0945678901', 'emily.davis@example.com'),
('ORD007', (SELECT id FROM Account WHERE username = 'davidmiller'), (SELECT id FROM Account WHERE username = 'sophiaanderson'), 'Processing', '2024-03-21 15:40:00', 2200000.00, 1, 'David Miller Business Trip', '0956789012', 'david.miller@example.com'),
('ORD008', (SELECT id FROM Account WHERE username = 'oliviawilson'), (SELECT id FROM Account WHERE username = 'johndoe'), 'Confirmed', '2024-03-22 08:55:00', 1600000.00, 1, 'Olivia Wilson Travel', '0967890123', 'olivia.wilson@example.com'),
('ORD009', (SELECT id FROM Account WHERE username = 'williamtaylor'), (SELECT id FROM Account WHERE username = 'janesmith'), 'Completed', '2024-03-23 12:15:00', 1350000.00, 1, 'William Taylor Trip', '0978901234', 'william.taylor@example.com'),
('ORD010', (SELECT id FROM Account WHERE username = 'sophiaanderson'), (SELECT id FROM Account WHERE username = 'robertjohnson'), 'Cancelled', '2024-03-24 17:30:00', 1450000.00, 1, 'Sophia Anderson Vacation', '0989012345', 'sophia.anderson@example.com');

INSERT INTO OrderPassenger (id, orderID, passengerTypeID, fullName, dob, nationID)
VALUES
('OP001', 'ORD001', 1, 'John Doe', '1990-05-15', 1),
('OP002', 'ORD001', 1, 'Mary Johnson', '1992-07-22', 2),
('OP003', 'ORD002', 1, 'Jane Smith', '1985-08-21', 1),
('OP004', 'ORD002', 2, 'Emily Smith', '2015-03-14', 1),
('OP005', 'ORD003', 1, 'Robert Johnson', '1988-11-30', 3),
('OP006', 'ORD004', 1, 'Sarah Williams', '1992-04-12', 4),
('OP007', 'ORD005', 1, 'Michael Brown', '1979-07-25', 2),
('OP008', 'ORD005', 3, 'Baby Brown', '2023-12-01', 2),
('OP009', 'ORD006', 1, 'Emily Davis', '1995-02-18', 5),
('OP010', 'ORD007', 1, 'David Miller', '1983-09-09', 6);

INSERT INTO Ticket (id, orderID, orderPassengerID, flightID, seatID, type, price, status) VALUES
('TKT001', 'ORD001', 'OP001', 'FL001', 'S001A', 'First Class', 2500000.00, 'Confirmed'),
('TKT002', 'ORD002', 'OP003', 'FL002', 'S002B', 'Business Class', 1800000.00, 'Issued'),
('TKT003', 'ORD003', 'OP005', 'FL003', 'S003C', 'Economy Class', 1200000.00, 'Confirmed'),
('TKT004', 'ORD004', 'OP006', 'FL004', 'S004D', 'Business Class', 2000000.00, 'Cancelled'),
('TKT005', 'ORD005', 'OP007', 'FL005', 'S005E', 'Economy Class', 1500000.00, 'Checked-In'),
('TKT006', 'ORD006', 'OP009', 'FL006', 'S006F', 'First Class', 2800000.00, 'Confirmed'),
('TKT007', 'ORD007', 'OP010', 'FL007', 'S007G', 'Business Class', 2200000.00, 'Pending'),
('TKT008', 'ORD008', 'OP008', 'FL008', 'S008H', 'Premium Economy', 1600000.00, 'Confirmed'),
('TKT009', 'ORD009', 'OP009', 'FL009', 'S009I', 'Economy Class', 1350000.00, 'Boarded'),
('TKT010', 'ORD010', 'OP010', 'FL010', 'S010J', 'Economy Plus', 1450000.00, 'Cancelled');


INSERT INTO Luggage (id, customerID, orderID, type, weight) VALUES
('LUG001', (SELECT id FROM Account WHERE username = 'johndoe'), 'ORD001', 'Checked', 23.5),
('LUG002', (SELECT id FROM Account WHERE username = 'janesmith'), 'ORD002', 'Cabin', 7.0),
('LUG003', (SELECT id FROM Account WHERE username = 'robertjohnson'), 'ORD003', 'Checked', 18.2),
('LUG004', (SELECT id FROM Account WHERE username = 'sarahwilliams'), 'ORD004', 'Checked', 25.0),
('LUG005', (SELECT id FROM Account WHERE username = 'michaelbrown'), 'ORD005', 'Cabin', 8.5),
('LUG006', (SELECT id FROM Account WHERE username = 'emilydavis'), 'ORD006', 'Checked', 20.7),
('LUG007', (SELECT id FROM Account WHERE username = 'davidmiller'), 'ORD007', 'Checked', 22.3),
('LUG008', (SELECT id FROM Account WHERE username = 'oliviawilson'), 'ORD008', 'Cabin', 6.8),
('LUG009', (SELECT id FROM Account WHERE username = 'williamtaylor'), 'ORD009', 'Checked', 19.5),
('LUG010', (SELECT id FROM Account WHERE username = 'sophiaanderson'), 'ORD010', 'Cabin', 9.2);

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
INSERT INTO BlogPost (title, content, authorID, categoryID, published) VALUES
('The Future of Aviation Technology', 'Exploring the latest innovations in aviation technology that are reshaping the industry...', (SELECT id FROM Account WHERE username = 'johndoe'), 1, TRUE),
('Top 10 Travel Tips for First-Time Flyers', 'Essential advice for those taking their first flight, covering everything from booking to landing...', (SELECT id FROM Account WHERE username = 'janesmith'), 2, TRUE),
('Business Class Experience: Worth the Upgrade?', 'A detailed review of the business class experience and whether the premium price justifies the benefits...', (SELECT id FROM Account WHERE username = 'robertjohnson'), 3, TRUE),
('New Routes Announced for Summer 2024', 'Breaking news about exciting new flight routes being launched for the upcoming summer season...', (SELECT id FROM Account WHERE username = 'sarahwilliams'), 4, TRUE),
('Hidden Gems: Underrated Destinations in Southeast Asia', 'Discover lesser-known but equally beautiful destinations across Southeast Asia that deserve a visit...', (SELECT id FROM Account WHERE username = 'michaelbrown'), 5, TRUE),
('Understanding Airline Safety Protocols', 'An in-depth look at the safety measures that airlines implement to ensure passenger security...', (SELECT id FROM Account WHERE username = 'emilydavis'), 6, FALSE),
('Boeing 787 vs. Airbus A350: The Ultimate Comparison', 'A comprehensive comparison between two of the most advanced widebody aircraft in service today...', (SELECT id FROM Account WHERE username = 'davidmiller'), 7, TRUE),
('How Airlines Are Improving Customer Service', 'Examining the strategies airlines are adopting to enhance the customer experience...', (SELECT id FROM Account WHERE username = 'oliviawilson'), 8, TRUE),
('Life at 35,000 Feet: Confessions of a Long-Haul Pilot', 'Personal stories and insights from a veteran pilot about life in the cockpit...', (SELECT id FROM Account WHERE username = 'williamtaylor'), 9, FALSE),
('World\'s Most Impressive Airport Terminals', 'A tour of architectural marvels among airport terminals around the world...', (SELECT id FROM Account WHERE username = 'sophiaanderson'), 10, TRUE);

-- Tag table (10 records)
INSERT INTO Tag (name) VALUES
('Aviation'),
('Travel'),
('Technology'),
('Customer Service'),
('Safety'),
('Destinations'),
('Aircraft'),
('Airlines'),
('Airports'),
('Flight Experience');

-- PostTag table (10 records)
INSERT INTO PostTag (postID, tagID) VALUES
((SELECT id FROM BlogPost WHERE title = 'The Future of Aviation Technology'), (SELECT id FROM Tag WHERE name = 'Aviation')),
((SELECT id FROM BlogPost WHERE title = 'The Future of Aviation Technology'), (SELECT id FROM Tag WHERE name = 'Technology')),
((SELECT id FROM BlogPost WHERE title = 'Top 10 Travel Tips for First-Time Flyers'), (SELECT id FROM Tag WHERE name = 'Travel')),
((SELECT id FROM BlogPost WHERE title = 'Business Class Experience: Worth the Upgrade?'), (SELECT id FROM Tag WHERE name = 'Flight Experience')),
((SELECT id FROM BlogPost WHERE title = 'New Routes Announced for Summer 2024'), (SELECT id FROM Tag WHERE name = 'Airlines')),
((SELECT id FROM BlogPost WHERE title = 'Hidden Gems: Underrated Destinations in Southeast Asia'), (SELECT id FROM Tag WHERE name = 'Destinations')),
((SELECT id FROM BlogPost WHERE title = 'Understanding Airline Safety Protocols'), (SELECT id FROM Tag WHERE name = 'Safety')),
((SELECT id FROM BlogPost WHERE title = 'Boeing 787 vs. Airbus A350: The Ultimate Comparison'), (SELECT id FROM Tag WHERE name = 'Aircraft')),
((SELECT id FROM BlogPost WHERE title = 'How Airlines Are Improving Customer Service'), (SELECT id FROM Tag WHERE name = 'Customer Service')),
((SELECT id FROM BlogPost WHERE title = 'World\'s Most Impressive Airport Terminals'), (SELECT id FROM Tag WHERE name = 'Airports'));

-- Comment table (10 records)
INSERT INTO Comment (postID, accountID, content) VALUES
((SELECT id FROM BlogPost WHERE title = 'The Future of Aviation Technology'), (SELECT id FROM Account WHERE username = 'janesmith'), 'This article opened my eyes to the amazing innovations coming to aviation!'),
((SELECT id FROM BlogPost WHERE title = 'Top 10 Travel Tips for First-Time Flyers'), (SELECT id FROM Account WHERE username = 'robertjohnson'), 'Wish I had read this before my first flight. Great advice!'),
((SELECT id FROM BlogPost WHERE title = 'Business Class Experience: Worth the Upgrade?'), (SELECT id FROM Account WHERE username = 'sarahwilliams'), 'Just upgraded on my last flight based on this review and completely agree with your assessment.'),
((SELECT id FROM BlogPost WHERE title = 'New Routes Announced for Summer 2024'), (SELECT id FROM Account WHERE username = 'michaelbrown'), 'Excited about the new route to Phu Quoc! Already planning my trip.'),
((SELECT id FROM BlogPost WHERE title = 'Hidden Gems: Underrated Destinations in Southeast Asia'), (SELECT id FROM Account WHERE username = 'emilydavis'), 'Visited Con Dao based on your recommendation - absolutely stunning!'),
((SELECT id FROM BlogPost WHERE title = 'Understanding Airline Safety Protocols'), (SELECT id FROM Account WHERE username = 'davidmiller'), 'Very informative. Makes me feel much more confident about flying.'),
((SELECT id FROM BlogPost WHERE title = 'Boeing 787 vs. Airbus A350: The Ultimate Comparison'), (SELECT id FROM Account WHERE username = 'oliviawilson'), 'Great technical breakdown! As an engineering student, I really appreciated the detailed analysis.'),
((SELECT id FROM BlogPost WHERE title = 'How Airlines Are Improving Customer Service'), (SELECT id FROM Account WHERE username = 'williamtaylor'), 'Still waiting to see these improvements on my regular airline...'),
((SELECT id FROM BlogPost WHERE title = 'Life at 35,000 Feet: Confessions of a Long-Haul Pilot'), (SELECT id FROM Account WHERE username = 'sophiaanderson'), 'Fascinating insights! Always wondered what pilots experience during those long flights.'),
((SELECT id FROM BlogPost WHERE title = 'World\'s Most Impressive Airport Terminals'), (SELECT id FROM Account WHERE username = 'johndoe'), 'Singapore Changi is truly incredible. Great coverage of its features!');

-- PostLike table (10 records)
INSERT INTO PostLike (postID, accountID) VALUES
((SELECT id FROM BlogPost WHERE title = 'The Future of Aviation Technology'), (SELECT id FROM Account WHERE username = 'janesmith')),
((SELECT id FROM BlogPost WHERE title = 'The Future of Aviation Technology'), (SELECT id FROM Account WHERE username = 'robertjohnson')),
((SELECT id FROM BlogPost WHERE title = 'Top 10 Travel Tips for First-Time Flyers'), (SELECT id FROM Account WHERE username = 'sarahwilliams')),
((SELECT id FROM BlogPost WHERE title = 'Business Class Experience: Worth the Upgrade?'), (SELECT id FROM Account WHERE username = 'michaelbrown')),
((SELECT id FROM BlogPost WHERE title = 'New Routes Announced for Summer 2024'), (SELECT id FROM Account WHERE username = 'emilydavis')),
((SELECT id FROM BlogPost WHERE title = 'Hidden Gems: Underrated Destinations in Southeast Asia'), (SELECT id FROM Account WHERE username = 'davidmiller')),
((SELECT id FROM BlogPost WHERE title = 'Understanding Airline Safety Protocols'), (SELECT id FROM Account WHERE username = 'oliviawilson')),
((SELECT id FROM BlogPost WHERE title = 'Boeing 787 vs. Airbus A350: The Ultimate Comparison'), (SELECT id FROM Account WHERE username = 'williamtaylor')),
((SELECT id FROM BlogPost WHERE title = 'Life at 35,000 Feet: Confessions of a Long-Haul Pilot'), (SELECT id FROM Account WHERE username = 'sophiaanderson')),
((SELECT id FROM BlogPost WHERE title = 'World\'s Most Impressive Airport Terminals'), (SELECT id FROM Account WHERE username = 'johndoe'));

-- Blog table (10 records)
INSERT INTO Blog (postID, title, short_description, thumbnail, authorID) VALUES
((SELECT id FROM BlogPost WHERE title = 'The Future of Aviation Technology'), 'Aviation Tech Trends', 'Discover the cutting-edge technologies shaping the future of air travel', 'tech_thumb.jpg', (SELECT id FROM Account WHERE username = 'johndoe')),
((SELECT id FROM BlogPost WHERE title = 'Top 10 Travel Tips for First-Time Flyers'), 'First-Time Flyer Guide', 'Essential advice for anyone taking their first flight', 'firstflight_thumb.jpg', (SELECT id FROM Account WHERE username = 'janesmith')),
((SELECT id FROM BlogPost WHERE title = 'Business Class Experience: Worth the Upgrade?'), 'Business Class Analysis', 'Is the premium price worth the luxury experience?', 'business_thumb.jpg', (SELECT id FROM Account WHERE username = 'robertjohnson')),
((SELECT id FROM BlogPost WHERE title = 'New Routes Announced for Summer 2024'), 'Summer 2024 Routes', 'Exciting new destinations for your summer travel plans', 'routes_thumb.jpg', (SELECT id FROM Account WHERE username = 'sarahwilliams')),
((SELECT id FROM BlogPost WHERE title = 'Hidden Gems: Underrated Destinations in Southeast Asia'), 'Southeast Asia Secrets', 'Discover lesser-known but incredible places to visit in Southeast Asia', 'seasia_thumb.jpg', (SELECT id FROM Account WHERE username = 'michaelbrown')),
((SELECT id FROM BlogPost WHERE title = 'Understanding Airline Safety Protocols'), 'Airline Safety Guide', 'An inside look at how airlines keep passengers safe', 'safety_thumb.jpg', (SELECT id FROM Account WHERE username = 'emilydavis')),
((SELECT id FROM BlogPost WHERE title = 'Boeing 787 vs. Airbus A350: The Ultimate Comparison'), 'Modern Aircraft Comparison', 'Which widebody aircraft delivers the best passenger experience?', 'aircraft_thumb.jpg', (SELECT id FROM Account WHERE username = 'davidmiller')),
((SELECT id FROM BlogPost WHERE title = 'How Airlines Are Improving Customer Service'), 'Customer Service Evolution', 'New approaches airlines are taking to enhance passenger satisfaction', 'service_thumb.jpg', (SELECT id FROM Account WHERE username = 'oliviawilson')),
((SELECT id FROM BlogPost WHERE title = 'Life at 35,000 Feet: Confessions of a Long-Haul Pilot'), 'Pilot Perspectives', 'A pilot\'s view of life in the cockpit and the challenges of long flights', 'pilot_thumb.jpg', (SELECT id FROM Account WHERE username = 'williamtaylor')),
((SELECT id FROM BlogPost WHERE title = 'World\'s Most Impressive Airport Terminals'), 'Amazing Airports', 'Exploring architectural wonders among the world\'s airports', 'airport_thumb.jpg', (SELECT id FROM Account WHERE username = 'sophiaanderson'));

-- ChatMessage table (10 records)
INSERT INTO ChatMessage (senderAccountID, receiverAccountID, message, timestamp, isRead) VALUES
((SELECT id FROM Account WHERE username = 'johndoe'), (SELECT id FROM Account WHERE username = 'janesmith'), 'Hi Jane, I have a question about my upcoming flight.', '2024-03-15 10:15:00', TRUE),
((SELECT id FROM Account WHERE username = 'janesmith'), (SELECT id FROM Account WHERE username = 'johndoe'), 'Sure John, how can I help you?', '2024-03-15 10:18:00', TRUE),
((SELECT id FROM Account WHERE username = 'robertjohnson'), (SELECT id FROM Account WHERE username = 'sarahwilliams'), 'Sarah, could you check if there are any window seats available on flight VN303?', '2024-03-16 14:30:00', TRUE),
((SELECT id FROM Account WHERE username = 'sarahwilliams'), (SELECT id FROM Account WHERE username = 'robertjohnson'), 'I just checked and there are 3 window seats available. Would you like me to book one for you?', '2024-03-16 14:45:00', TRUE),
((SELECT id FROM Account WHERE username = 'michaelbrown'), (SELECT id FROM Account WHERE username = 'emilydavis'), 'Emily, I need to change my flight date. Is it possible?', '2024-03-17 09:20:00', FALSE),
((SELECT id FROM Account WHERE username = 'davidmiller'), (SELECT id FROM Account WHERE username = 'oliviawilson'), 'Hi Olivia, I\'m looking for information about luggage allowance for international flights.', '2024-03-18 11:10:00', TRUE),
((SELECT id FROM Account WHERE username = 'oliviawilson'), (SELECT id FROM Account WHERE username = 'davidmiller'), 'Hello David, for international flights, you get 30kg for business class and 20kg for economy. Do you need more details?', '2024-03-18 11:25:00', TRUE),
((SELECT id FROM Account WHERE username = 'williamtaylor'), (SELECT id FROM Account WHERE username = 'sophiaanderson'), 'Sophia, I\'m experiencing issues with the online check-in system. Can you help?', '2024-03-19 15:40:00', FALSE),
((SELECT id FROM Account WHERE username = 'johndoe'), (SELECT id FROM Account WHERE username = 'robertjohnson'), 'Robert, can you send me the itinerary for our business trip next week?', '2024-03-20 08:55:00', FALSE),
((SELECT id FROM Account WHERE username = 'janesmith'), (SELECT id FROM Account WHERE username = 'michaelbrown'), 'Michael, I\'ve approved your refund request. The amount will be credited to your account within 7 business days.', '2024-03-21 13:15:00', TRUE);

SELECT 
    t.*, 
    f.name AS flightName, 
    f.code AS flightCode, 
    f.startingTime, 
    f.landingTime, 
    l1.name AS departureName, 
    l2.name AS destinationName, 
    s.id AS seatCode, 
    c.name AS compartmentName, 
    tt.handLuggageWeight, 
    tt.checkedLuggageWeight, 
    tt.luggageQuantity, 
    tt.additionalServices, 
    a.id AS airplaneId, 
    a.name AS airplaneName 
FROM 
    Ticket t
JOIN 
    Flight f ON t.flightId = f.id
JOIN 
    Location l1 ON f.departure = l1.id
JOIN 
    Location l2 ON f.destination = l2.id
JOIN 
    Seat s ON t.seatId = s.id
JOIN 
    Compartment c ON s.compartmentId = c.id
JOIN 
    Airplane a ON c.airplaneId = a.id
JOIN 
    TicketType tt ON t.type = tt.type
WHERE 
    t.orderId = 'ORD002'; -- Thay 1234 bằng orderId cụ thể
    
SELECT t.*, f.name AS flightName, f.code AS flightCode, 
       f.startingTime, f.landingTime,
       l1.name AS departureName, l2.name AS destinationName,
       s.id AS seatCode, c.name AS compartmentName,
       ap.name AS airplaneName,
       op.fullName AS passengerName, op.dob AS passengerDob,
       n.name AS nationName,
       pt.name AS passengerType,
       tt.checkedLuggageWeight, tt.handLuggageWeight, tt.luggageQuantity, tt.additionalServices,
       l.weight AS luggageWeight, l.type AS luggageType
FROM Ticket t
JOIN Flight f ON t.flightId = f.id
JOIN Location l1 ON f.departure = l1.id
JOIN Location l2 ON f.destination = l2.id
JOIN Seat s ON t.seatId = s.id
JOIN Compartment c ON s.compartmentId = c.id
JOIN Airplane ap ON f.airplaneId = ap.id
JOIN OrderPassenger op ON op.orderId = t.orderId
LEFT JOIN Nation n ON op.nationId = n.id
LEFT JOIN PassengerType pt ON op.passengerTypeId = pt.id
LEFT JOIN TicketType tt ON t.type = tt.type
LEFT JOIN Luggage l ON l.orderId = t.orderId
WHERE t.orderId = 'ORD005';

SELECT t.id, t.orderID, t.orderPassengerID, t.flightID, t.seatID, t.type, t.price, t.status,  
       op.fullName, n.name AS nation  
FROM Ticket t  
LEFT JOIN OrderPassenger op ON t.orderPassengerID = op.id  
LEFT JOIN Nation n ON op.nationID = n.id  
WHERE t.orderID = 'ORD002';

SELECT * FROM OrderPassenger WHERE id IN 
  (SELECT orderPassengerID FROM Ticket WHERE seatID = 'S002B');

SELECT id, orderID, orderPassengerID, COUNT(*) 
FROM ticket
GROUP BY id, orderID, orderPassengerID
HAVING COUNT(*) > 1;


SELECT OrderID, COUNT(id) AS TotalTickets
FROM ticket
GROUP BY OrderID
HAVING TotalTickets > 1;

SELECT id, COUNT(*) as count
FROM Ticket
GROUP BY id
HAVING COUNT(*) > 1;

SELECT op.fullName, t.orderPassengerID, t.id AS ticketID
FROM Ticket t
JOIN OrderPassenger op ON t.orderPassengerID = op.id;

Select * from `Order`;

SELECT o.id, o.customerID, o.staffID, o.status, o.time, COUNT(t.id) AS ticket_count
FROM `Order` o
LEFT JOIN Ticket t ON o.id = t.orderID
WHERE o.customerID = 'c9978809-08e2-11f0-b095-71802f6a8767' -- Thay 'CUST001' bằng ID khách hàng thực tế
GROUP BY o.id, o.customerID, o.staffID, o.status, o.time
ORDER BY o.time DESC;

SELECT o.id AS orderID, o.customerID, o.staffID, o.status, o.time, 
       t.id AS ticketID, op.fullName, op.id AS orderPassengerID
FROM `Order` o
JOIN Ticket t ON o.id = t.orderID
JOIN OrderPassenger op ON t.orderPassengerID = op.id
WHERE o.customerID = 'c9978809-08e2-11f0-b095-71802f6a8767' -- Thay 'CUST001' bằng ID khách hàng thực tế
ORDER BY o.time DESC, t.id;

SELECT 
    o.id AS orderID, 
    o.customerID, 
    o.staffID, 
    o.status, 
    o.time, 
    GROUP_CONCAT(t.id ORDER BY t.id SEPARATOR ', ') AS ticketIDs, 
    COUNT(t.id) AS ticketCount,
    op.fullName, 
    op.id AS orderPassengerID
FROM `Order` o
JOIN Ticket t ON o.id = t.orderID
JOIN OrderPassenger op ON t.orderPassengerID = op.id
WHERE o.customerID = 'c9978809-08e2-11f0-b095-71802f6a8767' -- Thay 'CUST001' bằng ID khách hàng thực tế
GROUP BY o.id, o.customerID, o.staffID, o.status, o.time, op.fullName, op.id
ORDER BY o.time DESC;

SELECT 
    op.fullName, 
    t.orderPassengerID, 
    t.orderID ,  -- Thêm cột OrderID
    t.id AS ticketID
FROM Ticket t
JOIN OrderPassenger op ON t.orderPassengerID = op.id;






