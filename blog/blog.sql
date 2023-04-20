-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema wf3_blog
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema wf3_blog
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `wf3_blog` DEFAULT CHARACTER SET utf8 ;
USE `wf3_blog` ;

-- -----------------------------------------------------
-- Table `wf3_blog`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wf3_blog`.`user` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(60) NOT NULL,
  `lastname` VARCHAR(60) NOT NULL,
  `fullname` VARCHAR(121) GENERATED ALWAYS AS (CONCAT(`firstname`," ",`lastname`)) STORED,
  `sreenname` VARCHAR(63) NOT NULL,
  `nickname` VARCHAR(40) NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role` ENUM('user', 'contributor', 'moderator', 'administrator') NOT NULL DEFAULT 'user',
  `birth_place` VARCHAR(60) NOT NULL,
  `birth_date` DATE NULL,
  `gender` ENUM('M', 'N', 'F') NOT NULL DEFAULT 'N',
  `phone_number` VARCHAR(20) NULL,
  `profile_picture` VARCHAR(40) NOT NULL DEFAULT 'no-picture.jpg',
  `profile_banner` VARCHAR(40) NOT NULL DEFAULT 'no-banner.jpg',
  `profile_description` TEXT NULL,
  `register_date` DATETIME NOT NULL DEFAULT NOW(),
  `last_connection_date` DATETIME NULL,
  `last_action_date` TIMESTAMP NULL,
  `country` CHAR(2) NULL,
  `is_deleted` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wf3_blog`.`article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wf3_blog`.`article` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(120) NOT NULL,
  `slug` VARCHAR(120) NOT NULL,
  `summary` TINYTEXT NULL,
  `excerpt_html` TINYTEXT NULL,
  `excerpt_text` TINYTEXT NULL,
  `illustration` VARCHAR(40) NULL,
  `illustration_excerpt` VARCHAR(40) NULL,
  `content_html` TEXT NOT NULL,
  `content_text` TEXT NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT NOW(),
  `review_at` DATETIME NULL,
  `publish_at` DATETIME NULL,
  `edit_at` DATETIME NULL,
  `counter_view` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
  `counter_read` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
  `counter_applause` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
  `read_time` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
  `reading_time` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
  `is_shareable` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
  `is_comment_allowed` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
  `is_comment_active` TINYINT(1) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `wf3_blog`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wf3_blog`.`comment` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` INT(11) UNSIGNED NULL,
  `article_id` INT(11) UNSIGNED NULL,
  `user_id` INT(11) UNSIGNED NULL,
  `title` VARCHAR(120) NULL,
  `created_at` DATETIME NOT NULL DEFAULT NOW(),
  `edit_at` DATETIME NULL,
  `publish_at` DATETIME NULL,
  `delete_at` DATETIME NULL,
  `delete_reason` ENUM('haine', 'harcelement', 'nuditide') NULL,
  `counter_like` SMALLINT(5) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `article__comment__article_id_idx` (`article_id` ASC) VISIBLE,
  INDEX `user__comment__user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `comment__comment__parent_id_idx` (`parent_id` ASC) VISIBLE,
  CONSTRAINT `article__comment__article_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `wf3_blog`.`article` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user__comment__user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `wf3_blog`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `comment__comment__parent_id`
    FOREIGN KEY (`parent_id`)
    REFERENCES `wf3_blog`.`comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wf3_blog`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wf3_blog`.`category` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(20) NULL,
  `color` CHAR(6) NULL,
  `illustration` VARCHAR(40) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wf3_blog`.`category_article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wf3_blog`.`category_article` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` INT(11) UNSIGNED NOT NULL,
  `article_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `category__category_article__category_id_idx` (`category_id` ASC) VISIBLE,
  INDEX `article__category_article__article_id_idx` (`article_id` ASC) VISIBLE,
  CONSTRAINT `category__category_article__category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `wf3_blog`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `article__category_article__article_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `wf3_blog`.`article` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wf3_blog`.`keywords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wf3_blog`.`keywords` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `article_id` INT(11) UNSIGNED NOT NULL,
  `values` VARCHAR(120) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `article__keywords__article_id_idx` (`article_id` ASC) VISIBLE,
  CONSTRAINT `article__keywords__article_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `wf3_blog`.`article` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wf3_blog`.`article_author`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wf3_blog`.`article_author` (
  `id` INT(11) UNSIGNED NOT NULL,
  `article_id` INT(11) UNSIGNED NOT NULL,
  `user_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `article__article_author__article_id_idx` (`article_id` ASC) VISIBLE,
  INDEX `author__article_author__user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `article__article_author__article_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `wf3_blog`.`article` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `author__article_author__user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `wf3_blog`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wf3_blog`.`sourcing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wf3_blog`.`sourcing` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `article_id` INT(11) UNSIGNED NOT NULL,
  `label` VARCHAR(80) NOT NULL,
  `url` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `article__sourcing__aricle_id_idx` (`article_id` ASC) VISIBLE,
  CONSTRAINT `article__sourcing__aricle_id`
    FOREIGN KEY (`article_id`)
    REFERENCES `wf3_blog`.`article` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
