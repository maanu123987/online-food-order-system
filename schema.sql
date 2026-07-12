CREATE DATABASE IF NOT EXISTS food_order_system;
USE food_order_system;

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(20),
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS admins (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS categories (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS food_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  rating DECIMAL(2,1) DEFAULT 0.0,
  image_url VARCHAR(255),
  category_id INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS cart (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  food_id INT NOT NULL,
  quantity INT DEFAULT 1,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (food_id) REFERENCES food_items(id)
);

CREATE TABLE IF NOT EXISTS orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  delivery_address VARCHAR(255),
  phone VARCHAR(20),
  payment_method VARCHAR(50),
  status VARCHAR(50) DEFAULT 'Order Placed',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  food_id INT NOT NULL,
  quantity INT DEFAULT 1,
  price DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (food_id) REFERENCES food_items(id)
);

CREATE TABLE IF NOT EXISTS feedback (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  food_id INT NOT NULL,
  rating INT NOT NULL,
  comment TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (food_id) REFERENCES food_items(id)
);

INSERT INTO categories (name) VALUES ('Fast Food'), ('Desserts'), ('Drinks');

INSERT INTO food_items (name, description, price, rating, image_url, category_id) VALUES
('Burger', 'Juicy grilled burger with cheese.', 8.99, 4.8, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80', 1),
('Pizza', 'Crispy crust with rich tomato sauce.', 12.49, 4.9, 'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=800&q=80', 1),
('French Fries', 'Golden crispy fries with herb seasoning.', 4.49, 4.7, 'https://images.unsplash.com/photo-1576107232684-2cc3c0d8a3d5?auto=format&fit=crop&w=800&q=80', 1),
('Sandwich', 'Toasted bread with fresh vegetables.', 6.99, 4.6, 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?auto=format&fit=crop&w=800&q=80', 1),
('Pasta', 'Creamy pasta with basil and herbs.', 9.99, 4.8, 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?auto=format&fit=crop&w=800&q=80', 1),
('Cold Drinks', 'Chilled beverages for your meal.', 2.49, 4.5, 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?auto=format&fit=crop&w=800&q=80', 3);

INSERT INTO admins (name, email, password) VALUES ('Admin', 'admin@foodierush.com', '$2a$10$8Q5zQqB2B3fUqMZJx8D1l.4K9vJ8F2bQHq7dR7L9/0F4F6N5QfG4i');