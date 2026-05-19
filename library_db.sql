-- ============================================================
--  LibraryOS – MySQL Database Schema
--  Import this file via phpMyAdmin or the MySQL CLI
-- ============================================================

-- 1. Create & select the database
CREATE DATABASE IF NOT EXISTS library_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE library_db;

-- ============================================================
--  TABLE: users  (staff / admin accounts)
-- ============================================================
CREATE TABLE IF NOT EXISTS users (
    id          INT          NOT NULL AUTO_INCREMENT,
    username    VARCHAR(80)  NOT NULL UNIQUE,
    password    VARCHAR(64)  NOT NULL,          -- SHA-256 hex
    full_name   VARCHAR(150) NOT NULL,
    role        ENUM('admin','librarian') NOT NULL DEFAULT 'librarian',
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

-- Default admin account  (password = admin123)
INSERT INTO users (username, password, full_name, role)
SELECT 'admin',
       '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',
       'System Administrator',
       'admin'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'admin');


-- ============================================================
--  TABLE: members  (library card holders)
-- ============================================================
CREATE TABLE IF NOT EXISTS members (
    id              INT          NOT NULL AUTO_INCREMENT,
    member_id       VARCHAR(20)  NOT NULL UNIQUE,   -- e.g. LIB-00001
    full_name       VARCHAR(150) NOT NULL,
    email           VARCHAR(150),
    phone           VARCHAR(30),
    address         TEXT,
    membership_type ENUM('standard','premium','student') NOT NULL DEFAULT 'standard',
    status          ENUM('active','inactive','suspended') NOT NULL DEFAULT 'active',
    joined_date     DATE         NOT NULL DEFAULT (CURDATE()),
    expiry_date     DATE,
    notes           TEXT,
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
                                          ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB;


-- ============================================================
--  TABLE: books  (future extension)
-- ============================================================
CREATE TABLE IF NOT EXISTS books (
    id          INT          NOT NULL AUTO_INCREMENT,
    isbn        VARCHAR(20)  UNIQUE,
    title       VARCHAR(255) NOT NULL,
    author      VARCHAR(150),
    category    VARCHAR(80),
    copies      INT          NOT NULL DEFAULT 1,
    available   INT          NOT NULL DEFAULT 1,
    PRIMARY KEY (id)
) ENGINE=InnoDB;
