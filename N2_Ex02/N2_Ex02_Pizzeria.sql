-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`provincia` (
  `provincia_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`provincia_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`localidad` (
  `localidad_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `provincia_provincia_id` INT NOT NULL,
  PRIMARY KEY (`localidad_id`, `provincia_provincia_id`),
  INDEX `fk_localidad_provincia1_idx` (`provincia_provincia_id` ASC) VISIBLE,
  CONSTRAINT `fk_localidad_provincia1`
    FOREIGN KEY (`provincia_provincia_id`)
    REFERENCES `pizzeria`.`provincia` (`provincia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `cp` VARCHAR(5) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `localidad_localidad_id` INT NOT NULL,
  PRIMARY KEY (`id`, `localidad_localidad_id`),
  INDEX `fk_cliente_localidad_idx` (`localidad_localidad_id` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_localidad`
    FOREIGN KEY (`localidad_localidad_id`)
    REFERENCES `pizzeria`.`localidad` (`localidad_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`empleado` (
  `empleado_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `cargo` ENUM("Cocinero", "Repartidor") NOT NULL,
  PRIMARY KEY (`empleado_id`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`tienda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`tienda` (
  `tienda_id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NOT NULL,
  `cp` VARCHAR(45) NOT NULL,
  `tienda_localidad_id` INT NOT NULL,
  `tienda_localidad_provincia_id` INT NOT NULL,
  PRIMARY KEY (`tienda_id`, `tienda_localidad_id`, `tienda_localidad_provincia_id`),
  INDEX `fk_tienda_localidad1_idx` (`tienda_localidad_id` ASC, `tienda_localidad_provincia_id` ASC) VISIBLE,
  CONSTRAINT `fk_tienda_localidad1`
    FOREIGN KEY (`tienda_localidad_id` , `tienda_localidad_provincia_id`)
    REFERENCES `pizzeria`.`localidad` (`localidad_id` , `provincia_provincia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pedido` (
  `pedido_id` INT NOT NULL AUTO_INCREMENT,
  `fechahora` DATETIME NOT NULL,
  `recogida` ENUM("tienda", "domicilio") NOT NULL,
  `cantidad` INT NOT NULL,
  `total` FLOAT NOT NULL,
  `cliente_id` INT NOT NULL,
  `cliente_localidad_localidad_id` INT NOT NULL,
  `repartidor_pedido_id` INT NOT NULL,
  `pedido_tienda_id` INT NOT NULL,
  `tienda_tienda_localidad_id` INT NOT NULL,
  `tienda_tienda_localidad_provincia_id` INT NOT NULL,
  PRIMARY KEY (`pedido_id`, `pedido_tienda_id`, `tienda_tienda_localidad_id`, `tienda_tienda_localidad_provincia_id`),
  INDEX `fk_pedido_cliente1_idx` (`cliente_id` ASC, `cliente_localidad_localidad_id` ASC) VISIBLE,
  INDEX `fk_pedido_empleado1_idx` (`repartidor_pedido_id` ASC) VISIBLE,
  INDEX `fk_pedido_tienda1_idx` (`pedido_tienda_id` ASC, `tienda_tienda_localidad_id` ASC, `tienda_tienda_localidad_provincia_id` ASC) VISIBLE,
  CONSTRAINT `fk_pedido_cliente1`
    FOREIGN KEY (`cliente_id` , `cliente_localidad_localidad_id`)
    REFERENCES `pizzeria`.`cliente` (`id` , `localidad_localidad_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedido_empleado1`
    FOREIGN KEY (`repartidor_pedido_id`)
    REFERENCES `pizzeria`.`empleado` (`empleado_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pedido_tienda1`
    FOREIGN KEY (`pedido_tienda_id` , `tienda_tienda_localidad_id` , `tienda_tienda_localidad_provincia_id`)
    REFERENCES `pizzeria`.`tienda` (`tienda_id` , `tienda_localidad_id` , `tienda_localidad_provincia_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`categoria` (
  `categoria_id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL COMMENT 'Puede cambiar de nombre a lo largo del año',
  PRIMARY KEY (`categoria_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`producto` (
  `producto_id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `imagen` BLOB NULL,
  `precio` FLOAT NOT NULL,
  `pedido_pedido_id` INT NOT NULL,
  `categoria_producto_id` INT NOT NULL,
  PRIMARY KEY (`producto_id`, `pedido_pedido_id`, `categoria_producto_id`),
  INDEX `fk_producto_pedido1_idx` (`pedido_pedido_id` ASC) VISIBLE,
  INDEX `fk_producto_categoria1_idx` (`categoria_producto_id` ASC) VISIBLE,
  CONSTRAINT `fk_producto_pedido1`
    FOREIGN KEY (`pedido_pedido_id`)
    REFERENCES `pizzeria`.`pedido` (`pedido_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_producto_categoria1`
    FOREIGN KEY (`categoria_producto_id`)
    REFERENCES `pizzeria`.`categoria` (`categoria_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
