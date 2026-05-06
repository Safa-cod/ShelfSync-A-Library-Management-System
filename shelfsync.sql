


CREATE TABLE `books` (
  `book_id` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `isbn` varchar(50) DEFAULT NULL,
  `genre` varchar(50) DEFAULT NULL,
  `total_qty` int(11) DEFAULT NULL,
  `available_qty` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



INSERT INTO `books` (`book_id`, `title`, `author`, `isbn`, `genre`, `total_qty`, `available_qty`) VALUES
(1, 'tin goyenda', 'rakib hasan', '123', 'detective', 10, 10),
(2, 'sherlock Holmes', 'arther konan duel', '123', 'Detective', 5, 5);



ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`);

ALTER TABLE `books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;


