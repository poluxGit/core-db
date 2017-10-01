-- -------------------------------------------------------------------------- --
-- MyECM - Database - Deployment Script - Tables and indexes                  --
-- -------------------------------------------------------------------------- --
-- @author : poluxGit <polux@poluxfr.org>                                     --
-- -------------------------------------------------------------------------- --
-- Database version : 2.0-beta                                                --
-- @date : September, 2017                                                    --
-- -------------------------------------------------------------------------- --


-- -----------------------------------------------------
-- Table `CORE_TOBJV_ObjectName`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_TOBJV_ObjectName` ;

CREATE TABLE IF NOT EXISTS `CORE_TOBJV_ObjectName` (
  `id` INT(8) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identifiant unique géré par le SGBD.',
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEFINED' COMMENT 'Identifiant Unique applicatif',
  `bid` VARCHAR(100) NOT NULL DEFAULT 'BID-NOTDEFINED' COMMENT 'Identifiant "Business" unique.',
  `version` INT NOT NULL DEFAULT 1 COMMENT 'Version de l'objet',
  `revision` INT NOT NULL DEFAULT 0 COMMENT 'Révision de l'objet',
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Titre cournt non défini' COMMENT 'Titre court de l'objet',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Titre long non défini' COMMENT 'Titre long de l'objet',
  `comment` TEXT NULL DEFAULT NULL COMMENT 'description de l'objet',
  `creator` VARCHAR(100) NOT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updator` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UQ_TID` (`tid` ASC),
  UNIQUE INDEX `UQ_BID-VERS-REV` (`bid` ASC, `version` ASC, `revision` ASC),
  INDEX `FK_TOBJ_USER_CREATOR_idx` (`creator` ASC),
  INDEX `FK_TOBJ_USER_UPDATOR_idx` (`updator` ASC),
  CONSTRAINT `FK_ObjectName_USER_CREATOR`
    FOREIGN KEY (`creator`)
    REFERENCES `APP_USERS` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ObjectName_USER_UPDATOR`
    FOREIGN KEY (`updator`)
    REFERENCES `APP_USERS` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Triggers for table `CORE_TOBJV_ObjectName`
-- -----------------------------------------------------
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
USE `SchemaName`;

DELIMITER $$

USE `SchemaName`$$
DROP TRIGGER IF EXISTS `CORE_TOBJV_ObjectName_BEFORE_INSERT` $$
USE `SchemaName`$$
CREATE DEFINER = CURRENT_USER TRIGGER `SchemaName`.`CORE_TOBJV_ObjectName_BEFORE_INSERT` BEFORE INSERT ON `CORE_TOBJV_ObjectName` FOR EACH ROW
BEGIN
    -- TID Rule
    SET NEW.tid =  '';
    -- Creator definition.
    SET NEW.creator = CURRENT_USER;
END$$


USE `SchemaName`$$
DROP TRIGGER IF EXISTS `CORE_TOBJV_ObjectName_AFTER_INSERT` $$
USE `SchemaName`$$
CREATE DEFINER = CURRENT_USER TRIGGER `SchemaName`.`CORE_TOBJV_ObjectName_AFTER_INSERT` AFTER INSERT ON `CORE_TOBJV_ObjectName` FOR EACH ROW
BEGIN
  CALL LOG_LogDataInsert('`CORE_TOBJV_ObjectName',NEW.tid);
END$$


USE `SchemaName`$$
DROP TRIGGER IF EXISTS `CORE_TOBJV_ObjectName_BEFORE_UPDATE` $$
USE `SchemaName`$$
CREATE DEFINER = CURRENT_USER TRIGGER `SchemaName`.`CORE_TOBJV_ObjectName_BEFORE_UPDATE` BEFORE UPDATE ON `CORE_TOBJV_ObjectName` FOR EACH ROW
BEGIN
  # Define Updator and update timestamp  to now.
  SET updator = CURRENT_USER;
    SET utime = NOW();
END$$


USE `SchemaName`$$
DROP TRIGGER IF EXISTS `CORE_TOBJV_ObjectName_AFTER_UPDATE` $$
USE `SchemaName`$$
CREATE DEFINER = CURRENT_USER TRIGGER `SchemaName`.`CORE_TOBJV_ObjectName_AFTER_UPDATE` AFTER UPDATE ON `CORE_TOBJV_ObjectName` FOR EACH ROW
BEGIN
  CALL LOG_LogDataUpdate('CORE_TOBJV_ObjectName',NEW.tid);
END$$
