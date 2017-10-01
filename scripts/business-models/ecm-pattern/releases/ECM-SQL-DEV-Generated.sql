-- -----------------------------------------------------
-- Table `ECM_DOCUMENT`
-- -----------------------------------------------------
USE `COREDEV01`;
DROP TABLE IF EXISTS `ECM_DOCUMENT` ;

CREATE TABLE IF NOT EXISTS `ECM_DOCUMENT` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `bid` VARCHAR(50) UNIQUE NOT NULL DEFAULT 'BID-NOTDEF',
  `version` INT NOT NULL DEFAULT 0,
  `revision` INT NOT NULL DEFAULT 0,
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Short Title not defined',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Long Title not defined',
  `comment` TEXT NULL DEFAULT NULL,
  `cuser` VARCHAR(100) NOT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_DOC_USER_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DOC_USER_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Document ECM';

CREATE UNIQUE INDEX `UQ_BID-VER-REV` ON `ECM_DOCUMENT` (`bid` ASC, `version` ASC, `revision` ASC);
CREATE INDEX `FK_DOC_USER_CUSER_idx` ON `ECM_DOCUMENT` (`cuser` ASC);
CREATE INDEX `FK_DOC_USER_UUSER_idx` ON `ECM_DOCUMENT` (`uuser` ASC);

-- -----------------------------------------------------------------------------
-- TRIGGERS
-- -----------------------------------------------------------------------------
DELIMITER $$

USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_ECM_DOCUMENT` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_ECM_DOCUMENT BEFORE INSERT ON ECM_DOCUMENT FOR EACH ROW
BEGIN

	DECLARE lStrNewTID VARCHAR(30);
  SELECT CORE_GenNewTIDForTable('ECM_DOCUMENT') INTO lStrNewTID ;
	SET NEW.tid = lStrNewTID;
  SET NEW.bid = lStrNewTID;
	SET NEW.CUSER = CURRENT_USER;
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_ECM_DOCUMENT` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_ECM_DOCUMENT AFTER INSERT ON ECM_DOCUMENT FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Insert(NEW.tid);
    CALL CORE_RegisterNewTID(NEW.tid,'ECM_DOCUMENT');
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_ECM_DOCUMENT` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_ECM_DOCUMENT BEFORE UPDATE ON ECM_DOCUMENT FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_ECM_DOCUMENT` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_ECM_DOCUMENT AFTER UPDATE ON ECM_DOCUMENT FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Update(NEW.tid);
END$$

DELIMITER ;

-- -----------------------------------------------------------------------------
-- TODO reviseComplexObject & versionObject
-- -----------------------------------------------------------------------------

-- -----------------------------------------------------------------------------
-- Intégration à la configuration du CORE
-- -----------------------------------------------------------------------------
INSERT INTO `CORE_TYPEOBJECTS` (
 `stitle`,
 `ltitle`,
 `comment`,
 `obj_type`,
 `obj_prefix`,
 `obj_tablename`,
 `isSystem`)
VALUES (
 'Document',
 'Document ECM',
 'Document ECM',
 'Complex',
 'DOC',
 'ECM_DOCUMENT',
 0);
-- -----------------------------------------------------
-- Table `ECM_CATEGORIE`
-- -----------------------------------------------------
USE `COREDEV01`;
DROP TABLE IF EXISTS `ECM_CATEGORIE` ;

CREATE TABLE IF NOT EXISTS `ECM_CATEGORIE` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `bid` VARCHAR(50) UNIQUE NOT NULL DEFAULT 'BID-NOTDEF',
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Short Title not defined',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Long Title not defined',
  `comment` TEXT NULL DEFAULT NULL,
  `cuser` VARCHAR(100) NOT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_CAT_USER_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_CAT_USER_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Categorie de regroupement de document.';

CREATE UNIQUE INDEX `UQ_BID` ON `ECM_CATEGORIE` (`bid` ASC);
CREATE INDEX `FK_CAT_USER_CUSER_idx` ON `ECM_CATEGORIE` (`cuser` ASC);
CREATE INDEX `FK_CAT_USER_UUSER_idx` ON `ECM_CATEGORIE` (`uuser` ASC);

-- -----------------------------------------------------------------------------
-- TRIGGERS
-- -----------------------------------------------------------------------------
DELIMITER $$

USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_ECM_CATEGORIE` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_ECM_CATEGORIE BEFORE INSERT ON ECM_CATEGORIE FOR EACH ROW
BEGIN

	DECLARE lStrNewTID VARCHAR(30);

  SELECT CORE_GenNewTIDForTable('ECM_CATEGORIE') INTO lStrNewTID ;
	SET NEW.tid = lStrNewTID;
  SET NEW.bid = lStrNewTID;
	SET NEW.CUSER = CURRENT_USER;

END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_ECM_CATEGORIE` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_ECM_CATEGORIE AFTER INSERT ON ECM_CATEGORIE FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Insert(NEW.tid);
  CALL CORE_RegisterNewTID(NEW.tid,'ECM_CATEGORIE');
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_ECM_CATEGORIE` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_ECM_CATEGORIE BEFORE UPDATE ON ECM_CATEGORIE FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
  SET NEW.utime = NOW();
END$$

USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_ECM_CATEGORIE` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_ECM_CATEGORIE AFTER UPDATE ON ECM_CATEGORIE FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Update(NEW.tid);
END$$

DELIMITER ;

-- -----------------------------------------------------------------------------
-- Ajout de la definition de l'objet aux tables du CORE
-- -----------------------------------------------------------------------------
INSERT INTO `COREDEV01`.`CORE_TYPEOBJECTS`(
  `stitle`,
  `ltitle`,
  `comment`,
  `obj_prefix`,
  `obj_tablename`,
  `obj_type`
) VALUES (
  'Categorie',
  'Categorie de regroupement de document.',
  'Categorie de regroupement de document.',
  'CAT',
  'ECM_CATEGORIE',
  'Simple'
);
-- -----------------------------------------------------
-- Table `ECM_TIER`
-- -----------------------------------------------------
USE `COREDEV01`;
DROP TABLE IF EXISTS `ECM_TIER` ;

CREATE TABLE IF NOT EXISTS `ECM_TIER` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `bid` VARCHAR(50) UNIQUE NOT NULL DEFAULT 'BID-NOTDEF',
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Short Title not defined',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Long Title not defined',
  `comment` TEXT NULL DEFAULT NULL,
  `cuser` VARCHAR(100) NOT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_TIE_USER_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TIE_USER_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tier divers.';

CREATE UNIQUE INDEX `UQ_BID` ON `ECM_TIER` (`bid` ASC);
CREATE INDEX `FK_TIE_USER_CUSER_idx` ON `ECM_TIER` (`cuser` ASC);
CREATE INDEX `FK_TIE_USER_UUSER_idx` ON `ECM_TIER` (`uuser` ASC);

-- -----------------------------------------------------------------------------
-- TRIGGERS
-- -----------------------------------------------------------------------------
DELIMITER $$

USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_ECM_TIER` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_ECM_TIER BEFORE INSERT ON ECM_TIER FOR EACH ROW
BEGIN

	DECLARE lStrNewTID VARCHAR(30);

  SELECT CORE_GenNewTIDForTable('ECM_TIER') INTO lStrNewTID ;
	SET NEW.tid = lStrNewTID;
  SET NEW.bid = lStrNewTID;
	SET NEW.CUSER = CURRENT_USER;

END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_ECM_TIER` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_ECM_TIER AFTER INSERT ON ECM_TIER FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Insert(NEW.tid);
  CALL CORE_RegisterNewTID(NEW.tid,'ECM_TIER');
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_ECM_TIER` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_ECM_TIER BEFORE UPDATE ON ECM_TIER FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
  SET NEW.utime = NOW();
END$$

USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_ECM_TIER` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_ECM_TIER AFTER UPDATE ON ECM_TIER FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Update(NEW.tid);
END$$

DELIMITER ;

-- -----------------------------------------------------------------------------
-- Ajout de la definition de l'objet aux tables du CORE
-- -----------------------------------------------------------------------------
INSERT INTO `COREDEV01`.`CORE_TYPEOBJECTS`(
  `stitle`,
  `ltitle`,
  `comment`,
  `obj_prefix`,
  `obj_tablename`,
  `obj_type`
) VALUES (
  'Tier',
  'Tier divers.',
  'Tier divers.',
  'TIE',
  'ECM_TIER',
  'Simple'
);
-- -----------------------------------------------------
-- Table `ECM_FICHIER`
-- -----------------------------------------------------
USE `COREDEV01`;
DROP TABLE IF EXISTS `ECM_FICHIER` ;

CREATE TABLE IF NOT EXISTS `ECM_FICHIER` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `bid` VARCHAR(50) UNIQUE NOT NULL DEFAULT 'BID-NOTDEF',
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Short Title not defined',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Long Title not defined',
  `comment` TEXT NULL DEFAULT NULL,
  `cuser` VARCHAR(100) NOT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_FIC_USER_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_FIC_USER_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Fichier physique';

CREATE UNIQUE INDEX `UQ_BID` ON `ECM_FICHIER` (`bid` ASC);
CREATE INDEX `FK_FIC_USER_CUSER_idx` ON `ECM_FICHIER` (`cuser` ASC);
CREATE INDEX `FK_FIC_USER_UUSER_idx` ON `ECM_FICHIER` (`uuser` ASC);

-- -----------------------------------------------------------------------------
-- TRIGGERS
-- -----------------------------------------------------------------------------
DELIMITER $$

USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_ECM_FICHIER` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_ECM_FICHIER BEFORE INSERT ON ECM_FICHIER FOR EACH ROW
BEGIN

	DECLARE lStrNewTID VARCHAR(30);

  SELECT CORE_GenNewTIDForTable('ECM_FICHIER') INTO lStrNewTID ;
	SET NEW.tid = lStrNewTID;
  SET NEW.bid = lStrNewTID;
	SET NEW.CUSER = CURRENT_USER;

END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_ECM_FICHIER` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_ECM_FICHIER AFTER INSERT ON ECM_FICHIER FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Insert(NEW.tid);
  CALL CORE_RegisterNewTID(NEW.tid,'ECM_FICHIER');
END$$


USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_ECM_FICHIER` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_ECM_FICHIER BEFORE UPDATE ON ECM_FICHIER FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
  SET NEW.utime = NOW();
END$$

USE `COREDEV01`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_ECM_FICHIER` $$
USE `COREDEV01`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_ECM_FICHIER AFTER UPDATE ON ECM_FICHIER FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Update(NEW.tid);
END$$

DELIMITER ;

-- -----------------------------------------------------------------------------
-- Ajout de la definition de l'objet aux tables du CORE
-- -----------------------------------------------------------------------------
INSERT INTO `COREDEV01`.`CORE_TYPEOBJECTS`(
  `stitle`,
  `ltitle`,
  `comment`,
  `obj_prefix`,
  `obj_tablename`,
  `obj_type`
) VALUES (
  'Fichier',
  'Fichier Physique',
  'Fichier physique',
  'FIC',
  'ECM_FICHIER',
  'Simple'
);
-- -----------------------------------------------------
-- Add Link type 'Document vers Tiers'
-- -----------------------------------------------------
CALL CORE_addTypeLinkFromTableName('Document vers Tiers','Lien logique dun document vers des tiers.','Lien logique dun document vers des tiers.','ECM_DOCUMENT','ECM_TIER');
-- -----------------------------------------------------
-- Add Link type 'Document vers Fichier'
-- -----------------------------------------------------
CALL CORE_addTypeLinkFromTableName('Document vers Fichier','Lien logique dun doc vers un fichier.','Lien logique dun doc vers un fichier.','ECM_DOCUMENT','ECM_FICHIER');
-- -----------------------------------------------------
-- Add Link type 'Document vers Categorie'
-- -----------------------------------------------------
CALL CORE_addTypeLinkFromTableName('Document vers Categorie','Lien doc vers cat','Lien doc vers cat','ECM_DOCUMENT','ECM_CATEGORIE');
-- -----------------------------------------------------
-- Add Link type 'Mois'
-- -----------------------------------------------------
CALL CORE_addAttributeDefinitionForAnObject('ECM_DOCUMENT','Mois','Mois du document.','Mois du document','INTEGER','','01');
-- -----------------------------------------------------
-- Add Link type 'Annee'
-- -----------------------------------------------------
CALL CORE_addAttributeDefinitionForAnObject('ECM_DOCUMENT','Annee','Annee du Document','Annee du Document','INTEGER','','2017');
-- -----------------------------------------------------
-- Add Link type 'Jour'
-- -----------------------------------------------------
CALL CORE_addAttributeDefinitionForAnObject('ECM_DOCUMENT','Jour','Jour du Document','Jour du Document','INTEGER','','01');
-- -----------------------------------------------------
-- Add Link type 'Fichier'
-- -----------------------------------------------------
CALL CORE_addAttributeDefinitionForAnObject('ECM_FICHIER','Fichier','Fichier source','Fichier source','FILE','','');
