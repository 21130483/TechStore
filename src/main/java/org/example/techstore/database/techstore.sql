
CREATE DATABASE IF NOT EXISTS `techstore` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `techstore`;


CREATE TABLE IF NOT EXISTS `users` (
                                       `email` varchar(50) NOT NULL,
    `phone_numbers` varchar(20) NOT NULL,
    `full_name` varchar(50) NOT NULL,
    `password` varchar(50) NOT NULL,
    `dob` date NOT NULL,
    `gender` varchar(20) NOT NULL,
    `role` varchar(20) NOT NULL,
    `access` varchar(20) NOT NULL,
    PRIMARY KEY (`email`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE IF NOT EXISTS `category` (
                                          `categoryID` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL,
    PRIMARY KEY (`categoryID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `products` (
                                          `productID` int(11) NOT NULL AUTO_INCREMENT,
    `categoryID` int(11) NOT NULl,
    `quantity` int(11) NOT NULL,
    `date_added` date NOT NULL,
    `price` int(11) NOT NULL,
    `sale` int(11) NOT NULL,
    `ordered_numbers` int(11) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `trademark` varchar(50) NOT NULL,
    `content` VARCHAR(1000) NOT NULL,

    PRIMARY KEY (`productID`),
    KEY `userID` (`categoryID`),
    CONSTRAINT `products_fk_categoryID` FOREIGN KEY (`categoryID`) REFERENCES `category` (`categoryID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE IF NOT EXISTS `vouchers` (
                                          `voucherID` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(50) NOT NULL,
    `sale` int(11) NOT NULL,
    `expired_date` date NOT NULL,
    `cond` int(11) NOT NULL,

    PRIMARY KEY (`voucherID`)
    ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



CREATE TABLE IF NOT EXISTS `wishes` (
                                        `email` varchar(50) NOT NULL,
    `productID` int(11) NOT NULL,
    PRIMARY KEY (`email`,`productID`),
    KEY `email` (`email`),
    KEY `productID` (`productID`),
    CONSTRAINT `wishes_fk_email` FOREIGN KEY (`email`) REFERENCES `users` (`email`),
    CONSTRAINT `wishes_fk_productID` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=UTF8MB4_UNICODE_CI;


CREATE TABLE IF NOT EXISTS `cart` (
                                      `email` varchar(50) NOT NULL,
    `productID` int(11) NOT NULL,
    `quantity` int(11) NOT NULL,
    `selected` TINYINT(1) NOT NULL,
    PRIMARY KEY (`email`,`productID`),
    KEY `email` (`email`),
    KEY `productID` (`productID`),
    CONSTRAINT `cart_fk_email` FOREIGN KEY (`email`) REFERENCES `users` (`email`),
    CONSTRAINT `cart_fk_productID` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=UTF8MB4_UNICODE_CI;




CREATE TABLE IF NOT EXISTS `purchases` (
                                           `email` varchar(50) NOT NULL,
    `productID` int(11) NOT NULL,
    `quantity` int(11) NOT NULL,
    `price` int(11) NOT NULL,
    `order_date` date NOT NULL,
    `status` int NOT NULL,
    `received_date` date,
    `star_number` int(11),
    `comment` varchar(100),
    `address` varchar(100),
    `date_rated` date,
    PRIMARY KEY (`email`,`productID`),
    KEY `email` (`email`),
    KEY `productID` (`productID`),
    CONSTRAINT `purchases_fk_email` FOREIGN KEY (`email`) REFERENCES `users` (`email`),
    CONSTRAINT `purchases_fk_productID` FOREIGN KEY (`productID`) REFERENCES `products` (`productID`)
    ) ENGINE=INNODB AUTO_INCREMENT=1  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




CREATE TABLE IF NOT EXISTS `address` (
                                         `addressID` int(11) NOT NULL AUTO_INCREMENT,
    `email` varchar(50) NOT NULL,
    `city` varchar(50) NOT NULL,
    `district` varchar(50) NOT NULL,
    `ward` varchar(50) NOT NULL,
    `detail` varchar(100) NOT NULL,
    PRIMARY KEY (`addressID`,`email`),
    KEY `email` (`email`),
    CONSTRAINT `address_fk_userID` FOREIGN KEY (`email`) REFERENCES `users` (`email`)
    ) ENGINE=INNODB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;







CREATE TABLE IF NOT EXISTS `uservouchers` (
                                              `email` varchar(50) NOT NULL,
    `voucherID` int(11) NOT NULL,
    `quantity` int(11) NOT NULL,
    PRIMARY KEY (`email`,`voucherID`),
    KEY `email` (`email`),
    KEY `voucherID` (`voucherID`),
    CONSTRAINT `uservouchers_fk_userID` FOREIGN KEY (`email`) REFERENCES `users` (`email`),
    CONSTRAINT `uservouchers_fk_voucherID` FOREIGN KEY (`voucherID`) REFERENCES `vouchers` (`voucherID`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




