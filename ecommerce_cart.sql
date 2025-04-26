-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2025 at 11:55 AM
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
-- Database: `ecommerce_cart`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `o_id` int(11) NOT NULL,
  `p_id` int(11) NOT NULL,
  `u_id` int(11) NOT NULL,
  `o_quantity` int(11) NOT NULL,
  `o_date` varchar(450) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`o_id`, `p_id`, `u_id`, `o_quantity`, `o_date`) VALUES
(22, 3, 1, 1, '28-12-2024'),
(23, 4, 1, 1, '28-12-2024'),
(31, 4, 1, 1, '28-16-2024'),
(50, 20, 8, 1, '28-12-2024'),
(51, 21, 8, 1, '28-12-2024'),
(54, 2, 9, 3, '28-12-2024'),
(57, 3, 2, 1, '29-12-2024'),
(58, 4, 2, 1, '29-12-2024'),
(59, 14, 2, 1, '29-12-2024'),
(60, 10, 2, 2, '29-12-2024'),
(61, 3, 2, 1, '29-12-2024'),
(62, 3, 2, 2, '29-12-2024'),
(64, 3, 2, 1, '01-01-2025'),
(66, 3, 2, 1, '06-01-2025'),
(67, 2, 2, 1, '06-01-2025'),
(68, 2, 2, 1, '06-01-2025'),
(69, 2, 2, 1, '06-01-2025'),
(71, 17, 1, 1, '09-01-2025'),
(72, 5, 1, 1, '09-01-2025'),
(73, 4, 1, 1, '09-01-2025'),
(75, 9, 12, 1, '09-01-2025'),
(76, 14, 12, 1, '09-01-2025'),
(77, 1, 12, 1, '09-01-2025'),
(78, 4, 12, 1, '09-01-2025'),
(79, 2, 12, 4, '09-01-2025'),
(80, 3, 4, 1, '19-01-2025'),
(81, 6, 5, 1, '20-01-2025'),
(82, 2, 5, 1, '20-01-2025'),
(83, 1, 13, 1, '21-01-2025'),
(84, 10, 13, 3, '21-01-2025'),
(85, 25, 13, 1, '21-01-2025'),
(86, 4, 1, 2, '23-01-2025'),
(87, 6, 1, 1, '23-01-2025'),
(88, 6, 1, 1, '23-01-2025'),
(89, 6, 1, 1, '25-01-2025'),
(90, 2, 1, 1, '25-01-2025'),
(91, 5, 1, 1, '25-01-2025'),
(92, 5, 1, 1, '25-01-2025'),
(93, 5, 1, 1, '25-01-2025'),
(94, 2, 1, 1, '25-01-2025'),
(95, 3, 1, 1, '25-01-2025'),
(96, 8, 1, 1, '25-01-2025'),
(97, 60, 1, 1, '25-01-2025'),
(98, 7, 1, 1, '25-01-2025'),
(99, 1, 1, 1, '25-01-2025'),
(102, 3, 1, 1, '25-01-2025'),
(103, 1, 1, 1, '29-01-2025'),
(104, 3, 1, 2, '09-02-2025'),
(106, 3, 1, 1, '22-04-2025'),
(107, 4, 1, 3, '22-04-2025');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(450) NOT NULL,
  `category` varchar(450) NOT NULL,
  `price` double NOT NULL,
  `image` varchar(450) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `category`, `price`, `image`) VALUES
(2, 'Ladies Pure PU Shoulder Bag ', 'Ladis Bag', 66669.99, 'ladis-bag.jpeg'),
(3, 'Stylish Men Office Suits', 'Men Clothes', 1169, 'men-suits.jpeg'),
(4, 'Jaeger-LeCoultre Men Watch', 'Men Watch', 250011.99, 'men-watch.jpeg'),
(5, 'FreeMax e-bike VB-456', 'E-bike', 10, 'smoking-e-bike.jpeg'),
(6, 'football shoes MM-632', 'Football', 955.5, 'football.jpeg'),
(7, 'Apple iPhone 14', 'Mobile Phones', 79999, 'iphone-14.jpeg'),
(8, 'Samsung Galaxy S23', 'Mobile Phones', 74999, 'galaxy-s23.jpeg'),
(9, 'OnePlus 11', 'Mobile Phones', 56999, 'oneplus-11.jpeg'),
(10, 'Xiaomi Redmi Note 12', 'Mobile Phones', 15999, 'redmi-note-12.jpeg'),
(11, 'Sony WH-1000XM4', 'Headphones', 29990, 'sony-headphones.jpeg'),
(12, 'JBL Flip 6', 'Portable Speakers', 12990, 'jbl-flip-6.jpeg'),
(13, 'Lenovo IdeaPad 3', 'Laptops', 47990, 'lenovo-ideapad-3.jpeg'),
(14, 'HP Pavilion x360 plus', 'Laptops', 58990, 'hp-pavilion-x360.jpeg'),
(15, 'Canon EOS 200D', 'Cameras', 54990, 'canon-eos-200d.jpeg'),
(16, 'Nikon D3500', 'Cameras', 42990, 'nikon-d3500.jpeg'),
(18, 'Realme Narzo 60x', 'Mobile Phones', 13999, 'realme-narzo-60x.jpeg'),
(19, 'Samsung 43-inch 4K Smart TV', 'Televisions', 33999, 'samsung-4k-smart-tv.jpeg'),
(20, 'LG 260L Double Door Refrigerator', 'Home Appliances', 29999, 'lg-double-door-refrigerator.jpeg'),
(21, 'Prestige 3 Burner Gas Stove', 'Kitchen Appliances', 4599, 'prestige-3-burner-gas-stove.jpeg'),
(22, 'Asus ROG Strix G16', 'Gaming Laptops', 124990, 'asus-rog-strix-g16.jpeg'),
(23, 'Mi Smart Band 8 pro', 'Wearable Devices', 3499, 'mi-smart-band-8.jpeg'),
(24, 'Sony Alpha 7C', 'Cameras', 179990, 'sony-alpha-7c.jpeg'),
(25, 'Amazon Echo Dot 5th Gen', 'Smart Devices', 4999, 'amazon-echo-dot-5th-gen.jpeg'),
(26, 'Puma Men Running Shoes', 'Men Shoes', 4999, 'puma-men-running-shoes.jpeg'),
(27, 'Dell Inspiron 15', 'Laptops', 65999, 'dell-inspiron-15.jpeg'),
(28, 'Sony WH-1000XM5', 'Headphones', 32999, 'sony-wh-1000xm5.jpeg'),
(29, 'Apple Watch Series 9', 'Wearable Devices', 45999, 'apple-watch-series-9.jpeg'),
(30, 'Canon EOS R6 Mark II', 'Cameras', 239999, 'canon-eos-r6-mark-ii.jpeg'),
(31, 'Philips Air Fryer XL', 'Kitchen Appliances', 19999, 'philips-air-fryer-xl.jpeg'),
(32, 'Lenovo Yoga Slim 7i', 'Laptops', 77999, 'lenovo-yoga-slim-7i.jpeg'),
(33, 'GoPro Hero 12', 'Cameras', 49999, 'gopro-hero-12.jpeg'),
(34, 'JBL Charge 5', 'Portable Speakers', 17999, 'jbl-charge-5.jpeg'),
(35, 'Apple iPad Air', 'Tablets', 59999, 'apple-ipad-air.jpeg'),
(36, 'Elegant High Heels', 'Female Shoes', 7977.17, 'elegant-high-heels.jpeg'),
(37, 'Casual Sports Shoes', 'Female Shoes', 6639.17, 'casual-sports-shoes.jpeg'),
(38, 'Floral Sandals', 'Female Shoes', 4144.17, 'floral-sandals.jpeg'),
(39, 'Elegant Tote Bag', 'Ladis Bag', 7469.17, 'elegant-tote-bag.jpeg'),
(40, 'Vintage Leather Handbag', 'Ladis Bag', 9960, 'vintage-leather-handbag.jpeg'),
(41, 'Mini Crossbody Bag', 'Ladis Bag', 3319.17, 'mini-crossbody-bag.jpeg'),
(42, 'Formal Business Suit', 'Men Clothes', 16599.17, 'formal-business-suit.jpeg'),
(43, 'Casual Denim Jacket', 'Men Clothes', 7469.17, 'casual-denim-jacket.jpeg'),
(44, 'Stylish Hoodie', 'Men Clothes', 4979.17, 'stylish-hoodie.jpeg'),
(45, 'Luxury Gold Watch', 'Men Watch', 290582.17, 'luxury-gold-watch.jpeg'),
(46, 'Sports Digital Watch', 'Men Watch', 16599.17, 'sports-digital-watch.jpeg'),
(47, 'Smartwatch Pro Edition', 'Men Watch', 37350, 'smartwatch-pro-edition.jpeg'),
(48, 'Electric Mountain Bike', 'E-bike', 124750, 'electric-mountain-bike.jpeg'),
(49, 'Foldable Electric Bike', 'E-bike', 84999, 'foldable-electric-bike.jpeg'),
(50, 'City Commuter E-bike', 'E-bike', 99999, 'city-commuter-e-bike.jpeg'),
(51, 'Official Match Football', 'Football', 2499, 'official-match-football.jpeg'),
(52, 'Training Football', 'Football', 1499, 'training-football.jpeg'),
(54, 'Smart LED TV 55-inch', 'Home Appliances', 45999, 'smart-led-tv-55-inch.jpeg'),
(55, 'Air Conditioner 1.5 Ton', 'Home Appliances', 35999, 'air-conditioner-1-5-ton.jpeg'),
(56, 'Automatic Washing Machine', 'Home Appliances', 28999, 'automatic-washing-machine.jpeg'),
(57, 'Microwave Oven 28L', 'Kitchen Appliances', 9999, 'microwave-oven-28l.jpeg'),
(58, 'Induction Cooktop 2100W', 'Kitchen Appliances', 2999, 'induction-cooktop-2100w.jpeg'),
(59, 'Mixer Grinder 750W', 'Kitchen Appliances', 3499, 'mixer-grinder-750w.jpeg'),
(60, 'pen', 'pen', 299, 'download.jpg'),
(61, 'my watch company', 'Men Watch', 19999.9, 'watch.jpg'),
(62, 'cricket bat', 'cricket bat', 2500.9, 'bat.jpg'),
(63, 'bottle', 'drinkable', 299.99, 'download (2).jpeg'),
(65, 'galaxy s23', 'Mobile Phones', 99999, 'galaxys23.webp'),
(66, 'Chicken Pickle', 'Pickle', 200, 'chicken pickle.webp');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `last_login` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `last_login`) VALUES
(1, 'sarvesh', 'sarv@gmail.com', '12345', 'user', '2025-04-22 15:16:35'),
(2, 'jhawar', 'jhawar@gmail.com', '123', 'admin', '2025-04-22 15:19:47'),
(4, 'hero', 'hero@gmail.com', '123456', 'user', '2025-01-19 01:05:59'),
(5, 'hero2', 'hero2@gmail.com', 'qwerty', 'user', '2025-01-20 18:32:28'),
(6, 'hero3', 'hero3@gmail.com', '12', 'user', NULL),
(7, 'hello', 'hello@gmail.com', '1234', 'user', NULL),
(8, 'anuradha', 'anu@gmail.com', '678', 'user', NULL),
(9, 'omprakash jhawar', 'omprakash@gmail.com', '9440576611', 'user', NULL),
(10, 'divya', 'bangaddivya@gmail.com', '@95408', 'user', NULL),
(12, 'anuradha', 'hero111@gmail.com', '123456789', 'user', NULL),
(13, 'ayush ', 'udits1113@gmail.com', 'Ayush', 'user', '2025-01-21 20:48:01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`o_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `o_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
