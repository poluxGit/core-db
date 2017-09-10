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
CREATE FUNCTION `createTask` (pStrCode VARCHAR(3), pStrTitle VARCHAR(50), pDblPercent DECIMAL(5,2)) RETURNS VARCHAR(20)
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

  SET createTask = lCODE;
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
