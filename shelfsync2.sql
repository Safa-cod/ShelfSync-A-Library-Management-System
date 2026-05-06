--  MEMBERS TABLE
CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20)
);
--  BOOKS TABLE
-- (Required for issue/return)
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100),
    isbn VARCHAR(50) UNIQUE,
    genre VARCHAR(50),
    total_qty INT NOT NULL,
    available_qty INT NOT NULL
);
-- TRANSACTIONS TABLE
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    book_id INT NOT NULL,

    issue_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    due_date DATETIME,
    return_date DATETIME NULL,

    status VARCHAR(20) DEFAULT 'Issued',
-- Relationships
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
        ON DELETE CASCADE,

    FOREIGN KEY (book_id) REFERENCES Books(book_id)
        ON DELETE CASCADE
);
