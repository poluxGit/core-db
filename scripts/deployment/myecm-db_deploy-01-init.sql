-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema myecm
-- -----------------------------------------------------
-- MyECM Database
DROP SCHEMA IF EXISTS `myecm` ;

-- -----------------------------------------------------
-- Schema myecm
--
-- MyECM Database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `myecm` DEFAULT CHARACTER SET utf8 ;
USE `myecm` ;

-- -----------------------------------------------------
-- Table `tapp_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tapp_users` ;

CREATE TABLE IF NOT EXISTS `tapp_users` (
  `login` VARCHAR(100) NOT NULL,
  `firstname` VARCHAR(50) NOT NULL,
  `lastname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`login`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tref_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_categories` ;

CREATE TABLE IF NOT EXISTS `tref_categories` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL,
  `code` VARCHAR(20) UNICODE NOT NULL,
  `title` VARCHAR(100) UNICODE NOT NULL DEFAULT 'Default Title',
  `description` TINYTEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  CONSTRAINT `fk_categories_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categories_users_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tref_tiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_tiers` ;

CREATE TABLE IF NOT EXISTS `tref_tiers` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL,
  `code` VARCHAR(20) NOT NULL,
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  CONSTRAINT `fk_tiers_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tiers_users_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tref_typesdoc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_typesdoc` ;

CREATE TABLE IF NOT EXISTS `tref_typesdoc` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL,
  `code` VARCHAR(20) UNICODE NOT NULL,
  `title` VARCHAR(100) UNICODE NOT NULL DEFAULT 'Default Title',
  `description` TINYTEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  CONSTRAINT `fk_typesdoc_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_typesdoc_users_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tdta_containers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tdta_containers` ;

CREATE TABLE IF NOT EXISTS `tdta_containers` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL,
  `code` VARCHAR(20) UNICODE NOT NULL,
  `rootpath` VARCHAR(400) NULL DEFAULT NULL,
  `title` VARCHAR(100) UNICODE NOT NULL DEFAULT 'Default Title',
  `description` TINYTEXT NULL DEFAULT NULL COMMENT 'Table des conteneurs d\'objets.',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  CONSTRAINT `fk_container_user_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_container_user_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tdta_fichiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tdta_fichiers` ;

CREATE TABLE IF NOT EXISTS `tdta_fichiers` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL,
  `filename` VARCHAR(20) UNICODE NOT NULL,
  `filepath` VARCHAR(400) NOT NULL,
  `filesize` BIGINT NOT NULL DEFAULT 0,
  `mime` VARCHAR(100) NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  CONSTRAINT `fk_fichiers_user_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fichiers_user_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobj_documents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tobj_documents` ;

CREATE TABLE IF NOT EXISTS `tobj_documents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL,
  `code` VARCHAR(20) UNICODE NOT NULL,
  `version` INT NOT NULL DEFAULT 1,
  `revision` INT NOT NULL DEFAULT 1,
  `typedoc_code` VARCHAR(20) UNICODE NOT NULL,
  `ctnr_code` VARCHAR(20) UNICODE NOT NULL,
  `title` VARCHAR(100) UNICODE NOT NULL DEFAULT 'Default Title',
  `description` TINYTEXT NULL DEFAULT NULL,
  `year` INT NOT NULL,
  `month` INT NOT NULL DEFAULT 0,
  `day` INT NOT NULL DEFAULT 0,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `json_data` TEXT NULL DEFAULT NULL,
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  INDEX `fk_tref_documents_tref_typesdoc_code_idx` (`typedoc_code` ASC),
  INDEX `fk_tref_documents_tref_containers_code_idx` (`ctnr_code` ASC),
  PRIMARY KEY (`id`, `uid`),
  CONSTRAINT `fk_documents_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documents_users_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documents_typesdoc_code`
    FOREIGN KEY (`typedoc_code`)
    REFERENCES `tref_typesdoc` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documents_containers_code`
    FOREIGN KEY (`ctnr_code`)
    REFERENCES `tdta_containers` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tlnk_documents_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tlnk_documents_categories` ;

CREATE TABLE IF NOT EXISTS `tlnk_documents_categories` (
  `doc_uid` VARCHAR(15) NOT NULL,
  `cat_uid` VARCHAR(15) NOT NULL,
  `isMain` TINYINT NOT NULL DEFAULT 1,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`doc_uid`, `cat_uid`),
  INDEX `fk_categories_idx` (`cat_uid` ASC),
  INDEX `fk_lnk_docs_cats_users_create_idx` (`cuser` ASC),
  CONSTRAINT `fk_lnk_docs_cats_uid`
    FOREIGN KEY (`doc_uid`)
    REFERENCES `tobj_documents` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_cats_uid`
    FOREIGN KEY (`cat_uid`)
    REFERENCES `tref_categories` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_docs_cats_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tlnk_documents_tiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tlnk_documents_tiers` ;

CREATE TABLE IF NOT EXISTS `tlnk_documents_tiers` (
  `doc_uid` VARCHAR(15) NOT NULL,
  `tier_uid` VARCHAR(15) NOT NULL,
  `isMain` TINYINT NOT NULL DEFAULT 1,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`doc_uid`, `tier_uid`),
  INDEX `fk_tiers_idx` (`tier_uid` ASC),
  INDEX `fk_lnk_docs_tiers_users_create_idx` (`cuser` ASC),
  CONSTRAINT `fk_lnk_docs_tiers_uid`
    FOREIGN KEY (`doc_uid`)
    REFERENCES `tobj_documents` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_tiers_uid`
    FOREIGN KEY (`tier_uid`)
    REFERENCES `tref_tiers` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_docs_tiers_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tref_typesdoc_metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_typesdoc_metadata` ;

CREATE TABLE IF NOT EXISTS `tref_typesdoc_metadata` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL,
  `code` VARCHAR(20) UNICODE NOT NULL,
  `typedoc_code` VARCHAR(20) UNICODE NOT NULL,
  `title` VARCHAR(100) UNICODE NOT NULL DEFAULT 'Default Title',
  `description` TINYTEXT NULL DEFAULT NULL,
  `order_number` INT NOT NULL DEFAULT 0,
  `isMandatory` TINYINT NOT NULL DEFAULT 0,
  `json_data` TEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`, `code`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  INDEX `fk_typedocs_idx` (`typedoc_code` ASC),
  CONSTRAINT `fk_typesdoc_metadata_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_typesdoc_metadata_users_create_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_typedocs_meta_meta_code`
    FOREIGN KEY (`typedoc_code`)
    REFERENCES `tref_typesdoc` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tdta_metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tdta_metadata` ;

CREATE TABLE IF NOT EXISTS `tdta_metadata` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL,
  `code` VARCHAR(20) UNICODE NOT NULL,
  `typedoc_code` VARCHAR(20) UNICODE NOT NULL,
  `tdocmeta_code` VARCHAR(20) UNICODE NOT NULL,
  `doc_uid` VARCHAR(15) NOT NULL,
  `title` VARCHAR(100) UNICODE NOT NULL DEFAULT 'Default Title',
  `value` TINYTEXT NULL DEFAULT NULL,
  `json_data` TEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`, `code`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  INDEX `fk_typedocs_idx` (`typedoc_code` ASC),
  INDEX `fk_typedocs_metadata_code_idx` (`tdocmeta_code` ASC),
  INDEX `fk_documents_uid_idx` (`doc_uid` ASC),
  CONSTRAINT `fk_metadata_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_metadata_users_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_metadata_typedocs_code`
    FOREIGN KEY (`typedoc_code`)
    REFERENCES `tref_typesdoc` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_metadata_tdocs_meta_code`
    FOREIGN KEY (`tdocmeta_code`)
    REFERENCES `tref_typesdoc_metadata` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_metadata_documents_uid`
    FOREIGN KEY (`doc_uid`)
    REFERENCES `tobj_documents` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tlnk_documents_fichiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tlnk_documents_fichiers` ;

CREATE TABLE IF NOT EXISTS `tlnk_documents_fichiers` (
  `doc_code` VARCHAR(20) UNICODE NOT NULL,
  `fic_uid` VARCHAR(15) NOT NULL,
  `order_number` INT NOT NULL DEFAULT 0,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`doc_code`, `fic_uid`),
  INDEX `fk_fichiers_uid_idx` (`fic_uid` ASC),
  INDEX `fk_lnk_docs_fics_user_create_idx` (`cuser` ASC),
  CONSTRAINT `fk_lnk_docs_fics_uid`
    FOREIGN KEY (`doc_code`)
    REFERENCES `tobj_documents` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_fics_uid`
    FOREIGN KEY (`fic_uid`)
    REFERENCES `tdta_fichiers` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_docs_fics_user_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tlog_events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tlog_events` ;

CREATE TABLE IF NOT EXISTS `tlog_events` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(20) NOT NULL,
  `target` VARCHAR(100) NOT NULL DEFAULT 'Objet non défini',
  `message` TEXT NULL,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_users_idx` (`cuser` ASC),
  CONSTRAINT `fk_logevent_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `myecm` ;

-- -----------------------------------------------------
-- procedure logDataInsert
-- -----------------------------------------------------

USE `myecm`;
DROP procedure IF EXISTS `logDataInsert`;

DELIMITER $$
USE `myecm`$$
CREATE PROCEDURE logDataInsert ( IN pStrTableName VARCHAR(100), IN pStrUIDObject VARCHAR(15), IN pStrCode VARCHAR(20))
BEGIN
	DECLARE lMsg TEXT;
    SET lMsg = CONCAT('Ajout de "',pStrCode,'" dans la tabble "',pStrTableName,'".');
	INSERT INTO `tlog_events` (`type`, `target`, `message`) VALUES ('DATA_INSERT', pStrUIDObject, lMsg);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure logDataUpdate
-- -----------------------------------------------------

USE `myecm`;
DROP procedure IF EXISTS `logDataUpdate`;

DELIMITER $$
USE `myecm`$$
CREATE PROCEDURE logDataUpdate ( IN pStrTableName VARCHAR(100), IN pStrUIDObject VARCHAR(15), IN pStrCode VARCHAR(20))
BEGIN
	DECLARE lMsg TEXT;
    SET lMsg = CONCAT('Mise à jour de "',pStrCode,'" dans la tabble "',pStrTableName,'".');
	INSERT INTO `tlog_events` (`type`, `target`, `message`) VALUES ('DATA_UPDATE', pStrUIDObject, lMsg);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function coreGetAutoIncrementNextValue
-- -----------------------------------------------------

USE `myecm`;
DROP function IF EXISTS `coreGetAutoIncrementNextValue`;

DELIMITER $$
USE `myecm`$$
create function coreGetAutoIncrementNextValue(pStrTablename VARCHAR(100)) RETURNS INT
BEGIN
	DECLARE pk_ai_currentTable INT DEFAULT 0;

    select auto_increment into pk_ai_currentTable
		from information_schema.tables
		where table_name = pStrTablename
		and table_schema = database();

	RETURN pk_ai_currentTable;
END$$

DELIMITER ;
USE `myecm`;

DELIMITER $$

USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_categories_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_categories_BEFORE_INSERT` BEFORE INSERT ON `tref_categories` FOR EACH ROW
BEGIN
	SET NEW.uid = CONCAT('CAT-',UCASE(NEW.code));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_categories_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_categories_AFTER_INSERT` AFTER INSERT ON `tref_categories` FOR EACH ROW
BEGIN
	CALL logDataInsert('tref_categories',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_categories_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_categories_BEFORE_UPDATE` BEFORE UPDATE ON `tref_categories` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_categories_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_categories_AFTER_UPDATE` AFTER UPDATE ON `tref_categories` FOR EACH ROW
BEGIN
	CALL logDataUpdate('tref_categories',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_tiers_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_tiers_BEFORE_INSERT` BEFORE INSERT ON `tref_tiers` FOR EACH ROW
BEGIN
	SET NEW.uid = CONCAT('TIER-',UCASE(NEW.code));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_tiers_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_tiers_AFTER_INSERT` AFTER INSERT ON `tref_tiers` FOR EACH ROW
BEGIN
	CALL logDataInsert('tref_tiers',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_tiers_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_tiers_BEFORE_UPDATE` BEFORE UPDATE ON `tref_tiers` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_tiers_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_tiers_AFTER_UPDATE` AFTER UPDATE ON `tref_tiers` FOR EACH ROW
BEGIN
CALL logDataUpdate('tref_tiers',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_BEFORE_INSERT` BEFORE INSERT ON `tref_typesdoc` FOR EACH ROW
BEGIN

	SET NEW.uid = CONCAT('TDOC-',UCASE(NEW.code));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_AFTER_INSERT` AFTER INSERT ON `tref_typesdoc` FOR EACH ROW
BEGIN
	CALL logDataInsert('tref_typesdoc',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_BEFORE_UPDATE` BEFORE UPDATE ON `tref_typesdoc` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_AFTER_UPDATE` AFTER UPDATE ON `tref_typesdoc` FOR EACH ROW
BEGIN
	CALL logDataUpdate('tref_typesdoc',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_containers_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_containers_BEFORE_INSERT` BEFORE INSERT ON `tdta_containers` FOR EACH ROW
BEGIN
	DECLARE pk_ai_currentTable INT DEFAULT 0;
    SELECT coreGetAutoIncrementNextValue('tdta_containers') INTO pk_ai_currentTable;
	SET NEW.uid = CONCAT('CTNR-',LPAD(CONVERT(pk_ai_currentTable,CHAR),10,'0'));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_containers_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_containers_AFTER_INSERT` AFTER INSERT ON `tdta_containers` FOR EACH ROW
BEGIN
	CALL logDataInsert('tdta_containers',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_containers_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_containers_BEFORE_UPDATE` BEFORE UPDATE ON `tdta_containers` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_containers_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_containers_AFTER_UPDATE` AFTER UPDATE ON `tdta_containers` FOR EACH ROW
BEGIN
	CALL logDataUpdate('tdta_containers',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_fichiers_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_fichiers_BEFORE_INSERT` BEFORE INSERT ON `tdta_fichiers` FOR EACH ROW
BEGIN
	DECLARE pk_ai_currentTable INT DEFAULT 0;
    SELECT coreGetAutoIncrementNextValue('tdta_fichiers') INTO pk_ai_currentTable;
	SET NEW.uid = CONCAT('FIC-',LPAD(CONVERT(pk_ai_currentTable,CHAR),11,'0'));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_fichiers_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_fichiers_AFTER_INSERT` AFTER INSERT ON `tdta_fichiers` FOR EACH ROW
BEGIN
	CALL logDataInsert('tdta_fichiers',NEW.uid,NEW.filepath);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_fichiers_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_fichiers_BEFORE_UPDATE` BEFORE UPDATE ON `tdta_fichiers` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_fichiers_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_fichiers_AFTER_UPDATE` AFTER UPDATE ON `tdta_fichiers` FOR EACH ROW
BEGIN
	CALL logDataUpdate('tdta_fichiers',NEW.uid,NEW.filepath);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tobj_documents_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tobj_documents_BEFORE_INSERT` BEFORE INSERT ON `tobj_documents` FOR EACH ROW
BEGIN
	DECLARE pk_ai_currentTable INT DEFAULT 0;
    DECLARE s_Code VARCHAR(20);

    SELECT coreGetAutoIncrementNextValue('tobj_documents') INTO pk_ai_currentTable;

	SET s_Code = CONCAT('D-',NEW.typedoc_code,'-',CONVERT(NEW.year,CHAR),'-',LPAD(CONVERT(pk_ai_currentTable,CHAR),8,'0'));

	SET NEW.uid = CONCAT(s_Code,'_',LPAD(CONVERT(NEW.version,CHAR),2,'0'),'.',LPAD(CONVERT(NEW.revision,CHAR),3,'0'));
    SET NEW.code = s_Code;
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tobj_documents_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tobj_documents_AFTER_INSERT` AFTER INSERT ON `tobj_documents` FOR EACH ROW
BEGIN
	CALL logDataInsert('tobj_documents',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tobj_documents_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tobj_documents_BEFORE_UPDATE` BEFORE UPDATE ON `tobj_documents` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tobj_documents_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tobj_documents_AFTER_UPDATE` AFTER UPDATE ON `tobj_documents` FOR EACH ROW
BEGIN
	CALL logDataUpdate('tobj_documents',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_metadata_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_metadata_BEFORE_INSERT` BEFORE INSERT ON `tref_typesdoc_metadata` FOR EACH ROW
BEGIN
	DECLARE lStrCode VARCHAR(20);
    DECLARE iNbMetaTypeDoc INT;
    DECLARE pk_ai_currentTable INT DEFAULT 0;


    SELECT coreGetAutoIncrementNextValue('tref_typesdoc_metadata') INTO pk_ai_currentTable;
    SELECT COUNT(uid) into iNbMetaTypeDoc
		FROM tref_typesdoc_metadata
		WHERE typedoc_code = NEW.typedoc_code;

	SET lStrCode = CONCAT('TMDC-',NEW.typedoc_code,'-');

    SET NEW.uid = CONCAT('TMDC-',LPAD(CONVERT(pk_ai_currentTable,CHAR),10,'0'));
	SET NEW.code = CONCAT(lStrCode,LPAD(CONVERT(iNbMetaTypeDoc+1,CHAR),20-CHAR_LENGTH(lStrCode),'0'));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_metadata_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_metadata_AFTER_INSERT` AFTER INSERT ON `tref_typesdoc_metadata` FOR EACH ROW
BEGIN
	CALL logDataInsert('tref_typesdoc_metadata',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_metadata_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_metadata_BEFORE_UPDATE` BEFORE UPDATE ON `tref_typesdoc_metadata` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_metadata_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_metadata_AFTER_UPDATE` AFTER UPDATE ON `tref_typesdoc_metadata` FOR EACH ROW
BEGIN
	CALL logDataUpdate('tref_typesdoc_metadata',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_metadata_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_metadata_BEFORE_INSERT` BEFORE INSERT ON `tdta_metadata` FOR EACH ROW
BEGIN

	DECLARE pk_ai_currentTable INT DEFAULT 0;

    SELECT coreGetAutoIncrementNextValue('tdta_metadata') INTO pk_ai_currentTable;

	SET NEW.uid = CONCAT('MDOC-',LPAD(CONVERT(pk_ai_currentTable,CHAR),10,'0'));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_metadata_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_metadata_AFTER_INSERT` AFTER INSERT ON `tdta_metadata` FOR EACH ROW
BEGIN
	CALL logDataInsert('tdta_containers',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_metadata_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_metadata_BEFORE_UPDATE` BEFORE UPDATE ON `tdta_metadata` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_metadata_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_metadata_AFTER_UPDATE` AFTER UPDATE ON `tdta_metadata` FOR EACH ROW
BEGIN
	CALL logDataUpdate('tdta_metadata',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tlog_events_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tlog_events_BEFORE_INSERT` BEFORE INSERT ON `tlog_events` FOR EACH ROW
BEGIN
	SET NEW.cuser = CURRENT_USER;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
