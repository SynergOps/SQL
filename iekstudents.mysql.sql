-- Copyright (c) 2025, Salih Emin 
-- License: GPL-3.0
-- Generation Time: May 22, 2025 at 11:24 AM
-- Server version: 10.11.11-MariaDB-ubu2204
-- PHP Version: 8.2.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+03:00";
START TRANSACTION;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `iekstudents`
--
CREATE DATABASE IF NOT EXISTS `iekstudents` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `iekstudents`;
-- 
-- 

-- --------------------------------------------------------

--
-- Table structure for table `dinners`
--
DROP TABLE IF EXISTS `dinners`;
CREATE TABLE `dinners` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` varchar(30) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `entree` varchar(30) DEFAULT NULL,
  `side` varchar(30) DEFAULT NULL,
  `dessert` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dinners`
--
DROP TABLE IF EXISTS `tourneys`;
INSERT INTO `dinners` (`id`, `name`, `birthdate`, `entree`, `side`, `dessert`) VALUES
(1, 'Manolis', '2003-01-19', 'steak', 'salad', 'cake'),
(2, 'Thanos', '2003-01-25', 'chicken', 'fries', 'ice cream'),
(3, 'Sara', '2005-02-18', 'tofu', 'fries', 'cake'),
(4, 'Elpida', '2004-12-25', 'tofu', 'salad', 'ice cream'),
(5, 'Georgia', '2006-05-28', 'steak', 'fries', 'ice cream'),
(6, 'Sali', '1990-01-01', 'chicken', 'fries', 'ice cream');
COMMIT;
-- --------------------------------------------------------

--
-- Table structure for table `tourneys`
--
DROP TABLE IF EXISTS `tourneys`;
CREATE TABLE `tourneys` (
  `id` int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `NAME` varchar(30) DEFAULT NULL,
  `wins` double DEFAULT NULL,
  `best` double DEFAULT NULL,
  `size` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tourneys`
--

INSERT INTO `tourneys` (`id`, `NAME`, `wins`, `best`, `size`) VALUES
(1, 'Manolis', 7, 245, 44),
(2, 'Thanos', 4, 280, 45),
(3, 'Sara', 9, 266, 38),
(4, 'Elpida', 2, 200, 37),
(5, 'Georgia', 2, 197, 37),
(6, 'Sali', 13, 283, 46);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
