CREATE DATABASE IF NOT EXISTS `library` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `library`;

-- Table structure for table `authors`
DROP TABLE IF EXISTS `authors`;
CREATE TABLE `authors` (
 `author_id` int NOT NULL,
 `fname` varchar(20) NOT NULL,
 `lname` varchar(20) NOT NULL,
 `age` int NOT NULL,
 `nationality` varchar(20) DEFAULT NULL,
 PRIMARY KEY (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Table structure for table `books`
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
 `book_id` int NOT NULL,
 `book_name` varchar(100) NOT NULL,
 `isbn` int NOT NULL,
 `page_length` int NOT NULL,
 `publish_year` year NOT NULL,
 `genre_id` int NOT NULL,
 `author_id` int NOT NULL,
 `publisher_id` int NOT NULL,
 `type_id` int NOT NULL,
 PRIMARY KEY (`book_id`),
 KEY `fk_books_genre_idx` (`genre_id`),
 KEY `fk_books_authors1_idx` (`author_id`),
 KEY `fk_books_Publishers1_idx` (`publisher_id`),
 KEY `fk_books_type1_idx` (`type_id`),
 CONSTRAINT `fk_books_authors1` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`),
 CONSTRAINT `fk_books_genre` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`genre_id`),
 CONSTRAINT `fk_books_Publishers1` FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`publisher_id`),
 CONSTRAINT `fk_books_type1` FOREIGN KEY (`type_id`) REFERENCES `type` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Table structure for table `genre`
DROP TABLE IF EXISTS `genre`;
CREATE TABLE `genre` (
 `genre_id` int NOT NULL,
 `genre_name` varchar(30) NOT NULL,
 `genre_description` varchar(200) DEFAULT NULL,
 PRIMARY KEY (`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Table structure for table `lending`
DROP TABLE IF EXISTS `lending`;
CREATE TABLE `lending` (
 `days_lent` int NOT NULL,
 `days_overdue` int NOT NULL,
 `checkout_date` date DEFAULT NULL,
 `date_due` date DEFAULT NULL,
 `user_id` int NOT NULL,
 `book_id` int NOT NULL,
 PRIMARY KEY (`user_id`,`book_id`),
 KEY `fk_Lending_books1_idx` (`book_id`),
 CONSTRAINT `fk_Lending_books1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
 CONSTRAINT `fk_Lending_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Table structure for table `publishers`
DROP TABLE IF EXISTS `publishers`;
CREATE TABLE `publishers` (
 `publisher_id` int NOT NULL,
 `publisher_name` varchar(20) NOT NULL,
 `publisher_description` varchar(20) DEFAULT NULL,
 `publisher_state` varchar(20) DEFAULT NULL,
 PRIMARY KEY (`publisher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Table structure for table `type`
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
 `type_id` int NOT NULL,
 `type_name` varchar(10) NOT NULL,
 `type_description` varchar(10) NOT NULL,
 PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Table structure for table `users`
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
 `user_id` int NOT NULL,
 `fname` varchar(20) NOT NULL,
 `lname` varchar(20) NOT NULL,
 `email` varchar(30) DEFAULT NULL,
 `phone_number` varchar(12) DEFAULT NULL,
 `street_address` varchar(30) DEFAULT NULL,
 `city` varchar(20) DEFAULT NULL,
 `state` varchar(2) DEFAULT NULL,
 `zip_code` int DEFAULT NULL,
 PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Temporary view structures
DROP VIEW IF EXISTS `largest_authors`;
CREATE VIEW `largest_authors` AS 
SELECT CONCAT(`a`.`fname`, ' ', `a`.`lname`) AS `author_name`, COUNT(`b`.`author_id`) AS `num_books_authored` 
FROM `books` `b` 
JOIN `authors` `a` ON `b`.`author_id` = `a`.`author_id` 
GROUP BY `b`.`author_id` 
HAVING `num_books_authored` > 2 
ORDER BY `num_books_authored` DESC;

DROP VIEW IF EXISTS `largest_genres`;
CREATE VIEW `largest_genres` AS 
SELECT `g`.`genre_name` AS `genre_name`, COUNT(`b`.`genre_id`) AS `num_books` 
FROM `books` `b` 
JOIN `genre` `g` ON `b`.`genre_id` = `g`.`genre_id` 
GROUP BY `g`.`genre_name` 
HAVING `num_books` > 2 
ORDER BY `num_books` DESC;
