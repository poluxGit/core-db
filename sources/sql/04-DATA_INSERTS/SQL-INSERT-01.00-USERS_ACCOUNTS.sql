SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `CORE_TYPEOBJECTS`
-- -----------------------------------------------------
START TRANSACTION;
USE `TARGET_SCHEMA`;
INSERT INTO `CORE_USER_ACCOUNTS` (`tid`, `firstname`, `lastname`, `comment`, `ctime`, `isActive`, `isSystem`) VALUES ('polux@%', 'polux', 'DEV', 'Main development account.', DEFAULT, 1, 0);

COMMIT;
