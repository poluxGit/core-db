
-- -------------------------------------------------------------------------- --
-- From Source file : SQL-INIT-01.00-INIT_SCHEMA.sql
-- -------------------------------------------------------------------------- --

-- -------------------------------------------------------------------------- --
-- COREDEV01 - Database - Deployment Script - Tables and indexes          --
-- -------------------------------------------------------------------------- --
-- @author : poluxGit <polux@poluxfr.org>                                     --
-- -------------------------------------------------------------------------- --
-- Database version : 00.01                                              --
-- Generation time : 2017-10-03_00:36:58                                                 --
-- -------------------------------------------------------------------------- --
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -------------------------------------------------------------------------- --
-- CORE Application Main Database `COREDEV01`                            --
-- -------------------------------------------------------------------------- --
DROP SCHEMA IF EXISTS `COREDEV01`;
CREATE SCHEMA IF NOT EXISTS `COREDEV01` DEFAULT CHARACTER SET utf8 ;
USE `COREDEV01`;

-- -------------------------------------------------------------------------- --
-- From Source file : SQL-TAB-01.00-USERS_TABLES.sql
-- -------------------------------------------------------------------------- --

-- -----------------------------------------------------
-- Table `CORE_USER_ACCOUNTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_USER_ACCOUNTS` ;

CREATE TABLE IF NOT EXISTS `CORE_USER_ACCOUNTS` (
  `tid` VARCHAR(100) NOT NULL DEFAULT 'TID-NOTDEF',
  `firstname` VARCHAR(100) NOT NULL DEFAULT 'Short Title not defined',
  `lastname` VARCHAR(100) NOT NULL DEFAULT 'Long Title not defined',
  `comment` TEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `isSystem` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`tid`))
ENGINE = InnoDB
COMMENT = 'Users\' account table.';

-- -------------------------------------------------------------------------- --
-- From Source file : SQL-TAB-01.01-CORE_TABLES.sql
-- -------------------------------------------------------------------------- --


-- -----------------------------------------------------
-- Table `CORE_TYPEOBJECTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_TYPEOBJECTS` ;

CREATE TABLE IF NOT EXISTS `CORE_TYPEOBJECTS` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `bid` VARCHAR(50) UNIQUE NOT NULL DEFAULT 'BID-NOTDEF',
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Short Title not defined',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Long Title not defined',
  `comment` TEXT NULL DEFAULT NULL,
  `obj_prefix` VARCHAR(5) NOT NULL DEFAULT 'NDEF',
  `obj_tablename` VARCHAR(150) NULL DEFAULT NULL,
  `cuser` VARCHAR(100) NOT NULL DEFAULT 'notdefined',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `obj_type` ENUM('Simple', 'Complex', 'System') NOT NULL DEFAULT 'Simple',
  `isSystem` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_TYPEOBJ_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TYPEOBJ_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Type of Objects.';

-- -----------------------------------------------------
-- Index on Table `CORE_TYPEOBJECTS`
-- -----------------------------------------------------
CREATE UNIQUE INDEX `UQ_BID` ON `CORE_TYPEOBJECTS` (`bid` ASC);
CREATE INDEX `FK_TYPEOBJ_CUSER_idx` ON `CORE_TYPEOBJECTS` (`cuser` ASC);
CREATE INDEX `FK_TYPEOBJ_UUSER_idx` ON `CORE_TYPEOBJECTS` (`uuser` ASC);

-- -----------------------------------------------------
-- Table `CORE_TYPELINKS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_TYPELINKS` ;

CREATE TABLE IF NOT EXISTS `CORE_TYPELINKS` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `bid` VARCHAR(50) UNIQUE NOT NULL DEFAULT 'BID-NOTDEF',
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Short Title not defined' COMMENT 'Short title of Object',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Long Title not defined' COMMENT 'Long title of object',
  `typobj_src` VARCHAR(30) NULL DEFAULT NULL COMMENT 'Type of source object',
  `typobj_dst` VARCHAR(30) NULL DEFAULT NULL COMMENT 'Type of destination object',
  `comment` TEXT NULL DEFAULT NULL,
  `cuser` VARCHAR(100) NOT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `isSystem` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_TYPLNK_OBJSRC`
    FOREIGN KEY (`typobj_src`)
    REFERENCES `CORE_TYPEOBJECTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TYPLNK_OBJDST`
    FOREIGN KEY (`typobj_dst`)
    REFERENCES `CORE_TYPEOBJECTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TYPLNK_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TYPLNK_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Type of linked between Objects.';

-- -----------------------------------------------------
-- Index on Table `CORE_TYPELINKS`
-- -----------------------------------------------------
CREATE UNIQUE INDEX `UQ_BID` ON `CORE_TYPELINKS` (`bid` ASC);
CREATE INDEX `FK_TYPLNK_OBJSRC_idx` ON `CORE_TYPELINKS` (`typobj_src` ASC);
CREATE INDEX `FK_TYPLNK_OBJDST_idx` ON `CORE_TYPELINKS` (`typobj_dst` ASC);
CREATE INDEX `FK_TYPLNK_CUSER_idx` ON `CORE_TYPELINKS` (`cuser` ASC);
CREATE INDEX `FK_TYPLNK_UUSER_idx` ON `CORE_TYPELINKS` (`uuser` ASC);

-- -----------------------------------------------------
-- Table `CORE_ATTRDEFS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_ATTRDEFS` ;

CREATE TABLE IF NOT EXISTS `CORE_ATTRDEFS` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `tlnk_tid` VARCHAR(30) NULL DEFAULT NULL COMMENT 'Type of links concerned',
  `tobj_tid` VARCHAR(30) NULL DEFAULT NULL,
  `bid` VARCHAR(50) NULL DEFAULT NULL,
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Short Title not defined',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Long Title not defined',
  `attr_type` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Type of Attribute definition',
  `attr_pattern` VARCHAR(200) NULL DEFAULT NULL,
  `attr_default_value` VARCHAR(1000) NULL DEFAULT NULL,
  `comment` TEXT NULL DEFAULT NULL,
  `cuser` VARCHAR(100) NOT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `isSystem` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_DEFS_TYPLNK`
    FOREIGN KEY (`tlnk_tid`)
    REFERENCES `CORE_TYPELINKS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DEFS_TYPOBJ`
    FOREIGN KEY (`tobj_tid`)
    REFERENCES `CORE_TYPEOBJECTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DEFS_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DEFS_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Attributes definitions.';

-- -----------------------------------------------------
-- Index on Table `CORE_ATTRDEFS`
-- -----------------------------------------------------
CREATE INDEX `fk_CORE_ATTRDEFS_CORE_TYPELINKS1_idx` ON `CORE_ATTRDEFS` (`tlnk_tid` ASC);
CREATE INDEX `FK_ATTRDEFS_TYPEOBJECT_idx` ON `CORE_ATTRDEFS` (`tobj_tid` ASC);
CREATE INDEX `FK_DEFS_CUSER_idx` ON `CORE_ATTRDEFS` (`cuser` ASC);
CREATE INDEX `FK_DEFS_UUSER_idx` ON `CORE_ATTRDEFS` (`uuser` ASC);

-- -----------------------------------------------------
-- Table `CORE_ATTROBJECTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_ATTROBJECTS` ;

CREATE TABLE IF NOT EXISTS `CORE_ATTROBJECTS` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `bid` VARCHAR(50) DEFAULT NULL,
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Short Title not defined',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Long Title not defined',
  `obj_tid` VARCHAR(30) NULL DEFAULT NULL COMMENT 'Object Unique TID',
  `adef_tid` VARCHAR(30) NOT NULL COMMENT 'Attribute definition key',
  `attr_value` TEXT NULL DEFAULT NULL,
  `comment` TEXT NULL DEFAULT NULL,
  `cuser` VARCHAR(100) NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `isSystem` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_ATTRDEF_ATTROBJ`
    FOREIGN KEY (`adef_tid`)
    REFERENCES `CORE_ATTRDEFS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ATTROBJ_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ATTROBJ_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Object attributes values items.';

-- -----------------------------------------------------
-- Index on Table `CORE_ATTROBJECTS`
-- -----------------------------------------------------
CREATE INDEX `FK_ATTROBJ_DEFS_idx` ON `CORE_ATTROBJECTS` (`adef_tid` ASC);
CREATE INDEX `FK_ATTROBJ_CUSER_idx` ON `CORE_ATTROBJECTS` (`cuser` ASC);
CREATE INDEX `FK_ATTROBJ_UUSER_idx` ON `CORE_ATTROBJECTS` (`uuser` ASC);

-- -----------------------------------------------------
-- Table `CORE_TID`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_TID` ;

CREATE TABLE IF NOT EXISTS `CORE_TID` (
  `tid` VARCHAR(30) NOT NULL COMMENT 'Unique TID of Object.',
  `obj_tablename` VARCHAR(150) NOT NULL COMMENT 'Tablename of Object',
  PRIMARY KEY (`tid`))
ENGINE = InnoDB
COMMENT = 'All Object of database TID references.';


-- -----------------------------------------------------
-- Table `CORE_LINKS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_LINKS`;

CREATE TABLE IF NOT EXISTS `CORE_LINKS` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `bid` VARCHAR(50) UNIQUE NOT NULL DEFAULT 'BID-NOTDEF',
  `tlnk_tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `objsrc` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `objdst` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `cuser` VARCHAR(100) NOT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_LNK_TYLNK`
      FOREIGN KEY (`tlnk_tid`)
      REFERENCES `CORE_TYPELINKS` (`tid`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  CONSTRAINT `FK_LNK_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_LNK_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Objects Links Table.';

CREATE UNIQUE INDEX `UQ_BID` ON `CORE_LINKS` (`bid` ASC);
CREATE INDEX `FK_LNK_TYLNK_idx` ON `CORE_LINKS` (`tlnk_tid` ASC);
CREATE INDEX `FK_LNK_CUSER_idx` ON `CORE_LINKS` (`cuser` ASC);
CREATE INDEX `FK_LNK_UUSER_idx` ON `CORE_LINKS` (`uuser` ASC);

-- -------------------------------------------------------------------------- --
-- From Source file : SQL-TAB-01.02-LOGS_TABLES.sql
-- -------------------------------------------------------------------------- --

-- -----------------------------------------------------
-- Table `CORE_LOGS_DATAEVTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_LOGS_DATAEVTS` ;

CREATE TABLE IF NOT EXISTS `CORE_LOGS_DATAEVTS` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `obj_tid` VARCHAR(30) NOT NULL,
  `message` VARCHAR(400) NOT NULL,
  `cuser` VARCHAR(100) NOT NULL DEFAULT 'NOTDEFINED',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_LOGDTAEVT_USER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Data events logs table.';

CREATE INDEX `FK_LOGDTAEVT_USER_idx` ON `CORE_LOGS_DATAEVTS` (`cuser` ASC);

-- -------------------------------------------------------------------------- --
-- From Source file : SQL-ROU-01.01-ROUTINES_LOGS.sql
-- -------------------------------------------------------------------------- --

-- -----------------------------------------------------
-- procedure LOGS_LogDataEvent_Insert
-- -----------------------------------------------------

USE `COREDEV01`;
DROP procedure IF EXISTS `LOGS_LogDataEvent_Insert`;

DELIMITER $$

USE `COREDEV01`$$
CREATE PROCEDURE LOGS_LogDataEvent_Insert(IN pStrTIDObject VARCHAR(30))
BEGIN

	DECLARE lStrMsg VARCHAR(400);

    SET lStrMsg = CONCAT('New "',pStrTIDObject,'" data inserted successfully.');

    INSERT INTO CORE_LOGS_DATAEVTS
    (`obj_tid`, `message`) VALUES (pStrTIDObject, lStrMsg);


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure LOGS_LogDataEvent_Update
-- -----------------------------------------------------

USE `COREDEV01`;
DROP procedure IF EXISTS `LOGS_LogDataEvent_Update`;

DELIMITER $$
USE `COREDEV01`$$
CREATE PROCEDURE LOGS_LogDataEvent_Update(IN pStrTIDObject VARCHAR(30))
BEGIN

	DECLARE lStrMsg VARCHAR(400);

    SET lStrMsg = CONCAT('Object "',pStrTIDObject,'" data updated successfully.');

    INSERT INTO CORE_LOGS_DATAEVTS
    (`obj_tid`, `message`) VALUES (pStrTIDObject, lStrMsg);


END$$

DELIMITER ;

-- -------------------------------------------------------------------------- --
-- From Source file : SQL-ROU-01.02-ROUTINES_CORE.sql
-- -------------------------------------------------------------------------- --


-- -----------------------------------------------------
-- function CORE_GetTablenameFromObjectTypeTID
-- -----------------------------------------------------

USE `COREDEV01`;
DROP function IF EXISTS `CORE_GetTablenameFromObjectTypeTID`;

DELIMITER $$
USE `COREDEV01`$$
CREATE FUNCTION CORE_GetTablenameFromObjectTypeTID (pStrObjTypeTID VARCHAR(30)) RETURNS VARCHAR(150)
BEGIN
	DECLARE lStrResult VARCHAR(150);

    -- tid, bid, stitle, ltitle, comment, obj_type, obj_prefix, obj_tablename, cuser, ctime, uuser, utime, isActive, obj_type
    SELECT obj_tablename INTO lStrResult
    FROM CORE_TYPEOBJECTS WHERE tid = pStrObjTypeTID;

    RETURN lStrResult;
END$$

DELIMITER ;


-- -----------------------------------------------------
-- function CORE_getTIDObjectTypeFromTableName
-- -----------------------------------------------------

USE `COREDEV01`;
DROP function IF EXISTS `CORE_getTIDObjectTypeFromTableName`;

DELIMITER $$
USE `COREDEV01`$$
CREATE FUNCTION CORE_getTIDObjectTypeFromTableName (pStrObjTablename VARCHAR(150)) RETURNS VARCHAR(30)
BEGIN
	DECLARE lStrResult VARCHAR(30);

    -- tid, bid, stitle, ltitle, comment, obj_type, obj_prefix, obj_tablename, cuser, ctime, uuser, utime, isActive, obj_type
    SELECT tid INTO lStrResult
    FROM CORE_TYPEOBJECTS WHERE obj_tablename = pStrObjTablename;

    RETURN lStrResult;
END$$

DELIMITER ;


-- -----------------------------------------------------
-- function CORE_GetTablenameFromObjectType
-- -----------------------------------------------------

USE `COREDEV01`;
DROP function IF EXISTS `CORE_GetTablenameFromObjectType`;

DELIMITER $$
USE `COREDEV01`$$
CREATE FUNCTION CORE_GetTablenameFromObjectType (pStrObjType VARCHAR(45)) RETURNS VARCHAR(150)
BEGIN
	DECLARE lStrResult VARCHAR(150);

    -- tid, bid, stitle, ltitle, comment, obj_type, obj_prefix, obj_tablename, cuser, ctime, uuser, utime, isActive, obj_type
    SELECT obj_tablename INTO lStrResult
    FROM CORE_TYPEOBJECTS WHERE obj_type = pStrObjType;

    RETURN lStrResult;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function CORE_GenNewTIDForTable
-- -----------------------------------------------------
USE `COREDEV01`;
DROP function IF EXISTS `CORE_GenNewTIDForTable`;

DELIMITER $$
USE `COREDEV01`$$
CREATE FUNCTION CORE_GenNewTIDForTable (pStrTableName VARCHAR(150)) RETURNS VARCHAR(30)
BEGIN
	DECLARE lStrPrefixObject VARCHAR(5);
    DECLARE lStrNewTID VARCHAR(30);
    DECLARE lIntNbRows LONG;

    -- tid, bid, stitle, ltitle, comment, obj_type, obj_prefix, obj_tablename, cuser, ctime, uuser, utime, isActive, obj_type
    SELECT obj_prefix INTO lStrPrefixObject
    FROM CORE_TYPEOBJECTS WHERE obj_tablename = pStrTableName;

		select TABLE_ROWS INTO lIntNbRows from information_schema.TABLES
		where TABLE_NAME=pStrTableName AND TABLE_SCHEMA='COREDEV01';

    SET lStrNewTID = CONCAT(lStrPrefixObject,'-',LPAD(CONVERT(lIntNbRows+1,CHAR),(29-LENGTH(lStrPrefixObject)),'0'));

    RETURN lStrNewTID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CORE_RegisterNewTID
-- -----------------------------------------------------
USE `COREDEV01`;
DROP procedure IF EXISTS `CORE_RegisterNewTID`;

DELIMITER $$
USE `COREDEV01`$$
CREATE PROCEDURE CORE_RegisterNewTID (IN pStrTID VARCHAR(30),IN pStrTableName VARCHAR(150))
BEGIN
	INSERT INTO CORE_TID ( tid, obj_tablename) VALUES (pStrTID,pStrTableName);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure CORE_addTypeLinkFromTableName
-- -----------------------------------------------------

USE `COREDEV01`;
DROP procedure IF EXISTS `CORE_addTypeLinkFromTableName`;

DELIMITER $$
USE `COREDEV01`$$
CREATE PROCEDURE CORE_addTypeLinkFromTableName (IN pStrShortTile VARCHAR(30),IN pStrLongTile VARCHAR(100),IN pStrComment TEXT, IN pStrTableNameParent VARCHAR(150), IN pStrTableNameSon VARCHAR(150))
BEGIN

	DECLARE lStrObjSrcTID VARCHAR(30);
	DECLARE lStrObjDstTID VARCHAR(30);

	SELECT tid INTO lStrObjSrcTID
	FROM CORE_TYPEOBJECTS WHERE obj_tablename = pStrTableNameParent;

	SELECT tid INTO lStrObjDstTID
	FROM CORE_TYPEOBJECTS WHERE obj_tablename = pStrTableNameSon;

	-- TODO Gestion d'erreurs !

	INSERT INTO `CORE_TYPELINKS`
	(
		`stitle`,
		`ltitle`,
		`typobj_src`,
		`typobj_dst`,
		`comment`,
		`cuser`
	)
	VALUES
	(
		pStrShortTile,
		pStrLongTile,
		lStrObjSrcTID,
		lStrObjDstTID,
		pStrComment,
		CURRENT_USER
	);
END$$

DELIMITER ;


-- -----------------------------------------------------
-- procedure CORE_addAttributeDefinitionForAnObject
-- -----------------------------------------------------

USE `COREDEV01`;
DROP procedure IF EXISTS `CORE_addAttributeDefinitionForAnObject`;

DELIMITER $$
USE `COREDEV01`$$
CREATE PROCEDURE CORE_addAttributeDefinitionForAnObject (IN pTypeObjTableName VARCHAR(150),IN pStrShortTitle VARCHAR(30),IN pStrLongTitle VARCHAR(100),IN pStrComment TEXT, IN pStrAttrType VARCHAR(100), IN pStrAttrPattern VARCHAR(200), IN pStrAttrDefaultValue VARCHAR(1000))
BEGIN

	DECLARE lStrObjTID VARCHAR(30);

	SELECT tid INTO lStrObjTID
	FROM CORE_TYPEOBJECTS WHERE obj_tablename = pTypeObjTableName;

	-- TODO Gestion d'erreurs !

	INSERT INTO `CORE_ATTRDEFS`
	(
		`tobj_tid`,
		`stitle`,
		`ltitle`,
		`attr_type`,
		`attr_pattern`,
		`attr_default_value`,
		`comment`,
		`cuser`)
	VALUES
	(
		lStrObjTID,
		pStrShortTitle,
		pStrLongTitle,
		pStrAttrType,
		pStrAttrPattern,
		pStrAttrDefaultValue,
		pStrComment,
		CURRENT_USER
	);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CORE_addAttributeDefinitionForALink
-- -----------------------------------------------------

USE `COREDEV01`;
DROP procedure IF EXISTS `CORE_addAttributeDefinitionForALink`;

DELIMITER $$
USE `COREDEV01`$$
CREATE PROCEDURE CORE_addAttributeDefinitionForALink (IN pTypeObjTableNameSrc VARCHAR(150),IN pTypeObjTableNameDst VARCHAR(150),IN pStrShortTitle VARCHAR(30),IN pStrLongTitle VARCHAR(100),IN pStrComment TEXT, IN pStrAttrType VARCHAR(100), IN pStrAttrPattern VARCHAR(200), IN pStrAttrDefaultValue VARCHAR(1000))
BEGIN

	DECLARE lStrLnkTID VARCHAR(30);
	DECLARE lStrObjSrcPrefix VARCHAR(5);
	DECLARE lStrObjDstPrefix VARCHAR(5);

	SELECT obj_prefix INTO lStrObjSrcPrefix
	FROM CORE_TYPEOBJECTS WHERE obj_tablename = pTypeObjTableNameSrc;

	SELECT obj_prefix INTO lStrObjDstPrefix
	FROM CORE_TYPEOBJECTS WHERE obj_tablename = pTypeObjTableNameDst;

	SELECT tid INTO lStrLnkTID
	FROM CORE_TYPELINKS WHERE bid = CONCAT('TYLNK-',lStrObjSrcPrefix,'_',lStrObjDstPrefix);

	-- TODO Gestion d'erreurs !

	INSERT INTO `CORE_ATTRDEFS`
	(
		`tlnk_tid`,
		`stitle`,
		`ltitle`,
		`attr_type`,
		`attr_pattern`,
		`attr_default_value`,
		`comment`,
		`cuser`)
	VALUES
	(
		lStrLnkTID,
		pStrShortTitle,
		pStrLongTitle,
		pStrAttrType,
		pStrAttrPattern,
		pStrAttrDefaultValue,
		pStrComment,
		CURRENT_USER
	);

END$$

DELIMITER ;

-- -------------------------------------------------------------------------- --
-- From Source file : SQL-TRIG-01.01-ALLCORE_TRIGGERS.sql
-- -------------------------------------------------------------------------- --


USE `COREDEV01`;

DELIMITER $$

USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_CORE_TYPEOBJECTS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_CORE_TYPEOBJECTS BEFORE INSERT ON CORE_TYPEOBJECTS FOR EACH ROW
BEGIN

	DECLARE lStrNewTID VARCHAR(30);
  DECLARE lIntNbRows LONG;

  SELECT count(*) INTO lIntNbRows FROM CORE_TYPEOBJECTS;
  SET lStrNewTID = CONCAT('TYOBJ','-',LPAD(CONVERT(lIntNbRows+1,CHAR),24,'0'));

	SET NEW.tid = lStrNewTID;
  SET NEW.bid = lStrNewTID;
	SET NEW.cuser = CURRENT_USER;
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_CORE_TYPEOBJECTS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_CORE_TYPEOBJECTS AFTER INSERT ON CORE_TYPEOBJECTS FOR EACH ROW
BEGIN
	  CALL LOGS_LogDataEvent_Insert(NEW.tid);
    CALL CORE_RegisterNewTID(NEW.tid,'CORE_TYPEOBJECTS');
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_CORE_TYPEOBJECTS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_CORE_TYPEOBJECTS BEFORE UPDATE ON CORE_TYPEOBJECTS FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_CORE_TYPEOBJECTS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_CORE_TYPEOBJECTS AFTER UPDATE ON CORE_TYPEOBJECTS FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Update(NEW.tid);
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_CORE_TYPELINKS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_CORE_TYPELINKS BEFORE INSERT ON CORE_TYPELINKS FOR EACH ROW
BEGIN
	DECLARE lStrTID VARCHAR(30);
	DECLARE lStrObjPrefix VARCHAR(5);
	DECLARE lStrObjSrcPrefix VARCHAR(5);
	DECLARE lStrObjDstPrefix VARCHAR(5);
	DECLARE lStrNewBID VARCHAR(50);

  SELECT CORE_GenNewTIDForTable('CORE_TYPELINKS') INTO lStrTID;

	SELECT obj_prefix INTO lStrObjPrefix
	FROM CORE_TYPEOBJECTS WHERE obj_tablename = 'CORE_TYPELINKS';

	SELECT obj_prefix INTO lStrObjSrcPrefix
	FROM CORE_TYPEOBJECTS WHERE tid = NEW.typobj_src;

	SELECT obj_prefix INTO lStrObjDstPrefix
	FROM CORE_TYPEOBJECTS WHERE tid = NEW.typobj_dst;

	SET NEW.bid = CONCAT(lStrObjPrefix,'-',lStrObjSrcPrefix,'_',lStrObjDstPrefix);
	SET NEW.tid = lStrTID;
  SET NEW.cuser = CURRENT_USER;
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_CORE_TYPELINKS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_CORE_TYPELINKS AFTER INSERT ON CORE_TYPELINKS FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Insert(NEW.tid);
    CALL CORE_RegisterNewTID(NEW.tid,'CORE_TYPELINKS');
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_CORE_TYPELINKS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_CORE_TYPELINKS BEFORE UPDATE ON CORE_TYPELINKS FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_CORE_TYPELINKS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_CORE_TYPELINKS AFTER UPDATE ON CORE_TYPELINKS FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Update(NEW.tid);
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_CORE_ATTRDEFS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_CORE_ATTRDEFS BEFORE INSERT ON CORE_ATTRDEFS FOR EACH ROW
BEGIN
	DECLARE lStrTID VARCHAR(30);
  SELECT CORE_GenNewTIDForTable('CORE_ATTRDEFS') INTO lStrTID;

	IF NEW.bid IS NULL THEN
  	SET NEW.bid = lStrTID;
	END IF;
	SET NEW.tid = lStrTID;
  SET NEW.cuser = CURRENT_USER;
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_CORE_ATTRDEFS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_CORE_ATTRDEFS AFTER INSERT ON CORE_ATTRDEFS FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Insert(NEW.tid);
    CALL CORE_RegisterNewTID(NEW.tid,'CORE_ATTRDEFS');
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_CORE_ATTRDEFS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_CORE_ATTRDEFS BEFORE UPDATE ON `CORE_ATTRDEFS` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_CORE_ATTRDEFS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_CORE_ATTRDEFS AFTER UPDATE ON `CORE_ATTRDEFS` FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Update(NEW.tid);
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_CORE_ATTROBJECTS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_CORE_ATTROBJECTS BEFORE INSERT ON `CORE_ATTROBJECTS` FOR EACH ROW
BEGIN
	DECLARE lStrTID VARCHAR(30);
  SELECT CORE_GenNewTIDForTable('CORE_ATTROBJECTS') INTO lStrTID;

	SET NEW.tid = lStrTID;
	IF NEW.bid IS NULL THEN
  	SET NEW.bid = lStrTID;
	END IF;
  SET NEW.cuser = CURRENT_USER;
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_CORE_ATTROBJECTS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_CORE_ATTROBJECTS AFTER INSERT ON `CORE_ATTROBJECTS` FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Insert(NEW.tid);
    CALL CORE_RegisterNewTID(NEW.tid,'CORE_ATTROBJECTS');
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_CORE_ATTROBJECTS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_CORE_ATTROBJECTS BEFORE UPDATE ON `CORE_ATTROBJECTS` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_CORE_ATTROBJECTS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_CORE_ATTROBJECTS AFTER UPDATE ON `CORE_ATTROBJECTS` FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Update(NEW.tid);
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_CORE_LOGS_DATAEVTS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_CORE_LOGS_DATAEVTS BEFORE INSERT ON CORE_LOGS_DATAEVTS FOR EACH ROW
BEGIN

	DECLARE lIntNbLogs BIGINT;
	SELECT COUNT(tid) INTO lIntNbLogs FROM CORE_LOGS_DATAEVTS WHERE YEAR(ctime) = YEAR(NOW());
	SET NEW.tid = CONCAT('LDEVT-',CONVERT(YEAR(NOW()),CHAR),'-',LPAD(CONVERT(lIntNbLogs+1,CHAR),19,'0'));
	SET NEW.cuser = CURRENT_USER;
END$$

USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_CORE_LINKS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_CORE_LINKS BEFORE INSERT ON CORE_LINKS FOR EACH ROW
BEGIN
	DECLARE lStrNewTID VARCHAR(30);
  SELECT CORE_GenNewTIDForTable('CORE_LINKS') INTO lStrNewTID ;
	SET NEW.tid = lStrNewTID;
	IF NEW.bid IS NULL THEN
  	SET NEW.bid = lStrNewTID;
	END IF;
	SET NEW.CUSER = CURRENT_USER;
END$$

USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_CORE_LINKS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_CORE_LINKS AFTER INSERT ON CORE_LINKS FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Insert(NEW.tid);
  CALL CORE_RegisterNewTID(NEW.tid,'CORE_LINKS');
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_CORE_LINKS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_CORE_LINKS BEFORE UPDATE ON CORE_LINKS FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
  SET NEW.utime = NOW();
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_CORE_LINKS` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_CORE_LINKS AFTER UPDATE ON CORE_LINKS FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Update(NEW.tid);
END$$


























DELIMITER ;

-- -------------------------------------------------------------------------- --
-- From Source file : SQL-INSERT-01.00-USERS_ACCOUNTS.sql
-- -------------------------------------------------------------------------- --

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `CORE_TYPEOBJECTS`
-- -----------------------------------------------------
START TRANSACTION;
USE `COREDEV01`;
INSERT INTO `CORE_USER_ACCOUNTS` (`tid`, `firstname`, `lastname`, `comment`, `ctime`, `isActive`, `isSystem`) VALUES ('polux@%', 'polux', 'DEV', 'Main development account.', DEFAULT, 1, 0);

COMMIT;

-- -------------------------------------------------------------------------- --
-- From Source file : SQL-INSERT-01.01-TYPEOBJECTS.sql
-- -------------------------------------------------------------------------- --

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `CORE_TYPEOBJECTS`
-- -----------------------------------------------------
START TRANSACTION;
USE `COREDEV01`;
INSERT INTO `CORE_TYPEOBJECTS` (
  `stitle`,
  `ltitle`,
  `comment`,
  `obj_type`,
  `obj_prefix`,
  `obj_tablename`,
  `isSystem`)
VALUES (
    'Object\'s types',
    'All Types of Objects',
    'Internal referentials about Type Of Objects - This Table.',
    'System',
    'TYOBJ',
    'CORE_TYPEOBJECTS',
    1);

INSERT INTO `CORE_TYPEOBJECTS` (
      `stitle`,
      `ltitle`,
      `comment`,
      `obj_type`,
      `obj_prefix`,
      `obj_tablename`,
      `isSystem`)
VALUES (
  'Links\' types',
  'All Types of Links between Objects',
  'Internal referentials about links types between two type of Object.',
  'System',
  'TYLNK',
  'CORE_TYPELINKS',
   1);

INSERT INTO `CORE_TYPEOBJECTS` (
         `stitle`,
         `ltitle`,
         `comment`,
         `obj_type`,
         `obj_prefix`,
         `obj_tablename`,
         `isSystem`)
   VALUES (
'Attributes\' definition', 'All defintion of Attributes.', 'Internal referentials about attributes defined by type of Links or type of Object.', 'System', 'ATDEF', 'CORE_ATTRDEFS', 1);

INSERT INTO `CORE_TYPEOBJECTS` (
      `stitle`,
      `ltitle`,
      `comment`,
      `obj_type`,
      `obj_prefix`,
      `obj_tablename`,
      `isSystem`)
VALUES (
 'Attributes\' values', 'All values of attributes', 'Internal referential about attributes values defined on Object or Link.', 'System', 'ATVAL', 'CORE_ATTROBJECTS',  1);

 INSERT INTO `CORE_TYPEOBJECTS` (
       `stitle`,
       `ltitle`,
       `comment`,
       `obj_type`,
       `obj_prefix`,
       `obj_tablename`,
       `isSystem`)
 VALUES (
  'Links', 'All links between objects', 'Internal referential about links between two Objects.', 'System', 'LNK', 'CORE_LINKS',  1);

COMMIT;
