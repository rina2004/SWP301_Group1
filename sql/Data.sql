INSERT INTO Customer VALUES (NULL), (NULL), (NULL), (NULL), (NULL);
INSERT INTO Administrator VALUES (NULL, NULL), (NULL, NULL), (NULL, NULL), (NULL, NULL), (NULL, NULL);
INSERT INTO Staff VALUES (NULL, NOW()), (NULL, NOW()), (NULL, NOW()), (NULL, NOW()), (NULL, NOW());
INSERT INTO AirTrafficControl VALUES (NULL, 'ABC', NOW()), (NULL, 'DEF', NOW()), (NULL, 'GHI', NOW()), (NULL, 'JKL', NOW()), (NULL, 'MNO', NOW());
INSERT INTO airplane_status (name) VALUES 
('Active'), ('Maintenance'), ('Retired'), ('In Use'), ('Under Repair');
INSERT INTO Blog_Category (name) VALUES 
('Travel'), ('Aviation'), ('News'), ('Technology'), ('Lifestyle');

-- Insert into Blog
INSERT INTO Blog (id, title, categoryID, image, description) VALUES
('B1', 'Top 10 Travel Destinations', 1, 'travel.jpg', 'Explore the best places to visit in 2024.'),
('B2', 'How Planes Are Maintained', 2, 'maintenance.jpg', 'A look into airplane maintenance procedures.');

-- Insert into Role
INSERT INTO Role (name, adminID) VALUES 
('Super Admin', 'ADMIN1'), 
('Manager', 'ADMIN2'), 
('Operator', 'ADMIN3'), 
('Technician', 'ADMIN4'), 
('Support', 'ADMIN5');

-- Insert into Account
INSERT INTO Account (username, password, roleID, id, citizenID, name, dob, phone, address, email, adminID) VALUES
('admin1', 'pass123', 1, NULL, '123456789012', 'John Doe', '1990-05-15', '0987654321', '123 Street, City', 'john@example.com', 'ADMIN1'),
('admin2', 'pass123', 2, NULL, '123456789013', 'Jane Smith', '1985-08-21', '0976543210', '456 Avenue, City', 'jane@example.com', 'ADMIN2');

-- Insert into Type
INSERT INTO Type (id, Name, manufacture, length, weight, height, atcID) VALUES
('T1', 'Boeing 747', 'Boeing', 70.60, 183500, 19.40, 'ATC1'),
('T2', 'Airbus A320', 'Airbus', 37.57, 73500, 11.76, 'ATC2'),
('T3', 'Ginger N666', 'Ginger', 66.66, 666666, 66.06, 'ATC3');

-- Insert into Airplane
INSERT INTO Airplane (id, name, typeID, statusID, maintainanceTime, usedTime, atcID) VALUES
(NULL, 'Boeing 747', 'T1', 1, '2024-01-15 10:00:00', '2023-12-10 08:00:00', 'ATC1'),
(NULL, 'Airbus A320', 'T2', 2, '2024-02-20 15:30:00', '2023-11-20 12:00:00', 'ATC2'),
(NULL, 'Ginger N666', 'T2', 2, '2024-02-23 07:30:00', '2023-11-25 12:00:00', 'ATC3');

-- Insert into Compartment
INSERT INTO Compartment (id, name, typeID, capacity) VALUES
('A', 'First Class', 'T1', 20),
('B', 'Business Class', 'T1', 50),
('C', 'Economy Class', 'T2', 150),
('D', 'Premium Economy', 'T2', 100);

-- Insert into Flight
INSERT INTO Flight (id, name, code, airplaneID, departure, destination, entryTime, startingTime, landingTime, atcID) VALUES
(NULL, 'Flight 101', 'FL101', 'PL1', 'Hanoi', 'Ho Chi Minh City', '2024-03-10 08:00:00', '2024-03-10 09:00:00', '2024-03-10 11:00:00', 'ATC1'),
(NULL, 'Flight 102', 'FL102', 'PL1', 'Da Nang', 'Singapore', '2024-04-15 10:30:00', '2024-04-15 11:30:00', '2024-04-15 14:00:00', 'ATC2'),
(NULL, 'Flight 201', 'FL201', 'PL2', 'Africa', 'Rung Pac Po', '2025-02-12 11:10:00', '2025-02-12 11:30:00', '2025-02-12 21:30:00', 'ATC1'),
(NULL, 'Flight 202', 'FL202', 'PL2', 'Ohio Gyatt', 'Sigma', '2024-04-18 10:30:00', '2024-04-18 11:30:00', '2024-04-20 14:00:00', 'ATC1'),
(NULL, 'Flight 301', 'FL301', 'PL', 'Africa', 'Rung Pac Po', '2025-02-12 11:10:00', '2025-02-12 11:30:00', '2025-02-12 21:30:00', 'ATC2');

-- Insert into Seat
INSERT INTO Seat (id, compartmentID, available) VALUES
('S1', 'A', TRUE),
('S2', 'B', TRUE),
('S3', 'C', TRUE),
('S4', 'D', FALSE);

INSERT INTO `Order` (id, customerID, staffID, status, time) VALUES  
('O1', 'C1', 'S1', 'Pending', NOW()),  
('O2', 'C2', 'S2', 'Completed', NOW());

INSERT INTO Ticket (id, staffID, orderID, flightID, seatID, type, Price, Status) 
VALUES 
('O1', 'S1', (SELECT id FROM `Order` ORDER BY time DESC LIMIT 1), 'F1', 'S1', 'Economy', 200.00, 'Booked'),
('O2', 'S2', (SELECT id FROM `Order` ORDER BY time DESC LIMIT 1 OFFSET 1), 'F2', 'S2', 'Business', 500.00, 'Confirmed');

-- Insert into Luggage
INSERT INTO Luggage (id, customerID, orderID, type, weight) VALUES
('O1', 'C1', (SELECT id FROM `Order` ORDER BY time DESC LIMIT 1), 'Checked', 20.5),
('O2', 'C2', (SELECT id FROM `Order` ORDER BY time DESC LIMIT 1 OFFSET 1), 'Cabin', 7.0);
