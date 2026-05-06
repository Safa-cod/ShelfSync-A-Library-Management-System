CREATE DATABASE shelfsync;
USE shelfsync;

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    isbn VARCHAR(50),
    genre VARCHAR(50),
    total_qty INT,
    available_qty INT
);
