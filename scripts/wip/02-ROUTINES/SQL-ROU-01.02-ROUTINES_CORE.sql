
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
-- function CORE_getTIDObjectTypeFromTableName
-- -----------------------------------------------------

USE `TARGET_SCHEMA`;
DROP function IF EXISTS `CORE_getTIDObjectTypeFromTableName`;

DELIMITER $$
USE `TARGET_SCHEMA`$$
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

		select TABLE_ROWS INTO lIntNbRows from information_schema.TABLES
		where TABLE_NAME=pStrTableName AND TABLE_SCHEMA='TARGET_SCHEMA';

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


-- -----------------------------------------------------
-- procedure CORE_addTypeLinkFromTableName
-- -----------------------------------------------------

USE `TARGET_SCHEMA`;
DROP procedure IF EXISTS `CORE_addTypeLinkFromTableName`;

DELIMITER $$
USE `TARGET_SCHEMA`$$
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

USE `TARGET_SCHEMA`;
DROP procedure IF EXISTS `CORE_addAttributeDefinitionForAnObject`;

DELIMITER $$
USE `TARGET_SCHEMA`$$
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

USE `TARGET_SCHEMA`;
DROP procedure IF EXISTS `CORE_addAttributeDefinitionForALink`;

DELIMITER $$
USE `TARGET_SCHEMA`$$
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
