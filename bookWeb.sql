

CREATE TABLE `bookWeb`.`MEMBER` (
  `CODE` INT NOT NULL AUTO_INCREMENT,
  `ID` VARCHAR(45) NULL,
  `PASSWORD` VARCHAR(100) NULL,
  `EMAIL` VARCHAR(100) NULL,
  `PHONE` VARCHAR(45) NULL,
  `NICKNAME` VARCHAR(45) NULL,
   ROLE VARCHAR(15) DEFAULT 'user';
  PRIMARY KEY (`CODE`));

CREATE TABLE `CATEGORY` (
  `CODE` int NOT NULL,
  `CATEGORY` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CODE`);
)

CREATE TABLE `SUBCATEGORY` (
  `CODE` int NOT NULL AUTO_INCREMENT,
  `CATEGORYCODE` int DEFAULT NULL,
  `SUB_CATEGORY` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`CODE`),
  UNIQUE KEY `CODE_UNIQUE` (`CODE`),
  KEY `CATEGORYCODE` (`CATEGORYCODE`),
  CONSTRAINT `subcategory_ibfk_1` FOREIGN KEY (`CATEGORYCODE`) REFERENCES `CATEGORY` (`CODE`)
);

CREATE TABLE `BOOK` (
  `CODE` int NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(100) DEFAULT NULL,
  `DETAIL` varchar(1000) DEFAULT NULL,
  `AUTHORITY` varchar(100) DEFAULT NULL,
  `SUBCATEGORY` int DEFAULT NULL,
  `PRICE` int DEFAULT NULL,
  `PUBLISHER` varchar(100) DEFAULT NULL,
  `DATE` datetime DEFAULT NULL,
  `IMAGE` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`CODE`),
  UNIQUE KEY `CODE_UNIQUE` (`CODE`)
) ;

CREATE TABLE `MEMBER` (
  `CODE` int NOT NULL,
  `ID` varchar(45) DEFAULT NULL,
  `PASSWORD` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  `PHONE` varchar(45) DEFAULT NULL,
  `NICKNAME` varchar(45) DEFAULT NULL,
  `ADMIN` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`CODE`)
);

