INSERT INTO Customer VALUES (NULL), (NULL), (NULL), (NULL), (NULL);
INSERT INTO Administrator VALUES (NULL, NULL), (NULL, NULL), (NULL, NULL), (NULL, NULL), (NULL, NULL);
INSERT INTO Staff VALUES (NULL, NOW()), (NULL, NOW()), (NULL, NOW()), (NULL, NOW()), (NULL, NOW());
INSERT INTO AirTrafficControl VALUES (NULL, NOW()), (NULL, NOW()), (NULL, NOW()), (NULL, NOW()), (NULL, NOW());
INSERT INTO airplane_status (name) VALUES 
('Active'), ('Maintenance'), ('Retired'), ('In Use'), ('Under Repair');

-- Insert into Role
INSERT INTO Role (name) VALUES 
('Super Admin'), 
('Manager'), 
('Operator'), 
('Technician'), 
('Support');

-- Insert into Account
INSERT INTO Account (username, password, citizenID, name, dob, phone, address, email) VALUES
('admin1', 'pass123', '123456789012', 'John Doe', '1990-05-15', '0987654321', '123 Street, City', 'john@example.com'),
('admin2', 'pass123', '123456789013', 'Jane Smith', '1985-08-21', '0976543210', '456 Avenue, City', 'jane@example.com');

-- Insert dữ liệu cho bảng Role
-- INSERT INTO Role (name) VALUES 
-- ('Admin'), ('Staff'), ('Customer');

-- Insert dữ liệu cho bảng Account
-- INSERT INTO Account (username, password, citizenID, name, dob, phone, address, email) VALUES 
-- ('admin01', 'password', '123456789012', 'Admin User', '1985-06-15', '0123456789', 'Hanoi', 'admin@example.com'),
-- ('staff01', 'password', '234567890123', 'Staff User', '1990-08-22', '0987654321', 'HCM City', 'staff@example.com'),
-- ('customer01', 'password', '345678901234', 'Customer User', '1995-03-10', '0901234567', 'Da Nang', 'customer@example.com');

-- Insert dữ liệu cho bảng AccountUserRole
-- INSERT INTO AccountUserRole (accountID, entityID, roleID) VALUES 
-- ('admin01', 1, 1),
-- ('staff01', 2, 2),
-- ('customer01', 3, 3);

-- Insert dữ liệu cho bảng Administrator
-- INSERT INTO Administrator (id, roleID) VALUES 
-- ('admin01', 1);


-- Insert dữ liệu cho bảng Staff
-- INSERT INTO Staff (id, createdDate) VALUES 
-- ('staff01', '2023-05-01 09:00:00');

-- Insert dữ liệu cho bảng AirTrafficControl
-- INSERT INTO AirTrafficControl (id, name, createdDate) VALUES 
-- ('ATC001', 'Control Tower 1', '2023-01-01 08:00:00');

-- Insert dữ liệu cho bảng Type
-- INSERT INTO Type (id, Name, manufacture, length, weight, height, atcID) VALUES 
-- ('TYP001', 'Boeing 737', 'Boeing', 39.5, 41.4, 12.5, 'ATC001');
-- Insert into Flight
INSERT INTO Flight (id, name, code, airplaneID, departure, destination, entryTime, startingTime, landingTime, atcID) VALUES
(NULL, 'Flight 101', 'FL101', 'PL1', 'Hanoi', 'Ho Chi Minh City', '2024-03-10 08:00:00', '2025-03-10 09:00:00', '2025-03-10 11:00:00', 'ATC1'),
(NULL, 'Flight 202', 'FL202', 'PL2', 'Da Nang', 'Singapore', '2024-04-15 10:30:00', '2025-04-15 11:30:00', '2025-04-15 14:00:00', 'ATC2');
-- Insert dữ liệu cho bảng Compartment
-- INSERT INTO Compartment (id, name, typeID, capacity) VALUES 
-- ('C001', 'Business Class', 'TYP001', 50);

-- Insert dữ liệu cho bảng Airplane_Status
-- INSERT INTO Airplane_Status (name) VALUES 
-- ('Available'), ('Maintenance'), ('In Use');

-- Insert dữ liệu cho bảng Airplane
-- INSERT INTO Airplane (id, name, typeID, statusID, maintainanceTime, usedTime, atcID) VALUES 
-- ('PL001', 'Plane 001', 'TYP001', 1, '2024-02-01 10:00:00', '2024-02-15 10:00:00', 'ATC001');

INSERT INTO Ticket (id, staffID, orderID, flightID, seatID, type, Price, Status) 
VALUES 
('O1', 'S1', (SELECT id FROM `Order` ORDER BY time DESC LIMIT 1), 'F1', 'S1', 'Normal', 200000.00, 'Booked'),
('O2', 'S2', (SELECT id FROM `Order` ORDER BY time DESC LIMIT 1 OFFSET 1), 'F2', 'S2', 'VIP', 500000.00, 'Confirmed');

-- Insert into Luggage
INSERT INTO Luggage (id, customerID, orderID, type, weight) VALUES
('O1', 'C1', (SELECT id FROM `Order` ORDER BY time DESC LIMIT 1), 'Checked', 20.5),
('O2', 'C2', (SELECT id FROM `Order` ORDER BY time DESC LIMIT 1 OFFSET 1), 'Cabin', 7.0);

-- Insert dữ liệu cho bảng Flight
-- INSERT INTO Flight (id, name, code, airplaneID, departure, destination, entryTime, startingTime, landingTime, atcID) VALUES 
-- ('FL001', 'Hanoi to HCM', 'VN123', 'PL001', 'Hanoi', 'HCM City', '2024-02-25 06:00:00', '2024-02-25 07:00:00', '2024-02-25 09:00:00', 'ATC001');

-- Insert dữ liệu cho bảng Seat
-- INSERT INTO Seat (id, compartmentID, available) VALUES 
-- ('S001', 'C001', TRUE);

-- Insert dữ liệu cho bảng Order
-- INSERT INTO Order (id, customerID, staffID, status, time) VALUES 
-- ('O001', 'customer01', 'staff01', 'Confirmed', '2024-02-20 14:30:00');

-- Insert dữ liệu cho bảng Ticket
-- INSERT INTO Ticket (id, staffID, orderID, flightID, seatID, type, Price, Status) VALUES 
-- ('T001', 'staff01', 'O001', 'FL001', 'S001', 'Economy', 150.00, 'Booked');

-- Insert dữ liệu cho bảng Luggage
-- INSERT INTO Luggage (id, customerID, orderID, type, weight) VALUES 
-- ('L001', 'customer01', 'O001', 'Checked', 20.5);

-- Insert dữ liệu cho bảng BlogCategory
-- INSERT INTO BlogCategory (name) VALUES 
-- ('Technology'), ('Aviation'), ('Travel');

-- Insert dữ liệu cho bảng BlogPost
-- INSERT INTO BlogPost (title, content, image, authorID) VALUES 
-- ('Tech Innovations', 'Latest in aviation technology...', 'tech.jpg', '5394ac40-f85c-11ef-86fb-3c2c30e1270f'),
-- ('New Flight Routes', 'Exciting new travel destinations...', 'travel.jpg', '5394ac40-f85c-11ef-86fb-3c2c30e1270f'),
-- ('Pilot Training', 'Understanding the new pilot training process...', 'pilot.jpg', '5394ac40-f85c-11ef-86fb-3c2c30e1270f'),
-- ('Airplane Maintenance', 'How maintenance is conducted...', 'maintenance.jpg', '5394ac40-f85c-11ef-86fb-3c2c30e1270f'),
-- ('Flight Safety', 'Ensuring passenger safety...', 'safety.jpg', '5394ac40-f85c-11ef-86fb-3c2c30e1270f'),
-- ('Airport Operations', 'Behind the scenes at the airport...', 'operations.jpg', '5394ac40-f85c-11ef-86fb-3c2c30e1270f'),
-- ('Customer Experience', 'Enhancing customer journeys...', 'customer.jpg', '5394ac40-f85c-11ef-86fb-3c2c30e1270f');

-- Insert dữ liệu cho bảng Blog
INSERT INTO Blog (postID, title, description, image, categoryID) VALUES 
('POST-950d0b80-f86d-11ef-86fb-3c2c30e1270f', 'Tech Innovations', 'A deep dive into the latest aviation tech.', 'deal1.jpg', 1),
('POST-950d1027-f86d-11ef-86fb-3c2c30e1270f', 'New Flight Routes', 'Discover new airline routes worldwide.', 'deal2.jpg', 2),
('POST-950d116d-f86d-11ef-86fb-3c2c30e1270f', 'Pilot Training', 'How pilots are trained for modern aircraft.', 'deal3.jpg', 2),
('POST-950d12df-f86d-11ef-86fb-3c2c30e1270f', 'Airplane Maintenance', 'The crucial process of airplane maintenance.', 'deal4.jpg', 1),
('POST-950d1513-f86d-11ef-86fb-3c2c30e1270f', 'Flight Safety', 'Measures taken to ensure safe flights.', 'deal2.jpg', 2),
('POST-950d162f-f86d-11ef-86fb-3c2c30e1270f', 'Airport Operations', 'Insights into daily airport operations.', 'deal3.jpg', 3),
('POST-950d1729-f86d-11ef-86fb-3c2c30e1270f', 'Customer Experience', 'Improving passenger satisfaction in aviation.', 'deal1.jpg', 3);

-- Insert dữ liệu cho bảng Comment
INSERT INTO Comment (postID, accountID, content) VALUES 
('POST-950d0b80-f86d-11ef-86fb-3c2c30e1270f', '5394adb9-f85c-11ef-86fb-3c2c30e1270f', 'Great article!'),
('POST-950d1027-f86d-11ef-86fb-3c2c30e1270f', '5394adb9-f85c-11ef-86fb-3c2c30e1270f', 'Very informative!');

-- Insert dữ liệu cho bảng PostLike
INSERT INTO PostLike (postID, accountID) VALUES 
('POST-950d0b80-f86d-11ef-86fb-3c2c30e1270f', '5394adb9-f85c-11ef-86fb-3c2c30e1270f'),
('POST-950d1027-f86d-11ef-86fb-3c2c30e1270f', '5394adb9-f85c-11ef-86fb-3c2c30e1270f');