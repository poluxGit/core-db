-- -----------------------------------------------------
-- Table `CORE_TOBJV_DOCUMENTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_TOBJV_DOCUMENTS` ;

CREATE TABLE IF NOT EXISTS `CORE_TOBJV_DOCUMENTS` (
  `id` INT(8) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT COMMENT 'Identifiant unique géré par le SGBD.',
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEFINED' COMMENT 'Identifiant Unique applicatif',
  `bid` VARCHAR(100) NOT NULL DEFAULT 'BID-NOTDEFINED' COMMENT 'Identifiant "Business" unique.',
  `version` INT NOT NULL DEFAULT 1 COMMENT 'Version de l'objet',
  `revision` INT NOT NULL DEFAULT 0 COMMENT 'Révision de l'objet',
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Titre cournt non défini' COMMENT 'Titre court de l'objet',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Titre long non défini' COMMENT 'Titre long de l'objet',
  `comment` TEXT NULL DEFAULT NULL COMMENT 'description de l'objet',
  `creator` VARCHAR(100) NOT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updator` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UQ_TID` (`tid` ASC),
  UNIQUE INDEX `UQ_BID-VERS-REV` (`bid` ASC, `version` ASC, `revision` ASC),
  INDEX `FK_TOBJ_USER_CREATOR_idx` (`creator` ASC),
  INDEX `FK_TOBJ_USER_UPDATOR_idx` (`updator` ASC),
  CONSTRAINT `FK_DOCUMENTS_USER_CREATOR`
    FOREIGN KEY (`creator`)
    REFERENCES `APP_USERS` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DOCUMENTS_USER_UPDATOR`
    FOREIGN KEY (`updator`)
    REFERENCES `APP_USERS` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
