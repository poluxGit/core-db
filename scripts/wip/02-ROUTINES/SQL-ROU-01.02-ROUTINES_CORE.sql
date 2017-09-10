
-- -----------------------------------------------------
-- function CORE_GetTablenameFromObjectTypeTID
-- -----------------------------------------------------

USE `TARGET_SCHEMA`;
DROP function IF EXISTS `CORE_GetTablenameFromObjectTypeTID`;

DELIMITER $$
USE `TARGET_SCHEMA`$$
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
-- function CORE_GetTablenameFromObjectType
-- -----------------------------------------------------

USE `TARGET_SCHEMA`;
DROP function IF EXISTS `CORE_GetTablenameFromObjectType`;

DELIMITER $$
USE `TARGET_SCHEMA`$$
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

USE `TARGET_SCHEMA`;
DROP function IF EXISTS `CORE_GenNewTIDForTable`;

DELIMITER $$
USE `TARGET_SCHEMA`$$
CREATE FUNCTION CORE_GenNewTIDForTable (pStrTableName VARCHAR(150)) RETURNS VARCHAR(30)
BEGIN
	DECLARE lStrPrefixObject VARCHAR(5);
    DECLARE lStrNewTID VARCHAR(30);
    DECLARE lIntNbRows LONG;

    -- tid, bid, stitle, ltitle, comment, obj_type, obj_prefix, obj_tablename, cuser, ctime, uuser, utime, isActive, obj_type
    SELECT obj_prefix INTO lStrPrefixObject
    FROM CORE_TYPEOBJECTS WHERE obj_tablename = pStrTableName;

    SELECT count(*) INTO lIntNbRows FROM pStrTableName;
    SET lStrNewTID = CONCAT(lStrPrefixObject,'-',LPAD(CONVERT(lIntNbRows+1,CHAR),(29-LENGTH(lStrPrefixObject)),'0'));

    RETURN lStrNewTID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure CORE_RegisterNewTID
-- -----------------------------------------------------

USE `TARGET_SCHEMA`;
DROP procedure IF EXISTS `CORE_RegisterNewTID`;

DELIMITER $$
USE `TARGET_SCHEMA`$$
CREATE PROCEDURE CORE_RegisterNewTID (IN pStrTID VARCHAR(30),IN pStrTableName VARCHAR(150))
BEGIN
	INSERT INTO CORE_TID ( tid, obj_tablename) VALUES (pStrTID,pStrTableName);
END$$

DELIMITER ;
