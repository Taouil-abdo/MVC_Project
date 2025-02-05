-- Drop and create the database
DROP DATABASE IF EXISTS mvc_db;
CREATE DATABASE mvc_db;

-- Use the database
USE mvc_db;

-- Create users table
CREATE TABLE users (
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    bio TEXT,
    profile_picture VARCHAR(255),
    role ENUM('admin', 'author', 'user') NOT NULL DEFAULT 'user'
);

-- Create categories table
CREATE TABLE categories (
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    categorie_name VARCHAR(255) NOT NULL UNIQUE
);

-- Create articles table with foreign keys
CREATE TABLE articles (
    id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    featured_image VARCHAR(255),
    status ENUM('draft', 'published', 'scheduled') NOT NULL DEFAULT 'draft',
    scheduled_date DATETIME NULL,
    category_id BIGINT UNSIGNED NOT NULL,
    author_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_articles_category (category_id),
    INDEX idx_articles_author (author_id),
    INDEX idx_articles_status_date (status, scheduled_date),
    CONSTRAINT fk_articles_category FOREIGN KEY (category_id) 
        REFERENCES categories (id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_articles_author FOREIGN KEY (author_id) 
        REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert data into users table
INSERT INTO users (username, email, password_hash, bio, profile_picture, role) VALUES
('john_doe', 'john.doe@example.com', 'hashedpassword1', 'Software developer with a passion for open-source projects.', 'john_doe.jpg', 'admin'),
('jane_smith', 'jane.smith@example.com', 'hashedpassword2', 'Freelance writer specializing in technology and health.', 'jane_smith.jpg', 'author'),
('alice_jones', 'alice.jones@example.com', 'hashedpassword3', 'Data scientist focusing on machine learning and AI.', 'alice_jones.jpg', 'user'),
('bob_brown', 'bob.brown@example.com', 'hashedpassword4', 'Educator with a background in science and mathematics.', 'bob_brown.jpg', 'user'),
('charlie_green', 'charlie.green@example.com', 'hashedpassword5', 'Film critic and movie enthusiast.', 'charlie_green.jpg', 'user');

-- Insert data into categories table
INSERT INTO categories (categorie_name) VALUES
('Technology'),
('Health & Wellness'),
('Science'),
('Education'),
('Entertainment');

-- Insert data into articles table
INSERT INTO articles (title, content, featured_image, status, scheduled_date, category_id, author_id) VALUES
('The Future of AI in Healthcare', 'AI healthcare innovations', 'ai_healthcare.jpg', 'published', NULL, 1, 1),
('Improve your lifestyle with these health tips.', 'Healthy lifestyle tips', 'health_tips.jpg', 'draft', NULL, 2, 2),
('Learn about the fundamentals of machine learning algorithms.', 'Machine Learning algorithms explained', 'ml_algorithms.jpg', 'scheduled', '2024-12-30 10:00:00', 3, 3),
('Why STEM education matters for the future.', 'STEM education importance', 'stem_education.jpg', 'published', NULL, 4, 4),
('A review of the best movies of 2023.', 'Best movies of 2023 review', 'best_movies_2023.jpg', 'draft', NULL, 5, 5);
