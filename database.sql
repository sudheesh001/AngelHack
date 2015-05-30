-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 30, 2015 at 09:06 PM
-- Server version: 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ah15_1`
--

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE IF NOT EXISTS `bills` (
  `bill_no` int(10) NOT NULL,
  `res_id` int(10) DEFAULT NULL,
  `order_id` int(10) DEFAULT NULL,
  `cuisine_id` int(10) DEFAULT NULL,
  `loc_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `cuisine`
--

CREATE TABLE IF NOT EXISTS `cuisine` (
  `cuisine_id` int(10) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cuisine`
--

INSERT INTO `cuisine` (`cuisine_id`, `name`) VALUES
(1, 'North India'),
(2, 'South Indian'),
(3, 'Continental'),
(4, 'Italian'),
(5, 'Gujarati'),
(6, 'Global'),
(7, 'Chinese'),
(8, 'Japanese'),
(9, 'French'),
(10, 'Rajasthani'),
(11, 'Fast Food'),
(12, 'Konkani'),
(13, 'Oriental'),
(14, 'Mughlai'),
(15, 'Pizza'),
(16, 'Seafood'),
(17, 'Ice Creams'),
(18, 'Cakes & Bakeries'),
(19, 'Middle Eastern'),
(20, 'European'),
(21, 'Pan-Asian'),
(22, 'Thai'),
(23, 'Arabic');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE IF NOT EXISTS `menu` (
  `item_id` int(10) NOT NULL,
  `res_id` int(10) DEFAULT NULL,
  `cuisine_id` int(10) DEFAULT NULL,
  `item_name` varchar(255) NOT NULL,
  `price` int(10) DEFAULT NULL,
  `image` longtext,
  `calories` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `price`, `image`, `calories`) VALUES
(1, 1, 1, 'i1', 100, NULL, 320),
(2, 1, 1, 'i2', 130, NULL, 300),
(3, 1, 1, 'i3', 150, NULL, 0),
(4, 1, 1, 'i4', 170, NULL, 400),
(5, 1, 1, 'i5', 160, NULL, 250),
(6, 2, 2, 'i1', 10, NULL, 10),
(7, 2, 2, 'i2', 10, NULL, 10),
(8, 2, 2, 'i3', 10, NULL, 10),
(9, 2, 2, 'i4', 10, NULL, 10),
(10, 2, 2, 'i5', 10, NULL, 10);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` int(10) DEFAULT NULL,
  `item_id` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `restaurant`
--

CREATE TABLE IF NOT EXISTS `restaurant` (
  `res_id` varchar(11) NOT NULL,
  `res_name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `status` varchar(1) NOT NULL,
  `rating` varchar(11) NOT NULL,
  `serv_type` varchar(255) NOT NULL,
  `no_people_visited` varchar(11) NOT NULL,
  `no_people_liked` varchar(11) NOT NULL,
  `pure_veg` varchar(1) NOT NULL DEFAULT '0',
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `restaurant`
--

-- INSERT INTO `restaurant` (`res_id`, `res_name`, `loc_id`, `status`, `rating`, `serv_type`, `no_people_visited`, `no_people_liked`, `pure_veg`, `password`) VALUES
-- (1, 'Punjabi Affair', 1, 1, 0, 'take away;dine in;home delivery', 0, 0, 0, 'd666154a5a1823c468621b10d275433d'),
-- (2, 'Heart Cup coffee', 1, 1, 0, 'dine in', 0, 0, 0, 'cb631c075ee0f0bed1863c6cda8c6f85'),
-- (3, 'Olive House', 1, 1, 0, 'dine in;home delivery', 0, 0, 0, 'b9ef6782d704622715d482f3b1eef76b'),
-- (4, '13 DHABA', 2, 1, 0, 'dine in', 0, 0, 0, 'passwd1236'),
-- (5, 'Sardarji''s Dhaba', 2, 1, 0, 'outdoor seating', 0, 0, 0, 'passwd1237'),
-- (6, 'The Wonton', 2, 1, 0, 'dine in;home delivery', 0, 0, 0, 'passwd13456'),
-- (7, 'Habanero', 3, 1, 0, 'dine in', 0, 0, 0, '6181354e1d2fe9e548672f93a1aadb60'),
-- (8, 'Little Italy', 3, 1, 0, 'home delivery;dine in', 0, 0, 0, '6181354e1d2fe9e548672f93a1aadb60'),
-- (9, 'Olive Bistro', 4, 1, 0, 'dine in', 0, 0, 0, '2542d4124b9933efdb8a69d68cebd2c1'),
-- (10, 'Chutneys', 4, 1, 0, 'dine in', 0, 0, 1, 'bace8d29fc10c4d146081371411203f1'),
-- (11, 'Temptaions', 5, 1, 0, 'dine in', 0, 0, 1, '7a4a6849014a18a4a28c9412c9656965'),
-- (12, 'Udupi''s Upahar', 5, 1, 0, 'dine in', 0, 0, 1, 'b2fd9cae6b9e17e1d8349b0e67c8bb0d'),
-- (13, 'Exotica', 6, 1, 0, 'dine in;outdoor seating', 0, 0, 0, 'df7b7a0b1f13fe533f5e5b5e69083440'),
-- (14, 'Bikanerwala', 6, 1, 0, 'dine in', 0, 0, 1, '2e5bbffda3167a757b2bc8994cc7f6e1'),
-- (15, 'Hard Rock Cafe', 6, 1, 0, 'seating', 0, 0, 0, '6181354e1d2fe9e548672f93a1aadb60');

-- --------------------------------------------------------

--
-- Table structure for table `res_cus`
--

CREATE TABLE IF NOT EXISTS `res_cus` (
  `res_id` int(10) NOT NULL,
  `cuisine_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE IF NOT EXISTS `transaction` (
  `trans_id` int(10) NOT NULL DEFAULT '0',
  `res_id` int(10) NOT NULL DEFAULT '0',
  `user_id` int(10) NOT NULL DEFAULT '0',
  `bill_no` int(10) NOT NULL DEFAULT '0',
  `amount` int(10) NOT NULL DEFAULT '0',
  `time_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_admin`
--

CREATE TABLE IF NOT EXISTS `user_admin` (
  `user_id` int(10) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_login`
--

CREATE TABLE IF NOT EXISTS `user_login` (
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `BMI` float DEFAULT NULL,
  `height` float DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `cuisine_id` int(10) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `likes` int(10) DEFAULT NULL,
  `points` int(11) DEFAULT NULL,
  `wallet` int(11) NOT NULL DEFAULT '0' COMMENT 'Wallet Amount'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
