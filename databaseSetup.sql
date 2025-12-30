-- ========================================
-- Airplane Booking System - Database Setup
-- ========================================

-- Drop existing tables if they exist
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    role VARCHAR(10) DEFAULT 'user'
);

-- Create flights table
CREATE TABLE flights (
    flight_id VARCHAR(20) PRIMARY KEY,
    from_city VARCHAR(30) NOT NULL,
    to_city VARCHAR(30) NOT NULL,
    date VARCHAR(20) NOT NULL,
    seats_available INT NOT NULL,
    price INT NOT NULL
);

-- Create bookings table
CREATE TABLE bookings (
    booking_id VARCHAR(20) PRIMARY KEY,
    user_id INT NOT NULL,
    flight_id VARCHAR(20) NOT NULL,
    seats_booked INT NOT NULL,
    total_price INT NOT NULL,
    booking_date VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id) ON DELETE CASCADE
);

-- Insert sample admin user
-- Password: admin123 (in production, use hashed passwords!)
INSERT INTO users (name, email, password, role) VALUES 
('Admin User', 'admin@airbooking.com', 'admin123', 'admin');

-- Insert sample regular user
INSERT INTO users (name, email, password, role) VALUES 
('John Doe', 'john@example.com', 'user123', 'user');

-- Insert sample flights
INSERT INTO flights (flight_id, from_city, to_city, date, seats_available, price) VALUES 
('AI101', 'Mumbai', 'Delhi', '2025-01-15', 50, 3500),
('AI102', 'Delhi', 'Bangalore', '2025-01-16', 45, 4200),
('AI103', 'Bangalore', 'Kolkata', '2025-01-17', 30, 5000),
('AI104', 'Mumbai', 'Chennai', '2025-01-18', 40, 3800),
('AI105', 'Delhi', 'Hyderabad', '2025-01-19', 35, 4500),
('AI106', 'Chennai', 'Mumbai', '2025-01-20', 25, 3900),
('AI107', 'Kolkata', 'Delhi', '2025-01-21', 48, 4100),
('AI108', 'Hyderabad', 'Bangalore', '2025-01-22', 42, 3600);

-- Verify tables created
SELECT 'Users table' AS Table_Name, COUNT(*) AS Record_Count FROM users
UNION ALL
SELECT 'Flights table', COUNT(*) FROM flights
UNION ALL
SELECT 'Bookings table', COUNT(*) FROM bookings;