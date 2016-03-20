-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema library
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema library
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `library` DEFAULT CHARACTER SET utf8 ;
USE `library` ;


-- -----------------------------------------------------
-- Table `library`.`publishing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`publishing` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `publishing_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`sub_author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`sub_author` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `second_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`author` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `second_name` VARCHAR(45) NOT NULL,
  `sub_author_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_author_sub_author1_idx` (`sub_author_id` ASC),
  CONSTRAINT `fk_author_sub_author1`
    FOREIGN KEY (`sub_author_id`)
    REFERENCES `library`.`sub_author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`book` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `book_name` VARCHAR(45) NOT NULL,
  `count_of_page` INT NOT NULL,
  `code` INT NULL,
  `description` VARCHAR(75) NOT NULL,
  `genre_id` INT NOT NULL,
  `publishing_id` INT NOT NULL,
  `author_id` INT,
  PRIMARY KEY (`id`),
  INDEX `fk_book_publishing1_idx` (`publishing_id` ASC),
  INDEX `fk_book_author1_idx` (`author_id` ASC),
  CONSTRAINT `fk_book_publishing1`
    FOREIGN KEY (`publishing_id`)
    REFERENCES `library`.`publishing` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `library`.`author` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`adress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`adress` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `street` VARCHAR(45) NULL,
  `number_of_street` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`reader`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`reader` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(45) NOT NULL,
  `adress_id1` INT NOT NULL,
  `book_id` INT NOT NULL,
  `date_of_isuue` DATE NULL,
  `delivery_date` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_adress1_idx` (`adress_id1` ASC),
  INDEX `fk_user_book1_idx` (`book_id` ASC),
  CONSTRAINT `fk_user_adress1`
    FOREIGN KEY (`adress_id1`)
    REFERENCES `library`.`adress` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `library`.`book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`genre` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `genre_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book_has_genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`book_has_genre` (
  `book_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`book_id`, `genre_id`),
  INDEX `fk_book_has_genre_genre1_idx` (`genre_id` ASC),
  INDEX `fk_book_has_genre_book1_idx` (`book_id` ASC),
  CONSTRAINT `fk_book_has_genre_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `library`.`book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_genre_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `library`.`genre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `library`.`book_instance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `library`.`book_instance` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `inventory_number` INT NOT NULL,
  `in_stock` TINYINT(1) NOT NULL,
  `reader_id` INT NOT NULL,
  `book_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_book_instance_reader1_idx` (`reader_id` ASC),
  INDEX `fk_book_instance_book1_idx` (`book_id` ASC),
  CONSTRAINT `fk_book_instance_reader1`
    FOREIGN KEY (`reader_id`)
    REFERENCES `library`.`reader` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_instance_book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `library`.`book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
