-- -----------------------------------------------------
-- Table `DEFAULT_OBJTABLE`
-- -----------------------------------------------------
USE `TARGET_SCHEMA`;
DROP TABLE IF EXISTS `DEFAULT_OBJTABLE` ;

CREATE TABLE IF NOT EXISTS `DEFAULT_OBJTABLE` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `bid` VARCHAR(50) NULL DEFAULT NULL,
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Short Title not defined',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Long Title not defined',
  `comment` TEXT NULL DEFAULT NULL,
  `cuser` VARCHAR(100) DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_DEFOBJ_USER_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DEFOBJ_USER_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'DEFAULT_OBJTABLE_COMMENT';

CREATE UNIQUE INDEX `UQ_BID` ON `DEFAULT_OBJTABLE` (`bid` ASC);
CREATE INDEX `FK_DEFOBJ_USER_CUSER_idx` ON `DEFAULT_OBJTABLE` (`cuser` ASC);
CREATE INDEX `FK_DEFOBJ_USER_UUSER_idx` ON `DEFAULT_OBJTABLE` (`uuser` ASC);

-- -----------------------------------------------------------------------------
-- TRIGGERS
-- -----------------------------------------------------------------------------
DELIMITER $$

USE `TARGET_SCHEMA`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_DEFAULT_OBJTABLE` $$
USE `TARGET_SCHEMA`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_DEFAULT_OBJTABLE BEFORE INSERT ON DEFAULT_OBJTABLE FOR EACH ROW
BEGIN

	DECLARE lStrNewTID VARCHAR(30);

  SELECT CORE_GenNewTIDForTable('DEFAULT_OBJTABLE') INTO lStrNewTID ;
	SET NEW.tid = lStrNewTID;
  IF NEW.bid IS NULL THEN
  	SET NEW.bid = lStrNewTID;
	END IF;
	SET NEW.CUSER = CURRENT_USER;

END$$


USE `TARGET_SCHEMA`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_DEFAULT_OBJTABLE` $$
USE `TARGET_SCHEMA`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_DEFAULT_OBJTABLE AFTER INSERT ON DEFAULT_OBJTABLE FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Insert(NEW.tid);
  CALL CORE_RegisterNewTID(NEW.tid,'DEFAULT_OBJTABLE');

  INSERT INTO `CORE_ATTROBJECTS`
  (
    `stitle`,
    `ltitle`,
    `obj_tid`,
    `adef_tid`,
    `attr_value`,
    `comment`
  )
  SELECT
    `stitle`,
    `ltitle`,
    NEW.tid,
    `tid`,
    `attr_default_value`,
    `comment`
  FROM `CORE_ATTRDEFS`
  WHERE `tobj_tid` = CORE_getTIDObjectTypeFromTableName('DEFAULT_OBJTABLE');

END$$


USE `TARGET_SCHEMA`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_DEFAULT_OBJTABLE` $$
USE `TARGET_SCHEMA`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_DEFAULT_OBJTABLE BEFORE UPDATE ON DEFAULT_OBJTABLE FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
  SET NEW.utime = NOW();
END$$

USE `TARGET_SCHEMA`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_DEFAULT_OBJTABLE` $$
USE `TARGET_SCHEMA`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_DEFAULT_OBJTABLE AFTER UPDATE ON DEFAULT_OBJTABLE FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Update(NEW.tid);
END$$

DELIMITER ;

-- -----------------------------------------------------------------------------
-- Ajout de la definition de l'objet aux tables du CORE
-- -----------------------------------------------------------------------------
INSERT INTO `TARGET_SCHEMA`.`CORE_TYPEOBJECTS`(
  `stitle`,
  `ltitle`,
  `comment`,
  `obj_prefix`,
  `obj_tablename`,
  `obj_type`
) VALUES (
  'DEFAULT_OBJTABLE_STITLE',
  'DEFAULT_OBJTABLE_LTITLE',
  'DEFAULT_OBJTABLE_COMMENT',
  'DEFAULT_OBJTABLE_PREFIX',
  'DEFAULT_OBJTABLE',
  'Simple'
);
