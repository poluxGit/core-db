
-- -----------------------------------------------------
-- Table `CORE_TYPEOBJECTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_TYPEOBJECTS` ;

CREATE TABLE IF NOT EXISTS `CORE_TYPEOBJECTS` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `bid` VARCHAR(50) UNIQUE NOT NULL DEFAULT 'BID-NOTDEF',
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Short Title not defined',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Long Title not defined',
  `comment` TEXT NULL DEFAULT NULL,
  `obj_prefix` VARCHAR(5) NOT NULL DEFAULT 'NDEF',
  `obj_tablename` VARCHAR(150) NULL DEFAULT NULL,
  `cuser` VARCHAR(100) NOT NULL DEFAULT 'notdefined',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `obj_type` ENUM('Simple', 'Complex', 'System') NOT NULL DEFAULT 'Simple',
  `isSystem` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_TYPEOBJ_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TYPEOBJ_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Type of Objects.';

-- -----------------------------------------------------
-- Index on Table `CORE_TYPEOBJECTS`
-- -----------------------------------------------------
CREATE UNIQUE INDEX `UQ_BID` ON `CORE_TYPEOBJECTS` (`bid` ASC);
CREATE INDEX `FK_TYPEOBJ_CUSER_idx` ON `CORE_TYPEOBJECTS` (`cuser` ASC);
CREATE INDEX `FK_TYPEOBJ_UUSER_idx` ON `CORE_TYPEOBJECTS` (`uuser` ASC);

-- -----------------------------------------------------
-- Table `CORE_TYPELINKS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_TYPELINKS` ;

CREATE TABLE IF NOT EXISTS `CORE_TYPELINKS` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `bid` VARCHAR(50) UNIQUE NOT NULL DEFAULT 'BID-NOTDEF',
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Short Title not defined' COMMENT 'Short title of Object',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Long Title not defined' COMMENT 'Long title of object',
  `typobj_src` VARCHAR(30) NULL DEFAULT NULL COMMENT 'Type of source object',
  `typobj_dst` VARCHAR(30) NULL DEFAULT NULL COMMENT 'Type of destination object',
  `comment` TEXT NULL DEFAULT NULL,
  `cuser` VARCHAR(100) NOT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `isSystem` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_TYPLNK_OBJSRC`
    FOREIGN KEY (`typobj_src`)
    REFERENCES `CORE_TYPEOBJECTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TYPLNK_OBJDST`
    FOREIGN KEY (`typobj_dst`)
    REFERENCES `CORE_TYPEOBJECTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TYPLNK_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TYPLNK_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Type of linked between Objects.';

-- -----------------------------------------------------
-- Index on Table `CORE_TYPELINKS`
-- -----------------------------------------------------
CREATE UNIQUE INDEX `UQ_BID` ON `CORE_TYPELINKS` (`bid` ASC);
CREATE INDEX `FK_TYPLNK_OBJSRC_idx` ON `CORE_TYPELINKS` (`typobj_src` ASC);
CREATE INDEX `FK_TYPLNK_OBJDST_idx` ON `CORE_TYPELINKS` (`typobj_dst` ASC);
CREATE INDEX `FK_TYPLNK_CUSER_idx` ON `CORE_TYPELINKS` (`cuser` ASC);
CREATE INDEX `FK_TYPLNK_UUSER_idx` ON `CORE_TYPELINKS` (`uuser` ASC);

-- -----------------------------------------------------
-- Table `CORE_ATTRDEFS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_ATTRDEFS` ;

CREATE TABLE IF NOT EXISTS `CORE_ATTRDEFS` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `tlnk_tid` VARCHAR(30) NULL DEFAULT NULL COMMENT 'Type of links concerned',
  `tobj_tid` VARCHAR(30) NULL DEFAULT NULL,
  `bid` VARCHAR(50) UNIQUE NOT NULL DEFAULT 'BID-NOTDEF',
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Short Title not defined',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Long Title not defined',
  `attr_type` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Type of Attribute definition',
  `attr_pattern` VARCHAR(200) NULL DEFAULT NULL,
  `attr_default_value` VARCHAR(1000) NULL DEFAULT NULL,
  `comment` TEXT NULL DEFAULT NULL,
  `cuser` VARCHAR(100) NOT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `isSystem` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_DEFS_TYPLNK`
    FOREIGN KEY (`tlnk_tid`)
    REFERENCES `CORE_TYPELINKS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DEFS_TYPOBJ`
    FOREIGN KEY (`tobj_tid`)
    REFERENCES `CORE_TYPEOBJECTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DEFS_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DEFS_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Attributes definitions.';

-- -----------------------------------------------------
-- Index on Table `CORE_ATTRDEFS`
-- -----------------------------------------------------
CREATE INDEX `fk_CORE_ATTRDEFS_CORE_TYPELINKS1_idx` ON `CORE_ATTRDEFS` (`tlnk_tid` ASC);
CREATE INDEX `FK_ATTRDEFS_TYPEOBJECT_idx` ON `CORE_ATTRDEFS` (`tobj_tid` ASC);
CREATE INDEX `FK_DEFS_CUSER_idx` ON `CORE_ATTRDEFS` (`cuser` ASC);
CREATE INDEX `FK_DEFS_UUSER_idx` ON `CORE_ATTRDEFS` (`uuser` ASC);

-- -----------------------------------------------------
-- Table `CORE_ATTROBJECTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_ATTROBJECTS` ;

CREATE TABLE IF NOT EXISTS `CORE_ATTROBJECTS` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `bid` VARCHAR(50) UNIQUE NOT NULL DEFAULT 'BID-NOTDEF',
  `stitle` VARCHAR(30) NOT NULL DEFAULT 'Short Title not defined',
  `ltitle` VARCHAR(100) NOT NULL DEFAULT 'Long Title not defined',
  `adef_tid` VARCHAR(30) NOT NULL COMMENT 'Attribute definition key',
  `attr_value` TEXT NULL DEFAULT NULL,
  `comment` TEXT NULL DEFAULT NULL,
  `cuser` VARCHAR(100) NOT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `isSystem` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_ATTRDEF_ATTROBJ`
    FOREIGN KEY (`adef_tid`)
    REFERENCES `CORE_ATTRDEFS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ATTROBJ_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ATTROBJ_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Object attributes values items.';

-- -----------------------------------------------------
-- Index on Table `CORE_ATTROBJECTS`
-- -----------------------------------------------------
CREATE INDEX `FK_ATTROBJ_DEFS_idx` ON `CORE_ATTROBJECTS` (`adef_tid` ASC);
CREATE INDEX `FK_ATTROBJ_CUSER_idx` ON `CORE_ATTROBJECTS` (`cuser` ASC);
CREATE INDEX `FK_ATTROBJ_UUSER_idx` ON `CORE_ATTROBJECTS` (`uuser` ASC);

-- -----------------------------------------------------
-- Table `CORE_TID`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_TID` ;

CREATE TABLE IF NOT EXISTS `CORE_TID` (
  `tid` VARCHAR(30) NOT NULL COMMENT 'Unique TID of Object.',
  `obj_tablename` VARCHAR(150) NOT NULL COMMENT 'Tablename of Object',
  PRIMARY KEY (`tid`))
ENGINE = InnoDB
COMMENT = 'All Object of database TID references.';


-- -----------------------------------------------------
-- Table `CORE_LINKS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_LINKS`;

CREATE TABLE IF NOT EXISTS `CORE_LINKS` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `bid` VARCHAR(50) UNIQUE NOT NULL DEFAULT 'BID-NOTDEF',
  `tlnk_tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `objsrc` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `objdst` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `cuser` VARCHAR(100) NOT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_LNK_TYLNK`
      FOREIGN KEY (`tlnk_tid`)
      REFERENCES `CORE_TYPELINKS` (`tid`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  CONSTRAINT `FK_LNK_CUSER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_LNK_UUSER`
    FOREIGN KEY (`uuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Objects Links Table.';

CREATE UNIQUE INDEX `UQ_BID` ON `CORE_LINKS` (`bid` ASC);
CREATE INDEX `FK_LNK_TYLNK_idx` ON `CORE_LINKS` (`tlnk_tid` ASC);
CREATE INDEX `FK_LNK_CUSER_idx` ON `CORE_LINKS` (`cuser` ASC);
CREATE INDEX `FK_LNK_UUSER_idx` ON `CORE_LINKS` (`uuser` ASC);
