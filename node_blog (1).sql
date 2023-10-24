-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 24, 2023 at 10:12 AM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `node_blog`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `content` text,
  `postId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `perm_name` varchar(255) NOT NULL,
  `perm_description` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `perm_name`, `perm_description`, `createdAt`, `updatedAt`) VALUES
(1, 'canSave', 'can Save', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'canView', 'can View', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 'canEdit', 'can Edit', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(4, 'canAuthorize', 'can Authorize', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 'canDelete', 'can Delete', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `imageUrl` varchar(255) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `content`, `imageUrl`, `categoryId`, `userId`, `createdAt`, `updatedAt`) VALUES
(1, '2 Favour', 'My Newest Title in TownNewest Title in TownNewest Title in TownNewest Title in TownNewest Title in Town', NULL, NULL, 2, '2023-09-30 22:08:48', '2023-09-30 22:08:48'),
(2, '2 Favour', 'My Newest Title in TownNewest Title in TownNewest Title in TownNewest Title in TownNewest Title in Town', 'https://avatars.githubusercontent.com/u/26245738?v=4', 2, 2, '2023-10-01 07:14:00', '2023-10-01 07:14:00'),
(3, '1 Favour', 'My Newest Title in TownNewest Title in TownNewest Title in TownNewest Title in TownNewest Title in Town', 'https://avatars.githubusercontent.com/u/26245738?v=4', 2, 1, '2023-10-01 07:29:08', '2023-10-01 07:29:08'),
(4, '5 Favour', 'My Newest Title in TownNewest Title in TownNewest Title in TownNewest Title in TownNewest Title in Town', 'https://avatars.githubusercontent.com/u/26245738?v=4', 3, 1, '2023-10-01 07:38:52', '2023-10-01 07:38:52'),
(5, '55 Favour', 'My Newest Title in TownNewest Title in TownNewest Title in TownNewest Title in TownNewest Title in Town', 'https://avatars.githubusercontent.com/u/26245738?v=4', 3, 1, '2023-10-01 07:43:46', '2023-10-01 08:37:24');

-- --------------------------------------------------------

--
-- Table structure for table `rolepermissions`
--

CREATE TABLE `rolepermissions` (
  `id` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  `permissionId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rolepermissions`
--

INSERT INTO `rolepermissions` (`id`, `roleId`, `permissionId`, `createdAt`, `updatedAt`) VALUES
(1, 1, 4, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 1, 5, '2023-09-30 06:41:00', '2023-09-30 09:00:00'),
(3, 1, 3, '2023-09-30 00:00:00', '2023-09-30 00:00:00'),
(4, 1, 1, '2023-09-30 00:00:00', '2023-09-30 00:00:00'),
(5, 1, 2, '2023-09-30 00:00:00', '0000-00-00 00:00:00'),
(6, 2, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(7, 2, 2, '2023-09-30 06:41:00', '2023-09-30 09:00:00'),
(8, 3, 1, '2023-09-30 00:00:00', '2023-09-30 00:00:00'),
(9, 3, 2, '2023-09-30 00:00:00', '2023-09-30 00:00:00'),
(10, 3, 3, '2023-09-30 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  `role_description` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role_name`, `role_description`, `createdAt`, `updatedAt`) VALUES
(1, 'admin', 'Super Administrator', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'user', 'Basic user', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 'editor', 'Editor', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `sequelizemeta`
--

CREATE TABLE `sequelizemeta` (
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sequelizemeta`
--

INSERT INTO `sequelizemeta` (`name`) VALUES
('20230902073607-create-category.js'),
('20230902073657-create-comment.js'),
('20230928170241-create-role.js'),
('20230928170247-create-permission.js'),
('20230928170251-create-role-permission.js'),
('20230928211123-create-post.js'),
('20230928211520-create-post.js'),
('20230930131958-create-user.js'),
('20230930132225-create-post.js'),
('20230930215234-create-post.js'),
('20230930215439-create-post.js');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `roleId` int(11) NOT NULL,
  `refreshToken` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `roleId`, `refreshToken`, `createdAt`, `updatedAt`) VALUES
(1, 'Yaqub Adeyeye', 'yaqub2@gmail.com', '$2b$10$amTdOQDtXbQJaCtR/iF1ZeRBbFZHh5j1B5Fz7zbH8hWARmOoOO1Ra', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyRGV0Ijp7ImlkIjoxLCJuYW1lIjoiWWFxdWIgQWRleWV5ZSIsImVtYWlsIjoieWFxdWIyQGdtYWlsLmNvbSIsInJvbGVJZCI6MSwiUm9sZSI6eyJpZCI6MSwicm9sZV9uYW1lIjoiYWRtaW4iLCJyb2xlX2Rlc2NyaXB0aW9uIjoiU3VwZXIgQWRtaW5pc3RyYXRvciIsImNyZWF0ZW', '2023-09-30 14:16:01', '2023-10-01 07:43:26'),
(2, 'Yaqub Adeyeye', 'yaqub@gmail.com', '$2b$10$1cKZ7n/OEf/ccuZz8BDudOIM3giQSlZ8VWwKKr3/0SaYGEXy5p7RK', 2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyRGV0Ijp7ImlkIjoyLCJuYW1lIjoiWWFxdWIgQWRleWV5ZSIsImVtYWlsIjoieWFxdWJAZ21haWwuY29tIiwicm9sZUlkIjoyLCJSb2xlIjp7ImlkIjoyLCJyb2xlX25hbWUiOiJ1c2VyIiwicm9sZV9kZXNjcmlwdGlvbiI6IkJhc2ljIHVzZXIiLCJjcmVhdGVkQXQiOm51bGwsIn', '2023-09-30 18:20:42', '2023-10-01 08:16:34'),
(3, 'Yaqub Raheem', 'yaqub.adesola@gmail.com', '$2b$10$IrKA.UH443YitfPRNv8/CeWpe66BB2JHxcPF3KHrFHozV20kI0GLi', 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyRGV0Ijp7ImlkIjozLCJuYW1lIjoiWWFxdWIgUmFoZWVtIiwiZW1haWwiOiJ5YXF1Yi5hZGVzb2xhQGdtYWlsLmNvbSIsInJvbGVJZCI6MSwiUm9sZSI6eyJpZCI6MSwicm9sZV9uYW1lIjoiYWRtaW4iLCJyb2xlX2Rlc2NyaXB0aW9uIjoiU3VwZXIgQWRtaW5pc3RyYXRvciIsIm', '2023-10-23 14:06:04', '2023-10-23 20:55:36'),
(4, 'Adesola Akande', 'akande@yahoo.com', '$2b$10$BhH4B7k2uht8lmplhYRnauAFO647.hh333L/AeTgCfzo1EnZqwKQK', 1, NULL, '2023-10-23 20:02:02', '2023-10-23 20:02:02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `perm_name` (`perm_name`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rolepermissions`
--
ALTER TABLE `rolepermissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roleId` (`roleId`),
  ADD KEY `permissionId` (`permissionId`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sequelizemeta`
--
ALTER TABLE `sequelizemeta`
  ADD PRIMARY KEY (`name`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `roleId` (`roleId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `rolepermissions`
--
ALTER TABLE `rolepermissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `rolepermissions`
--
ALTER TABLE `rolepermissions`
  ADD CONSTRAINT `rolepermissions_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `rolepermissions_ibfk_2` FOREIGN KEY (`permissionId`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
