-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 23 2026 г., 10:32
-- Версия сервера: 5.6.51
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `steam`
--

-- --------------------------------------------------------

--
-- Структура таблицы `inventory`
--

CREATE TABLE `inventory` (
  `inventory_item_ID` int(34) NOT NULL,
  `User_ID` int(34) NOT NULL,
  `Item_ID` int(34) NOT NULL,
  `Quantity` int(34) NOT NULL,
  `Is_Trade_Locked` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `item`
--

CREATE TABLE `item` (
  `name` varchar(37) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` int(37) NOT NULL,
  `price` int(37) NOT NULL,
  `status` varchar(37) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` int(37) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `listing`
--

CREATE TABLE `listing` (
  `Listing_ID` int(34) NOT NULL,
  `Seller_ID` int(34) NOT NULL,
  `Inventory_item_ID` int(34) NOT NULL,
  `Price` decimal(10,2) NOT NULL,
  `Listing_Date` datetime(6) NOT NULL,
  `Status` varchar(34) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `transaction`
--

CREATE TABLE `transaction` (
  `Transaction_ID` int(34) NOT NULL,
  `Buyer_ID` int(34) NOT NULL,
  `Listing_ID` int(34) NOT NULL,
  `Total_price` decimal(10,2) NOT NULL,
  `Transaction_Fee` decimal(10,2) NOT NULL,
  `Seller_Payout` decimal(10,2) NOT NULL,
  `Transaction_Date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `User`
--

CREATE TABLE `User` (
  `user_id` int(30) NOT NULL,
  `username` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registration_date` int(30) NOT NULL,
  `balance` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_item_ID`),
  ADD KEY `FK` (`User_ID`),
  ADD KEY `fkey` (`Item_ID`);

--
-- Индексы таблицы `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `FK` (`owner_id`);

--
-- Индексы таблицы `listing`
--
ALTER TABLE `listing`
  ADD PRIMARY KEY (`Listing_ID`),
  ADD KEY `FK` (`Seller_ID`),
  ADD KEY `fkey` (`Inventory_item_ID`);

--
-- Индексы таблицы `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`Transaction_ID`),
  ADD KEY `FK` (`Buyer_ID`),
  ADD KEY `fkey` (`Listing_ID`);

--
-- Индексы таблицы `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`user_id`);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`inventory_item_ID`) REFERENCES `listing` (`Inventory_item_ID`);

--
-- Ограничения внешнего ключа таблицы `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `item_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `inventory` (`Item_ID`);

--
-- Ограничения внешнего ключа таблицы `User`
--
ALTER TABLE `User`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `inventory` (`User_ID`),
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `transaction` (`Buyer_ID`),
  ADD CONSTRAINT `user_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `listing` (`Seller_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
