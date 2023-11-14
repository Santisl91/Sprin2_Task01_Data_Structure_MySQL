-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema CulAmpolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CulAmpolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CulAmpolla` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `CulAmpolla` ;

-- -----------------------------------------------------
-- Table `CulAmpolla`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CulAmpolla`.`Customer` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(20) NOT NULL,
  `Address` VARCHAR(100) NOT NULL,
  `Phone` INT NOT NULL,
  `Email` VARCHAR(30) NOT NULL,
  `RegistrationDay` DATE NULL DEFAULT NULL,
  `ReferrerID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `ReferrerID_FK` (`ReferrerID` ASC) VISIBLE,
  CONSTRAINT `ReferrerID_FK`
    FOREIGN KEY (`ReferrerID`)
    REFERENCES `CulAmpolla`.`Customer` (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CulAmpolla`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CulAmpolla`.`Employee` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CulAmpolla`.`Mark`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CulAmpolla`.`Mark` (
  `MarkID` INT NOT NULL AUTO_INCREMENT,
  `MarkName` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`MarkID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CulAmpolla`.`Suplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CulAmpolla`.`Suplier` (
  `SuplierID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(60) NOT NULL,
  `Address` VARCHAR(200) NOT NULL,
  `PhoneNumber` INT NOT NULL,
  `Fax` INT NULL DEFAULT NULL,
  `NIF` VARCHAR(10) NOT NULL,
  `GlassesID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`SuplierID`),
  INDEX `GlassesID` (`GlassesID` ASC) VISIBLE,
  CONSTRAINT `suplier_ibfk_1`
    FOREIGN KEY (`GlassesID`)
    REFERENCES `CulAmpolla`.`Glasses` (`GlassesID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CulAmpolla`.`Glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CulAmpolla`.`Glasses` (
  `GlassesID` INT NOT NULL AUTO_INCREMENT,
  `RigthCrystalColor` VARCHAR(30) NOT NULL,
  `LeftCrystalColor` VARCHAR(30) NOT NULL,
  `FrameType` ENUM('floating', 'paste', 'metallic') NOT NULL,
  `RigthCrystalGraduation` FLOAT(2,2) NOT NULL,
  `LeftCrystalGraduation` FLOAT(2,2) NOT NULL,
  `Price` INT NOT NULL,
  `MarkID` INT NULL DEFAULT NULL,
  `SuplierID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`GlassesID`),
  INDEX `MarkID` (`MarkID` ASC) VISIBLE,
  INDEX `SuplierID` (`SuplierID` ASC) VISIBLE,
  CONSTRAINT `glasses_ibfk_1`
    FOREIGN KEY (`MarkID`)
    REFERENCES `CulAmpolla`.`Mark` (`MarkID`),
  CONSTRAINT `glasses_ibfk_2`
    FOREIGN KEY (`SuplierID`)
    REFERENCES `CulAmpolla`.`Suplier` (`SuplierID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CulAmpolla`.`Sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CulAmpolla`.`Sales` (
  `Sales_Number` INT NOT NULL AUTO_INCREMENT,
  `SaleDate` DATE NOT NULL,
  `CustomerID` INT NULL DEFAULT NULL,
  `GlassesID` INT NULL DEFAULT NULL,
  `EmployeeID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Sales_Number`),
  INDEX `CustomerID` (`CustomerID` ASC) VISIBLE,
  INDEX `GlassesID` (`GlassesID` ASC) VISIBLE,
  INDEX `EmployeeID` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `sales_ibfk_1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `CulAmpolla`.`Customer` (`CustomerID`),
  CONSTRAINT `sales_ibfk_2`
    FOREIGN KEY (`GlassesID`)
    REFERENCES `CulAmpolla`.`Glasses` (`GlassesID`),
  CONSTRAINT `sales_ibfk_3`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `CulAmpolla`.`Employee` (`EmployeeID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
