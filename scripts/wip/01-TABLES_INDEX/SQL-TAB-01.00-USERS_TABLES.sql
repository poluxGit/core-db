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
