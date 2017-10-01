DELIMITER $$

CREATE PROCEDURE `LOG_LogDataUpdate`(IN pSTableName VARCHAR(200),IN pStid VARCHAR(30))
COMMENT 'Proc. Logging DATA-UPDATE event.'
BEGIN
	DECLARE lMsg TEXT;    
    SET lMsg = CONCAT('Mise à jour de "',pStid,'" dans la table "',pSTableName,'".');
	INSERT INTO `LOGS_CORE_DATA_EVENTS` 
    (
		`type`, 
        `event_date`, 
        `obj_table`, 
        `obj_tid`, 
        `message`, 
        `user_event`
	) VALUES 
    ('DATA-UPDATE', NOW(), pSTableName, pStid, lMsg, CURRENT_USER);
    
END$$

CREATE PROCEDURE `LOG_LogDataInsert`(IN pSTableName VARCHAR(200),IN pStid VARCHAR(30))
COMMENT 'Proc. Logging DATA-INSERT event.'
BEGIN
	DECLARE lMsg TEXT;    
    SET lMsg = CONCAT('Ajout de "',pStid,'" dans la table "',pSTableName,'".');
	INSERT INTO `LOGS_CORE_DATA_EVENTS` 
    (
		`type`, 
        `event_date`, 
        `obj_table`, 
        `obj_tid`, 
        `message`, 
        `user_event`
	) VALUES 
    ('DATA-INSERT', NOW(), pSTableName, pStid, lMsg, CURRENT_USER);
    
END$$

