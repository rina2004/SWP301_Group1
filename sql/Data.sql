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

-- Type table (10 records)
INSERT INTO Type (id, name, manufacture, length, weight, height) VALUES
('TYP001', 'Boeing 737-800', 'Boeing', 39.50, 41400.00, 12.50),
('TYP002', 'Airbus A320', 'Airbus', 37.57, 42600.00, 11.76),
('TYP003', 'Boeing 787-9', 'Boeing', 63.00, 128000.00, 17.00),
('TYP004', 'Airbus A350-900', 'Airbus', 66.80, 142000.00, 17.05),
('TYP005', 'Embraer E190', 'Embraer', 36.24, 28080.00, 10.57),
('TYP006', 'Bombardier CRJ900', 'Bombardier', 36.40, 21500.00, 7.50),
('TYP007', 'Airbus A330-300', 'Airbus', 63.60, 124000.00, 16.79),
('TYP008', 'Boeing 777-300ER', 'Boeing', 73.90, 160000.00, 18.50),
('TYP009', 'ATR 72-600', 'ATR', 27.17, 12800.00, 7.65),
('TYP010', 'Airbus A321neo', 'Airbus', 44.51, 50500.00, 11.76);

-- AirplaneStatus table already has 5 records, adding 5 more to reach 10
INSERT INTO AirplaneStatus (name) VALUES 
('Grounded'), ('Out of Service'), ('Scheduled'), ('Reserved'), ('Standby');

-- Airplane table (10 records)
INSERT INTO Airplane (id, name, typeID, statusID, maintainanceTime, usedTime) VALUES
('VN-A001', 'Sky Dragon', 'TYP001', 1, '2024-06-15 08:00:00', '2023-12-01 00:00:00'),
('VN-A002', 'Ocean Star', 'TYP002', 2, '2024-07-20 10:30:00', '2024-01-15 00:00:00'),
('VN-A003', 'Cloud Runner', 'TYP003', 3, '2024-05-10 09:15:00', '2023-11-05 00:00:00'),
('VN-A004', 'Wind Rider', 'TYP004', 4, '2024-08-05 11:45:00', '2024-02-20 00:00:00'),
('VN-A005', 'Sun Chaser', 'TYP005', 5, '2024-06-30 13:20:00', '2023-12-25 00:00:00'),
('VN-A006', 'Moon Walker', 'TYP006', 1, '2024-07-12 14:00:00', '2024-01-30 00:00:00'),
('VN-A007', 'Star Gazer', 'TYP007', 2, '2024-05-25 15:30:00', '2023-11-20 00:00:00'),
('VN-A008', 'Air Master', 'TYP008', 3, '2024-08-18 16:45:00', '2024-02-10 00:00:00'),
('VN-A009', 'Sky Voyager', 'TYP009', 4, '2024-06-05 08:30:00', '2023-12-15 00:00:00'),
('VN-A010', 'Cloud Dancer', 'TYP010', 5, '2024-07-28 09:45:00', '2024-01-05 00:00:00');

-- Compartment table (10 records)
INSERT INTO Compartment (id, name, airplaneID, capacity) VALUES
('A', 'First Class', 'VN-A001', 8),
('B', 'Business Class', 'VN-A001', 32),
('C', 'Economy Class', 'VN-A001', 120),
('D', 'Business Class', 'VN-A002', 28),
('E', 'Economy Class', 'VN-A002', 150),
('F', 'First Class', 'VN-A003', 10),
('G', 'Business Class', 'VN-A003', 42),
('H', 'Premium Economy', 'VN-A003', 28),
('I', 'Economy Class', 'VN-A003', 198),
('J', 'Economy Plus', 'VN-A004', 48);


-- Flight table (10 records)
INSERT INTO Flight (id, name, code, airplaneID, departure, destination, entryTime, startingTime, landingTime) VALUES
('FL001', 'Morning Express', 'VN001', 'VN-A001', 'Hanoi', 'Ho Chi Minh City', '2024-04-10 06:00:00', '2024-04-10 07:00:00', '2024-04-10 09:00:00'),
('FL002', 'Afternoon Shuttle', 'VN002', 'VN-A002', 'Ho Chi Minh City', 'Da Nang', '2024-04-11 12:30:00', '2024-04-11 13:30:00', '2024-04-11 14:45:00'),
('FL003', 'Evening Direct', 'VN003', 'VN-A003', 'Da Nang', 'Hanoi', '2024-04-12 18:00:00', '2024-04-12 19:00:00', '2024-04-12 20:30:00'),
('FL004', 'International Route', 'VN004', 'VN-A004', 'Ho Chi Minh City', 'Singapore', '2024-04-13 09:15:00', '2024-04-13 10:15:00', '2024-04-13 12:45:00'),
('FL005', 'Night Flight', 'VN005', 'VN-A005', 'Hanoi', 'Bangkok', '2024-04-14 22:00:00', '2024-04-14 23:00:00', '2024-04-15 00:30:00'),
('FL006', 'Weekend Special', 'VN006', 'VN-A006', 'Da Nang', 'Phu Quoc', '2024-04-15 10:45:00', '2024-04-15 11:45:00', '2024-04-15 13:00:00'),
('FL007', 'Business Express', 'VN007', 'VN-A007', 'Hanoi', 'Tokyo', '2024-04-16 08:30:00', '2024-04-16 09:30:00', '2024-04-16 14:00:00'),
('FL008', 'Tourist Delight', 'VN008', 'VN-A008', 'Ho Chi Minh City', 'Seoul', '2024-04-17 14:15:00', '2024-04-17 15:15:00', '2024-04-17 19:45:00'),
('FL009', 'Express Connection', 'VN009', 'VN-A009', 'Da Nang', 'Hong Kong', '2024-04-18 11:30:00', '2024-04-18 12:30:00', '2024-04-18 15:15:00'),
('FL010', 'Domestic Link', 'VN010', 'VN-A010', 'Cam Ranh', 'Hai Phong', '2024-04-19 16:45:00', '2024-04-19 17:45:00', '2024-04-19 19:30:00');

-- Seat table (10 records)
INSERT INTO Seat (id, compartmentID, status, reason) VALUES
('S001A', 'A', TRUE, null),
('S002B', 'B', TRUE, null),
('S003C', 'C', TRUE, null),
('S004D', 'D', FALSE, 'In Maintenance'),
('S005E', 'E', TRUE, null),
('S006F', 'F', TRUE, null),
('S007G', 'G', FALSE, 'In Maintenance'),
('S008H', 'H', TRUE, null),
('S009I', 'I', TRUE, null),
('S010J', 'J', FALSE, 'In Reparing');

-- Order table (10 records)
INSERT INTO `Order` (id, customerID, staffID, status, time) VALUES
('ORD001', (SELECT id FROM Account WHERE username = 'johndoe'), (SELECT id FROM Account WHERE username = 'sarahwilliams'), 'Confirmed', '2024-03-15 09:30:00'),
('ORD002', (SELECT id FROM Account WHERE username = 'janesmith'), (SELECT id FROM Account WHERE username = 'michaelbrown'), 'Processing', '2024-03-16 11:45:00'),
('ORD003', (SELECT id FROM Account WHERE username = 'robertjohnson'), (SELECT id FROM Account WHERE username = 'emilydavis'), 'Confirmed', '2024-03-17 14:20:00'),
('ORD004', (SELECT id FROM Account WHERE username = 'sarahwilliams'), (SELECT id FROM Account WHERE username = 'davidmiller'), 'Cancelled', '2024-03-18 16:35:00'),
('ORD005', (SELECT id FROM Account WHERE username = 'michaelbrown'), (SELECT id FROM Account WHERE username = 'oliviawilson'), 'Completed', '2024-03-19 10:10:00'),
('ORD006', (SELECT id FROM Account WHERE username = 'emilydavis'), (SELECT id FROM Account WHERE username = 'williamtaylor'), 'Confirmed', '2024-03-20 13:25:00'),
('ORD007', (SELECT id FROM Account WHERE username = 'davidmiller'), (SELECT id FROM Account WHERE username = 'sophiaanderson'), 'Processing', '2024-03-21 15:40:00'),
('ORD008', (SELECT id FROM Account WHERE username = 'oliviawilson'), (SELECT id FROM Account WHERE username = 'johndoe'), 'Confirmed', '2024-03-22 08:55:00'),
('ORD009', (SELECT id FROM Account WHERE username = 'williamtaylor'), (SELECT id FROM Account WHERE username = 'janesmith'), 'Completed', '2024-03-23 12:15:00'),
('ORD010', (SELECT id FROM Account WHERE username = 'sophiaanderson'), (SELECT id FROM Account WHERE username = 'robertjohnson'), 'Cancelled', '2024-03-24 17:30:00');

-- Ticket table (10 records)
INSERT INTO Ticket (id, orderID, flightID, seatID, type, Price, Status) VALUES
('TKT001', 'ORD001', 'FL001', 'S001A', 'First Class', 2500000.00, 'Confirmed'),
('TKT002', 'ORD002', 'FL002', 'S002B', 'Business Class', 1800000.00, 'Issued'),
('TKT003', 'ORD003', 'FL003', 'S003C', 'Economy Class', 1200000.00, 'Confirmed'),
('TKT004', 'ORD004', 'FL004', 'S004D', 'Business Class', 2000000.00, 'Cancelled'),
('TKT005', 'ORD005', 'FL005', 'S005E', 'Economy Class', 1500000.00, 'Checked-In'),
('TKT006', 'ORD006', 'FL006', 'S006F', 'First Class', 2800000.00, 'Confirmed'),
('TKT007', 'ORD007', 'FL007', 'S007G', 'Business Class', 2200000.00, 'Pending'),
('TKT008', 'ORD008', 'FL008', 'S008H', 'Premium Economy', 1600000.00, 'Confirmed'),
('TKT009', 'ORD009', 'FL009', 'S009I', 'Economy Class', 1350000.00, 'Boarded'),
('TKT010', 'ORD010', 'FL010', 'S010J', 'Economy Plus', 1450000.00, 'Cancelled');

-- Luggage table (10 records)
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