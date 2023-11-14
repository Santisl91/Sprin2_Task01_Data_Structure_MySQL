-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`Hamburguesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Hamburguesa` (
  `hamburguesa_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) COLLATE 'utf8mb3_bin' NOT NULL,
  `description` VARCHAR(150) COLLATE 'utf8mb3_bin' NOT NULL,
  `image` VARCHAR(100) COLLATE 'utf8mb3_bin' NOT NULL,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`hamburguesa_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`bebida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`bebida` (
  `bebida_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) COLLATE 'utf8mb3_bin' NOT NULL,
  `description` VARCHAR(150) COLLATE 'utf8mb3_bin' NOT NULL,
  `image` VARCHAR(100) COLLATE 'utf8mb3_bin' NOT NULL,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`bebida_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`province` (
  `province_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) COLLATE 'utf8mb3_bin' NOT NULL,
  PRIMARY KEY (`province_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`location` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) COLLATE 'utf8mb3_bin' NOT NULL,
  `province_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  INDEX `province_id` (`province_id` ASC) VISIBLE,
  CONSTRAINT `location_ibfk_1`
    FOREIGN KEY (`province_id`)
    REFERENCES `Pizzeria`.`province` (`province_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`store` (
  `store_id` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(100) COLLATE 'utf8mb3_bin' NOT NULL,
  `postal_code` INT NOT NULL,
  `location_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`store_id`),
  INDEX `location_id` (`location_id` ASC) VISIBLE,
  CONSTRAINT `store_ibfk_1`
    FOREIGN KEY (`location_id`)
    REFERENCES `Pizzeria`.`location` (`location_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) COLLATE 'utf8mb3_bin' NOT NULL,
  `sure_name` VARCHAR(50) COLLATE 'utf8mb3_bin' NOT NULL,
  `nif` VARCHAR(10) COLLATE 'utf8mb3_bin' NOT NULL,
  `phone_number` INT NOT NULL,
  `employee_type` ENUM('deliveryman', 'cook') COLLATE 'utf8mb3_bin' NULL DEFAULT NULL,
  `store_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `store_id` (`store_id` ASC) VISIBLE,
  CONSTRAINT `employee_ibfk_1`
    FOREIGN KEY (`store_id`)
    REFERENCES `Pizzeria`.`store` (`store_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`pizza` (
  `pizza_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) COLLATE 'utf8mb3_bin' NOT NULL,
  `description` VARCHAR(150) COLLATE 'utf8mb3_bin' NOT NULL,
  `image` VARCHAR(100) COLLATE 'utf8mb3_bin' NOT NULL,
  `price` FLOAT NOT NULL,
  PRIMARY KEY (`pizza_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`product_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`product_order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `date_time` DATETIME NOT NULL,
  `delivery_type` ENUM('delivey', 'pick_up') COLLATE 'utf8mb3_bin' NOT NULL,
  `quantity` INT NOT NULL,
  `total_price` FLOAT NOT NULL,
  `employee_id` INT NULL DEFAULT NULL,
  `store_id` INT NULL DEFAULT NULL,
  `cantidad_hamburguesas` INT NULL DEFAULT NULL,
  `cantidad_bebidas` INT NULL DEFAULT NULL,
  `cantidad_pizzas` INT NULL DEFAULT NULL,
  `hamburguesa_id` INT NULL DEFAULT NULL,
  `bebida_id` INT NULL DEFAULT NULL,
  `pizza_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `FK_employee_id` (`employee_id` ASC) VISIBLE,
  INDEX `FK_store_id` (`store_id` ASC) VISIBLE,
  INDEX `hamburguesaID_FK` (`hamburguesa_id` ASC) VISIBLE,
  INDEX `pizzaID_FK` (`pizza_id` ASC) VISIBLE,
  INDEX `bebidaID_FK` (`bebida_id` ASC) VISIBLE,
  CONSTRAINT `bebidaID_FK`
    FOREIGN KEY (`bebida_id`)
    REFERENCES `Pizzeria`.`bebida` (`bebida_id`),
  CONSTRAINT `FK_employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Pizzeria`.`employee` (`employee_id`),
  CONSTRAINT `FK_store_id`
    FOREIGN KEY (`store_id`)
    REFERENCES `Pizzeria`.`store` (`store_id`),
  CONSTRAINT `hamburguesaID_FK`
    FOREIGN KEY (`hamburguesa_id`)
    REFERENCES `Pizzeria`.`Hamburguesa` (`hamburguesa_id`),
  CONSTRAINT `pizzaID_FK`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `Pizzeria`.`pizza` (`pizza_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) COLLATE 'utf8mb3_bin' NOT NULL,
  `last_name` VARCHAR(45) COLLATE 'utf8mb3_bin' NOT NULL,
  `address` VARCHAR(100) COLLATE 'utf8mb3_bin' NOT NULL,
  `post_code` INT NOT NULL,
  `location_id` INT NULL DEFAULT NULL,
  `phone_number` INT NULL DEFAULT NULL,
  `order_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `location_id` (`location_id` ASC) VISIBLE,
  INDEX `FK_order_id` (`order_id` ASC) VISIBLE,
  CONSTRAINT `customer_ibfk_1`
    FOREIGN KEY (`location_id`)
    REFERENCES `Pizzeria`.`location` (`location_id`),
  CONSTRAINT `FK_order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `Pizzeria`.`product_order` (`order_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`pizza_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`pizza_category` (
  `pizza_category_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) COLLATE 'utf8mb3_bin' NOT NULL,
  `pizza_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`pizza_category_id`),
  INDEX `pizza_id` (`pizza_id` ASC) VISIBLE,
  CONSTRAINT `pizza_category_ibfk_1`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `Pizzeria`.`pizza` (`pizza_id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
