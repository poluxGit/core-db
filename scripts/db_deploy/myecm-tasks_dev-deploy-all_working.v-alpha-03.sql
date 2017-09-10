-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema myecm-tasks
-- -----------------------------------------------------
-- Tasks Management Shema.
--
DROP SCHEMA IF EXISTS `myecm-tasks` ;

-- -----------------------------------------------------
-- Schema myecm-tasks
--
-- Tasks Management Shema.
--
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `myecm-tasks` DEFAULT CHARACTER SET utf8 ;

USE `myecm-tasks` ;

-- -----------------------------------------------------
-- Table `tref_typetask`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_typetask` ;

CREATE TABLE IF NOT EXISTS `tref_typetask` (
  `id` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOT_DEF' COMMENT 'Table des types de tâches.',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOT_DEF',
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_typetask_user_creator`
    FOREIGN KEY (`cuser`)
    REFERENCES `myecm`.`tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_typetask_user_updator`
    FOREIGN KEY (`uuser`)
    REFERENCES `myecm`.`tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `code_UNIQUE` ON `tref_typetask` (`code` ASC);
CREATE UNIQUE INDEX `uid_UNIQUE` ON `tref_typetask` (`uid` ASC);
CREATE INDEX `fk_typetask_user_creator_idx` ON `tref_typetask` (`cuser` ASC);
CREATE INDEX `fk_typetask_user_updator_idx` ON `tref_typetask` (`uuser` ASC);


-- -----------------------------------------------------
-- Table `tobj_tasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tobj_tasks` ;

CREATE TABLE IF NOT EXISTS `tobj_tasks` (
  `id` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `typetask_code` VARCHAR(20) NOT NULL,
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Task Title',
  `description` TEXT NULL DEFAULT NULL,
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
  CONSTRAINT `fk_task_typetask_code`
    FOREIGN KEY (`typetask_code`)
    REFERENCES `tref_typetask` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `uid_UNIQUE` ON `tobj_tasks` (`uid` ASC);

CREATE INDEX `fk_tobj_tasks_tapp_users_idx` ON `tobj_tasks` (`cuser` ASC);

CREATE INDEX `fk_tobj_tasks_tapp_users1_idx` ON `tobj_tasks` (`uuser` ASC);

CREATE INDEX `fk_task_typetask_code_idx` ON `tobj_tasks` (`typetask_code` ASC);

CREATE UNIQUE INDEX `code_UNIQUE` ON `tobj_tasks` (`code` ASC);


-- -----------------------------------------------------
-- Table `tref_statustask`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_statustask` ;

CREATE TABLE IF NOT EXISTS `tref_statustask` (
  `id` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NO_DEF',
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

CREATE UNIQUE INDEX `uid_UNIQUE` ON `tref_statustask` (`uid` ASC);

CREATE INDEX `fk_tref_categories_tapp_users_idx` ON `tref_statustask` (`cuser` ASC);

CREATE INDEX `fk_tref_categories_tapp_users1_idx` ON `tref_statustask` (`uuser` ASC);

CREATE UNIQUE INDEX `code_UNIQUE` ON `tref_statustask` (`code` ASC);


-- -----------------------------------------------------
-- Table `tdta_task_statustask`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tdta_task_statustask` ;

CREATE TABLE IF NOT EXISTS `tdta_task_statustask` (
  `id` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identifiant Unique Technique Interne',
  `task_code` VARCHAR(20) NOT NULL COMMENT 'Code Unique de la Tâche',
  `statustask_code` VARCHAR(20) NOT NULL COMMENT 'Code Unique du status',
  `order` INT NOT NULL COMMENT 'Ordre d\'execution du statut de la tâche',
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF' COMMENT 'Identifiant Unique Fonctionnel Interne',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NO_DEF' COMMENT 'Identifiant Unique Fonctionnel',
  `title` VARCHAR(500) NOT NULL DEFAULT 'Default Title' COMMENT 'Titre de l\'étape',
  `description` TEXT NULL DEFAULT NULL,
  `command` VARCHAR(4000) NULL DEFAULT NULL,
  `starttime` TIMESTAMP NULL DEFAULT NULL,
  `endtime` TIMESTAMP NULL DEFAULT NULL,
  `log_command` TEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT(4) NOT NULL DEFAULT '1',
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tiers_users_create0`
    FOREIGN KEY (`cuser`)
    REFERENCES `myecm`.`tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tiers_users_update0`
    FOREIGN KEY (`uuser`)
    REFERENCES `myecm`.`tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tdta_task_statustask_tobj_tasks1`
    FOREIGN KEY (`task_code`)
    REFERENCES `tobj_tasks` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tdta_task_statustask_tref_statustask1`
    FOREIGN KEY (`statustask_code`)
    REFERENCES `tref_statustask` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 25
DEFAULT CHARACTER SET = utf8;

CREATE UNIQUE INDEX `uid_UNIQUE` ON `tdta_task_statustask` (`uid` ASC);
CREATE INDEX `fk_tref_categories_tapp_users_idx` ON `tdta_task_statustask` (`cuser` ASC);
CREATE INDEX `fk_tref_categories_tapp_users1_idx` ON `tdta_task_statustask` (`uuser` ASC);
CREATE UNIQUE INDEX `code_UNIQUE` ON `tdta_task_statustask` (`code` ASC);
CREATE INDEX `fk_tdta_task_statustask_tobj_tasks1_idx` ON `tdta_task_statustask` (`task_code` ASC);
CREATE INDEX `fk_tdta_task_statustask_tref_statustask1_idx` ON `tdta_task_statustask` (`statustask_code` ASC);
CREATE UNIQUE INDEX `table_key_UNIQUE` ON `tdta_task_statustask` (`task_code` ASC, `order` ASC);


-- -----------------------------------------------------
-- Table `tref_typetask_status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_typetask_status` ;

CREATE TABLE IF NOT EXISTS `tref_typetask_status` (
  `id` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `typetask_code` VARCHAR(20) NOT NULL,
  `statustask_code` VARCHAR(20) NOT NULL,
  `order` INT NOT NULL DEFAULT 1,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NO_DEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NO_DEF' COMMENT 'Table de définition des statuts par type de tâche.',
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_typetask_statustask_creator`
    FOREIGN KEY (`cuser`)
    REFERENCES `myecm`.`tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_typetask_statustask_updator`
    FOREIGN KEY (`uuser`)
    REFERENCES `myecm`.`tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_typestatus_typetask`
    FOREIGN KEY (`typetask_code`)
    REFERENCES `tref_typetask` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_typestatus_statustask`
    FOREIGN KEY (`statustask_code`)
    REFERENCES `tref_statustask` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `uid_UNIQUE` ON `tref_typetask_status` (`uid` ASC);
CREATE UNIQUE INDEX `code_UNIQUE` ON `tref_typetask_status` (`code` ASC);
CREATE UNIQUE INDEX `id_UNIQUE` ON `tref_typetask_status` (`id` ASC);
CREATE INDEX `fk_typetask_statustask_creator_idx` ON `tref_typetask_status` (`cuser` ASC);
CREATE INDEX `fk_typetask_statustask_updator_idx` ON `tref_typetask_status` (`uuser` ASC);
CREATE INDEX `fk_typestatus_statustask_idx` ON `tref_typetask_status` (`statustask_code` ASC);
CREATE UNIQUE INDEX `table_key_UNIQUE` ON `tref_typetask_status` (`typetask_code` ASC, `statustask_code` ASC, `order` ASC);

-- -----------------------------------------------------
-- function createTask
-- -----------------------------------------------------

USE `myecm-tasks`;
DROP function IF EXISTS `createTask`;

DELIMITER $$
CREATE FUNCTION `createTask` (pStrTitle VARCHAR(100), pStrTypeTaskCode VARCHAR(20)) RETURNS VARCHAR(15)
BEGIN

	DECLARE lLastID INT;
    DECLARE lNewUID VARCHAR(15);
    DECLARE lNewCode VARCHAR(20);

	-- INSERT INTO `myecm-tasks`.`tobj_tasks` (`id`, `uid`, `code`, `typetask_code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
    INSERT INTO `tobj_tasks`(
		`typetask_code`,
		`title`
	)
	VALUES
	(
		pStrTypeTaskCode,
		pStrTitle
	);

    -- Last ID inserted getting!
    SET lLastID = LAST_INSERT_ID();

    SELECT uid,code into lNewUID, lNewCode
    FROM tobj_tasks WHERE id = lLastID;

    -- Launch instanciation !
    CALL _initializedStepsForATaskFromHisType(lNewCode);

    -- Set First Status ON
    UPDATE `tdta_task_statustask` tdta SET tdta.`starttime` = CURRENT_TIMESTAMP
    WHERE tdta.`order`= 1 AND tdta.`task_code` = lNewCode;

    -- Function return value
    RETURN lNewUID;
END $$

DELIMITER ;

-- -----------------------------------------------------
-- procedure createTypeTask
-- -----------------------------------------------------

USE `myecm-tasks`;
DROP procedure IF EXISTS `createTypeTask`;

DELIMITER $$

CREATE PROCEDURE createTypeTask (IN pStrCode VARCHAR(20), IN pStrTitle VARCHAR(100), IN pStrDescription TEXT)
BEGIN
    INSERT INTO tref_typetask(
		`code`,
        `title`,
        `description`)
	VALUES (pStrCode, pStrTitle, pStrDescription);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure createTypeTaskStepStatusOrder
-- -----------------------------------------------------

USE `myecm-tasks`;
DROP procedure IF EXISTS `createTypeTaskStepStatusOrder`;

DELIMITER $$
USE `myecm-tasks`$$
CREATE PROCEDURE `createTypeTaskStepStatusOrder` (IN pStrTypeTaskCode VARCHAR(20),IN pStrStatusTaskCode VARCHAR(20), IN pIntOrder INT)
BEGIN

	DECLARE lIntRowExists_CNT INT;

	-- CHECK IF a row have already this order value
	SELECT COUNT(*) INTO lIntRowExists_CNT FROM tref_typetask_status WHERE typetask_code=pStrTypeTaskCode AND statustask_code = pStrStatusTaskCode AND `order` = pIntOrder;

	IF lIntRowExists_CNT>0 THEN
		UPDATE tref_typetask_status
        SET `order` = `order`+1
        WHERE
			typetask_code=pStrTypeTaskCode
            AND statustask_code = pStrStatusTaskCode
            AND `order` >= pIntOrder
        ORDER BY `order` DESC;
    END IF;

	INSERT INTO tref_typetask_status(
		`typetask_code`,
        `statustask_code`,
        `order`)
	VALUES (pStrTypeTaskCode, pStrStatusTaskCode, pIntOrder);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure createTypeTaskStepStatusAtEnd
-- -----------------------------------------------------

USE `myecm-tasks`;
DROP procedure IF EXISTS `createTypeTaskStepStatusAtEnd`;

DELIMITER $$
USE `myecm-tasks`$$
CREATE PROCEDURE `createTypeTaskStepStatusAtEnd` (IN pStrTypeTaskCode VARCHAR(20),IN pStrStatusTaskCode VARCHAR(20))
BEGIN

	DECLARE TYPETASK_STATUS_MAX_ORDER INT;

    -- Getting Max of existing order for same type and status
    SELECT IFNULL(MAX(tref_typetask_status.order),0) INTO TYPETASK_STATUS_MAX_ORDER
    FROM tref_typetask_status
    WHERE typetask_code = pStrTypeTaskCode;

	INSERT INTO tref_typetask_status(
		`typetask_code`,
        `statustask_code`,
        `order`)
	VALUES (pStrTypeTaskCode, pStrStatusTaskCode, TYPETASK_STATUS_MAX_ORDER+1);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure setTasktoNextStep
-- -----------------------------------------------------

USE `myecm-tasks`;
DROP procedure IF EXISTS `setTasktoNextStep`;

DELIMITER $$
USE `myecm-tasks`$$
CREATE PROCEDURE `setTasktoNextStep` (IN pStrTaskCode VARCHAR(20))
BEGIN

	DECLARE STATUS_ORDER INT;
    DECLARE STATUS_NXT_ORDER INT DEFAULT 0;
    DECLARE REMAINING_STATUS INT;

	-- Getting current Status Step Order data.
    SELECT getTaskCurrentOrder(pStrTaskCode) INTO STATUS_ORDER;

    -- Count remaining status for this Task
    SELECT COUNT(id) INTO REMAINING_STATUS
    FROM tdta_task_statustask WHERE task_code = pStrTaskCode AND tdta_task_statustask.order > STATUS_ORDER;

    IF REMAINING_STATUS > 0 THEN
		SELECT MIN(tdta_task_statustask.order) INTO STATUS_NXT_ORDER
		FROM tdta_task_statustask WHERE task_code = pStrTaskCode AND tdta_task_statustask.order > STATUS_ORDER
        GROUP BY task_code;
    END IF;

    -- If a next status exists !
    IF STATUS_NXT_ORDER <> 0 THEN
		-- Close current Step!
		UPDATE tdta_task_statustask
			SET endtime = CURRENT_TIMESTAMP
		WHERE
			task_code = pStrTaskCode
            and statustask_code = getTaskCurrentStatusCode(pStrTaskCode)
            and tdta_task_statustask.order = STATUS_ORDER;

        -- Open Next one!
        UPDATE tdta_task_statustask
			SET starttime = CURRENT_TIMESTAMP
		WHERE
			task_code = pStrTaskCode
            and statustask_code = getTaskCurrentStatusCode(pStrTaskCode)
            and tdta_task_statustask.order = STATUS_NXT_ORDER;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function getTaskCurrentStatusCode
-- -----------------------------------------------------

USE `myecm-tasks`;
DROP function IF EXISTS `getTaskCurrentStatusCode`;

DELIMITER $$
USE `myecm-tasks`$$
CREATE FUNCTION `getTaskCurrentStatusCode` (pStrTaskCode VARCHAR(20))  RETURNS VARCHAR(20)
BEGIN

	DECLARE STATUSTASK_CODE VARCHAR(20);

	-- Getting current Step of a Task!
	SELECT statustask_code INTO STATUSTASK_CODE
    FROM tdta_task_statustask
	WHERE NOT starttime IS NULL AND endtime IS NULL;

  RETURN  STATUSTASK_CODE;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function getTaskCurrentOrder
-- -----------------------------------------------------

USE `myecm-tasks`;
DROP function IF EXISTS `getTaskCurrentOrder`;

DELIMITER $$
USE `myecm-tasks`$$
CREATE FUNCTION `getTaskCurrentOrder` (pStrTaskCode VARCHAR(20))  RETURNS INT
BEGIN
	DECLARE STATUS_ORDER INT;

	-- Getting current Step of a Task!
	SELECT IFNULL(MAX(tdta_task_statustask.order),0) INTO STATUS_ORDER
    FROM tdta_task_statustask
	WHERE task_code = pStrTaskCode
		AND statustask_code = getTaskCurrentStatusCode(pStrTaskCode)
        AND NOT starttime IS NULL AND endtime IS NULL;

    RETURN STATUS_ORDER;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure _initializedStepsForATaskFromHisType
-- -----------------------------------------------------

USE `myecm-tasks`;
DROP procedure IF EXISTS `_initializedStepsForATaskFromHisType`;

DELIMITER $$
USE `myecm-tasks`$$
CREATE PROCEDURE `_initializedStepsForATaskFromHisType` (IN pStrTaskCode VARCHAR(20))
BEGIN
    -- VARIABLES --------------------------------------------------------------
    DECLARE done INT DEFAULT FALSE;
	  DECLARE lStrTypeTask_CODE VARCHAR(20);
    DECLARE lIntTaskCNT INT DEFAULT 0;
    DECLARE lStrStatusCode 		VARCHAR(20);
    DECLARE lStrTaskTitle 		VARCHAR(100);
	  DECLARE lStrStatusTaskTitle VARCHAR(100);
    DECLARE lStrNewCode			VARCHAR(20);
    DECLARE lStrNewTitle		VARCHAR(500);
    DECLARE lIntStepCNT INT ;

    -- Main Cursor - From type, get all Steps defined into the table tref_typetask_status!
    DECLARE cStepTypeTask CURSOR FOR
		  SELECT statustask_code
        FROM tref_typetask_status tstatus
        WHERE typetask_code = lStrTypeTask_CODE
        ORDER BY tstatus.order;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
      SET done = TRUE;


    -- BEGIN --------------------------------------------------------------
    -- Getting TypeTask of the Task!
    SELECT typetask_code,title INTO lStrTypeTask_CODE, lStrTaskTitle
    FROM tobj_tasks
    WHERE code = pStrTaskCode;

    -- Getting number of tasks!
    SELECT count(*) INTO lIntTaskCNT
    FROM tobj_tasks;

    -- Creation for each instance.
    open cStepTypeTask;


    SET lIntStepCNT = 0;

creationTaskSteps_loop: loop

	-- Reset local variables
    SET done = FALSE;
    SET lStrStatusTaskTitle = NULL;
    SET lStrStatusCode = NULL;
    SET lStrNewTitle = NULL;
    SET lStrNewCode = NULL;

    -- Next Row - Fecthing cursor ...
fetch cStepTypeTask into lStrStatusCode;

	  --  Final case : exit loop!
    IF done = TRUE THEN
      LEAVE creationTaskSteps_loop;
    END IF;

    -- Getting status title ...
    SELECT title INTO lStrStatusTaskTitle FROM tref_statustask WHERE code = lStrStatusCode;

    -- Building title!
    SET lStrNewTitle = CONCAT(
		    lStrTaskTitle,
        ' - ',
        LPAD(cast(lIntStepCNT+1 as CHAR),3,'0'),
        ' - ',
        lStrStatusTaskTitle);

	SET lStrNewCode = CONCAT(
		LPAD(cast(lIntTaskCNT+1 as CHAR),5,'0'),
    '.',
    LPAD(cast(lIntStepCNT+1 as CHAR),2,'0'));

	-- Adding new record into the table tdta_task_statustask
	INSERT INTO tdta_task_statustask (
		  `task_code`,
      `statustask_code`,
      `order`,
      `code`,
      `title`)
    VALUES(pStrTaskCode
      ,lStrStatusCode
      ,lIntStepCNT+1
      ,lStrNewCode
      ,lStrNewTitle);

      SET lIntStepCNT = lIntStepCNT + 1;

	-- INSERT INTO `myecm-tasks`.`tdta_task_statustask` (`id`, `task_code`, `statustask_code`, `order`, `uid`, `code`, `title`, `description`, `command`, `starttime`, `endtime`, `log_command`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

end loop creationTaskSteps_loop;

close cStepTypeTask;

END$$

DELIMITER ;
USE `myecm-tasks`;

DELIMITER $$

USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tref_typetask_BEFORE_INSERT` $$
USE `myecm-tasks`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm-tasks`.`tref_typetask_BEFORE_INSERT` BEFORE INSERT ON `tref_typetask` FOR EACH ROW
BEGIN
  DECLARE TTASK_CNT INT;
  SELECT IFNULL(COUNT(id),0) INTO TTASK_CNT FROM tref_typetask;
  SET NEW.uid = CONCAT('TTYP-',LPAD(CONVERT(TTASK_CNT+1,CHAR),10,'0'));
  SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tref_typetask_AFTER_INSERT` $$
USE `myecm-tasks`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm-tasks`.`tref_typetask_AFTER_INSERT` AFTER INSERT ON `tref_typetask` FOR EACH ROW
BEGIN
	CALL myecm.logDataInsert('tref_typetask',NEW.uid,NEW.code);
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tref_typetask_BEFORE_UPDATE` $$
USE `myecm-tasks`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm-tasks`.`tref_typetask_BEFORE_UPDATE` BEFORE UPDATE ON `tref_typetask` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tref_typetask_AFTER_UPDATE` $$
USE `myecm-tasks`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm-tasks`.`tref_typetask_AFTER_UPDATE` AFTER UPDATE ON `tref_typetask` FOR EACH ROW
BEGIN
	CALL myecm.logDataUpdate('tref_typetask',NEW.uid,NEW.code);
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tobj_tasks_BEFORE_INSERT` $$
USE `myecm-tasks`$$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tobj_tasks_BEFORE_INSERT`
BEFORE INSERT ON `myecm-tasks`.`tobj_tasks`
FOR EACH ROW
BEGIN
	SET NEW.uid = CONCAT('T',
		CONVERT(YEAR(NOW()),CHAR),
        LPAD(CONVERT(MONTH(NOW()),CHAR),2,'0'),
        LPAD(CONVERT(DAY(NOW()),CHAR),2,'0'),
        LPAD(CONVERT(HOUR(NOW()),CHAR),2,'0'),
        LPAD(CONVERT(MINUTE(NOW()),CHAR),2,'0'),
        LPAD(CONVERT(SECOND(NOW()),CHAR),2,'0'));
	SET NEW.code = CONCAT('T',
		'-',
		CONVERT(YEAR(NOW()),CHAR),
        LPAD(CONVERT(MONTH(NOW()),CHAR),2,'0'),
        LPAD(CONVERT(DAY(NOW()),CHAR),2,'0'),
        '-',
        LPAD(CONVERT(HOUR(NOW()),CHAR),2,'0'),
        LPAD(CONVERT(MINUTE(NOW()),CHAR),2,'0'),
        LPAD(CONVERT(SECOND(NOW()),CHAR),2,'0'));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tobj_tasks_AFTER_INSERT` $$
USE `myecm-tasks`$$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tobj_tasks_AFTER_INSERT`
AFTER INSERT ON `myecm-tasks`.`tobj_tasks`
FOR EACH ROW
BEGIN
	CALL myecm.logDataInsert('tobj_tasks',NEW.uid,NEW.code);
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tobj_tasks_BEFORE_UPDATE` $$
USE `myecm-tasks`$$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tobj_tasks_BEFORE_UPDATE`
BEFORE UPDATE ON `myecm-tasks`.`tobj_tasks`
FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tobj_tasks_AFTER_UPDATE` $$
USE `myecm-tasks`$$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tobj_tasks_AFTER_UPDATE`
AFTER UPDATE ON `myecm-tasks`.`tobj_tasks`
FOR EACH ROW
BEGIN
CALL myecm.logDataUpdate('tobj_tasks',NEW.uid,NEW.code);
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tref_status_BEFORE_INSERT` $$
USE `myecm-tasks`$$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tref_status_BEFORE_INSERT`
BEFORE INSERT ON `myecm-tasks`.`tref_statustask`
FOR EACH ROW
BEGIN
	SET NEW.uid = CONCAT('TSTA-',UCASE(NEW.code));
  SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tref_status_AFTER_INSERT` $$
USE `myecm-tasks`$$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tref_status_AFTER_INSERT`
AFTER INSERT ON `myecm-tasks`.`tref_statustask`
FOR EACH ROW
BEGIN
	CALL myecm.logDataInsert('tref_statustask',NEW.uid,NEW.code);
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tref_status_BEFORE_UPDATE` $$
USE `myecm-tasks`$$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tref_status_BEFORE_UPDATE`
BEFORE UPDATE ON `myecm-tasks`.`tref_statustask`
FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tref_status_AFTER_UPDATE` $$
USE `myecm-tasks`$$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tref_status_AFTER_UPDATE`
AFTER UPDATE ON `myecm-tasks`.`tref_statustask`
FOR EACH ROW
BEGIN
CALL myecm.logDataUpdate('tref_statustask',NEW.uid,NEW.code);
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tdta_task_statustask_BEFORE_INSERT` $$
USE `myecm-tasks`$$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tdta_task_statustask_BEFORE_INSERT`
BEFORE INSERT ON `myecm-tasks`.`tdta_task_statustask`
FOR EACH ROW
BEGIN
	SET NEW.uid = CONCAT('TSKSTA-',UCASE(NEW.code));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tdta_task_statustask_AFTER_INSERT` $$
USE `myecm-tasks`$$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tdta_task_statustask_AFTER_INSERT`
AFTER INSERT ON `myecm-tasks`.`tdta_task_statustask`
FOR EACH ROW
BEGIN
	CALL myecm.logDataInsert('tdta_task_statustask',NEW.uid,NEW.code);
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tdta_task_statustask_BEFORE_UPDATE` $$
USE `myecm-tasks`$$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tdta_task_statustask_BEFORE_UPDATE`
BEFORE UPDATE ON `myecm-tasks`.`tdta_task_statustask`
FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tdta_task_statustask_AFTER_UPDATE` $$
USE `myecm-tasks`$$
CREATE
DEFINER=`polux`@`%`
TRIGGER `myecm-tasks`.`tdta_task_statustask_AFTER_UPDATE`
AFTER UPDATE ON `myecm-tasks`.`tdta_task_statustask`
FOR EACH ROW
BEGIN
CALL myecm.logDataUpdate('tdta_task_statustask',NEW.uid,NEW.code);
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tref_typetask_status_BEFORE_INSERT` $$
USE `myecm-tasks`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm-tasks`.`tref_typetask_status_BEFORE_INSERT` BEFORE INSERT ON `tref_typetask_status` FOR EACH ROW
BEGIN
	  DECLARE TTSTATUS_CNT INT;

    SELECT COUNT(id) INTO TTSTATUS_CNT FROM tref_typetask_status;
    SET NEW.uid = CONCAT('TTST-',LPAD(CONVERT(TTSTATUS_CNT+1,CHAR),10,'0'));
    SET NEW.code = CONCAT('TTST-',
		    LPAD(CONVERT(TTSTATUS_CNT+1,CHAR),10,'0'),'-',
        LPAD(CONVERT(NEW.`order`,CHAR),4,'0'));
	  SET NEW.title = CONCAT(NEW.typetask_code,' - ',LPAD(CONVERT(NEW.`order` ,CHAR),3,'0'),' - ',NEW.statustask_code);
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tref_typetask_status_AFTER_INSERT` $$
USE `myecm-tasks`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm-tasks`.`tref_typetask_status_AFTER_INSERT` AFTER INSERT ON `tref_typetask_status` FOR EACH ROW
BEGIN
	CALL myecm.logDataInsert('tref_typetask_status',NEW.uid,NEW.code);
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tref_typetask_status_BEFORE_UPDATE` $$
USE `myecm-tasks`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm-tasks`.`tref_typetask_status_BEFORE_UPDATE` BEFORE UPDATE ON `tref_typetask_status` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm-tasks`$$
DROP TRIGGER IF EXISTS `tref_typetask_status_AFTER_UPDATE` $$
USE `myecm-tasks`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm-tasks`.`tref_typetask_status_AFTER_UPDATE` AFTER UPDATE ON `tref_typetask_status` FOR EACH ROW
BEGIN
	CALL myecm.logDataUpdate('tref_typetask_status',NEW.uid,NEW.code);
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `tref_typetask`
-- -----------------------------------------------------
START TRANSACTION;
USE `myecm-tasks`;
INSERT INTO `tref_typetask` (`code`, `title`, `description`) VALUES ('GENERIC', 'Tâche générique', 'Traitement générique');
INSERT INTO `tref_typetask` (`code`, `title`, `description`) VALUES ('OCR', 'Reconnaissance optique de caractères', 'Traitement OCR - Reconnaissance optique de caractères.');
INSERT INTO `tref_typetask` (`code`, `title`, `description`) VALUES ('FILECOPY', 'Copie de fichier(s).', 'Traitement sur le filesystem - Copie de fichier.');
INSERT INTO `tref_typetask` (`code`, `title`, `description`) VALUES ('FILEMOVE', 'Déplacement de fichier(s).', 'Traitement sur le filesystem - Déplcament de fichier.');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tref_statustask`
-- -----------------------------------------------------
START TRANSACTION;
USE `myecm-tasks`;
INSERT INTO `tref_statustask` (`code`, `title`, `description`) VALUES ('CREATED', 'Créée', 'Statut POST Création.');
INSERT INTO `tref_statustask` (`code`, `title`, `description`) VALUES ('INITIALIZED', 'Initilialisée', 'Statut POST Initialisation.');
INSERT INTO `tref_statustask` (`code`, `title`, `description`) VALUES ('ENDED', 'Finie', 'Statut de fin de traitement de tâche.');
INSERT INTO `tref_statustask` (`code`, `title`, `description`) VALUES ('INPROGRESS', 'En cours', 'Statut d\'éxecution de la ta^che.');

COMMIT;

-- --------------------------------------------------------------- --
-- Définition des status par type de tâche.
-- --------------------------------------------------------------- --
START TRANSACTION;
USE `myecm-tasks`;

CALL createTypeTaskStepStatusAtEnd('GENERIC','CREATED');
CALL createTypeTaskStepStatusAtEnd('GENERIC','INITIALIZED');
CALL createTypeTaskStepStatusAtEnd('GENERIC','INPROGRESS');
CALL createTypeTaskStepStatusAtEnd('GENERIC','ENDED');

CALL createTypeTaskStepStatusAtEnd('OCR','CREATED');
CALL createTypeTaskStepStatusAtEnd('OCR','INITIALIZED');
CALL createTypeTaskStepStatusAtEnd('OCR','INPROGRESS');
CALL createTypeTaskStepStatusAtEnd('OCR','ENDED');

COMMIT;
