USE `swp301`;

-- Keep the original Role data
INSERT INTO Role (name) VALUES 
('Administrator'),
('Customer'),
('Staff'),
('AirTrafficControl');

INSERT INTO Location (name) VALUES
('Hà Nội-Nội Bài'),
('TP. Hồ Chí Minh-Tân Sơn Nhất'),
('Đà Nẵng-Quốc tế Đà Nẵng'),
('Nha Trang-Cam Ranh'),
('Phú Quốc-Quốc tế Phú Quốc'),
('Huế-Phú Bài'),
('Hải Phòng-Cát Bi'),
('Đà Lạt-Liên Khương'),
('Cần Thơ-Quốc tế Cần Thơ'),
('Quảng Ninh-Vân Đồn'),
('Nghệ An-Vinh'),
('Buôn Ma Thuột-Buôn Ma Thuột'),
('Quy Nhơn-Phù Cát'),
('Thanh Hóa-Thọ Xuân'),
('Quảng Bình-Đồng Hới'),
('Điện Biên-Điện Biên Phủ'),
('Pleiku-Pleiku'),
('Côn Đảo-Côn Sơn'),
('Tuy Hòa-Tuy Hòa'),
('Cà Mau-Cà Mau');

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

INSERT INTO AirplaneStatus (name) VALUES 
('Active'), ('Maintenance'), ('Retired'), ('In Use'), ('Under Repair');

INSERT INTO PassengerType (name, ageMin, ageMax, discountPercentage) VALUES
('Người lớn', 12, 100, 0),
('Trẻ em', 2, 11, 25),
('Em bé', 0, 1, 90);

INSERT INTO `TicketType` (`type`, `description`, `percent`, `checkedweightneed`, `handedweightneed` ) VALUES
('Basic', 'Standard seating and basic amenities. Additional services: Priority boarding, extra legroom, complimentary beverage service.', 100, 23.0, 7.0),
('Extra', 'Full business class experience. Additional services: Lie-flat seats, lounge access, premium meals and beverages.', 105, 25.0, 10.0),
('First Class', 'Luxury air travel experience. Additional services: Private suites, personalized service, gourmet dining, exclusive lounge access.', 150, 50.0, 10.0);

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

-- Airplane table (10 records)
INSERT INTO Airplane (id, name, statusID, numOfComs, maintainanceTime, usedTime) VALUES
('VN-A001', 'Sky Dragon', 1, 3, '2024-06-15 08:00:00', '2023-12-01 00:00:00'),
('VN-A002', 'Ocean Star', 2, 3, '2024-07-20 10:30:00', '2024-01-15 00:00:00'),
('VN-A003', 'Cloud Runner', 3, 3, '2024-05-10 09:15:00', '2023-11-05 00:00:00'),
('VN-A004', 'Wind Rider', 4, 3, '2024-08-05 11:45:00', '2024-02-20 00:00:00'),
('VN-A005', 'Sun Chaser', 5, 3, '2024-06-30 13:20:00', '2023-12-25 00:00:00'),
('VN-A006', 'Moon Walker', 1, 3, '2024-07-12 14:00:00', '2024-01-30 00:00:00'),
('VN-A007', 'Star Gazer', 2, 3, '2024-05-25 15:30:00', '2023-11-20 00:00:00'),
('VN-A008', 'Air Master', 3, 3, '2024-08-18 16:45:00', '2024-02-10 00:00:00'),
('VN-A009', 'Sky Voyager', 4, 3, '2024-06-05 08:30:00', '2023-12-15 00:00:00'),
('VN-A010', 'Cloud Dancer', 5, 3, '2024-07-28 09:45:00', '2024-01-05 00:00:00');

-- Flight table (10 records)
INSERT INTO Flight (id, name, code, airplaneID, departure, destination, entryTime, startingTime, landingTime, price) VALUES 
    ('FL001', 'Morning Express', 'VN001', 'VN-A001', 1, 2, '2025-05-1 06:00:00', '2025-05-2 07:00:00', '2025-05-2 09:00:00', 2100000),
    ('FL002', 'Afternoon Shuttle', 'VN002', 'VN-A002', 2, 3, '2025-05-1 06:00:00', '2025-05-2 07:30:00', '2025-05-2 09:30:00', 2080000),
    ('FL003', 'Evening Direct', 'VN003', 'VN-A003', 3, 1, '2025-05-1 06:00:00', '2025-05-2 08:00:00', '2025-05-2 10:00:00', 2150000.00),
    ('FL004', 'International Route', 'VN004', 'VN-A004', 2, 11, '2025-05-1 06:00:00', '2025-05-2 09:00:00', '2025-05-2 11:00:00', 2500000),    
    ('FL005', 'Night Flight', 'VN005', 'VN-A005', 1, 12, '2025-05-1 06:00:00', '2025-05-2 10:30:00', '2025-05-2 12:30:00', 2200000),   
    ('FL006', 'Weekend Special', 'VN006', 'VN-A006', 3, 5, '2025-05-1 06:00:00', '2025-05-2 07:15:00', '2025-05-2 09:15:00', 2250000),    
    ('FL007', 'Business Express', 'VN007', 'VN-A007', 1, 13, '2025-05-1 06:00:00', '2025-05-2 07:45:00', '2025-05-2 09:45:00', 2300000),
    ('FL008', 'Tourist Delight', 'VN008', 'VN-A008', 2, 14, '2025-05-1 06:00:00', '2025-05-2 08:15:00', '2025-05-2 10:15:00', 2250000),
    ('FL009', 'Express Connection', 'VN009', 'VN-A009', 3, 15, '2025-05-1 06:00:00', '2025-05-2 09:30:00', '2025-05-2 11:30:00', 2400000),    
    ('FL010', 'Domestic Link', 'VN010', 'VN-A010', 4, 7, '2025-05-1 06:00:00', '2025-05-2 10:00:00', '2025-05-2 12:00:00', 2300000);

INSERT INTO CompartmentType (id, name) VALUES
('B', 'Business'),
('E', 'Economy'),
('F', 'First Class');

-- Compartment table (10 records)
INSERT INTO Compartment (id, typeId, airplaneID, capacity) VALUES
('VN-A001-B', 'B','VN-A001', 40),
('VN-A001-E', 'E','VN-A001', 40),
('VN-A001-F', 'F','VN-A001', 40),
('VN-A002-B', 'B','VN-A002', 40),
('VN-A002-E', 'E','VN-A002', 40),
('VN-A002-F','F','VN-A002', 40),
('VN-A003-B', 'B','VN-A003', 40),
('VN-A003-E', 'E','VN-A003', 40),
('VN-A003-F','F','VN-A003', 40),
('VN-A004-B', 'B','VN-A004', 40),
('VN-A004-E', 'E','VN-A004', 40),
('VN-A004-F','F','VN-A004', 40),
('VN-A005-B', 'B','VN-A005', 40),
('VN-A005-E', 'E','VN-A005', 40),
('VN-A005-F','F','VN-A005', 40),
('VN-A006-B', 'B','VN-A006', 40),
('VN-A006-E', 'E','VN-A006', 40),
('VN-A006-F','F','VN-A006', 40),
('VN-A007-B', 'B','VN-A007', 40),
('VN-A007-E', 'E','VN-A007', 40),
('VN-A007-F','F','VN-A007', 40),
('VN-A008-B', 'B','VN-A008', 40),
('VN-A008-E', 'E','VN-A008', 40),
('VN-A008-F','F','VN-A008', 40),
('VN-A009-B', 'B','VN-A009', 40),
('VN-A009-E', 'E','VN-A009', 40),
('VN-A009-F','F','VN-A009', 40),
('VN-A010-B', 'B','VN-A010', 40),
('VN-A010-E', 'E','VN-A010', 40),
('VN-A010-F','F','VN-A010', 40);

-- Seat table (10 records)
INSERT INTO Seat (id, compartmentID, status, reason) VALUES
('VN-A001-B-1', 'VN-A001-B', 'Active', null),
('VN-A001-B-2', 'VN-A001-B', 'Active', null),
('VN-A001-B-3', 'VN-A001-B', 'Active', null),
('VN-A001-E-4', 'VN-A001-E', 'Active', null),
('VN-A001-E-5', 'VN-A001-E', 'In Maintenance', 'SUPAIGA'),
('VN-A001-E-6', 'VN-A001-E', 'Retired', 'SUPANIGA'),
('VN-A001-F-7', 'VN-A001-F', 'Active', null),
('VN-A001-F-8', 'VN-A001-F', 'Active', 'SUPAIGA'),
('VN-A001-F-9', 'VN-A001-F', 'Active', 'SUPANIGA'),
('VN-A002-B-1', 'VN-A002-B', 'Active', null),
('VN-A002-B-2', 'VN-A002-B', 'Active', 'SUPAIGA'),
('VN-A002-B-3', 'VN-A002-B', 'Active', 'SUPANIGA'),
('VN-A002-E-4', 'VN-A002-E', 'Active', null),
('VN-A002-E-5', 'VN-A002-E', 'Active', 'SUPAIGA'),
('VN-A002-E-6', 'VN-A002-E', 'Active', 'SUPANIGA'),
('VN-A002-F-7', 'VN-A002-F', 'Active', null),
('VN-A002-F-8', 'VN-A002-F', 'Active', 'SUPAIGA'),
('VN-A002-F-9', 'VN-A002-F', 'Active', 'SUPANIGA'),
('VN-A003-B-1', 'VN-A003-B', 'Active', null),
('VN-A003-B-2', 'VN-A003-B', 'Active', 'SUPAIGA'),
('VN-A003-B-3', 'VN-A003-B', 'Active', 'SUPANIGA'),
('VN-A003-E-4', 'VN-A003-E', 'Active', null),
('VN-A003-E-5', 'VN-A003-E', 'Active', 'SUPAIGA'),
('VN-A003-E-6', 'VN-A003-E', 'Active', 'SUPANIGA'),
('VN-A003-F-7', 'VN-A003-F', 'Active', null),
('VN-A003-F-8', 'VN-A003-F', 'Active', 'SUPAIGA'),
('VN-A003-F-9', 'VN-A003-F', 'Active', 'SUPANIGA');

INSERT INTO `Order` (id, customerID, staffID, status, time, finalPrice, finalNum, type) VALUES
('ORD001', (SELECT id FROM Account WHERE username = 'user1'), (SELECT id FROM Account WHERE username = 'staff1'), 'Confirmed', '2024-03-15 09:30:00', 0.0, 1, 'Extra'),
('ORD002', (SELECT id FROM Account WHERE username = 'user2'), (SELECT id FROM Account WHERE username = 'staff1'), 'Processing', '2024-03-16 11:45:00', 0.0, 3, 'Basic'),
('ORD003', (SELECT id FROM Account WHERE username = 'user3'), (SELECT id FROM Account WHERE username = 'staff1'), 'Confirmed', '2024-03-17 14:20:00', 0.0, 1, 'Extra'),
('ORD004', (SELECT id FROM Account WHERE username = 'user4'), (SELECT id FROM Account WHERE username = 'staff1'), 'Cancelled', '2024-03-18 16:35:00', 0.0, 1, 'First Class');

INSERT INTO OrderPassenger (id, orderID, passengerTypeID, fullName, dob, nationID)
VALUES
('ORD001-1', 'ORD001', 1, 'John Doe', '1990-05-15', 1),
('ORD002-1', 'ORD002', 1, 'Mary Johnson', '1992-07-22', 2),
('ORD002-2', 'ORD002', 1, 'Jane Smith', '1985-08-21', 1),
('ORD002-3', 'ORD002', 2, 'Emily Smith', '2015-03-14', 1),
('ORD003-1', 'ORD003', 1, 'Robert Johnson', '1988-11-30', 3),
('ORD004-1', 'ORD004', 1, 'Sarah Williams', '1992-04-12', 4);

INSERT INTO Ticket (orderPID, flightID, comID, seatID, status) VALUES
('ORD001-1', 'FL001', 'VN-A001-B', 'VN-A001-B-1', 'Confirmed'),
('ORD002-1', 'FL001', 'VN-A001-E', 'VN-A001-E-4', 'Pending'),
('ORD002-2', 'FL001', 'VN-A001-E', 'VN-A001-E-5', 'Confirmed'),
('ORD002-3', 'FL001', 'VN-A001-E', 'VN-A001-E-6', 'Cancelled'),
('ORD003-1', 'FL001', 'VN-A002-F', 'VN-A001-F-7', 'Checked-In'),
('ORD004-1', 'FL001', 'VN-A002-F', 'VN-A001-F-8', 'Confirmed');

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


SELECT 
    t.id AS ticketId, 
    t.status AS ticketStatus, 
    o.id AS orderId, 
    o.customerID, 
    o.staffID, 
    o.status AS orderStatus, 
    o.time, 
    o.finalPrice, 
    o.finalNum, 
    f.id AS flightId, 
    f.name AS flightName, 
    f.code, 
    f.airplaneID, 
    f.departure, 
    f.destination, 
    f.entryTime, 
    f.startingTime, 
    f.landingTime, 
    s.id AS seatId, 
    s.status AS seatStatus, 
    s.reason 
FROM Ticket t 
JOIN `Order` o ON t.orderID = o.id 
JOIN Flight f ON t.flightID = f.id 
JOIN Seat s ON t.seatID = s.id 
WHERE t.flightID = 'FL001' 
AND t.seatID = 'VN-A001-1';


SELECT 
    t.id AS ticketId, 
    t.status AS ticketStatus, 
    o.id AS orderId, 
    o.customerID, 
    o.staffID, 
    o.status AS orderStatus, 
    o.time, 
    o.finalPrice, 
    o.finalNum, 
    f.id AS flightId, 
    f.name AS flightName, 
    f.code, 
    f.airplaneID, 
    f.departure, 
    f.destination, 
    f.entryTime, 
    f.startingTime, 
    f.landingTime, 
    s.id AS seatId, 
    s.status AS seatStatus, 
    s.reason 
FROM Ticket t 
JOIN `Order` o ON t.orderID = o.id 
JOIN Flight f ON t.flightID = f.id 
JOIN Seat s ON t.seatID = s.id 
WHERE t.orderID = 'ORD002';

SELECT 
    t.id AS ticketId, 
    t.status AS ticketStatus, 
    o.id AS orderId, 
    o.customerID, 
    o.staffID, 
    o.status AS orderStatus, 
    o.time, 
    o.finalPrice, 
    o.finalNum, 
    f.id AS flightId, 
    f.name AS flightName, 
    f.code, 
    f.airplaneID, 
    dep.name AS departure,  -- Lấy tên địa điểm thay vì ID
    des.name AS destination, -- Lấy tên địa điểm thay vì ID
    f.entryTime, 
    f.startingTime, 
    f.landingTime, 
    s.id AS seatId, 
    s.status AS seatStatus, 
    s.reason 
FROM Ticket t 
JOIN `Order` o ON t.orderID = o.id 
JOIN Flight f ON t.flightID = f.id 
JOIN Seat s ON t.seatID = s.id 
JOIN Location dep ON f.departure = dep.id  -- Thay ID bằng tên
JOIN Location des ON f.destination = des.id -- Thay ID bằng tên
WHERE t.orderID ='ORD002';

SELECT 
    t.id AS ticketId, 
    t.status AS ticketStatus, 
    o.id AS orderId, 
    o.customerID, 
    o.staffID, 
    o.status AS orderStatus, 
    o.time, 
    o.finalPrice, 
    o.finalNum, 
    f.id AS flightId, 
    f.name AS flightName, 
    f.code, 
    f.airplaneID, 
    a.name AS airplaneName, 
    dep.name AS departure,  
    des.name AS destination, 
    f.entryTime, 
    f.startingTime, 
    f.landingTime, 
    s.id AS seatId, 
    s.status AS seatStatus, 
    s.reason, 
    op.fullName AS passengerName,  -- Lấy tên hành khách
    n.name AS nationName  -- Lấy quốc tịch của hành khách
FROM Ticket t 
JOIN `Order` o ON t.orderID = o.id 
JOIN Flight f ON t.flightID = f.id 
JOIN Seat s ON t.seatID = s.id 
JOIN Location dep ON f.departure = dep.id  
JOIN Location des ON f.destination = des.id 
JOIN Airplane a ON f.airplaneID = a.id 
JOIN OrderPassenger op ON o.id = op.orderID  -- Liên kết với OrderPassenger để lấy thông tin hành khách
JOIN Nation n ON op.nationID = n.id  -- Lấy quốc tịch từ bảng Nation
WHERE t.orderID = 'ORD002';

SELECT 
    t.id AS ticketId, 
    t.status AS ticketStatus, 
    o.id AS orderId, 
    o.customerID, 
    o.staffID, 
    o.status AS orderStatus, 
    o.time, 
    o.finalPrice, 
    o.finalNum, 
    f.id AS flightId, 
    f.name AS flightName, 
    f.code, 
    f.airplaneID, 
    a.name AS airplaneName, 
    dep.name AS departure,  
    des.name AS destination, 
    f.entryTime, 
    f.startingTime, 
    f.landingTime, 
    s.id AS seatId, 
    s.status AS seatStatus, 
    s.reason, 
    op.fullName AS passengerName, 
    n.name AS nationName 
FROM Ticket t 
JOIN `Order` o ON t.orderID = o.id 
JOIN Flight f ON t.flightID = f.id 
JOIN Seat s ON t.seatID = s.id 
JOIN Location dep ON f.departure = dep.id 
JOIN Location des ON f.destination = des.id 
JOIN Airplane a ON f.airplaneID = a.id 
JOIN OrderPassenger op ON op.orderID = o.id 
JOIN Nation n ON op.nationID = n.id 
WHERE t.orderID ='ORD003'
GROUP BY t.id, op.fullName, op.nationID;

UPDATE `Ticket` SET status = 'Confirmed' WHERE orderPID = 'ORD002-1';

UPDATE Ticket
SET status = 'Confirmed'
WHERE orderID = 'ORD004';


Select * from `Order`;
SELECT id FROM OrderPassenger;

SELECT o.*
FROM `OrderPassenger` op
JOIN `Order` o ON op.orderID = o.id
WHERE op.id = 'ORD002-2' ;

SELECT t.id AS ticketID, t.flightID, t.seatID, t.status,
       o.id AS orderID, o.status AS orderStatus, o.time, o.finalPrice
FROM Ticket t
JOIN `Order` o ON t.orderID = o.id
WHERE o.customerID = '1f0d2653-0a7e-11f0-a521-dda8ae72319d';  -- Thay bằng ID của khách hàng hiện tại



SELECT o.id, o.customerID, o.staffID, o.status, o.time, COUNT(t.id) AS finalNum
FROM `Order` o
LEFT JOIN OrderPassenger op ON o.id = op.orderID
LEFT JOIN Ticket t ON op.id = t.orderPID
WHERE o.customerID = '1b6660ae-0a8b-11f0-a521-dda8ae72319d'
GROUP BY o.id, o.customerID, o.staffID, o.status, o.time
ORDER BY o.time DESC;

SELECT 
    t.id AS ticketId, 
    t.status AS ticketStatus, 
    o.id AS orderId, 
    o.customerID, 
    o.staffID, 
    o.status AS orderStatus, 
    o.time, 
    o.finalPrice, 
    o.finalNum, 
    f.id AS flightId, 
    f.name AS flightName, 
    f.code, 
    f.airplaneID, 
    a.name AS airplaneName, -- Lấy tên máy bay từ bảng Airplane
    dep.name AS departure,  -- Lấy tên địa điểm thay vì ID
    des.name AS destination, -- Lấy tên địa điểm thay vì ID
    f.entryTime, 
    f.startingTime, 
    f.landingTime, 
    s.id AS seatId, 
    s.status AS seatStatus, 
    s.reason 
FROM Ticket t 
JOIN OrderPassenger op ON t.orderPID = op.id  -- Thay orderID bằng orderPID để lấy theo OrderPassenger
JOIN `Order` o ON op.orderID = o.id 
JOIN Flight f ON t.flightID = f.id 
JOIN Seat s ON t.seatID = s.id 
JOIN Location dep ON f.departure = dep.id  -- Thay ID bằng tên
JOIN Location des ON f.destination = des.id -- Thay ID bằng tên
JOIN Airplane a ON f.airplaneID = a.id -- JOIN với Airplane để lấy tên máy bay
WHERE op.id = 'ORD002-1';  -- Lọc theo OrderPassenger.id

SELECT 
    t.id AS ticketId, 
    t.status AS ticketStatus, 
    o.id AS orderId, 
    o.customerID, 
    o.staffID, 
    o.status AS orderStatus, 
    o.time, 
    o.finalPrice, 
    o.finalNum, 
    f.id AS flightId, 
    f.name AS flightName, 
    f.code, 
    f.airplaneID, 
    a.name AS airplaneName, -- Lấy tên máy bay từ bảng Airplane
    dep.name AS departure,  -- Lấy tên địa điểm thay vì ID
    des.name AS destination, -- Lấy tên địa điểm thay vì ID
    f.entryTime, 
    f.startingTime, 
    f.landingTime, 
    f.price, -- Thêm giá của chuyến bay
    s.id AS seatId, 
    s.status AS seatStatus, 
    s.reason 
FROM Ticket t 
JOIN OrderPassenger op ON t.orderPID = op.id  -- Thay orderID bằng orderPID để lấy theo OrderPassenger
JOIN `Order` o ON op.orderID = o.id 
JOIN Flight f ON t.flightID = f.id 
JOIN Seat s ON t.seatID = s.id 
JOIN Location dep ON f.departure = dep.id  -- Thay ID bằng tên
JOIN Location des ON f.destination = des.id -- Thay ID bằng tên
JOIN Airplane a ON f.airplaneID = a.id -- JOIN với Airplane để lấy tên máy bay
WHERE op.id = 'ORD002-1';  -- Lọc theo OrderPassenger.id

SELECT 
    t.id AS ticketId, 
    t.status AS ticketStatus, 
    o.id AS orderId, 
    o.customerID, 
    o.staffID, 
    o.status AS orderStatus, 
    o.time, 
    o.finalPrice, 
    o.finalNum, 
    o.type, 
    tt.type AS ticketType,  -- Thêm trường này để gán vào TicketType
    tt.description, 
    tt.percent, 
    tt.checkedweightneed, 
    tt.handedweightneed, 
    f.id AS flightId, 
    f.name AS flightName, 
    f.code, 
    f.airplaneID, 
    f.price,  -- Thêm cột price từ bảng Flight
    a.name AS airplaneName,  -- Lấy tên máy bay từ bảng Airplane
    dep.name AS departure,  -- Lấy tên địa điểm thay vì ID
    des.name AS destination, -- Lấy tên địa điểm thay vì ID
    f.entryTime, 
    f.startingTime, 
    f.landingTime, 
    s.id AS seatId, 
    s.status AS seatStatus, 
    s.reason 
FROM Ticket t 
JOIN OrderPassenger op ON t.orderPID = op.id  -- Thay orderID bằng orderPID để lấy theo OrderPassenger
JOIN `Order` o ON op.orderID = o.id 
JOIN TicketType tt ON o.type = tt.type 
JOIN Flight f ON t.flightID = f.id 
JOIN Seat s ON t.seatID = s.id 
JOIN Location dep ON f.departure = dep.id  -- Thay ID bằng tên
JOIN Location des ON f.destination = des.id -- Thay ID bằng tên
JOIN Airplane a ON f.airplaneID = a.id -- JOIN với Airplane để lấy tên máy bay
WHERE op.id = 'ORD002-1';  -- Lọc theo OrderPassenger.id

SELECT 
    t.id AS ticketId, 
    t.status AS ticketStatus, 
    o.id AS orderId, 
    o.customerID, 
    o.staffID, 
    o.status AS orderStatus, 
    o.time, 
    o.finalPrice, 
    o.finalNum, 
    o.type, 
    tt.type AS ticketType,  -- Thêm trường này để gán vào TicketType
    tt.description, 
    tt.percent, 
    tt.checkedweightneed, 
    tt.handedweightneed, 
    f.id AS flightId, 
    f.name AS flightName, 
    f.code, 
    f.airplaneID, 
    f.price,  -- Thêm cột price từ bảng Flight
    a.name AS airplaneName,  -- Lấy tên máy bay từ bảng Airplane
    dep.name AS departure,  -- Lấy tên địa điểm thay vì ID
    des.name AS destination, -- Lấy tên địa điểm thay vì ID
    f.entryTime, 
    f.startingTime, 
    f.landingTime, 
    s.id AS seatId, 
    s.status AS seatStatus, 
    s.reason 
FROM Ticket t 
JOIN OrderPassenger op ON t.orderPID = op.id  -- Thay orderID bằng orderPID để lấy theo OrderPassenger
JOIN `Order` o ON op.orderID = o.id 
JOIN TicketType tt ON o.type = tt.type 
JOIN Flight f ON t.flightID = f.id 
JOIN Seat s ON t.seatID = s.id 
JOIN Location dep ON f.departure = dep.id  -- Thay ID bằng tên
JOIN Location des ON f.destination = des.id -- Thay ID bằng tên
JOIN Airplane a ON f.airplaneID = a.id -- JOIN với Airplane để lấy tên máy bay
WHERE op.id = 'ORD002-1';

SELECT * FROM Ticket WHERE status = 'Cancelled' OR status = 'Processing';
