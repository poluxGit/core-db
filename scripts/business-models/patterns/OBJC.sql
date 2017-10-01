-- -----------------------------------------------------
-- Table `DEFAULT_COMPLEX_OBJTABLE`
-- -----------------------------------------------------
USE `TARGET_SCHEMA`;
DROP TABLE IF EXISTS `DEFAULT_COMPLEX_OBJTABLE` ;

CREATE TABLE IF NOT EXISTS `DEFAULT_COMPLEX_OBJTABLE` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `bid` VARCHAR(50) NULL DEFAULT NULL,
  `version` INT NOT NULL DEFAULT 0,
  `revision` INT NOT NULL DEFAULT 0,
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Short Title not defined',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Long Title not defined',
  `comment` TEXT NULL DEFAULT NULL,
  `cuser` VARCHAR(100) DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_DEFCOMPOBJ_USER_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DEFCOMPOBJ_USER_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'DEFAULT_COMPLEX_OBJECT_COMMENT';

CREATE UNIQUE INDEX `UQ_BID-VER-REV` ON `DEFAULT_COMPLEX_OBJTABLE` (`bid` ASC, `version` ASC, `revision` ASC);
CREATE INDEX `FK_DEFCOMPOBJ_USER_CUSER_idx` ON `DEFAULT_COMPLEX_OBJTABLE` (`cuser` ASC);
CREATE INDEX `FK_DEFCOMPOBJ_USER_UUSER_idx` ON `DEFAULT_COMPLEX_OBJTABLE` (`uuser` ASC);

-- -----------------------------------------------------------------------------
-- TRIGGERS
-- -----------------------------------------------------------------------------
DELIMITER $$

USE `TARGET_SCHEMA`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_DEFAULT_COMPLEX_OBJTABLE` $$
USE `TARGET_SCHEMA`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_DEFAULT_COMPLEX_OBJTABLE BEFORE INSERT ON DEFAULT_COMPLEX_OBJTABLE FOR EACH ROW
BEGIN

	DECLARE lStrNewTID VARCHAR(30);
  SELECT CORE_GenNewTIDForTable('DEFAULT_COMPLEX_OBJTABLE') INTO lStrNewTID ;
	SET NEW.tid = lStrNewTID;
  IF NEW.bid IS NULL THEN
    SET NEW.bid = lStrNewTID;
  END IF;
	SET NEW.CUSER = CURRENT_USER;
END$$


USE `TARGET_SCHEMA`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_DEFAULT_COMPLEX_OBJTABLE` $$
USE `TARGET_SCHEMA`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_DEFAULT_COMPLEX_OBJTABLE AFTER INSERT ON DEFAULT_COMPLEX_OBJTABLE FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Insert(NEW.tid);
    CALL CORE_RegisterNewTID(NEW.tid,'DEFAULT_COMPLEX_OBJTABLE');
END$$


USE `TARGET_SCHEMA`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_DEFAULT_COMPLEX_OBJTABLE` $$
USE `TARGET_SCHEMA`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_DEFAULT_COMPLEX_OBJTABLE BEFORE UPDATE ON DEFAULT_COMPLEX_OBJTABLE FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `TARGET_SCHEMA`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_DEFAULT_COMPLEX_OBJTABLE` $$
USE `TARGET_SCHEMA`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_DEFAULT_COMPLEX_OBJTABLE AFTER UPDATE ON DEFAULT_COMPLEX_OBJTABLE FOR EACH ROW
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
 'DEFAULT_COMPLEX_OBJECT_STITLE',
 'DEFAULT_COMPLEX_OBJECT_LTITLE',
 'DEFAULT_COMPLEX_OBJECT_COMMENT',
 'Complex',
 'DEFAULT_COMPLEX_OBJECT_SIGLE',
 'DEFAULT_COMPLEX_OBJTABLE',
 0);


 -- -----------------------------------------------------
 -- createObject
 --
 -- procedure DBPREFIX_createOBJECT_NAME
 -- -----------------------------------------------------
 USE `TARGET_SCHEMA`;
 DROP FUNCTION IF EXISTS `DBPREFIX_createOBJECT_NAME_UCFObject`;

 DELIMITER $$
 USE `TARGET_SCHEMA`$$
 CREATE FUNCTION DBPREFIX_createOBJECT_NAME_UCFObject (pStrShortTitle VARCHAR(30),pStrLongTitle VARCHAR(100),pStrComment TEXT) RETURNS VARCHAR(30)
 BEGIN

 	DECLARE lStrBID VARCHAR(50);
  DECLARE lStrTID VARCHAR(30);
  DECLARE lStrTypeObjectTID VARCHAR(30);
  DECLARE lStrObjSrcPrefix VARCHAR(5);
  DECLARE lLongUniqueBID INTEGER;

 	SELECT obj_prefix,tid INTO lStrObjSrcPrefix,lStrTypeObjectTID
 	FROM CORE_TYPEOBJECTS WHERE obj_tablename = 'DEFAULT_COMPLEX_OBJTABLE';

  SELECT COUNT(TID) INTO lLongUniqueBID
  FROM DEFAULT_COMPLEX_OBJTABLE;

  IF lLongUniqueBID <> 0 THEN
    SELECT COUNT(bid) INTO lLongUniqueBID
    FROM DEFAULT_COMPLEX_OBJTABLE GROUP BY bid;
  END IF;

  SET lStrBID = CONCAT(lStrObjSrcPrefix,'-',LPAD(CONVERT(lLongUniqueBID+1,CHAR),10,'0'));

 	INSERT INTO `DEFAULT_COMPLEX_OBJTABLE`
 	(
    `bid`,
    `stitle`,
    `ltitle`,
    `comment`
  )
 	VALUES
 	(
 		lStrBID,
 		pStrShortTitle,
 		pStrLongTitle,
 		pStrComment
 	);

  SELECT MAX(tid) INTO lStrTID FROM DEFAULT_COMPLEX_OBJTABLE WHERE bid=lStrBID;

  -- Attribute instanciation
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
    lStrTID,
    `tid`,
    `attr_default_value`,
    `comment`
  FROM `CORE_ATTRDEFS`
  WHERE `tobj_tid` = lStrTypeObjectTID;

  RETURN lStrTID;

 END$$

 DELIMITER ;


 -- -----------------------------------------------------
 -- getLastVersion
 --
 -- procedure DBPREFIX_getLastVersionOnOBJECT_NAME_UCF
 -- -----------------------------------------------------
 USE `TARGET_SCHEMA`;
 DROP FUNCTION IF EXISTS `DBPREFIX_getLastVersionOnOBJECT_NAME_UCF`;

 DELIMITER $$
 USE `TARGET_SCHEMA`$$
 CREATE FUNCTION DBPREFIX_getLastVersionOnOBJECT_NAME_UCF (pStrBidObject VARCHAR(50)) RETURNS INTEGER
 BEGIN

  DECLARE lIntCurrentVersion INTEGER;

  SELECT MAX(version) INTO lIntCurrentVersion FROM DEFAULT_COMPLEX_OBJTABLE WHERE bid = pStrBidObject;
  RETURN lIntCurrentVersion;

 END$$

 DELIMITER ;

 -- -----------------------------------------------------
 -- getLastRevision
 --
 -- procedure DBPREFIX_getLastRevisionOnOBJECT_NAME_UCF
 -- -----------------------------------------------------
 USE `TARGET_SCHEMA`;
 DROP FUNCTION IF EXISTS `DBPREFIX_getLastRevisionOnOBJECT_NAME_UCF`;

 DELIMITER $$
 USE `TARGET_SCHEMA`$$
 CREATE FUNCTION DBPREFIX_getLastRevisionOnOBJECT_NAME_UCF (pStrBidObject VARCHAR(50)) RETURNS INTEGER
 BEGIN

  DECLARE lIntCurrentRevision INTEGER;

  SELECT MAX(revision) INTO lIntCurrentRevision FROM DEFAULT_COMPLEX_OBJTABLE WHERE bid = pStrBidObject and version=DBPREFIX_getLastVersionOnOBJECT_NAME_UCF(pStrBidObject);
  RETURN lIntCurrentRevision;

 END$$

 DELIMITER ;

 -- -----------------------------------------------------
 -- incrementVersion
 --
 -- procedure DBPREFIX_incrementVersionOnOBJECT_NAME_UCFObject
 -- -----------------------------------------------------
 USE `TARGET_SCHEMA`;
 DROP FUNCTION IF EXISTS `DBPREFIX_incrementVersionOnOBJECT_NAME_UCFObject`;

 DELIMITER $$
 USE `TARGET_SCHEMA`$$
 CREATE FUNCTION DBPREFIX_incrementVersionOnOBJECT_NAME_UCFObject (pStrBidObject VARCHAR(50)) RETURNS VARCHAR(30)
 BEGIN

   DECLARE lIntCurrentVersion INTEGER;
   DECLARE lStrTID VARCHAR(30);
   DECLARE lStrPrevTID VARCHAR(30);

   SELECT DBPREFIX_getLastVersionOnOBJECT_NAME_UCF(pStrBidObject) INTO lIntCurrentVersion;

   SELECT tid INTO lStrPrevTID
   FROM DEFAULT_COMPLEX_OBJTABLE
   WHERE
     bid=pStrBidObject
     AND version = DBPREFIX_getLastVersionOnOBJECT_NAME_UCF(pStrBidObject)
     AND revision = DBPREFIX_getLastRevisionOnOBJECT_NAME_UCF(pStrBidObject);

   INSERT INTO `DEFAULT_COMPLEX_OBJTABLE`
   (
    `bid`,
    `version`,
    `stitle`,
    `ltitle`,
    `comment`
  )
  SELECT pStrBidObject, lIntCurrentVersion+1, stitle,ltitle,comment
  FROM DEFAULT_COMPLEX_OBJTABLE
  WHERE
    bid=pStrBidObject
    AND version = DBPREFIX_getLastVersionOnOBJECT_NAME_UCF(pStrBidObject)
    AND revision = DBPREFIX_getLastRevisionOnOBJECT_NAME_UCF(pStrBidObject);

  SELECT tid INTO lStrTID
  FROM DEFAULT_COMPLEX_OBJTABLE
  WHERE
    bid=pStrBidObject
    AND version = DBPREFIX_getLastVersionOnOBJECT_NAME_UCF(pStrBidObject)
    AND revision = DBPREFIX_getLastRevisionOnOBJECT_NAME_UCF(pStrBidObject);

  CALL DBPREFIX_duplicateAttributesOnOBJECT_NAME_UCFObject(lStrPrevTID,lStrTID);
  CALL DBPREFIX_duplicateLinksOnOBJECT_NAME_UCFObject(lStrPrevTID,lStrTID);

  RETURN lStrTID;

 END$$

 DELIMITER ;


 -- -----------------------------------------------------
 -- incrementRevision
 --
 -- procedure DBPREFIX_incrementRevisionOnOBJECT_NAME_UCFObject
 -- -----------------------------------------------------
 USE `TARGET_SCHEMA`;
 DROP FUNCTION IF EXISTS `DBPREFIX_incrementRevisionOnOBJECT_NAME_UCFObject`;

 DELIMITER $$
 USE `TARGET_SCHEMA`$$
 CREATE FUNCTION DBPREFIX_incrementRevisionOnOBJECT_NAME_UCFObject(pStrBidObject VARCHAR(50)) RETURNS VARCHAR(30)
 BEGIN

   DECLARE lIntCurrentRevision INTEGER;
   DECLARE lStrTID VARCHAR(30);
   DECLARE lStrPrevTID VARCHAR(30);

   SELECT DBPREFIX_getLastRevisionOnOBJECT_NAME_UCF(pStrBidObject) INTO lIntCurrentRevision;

   SELECT tid INTO lStrPrevTID
   FROM DEFAULT_COMPLEX_OBJTABLE
   WHERE
     bid=pStrBidObject
     AND version = DBPREFIX_getLastVersionOnOBJECT_NAME_UCF(pStrBidObject)
     AND revision = DBPREFIX_getLastRevisionOnOBJECT_NAME_UCF(pStrBidObject);



   INSERT INTO `DEFAULT_COMPLEX_OBJTABLE`
   (
    `bid`,
    `version`,
    `revision`,
    `stitle`,
    `ltitle`,
    `comment`
  )
  SELECT pStrBidObject, version,lIntCurrentRevision+1, stitle,ltitle,comment
  FROM DEFAULT_COMPLEX_OBJTABLE
  WHERE
    bid=pStrBidObject
    AND version = DBPREFIX_getLastVersionOnOBJECT_NAME_UCF(pStrBidObject)
    AND revision = DBPREFIX_getLastRevisionOnOBJECT_NAME_UCF(pStrBidObject);

  SELECT tid INTO lStrTID
  FROM DEFAULT_COMPLEX_OBJTABLE
  WHERE
    bid=pStrBidObject
    AND version = DBPREFIX_getLastVersionOnOBJECT_NAME_UCF(pStrBidObject)
    AND revision = DBPREFIX_getLastRevisionOnOBJECT_NAME_UCF(pStrBidObject);

  CALL DBPREFIX_duplicateAttributesOnOBJECT_NAME_UCFObject(lStrPrevTID,lStrTID);
  CALL DBPREFIX_duplicateLinksOnOBJECT_NAME_UCFObject(lStrPrevTID,lStrTID);

  RETURN lStrTID;

 END$$

 DELIMITER ;

 -- -----------------------------------------------------
 -- duplicateAttributes
 --
 -- procedure DBPREFIX_duplicateAttributesOnOBJECT_NAME_UCFObject
 -- -----------------------------------------------------
 USE `TARGET_SCHEMA`;
 DROP PROCEDURE IF EXISTS `DBPREFIX_duplicateAttributesOnOBJECT_NAME_UCFObject`;

 DELIMITER $$
 USE `TARGET_SCHEMA`$$
 CREATE PROCEDURE DBPREFIX_duplicateAttributesOnOBJECT_NAME_UCFObject(IN pStrTIDSrc VARCHAR(30),IN pStrTIDDst VARCHAR(30))
 BEGIN

   INSERT INTO `CORE_ATTROBJECTS`
   (
    `bid`,
    `stitle`,
    `ltitle`,
    `obj_tid`,
    `adef_tid`,
    `attr_value`,
    `comment`
  )
  SELECT
    `bid`,
    `stitle`,
    `ltitle`,
    pStrTIDDst,
    `adef_tid`,
    `attr_value`,
    `comment`
  FROM `CORE_ATTROBJECTS`
  WHERE obj_tid=pStrTIDSrc;

 END$$

 DELIMITER ;

 -- -----------------------------------------------------
 -- duplicatLinks
 --
 -- procedure DBPREFIX_duplicateLinksOnOBJECT_NAME_UCFObject
 -- -----------------------------------------------------
 USE `TARGET_SCHEMA`;
 DROP PROCEDURE IF EXISTS `DBPREFIX_duplicateLinksOnOBJECT_NAME_UCFObject`;

 DELIMITER $$
 USE `TARGET_SCHEMA`$$
 CREATE PROCEDURE DBPREFIX_duplicateLinksOnOBJECT_NAME_UCFObject(IN pStrTIDSrc VARCHAR(30),IN pStrTIDDst VARCHAR(30))
 BEGIN

-- Links where
 INSERT INTO `CORE_LINKS`
 (
   `bid`,
   `tlnk_tid`,
   `objsrc`,
   `objdst`
 )
 SELECT
   `bid`,
   `tlnk_tid`,
   pStrTIDDst,
   `objdst`
  FROM `CORE_LINKS`
  WHERE objsrc=pStrTIDSrc;

 END$$

 DELIMITER ;
