-- -------------------------------------------------------------------------- --
-- MyECM - Database - Deployment Script - Routines package about LOGS         --
-- -------------------------------------------------------------------------- --
-- @author : poluxGit <polux@poluxfr.org>                                     --
-- -------------------------------------------------------------------------- --
-- Database version : 2.0-beta                                                --
-- @date : September, 2017                                                    --
-- -------------------------------------------------------------------------- --

-- -------------------------------------------------------------------------- --
-- PROCEDURE LOG_LogDataUpdate
-- -------------------------------------------------------------------------- --
USE `TARGET_SCHEMA`;
DROP procedure IF EXISTS `LOG_LogDataUpdate`;

DELIMITER $$
USE `TARGET_SCHEMA`$$
CREATE PROCEDURE `LOG_LogDataUpdate`(IN pSTableName VARCHAR(200),IN pStid VARCHAR(30))
COMMENT 'Stored Procedure logging DATA-UPDATE event.'
BEGIN
	DECLARE lMsg TEXT;
  SET lMsg = CONCAT('Update of "',pStid,'" into "',pSTableName,'".');
	INSERT INTO `APP_LOGS_DATA_EVENTS`(`type`,`event_date`,`obj_table`,`obj_tid`, `message`,`user_event`)
  VALUES ('DATA-UPDATE', NOW(), pSTableName, pStid, lMsg, CURRENT_USER);
END$$
DELIMITER ;

-- -------------------------------------------------------------------------- --
-- PROCEDURE LOG_LogDataInsert
-- -------------------------------------------------------------------------- --
USE `TARGET_SCHEMA`;
DROP procedure IF EXISTS `LOG_LogDataInsert`;

DELIMITER $$
USE `TARGET_SCHEMA`$$
CREATE PROCEDURE `LOG_LogDataInsert`(IN pSTableName VARCHAR(200),IN pStid VARCHAR(30))
COMMENT 'Proc. Logging DATA-INSERT event.'
BEGIN
	DECLARE lMsg TEXT;
  SET lMsg = CONCAT('Insert of "',pStid,'" into "',pSTableName,'".');
	INSERT INTO `APP_LOGS_DATA_EVENTS` (`type`,`event_date`,`obj_table`,`obj_tid`,`message`,`user_event`)
  VALUES ('DATA-INSERT', NOW(), pSTableName, pStid, lMsg, CURRENT_USER);
END$$
DELIMITER ;
