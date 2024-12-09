--I got this .sql file by peforming a mysql dump on my already created RealEstate database in MariaDB
--All of this was orignally done using MariaDB

DROP DATABASE IF EXISTS RealEstate;

CREATE DATABASE RealEstate;

USE RealEstate;


DROP TABLE IF EXISTS `Agent`;
CREATE TABLE `Agent` (
  `agentId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `phone` char(12) NOT NULL,
  `firmId` int(11) NOT NULL,
  `dateStarted` date NOT NULL,
  PRIMARY KEY (`agentId`),
  KEY `firmId` (`firmId`),
  CONSTRAINT `agent_ibfk_1` FOREIGN KEY (`firmId`) REFERENCES `firm` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



LOCK TABLES `Agent` WRITE;
INSERT INTO `Agent` VALUES (1,'Johnathan Baker','4098767788',1,'2019-01-15'),(2,'Jane Smith','4567899876',2,'2019-06-20'),(3,'Sara Omega','1233214576',3,'2021-02-17'),(4,'Jim Bean','8572637213',4,'2018-03-28'),(5,'Morgan Manfree','8263890077',5,'2020-06-18');
UNLOCK TABLES;



DROP TABLE IF EXISTS `BusinessProperty`;
CREATE TABLE `BusinessProperty` (
  `address` varchar(50) NOT NULL,
  `type` char(20) NOT NULL,
  `size` int(11) NOT NULL,
  PRIMARY KEY (`address`),
  CONSTRAINT `BusinessProperty_ibfk_1` FOREIGN KEY (`address`) REFERENCES `property` (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;




LOCK TABLES `BusinessProperty` WRITE;
INSERT INTO `BusinessProperty` VALUES ('313 Leon Rd','Store Front',4000),('398 Orange St','Gas Station',3000),('424 Unix St','Grocery Store',4500),('764 Shack Cir','Mall',8000),('987 Showdown Cir','Office Space',2500);
UNLOCK TABLES;




DROP TABLE IF EXISTS `Buyer`;
CREATE TABLE `Buyer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `phone` char(12) NOT NULL,
  `propertyType` char(20) DEFAULT NULL,
  `bedrooms` int(11) DEFAULT NULL,
  `bathrooms` int(11) DEFAULT NULL,
  `businessPropertyType` char(20) DEFAULT NULL,
  `minimumPreferredPrice` int(11) NOT NULL,
  `maximumPreferredPrice` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



LOCK TABLES `Buyer` WRITE;
INSERT INTO `Buyer` VALUES (1,'Tom Hardy','1231231234','House',3,2,NULL,200000,800000),(2,'Emma Ju','3213214321','House',4,3,NULL,400000,500000),(3,'Jim Too','4564566543','Business Property',NULL,NULL,'Gas Station',400000,600000),(4,'Chris Hemis','7897899876','Business Property',NULL,NULL,'Store Front',500000,800000),(5,'Henry Cavill','9879877890','House',2,1,NULL,100000,200000);
UNLOCK TABLES;



DROP TABLE IF EXISTS `Firm`;
CREATE TABLE `Firm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `address` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;




LOCK TABLES `Firm` WRITE;
INSERT INTO `Firm` VALUES (1,'Elite Reality','567 Hollow Rd'),(2,'Prime Estates','900 Peace Loop'),(3,'Rocket Enterprise','450 June St'),(4,'Americas Alc','267 Discord Lane'),(5,'Real Law','167 Mammal Dr');
UNLOCK TABLES;


DROP TABLE IF EXISTS `House`;
CREATE TABLE `House` (
  `address` varchar(50) NOT NULL,
  `bedrooms` int(11) NOT NULL,
  `bathrooms` int(11) NOT NULL,
  `size` int(11) NOT NULL,
  PRIMARY KEY (`address`),
  CONSTRAINT `House_ibfk_1` FOREIGN KEY (`address`) REFERENCES `property` (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `House` WRITE;
INSERT INTO `House` VALUES ('288 Ash K St',3,2,1600),('321 Oak Dr',2,3,1200),('456 Apple Grove',4,3,2000),('650 Pine Cir',5,5,3000),('784 Homer St',2,2,1400), ('421 Blank Rd', 3, 2, 2800);
UNLOCK TABLES;


DROP TABLE IF EXISTS `Listings`;
CREATE TABLE `Listings` (
  `mlsNumber` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(50) NOT NULL,
  `agentId` int(11) NOT NULL,
  `dateListed` date NOT NULL,
  PRIMARY KEY (`mlsNumber`),
  KEY `address` (`address`),
  KEY `agentId` (`agentId`),
  CONSTRAINT `Listings_ibfk_1` FOREIGN KEY (`address`) REFERENCES `property` (`address`),
  CONSTRAINT `Listings_ibfk_2` FOREIGN KEY (`agentId`) REFERENCES `agent` (`agentId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


LOCK TABLES `Listings` WRITE;
INSERT INTO `Listings` VALUES (1,'398 Orange St',1,'2024-10-01'),(2,'424 Unix St',2,'2024-11-12'),(3,'650 Pine Cir',3,'2023-09-16'),(4,'450 June St',4,'2024-08-28'),(5,'456 Apple Grove',1,'2024-05-04'),(3, '421 Blank Rd', '2024-05-12');
UNLOCK TABLES;


DROP TABLE IF EXISTS `Property`;
CREATE TABLE `Property` (
  `address` varchar(50) NOT NULL,
  `ownerName` varchar(30) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `Property` WRITE;
INSERT INTO `Property` VALUES ('167 Mammal Dr','Ian',780000),('267 Discord Lane','Cameron',900000),('288 Ash K St','Kim',150000),('313 Leon Rd','Jack',800000),('321 Oak Dr','Charlie',550000),('398 Orange St','Robert',600000),('424 Unix St','Jim',850000),('450 June St','Faith',500000),('456 Apple Grove','Andres',5000000),('567 Hollow Rd','Andrea',700000),('650 Pine Cir','Eve',700000),('764 Shack Cir','Anthony',830000),('784 Homer St','Bob',250000),('900 Peace Loop','Gloria',670000),('987 Showdown Cir','Adriana',670000), ('421 Blank Rd', 'Chris', 467000);
UNLOCK TABLES;



DROP TABLE IF EXISTS `Works_With`;
CREATE TABLE `Works_With` (
  `buyerId` int(11) NOT NULL,
  `agentId` int(11) NOT NULL,
  PRIMARY KEY (`buyerId`,`agentId`),
  KEY `agentId` (`agentId`),
  CONSTRAINT `Works_With_ibfk_1` FOREIGN KEY (`buyerId`) REFERENCES `buyer` (`id`),
  CONSTRAINT `works_with_ibfk_2` FOREIGN KEY (`agentId`) REFERENCES `agent` (`agentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


LOCK TABLES `Works_With` WRITE;
INSERT INTO `Works_With` VALUES (1,1),(2,3),(3,2),(4,4),(5,5);
UNLOCK TABLES;
