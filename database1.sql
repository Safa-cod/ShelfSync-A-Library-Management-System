-- ================= DATABASE =================
CREATE DATABASE IF NOT EXISTS shelfsync;
USE shelfsync;

-- ================= MEMBERS TABLE =================
CREATE TABLE IF NOT EXISTS members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20)
);

-- ================= BOOKS TABLE =================
CREATE TABLE IF NOT EXISTS books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100),
    isbn VARCHAR(50),
    genre VARCHAR(50),
    total_qty INT DEFAULT 0,
    available_qty INT DEFAULT 0
);

-- ================= TRANSACTIONS TABLE =================
CREATE TABLE IF NOT EXISTS transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    issue_date DATE,
    due_date DATE,
    return_date DATE DEFAULT NULL,
    status VARCHAR(20) DEFAULT 'Issued',

    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- ================= FINES TABLE =================
CREATE TABLE IF NOT EXISTS fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    transaction_id INT,
    amount DECIMAL(10,2) DEFAULT 0,
    paid VARCHAR(10) DEFAULT 'No',

    FOREIGN KEY (transaction_id)
    REFERENCES transactions(transaction_id)
);

-- ================= SAMPLE DATA =================
INSERT INTO members (name, email, phone) VALUES
('Rahim', 'rahim@gmail.com', '01700000001'),
('Karim', 'karim@gmail.com', '01700000002');

INSERT INTO books (title, author, isbn, genre, total_qty, available_qty) VALUES
('Python Basics', 'John Doe', '1111', 'Programming', 5, 5),
('Database System', 'Smith', '2222', 'DBMS', 3, 3);