INSERT INTO Customer VALUES (NULL), (NULL), (NULL), (NULL), (NULL);
INSERT INTO Administrator VALUES (NULL, NULL), (NULL, NULL), (NULL, NULL), (NULL, NULL), (NULL, NULL);
INSERT INTO Staff VALUES (NULL, NOW()), (NULL, NOW()), (NULL, NOW()), (NULL, NOW()), (NULL, NOW());
INSERT INTO AirTrafficControl VALUES (NULL, 'ABC', NOW()), (NULL, 'DEF', NOW()), (NULL, 'GHI', NOW()), (NULL, 'JKL', NOW()), (NULL, 'MNO', NOW());
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

-- Insert into Type
INSERT INTO Type (id, Name, manufacture, length, weight, height, atcID) VALUES
('T1', 'Boeing 747', 'Boeing', 70.60, 183500, 19.40, 'ATC1'),
('T2', 'Airbus A320', 'Airbus', 37.57, 73500, 11.76, 'ATC2');

-- Insert into Airplane
INSERT INTO Airplane (id, name, typeID, statusID, maintainanceTime, usedTime, atcID) VALUES
(NULL, 'Boeing 747', 'T1', 1, '2024-01-15 10:00:00', '2023-12-10 08:00:00', 'ATC1'),
(NULL, 'Airbus A320', 'T2', 2, '2024-02-20 15:30:00', '2023-11-20 12:00:00', 'ATC2');

-- Insert into Compartment
INSERT INTO Compartment (id, name, typeID, capacity) VALUES
('A', 'First Class', 'T1', 20),
('B', 'Business Class', 'T1', 50),
('C', 'Economy Class', 'T2', 150),
('D', 'Premium Economy', 'T2', 100);

-- Insert into Flight
INSERT INTO Flight (id, name, code, airplaneID, departure, destination, entryTime, startingTime, landingTime, atcID) VALUES
(NULL, 'Flight 101', 'FL101', 'PL1', 'Hanoi', 'Ho Chi Minh City', '2024-03-10 08:00:00', '2024-03-10 09:00:00', '2024-03-10 11:00:00', 'ATC1'),
(NULL, 'Flight 202', 'FL202', 'PL2', 'Da Nang', 'Singapore', '2024-04-15 10:30:00', '2024-04-15 11:30:00', '2024-04-15 14:00:00', 'ATC2');

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
('O1', 'S1', (SELECT id FROM `Order` ORDER BY time DESC LIMIT 1), 'F1', 'S1', 'Normal', 200000.00, 'Booked'),
('O2', 'S2', (SELECT id FROM `Order` ORDER BY time DESC LIMIT 1 OFFSET 1), 'F2', 'S2', 'VIP', 500000.00, 'Confirmed');

-- Insert into Luggage
INSERT INTO Luggage (id, customerID, orderID, type, weight) VALUES
('O1', 'C1', (SELECT id FROM `Order` ORDER BY time DESC LIMIT 1), 'Checked', 20.5),
('O2', 'C2', (SELECT id FROM `Order` ORDER BY time DESC LIMIT 1 OFFSET 1), 'Cabin', 7.0);