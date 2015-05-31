CREATE TABLE IF NOT EXISTS `menu` (
  `item_id` varchar(255) NOT NULL,
  `res_id` varchar(255) DEFAULT NULL,
  `cuisine_id` varchar(255) DEFAULT NULL,
  `item_name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `price` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `calories` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('6', '2', '2', 'Paneer Butter Masala', 'Main Course', '100', NULL, '500');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('7', '2', '2', 'Naan', 'Main Course', '60', NULL, '600');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('8', '2', '2', 'Butter Chicken', 'Main Course', '100', NULL, '500');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('9', '2', '2', 'Chicken Do Pyaaza', 'Main Course', '200', NULL, '500');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('10', '2', '2', 'Veg Shabnami', 'Main Course', '600', NULL, '300');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('1', '1', '1', 'Kadhai Paneer', 'Main Course', '100', NULL, '320');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('2', '1', '1', 'Mughlai Kabab', 'Starters', '130', NULL, '300');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('3', '1', '1', 'Nargisi Koftha', 'Main Course', '150', NULL, '330');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('4', '1', '1', 'Angaara Kabab', 'Starters', '170', NULL, '400');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('5', '1', '1', 'Paneer Tikka', 'Starters', '160', NULL, '250');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('11', '10', '8', 'Gobhi matar', 'Main Course', '181', NULL, '439');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('12', '10', '10', 'French bean aloo', 'Main Course', '246', NULL, '50');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('13', '9', '3', 'Chaat', 'Main Course', '305', NULL, '8');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('14', '8', '4', 'Daal Puri', 'Main Course', '570', NULL, '273');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('15', '7', '10', 'Jeera aloo', 'Main Course', '234', NULL, '142');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('16', '4', '3', 'Gobhi matar', 'Main Course', '364', NULL, '323');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('17', '4', '4', 'Dal fry with tadka', 'Main Course', '372', NULL, '274');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('18', '10', '4', 'Gajar ka Halwa', 'Main Course', '451', NULL, '535');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('19', '6', '1', 'Kachori', 'Main Course', '479', NULL, '210');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('20', '3', '5', 'Daal Puri', 'Main Course', '348', NULL, '585');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('21', '5', '9', 'Karela Bharta', 'Main Course', '572', NULL, '325');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('22', '3', '4', 'Dum Aloo', 'Main Course', '361', NULL, '-16');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('23', '3', '7', 'Gajar matar aloo', 'Main Course', '205', NULL, '387');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('24', '4', '8', 'Katha meetha petha/halwakadoo', 'Main Course', '187', NULL, '-68');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('25', '8', '4', 'Hari Mutter ka Nimona (Green peas daal)', 'Main Course', '343', NULL, '282');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('26', '4', '2', 'Gajar ka Halwa', 'Main Course', '350', NULL, '406');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('27', '4', '7', 'Chicken Razala', 'Main Course', '361', NULL, '154');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('28', '6', '8', 'Chapathi', 'Main Course', '364', NULL, '566');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('29', '10', '8', 'Daal Puri', 'Main Course', '409', NULL, '468');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('30', '3', '9', 'Chole bhature', 'Main Course', '199', NULL, '455');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('31', '6', '3', 'Daal Baati Churma', 'Main Course', '324', NULL, '440');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('32', '7', '9', 'Jeera aloo', 'Main Course', '329', NULL, '362');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('33', '10', '6', 'Chicken Razala', 'Main Course', '314', NULL, '368');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('34', '5', '4', 'Karela Bharta', 'Main Course', '414', NULL, '50');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('35', '5', '10', 'Gajar ka Halwa', 'Main Course', '348', NULL, '99');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('36', '8', '5', 'Dal fry with tadka', 'Main Course', '373', NULL, '382');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('37', '10', '3', 'Chole bhature', 'Main Course', '316', NULL, '441');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('38', '4', '10', 'Katha meetha petha/halwakadoo', 'Main Course', '345', NULL, '256');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('39', '4', '3', 'Dal makhani (Kali Dal)', 'Main Course', '248', NULL, '546');
INSERT INTO `menu` (`item_id`, `res_id`, `cuisine_id`, `item_name`, `type`, `price`, `image`, `calories`) VALUES('40', '5', '8', 'Katha meetha petha/halwakadoo', 'Main Course', '310', NULL, '322');