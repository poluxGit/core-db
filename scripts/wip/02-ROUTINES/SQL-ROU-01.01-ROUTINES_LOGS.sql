-- -----------------------------------------------------
-- procedure LOGS_LogDataEvent_Insert
-- -----------------------------------------------------

USE `TARGET_SCHEMA`;
DROP procedure IF EXISTS `LOGS_LogDataEvent_Insert`;

DELIMITER $$

USE `TARGET_SCHEMA`$$
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

USE `TARGET_SCHEMA`;
DROP procedure IF EXISTS `LOGS_LogDataEvent_Update`;

DELIMITER $$
USE `TARGET_SCHEMA`$$
CREATE PROCEDURE LOGS_LogDataEvent_Update(IN pStrTIDObject VARCHAR(30))
BEGIN

	DECLARE lStrMsg VARCHAR(400);

    SET lStrMsg = CONCAT('Object "',pStrTIDObject,'" data updated successfully.');

    INSERT INTO CORE_LOGS_DATAEVTS
    (`obj_tid`, `message`) VALUES (pStrTIDObject, lStrMsg);


END$$

DELIMITER ;
