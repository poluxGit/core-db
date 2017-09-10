-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema myecm
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema myecm-tasks
-- -----------------------------------------------------
-- Tasks Management Shema.
--

-- -----------------------------------------------------
-- Table `tapp_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tapp_users` ;

CREATE TABLE IF NOT EXISTS `tapp_users` (
  `login` VARCHAR(100) NOT NULL,
  `firstname` VARCHAR(50) NOT NULL,
  `lastname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`login`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tdta_containers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tdta_containers` ;

CREATE TABLE IF NOT EXISTS `tdta_containers` (
  `id` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `rootpath` VARCHAR(400) NULL DEFAULT NULL,
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TINYTEXT NULL DEFAULT NULL COMMENT 'Table des conteneurs d\'objets.',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT(4) NOT NULL DEFAULT '1',
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
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
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `code_UNIQUE` ON `tdta_containers` (`code` ASC);

CREATE UNIQUE INDEX `uid_UNIQUE` ON `tdta_containers` (`uid` ASC);

CREATE INDEX `fk_tref_categories_tapp_users_idx` ON `tdta_containers` (`cuser` ASC);

CREATE INDEX `fk_tref_categories_tapp_users1_idx` ON `tdta_containers` (`uuser` ASC);


-- -----------------------------------------------------
-- Table `tref_typesdoc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_typesdoc` ;

CREATE TABLE IF NOT EXISTS `tref_typesdoc` (
  `id` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TINYTEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT(4) NOT NULL DEFAULT '1',
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
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
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `code_UNIQUE` ON `tref_typesdoc` (`code` ASC);

CREATE UNIQUE INDEX `uid_UNIQUE` ON `tref_typesdoc` (`uid` ASC);

CREATE INDEX `fk_tref_categories_tapp_users_idx` ON `tref_typesdoc` (`cuser` ASC);

CREATE INDEX `fk_tref_categories_tapp_users1_idx` ON `tref_typesdoc` (`uuser` ASC);


-- -----------------------------------------------------
-- Table `tobj_documents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tobj_documents` ;

CREATE TABLE IF NOT EXISTS `tobj_documents` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOUID',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `version` INT(11) NOT NULL DEFAULT '1',
  `revision` INT(11) NOT NULL DEFAULT '1',
  `typedoc_code` VARCHAR(20) NOT NULL,
  `ctnr_code` VARCHAR(20) NOT NULL,
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TINYTEXT NULL DEFAULT NULL,
  `year` INT(11) NOT NULL,
  `month` INT(11) NOT NULL DEFAULT '0',
  `day` INT(11) NOT NULL DEFAULT '0',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT(4) NOT NULL DEFAULT '1',
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`, `uid`),
  CONSTRAINT `fk_documents_containers_code`
    FOREIGN KEY (`ctnr_code`)
    REFERENCES `tdta_containers` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documents_typesdoc_code`
    FOREIGN KEY (`typedoc_code`)
    REFERENCES `tref_typesdoc` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documents_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documents_users_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 66
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `code_UNIQUE` ON `tobj_documents` (`code` ASC, `version` ASC, `revision` ASC);

CREATE UNIQUE INDEX `uid_UNIQUE` ON `tobj_documents` (`uid` ASC);

CREATE INDEX `fk_tref_categories_tapp_users_idx` ON `tobj_documents` (`cuser` ASC);

CREATE INDEX `fk_tref_categories_tapp_users1_idx` ON `tobj_documents` (`uuser` ASC);

CREATE INDEX `fk_tref_documents_tref_typesdoc_code_idx` ON `tobj_documents` (`typedoc_code` ASC);

CREATE INDEX `fk_tref_documents_tref_containers_code_idx` ON `tobj_documents` (`ctnr_code` ASC);


-- -----------------------------------------------------
-- Table `tref_typesdoc_metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_typesdoc_metadata` ;

CREATE TABLE IF NOT EXISTS `tref_typesdoc_metadata` (
  `id` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `typedoc_code` VARCHAR(20) NOT NULL,
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TINYTEXT NULL DEFAULT NULL,
  `order_number` INT(11) NOT NULL DEFAULT '0',
  `isMandatory` TINYINT(4) NOT NULL DEFAULT '0',
  `json_data` TEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`, `code`),
  CONSTRAINT `fk_typedocs_meta_meta_code`
    FOREIGN KEY (`typedoc_code`)
    REFERENCES `tref_typesdoc` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_typesdoc_metadata_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_typesdoc_metadata_users_create_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `code_UNIQUE` ON `tref_typesdoc_metadata` (`code` ASC);

CREATE UNIQUE INDEX `uid_UNIQUE` ON `tref_typesdoc_metadata` (`uid` ASC);

CREATE INDEX `fk_tref_categories_tapp_users_idx` ON `tref_typesdoc_metadata` (`cuser` ASC);

CREATE INDEX `fk_tref_categories_tapp_users1_idx` ON `tref_typesdoc_metadata` (`uuser` ASC);

CREATE INDEX `fk_typedocs_idx` ON `tref_typesdoc_metadata` (`typedoc_code` ASC);


-- -----------------------------------------------------
-- Table `tdta_metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tdta_metadata` ;

CREATE TABLE IF NOT EXISTS `tdta_metadata` (
  `id` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `typedoc_code` VARCHAR(20) NOT NULL,
  `tdocmeta_code` VARCHAR(20) NOT NULL,
  `doc_uid` VARCHAR(15) NOT NULL,
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `value` TINYTEXT NULL DEFAULT NULL,
  `json_data` TEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`, `code`),
  CONSTRAINT `fk_metadata_documents_uid`
    FOREIGN KEY (`doc_uid`)
    REFERENCES `tobj_documents` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_metadata_tdocs_meta_code`
    FOREIGN KEY (`tdocmeta_code`)
    REFERENCES `tref_typesdoc_metadata` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_metadata_typedocs_code`
    FOREIGN KEY (`typedoc_code`)
    REFERENCES `tref_typesdoc` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_metadata_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_metadata_users_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 47
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `code_UNIQUE` ON `tdta_metadata` (`code` ASC);

CREATE UNIQUE INDEX `uid_UNIQUE` ON `tdta_metadata` (`uid` ASC);

CREATE INDEX `fk_tref_categories_tapp_users_idx` ON `tdta_metadata` (`cuser` ASC);

CREATE INDEX `fk_tref_categories_tapp_users1_idx` ON `tdta_metadata` (`uuser` ASC);

CREATE INDEX `fk_typedocs_idx` ON `tdta_metadata` (`typedoc_code` ASC);

CREATE INDEX `fk_typedocs_metadata_code_idx` ON `tdta_metadata` (`tdocmeta_code` ASC);

CREATE INDEX `fk_documents_uid_idx` ON `tdta_metadata` (`doc_uid` ASC);


-- -----------------------------------------------------
-- Table `tref_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_categories` ;

CREATE TABLE IF NOT EXISTS `tref_categories` (
  `id` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TINYTEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT(4) NOT NULL DEFAULT '1',
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
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
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `code_UNIQUE` ON `tref_categories` (`code` ASC);

CREATE UNIQUE INDEX `uid_UNIQUE` ON `tref_categories` (`uid` ASC);

CREATE INDEX `fk_tref_categories_tapp_users_idx` ON `tref_categories` (`cuser` ASC);

CREATE INDEX `fk_tref_categories_tapp_users1_idx` ON `tref_categories` (`uuser` ASC);


-- -----------------------------------------------------
-- Table `tlnk_documents_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tlnk_documents_categories` ;

CREATE TABLE IF NOT EXISTS `tlnk_documents_categories` (
  `doc_uid` VARCHAR(15) NOT NULL,
  `cat_uid` VARCHAR(15) NOT NULL,
  `isMain` TINYINT(4) NOT NULL DEFAULT '1',
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`doc_uid`, `cat_uid`),
  CONSTRAINT `fk_lnk_cats_uid`
    FOREIGN KEY (`cat_uid`)
    REFERENCES `tref_categories` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_docs_cats_uid`
    FOREIGN KEY (`doc_uid`)
    REFERENCES `tobj_documents` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_docs_cats_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_categories_idx` ON `tlnk_documents_categories` (`cat_uid` ASC);

CREATE INDEX `fk_lnk_docs_cats_users_create_idx` ON `tlnk_documents_categories` (`cuser` ASC);


-- -----------------------------------------------------
-- Table `tobj_fichiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tobj_fichiers` ;

CREATE TABLE IF NOT EXISTS `tobj_fichiers` (
  `id` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `filename` VARCHAR(400) NOT NULL,
  `filepath` VARCHAR(1000) NOT NULL,
  `filesize` BIGINT(20) NOT NULL DEFAULT '0',
  `mime` VARCHAR(100) NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
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
ENGINE = InnoDB
AUTO_INCREMENT = 870
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `uid_UNIQUE` ON `tobj_fichiers` (`uid` ASC);

CREATE INDEX `fk_tref_categories_tapp_users_idx` ON `tobj_fichiers` (`cuser` ASC);

CREATE INDEX `fk_tref_categories_tapp_users1_idx` ON `tobj_fichiers` (`uuser` ASC);


-- -----------------------------------------------------
-- Table `tlnk_documents_fichiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tlnk_documents_fichiers` ;

CREATE TABLE IF NOT EXISTS `tlnk_documents_fichiers` (
  `doc_code` VARCHAR(20) NOT NULL,
  `fic_uid` VARCHAR(15) NOT NULL,
  `order_number` INT(11) NOT NULL DEFAULT '0',
  `isActive` TINYINT(4) NOT NULL DEFAULT '1',
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`doc_code`, `fic_uid`),
  CONSTRAINT `fk_lnk_docs_fics_uid`
    FOREIGN KEY (`doc_code`)
    REFERENCES `tobj_documents` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_docs_fics_user_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_fics_uid`
    FOREIGN KEY (`fic_uid`)
    REFERENCES `tobj_fichiers` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_fichiers_uid_idx` ON `tlnk_documents_fichiers` (`fic_uid` ASC);

CREATE INDEX `fk_lnk_docs_fics_user_create_idx` ON `tlnk_documents_fichiers` (`cuser` ASC);


-- -----------------------------------------------------
-- Table `tref_tiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_tiers` ;

CREATE TABLE IF NOT EXISTS `tref_tiers` (
  `id` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT(4) NOT NULL DEFAULT '1',
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
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
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `code_UNIQUE` ON `tref_tiers` (`code` ASC);

CREATE UNIQUE INDEX `uid_UNIQUE` ON `tref_tiers` (`uid` ASC);

CREATE INDEX `fk_tref_categories_tapp_users_idx` ON `tref_tiers` (`cuser` ASC);

CREATE INDEX `fk_tref_categories_tapp_users1_idx` ON `tref_tiers` (`uuser` ASC);


-- -----------------------------------------------------
-- Table `tlnk_documents_tiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tlnk_documents_tiers` ;

CREATE TABLE IF NOT EXISTS `tlnk_documents_tiers` (
  `doc_uid` VARCHAR(15) NOT NULL,
  `tier_uid` VARCHAR(15) NOT NULL,
  `isMain` TINYINT(4) NOT NULL DEFAULT '1',
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`doc_uid`, `tier_uid`),
  CONSTRAINT `fk_lnk_docs_tiers_uid`
    FOREIGN KEY (`doc_uid`)
    REFERENCES `tobj_documents` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_docs_tiers_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_tiers_uid`
    FOREIGN KEY (`tier_uid`)
    REFERENCES `tref_tiers` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_tiers_idx` ON `tlnk_documents_tiers` (`tier_uid` ASC);

CREATE INDEX `fk_lnk_docs_tiers_users_create_idx` ON `tlnk_documents_tiers` (`cuser` ASC);


-- -----------------------------------------------------
-- Table `tlog_events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tlog_events` ;

CREATE TABLE IF NOT EXISTS `tlog_events` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(20) NOT NULL,
  `target` VARCHAR(100) NOT NULL DEFAULT 'Objet non défini',
  `message` TEXT NULL DEFAULT NULL,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_logevent_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1259
DEFAULT CHARACTER SET = utf8;

CREATE INDEX `fk_users_idx` ON `tlog_events` (`cuser` ASC);


-- -----------------------------------------------------
-- Table `tref_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_status` ;

CREATE TABLE IF NOT EXISTS `tref_status` (
  `id` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL,
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT(4) NOT NULL DEFAULT '1',
  `json_data` TEXT NULL DEFAULT NULL,
  `tref_statuscol` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tiers_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `myecm`.`tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tiers_users_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `myecm`.`tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `uid_UNIQUE` ON `tref_status` (`uid` ASC);

CREATE INDEX `fk_tref_categories_tapp_users_idx` ON `tref_status` (`cuser` ASC);

CREATE INDEX `fk_tref_categories_tapp_users1_idx` ON `tref_status` (`uuser` ASC);

CREATE UNIQUE INDEX `code_UNIQUE` ON `tref_status` (`code` ASC);


-- -----------------------------------------------------
-- Table `tobj_tasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tobj_tasks` ;

CREATE TABLE IF NOT EXISTS `tobj_tasks` (
  `id` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Task Title',
  `description` TEXT NULL DEFAULT NULL,
  `status` VARCHAR(15) NULL,
  `percent` DECIMAL(5,2) NOT NULL DEFAULT 0.0,
  `starttime` TIMESTAMP NULL DEFAULT NULL,
  `endtime` TIMESTAMP NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT(4) NOT NULL DEFAULT '1',
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tasks_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `myecm`.`tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tasks_users_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `myecm`.`tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_tstatus`
    FOREIGN KEY (`status`)
    REFERENCES `tref_status` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `uid_UNIQUE` ON `tobj_tasks` (`uid` ASC);

CREATE INDEX `fk_tobj_tasks_tapp_users_idx` ON `tobj_tasks` (`cuser` ASC);

CREATE INDEX `fk_tobj_tasks_tapp_users1_idx` ON `tobj_tasks` (`uuser` ASC);

CREATE INDEX `fk_task_tstatus_idx` ON `tobj_tasks` (`status` ASC);


-- -----------------------------------------------------
-- Placeholder table for view `vobj_documents_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vobj_documents_history` (`uid` INT, `code` INT, `version` INT, `revision` INT, `typedoc_code` INT, `ctnr_code` INT, `title` INT, `description` INT, `year` INT, `month` INT, `day` INT, `ctime` INT, `cuser` INT, `utime` INT, `uuser` INT, `isActive` INT, `json_data` INT, `meta_json` INT, `fic_json` INT, `cat_json` INT, `tier_json` INT);

-- -----------------------------------------------------
-- Placeholder table for view `vobj_documents_last`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vobj_documents_last` (`uid` INT, `code` INT, `version` INT, `revision` INT, `typedoc_code` INT, `ctnr_code` INT, `title` INT, `description` INT, `year` INT, `month` INT, `day` INT, `ctime` INT, `cuser` INT, `utime` INT, `uuser` INT, `isActive` INT, `json_data` INT, `meta_json` INT, `fic_json` INT, `cat_json` INT, `tier_json` INT);

-- -----------------------------------------------------
-- Placeholder table for view `vobj_documents_lastuid`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vobj_documents_lastuid` (`code` INT, `version` INT, `revision` INT, `doc_uid` INT);

-- -----------------------------------------------------
-- Placeholder table for view `vobj_fichiers_notlinked`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vobj_fichiers_notlinked` (`uid` INT, `filename` INT, `filepath` INT, `filesize` INT, `mime` INT, `ctime` INT, `cuser` INT, `utime` INT, `uuser` INT, `json_data` INT);

-- -----------------------------------------------------
-- Placeholder table for view `vobj_fichiers_src_target`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vobj_fichiers_src_target` (`DOC_CODE` INT, `DOC_UID` INT, `FIC_UID` INT, `FIC_ORDER_FOR_DOC` INT, `SRC_FILEPATH` INT, `TRGT_FILEPATH` INT, `TRGT_FILENAME` INT, `TRGT_PATH` INT);

-- -----------------------------------------------------
-- Placeholder table for view `vobj_metadata_last`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vobj_metadata_last` (`id` INT, `uid` INT, `code` INT, `typedoc_code` INT, `tdocmeta_code` INT, `doc_uid` INT, `title` INT, `value` INT, `json_data` INT, `ctime` INT, `cuser` INT, `utime` INT, `uuser` INT, `isActive` INT);

-- -----------------------------------------------------
-- function _calculateProposedFilepath
-- -----------------------------------------------------
DROP function IF EXISTS `_calculateProposedFilepath`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` FUNCTION `_calculateProposedFilepath`(pStrFicUid VARCHAR(20)) RETURNS varchar(500) CHARSET utf8
BEGIN

	DECLARE containerPath VARCHAR(500);
    DECLARE docYear INT;
    DECLARE docMonth INT;
    DECLARE docDay INT;
    DECLARE fileExtension VARCHAR(500);
    DECLARE docTypeCode VARCHAR(500);
    DECLARE docTierCode VARCHAR(500);
    DECLARE docCode VARCHAR(500);
    DECLARE docTitle VARCHAR(500);
    DECLARE fileOrder INT;
    DECLARE fileTotal INT;
    DECLARE strResult VARCHAR(500);

	SET strResult = '';

	SELECT
		tcont.rootpath,
        tdoc.year,
        tdoc.month,
        tdoc.day,
        tdoc.typedoc_code,
        ttier.code,
        tdoc.title,
        tldf.order_number,
        SUBSTRING_INDEX(fic.filename,'.',-1), tldf.doc_code
	INTO
		containerPath,
        docYear,docMonth,docDay,
        docTypeCode,
        docTierCode,
        docTitle,
        fileOrder,
        fileExtension,docCode
	FROM
		tobj_fichiers fic
		INNER JOIN tlnk_documents_fichiers tldf ON tldf.fic_uid = fic.uid
		INNER JOIN tobj_documents tdoc ON tdoc.code = tldf.doc_code
		INNER JOIN tdta_containers tcont ON tcont.code = tdoc.ctnr_code
        INNER JOIN tlnk_documents_tiers tldt ON (tldt.doc_uid = tdoc.uid AND tldt.isMain = 1)
        INNER JOIN tref_tiers ttier ON (ttier.uid = tldt.tier_uid )
	WHERE
		fic.uid = pStrFicUid ;

    SELECT
		count(fic_uid)
	INTO
		fileTotal
	FROM
		tlnk_documents_fichiers tldf WHERE tldf.doc_code = docCode;


	IF ((NOT containerPath IS NULL) AND (NOT docTypeCode IS NULL) AND (NOT docTierCode IS NULL)) THEN

		SET strResult = CONCAT(containerPath,'/',docYear);

        IF (docMonth != 0 ) THEN
			SET strResult = CONCAT(strResult,LPAD(CONVERT(docMonth,CHAR),2,'0'));
        END IF;

        IF (docDay != 0 ) THEN
			SET strResult = CONCAT(strResult,LPAD(CONVERT(docDay,CHAR),2,'0'));
        END IF;

        SET strResult = CONCAT(strResult,'_',docTypeCode,
			'-',
			docTierCode,
			'_',
			replace(capitalize(docTitle),' ',''));

        IF(fileTotal>1) THEN
			SET strResult = CONCAT(strResult,'-',CONVERT(fileOrder,CHAR),'_',CONVERT(fileTotal,CHAR));
        END IF;
        SET strResult = CONCAT(strResult,'.',lower(fileExtension));

    END IF;

	RETURN strResult;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure _instanciateMetadataForDocument
-- -----------------------------------------------------
DROP procedure IF EXISTS `_instanciateMetadataForDocument`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` PROCEDURE `_instanciateMetadataForDocument`(IN pStrDocUid VARCHAR(15))
BEGIN
	declare lStrDocCode varchar(20);

    declare cptMetaDoc 	INT ;
    declare cptMeta 	INT ;
    declare cptDocMeta 	INT ;

    declare iPrevVerDoc	INT ;
    declare iPrevRevDoc	INT ;

    declare lStrTypeDocCode 	varchar(15);
    declare lStrMetaValue 	VARCHAR(4000) ;
    declare lStrMetaTitle 	varchar(100);
    declare lStrMetaCode 	varchar(20);
    declare lStrPrevDocUid 	varchar(15);
    declare lStrMetaJson 	TEXT;

    declare metaValue 	varchar(400);
    declare newMetaCode	varchar(20);

	declare done int default false;
	declare typedocmeta_cursor cursor for select code, title, json_data from `tref_typesdoc_metadata` where typedoc_code = lStrTypeDocCode order by order_number asc;
	declare continue handler for not found set done = true;

    select typedoc_code,version,revision into lStrTypeDocCode,iPrevVerDoc,iPrevRevDoc from tobj_documents where uid = pStrDocUid;

    select count(uid) into cptMetaDoc
    from tdta_metadata
    where typedoc_code = lStrTypeDocCode;

	open typedocmeta_cursor;

creationMeta_loop: loop

    set done = false;
    fetch typedocmeta_cursor into lStrMetaCode,lStrMetaTitle,lStrMetaJson;

    if done then
      leave creationMeta_loop;
    end if;

	SET cptMetaDoc = cptMetaDoc +1;
    SET metaValue = null;
	SET newMetaCode = CONCAT('MDOC-',lStrTypeDocCode,'-',LPAD(cast(cptMetaDoc as CHAR),2,'0'),'-',LPAD(cast(iPrevVerDoc as CHAR(10)),2,'0'),'.',LPAD(cast(iPrevRevDoc as CHAR(10)),3,'0'));

	IF iPrevVerDoc <> 1 OR iPrevRevDoc <>1 THEN
		SELECT value into metaValue FROM tdta_metadata
        WHERE tdocmeta_code =  lStrMetaCode ORDER BY code DESC LIMIT 1;
    END IF;

	insert into tdta_metadata (
			code,
			typedoc_code,
            tdocmeta_code,
			doc_uid,
			title,
			value,
			json_data
		) VALUES (
			newMetaCode,
			lStrTypeDocCode,
			lStrMetaCode,
			pStrDocUid,
			lStrMetaTitle,
			metaValue,
            lStrMetaJson
		);


end loop creationMeta_loop;

close typedocmeta_cursor;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addLinkDocumentToCategorie
-- -----------------------------------------------------
DROP procedure IF EXISTS `addLinkDocumentToCategorie`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` PROCEDURE `addLinkDocumentToCategorie`(IN pStrDocCode VARCHAR(20),IN pStrCatCode VARCHAR(20), IN pIntIsMain INT)
BEGIN

	DECLARE strDocUID VARCHAR(15);
    DECLARE strCatUID VARCHAR(15);

    SELECT uid INTO strCatUID
    FROM tref_categories
    WHERE code = pStrCatCode;

	select getLastDocUidFromCode(pStrDocCode) into strDocUID;

    IF pIntIsMain = 1 THEN
		UPDATE tlnk_documents_categories set isMain=0 WHERE doc_uid=strDocUID;
    END IF;


    INSERT INTO tlnk_documents_categories
	(
		`doc_uid`,
		`cat_uid`,
		`isMain`
	)
	VALUES
	(
		strDocUID,
		strCatUID,
		pIntIsMain
	);


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addLinkDocumentToFichier
-- -----------------------------------------------------
DROP procedure IF EXISTS `addLinkDocumentToFichier`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` PROCEDURE `addLinkDocumentToFichier`(IN pStrDocCode VARCHAR(20),IN pStrFicUID VARCHAR(15))
BEGIN

    DECLARE iNbFileDoc INTEGER;

    SELECT max(order_number) INTO iNbFileDoc FROM tlnk_documents_fichiers WHERE doc_code = pStrDocCode;

    IF iNbFileDoc IS NULL THEN
		SET iNbFileDoc = 0;
    END IF;

    INSERT INTO tlnk_documents_fichiers
	(
		`doc_code`,
		`fic_uid`,
		`order_number`
	)
	VALUES
	(
		pStrDocCode,
		pStrFicUID,
		iNbFileDoc+1
	);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addLinkDocumentToTier
-- -----------------------------------------------------
DROP procedure IF EXISTS `addLinkDocumentToTier`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` PROCEDURE `addLinkDocumentToTier`(IN pStrDocCode VARCHAR(20),IN pStrTierCode VARCHAR(20), IN pIntIsMain INT)
BEGIN

	DECLARE strDocUID VARCHAR(15);
    DECLARE strTierUID VARCHAR(15);

    SELECT uid INTO strTierUID
    FROM tref_tiers
    WHERE code = pStrTierCode;

	select getLastDocUidFromCode(pStrDocCode) into strDocUID;

    IF pIntIsMain = 1 THEN
		UPDATE tlnk_documents_tiers set isMain=0 WHERE doc_uid=strDocUID;
    END IF;


    INSERT INTO tlnk_documents_tiers
	(
		`doc_uid`,
		`tier_uid`,
		`isMain`
	)
	VALUES
	(
		strDocUID,
		strTierUID,
		pIntIsMain
	);


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addNewDocument
-- -----------------------------------------------------
DROP procedure IF EXISTS `addNewDocument`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` PROCEDURE `addNewDocument`(IN pStrTitle VARCHAR(100),IN pStrTypeDocCode VARCHAR(20), IN pIntYear INT)
BEGIN

	DECLARE strDocCode VARCHAR(20);
    DECLARE iCountDoc INT;

    SELECT count(distinct code) INTO iCountDoc
    FROM tobj_documents
    WHERE typedoc_code = pStrTypeDocCode AND year = pIntYear;

	SET strDocCode = CONCAT('D-',pStrTypeDocCode,'-',CONVERT(pIntYear,CHAR),'-',LPAD(CONVERT(iCountDoc+1,CHAR),4,'0'));

    INSERT INTO `tobj_documents`(
		`code`,
		`typedoc_code`,
		`ctnr_code`,
		`title`,
		`year`
	)
	VALUES
	(
		strDocCode,
		pStrTypeDocCode,
		'DEFAULT_CONTAINER',
		pStrTitle,
		pIntYear
	);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addNewDocumentFromFichier
-- -----------------------------------------------------
DROP procedure IF EXISTS `addNewDocumentFromFichier`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` PROCEDURE `addNewDocumentFromFichier`(IN pStrFicUID VARCHAR(15) , IN pStrTitle VARCHAR(100),IN pStrTypeDocCode VARCHAR(20), IN pIntYear INT)
BEGIN

	DECLARE strDocCode VARCHAR(20);
    DECLARE iCountDoc INT;


    SELECT count(distinct code) INTO iCountDoc
    FROM tobj_documents
    WHERE typedoc_code = pStrTypeDocCode AND year = pIntYear;

	SET strDocCode = CONCAT('D-',pStrTypeDocCode,'-',CONVERT(pIntYear,CHAR),'-',LPAD(CONVERT(iCountDoc+1,CHAR),4,'0'));

    INSERT INTO `tobj_documents`(
		`code`,
		`typedoc_code`,
		`ctnr_code`,
		`title`,
		`year`
	)
	VALUES
	(
		strDocCode,
		pStrTypeDocCode,
		'DEFAULT_CONTAINER',
		pStrTitle,
		pIntYear
	);

    CALL addLinkDocumentToFichier(strDocCode, pStrFicUID);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function capitalize
-- -----------------------------------------------------
DROP function IF EXISTS `capitalize`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` FUNCTION `capitalize`(s varchar(255)) RETURNS varchar(255) CHARSET utf8
BEGIN
  declare c int;
  declare x varchar(255);
  declare y varchar(255);
  declare z varchar(255);

  set x = UPPER( SUBSTRING( s, 1, 1));
  set y = SUBSTR( s, 2);
  set c = instr( y, ' ');

  while c > 0
    do
      set z = SUBSTR( y, 1, c);
      set x = CONCAT( x, z);
      set z = UPPER( SUBSTR( y, c+1, 1));
      set x = CONCAT( x, z);
      set y = SUBSTR( y, c+2);
      set c = INSTR( y, ' ');
  end while;
  set x = CONCAT(x, y);
  return x;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function coreGetAutoIncrementNextValue
-- -----------------------------------------------------
DROP function IF EXISTS `coreGetAutoIncrementNextValue`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` FUNCTION `coreGetAutoIncrementNextValue`(pStrTablename VARCHAR(100)) RETURNS int(11)
BEGIN
	DECLARE pk_ai_currentTable INT DEFAULT 0;

    select auto_increment into pk_ai_currentTable
		from information_schema.tables
		where table_name = pStrTablename
		and table_schema = database();

	RETURN pk_ai_currentTable;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function coreGetPreviousDocUID
-- -----------------------------------------------------
DROP function IF EXISTS `coreGetPreviousDocUID`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` FUNCTION `coreGetPreviousDocUID`(pStrDocUid VARCHAR(15)) RETURNS int(11)
BEGIN

	DECLARE strDocCode VARCHAR(20);
    DECLARE strPreviousDocUID VARCHAR(15) DEFAULT NULL;
    DECLARE iPrevVersion INT;
    DECLARE iPrevRevision INT;

    SELECT code, version, revision INTO strDocCode,iPrevVersion,iPrevRevision
    FROM tobj_documents
    WHERE
		uid = pStrDocUid;


    SELECT uid into strPreviousDocUID
    FROM
    (
		select version,revision
        from `tobj_documents`
        where code = strDocCode
        order by version desc, revision desc
	) tm
    WHERE (
		tm.version = iPrevVersion
        AND tm.revision < iPrevRevision
	)
    OR
    (
		tm.version < iPrevVersion
	)
    ORDER BY tm.version desc, tm.revision desc
    LIMIT 1;

    RETURN strPreviousDocUID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function coreGetPreviousRevision
-- -----------------------------------------------------
DROP function IF EXISTS `coreGetPreviousRevision`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` FUNCTION `coreGetPreviousRevision`(pStrDocUid VARCHAR(15)) RETURNS int(11)
BEGIN

	DECLARE iPrevVersion INT DEFAULT  0;
    DECLARE iPrevRevision INT DEFAULT  0;
    DECLARE iCurrVersion INT DEFAULT  0;
    DECLARE iCurrRevision INT DEFAULT  0;
    DECLARE strDocCode VARCHAR(20);

    SELECT code,version,revision INTO strDocCode,iCurrVersion,iCurrRevision
    FROM tobj_documents
    WHERE
		uid = pStrDocUid;

    SELECT tm.version, tm.revision
    INTO iPrevVersion, iPrevRevision
    FROM
    (
		select version,revision
        from `tobj_documents`
        where code = strDocCode
        order by version desc, revision desc
	) tm
    WHERE (
		tm.version = iCurrVersion
        AND tm.revision < iCurrRevision
	)
    OR
    (
		tm.version < iCurrVersion
	)
    ORDER BY tm.version desc, tm.revision desc
    LIMIT 1;

    RETURN iPrevRevision;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function coreGetPreviousVersion
-- -----------------------------------------------------
DROP function IF EXISTS `coreGetPreviousVersion`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` FUNCTION `coreGetPreviousVersion`(pStrDocUid VARCHAR(15)) RETURNS int(11)
BEGIN

	DECLARE iPrevVersion INT DEFAULT  0;
    DECLARE iPrevRevision INT DEFAULT  0;
    DECLARE iCurrVersion INT DEFAULT  0;
    DECLARE iCurrRevision INT DEFAULT  0;
    DECLARE strDocCode VARCHAR(20);

    SELECT code,version,revision INTO strDocCode,iCurrVersion,iCurrRevision
    FROM tobj_documents
    WHERE
		uid = pStrDocUid;

    SELECT tm.version, tm.revision
    INTO iPrevVersion, iPrevRevision
    FROM
    (
		select version,revision
        from `tobj_documents`
        where code = strDocCode
        order by version desc, revision desc
	) tm
    WHERE (
		tm.version = iCurrVersion
        AND tm.revision < iCurrRevision
	)
    OR
    (
		tm.version < iCurrVersion
	)
    ORDER BY tm.version desc, tm.revision desc
    LIMIT 1;

    RETURN iPrevVersion;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function getLastDocUidFromCode
-- -----------------------------------------------------
DROP function IF EXISTS `getLastDocUidFromCode`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` FUNCTION `getLastDocUidFromCode`(pStrDocCode VARCHAR(20)) RETURNS varchar(15) CHARSET utf8
BEGIN

	DECLARE strLastDocUID VARCHAR(15);
    DECLARE iPrevVersion INT;
    DECLARE iPrevRevision INT;

    SELECT uid INTO strLastDocUID
    FROM tobj_documents
    WHERE
		code = pStrDocCode
        AND version = getMaxVersionForDocFromCode(pStrDocCode)
        AND revision = getMaxRevisionForDocFromCode(pStrDocCode);

    RETURN strLastDocUID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function getMaxRevisionForDocFromCode
-- -----------------------------------------------------
DROP function IF EXISTS `getMaxRevisionForDocFromCode`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` FUNCTION `getMaxRevisionForDocFromCode`(pStrDocCode VARCHAR(20)) RETURNS int(11)
BEGIN

	DECLARE iPrevVersion INT;
    DECLARE iPrevRevision INT;

    SELECT MAX(revision) INTO iPrevVersion
    FROM tobj_documents
    WHERE
		code = pStrDocCode
        AND version = getMaxVersionForDocFromCode(pStrDocCode)
	GROUP BY code;

    return iPrevVersion;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function getMaxVersionForDocFromCode
-- -----------------------------------------------------
DROP function IF EXISTS `getMaxVersionForDocFromCode`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` FUNCTION `getMaxVersionForDocFromCode`(pStrDocCode VARCHAR(20)) RETURNS int(11)
BEGIN

	DECLARE iPrevVersion INT;
    DECLARE iPrevRevision INT;

    SELECT MAX(version) INTO iPrevVersion
    FROM tobj_documents
    WHERE
		code = pStrDocCode
	GROUP BY code;

    return iPrevVersion;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure logDataInsert
-- -----------------------------------------------------
DROP procedure IF EXISTS `logDataInsert`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` PROCEDURE `logDataInsert`( IN pStrTableName VARCHAR(100), IN pStrUIDObject VARCHAR(15), IN pStrCode VARCHAR(1000))
BEGIN
	DECLARE lMsg TEXT;
    SET lMsg = CONCAT('Ajout de "',pStrCode,'" dans la tabble "',pStrTableName,'".');
	INSERT INTO `tlog_events` (`type`, `target`, `message`) VALUES ('DATA_INSERT', pStrUIDObject, lMsg);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure logDataUpdate
-- -----------------------------------------------------
DROP procedure IF EXISTS `logDataUpdate`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` PROCEDURE `logDataUpdate`( IN pStrTableName VARCHAR(100), IN pStrUIDObject VARCHAR(15), IN pStrCode VARCHAR(1000))
BEGIN
	DECLARE lMsg TEXT;
    SET lMsg = CONCAT('Mise à jour de "',pStrCode,'" dans la table "',pStrTableName,'".');
	INSERT INTO `tlog_events` (`type`, `target`, `message`) VALUES ('DATA_UPDATE', pStrUIDObject, lMsg);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure removeLinkDocumentToCategorie
-- -----------------------------------------------------
DROP procedure IF EXISTS `removeLinkDocumentToCategorie`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` PROCEDURE `removeLinkDocumentToCategorie`(IN pStrDocCode VARCHAR(20),IN pStrCatCode VARCHAR(20))
BEGIN

	DECLARE strDocUID VARCHAR(15);
    DECLARE strCatUID VARCHAR(15);

    SELECT uid INTO strCatUID
    FROM tref_categories
    WHERE code = pStrCatCode;

	select getLastDocUidFromCode(pStrDocCode) into strDocUID;

	DELETE from tlnk_documents_categories WHERE doc_uid = strDocUID and cat_uid = strCatUID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure removeLinkDocumentToFichier
-- -----------------------------------------------------
DROP procedure IF EXISTS `removeLinkDocumentToFichier`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` PROCEDURE `removeLinkDocumentToFichier`(IN pStrDocCode VARCHAR(20),IN pStrFicUID VARCHAR(15))
BEGIN

	DELETE from tlnk_documents_fichiers WHERE doc_code = pStrDocCode and fic_uid = pStrFicUID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure removeLinkDocumentToTier
-- -----------------------------------------------------
DROP procedure IF EXISTS `removeLinkDocumentToTier`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` PROCEDURE `removeLinkDocumentToTier`(IN pStrDocCode VARCHAR(20),IN pStrTierCode VARCHAR(20))
BEGIN

	DECLARE strDocUID VARCHAR(15);
    DECLARE strTierUID VARCHAR(15);

    SELECT uid INTO strTierUID
    FROM tref_tiers
    WHERE code = pStrTierCode;

	select getLastDocUidFromCode(pStrDocCode) into strDocUID;

	DELETE from tlnk_documents_tiers WHERE doc_uid = strDocUID and tier_uid = strTierUID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure reviseDocument
-- -----------------------------------------------------
DROP procedure IF EXISTS `reviseDocument`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` PROCEDURE `reviseDocument`(IN pStrDocCode VARCHAR(20))
BEGIN

	DECLARE strDocUID VARCHAR(15);
    DECLARE iDocID INTEGER;
    DECLARE strNewDocUID VARCHAR(15);

    SELECT getLastDocUidFromCode(pStrDocCode) INTO strDocUID;

    INSERT INTO tobj_documents
	(
		`code`,
		`version`,
		`revision`,
		`typedoc_code`,
		`ctnr_code`,
		`title`,
		`description`,
		`year`,
		`month`,
		`day`,
		`json_data`
	)
	SELECT
		code,
		version,
		revision+1 as revision ,
		typedoc_code,
		ctnr_code,
		title,
		description,
		year,
		month,
		day,
		json_data
	FROM tobj_documents
	WHERE uid = strDocUID;

    SELECT LAST_INSERT_ID() INTO iDocID;
    SELECT uid into strNewDocUID FROM tobj_documents WHERE id = iDocID;

    -- Duplication of Doc -> Tiers Links
    INSERT INTO tlnk_documents_tiers(doc_uid,tier_uid,isMain)
    SELECT strNewDocUID,lnktier.tier_uid,lnktier.isMain FROM tlnk_documents_tiers lnktier WHERE lnktier.doc_uid = strDocUID;

    -- Duplication of Doc -> Categories Links
    INSERT INTO tlnk_documents_categories(doc_uid,cat_uid,isMain)
    SELECT strNewDocUID,lnkcat.cat_uid,lnkcat.isMain FROM tlnk_documents_categories lnkcat WHERE lnkcat.doc_uid = strDocUID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure versionDocument
-- -----------------------------------------------------
DROP procedure IF EXISTS `versionDocument`;

DELIMITER $$
CREATE DEFINER=`polux`@`%` PROCEDURE `versionDocument`(IN pStrDocCode VARCHAR(20))
BEGIN

	DECLARE strDocUID VARCHAR(15);
    DECLARE iDocID INTEGER;
    DECLARE strNewDocUID VARCHAR(15);

    SELECT getLastDocUidFromCode(pStrDocCode) INTO strDocUID;

    INSERT INTO `tobj_documents`
	(
		`code`,
		`version`,
		`revision`,
		`typedoc_code`,
		`ctnr_code`,
		`title`,
		`description`,
		`year`,
		`month`,
		`day`,
		`json_data`
	)
	SELECT
		`code`,
		`version`+1 as version,
		1 ,
		`typedoc_code`,
		`ctnr_code`,
		`title`,
		`description`,
		`year`,
		`month`,
		`day`,
		`json_data`
	FROM tobj_documents
	WHERE uid = strDocUID;

    SELECT LAST_INSERT_ID() INTO iDocID;
    SELECT uid into strNewDocUID FROM tobj_documents WHERE id = iDocID;

    -- Duplication of Doc -> Tiers Links
    INSERT INTO tlnk_documents_tiers(doc_uid,tier_uid,isMain)
    SELECT strNewDocUID,lnktier.tier_uid,lnktier.isMain FROM tlnk_documents_tiers lnktier WHERE lnktier.doc_uid = strDocUID;

    -- Duplication of Doc -> Categories Links
    INSERT INTO tlnk_documents_categories(doc_uid,cat_uid,isMain)
    SELECT strNewDocUID,lnkcat.cat_uid,lnkcat.isMain FROM tlnk_documents_categories lnkcat WHERE lnkcat.doc_uid = strDocUID;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `vobj_documents_history`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `vobj_documents_history` ;
DROP TABLE IF EXISTS `vobj_documents_history`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`polux`@`%` SQL SECURITY DEFINER VIEW `vobj_documents_history` AS select `doc`.`uid` AS `uid`,`doc`.`code` AS `code`,`doc`.`version` AS `version`,`doc`.`revision` AS `revision`,`doc`.`typedoc_code` AS `typedoc_code`,`doc`.`ctnr_code` AS `ctnr_code`,`doc`.`title` AS `title`,`doc`.`description` AS `description`,`doc`.`year` AS `year`,`doc`.`month` AS `month`,`doc`.`day` AS `day`,`doc`.`ctime` AS `ctime`,`doc`.`cuser` AS `cuser`,`doc`.`utime` AS `utime`,`doc`.`uuser` AS `uuser`,`doc`.`isActive` AS `isActive`,`doc`.`json_data` AS `json_data`,concat('[',group_concat(distinct concat('"',`meta`.`uid`,'":{code:"',`meta`.`code`,'", title:"',`meta`.`title`,'",value:"',ifnull(`meta`.`value`,'no value'),'"}') separator ', '),']') AS `meta_json`,concat('[',group_concat(distinct concat('"',`lnkfic`.`order_number`,'":{ uid:"',`lnkfic`.`fic_uid`,'"}') separator ', '),']') AS `fic_json`,concat('[',group_concat(distinct concat('"',`lnkcat`.`cat_uid`,'"') separator ', '),']') AS `cat_json`,concat('[',group_concat(distinct concat('"',`lnktiers`.`tier_uid`,'"') separator ', '),']') AS `tier_json` from ((((`tobj_documents` `doc` left join `tdta_metadata` `meta` on((`meta`.`doc_uid` = `doc`.`uid`))) left join `tlnk_documents_fichiers` `lnkfic` on((`lnkfic`.`doc_code` = `doc`.`code`))) left join `tlnk_documents_categories` `lnkcat` on((`lnkcat`.`doc_uid` = `doc`.`uid`))) left join `tlnk_documents_tiers` `lnktiers` on((`lnktiers`.`doc_uid` = `doc`.`uid`))) group by `doc`.`uid`,`doc`.`code`,`doc`.`version`,`doc`.`revision`,`doc`.`typedoc_code`,`doc`.`ctnr_code`,`doc`.`title`,`doc`.`description`,`doc`.`year`,`doc`.`month`,`doc`.`day`,`doc`.`ctime`,`doc`.`cuser`,`doc`.`utime`,`doc`.`uuser`,`doc`.`isActive`,`doc`.`json_data` order by `doc`.`code`,`doc`.`version` desc,`doc`.`revision` desc;

-- -----------------------------------------------------
-- View `vobj_documents_last`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `vobj_documents_last` ;
DROP TABLE IF EXISTS `vobj_documents_last`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`polux`@`%` SQL SECURITY DEFINER VIEW `vobj_documents_last` AS select `doc`.`uid` AS `uid`,`doc`.`code` AS `code`,`doc`.`version` AS `version`,`doc`.`revision` AS `revision`,`doc`.`typedoc_code` AS `typedoc_code`,`doc`.`ctnr_code` AS `ctnr_code`,`doc`.`title` AS `title`,`doc`.`description` AS `description`,`doc`.`year` AS `year`,`doc`.`month` AS `month`,`doc`.`day` AS `day`,`doc`.`ctime` AS `ctime`,`doc`.`cuser` AS `cuser`,`doc`.`utime` AS `utime`,`doc`.`uuser` AS `uuser`,`doc`.`isActive` AS `isActive`,`doc`.`json_data` AS `json_data`,concat('[',group_concat(distinct concat('"',`meta`.`uid`,'":{code:"',`meta`.`code`,'", title:"',`meta`.`title`,'",value:"',ifnull(`meta`.`value`,'no value'),'"}') separator ', '),']') AS `meta_json`,concat('[',group_concat(distinct concat('"',`lnkfic`.`order_number`,'":{ uid:"',`lnkfic`.`fic_uid`,'"}') separator ', '),']') AS `fic_json`,concat('[',group_concat(distinct concat('"',`lnkcat`.`cat_uid`,'"') separator ', '),']') AS `cat_json`,concat('[',group_concat(distinct concat('"',`lnktiers`.`tier_uid`,'"') separator ', '),']') AS `tier_json` from (((((`vobj_documents_lastuid` `vlastdoc` join `tobj_documents` `doc` on((`doc`.`uid` = `vlastdoc`.`doc_uid`))) left join `tdta_metadata` `meta` on((`meta`.`doc_uid` = `doc`.`uid`))) left join `tlnk_documents_fichiers` `lnkfic` on((`lnkfic`.`doc_code` = `doc`.`code`))) left join `tlnk_documents_categories` `lnkcat` on((`lnkcat`.`doc_uid` = `doc`.`uid`))) left join `tlnk_documents_tiers` `lnktiers` on((`lnktiers`.`doc_uid` = `doc`.`uid`))) group by `doc`.`uid`,`doc`.`code`,`doc`.`version`,`doc`.`revision`,`doc`.`typedoc_code`,`doc`.`ctnr_code`,`doc`.`title`,`doc`.`description`,`doc`.`year`,`doc`.`month`,`doc`.`day`,`doc`.`ctime`,`doc`.`cuser`,`doc`.`utime`,`doc`.`uuser`,`doc`.`isActive`,`doc`.`json_data` order by `doc`.`code`;

-- -----------------------------------------------------
-- View `vobj_documents_lastuid`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `vobj_documents_lastuid` ;
DROP TABLE IF EXISTS `vobj_documents_lastuid`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`polux`@`%` SQL SECURITY DEFINER VIEW `vobj_documents_lastuid` AS select `doc`.`code` AS `code`,`getMaxVersionForDocFromCode`(`doc`.`code`) AS `version`,`getMaxRevisionForDocFromCode`(`doc`.`code`) AS `revision`,`getLastDocUidFromCode`(`doc`.`code`) AS `doc_uid` from `tobj_documents` `doc` group by `doc`.`code` order by `doc`.`code`;

-- -----------------------------------------------------
-- View `vobj_fichiers_notlinked`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `vobj_fichiers_notlinked` ;
DROP TABLE IF EXISTS `vobj_fichiers_notlinked`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`polux`@`%` SQL SECURITY DEFINER VIEW `vobj_fichiers_notlinked` AS select `tobj_fichiers`.`uid` AS `uid`,`tobj_fichiers`.`filename` AS `filename`,`tobj_fichiers`.`filepath` AS `filepath`,`tobj_fichiers`.`filesize` AS `filesize`,`tobj_fichiers`.`mime` AS `mime`,`tobj_fichiers`.`ctime` AS `ctime`,`tobj_fichiers`.`cuser` AS `cuser`,`tobj_fichiers`.`utime` AS `utime`,`tobj_fichiers`.`uuser` AS `uuser`,`tobj_fichiers`.`json_data` AS `json_data` from `tobj_fichiers` where (not(`tobj_fichiers`.`uid` in (select distinct `tlnk_documents_fichiers`.`fic_uid` from `tlnk_documents_fichiers`)));

-- -----------------------------------------------------
-- View `vobj_fichiers_src_target`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `vobj_fichiers_src_target` ;
DROP TABLE IF EXISTS `vobj_fichiers_src_target`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`polux`@`%` SQL SECURITY DEFINER VIEW `vobj_fichiers_src_target` AS select `tdoc`.`code` AS `DOC_CODE`,`tdoc`.`code` AS `DOC_UID`,`tfic`.`uid` AS `FIC_UID`,`ldf`.`order_number` AS `FIC_ORDER_FOR_DOC`,concat(`tfic`.`filepath`,'/',`tfic`.`filename`) AS `SRC_FILEPATH`,concat(`tcont`.`rootpath`,'/',`tdoc`.`year`,if((`tdoc`.`month` = 0),'',lpad(cast(`tdoc`.`month` as char charset utf8),2,'0')),if((`tdoc`.`day` = 0),'',lpad(cast(`tdoc`.`day` as char charset utf8),2,'0')),'_',`tdoc`.`typedoc_code`,if(isnull(`trtier`.`code`),'_',concat('-',`trtier`.`code`,'_')),replace(`tdoc`.`title`,' ',''),'-',lpad(cast(`ldf`.`order_number` as char charset utf8),2,'0'),substr(`tfic`.`filename`,-(4))) AS `TRGT_FILEPATH`,concat(`tdoc`.`year`,if((`tdoc`.`month` = 0),'',lpad(cast(`tdoc`.`month` as char charset utf8),2,'0')),if((`tdoc`.`day` = 0),'',lpad(cast(`tdoc`.`day` as char charset utf8),2,'0')),'_',`tdoc`.`typedoc_code`,if(isnull(`trtier`.`code`),'_',concat('-',`trtier`.`code`,'_')),replace(`tdoc`.`title`,' ',''),'-',lpad(cast(`ldf`.`order_number` as char charset utf8),2,'0'),substr(`tfic`.`filename`,-(4))) AS `TRGT_FILENAME`,`tcont`.`rootpath` AS `TRGT_PATH` from (((((`tlnk_documents_fichiers` `ldf` left join `tobj_fichiers` `tfic` on((`tfic`.`uid` = `ldf`.`fic_uid`))) left join `tobj_documents` `tdoc` on((`tdoc`.`code` = `ldf`.`doc_code`))) left join `tdta_containers` `tcont` on((`tcont`.`code` = `tdoc`.`ctnr_code`))) left join `tlnk_documents_tiers` `tdt` on(((`tdt`.`doc_uid` = `tdoc`.`uid`) and (`tdt`.`isMain` = 1)))) left join `tref_tiers` `trtier` on((`trtier`.`uid` = `tdt`.`tier_uid`))) where (concat(`tfic`.`filepath`,'/',`tfic`.`filename`) <> concat(`tcont`.`rootpath`,'/',`tdoc`.`year`,if((`tdoc`.`month` = 0),'',lpad(cast(`tdoc`.`month` as char charset utf8),2,'0')),if((`tdoc`.`day` = 0),'',lpad(cast(`tdoc`.`day` as char charset utf8),2,'0')),'_',`tdoc`.`typedoc_code`,if(isnull(`trtier`.`code`),'_',concat('-',`trtier`.`code`,'_')),replace(`tdoc`.`title`,' ',''),'-',lpad(cast(`ldf`.`order_number` as char charset utf8),2,'0'),substr(`tfic`.`filename`,-(4))));

-- -----------------------------------------------------
-- View `vobj_metadata_last`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `vobj_metadata_last` ;
DROP TABLE IF EXISTS `vobj_metadata_last`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`polux`@`%` SQL SECURITY DEFINER VIEW `vobj_metadata_last` AS select `met`.`id` AS `id`,`met`.`uid` AS `uid`,`met`.`code` AS `code`,`met`.`typedoc_code` AS `typedoc_code`,`met`.`tdocmeta_code` AS `tdocmeta_code`,`met`.`doc_uid` AS `doc_uid`,`met`.`title` AS `title`,`met`.`value` AS `value`,`met`.`json_data` AS `json_data`,`met`.`ctime` AS `ctime`,`met`.`cuser` AS `cuser`,`met`.`utime` AS `utime`,`met`.`uuser` AS `uuser`,`met`.`isActive` AS `isActive` from (`vobj_documents_lastuid` `docl` join `tdta_metadata` `met` on((`met`.`doc_uid` = `docl`.`doc_uid`)));

-- -----------------------------------------------------
-- procedure startTask
-- -----------------------------------------------------
DROP procedure IF EXISTS `startTask`;

DELIMITER $$
CREATE PROCEDURE `startTask` (IN pTaskCode VARCHAR(20))
BEGIN
	UPDATE tobj_tasks set starttime = CURRENT_TIMESTAMP WHERE code= pTaskCode;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure endTask
-- -----------------------------------------------------
DROP procedure IF EXISTS `endTask`;

DELIMITER $$
CREATE PROCEDURE `endTask` (IN pTaskCode VARCHAR(20))
BEGIN
	UPDATE tobj_tasks set endtime = CURRENT_TIMESTAMP WHERE code= pTaskCode;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function createTask
-- -----------------------------------------------------
DROP function IF EXISTS `createTask`;

DELIMITER $$
CREATE FUNCTION `createTask` (pStrCode VARCHAR(3), pStrTitle VARCHAR(50), pDblPercent DECIMAL(5,2)) RETURNS VARCHAR(15)
BEGIN

	DECLARE lUID VARCHAR(15);
    DECLARE lCODE VARCHAR(15);
    DECLARE lCOUNTTASKS INTEGER;

    SELECT COUNT(*) INTO lCOUNTTASKS FROM tobj_tasks;

    SET lCODE = CONCAT('TASK-',pStrCode,'-',LPAD(CONVERT(lCOUNTTASKS+1,CHAR),12,'0'));

    INSERT INTO `tobj_tasks`(
		`code`,
		`title`,
		`status`,
		`percent`
	)
	VALUES
	(
		lCODE,
		pStrTitle,
		'INIT',
		pDblPercent
	);
END$$

DELIMITER ;

DELIMITER $$

DROP TRIGGER IF EXISTS `tdta_containers_AFTER_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tdta_containers_AFTER_INSERT`
AFTER INSERT ON `myecm`.`tdta_containers`
FOR EACH ROW
BEGIN
	CALL logDataInsert('tdta_containers',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tdta_containers_AFTER_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tdta_containers_AFTER_UPDATE`
AFTER UPDATE ON `myecm`.`tdta_containers`
FOR EACH ROW
BEGIN
	CALL logDataUpdate('tdta_containers',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tdta_containers_BEFORE_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tdta_containers_BEFORE_INSERT`
BEFORE INSERT ON `myecm`.`tdta_containers`
FOR EACH ROW
BEGIN
	DECLARE pk_ai_currentTable INT DEFAULT 0;
    SELECT coreGetAutoIncrementNextValue('tdta_containers') INTO pk_ai_currentTable;
	SET NEW.uid = CONCAT('CTNR-',LPAD(CONVERT(pk_ai_currentTable,CHAR),10,'0'));
    SET NEW.cuser = CURRENT_USER;
END$$


DROP TRIGGER IF EXISTS `tdta_containers_BEFORE_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tdta_containers_BEFORE_UPDATE`
BEFORE UPDATE ON `myecm`.`tdta_containers`
FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


DROP TRIGGER IF EXISTS `tref_typesdoc_AFTER_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_typesdoc_AFTER_INSERT`
AFTER INSERT ON `myecm`.`tref_typesdoc`
FOR EACH ROW
BEGIN
	CALL logDataInsert('tref_typesdoc',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tref_typesdoc_AFTER_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_typesdoc_AFTER_UPDATE`
AFTER UPDATE ON `myecm`.`tref_typesdoc`
FOR EACH ROW
BEGIN
	CALL logDataUpdate('tref_typesdoc',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tref_typesdoc_BEFORE_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_typesdoc_BEFORE_INSERT`
BEFORE INSERT ON `myecm`.`tref_typesdoc`
FOR EACH ROW
BEGIN

	SET NEW.uid = CONCAT('TDOC-',UCASE(NEW.code));
    SET NEW.cuser = CURRENT_USER;
END$$


DROP TRIGGER IF EXISTS `tref_typesdoc_BEFORE_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_typesdoc_BEFORE_UPDATE`
BEFORE UPDATE ON `myecm`.`tref_typesdoc`
FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


DROP TRIGGER IF EXISTS `tobj_documents_AFTER_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tobj_documents_AFTER_INSERT`
AFTER INSERT ON `myecm`.`tobj_documents`
FOR EACH ROW
BEGIN
	CALL logDataInsert('tobj_documents',NEW.uid,NEW.code);
    CALL _instanciateMetadataForDocument(NEW.uid);
END$$


DROP TRIGGER IF EXISTS `tobj_documents_AFTER_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tobj_documents_AFTER_UPDATE`
AFTER UPDATE ON `myecm`.`tobj_documents`
FOR EACH ROW
BEGIN
	CALL logDataUpdate('tobj_documents',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tobj_documents_BEFORE_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tobj_documents_BEFORE_INSERT`
BEFORE INSERT ON `myecm`.`tobj_documents`
FOR EACH ROW
BEGIN
	DECLARE pk_ai_currentTable INT;
    DECLARE s_Code VARCHAR(20);

    SELECT count(uid) INTO pk_ai_currentTable
    FROM tobj_documents
    WHERE typedoc_code = NEW.typedoc_code AND year = NEW.year; -- uid LIKE CONCAT('D-',NEW.typedoc_code,'-',CONVERT(NEW.year,CHAR),'-%') ;

	SET s_Code = CONCAT('D-',NEW.typedoc_code,'-',CONVERT(NEW.year,CHAR),'-',LPAD(CONVERT(pk_ai_currentTable+1,CHAR),3,'0'));
    SET NEW.uid = s_Code;
    SET NEW.cuser = CURRENT_USER;
END$$


DROP TRIGGER IF EXISTS `tobj_documents_BEFORE_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tobj_documents_BEFORE_UPDATE`
BEFORE UPDATE ON `myecm`.`tobj_documents`
FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


DROP TRIGGER IF EXISTS `tref_typesdoc_metadata_AFTER_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_typesdoc_metadata_AFTER_INSERT`
AFTER INSERT ON `myecm`.`tref_typesdoc_metadata`
FOR EACH ROW
BEGIN
	CALL logDataInsert('tref_typesdoc_metadata',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tref_typesdoc_metadata_AFTER_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_typesdoc_metadata_AFTER_UPDATE`
AFTER UPDATE ON `myecm`.`tref_typesdoc_metadata`
FOR EACH ROW
BEGIN
	CALL logDataUpdate('tref_typesdoc_metadata',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tref_typesdoc_metadata_BEFORE_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_typesdoc_metadata_BEFORE_INSERT`
BEFORE INSERT ON `myecm`.`tref_typesdoc_metadata`
FOR EACH ROW
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


DROP TRIGGER IF EXISTS `tref_typesdoc_metadata_BEFORE_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_typesdoc_metadata_BEFORE_UPDATE`
BEFORE UPDATE ON `myecm`.`tref_typesdoc_metadata`
FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


DROP TRIGGER IF EXISTS `tdta_metadata_AFTER_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tdta_metadata_AFTER_INSERT`
AFTER INSERT ON `myecm`.`tdta_metadata`
FOR EACH ROW
BEGIN
	CALL logDataInsert('tdta_containers',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tdta_metadata_AFTER_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tdta_metadata_AFTER_UPDATE`
AFTER UPDATE ON `myecm`.`tdta_metadata`
FOR EACH ROW
BEGIN
	CALL logDataUpdate('tdta_metadata',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tdta_metadata_BEFORE_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tdta_metadata_BEFORE_INSERT`
BEFORE INSERT ON `myecm`.`tdta_metadata`
FOR EACH ROW
BEGIN

	DECLARE pk_ai_currentTable INT DEFAULT 0;

    SELECT coreGetAutoIncrementNextValue('tdta_metadata') INTO pk_ai_currentTable;

	SET NEW.uid = CONCAT('MDOC-',LPAD(CONVERT(pk_ai_currentTable,CHAR),10,'0'));
    SET NEW.cuser = CURRENT_USER;
END$$


DROP TRIGGER IF EXISTS `tdta_metadata_BEFORE_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tdta_metadata_BEFORE_UPDATE`
BEFORE UPDATE ON `myecm`.`tdta_metadata`
FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


DROP TRIGGER IF EXISTS `tref_categories_AFTER_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_categories_AFTER_INSERT`
AFTER INSERT ON `myecm`.`tref_categories`
FOR EACH ROW
BEGIN
	CALL logDataInsert('tref_categories',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tref_categories_AFTER_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_categories_AFTER_UPDATE`
AFTER UPDATE ON `myecm`.`tref_categories`
FOR EACH ROW
BEGIN
	CALL logDataUpdate('tref_categories',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tref_categories_BEFORE_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_categories_BEFORE_INSERT`
BEFORE INSERT ON `myecm`.`tref_categories`
FOR EACH ROW
BEGIN
	SET NEW.uid = CONCAT('CAT-',UCASE(NEW.code));
    SET NEW.cuser = CURRENT_USER;
END$$


DROP TRIGGER IF EXISTS `tref_categories_BEFORE_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_categories_BEFORE_UPDATE`
BEFORE UPDATE ON `myecm`.`tref_categories`
FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


DROP TRIGGER IF EXISTS `tobj_fichiers_AFTER_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tobj_fichiers_AFTER_INSERT`
AFTER INSERT ON `myecm`.`tobj_fichiers`
FOR EACH ROW
BEGIN
	CALL logDataInsert('tobj_fichiers',NEW.uid,CONCAT(NEW.filepath,'/',NEW.filename));
END$$


DROP TRIGGER IF EXISTS `tobj_fichiers_AFTER_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tobj_fichiers_AFTER_UPDATE`
AFTER UPDATE ON `myecm`.`tobj_fichiers`
FOR EACH ROW
BEGIN
	CALL logDataUpdate('tobj_fichiers',NEW.uid,NEW.filepath);
END$$


DROP TRIGGER IF EXISTS `tobj_fichiers_BEFORE_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tobj_fichiers_BEFORE_INSERT`
BEFORE INSERT ON `myecm`.`tobj_fichiers`
FOR EACH ROW
BEGIN
	DECLARE pk_ai_currentTable INT;

    SELECT coreGetAutoIncrementNextValue('tobj_fichiers') INTO pk_ai_currentTable;

	SET NEW.uid = CONCAT('FIC-',LPAD(CONVERT(pk_ai_currentTable,CHAR),11,'0'));
    SET NEW.cuser = CURRENT_USER;
END$$


DROP TRIGGER IF EXISTS `tobj_fichiers_BEFORE_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tobj_fichiers_BEFORE_UPDATE`
BEFORE UPDATE ON `myecm`.`tobj_fichiers`
FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


DROP TRIGGER IF EXISTS `tref_tiers_AFTER_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_tiers_AFTER_INSERT`
AFTER INSERT ON `myecm`.`tref_tiers`
FOR EACH ROW
BEGIN
	CALL logDataInsert('tref_tiers',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tref_tiers_AFTER_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_tiers_AFTER_UPDATE`
AFTER UPDATE ON `myecm`.`tref_tiers`
FOR EACH ROW
BEGIN
CALL logDataUpdate('tref_tiers',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tref_tiers_BEFORE_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_tiers_BEFORE_INSERT`
BEFORE INSERT ON `myecm`.`tref_tiers`
FOR EACH ROW
BEGIN
	SET NEW.uid = CONCAT('TIER-',UCASE(NEW.code));
    SET NEW.cuser = CURRENT_USER;
END$$


DROP TRIGGER IF EXISTS `tref_tiers_BEFORE_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tref_tiers_BEFORE_UPDATE`
BEFORE UPDATE ON `myecm`.`tref_tiers`
FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


DROP TRIGGER IF EXISTS `tlog_events_BEFORE_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm`.`tlog_events_BEFORE_INSERT`
BEFORE INSERT ON `myecm`.`tlog_events`
FOR EACH ROW
BEGIN
	SET NEW.cuser = CURRENT_USER;
END$$


DELIMITER ;

DELIMITER $$

DROP TRIGGER IF EXISTS `tref_status_BEFORE_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tref_status_BEFORE_INSERT`
BEFORE INSERT ON `myecm-tasks`.`tref_status`
FOR EACH ROW
BEGIN
	SET NEW.uid = CONCAT('TSTAT-',UCASE(NEW.code));
    SET NEW.cuser = CURRENT_USER;
END$$


DROP TRIGGER IF EXISTS `tref_status_AFTER_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tref_status_AFTER_INSERT`
AFTER INSERT ON `myecm-tasks`.`tref_status`
FOR EACH ROW
BEGIN
	CALL myecm.logDataInsert('tref_status',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tref_status_BEFORE_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tref_status_BEFORE_UPDATE`
BEFORE UPDATE ON `myecm-tasks`.`tref_status`
FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


DROP TRIGGER IF EXISTS `tref_status_AFTER_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tref_status_AFTER_UPDATE`
AFTER UPDATE ON `myecm-tasks`.`tref_status`
FOR EACH ROW
BEGIN
CALL myecm.logDataUpdate('tref_status',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tobj_tasks_BEFORE_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tobj_tasks_BEFORE_INSERT`
BEFORE INSERT ON `myecm-tasks`.`tobj_tasks`
FOR EACH ROW
BEGIN
	SET NEW.uid = CONCAT('TIER-',UCASE(NEW.code));
    SET NEW.cuser = CURRENT_USER;
END$$


DROP TRIGGER IF EXISTS `tobj_tasks_AFTER_INSERT` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tobj_tasks_AFTER_INSERT`
AFTER INSERT ON `myecm-tasks`.`tobj_tasks`
FOR EACH ROW
BEGIN
	CALL myecm.logDataInsert('tobj_tasks',NEW.uid,NEW.code);
END$$


DROP TRIGGER IF EXISTS `tobj_tasks_BEFORE_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tobj_tasks_BEFORE_UPDATE`
BEFORE UPDATE ON `myecm-tasks`.`tobj_tasks`
FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


DROP TRIGGER IF EXISTS `tobj_tasks_AFTER_UPDATE` $$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tobj_tasks_AFTER_UPDATE`
AFTER UPDATE ON `myecm-tasks`.`tobj_tasks`
FOR EACH ROW
BEGIN
CALL myecm.logDataUpdate('tobj_tasks',NEW.uid,NEW.code);
END$$


DELIMITER ;

-- -----------------------------------------------------
-- Data for table `tref_status`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `tref_status` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`, `tref_statuscol`) VALUES (DEFAULT, DEFAULT, 'INIT', 'Initialisée', 'Tâches initialisées.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL, NULL);
INSERT INTO `tref_status` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`, `tref_statuscol`) VALUES (DEFAULT, DEFAULT, 'COMPLETED', 'Complétée', 'Tâches complétées.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL, NULL);
INSERT INTO `tref_status` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`, `tref_statuscol`) VALUES (DEFAULT, DEFAULT, 'INPROGRESS', 'En cours', 'Tâches en cours d\'execution.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL, NULL);
INSERT INTO `tref_status` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`, `tref_statuscol`) VALUES (DEFAULT, DEFAULT, 'ERROR', 'En erreur', 'Tâches en erreur.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL, NULL);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
