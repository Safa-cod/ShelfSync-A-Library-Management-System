
CREATE DATABASE IF NOT EXISTS shelfsync;
USE shelfsync;

CREATE TABLE IF NOT EXISTS books (

    book_id INT AUTO_INCREMENT PRIMARY KEY,

    title VARCHAR(100) NOT NULL,

    author VARCHAR(100) NOT NULL,

    isbn VARCHAR(50),

    genre VARCHAR(50),

    total_qty INT NOT NULL,

    available_qty INT NOT NULL

);
