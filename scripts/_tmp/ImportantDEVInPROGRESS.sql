DELIMITER $$

CREATE PROCEDURE `CORE_DuplicateLinksForNewTID`(IN pTID_NewObject VARCHAR(30),IN pTID_OldObject VARCHAR(30))
COMMENT 'Duplicate Links for a new TID from an oldest one.'
BEGIN
	INSERT INTO `CORE_LINKS` (`objsrc_tid`, `objdst_tid`, `lnktyp_tid`)
    SELECT pTID_NewObject, LNKS.`objdst_tid`, LNKS.`lnktyp_tid`  FROM CORE_LINKS LNKS WHERE LNKS.`objsrc_tid` = pTID_OldObject;
END$$

CREATE PROCEDURE `CORE_DuplicateLinksAttributesForNewTID`(IN pTID_NewObject VARCHAR(30),IN pTID_OldObject VARCHAR(30))
COMMENT 'Duplicate Links Attributes for a new TID from an oldest one.'
BEGIN

	INSERT INTO `CORE_LINKS` (`objsrc_tid`, `objdst_tid`, `lnktyp_tid`, `lnktypattr_tid`, `attr_order`, `attr_name`, `attr_value`)
    SELECT
		pTID_NewObject,
        LNKS.`objdst_tid`,
        LNKS.`lnktyp_tid`,
        LNKS.lnktypattr_tid,
        LNKS.attr_order,
        LNKS.attr_name,
        LNKS.attr_value
	FROM CORE_LINKS_ATTRIBUTES LNKS
    WHERE LNKS.`objsrc_tid` = pTID_OldObject
    ORDER BY LNKS.attr_order;
END$$

CREATE PROCEDURE `CORE_SetNewVersionOnObject`(IN pTID_NewObject VARCHAR(30),IN pTID_OldObject VARCHAR(30), OUT pIntNewVersion VARCHAR(30))
COMMENT 'Duplicate Links Attributes for a new TID from an oldest one.'
BEGIN

	INSERT INTO `CORE_LINKS` (`objsrc_tid`, `objdst_tid`, `lnktyp_tid`, `lnktypattr_tid`, `attr_order`, `attr_name`, `attr_value`)
    SELECT
		pTID_NewObject,
        LNKS.`objdst_tid`,
        LNKS.`lnktyp_tid`,
        LNKS.lnktypattr_tid,
        LNKS.attr_order,
        LNKS.attr_name,
        LNKS.attr_value
	FROM CORE_LINKS_ATTRIBUTES LNKS
    WHERE LNKS.`objsrc_tid` = pTID_OldObject
    ORDER BY LNKS.attr_order;
END$$
