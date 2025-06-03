-- Create database
CREATE DATABASE IF NOT EXISTS shop_db;
USE shop_db;

-- Products table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL
);

-- Buyers table
CREATE TABLE buyers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    id_card VARCHAR(20) NOT NULL UNIQUE,
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert products
INSERT INTO products (product_name) VALUES
('Laptop'), ('Headphones'), ('Smartphone');

-- Insert buyers
INSERT INTO buyers (name, id_card, product_id) VALUES
('Carlos Pérez', '0102030405', 1),
('Ana Gómez', '0607080910', 3),
('Luis Torres', '1122334455', 2);

