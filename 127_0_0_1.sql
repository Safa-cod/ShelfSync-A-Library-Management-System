-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2026 at 10:45 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aa`
--
CREATE DATABASE IF NOT EXISTS `aa` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `aa`;
--
-- Database: `abc`
--
CREATE DATABASE IF NOT EXISTS `abc` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `abc`;
--
-- Database: `abcd`
--
CREATE DATABASE IF NOT EXISTS `abcd` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `abcd`;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CustomerID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CustomerID`, `Name`, `Email`) VALUES
(1, 'Alice', 'alice@email.com'),
(2, 'Bob', 'bob@email.com'),
(3, 'Charlie', 'charlie@email.com'),
(4, 'Diana', 'diana@email.com'),
(5, 'Ethan', 'ethan@email.com');

-- --------------------------------------------------------

--
-- Table structure for table `orderitem`
--

CREATE TABLE `orderitem` (
  `OrderItemID` int(11) NOT NULL,
  `OrderID` int(11) DEFAULT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orderitem`
--

INSERT INTO `orderitem` (`OrderItemID`, `OrderID`, `ProductID`, `Quantity`) VALUES
(301, 101, 201, 1),
(302, 101, 202, 2),
(303, 102, 203, 1),
(304, 103, 204, 1),
(305, 104, 205, 3);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `OrderID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `OrderDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`OrderID`, `CustomerID`, `OrderDate`) VALUES
(101, 1, '2025-09-01'),
(102, 2, '2025-09-02'),
(103, 1, '2025-09-03'),
(104, 3, '2025-09-04'),
(105, 4, '2025-09-05');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `ProductID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`ProductID`, `Name`, `Price`) VALUES
(201, 'Laptop', 800.00),
(202, 'Mouse', 20.00),
(203, 'Keyboard', 35.00),
(204, 'Monitor', 150.00),
(205, 'Headset', 50.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CustomerID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `orderitem`
--
ALTER TABLE `orderitem`
  ADD PRIMARY KEY (`OrderItemID`),
  ADD KEY `OrderID` (`OrderID`),
  ADD KEY `ProductID` (`ProductID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `CustomerID` (`CustomerID`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`ProductID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orderitem`
--
ALTER TABLE `orderitem`
  ADD CONSTRAINT `orderitem_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
  ADD CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ProductID`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`);
--
-- Database: `b`
--
CREATE DATABASE IF NOT EXISTS `b` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `b`;
--
-- Database: `coffee_db`
--
CREATE DATABASE IF NOT EXISTS `coffee_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `coffee_db`;

-- --------------------------------------------------------

--
-- Table structure for table `coffee_db`
--

CREATE TABLE `coffee_db` (
  `Name` varchar(255) NOT NULL,
  `number` int(11) NOT NULL,
  `guests` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
--
-- Database: `coffe_db`
--
CREATE DATABASE IF NOT EXISTS `coffe_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `coffe_db`;

-- --------------------------------------------------------

--
-- Table structure for table `contact_form`
--

CREATE TABLE `contact_form` (
  `Name` varchar(255) NOT NULL,
  `number` varchar(11) NOT NULL,
  `guests` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
--
-- Database: `companydb`
--
CREATE DATABASE IF NOT EXISTS `companydb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `companydb`;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `dept_id` int(11) NOT NULL,
  `dept_name` varchar(50) NOT NULL,
  `location` varchar(50) DEFAULT NULL,
  `budget` int(11) DEFAULT NULL CHECK (`budget` >= 1000000)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`dept_id`);
--
-- Database: `companydbn`
--
CREATE DATABASE IF NOT EXISTS `companydbn` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `companydbn`;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `dept_id` int(11) NOT NULL,
  `dept_name` varchar(50) NOT NULL,
  `location` varchar(50) DEFAULT NULL,
  `budget` int(11) DEFAULT NULL CHECK (`budget` >= 100000)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`dept_id`, `dept_name`, `location`, `budget`) VALUES
(1, 'HR', 'Rajshahi', 700000),
(2, 'IT', 'Sylhet', 850000),
(3, 'Finance', 'Chittagong', 600000),
(4, 'Marketing', 'Dhaka', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`dept_id`);
--
-- Database: `database`
--
CREATE DATABASE IF NOT EXISTS `database` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `database`;

-- --------------------------------------------------------

--
-- Table structure for table `actor`
--

CREATE TABLE `actor` (
  `person_id` int(11) NOT NULL,
  `actor_name` varchar(40) DEFAULT NULL,
  `birth_year` year(4) DEFAULT NULL,
  `no_of_films` int(11) DEFAULT NULL,
  `no_of_awards` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `actor`
--

INSERT INTO `actor` (`person_id`, `actor_name`, `birth_year`, `no_of_films`, `no_of_awards`) VALUES
(4, 'Anjan Dutt', '1953', 39, 10),
(6, 'Goutam Ghose', '1950', 3, 1),
(7, 'Aparna Sen', '1945', 73, 43),
(8, 'Kaushik Ganguly', '1968', 22, 7),
(10, 'Soumitra Chatterjee', '1935', 250, 220),
(11, 'UTtam Kumar', '1926', 190, 150),
(12, 'Razzak', '1942', 120, 100);

-- --------------------------------------------------------

--
-- Table structure for table `director`
--

CREATE TABLE `director` (
  `person_id` int(11) NOT NULL,
  `director_name` varchar(40) DEFAULT NULL,
  `birth_year` year(4) DEFAULT NULL,
  `no_of_films` int(11) DEFAULT NULL,
  `no_of_awards` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `director`
--

INSERT INTO `director` (`person_id`, `director_name`, `birth_year`, `no_of_films`, `no_of_awards`) VALUES
(1, 'Zahir Raihan', '1935', 5, 5),
(2, 'Rajkumar Hirani', '1962', 5, 9),
(3, 'Saytajit Ray', '1921', 45, 55),
(4, 'Anjan Dutt', '1953', 23, 17),
(5, 'Rituparno Ghosh', '1963', 20, 15),
(6, 'Goutam Ghose', '1950', 12, 8),
(7, 'Aparna Sen', '1945', 12, 7),
(8, 'Kaushik Ganguly', '1968', 23, 30);

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `movie_id` int(11) NOT NULL,
  `movie_name` varchar(50) DEFAULT NULL,
  `genre` varchar(50) DEFAULT NULL,
  `year` year(4) DEFAULT NULL,
  `imdb_rating` float(2,1) DEFAULT NULL,
  `director_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie`
--

INSERT INTO `movie` (`movie_id`, `movie_name`, `genre`, `year`, `imdb_rating`, `director_id`) VALUES
(1, 'Pather Panchali', 'Drama', '1955', 8.5, 3),
(2, 'Noukadubi', 'Drama', '2011', 7.6, 5),
(3, 'Abohomaan', 'Drama', '2009', 7.3, 5),
(4, 'Joi Baba Felunath', 'Thriller', '1979', 8.0, 3),
(5, 'Jibon Theke Neya', 'Drama', '1970', 9.4, 1),
(6, 'Moner Manush', 'Biography', '2010', 8.0, 6),
(7, 'Apur Panchali', 'Biography', '2013', 8.2, 8),
(8, 'Goynar Baksho', 'Comdey', '2013', 7.1, 7),
(9, 'Byomkesh O Agnibaan', 'Thriller', '2017', 7.4, 4),
(10, 'Byomkesh Bakshi', 'Thriller', '2010', 7.4, 4),
(11, 'PK', 'Fiction', '2014', 8.2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `movie_characters`
--

CREATE TABLE `movie_characters` (
  `character_id` int(11) NOT NULL,
  `character_name` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie_characters`
--

INSERT INTO `movie_characters` (`character_id`, `character_name`, `age`) VALUES
(1, 'Apu', 7),
(2, 'Durga', 10),
(3, 'Harihar', 42),
(4, 'Sarbajaya', 35),
(5, 'Ramesh', 28),
(6, 'Hemnalini', 25),
(7, 'Nalinaksha', 30),
(8, 'Kamala', 20),
(9, 'Shikha', 21),
(10, 'Apratim', 26),
(11, 'Feluda', 25),
(12, 'Maganlal Meghraj', 35),
(13, 'Jatayu', 45),
(14, 'Topshe', 18),
(15, 'Ruku', 6),
(16, 'Faruk', 22),
(17, 'Bithi', 19),
(18, 'Sathi', 24),
(19, 'Lalon', NULL),
(20, 'Kaluah', 25),
(21, 'Siraj Saain', 45),
(22, 'Komli', 25),
(23, 'Subir Banerjee', NULL),
(24, 'Ashima', 24),
(25, 'Rashmoni', NULL),
(26, 'Somalata', 24),
(27, 'Chaitali', 18),
(28, 'Byomkesh Bakshi', 26),
(29, 'Ajit', 27),
(30, 'Malati', 16),
(31, 'Debkumar', 50),
(32, 'Doctor Anukul', 45),
(33, 'Prabhat', 27),
(34, 'Satyabati', 22),
(35, 'Anadi Babu', 55),
(36, 'PK', NULL),
(37, 'Jaggu', 26),
(38, 'Sarfaraz', 29),
(39, 'Tapasvi Maharaj', 50);

-- --------------------------------------------------------

--
-- Table structure for table `movie_character_relationship`
--

CREATE TABLE `movie_character_relationship` (
  `character_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie_character_relationship`
--

INSERT INTO `movie_character_relationship` (`character_id`, `movie_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 3),
(10, 3),
(11, 4),
(12, 4),
(13, 4),
(14, 4),
(15, 4),
(16, 5),
(17, 5),
(18, 5),
(19, 6),
(20, 6),
(21, 6),
(22, 6),
(23, 7),
(24, 7),
(25, 8),
(26, 8),
(27, 8),
(28, 9),
(28, 10),
(29, 9),
(29, 10),
(30, 9),
(31, 9),
(32, 9),
(33, 10),
(34, 9),
(34, 10),
(35, 10),
(36, 11),
(37, 11),
(38, 11),
(39, 11);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actor`
--
ALTER TABLE `actor`
  ADD PRIMARY KEY (`person_id`);

--
-- Indexes for table `director`
--
ALTER TABLE `director`
  ADD PRIMARY KEY (`person_id`);

--
-- Indexes for table `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`movie_id`),
  ADD KEY `director_id` (`director_id`);

--
-- Indexes for table `movie_characters`
--
ALTER TABLE `movie_characters`
  ADD PRIMARY KEY (`character_id`);

--
-- Indexes for table `movie_character_relationship`
--
ALTER TABLE `movie_character_relationship`
  ADD PRIMARY KEY (`character_id`,`movie_id`),
  ADD KEY `movie_id` (`movie_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `movie`
--
ALTER TABLE `movie`
  ADD CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`director_id`) REFERENCES `director` (`person_id`);

--
-- Constraints for table `movie_character_relationship`
--
ALTER TABLE `movie_character_relationship`
  ADD CONSTRAINT `movie_character_relationship_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `movie_characters` (`character_id`),
  ADD CONSTRAINT `movie_character_relationship_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`movie_id`);
--
-- Database: `director`
--
CREATE DATABASE IF NOT EXISTS `director` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `director`;
--
-- Database: `emplyee_info`
--
CREATE DATABASE IF NOT EXISTS `emplyee_info` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `emplyee_info`;
--
-- Database: `jahid`
--
CREATE DATABASE IF NOT EXISTS `jahid` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `jahid`;
--
-- Database: `khi`
--
CREATE DATABASE IF NOT EXISTS `khi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `khi`;
--
-- Database: `lab3`
--
CREATE DATABASE IF NOT EXISTS `lab3` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab3`;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `emp_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `Department` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`emp_id`, `name`, `salary`, `Department`) VALUES
(1, 'Fatema ', 20000, NULL),
(2, 'Tuz ', 22000, NULL),
(3, 'Juhura ', 23000, NULL),
(4, 'Karima', 25000, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `ID` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `CGPA` decimal(3,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`ID`);
--
-- Database: `lab4`
--
CREATE DATABASE IF NOT EXISTS `lab4` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab4`;

-- --------------------------------------------------------

--
-- Table structure for table `actor`
--

CREATE TABLE `actor` (
  `person_id` int(11) NOT NULL,
  `actor_name` varchar(40) DEFAULT NULL,
  `birth_year` year(4) DEFAULT NULL,
  `no_of_films` int(11) DEFAULT NULL,
  `no_of_awards` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `actor`
--

INSERT INTO `actor` (`person_id`, `actor_name`, `birth_year`, `no_of_films`, `no_of_awards`) VALUES
(4, 'Anjan Dutt', '1953', 39, 10),
(6, 'Goutam Ghose', '1950', 3, 1),
(7, 'Aparna Sen', '1945', 73, 43),
(8, 'Kaushik Ganguly', '1968', 22, 7),
(10, 'Soumitra Chatterjee', '1935', 250, 220),
(11, 'UTtam Kumar', '1926', 190, 150),
(12, 'Razzak', '1942', 120, 100);

-- --------------------------------------------------------

--
-- Table structure for table `director`
--

CREATE TABLE `director` (
  `person_id` int(11) NOT NULL,
  `director_name` varchar(40) DEFAULT NULL,
  `birth_year` year(4) DEFAULT NULL,
  `no_of_films` int(11) DEFAULT NULL,
  `no_of_awards` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `director`
--

INSERT INTO `director` (`person_id`, `director_name`, `birth_year`, `no_of_films`, `no_of_awards`) VALUES
(1, 'Zahir Raihan', '1935', 5, 5),
(2, 'Rajkumar Hirani', '1962', 5, 9),
(3, 'Saytajit Ray', '1921', 45, 55),
(4, 'Anjan Dutt', '1953', 23, 17),
(5, 'Rituparno Ghosh', '1963', 20, 15),
(6, 'Goutam Ghose', '1950', 12, 8),
(7, 'Aparna Sen', '1945', 12, 7),
(8, 'Kaushik Ganguly', '1968', 23, 30);

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `movie_id` int(11) NOT NULL,
  `movie_name` varchar(50) DEFAULT NULL,
  `genre` varchar(50) DEFAULT NULL,
  `year` year(4) DEFAULT NULL,
  `imdb_rating` float(2,1) DEFAULT NULL,
  `director_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie`
--

INSERT INTO `movie` (`movie_id`, `movie_name`, `genre`, `year`, `imdb_rating`, `director_id`) VALUES
(1, 'Pather Panchali', 'Drama', '1955', 8.5, 3),
(2, 'Noukadubi', 'Drama', '2011', 7.6, 5),
(3, 'Abohomaan', 'Drama', '2009', 7.3, 5),
(4, 'Joi Baba Felunath', 'Thriller', '1979', 8.0, 3),
(5, 'Jibon Theke Neya', 'Drama', '1970', 9.4, 1),
(6, 'Moner Manush', 'Biography', '2010', 8.0, 6),
(7, 'Apur Panchali', 'Biography', '2013', 8.2, 8),
(8, 'Goynar Baksho', 'Comdey', '2013', 7.1, 7),
(9, 'Byomkesh O Agnibaan', 'Thriller', '2017', 7.4, 4),
(10, 'Byomkesh Bakshi', 'Thriller', '2010', 7.4, 4),
(11, 'PK', 'Fiction', '2014', 8.2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `movie_characters`
--

CREATE TABLE `movie_characters` (
  `character_id` int(11) NOT NULL,
  `character_name` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie_characters`
--

INSERT INTO `movie_characters` (`character_id`, `character_name`, `age`) VALUES
(1, 'Apu', 7),
(2, 'Durga', 10),
(3, 'Harihar', 42),
(4, 'Sarbajaya', 35),
(5, 'Ramesh', 28),
(6, 'Hemnalini', 25),
(7, 'Nalinaksha', 30),
(8, 'Kamala', 20),
(9, 'Shikha', 21),
(10, 'Apratim', 26),
(11, 'Feluda', 25),
(12, 'Maganlal Meghraj', 35),
(13, 'Jatayu', 45),
(14, 'Topshe', 18),
(15, 'Ruku', 6),
(16, 'Faruk', 22),
(17, 'Bithi', 19),
(18, 'Sathi', 24),
(19, 'Lalon', NULL),
(20, 'Kaluah', 25),
(21, 'Siraj Saain', 45),
(22, 'Komli', 25),
(23, 'Subir Banerjee', NULL),
(24, 'Ashima', 24),
(25, 'Rashmoni', NULL),
(26, 'Somalata', 24),
(27, 'Chaitali', 18),
(28, 'Byomkesh Bakshi', 26),
(29, 'Ajit', 27),
(30, 'Malati', 16),
(31, 'Debkumar', 50),
(32, 'Doctor Anukul', 45),
(33, 'Prabhat', 27),
(34, 'Satyabati', 22),
(35, 'Anadi Babu', 55),
(36, 'PK', NULL),
(37, 'Jaggu', 26),
(38, 'Sarfaraz', 29),
(39, 'Tapasvi Maharaj', 50);

-- --------------------------------------------------------

--
-- Table structure for table `movie_character_relationship`
--

CREATE TABLE `movie_character_relationship` (
  `character_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie_character_relationship`
--

INSERT INTO `movie_character_relationship` (`character_id`, `movie_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 3),
(10, 3),
(11, 4),
(12, 4),
(13, 4),
(14, 4),
(15, 4),
(16, 5),
(17, 5),
(18, 5),
(19, 6),
(20, 6),
(21, 6),
(22, 6),
(23, 7),
(24, 7),
(25, 8),
(26, 8),
(27, 8),
(28, 9),
(28, 10),
(29, 9),
(29, 10),
(30, 9),
(31, 9),
(32, 9),
(33, 10),
(34, 9),
(34, 10),
(35, 10),
(36, 11),
(37, 11),
(38, 11),
(39, 11);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actor`
--
ALTER TABLE `actor`
  ADD PRIMARY KEY (`person_id`);

--
-- Indexes for table `director`
--
ALTER TABLE `director`
  ADD PRIMARY KEY (`person_id`);

--
-- Indexes for table `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`movie_id`),
  ADD KEY `director_id` (`director_id`);

--
-- Indexes for table `movie_characters`
--
ALTER TABLE `movie_characters`
  ADD PRIMARY KEY (`character_id`);

--
-- Indexes for table `movie_character_relationship`
--
ALTER TABLE `movie_character_relationship`
  ADD PRIMARY KEY (`character_id`,`movie_id`),
  ADD KEY `movie_id` (`movie_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `movie`
--
ALTER TABLE `movie`
  ADD CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`director_id`) REFERENCES `director` (`person_id`);

--
-- Constraints for table `movie_character_relationship`
--
ALTER TABLE `movie_character_relationship`
  ADD CONSTRAINT `movie_character_relationship_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `movie_characters` (`character_id`),
  ADD CONSTRAINT `movie_character_relationship_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`movie_id`);
--
-- Database: `lab5`
--
CREATE DATABASE IF NOT EXISTS `lab5` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab5`;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `dept_id` int(11) NOT NULL,
  `dept_name` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `budget` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`dept_id`, `dept_name`, `location`, `budget`) VALUES
(1, 'HR', 'Rajshahi', 700000),
(2, 'IT', 'Sylhet', 850000),
(3, 'Finance', 'Chittagong', 600000),
(4, 'Marketing', 'Dhaka', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `name`, `salary`, `dept_id`) VALUES
(101, 'Arif', 45000, 1),
(102, 'Nila', 60000, 2),
(103, 'Sumon', 55000, 3),
(104, 'Rina', 65000, 2),
(105, 'Karim', NULL, 4),
(106, 'Jamil', 50000, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`dept_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `dept_id` (`dept_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`);
--
-- Database: `lab31`
--
CREATE DATABASE IF NOT EXISTS `lab31` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab31`;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`id`, `name`) VALUES
(101, 'karima'),
(102, 'karim'),
(103, 'arima'),
(104, 'rima');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CustomerId` int(11) NOT NULL,
  `CustomerNumber` int(11) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `AreaCode` int(11) DEFAULT NULL,
  `Address` varchar(200) DEFAULT 'Dhaka',
  `Phone` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT 'Unknown',
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `id` int(11) NOT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `email`) VALUES
(103, 'arima@gmail.com'),
(102, 'karim@gmail.com'),
(101, 'karima@gmail.com'),
(104, 'rima@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CustomerId`),
  ADD UNIQUE KEY `CustomerNumber` (`CustomerNumber`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `CustomerId` int(11) NOT NULL AUTO_INCREMENT;
--
-- Database: `labtest`
--
CREATE DATABASE IF NOT EXISTS `labtest` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `labtest`;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `E_id` int(11) NOT NULL,
  `E_name` varchar(50) DEFAULT NULL,
  `Dept` varchar(20) DEFAULT NULL,
  `Salary` int(11) DEFAULT NULL,
  `JoinDate` date DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`E_id`, `E_name`, `Dept`, `Salary`, `JoinDate`, `Address`) VALUES
(1, 'Karim', 'Sales', 10000, '2019-03-12', 'Dhaka'),
(2, 'Nahida', 'IT', 20000, '2021-06-01', 'Khulna'),
(3, 'Sujon', 'HR', 30000, '2020-08-20', 'Khulna'),
(4, 'Afia', 'IT', 40000, '2022-02-11', 'Rajshahi'),
(5, 'Sada', 'HR', 50000, '2018-11-05', 'Dhaka'),
(6, 'Hriday', 'Sales', 25000, '2021-01-01', 'Sylhet');

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `pid` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `E_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`pid`, `name`, `location`, `E_id`) VALUES
(1, 'Alpha', 'Dhaka', 1),
(2, 'Beta', 'Rajshahi', 5),
(3, 'Gamma', 'Khulna', 3),
(4, 'Delta', 'Sylhet', 4),
(5, 'Sigma', 'Dhaka', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`E_id`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`pid`),
  ADD KEY `E_id` (`E_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `project_ibfk_1` FOREIGN KEY (`E_id`) REFERENCES `employee` (`E_id`);
--
-- Database: `lab_01_568`
--
CREATE DATABASE IF NOT EXISTS `lab_01_568` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab_01_568`;
--
-- Database: `lab_01__568`
--
CREATE DATABASE IF NOT EXISTS `lab_01__568` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab_01__568`;

-- --------------------------------------------------------

--
-- Table structure for table `deprtment`
--

CREATE TABLE `deprtment` (
  `dept_id` int(11) DEFAULT NULL,
  `dept_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deprtment`
--

INSERT INTO `deprtment` (`dept_id`, `dept_name`) VALUES
(10, 'HR'),
(20, 'Finance'),
(30, 'Engineering'),
(10, 'HR'),
(20, 'Finance'),
(30, 'Engineering');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` int(11) DEFAULT NULL,
  `emp_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `emp_name`) VALUES
(101, 'Alice Khan'),
(182, 'Brian Das'),
(183, 'Chen Li');

-- --------------------------------------------------------

--
-- Table structure for table `paydetails`
--

CREATE TABLE `paydetails` (
  `emp_id` int(11) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `basic` int(11) DEFAULT NULL,
  `deductions` int(11) DEFAULT NULL,
  `additions` int(11) DEFAULT NULL,
  `DOJ` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payroll`
--

CREATE TABLE `payroll` (
  `emp_id` int(11) DEFAULT NULL,
  `pay_date` date DEFAULT NULL,
  `paid_amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
--
-- Database: `lab_02_459`
--
CREATE DATABASE IF NOT EXISTS `lab_02_459` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab_02_459`;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `dept_id` int(11) DEFAULT NULL,
  `dept_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`dept_id`, `dept_name`) VALUES
(10, 'HR'),
(20, 'Finance'),
(30, 'Engineering');

-- --------------------------------------------------------

--
-- Table structure for table `employe`
--

CREATE TABLE `employe` (
  `emp_id` int(11) DEFAULT NULL,
  `emp_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employe`
--

INSERT INTO `employe` (`emp_id`, `emp_name`) VALUES
(101, 'Alice khan'),
(102, 'Brian Das'),
(103, 'Chen Li');

-- --------------------------------------------------------

--
-- Table structure for table `paydetails`
--

CREATE TABLE `paydetails` (
  `emp_id` int(11) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `basic` int(11) DEFAULT NULL,
  `deduction` int(11) DEFAULT NULL,
  `additions` int(11) DEFAULT NULL,
  `DOJ` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payroll`
--

CREATE TABLE `payroll` (
  `emp_id` int(11) DEFAULT NULL,
  `pay_date` date DEFAULT NULL,
  `paid_amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
--
-- Database: `lab_06_105`
--
CREATE DATABASE IF NOT EXISTS `lab_06_105` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab_06_105`;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `dept` varchar(50) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL,
  `cgpa` float DEFAULT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `name`, `dept`, `dept_id`, `cgpa`, `age`) VALUES
(1, 'Rubayed', 'BBA', 101, 3.2, 20),
(2, 'Tamjid', 'CSE', 102, 3.75, 22),
(3, 'Adnan', 'BBA', 101, 3.5, 21),
(4, 'Arnob', 'EEE', 103, 3.9, 23),
(5, 'Taufiq', 'CSE', 102, 3.6, 22),
(6, 'Abrar', 'EEE', 103, 3.67, 22);
--
-- Database: `lab_4`
--
CREATE DATABASE IF NOT EXISTS `lab_4` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab_4`;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `dept_id` int(11) NOT NULL,
  `dept_name` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `budget` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`dept_id`, `dept_name`, `location`, `budget`) VALUES
(1, 'HR', 'Rajshahi', 700000),
(2, 'IT', 'Sylhet', 850000),
(3, 'Finance', 'Chittagong', 600000),
(4, 'Marketing', 'Dhaka', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `emp_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `dept_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`emp_id`, `name`, `salary`, `dept_id`) VALUES
(101, 'Arif', 45000, 1),
(102, 'Nila', 60000, 2),
(103, 'Sumon', 55000, 3),
(104, 'Rina', 65000, 2),
(105, 'Karim', NULL, 4),
(106, 'Jamil', 50000, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`dept_id`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `dept_id` (`dept_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`);
--
-- Database: `lab_5_027`
--
CREATE DATABASE IF NOT EXISTS `lab_5_027` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab_5_027`;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `hire_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `name`, `department`, `salary`, `hire_date`) VALUES
(1, 'Alice', 'IT', 70000, '2021-03-15'),
(2, 'Bob', 'HR', 55000, '2022-06-01'),
(3, 'Charlie', 'Finance', 60000, '2019-11-20'),
(4, 'David', 'IT', 80000, '2020-01-10'),
(5, 'Eve', 'Marketing', 50000, '2023-02-12'),
(6, 'Frank', 'IT', 75000, '2021-09-05'),
(7, 'Grace', 'HR', 58000, '2020-07-22'),
(8, 'Heidi', 'Finance', 62000, '2022-01-17'),
(9, 'Ivan', 'Marketing', 49000, '2021-05-30'),
(10, 'Judy', 'HR', 56000, '2018-12-01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- Database: `lab_5_19`
--
CREATE DATABASE IF NOT EXISTS `lab_5_19` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab_5_19`;
--
-- Database: `lab_5_roll`
--
CREATE DATABASE IF NOT EXISTS `lab_5_roll` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab_5_roll`;
--
-- Database: `lab_6_roll`
--
CREATE DATABASE IF NOT EXISTS `lab_6_roll` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab_6_roll`;
--
-- Database: `lab_super_composite_144`
--
CREATE DATABASE IF NOT EXISTS `lab_super_composite_144` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab_super_composite_144`;

-- --------------------------------------------------------

--
-- Table structure for table `dorm_info`
--

CREATE TABLE `dorm_info` (
  `dorm_name` varchar(50) NOT NULL,
  `room_number` int(11) NOT NULL,
  `bed_number` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `student_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `email`, `name`) VALUES
(1, 'rahim@seu.edu.bd', 'Rahim'),
(2, 'karim@seu.edu.bd', 'Karim'),
(3, 'sadia@seu.edu.bd', 'Sadia');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dorm_info`
--
ALTER TABLE `dorm_info`
  ADD PRIMARY KEY (`dorm_name`,`room_number`,`bed_number`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dorm_info`
--
ALTER TABLE `dorm_info`
  ADD CONSTRAINT `dorm_info_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;
--
-- Database: `lab_super_composite_823`
--
CREATE DATABASE IF NOT EXISTS `lab_super_composite_823` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lab_super_composite_823`;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `email`, `name`) VALUES
(1, 'rahim@seu.edu.bd', 'Rahim'),
(2, 'karim@seu.edu.bd', 'Karim'),
(3, 'sadia@seu.edu.bd', 'Sadia');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `email` (`email`);
--
-- Database: `library_db`
--
CREATE DATABASE IF NOT EXISTS `library_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `library_db`;

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `book_id` varchar(50) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `available` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `member_id` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `member_id` varchar(50) DEFAULT NULL,
  `book_id` varchar(50) DEFAULT NULL,
  `issue_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `return_date` timestamp NULL DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`member_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Database: `movie`
--
CREATE DATABASE IF NOT EXISTS `movie` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `movie`;

-- --------------------------------------------------------

--
-- Table structure for table `actor`
--

CREATE TABLE `actor` (
  `person_id` int(11) NOT NULL,
  `actor_name` varchar(40) DEFAULT NULL,
  `birth_year` year(4) DEFAULT NULL,
  `no_of_films` int(11) DEFAULT NULL,
  `no_of_awards` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `actor`
--

INSERT INTO `actor` (`person_id`, `actor_name`, `birth_year`, `no_of_films`, `no_of_awards`) VALUES
(4, 'Anjan Dutt', '1953', 39, 10),
(6, 'Goutam Ghose', '1950', 3, 1),
(7, 'Aparna Sen', '1945', 73, 43),
(8, 'Kaushik Ganguly', '1968', 22, 7),
(10, 'Soumitra Chatterjee', '1935', 250, 220),
(11, 'UTtam Kumar', '1926', 190, 150),
(12, 'Razzak', '1942', 120, 100);

-- --------------------------------------------------------

--
-- Table structure for table `director`
--

CREATE TABLE `director` (
  `person_id` int(11) NOT NULL,
  `director_name` varchar(40) DEFAULT NULL,
  `birth_year` year(4) DEFAULT NULL,
  `no_of_films` int(11) DEFAULT NULL,
  `no_of_awards` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `director`
--

INSERT INTO `director` (`person_id`, `director_name`, `birth_year`, `no_of_films`, `no_of_awards`) VALUES
(1, 'Zahir Raihan', '1935', 5, 5),
(2, 'Rajkumar Hirani', '1962', 5, 9),
(3, 'Saytajit Ray', '1921', 45, 55),
(4, 'Anjan Dutt', '1953', 23, 17),
(5, 'Rituparno Ghosh', '1963', 20, 15),
(6, 'Goutam Ghose', '1950', 12, 8),
(7, 'Aparna Sen', '1945', 12, 7),
(8, 'Kaushik Ganguly', '1968', 23, 30);

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `movie_id` int(11) NOT NULL,
  `movie_name` varchar(50) DEFAULT NULL,
  `genre` varchar(50) DEFAULT NULL,
  `year` year(4) DEFAULT NULL,
  `imdb_rating` float(2,1) DEFAULT NULL,
  `director_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie`
--

INSERT INTO `movie` (`movie_id`, `movie_name`, `genre`, `year`, `imdb_rating`, `director_id`) VALUES
(1, 'Pather Panchali', 'Drama', '1955', 8.5, 3),
(2, 'Noukadubi', 'Drama', '2011', 7.6, 5),
(3, 'Abohomaan', 'Drama', '2009', 7.3, 5),
(4, 'Joi Baba Felunath', 'Thriller', '1979', 8.0, 3),
(5, 'Jibon Theke Neya', 'Drama', '1970', 9.4, 1),
(6, 'Moner Manush', 'Biography', '2010', 8.0, 6),
(7, 'Apur Panchali', 'Biography', '2013', 8.2, 8),
(8, 'Goynar Baksho', 'Comdey', '2013', 7.1, 7),
(9, 'Byomkesh O Agnibaan', 'Thriller', '2017', 7.4, 4),
(10, 'Byomkesh Bakshi', 'Thriller', '2010', 7.4, 4),
(11, 'PK', 'Fiction', '2014', 8.2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `movie_characters`
--

CREATE TABLE `movie_characters` (
  `character_id` int(11) NOT NULL,
  `character_name` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie_characters`
--

INSERT INTO `movie_characters` (`character_id`, `character_name`, `age`) VALUES
(1, 'Apu', 7),
(2, 'Durga', 10),
(3, 'Harihar', 42),
(4, 'Sarbajaya', 35),
(5, 'Ramesh', 28),
(6, 'Hemnalini', 25),
(7, 'Nalinaksha', 30),
(8, 'Kamala', 20),
(9, 'Shikha', 21),
(10, 'Apratim', 26),
(11, 'Feluda', 25),
(12, 'Maganlal Meghraj', 35),
(13, 'Jatayu', 45),
(14, 'Topshe', 18),
(15, 'Ruku', 6),
(16, 'Faruk', 22),
(17, 'Bithi', 19),
(18, 'Sathi', 24),
(19, 'Lalon', NULL),
(20, 'Kaluah', 25),
(21, 'Siraj Saain', 45),
(22, 'Komli', 25),
(23, 'Subir Banerjee', NULL),
(24, 'Ashima', 24),
(25, 'Rashmoni', NULL),
(26, 'Somalata', 24),
(27, 'Chaitali', 18),
(28, 'Byomkesh Bakshi', 26),
(29, 'Ajit', 27),
(30, 'Malati', 16),
(31, 'Debkumar', 50),
(32, 'Doctor Anukul', 45),
(33, 'Prabhat', 27),
(34, 'Satyabati', 22),
(35, 'Anadi Babu', 55),
(36, 'PK', NULL),
(37, 'Jaggu', 26),
(38, 'Sarfaraz', 29),
(39, 'Tapasvi Maharaj', 50);

-- --------------------------------------------------------

--
-- Table structure for table `movie_character_relationship`
--

CREATE TABLE `movie_character_relationship` (
  `character_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie_character_relationship`
--

INSERT INTO `movie_character_relationship` (`character_id`, `movie_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 3),
(10, 3),
(11, 4),
(12, 4),
(13, 4),
(14, 4),
(15, 4),
(16, 5),
(17, 5),
(18, 5),
(19, 6),
(20, 6),
(21, 6),
(22, 6),
(23, 7),
(24, 7),
(25, 8),
(26, 8),
(27, 8),
(28, 9),
(28, 10),
(29, 9),
(29, 10),
(30, 9),
(31, 9),
(32, 9),
(33, 10),
(34, 9),
(34, 10),
(35, 10),
(36, 11),
(37, 11),
(38, 11),
(39, 11);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actor`
--
ALTER TABLE `actor`
  ADD PRIMARY KEY (`person_id`);

--
-- Indexes for table `director`
--
ALTER TABLE `director`
  ADD PRIMARY KEY (`person_id`);

--
-- Indexes for table `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`movie_id`),
  ADD KEY `director_id` (`director_id`);

--
-- Indexes for table `movie_characters`
--
ALTER TABLE `movie_characters`
  ADD PRIMARY KEY (`character_id`);

--
-- Indexes for table `movie_character_relationship`
--
ALTER TABLE `movie_character_relationship`
  ADD PRIMARY KEY (`character_id`,`movie_id`),
  ADD KEY `movie_id` (`movie_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `movie`
--
ALTER TABLE `movie`
  ADD CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`director_id`) REFERENCES `director` (`person_id`);

--
-- Constraints for table `movie_character_relationship`
--
ALTER TABLE `movie_character_relationship`
  ADD CONSTRAINT `movie_character_relationship_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `movie_characters` (`character_id`),
  ADD CONSTRAINT `movie_character_relationship_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`movie_id`);
--
-- Database: `movie_database`
--
CREATE DATABASE IF NOT EXISTS `movie_database` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `movie_database`;

-- --------------------------------------------------------

--
-- Table structure for table `actor`
--

CREATE TABLE `actor` (
  `person_id` int(11) NOT NULL,
  `actor_name` varchar(40) DEFAULT NULL,
  `birth_year` year(4) DEFAULT NULL,
  `no_of_films` int(11) DEFAULT NULL,
  `no_of_awards` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `actor`
--

INSERT INTO `actor` (`person_id`, `actor_name`, `birth_year`, `no_of_films`, `no_of_awards`) VALUES
(4, 'Anjan Dutt', '1953', 39, 10),
(6, 'Goutam Ghose', '1950', 3, 1),
(7, 'Aparna Sen', '1945', 73, 43),
(8, 'Kaushik Ganguly', '1968', 22, 7),
(10, 'Soumitra Chatterjee', '1935', 250, 220),
(11, 'UTtam Kumar', '1926', 190, 150),
(12, 'Razzak', '1942', 120, 100);

-- --------------------------------------------------------

--
-- Table structure for table `director`
--

CREATE TABLE `director` (
  `person_id` int(11) NOT NULL,
  `director_name` varchar(40) DEFAULT NULL,
  `birth_year` year(4) DEFAULT NULL,
  `no_of_films` int(11) DEFAULT NULL,
  `no_of_awards` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `director`
--

INSERT INTO `director` (`person_id`, `director_name`, `birth_year`, `no_of_films`, `no_of_awards`) VALUES
(1, 'Zahir Raihan', '1935', 5, 5),
(2, 'Rajkumar Hirani', '1962', 5, 9),
(3, 'Saytajit Ray', '1921', 45, 55),
(4, 'Anjan Dutt', '1953', 23, 17),
(5, 'Rituparno Ghosh', '1963', 20, 15),
(6, 'Goutam Ghose', '1950', 12, 8),
(7, 'Aparna Sen', '1945', 12, 7),
(8, 'Kaushik Ganguly', '1968', 23, 30);

-- --------------------------------------------------------

--
-- Table structure for table `movie`
--

CREATE TABLE `movie` (
  `movie_id` int(11) NOT NULL,
  `movie_name` varchar(50) DEFAULT NULL,
  `genre` varchar(50) DEFAULT NULL,
  `year` year(4) DEFAULT NULL,
  `imdb_rating` float(2,1) DEFAULT NULL,
  `director_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie`
--

INSERT INTO `movie` (`movie_id`, `movie_name`, `genre`, `year`, `imdb_rating`, `director_id`) VALUES
(1, 'Pather Panchali', 'Drama', '1955', 8.5, 3),
(2, 'Noukadubi', 'Drama', '2011', 7.6, 5),
(3, 'Abohomaan', 'Drama', '2009', 7.3, 5),
(4, 'Joi Baba Felunath', 'Thriller', '1979', 8.0, 3),
(5, 'Jibon Theke Neya', 'Drama', '1970', 9.4, 1),
(6, 'Moner Manush', 'Biography', '2010', 8.0, 6),
(7, 'Apur Panchali', 'Biography', '2013', 8.2, 8),
(8, 'Goynar Baksho', 'Comdey', '2013', 7.1, 7),
(9, 'Byomkesh O Agnibaan', 'Thriller', '2017', 7.4, 4),
(10, 'Byomkesh Bakshi', 'Thriller', '2010', 7.4, 4),
(11, 'PK', 'Fiction', '2014', 8.2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `movie_characters`
--

CREATE TABLE `movie_characters` (
  `character_id` int(11) NOT NULL,
  `character_name` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie_characters`
--

INSERT INTO `movie_characters` (`character_id`, `character_name`, `age`) VALUES
(1, 'Apu', 7),
(2, 'Durga', 10),
(3, 'Harihar', 42),
(4, 'Sarbajaya', 35),
(5, 'Ramesh', 28),
(6, 'Hemnalini', 25),
(7, 'Nalinaksha', 30),
(8, 'Kamala', 20),
(9, 'Shikha', 21),
(10, 'Apratim', 26),
(11, 'Feluda', 25),
(12, 'Maganlal Meghraj', 35),
(13, 'Jatayu', 45),
(14, 'Topshe', 18),
(15, 'Ruku', 6),
(16, 'Faruk', 22),
(17, 'Bithi', 19),
(18, 'Sathi', 24),
(19, 'Lalon', NULL),
(20, 'Kaluah', 25),
(21, 'Siraj Saain', 45),
(22, 'Komli', 25),
(23, 'Subir Banerjee', NULL),
(24, 'Ashima', 24),
(25, 'Rashmoni', NULL),
(26, 'Somalata', 24),
(27, 'Chaitali', 18),
(28, 'Byomkesh Bakshi', 26),
(29, 'Ajit', 27),
(30, 'Malati', 16),
(31, 'Debkumar', 50),
(32, 'Doctor Anukul', 45),
(33, 'Prabhat', 27),
(34, 'Satyabati', 22),
(35, 'Anadi Babu', 55),
(36, 'PK', NULL),
(37, 'Jaggu', 26),
(38, 'Sarfaraz', 29),
(39, 'Tapasvi Maharaj', 50);

-- --------------------------------------------------------

--
-- Table structure for table `movie_character_relationship`
--

CREATE TABLE `movie_character_relationship` (
  `character_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `movie_character_relationship`
--

INSERT INTO `movie_character_relationship` (`character_id`, `movie_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 3),
(10, 3),
(11, 4),
(12, 4),
(13, 4),
(14, 4),
(15, 4),
(16, 5),
(17, 5),
(18, 5),
(19, 6),
(20, 6),
(21, 6),
(22, 6),
(23, 7),
(24, 7),
(25, 8),
(26, 8),
(27, 8),
(28, 9),
(28, 10),
(29, 9),
(29, 10),
(30, 9),
(31, 9),
(32, 9),
(33, 10),
(34, 9),
(34, 10),
(35, 10),
(36, 11),
(37, 11),
(38, 11),
(39, 11);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actor`
--
ALTER TABLE `actor`
  ADD PRIMARY KEY (`person_id`);

--
-- Indexes for table `director`
--
ALTER TABLE `director`
  ADD PRIMARY KEY (`person_id`);

--
-- Indexes for table `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`movie_id`),
  ADD KEY `director_id` (`director_id`);

--
-- Indexes for table `movie_characters`
--
ALTER TABLE `movie_characters`
  ADD PRIMARY KEY (`character_id`);

--
-- Indexes for table `movie_character_relationship`
--
ALTER TABLE `movie_character_relationship`
  ADD PRIMARY KEY (`character_id`,`movie_id`),
  ADD KEY `movie_id` (`movie_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `movie`
--
ALTER TABLE `movie`
  ADD CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`director_id`) REFERENCES `director` (`person_id`);

--
-- Constraints for table `movie_character_relationship`
--
ALTER TABLE `movie_character_relationship`
  ADD CONSTRAINT `movie_character_relationship_ibfk_1` FOREIGN KEY (`character_id`) REFERENCES `movie_characters` (`character_id`),
  ADD CONSTRAINT `movie_character_relationship_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`movie_id`);
--
-- Database: `mytable`
--
CREATE DATABASE IF NOT EXISTS `mytable` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `mytable`;
--
-- Database: `n`
--
CREATE DATABASE IF NOT EXISTS `n` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `n`;
--
-- Database: `newjoy`
--
CREATE DATABASE IF NOT EXISTS `newjoy` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `newjoy`;
--
-- Database: `oishi`
--
CREATE DATABASE IF NOT EXISTS `oishi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `oishi`;
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

--
-- Dumping data for table `pma__export_templates`
--

INSERT INTO `pma__export_templates` (`id`, `username`, `export_type`, `template_name`, `template_data`) VALUES
(1, 'root', 'server', 'Movie_database', '{\"quick_or_custom\":\"quick\",\"what\":\"sql\",\"db_select[]\":[\"abcd\",\"coffee_db\",\"coffe_db\",\"companydb\",\"emplyee_info\",\"lab3\",\"lab31\",\"labtest\",\"lab_01_568\",\"lab_01__568\",\"lab_02_459\",\"mytable\",\"newjoy\",\"phpmyadmin\",\"test\"],\"aliases_new\":\"\",\"output_format\":\"sendit\",\"filename_template\":\"@SERVER@\",\"remember_template\":\"on\",\"charset\":\"utf-8\",\"compression\":\"none\",\"maxsize\":\"\",\"codegen_structure_or_data\":\"data\",\"codegen_format\":\"0\",\"csv_separator\":\",\",\"csv_enclosed\":\"\\\"\",\"csv_escaped\":\"\\\"\",\"csv_terminated\":\"AUTO\",\"csv_null\":\"NULL\",\"csv_columns\":\"something\",\"csv_structure_or_data\":\"data\",\"excel_null\":\"NULL\",\"excel_columns\":\"something\",\"excel_edition\":\"win\",\"excel_structure_or_data\":\"data\",\"json_structure_or_data\":\"data\",\"json_unicode\":\"something\",\"latex_caption\":\"something\",\"latex_structure_or_data\":\"structure_and_data\",\"latex_structure_caption\":\"Structure of table @TABLE@\",\"latex_structure_continued_caption\":\"Structure of table @TABLE@ (continued)\",\"latex_structure_label\":\"tab:@TABLE@-structure\",\"latex_relation\":\"something\",\"latex_comments\":\"something\",\"latex_mime\":\"something\",\"latex_columns\":\"something\",\"latex_data_caption\":\"Content of table @TABLE@\",\"latex_data_continued_caption\":\"Content of table @TABLE@ (continued)\",\"latex_data_label\":\"tab:@TABLE@-data\",\"latex_null\":\"\\\\textit{NULL}\",\"mediawiki_structure_or_data\":\"data\",\"mediawiki_caption\":\"something\",\"mediawiki_headers\":\"something\",\"htmlword_structure_or_data\":\"structure_and_data\",\"htmlword_null\":\"NULL\",\"ods_null\":\"NULL\",\"ods_structure_or_data\":\"data\",\"odt_structure_or_data\":\"structure_and_data\",\"odt_relation\":\"something\",\"odt_comments\":\"something\",\"odt_mime\":\"something\",\"odt_columns\":\"something\",\"odt_null\":\"NULL\",\"pdf_report_title\":\"\",\"pdf_structure_or_data\":\"data\",\"phparray_structure_or_data\":\"data\",\"sql_include_comments\":\"something\",\"sql_header_comment\":\"\",\"sql_use_transaction\":\"something\",\"sql_compatibility\":\"NONE\",\"sql_structure_or_data\":\"structure_and_data\",\"sql_create_table\":\"something\",\"sql_auto_increment\":\"something\",\"sql_create_view\":\"something\",\"sql_create_trigger\":\"something\",\"sql_backquotes\":\"something\",\"sql_type\":\"INSERT\",\"sql_insert_syntax\":\"both\",\"sql_max_query_size\":\"50000\",\"sql_hex_for_binary\":\"something\",\"sql_utc_time\":\"something\",\"texytext_structure_or_data\":\"structure_and_data\",\"texytext_null\":\"NULL\",\"yaml_structure_or_data\":\"data\",\"\":null,\"as_separate_files\":null,\"csv_removeCRLF\":null,\"excel_removeCRLF\":null,\"json_pretty_print\":null,\"htmlword_columns\":null,\"ods_columns\":null,\"sql_dates\":null,\"sql_relation\":null,\"sql_mime\":null,\"sql_disable_fk\":null,\"sql_views_as_tables\":null,\"sql_metadata\":null,\"sql_drop_database\":null,\"sql_drop_table\":null,\"sql_if_not_exists\":null,\"sql_simple_view_export\":null,\"sql_view_current_user\":null,\"sql_or_replace_view\":null,\"sql_procedure_function\":null,\"sql_truncate\":null,\"sql_delayed\":null,\"sql_ignore\":null,\"texytext_columns\":null}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"lab5\",\"table\":\"employee\"},{\"db\":\"lab5\",\"table\":\"Employee\"},{\"db\":\"lab5\",\"table\":\"Department\"},{\"db\":\"lab5\",\"table\":\"department\"},{\"db\":\"movie\",\"table\":\"movie\"},{\"db\":\"movie\",\"table\":\"actor\"},{\"db\":\"movie\",\"table\":\"director\"},{\"db\":\"movie_database\",\"table\":\"movie_characters\"},{\"db\":\"movie_database\",\"table\":\"movie\"},{\"db\":\"movie_database\",\"table\":\"director\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2025-12-03 10:26:39', '{\"Console\\/Mode\":\"collapse\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `pookie`
--
CREATE DATABASE IF NOT EXISTS `pookie` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pookie`;
--
-- Database: `sadia`
--
CREATE DATABASE IF NOT EXISTS `sadia` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sadia`;
--
-- Database: `schooldb`
--
CREATE DATABASE IF NOT EXISTS `schooldb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `schooldb`;

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `agr` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`id`, `name`, `department`, `agr`) VALUES
(1, 'Mahib', 'CSE', 20),
(2, 'Pritom', 'EEE', 21),
(1, 'Ronaldo', 'BBA', 19);

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `teacher_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`teacher_id`);
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
--
-- Database: `university_db`
--
CREATE DATABASE IF NOT EXISTS `university_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `university_db`;
--
-- Database: `university_db_009`
--
CREATE DATABASE IF NOT EXISTS `university_db_009` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `university_db_009`;

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `enrollment_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `semester` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`enrollment_id`, `student_id`, `semester`) VALUES
(3, 2, 'Fall 2025');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `name`, `email`) VALUES
(2, 'Karim', 'karim@email.com'),
(3, 'Sadia', 'sadia@email.com');

-- --------------------------------------------------------

--
-- Table structure for table `student_details`
--

CREATE TABLE `student_details` (
  `detail_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`enrollment_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `student_details`
--
ALTER TABLE `student_details`
  ADD PRIMARY KEY (`detail_id`),
  ADD KEY `student_id` (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `enrollment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `student_details`
--
ALTER TABLE `student_details`
  MODIFY `detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- Constraints for table `student_details`
--
ALTER TABLE `student_details`
  ADD CONSTRAINT `student_details_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;
--
-- Database: `university_db_099`
--
CREATE DATABASE IF NOT EXISTS `university_db_099` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `university_db_099`;
--
-- Database: `university_db_102`
--
CREATE DATABASE IF NOT EXISTS `university_db_102` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `university_db_102`;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `STUDENTS_ID` int(11) NOT NULL,
  `NAME` varchar(50) DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`STUDENTS_ID`, `NAME`, `EMAIL`) VALUES
(1, 'NAHID', 'NAHID@GMAIL.COM');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`STUDENTS_ID`);
--
-- Database: `university_db_1002`
--
CREATE DATABASE IF NOT EXISTS `university_db_1002` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `university_db_1002`;

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `enrollment_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `semester` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `enrollments`
--

INSERT INTO `enrollments` (`enrollment_id`, `student_id`, `semester`) VALUES
(3, 2, 'Fall 2025'),
(6, 2, 'Fall 2025');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `name`, `email`) VALUES
(2, 'Karim', 'karim@email.com'),
(3, 'Sadia', 'sadia@email.com');

-- --------------------------------------------------------

--
-- Table structure for table `student_details`
--

CREATE TABLE `student_details` (
  `detail_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`enrollment_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `student_details`
--
ALTER TABLE `student_details`
  ADD PRIMARY KEY (`detail_id`),
  ADD KEY `student_id` (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `enrollment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `student_details`
--
ALTER TABLE `student_details`
  MODIFY `detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- Constraints for table `student_details`
--
ALTER TABLE `student_details`
  ADD CONSTRAINT `student_details_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;
--
-- Database: `vv`
--
CREATE DATABASE IF NOT EXISTS `vv` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `vv`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
