-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema myecm
-- -----------------------------------------------------
-- MyECM Database
DROP SCHEMA IF EXISTS `myecm` ;

-- -----------------------------------------------------
-- Schema myecm
--
-- MyECM Database
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `myecm` DEFAULT CHARACTER SET utf8 ;
USE `myecm` ;

-- -----------------------------------------------------
-- Table `tapp_users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tapp_users` ;

CREATE TABLE IF NOT EXISTS `tapp_users` (
  `login` VARCHAR(100) NOT NULL,
  `firstname` VARCHAR(50) NOT NULL,
  `lastname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`login`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tref_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_categories` ;

CREATE TABLE IF NOT EXISTS `tref_categories` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TINYTEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  CONSTRAINT `fk_categories_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categories_users_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tref_tiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_tiers` ;

CREATE TABLE IF NOT EXISTS `tref_tiers` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  CONSTRAINT `fk_tiers_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tiers_users_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tref_typesdoc`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_typesdoc` ;

CREATE TABLE IF NOT EXISTS `tref_typesdoc` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TINYTEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  CONSTRAINT `fk_typesdoc_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_typesdoc_users_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tdta_containers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tdta_containers` ;

CREATE TABLE IF NOT EXISTS `tdta_containers` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `rootpath` VARCHAR(400) NULL DEFAULT NULL,
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TINYTEXT NULL DEFAULT NULL COMMENT 'Table des conteneurs d\'objets.',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  CONSTRAINT `fk_container_user_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_container_user_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobj_fichiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tobj_fichiers` ;

CREATE TABLE IF NOT EXISTS `tobj_fichiers` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `filename` VARCHAR(20) NOT NULL,
  `filepath` VARCHAR(400) NOT NULL,
  `filesize` BIGINT NOT NULL DEFAULT 0,
  `mime` VARCHAR(100) NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `json_data` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  CONSTRAINT `fk_fichiers_user_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fichiers_user_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tobj_documents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tobj_documents` ;

CREATE TABLE IF NOT EXISTS `tobj_documents` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOUID',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `version` INT NOT NULL DEFAULT 1,
  `revision` INT NOT NULL DEFAULT 1,
  `typedoc_code` VARCHAR(20) NOT NULL,
  `ctnr_code` VARCHAR(20) NOT NULL,
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TINYTEXT NULL DEFAULT NULL,
  `year` INT NOT NULL,
  `month` INT NOT NULL DEFAULT 0,
  `day` INT NOT NULL DEFAULT 0,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `json_data` TEXT NULL DEFAULT NULL,
  UNIQUE INDEX `code_UNIQUE` (`code` ASC, `version` ASC, `revision` ASC),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  INDEX `fk_tref_documents_tref_typesdoc_code_idx` (`typedoc_code` ASC),
  INDEX `fk_tref_documents_tref_containers_code_idx` (`ctnr_code` ASC),
  PRIMARY KEY (`id`, `uid`),
  CONSTRAINT `fk_documents_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documents_users_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documents_typesdoc_code`
    FOREIGN KEY (`typedoc_code`)
    REFERENCES `tref_typesdoc` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documents_containers_code`
    FOREIGN KEY (`ctnr_code`)
    REFERENCES `tdta_containers` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tlnk_documents_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tlnk_documents_categories` ;

CREATE TABLE IF NOT EXISTS `tlnk_documents_categories` (
  `doc_uid` VARCHAR(15) NOT NULL,
  `cat_uid` VARCHAR(15) NOT NULL,
  `isMain` TINYINT NOT NULL DEFAULT 1,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`doc_uid`, `cat_uid`),
  INDEX `fk_categories_idx` (`cat_uid` ASC),
  INDEX `fk_lnk_docs_cats_users_create_idx` (`cuser` ASC),
  CONSTRAINT `fk_lnk_docs_cats_uid`
    FOREIGN KEY (`doc_uid`)
    REFERENCES `tobj_documents` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_cats_uid`
    FOREIGN KEY (`cat_uid`)
    REFERENCES `tref_categories` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_docs_cats_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tlnk_documents_tiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tlnk_documents_tiers` ;

CREATE TABLE IF NOT EXISTS `tlnk_documents_tiers` (
  `doc_uid` VARCHAR(15) NOT NULL,
  `tier_uid` VARCHAR(15) NOT NULL,
  `isMain` TINYINT NOT NULL DEFAULT 1,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`doc_uid`, `tier_uid`),
  INDEX `fk_tiers_idx` (`tier_uid` ASC),
  INDEX `fk_lnk_docs_tiers_users_create_idx` (`cuser` ASC),
  CONSTRAINT `fk_lnk_docs_tiers_uid`
    FOREIGN KEY (`doc_uid`)
    REFERENCES `tobj_documents` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_tiers_uid`
    FOREIGN KEY (`tier_uid`)
    REFERENCES `tref_tiers` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_docs_tiers_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tref_typesdoc_metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tref_typesdoc_metadata` ;

CREATE TABLE IF NOT EXISTS `tref_typesdoc_metadata` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `typedoc_code` VARCHAR(20) NOT NULL,
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `description` TINYTEXT NULL DEFAULT NULL,
  `order_number` INT NOT NULL DEFAULT 0,
  `isMandatory` TINYINT NOT NULL DEFAULT 0,
  `json_data` TEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`, `code`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  INDEX `fk_typedocs_idx` (`typedoc_code` ASC),
  CONSTRAINT `fk_typesdoc_metadata_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_typesdoc_metadata_users_create_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_typedocs_meta_meta_code`
    FOREIGN KEY (`typedoc_code`)
    REFERENCES `tref_typesdoc` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tdta_metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tdta_metadata` ;

CREATE TABLE IF NOT EXISTS `tdta_metadata` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `uid` VARCHAR(15) NOT NULL DEFAULT 'NOTDEF',
  `code` VARCHAR(20) NOT NULL DEFAULT 'NOTDEF',
  `typedoc_code` VARCHAR(20) NOT NULL,
  `tdocmeta_code` VARCHAR(20) NOT NULL,
  `doc_uid` VARCHAR(15) NOT NULL,
  `title` VARCHAR(100) NOT NULL DEFAULT 'Default Title',
  `value` TINYTEXT NULL DEFAULT NULL,
  `json_data` TEXT NULL DEFAULT NULL,
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `utime` TIMESTAMP NULL DEFAULT NULL,
  `uuser` VARCHAR(100) NULL DEFAULT NULL,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`, `code`),
  UNIQUE INDEX `code_UNIQUE` (`code` ASC),
  INDEX `fk_tref_categories_tapp_users_idx` (`cuser` ASC),
  INDEX `fk_tref_categories_tapp_users1_idx` (`uuser` ASC),
  UNIQUE INDEX `uid_UNIQUE` (`uid` ASC),
  INDEX `fk_typedocs_idx` (`typedoc_code` ASC),
  INDEX `fk_typedocs_metadata_code_idx` (`tdocmeta_code` ASC),
  INDEX `fk_documents_uid_idx` (`doc_uid` ASC),
  CONSTRAINT `fk_metadata_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_metadata_users_update`
    FOREIGN KEY (`uuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_metadata_typedocs_code`
    FOREIGN KEY (`typedoc_code`)
    REFERENCES `tref_typesdoc` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_metadata_tdocs_meta_code`
    FOREIGN KEY (`tdocmeta_code`)
    REFERENCES `tref_typesdoc_metadata` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_metadata_documents_uid`
    FOREIGN KEY (`doc_uid`)
    REFERENCES `tobj_documents` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tlnk_documents_fichiers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tlnk_documents_fichiers` ;

CREATE TABLE IF NOT EXISTS `tlnk_documents_fichiers` (
  `doc_code` VARCHAR(20) NOT NULL,
  `fic_uid` VARCHAR(15) NOT NULL,
  `order_number` INT NOT NULL DEFAULT 0,
  `isActive` TINYINT NOT NULL DEFAULT 1,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`doc_code`, `fic_uid`),
  INDEX `fk_fichiers_uid_idx` (`fic_uid` ASC),
  INDEX `fk_lnk_docs_fics_user_create_idx` (`cuser` ASC),
  CONSTRAINT `fk_lnk_docs_fics_uid`
    FOREIGN KEY (`doc_code`)
    REFERENCES `tobj_documents` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_fics_uid`
    FOREIGN KEY (`fic_uid`)
    REFERENCES `tobj_fichiers` (`uid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lnk_docs_fics_user_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tlog_events`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tlog_events` ;

CREATE TABLE IF NOT EXISTS `tlog_events` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(20) NOT NULL,
  `target` VARCHAR(100) NOT NULL DEFAULT 'Objet non défini',
  `message` TEXT NULL,
  `cuser` VARCHAR(100) NOT NULL DEFAULT '@%',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_users_idx` (`cuser` ASC),
  CONSTRAINT `fk_logevent_users_create`
    FOREIGN KEY (`cuser`)
    REFERENCES `tapp_users` (`login`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `myecm` ;

-- -----------------------------------------------------
-- Placeholder table for view `vobj_fichiers_notlinked`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vobj_fichiers_notlinked` (`uid` INT, `filename` INT, `filepath` INT, `filesize` INT, `mime` INT, `ctime` INT, `cuser` INT, `utime` INT, `uuser` INT, `json_data` INT);

-- -----------------------------------------------------
-- Placeholder table for view `vobj_documents_lastversrev`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vobj_documents_lastversrev` (`uid` INT, `code` INT, `version` INT, `revision` INT, `typedoc_code` INT, `ctnr_code` INT, `title` INT, `description` INT, `year` INT, `month` INT, `day` INT, `ctime` INT, `cuser` INT, `utime` INT, `uuser` INT, `isActive` INT, `json_data` INT);

-- -----------------------------------------------------
-- procedure logDataInsert
-- -----------------------------------------------------

USE `myecm`;
DROP procedure IF EXISTS `logDataInsert`;

DELIMITER $$
USE `myecm`$$
CREATE PROCEDURE logDataInsert ( IN pStrTableName VARCHAR(100), IN pStrUIDObject VARCHAR(15), IN pStrCode VARCHAR(20))
BEGIN
	DECLARE lMsg TEXT;
    SET lMsg = CONCAT('Ajout de "',pStrCode,'" dans la tabble "',pStrTableName,'".');
	INSERT INTO `tlog_events` (`type`, `target`, `message`) VALUES ('DATA_INSERT', pStrUIDObject, lMsg);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure logDataUpdate
-- -----------------------------------------------------

USE `myecm`;
DROP procedure IF EXISTS `logDataUpdate`;

DELIMITER $$
USE `myecm`$$
CREATE PROCEDURE logDataUpdate ( IN pStrTableName VARCHAR(100), IN pStrUIDObject VARCHAR(15), IN pStrCode VARCHAR(20))
BEGIN
	DECLARE lMsg TEXT;
    SET lMsg = CONCAT('Mise à jour de "',pStrCode,'" dans la tabble "',pStrTableName,'".');
	INSERT INTO `tlog_events` (`type`, `target`, `message`) VALUES ('DATA_UPDATE', pStrUIDObject, lMsg);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function coreGetAutoIncrementNextValue
-- -----------------------------------------------------

USE `myecm`;
DROP function IF EXISTS `coreGetAutoIncrementNextValue`;

DELIMITER $$
USE `myecm`$$
create function coreGetAutoIncrementNextValue(pStrTablename VARCHAR(100)) RETURNS INT
BEGIN
	DECLARE pk_ai_currentTable INT DEFAULT 0;

    select auto_increment into pk_ai_currentTable
		from information_schema.tables
		where table_name = pStrTablename
		and table_schema = database();

	RETURN pk_ai_currentTable;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- function coreGetPreviousVersion
-- -----------------------------------------------------

USE `myecm`;
DROP function IF EXISTS `coreGetPreviousVersion`;

DELIMITER $$
USE `myecm`$$
CREATE FUNCTION `coreGetPreviousVersion`(pStrDocUid VARCHAR(15)) RETURNS int(11)
BEGIN

	DECLARE iPrevVersion INT DEFAULT  0;
    DECLARE iPrevRevision INT DEFAULT  0;
    DECLARE iCurrVersion INT DEFAULT  0;
    DECLARE iCurrRevision INT DEFAULT  0;
    DECLARE strDocCode VARCHAR(20);

    SELECT code,version,revision INTO strDocCode,iCurrVersion,iCurrRevision
    FROM tobj_documents
    WHERE
		uid = pStrDocUid;

    SELECT tm.version, tm.revision
    INTO iPrevVersion, iPrevRevision
    FROM
    (
		select version,revision
        from `tobj_documents`
        where code = strDocCode
        order by version desc, revision desc
	) tm
    WHERE (
		tm.version = iCurrVersion
        AND tm.revision < iCurrRevision
	)
    OR
    (
		tm.version < iCurrVersion
	)
    ORDER BY tm.version desc, tm.revision desc
    LIMIT 1;

    RETURN iPrevVersion;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function coreGetPreviousRevision
-- -----------------------------------------------------

USE `myecm`;
DROP function IF EXISTS `coreGetPreviousRevision`;

DELIMITER $$
USE `myecm`$$
CREATE FUNCTION `coreGetPreviousRevision`(pStrDocUid VARCHAR(15)) RETURNS int(11)
BEGIN

	DECLARE iPrevVersion INT DEFAULT  0;
    DECLARE iPrevRevision INT DEFAULT  0;
    DECLARE iCurrVersion INT DEFAULT  0;
    DECLARE iCurrRevision INT DEFAULT  0;
    DECLARE strDocCode VARCHAR(20);

    SELECT code,version,revision INTO strDocCode,iCurrVersion,iCurrRevision
    FROM tobj_documents
    WHERE
		uid = pStrDocUid;

    SELECT tm.version, tm.revision
    INTO iPrevVersion, iPrevRevision
    FROM
    (
		select version,revision
        from `tobj_documents`
        where code = strDocCode
        order by version desc, revision desc
	) tm
    WHERE (
		tm.version = iCurrVersion
        AND tm.revision < iCurrRevision
	)
    OR
    (
		tm.version < iCurrVersion
	)
    ORDER BY tm.version desc, tm.revision desc
    LIMIT 1;

    RETURN iPrevRevision;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function coreGetPreviousDocUID
-- -----------------------------------------------------

USE `myecm`;
DROP function IF EXISTS `coreGetPreviousDocUID`;

DELIMITER $$
USE `myecm`$$
CREATE FUNCTION `coreGetPreviousDocUID`(pStrDocUid VARCHAR(15)) RETURNS int(11)
BEGIN

	DECLARE strDocCode VARCHAR(20);
    DECLARE strPreviousDocUID VARCHAR(15) DEFAULT NULL;
    DECLARE iPrevVersion INT;
    DECLARE iPrevRevision INT;

    SELECT code, version, revision INTO strDocCode,iPrevVersion,iPrevRevision
    FROM tobj_documents
    WHERE
		uid = pStrDocUid;


    SELECT uid into strPreviousDocUID
    FROM
    (
		select version,revision
        from `tobj_documents`
        where code = strDocCode
        order by version desc, revision desc
	) tm
    WHERE (
		tm.version = iPrevVersion
        AND tm.revision < iPrevRevision
	)
    OR
    (
		tm.version < iPrevVersion
	)
    ORDER BY tm.version desc, tm.revision desc
    LIMIT 1;

    RETURN strPreviousDocUID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addNewDocument
-- -----------------------------------------------------

USE `myecm`;
DROP procedure IF EXISTS `addNewDocument`;

DELIMITER $$
USE `myecm`$$
CREATE PROCEDURE addNewDocument(IN pStrTitle VARCHAR(100),IN pStrTypeDocCode VARCHAR(20), IN pIntYear INT)
BEGIN

	DECLARE strDocCode VARCHAR(20);
    DECLARE iCountDoc INT;

    SELECT count(distinct code) INTO iCountDoc
    FROM tobj_documents
    WHERE typedoc_code = pStrTypeDocCode AND year = pIntYear;

	SET strDocCode = CONCAT('D-',pStrTypeDocCode,'-',CONVERT(pIntYear,CHAR),'-',LPAD(CONVERT(iCountDoc+1,CHAR),4,'0'));

    INSERT INTO `tobj_documents`(
		`code`,
		`typedoc_code`,
		`ctnr_code`,
		`title`,
		`year`
	)
	VALUES
	(
		strDocCode,
		pStrTypeDocCode,
		'DEFAULT_CONTAINER',
		pStrTitle,
		pIntYear
	);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure _instanciateMetadataForDocument
-- -----------------------------------------------------

USE `myecm`;
DROP procedure IF EXISTS `_instanciateMetadataForDocument`;

DELIMITER $$
USE `myecm`$$
CREATE PROCEDURE `_instanciateMetadataForDocument`(IN pStrDocUid VARCHAR(15))
BEGIN
	declare lStrDocCode varchar(20);

    declare cptMetaDoc 	INT ;
    declare cptMeta 	INT ;
    declare cptDocMeta 	INT ;

    declare iPrevVerDoc	INT ;
    declare iPrevRevDoc	INT ;

    declare lStrTypeDocCode 	varchar(15);
    declare lStrMetaValue 	VARCHAR(4000) ;
    declare lStrMetaTitle 	varchar(100);
    declare lStrMetaCode 	varchar(20);
    declare lStrPrevDocUid 	varchar(15);
    declare lStrMetaJson 	TEXT;

    declare metaValue 	varchar(400);
    declare newMetaCode	varchar(20);

	declare done int default false;
	declare typedocmeta_cursor cursor for select code, title, json_data from `tref_typesdoc_metadata` where typedoc_code = lStrTypeDocCode order by order_number asc;
	declare continue handler for not found set done = true;

    select typedoc_code,version,revision into lStrTypeDocCode,iPrevVerDoc,iPrevRevDoc from tobj_documents where uid = pStrDocUid;

    select count(uid) into cptMetaDoc
    from tdta_metadata
    where typedoc_code = lStrTypeDocCode;

	open typedocmeta_cursor;

creationMeta_loop: loop

    set done = false;
    fetch typedocmeta_cursor into lStrMetaCode,lStrMetaTitle,lStrMetaJson;

    if done then
      leave creationMeta_loop;
    end if;

	SET cptMetaDoc = cptMetaDoc +1;
    SET metaValue = null;
	SET newMetaCode = CONCAT('MDOC-',lStrTypeDocCode,'-',LPAD(cast(cptMetaDoc as CHAR),2,'0'),'-',LPAD(cast(iPrevVerDoc as CHAR(10)),2,'0'),'.',LPAD(cast(iPrevRevDoc as CHAR(10)),3,'0'));

	insert into tdta_metadata (
			code,
			typedoc_code,
            tdocmeta_code,
			doc_uid,
			title,
			value,
			json_data
		) VALUES (
			newMetaCode,
			lStrTypeDocCode,
			lStrMetaCode,
			pStrDocUid,
			lStrMetaTitle,
			metaValue,
            lStrMetaJson
		);


end loop creationMeta_loop;

close typedocmeta_cursor;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure reviseDocument
-- -----------------------------------------------------

USE `myecm`;
DROP procedure IF EXISTS `reviseDocument`;

DELIMITER $$
USE `myecm`$$
CREATE PROCEDURE reviseDocument(IN pStrDocCode VARCHAR(20))
BEGIN

	DECLARE strDocUID VARCHAR(15);
    DECLARE strNewDocUID VARCHAR(15);

    SELECT getLastDocUidFromCode(pStrDocCode) INTO strDocUID;

    INSERT INTO tobj_documents
	(
		`code`,
		`version`,
		`revision`,
		`typedoc_code`,
		`ctnr_code`,
		`title`,
		`description`,
		`year`,
		`month`,
		`day`,
		`json_data`
	)
	SELECT
		code,
		version,
		revision+1 as revision ,
		typedoc_code,
		ctnr_code,
		title,
		description,
		year,
		month,
		day,
		json_data
	FROM tobj_documents
	WHERE uid = strDocUID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function getLastDocUidFromCode
-- -----------------------------------------------------

USE `myecm`;
DROP function IF EXISTS `getLastDocUidFromCode`;

DELIMITER $$
USE `myecm`$$
CREATE FUNCTION `getLastDocUidFromCode`(pStrDocCode VARCHAR(20)) RETURNS VARCHAR(15)
BEGIN

	DECLARE strLastDocUID VARCHAR(15);
    DECLARE iPrevVersion INT;
    DECLARE iPrevRevision INT;

    SELECT uid INTO strLastDocUID
    FROM tobj_documents
    WHERE
		code = pStrDocCode
        AND version = getMaxVersionForDocFromCode(pStrDocCode)
        AND revision = getMaxRevisionForDocFromCode(pStrDocCode);

    RETURN strLastDocUID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function getMaxVersionForDocFromCode
-- -----------------------------------------------------

USE `myecm`;
DROP function IF EXISTS `getMaxVersionForDocFromCode`;

DELIMITER $$
USE `myecm`$$
CREATE FUNCTION `getMaxVersionForDocFromCode`(pStrDocCode VARCHAR(20)) RETURNS INTEGER
BEGIN

	DECLARE iPrevVersion INT;
    DECLARE iPrevRevision INT;

    SELECT MAX(version) INTO iPrevVersion
    FROM tobj_documents
    WHERE
		code = pStrDocCode
	GROUP BY code;

    return iPrevVersion;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- function getMaxRevisionForDocFromCode
-- -----------------------------------------------------

USE `myecm`;
DROP function IF EXISTS `getMaxRevisionForDocFromCode`;

DELIMITER $$
USE `myecm`$$
CREATE FUNCTION `getMaxRevisionForDocFromCode`(pStrDocCode VARCHAR(20)) RETURNS INTEGER
BEGIN

	DECLARE iPrevVersion INT;
    DECLARE iPrevRevision INT;

    SELECT MAX(revision) INTO iPrevVersion
    FROM tobj_documents
    WHERE
		code = pStrDocCode
        AND version = getMaxVersionForDocFromCode(pStrDocCode)
	GROUP BY code;

    return iPrevVersion;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure versionDocument
-- -----------------------------------------------------

USE `myecm`;
DROP procedure IF EXISTS `versionDocument`;

DELIMITER $$
USE `myecm`$$
CREATE PROCEDURE versionDocument(IN pStrDocCode VARCHAR(20))
BEGIN

	DECLARE strDocUID VARCHAR(15);

    SELECT getLastDocUidFromCode(pStrDocCode) INTO strDocUID;

    INSERT INTO `tobj_documents`
	(
		`code`,
		`version`,
		`revision`,
		`typedoc_code`,
		`ctnr_code`,
		`title`,
		`description`,
		`year`,
		`month`,
		`day`,
		`json_data`
	)
	SELECT
		`code`,
		`version`+1 as version,
		1 ,
		`typedoc_code`,
		`ctnr_code`,
		`title`,
		`description`,
		`year`,
		`month`,
		`day`,
		`json_data`
	FROM tobj_documents
	WHERE uid = strDocUID;


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addLinkDocumentToCategorie
-- -----------------------------------------------------

USE `myecm`;
DROP procedure IF EXISTS `addLinkDocumentToCategorie`;

DELIMITER $$
USE `myecm`$$
CREATE PROCEDURE addLinkDocumentToCategorie(IN pStrDocCode VARCHAR(20),IN pStrCatCode VARCHAR(20), IN pIntIsMain INT)
BEGIN

	DECLARE strDocUID VARCHAR(15);
    DECLARE strCatUID VARCHAR(15);

    SELECT uid INTO strCatUID
    FROM tref_categories
    WHERE code = pStrCatCode;

	select getLastDocUidFromCode(pStrDocCode) into strDocUID;

    IF pIntIsMain = 1 THEN
		UPDATE tlnk_documents_categories set isMain=0 WHERE doc_uid=strDocUID;
    END IF;


    INSERT INTO tlnk_documents_categories
	(
		`doc_uid`,
		`cat_uid`,
		`isMain`
	)
	VALUES
	(
		strDocUID,
		strCatUID,
		pIntIsMain
	);


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure removeLinkDocumentToCategorie
-- -----------------------------------------------------

USE `myecm`;
DROP procedure IF EXISTS `removeLinkDocumentToCategorie`;

DELIMITER $$
USE `myecm`$$
CREATE PROCEDURE removeLinkDocumentToCategorie(IN pStrDocCode VARCHAR(20),IN pStrCatCode VARCHAR(20))
BEGIN

	DECLARE strDocUID VARCHAR(15);
    DECLARE strCatUID VARCHAR(15);

    SELECT uid INTO strCatUID
    FROM tref_categories
    WHERE code = pStrCatCode;

	select getLastDocUidFromCode(pStrDocCode) into strDocUID;

	DELETE from tlnk_documents_categories WHERE doc_uid = strDocUID and cat_uid = strCatUID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addLinkDocumentToTier
-- -----------------------------------------------------

USE `myecm`;
DROP procedure IF EXISTS `addLinkDocumentToTier`;

DELIMITER $$
USE `myecm`$$
CREATE PROCEDURE addLinkDocumentToTier(IN pStrDocCode VARCHAR(20),IN pStrTierCode VARCHAR(20), IN pIntIsMain INT)
BEGIN

	DECLARE strDocUID VARCHAR(15);
    DECLARE strTierUID VARCHAR(15);

    SELECT uid INTO strTierUID
    FROM tref_tiers
    WHERE code = pStrTierCode;

	select getLastDocUidFromCode(pStrDocCode) into strDocUID;

    IF pIntIsMain = 1 THEN
		UPDATE tlnk_documents_tiers set isMain=0 WHERE doc_uid=strDocUID;
    END IF;


    INSERT INTO tlnk_documents_tiers
	(
		`doc_uid`,
		`tier_uid`,
		`isMain`
	)
	VALUES
	(
		strDocUID,
		strTierUID,
		pIntIsMain
	);


END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure removeLinkDocumentToTier
-- -----------------------------------------------------

USE `myecm`;
DROP procedure IF EXISTS `removeLinkDocumentToTier`;

DELIMITER $$
USE `myecm`$$
CREATE PROCEDURE removeLinkDocumentToTier(IN pStrDocCode VARCHAR(20),IN pStrTierCode VARCHAR(20))
BEGIN

	DECLARE strDocUID VARCHAR(15);
    DECLARE strTierUID VARCHAR(15);

    SELECT uid INTO strTierUID
    FROM tref_tiers
    WHERE code = pStrTierCode;

	select getLastDocUidFromCode(pStrDocCode) into strDocUID;

	DELETE from tlnk_documents_tiers WHERE doc_uid = strDocUID and tier_uid = strTierUID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure addLinkDocumentToFichier
-- -----------------------------------------------------

USE `myecm`;
DROP procedure IF EXISTS `addLinkDocumentToFichier`;

DELIMITER $$
USE `myecm`$$
CREATE PROCEDURE addLinkDocumentToFichier(IN pStrDocCode VARCHAR(20),IN pStrFicUID VARCHAR(15))
BEGIN

    DECLARE iNbFileDoc INTEGER;

    SELECT max(order_number) INTO iNbFileDoc FROM tlnk_documents_fichiers WHERE doc_code = pStrDocCode;

    IF iNbFileDoc IS NULL THEN
		SET iNbFileDoc = 0;
    END IF;

    INSERT INTO tlnk_documents_fichiers
	(
		`doc_code`,
		`fic_uid`,
		`order_number`
	)
	VALUES
	(
		pStrDocCode,
		pStrFicUID,
		iNbFileDoc+1
	);

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure removeLinkDocumentToFichier
-- -----------------------------------------------------

USE `myecm`;
DROP procedure IF EXISTS `removeLinkDocumentToFichier`;

DELIMITER $$
USE `myecm`$$
CREATE PROCEDURE removeLinkDocumentToFichier(IN pStrDocCode VARCHAR(20),IN pStrFicUID VARCHAR(15))
BEGIN

	DELETE from tlnk_documents_fichiers WHERE doc_code = pStrDocCode and fic_uid = pStrFicUID;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `vobj_fichiers_notlinked`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `vobj_fichiers_notlinked` ;
DROP TABLE IF EXISTS `vobj_fichiers_notlinked`;
USE `myecm`;
CREATE  OR REPLACE VIEW `vobj_fichiers_notlinked` AS
SELECT
    `uid`,
    `filename`,
    `filepath`,
    `filesize`,
    `mime`,
    `ctime`,
    `cuser`,
    `utime`,
    `uuser`,
    `json_data`
FROM `tobj_fichiers` WHERE NOT uid IN (SELECT DISTINCT fic_uid from  `tlnk_documents_fichiers`);

-- -----------------------------------------------------
-- View `vobj_documents_lastversrev`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `vobj_documents_lastversrev` ;
DROP TABLE IF EXISTS `vobj_documents_lastversrev`;
USE `myecm`;
CREATE  OR REPLACE VIEW `vobj_documents_lastversrev` AS
SELECT `uid`,
    `code`,
    `version`,
    `revision`,
    `typedoc_code`,
    `ctnr_code`,
    `title`,
    `description`,
    `year`,
    `month`,
    `day`,
    `ctime`,
    `cuser`,
    `utime`,
    `uuser`,
    `isActive`,
    `json_data`
FROM tobj_documents WHERE uid IN (SELECT getLastDocUidFromCode(code) FROM tobj_documents GROUP BY code) ORDER BY code;
USE `myecm`;

DELIMITER $$

USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_categories_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_categories_BEFORE_INSERT` BEFORE INSERT ON `tref_categories` FOR EACH ROW
BEGIN
	SET NEW.uid = CONCAT('CAT-',UCASE(NEW.code));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_categories_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_categories_AFTER_INSERT` AFTER INSERT ON `tref_categories` FOR EACH ROW
BEGIN
	CALL logDataInsert('tref_categories',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_categories_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_categories_BEFORE_UPDATE` BEFORE UPDATE ON `tref_categories` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_categories_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_categories_AFTER_UPDATE` AFTER UPDATE ON `tref_categories` FOR EACH ROW
BEGIN
	CALL logDataUpdate('tref_categories',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_tiers_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_tiers_BEFORE_INSERT` BEFORE INSERT ON `tref_tiers` FOR EACH ROW
BEGIN
	SET NEW.uid = CONCAT('TIER-',UCASE(NEW.code));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_tiers_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_tiers_AFTER_INSERT` AFTER INSERT ON `tref_tiers` FOR EACH ROW
BEGIN
	CALL logDataInsert('tref_tiers',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_tiers_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_tiers_BEFORE_UPDATE` BEFORE UPDATE ON `tref_tiers` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_tiers_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_tiers_AFTER_UPDATE` AFTER UPDATE ON `tref_tiers` FOR EACH ROW
BEGIN
CALL logDataUpdate('tref_tiers',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_BEFORE_INSERT` BEFORE INSERT ON `tref_typesdoc` FOR EACH ROW
BEGIN

	SET NEW.uid = CONCAT('TDOC-',UCASE(NEW.code));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_AFTER_INSERT` AFTER INSERT ON `tref_typesdoc` FOR EACH ROW
BEGIN
	CALL logDataInsert('tref_typesdoc',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_BEFORE_UPDATE` BEFORE UPDATE ON `tref_typesdoc` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_AFTER_UPDATE` AFTER UPDATE ON `tref_typesdoc` FOR EACH ROW
BEGIN
	CALL logDataUpdate('tref_typesdoc',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_containers_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_containers_BEFORE_INSERT` BEFORE INSERT ON `tdta_containers` FOR EACH ROW
BEGIN
	DECLARE pk_ai_currentTable INT DEFAULT 0;
    SELECT coreGetAutoIncrementNextValue('tdta_containers') INTO pk_ai_currentTable;
	SET NEW.uid = CONCAT('CTNR-',LPAD(CONVERT(pk_ai_currentTable,CHAR),10,'0'));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_containers_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_containers_AFTER_INSERT` AFTER INSERT ON `tdta_containers` FOR EACH ROW
BEGIN
	CALL logDataInsert('tdta_containers',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_containers_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_containers_BEFORE_UPDATE` BEFORE UPDATE ON `tdta_containers` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_containers_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_containers_AFTER_UPDATE` AFTER UPDATE ON `tdta_containers` FOR EACH ROW
BEGIN
	CALL logDataUpdate('tdta_containers',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tobj_fichiers_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tobj_fichiers_BEFORE_INSERT` BEFORE INSERT ON `tobj_fichiers` FOR EACH ROW
BEGIN
	DECLARE pk_ai_currentTable INT;

    SELECT coreGetAutoIncrementNextValue('tobj_fichiers') INTO pk_ai_currentTable;

	SET NEW.uid = CONCAT('FIC-',LPAD(CONVERT(pk_ai_currentTable,CHAR),11,'0'));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tobj_fichiers_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tobj_fichiers_AFTER_INSERT` AFTER INSERT ON `tobj_fichiers` FOR EACH ROW
BEGIN
	CALL logDataInsert('tobj_fichiers',NEW.uid,NEW.filepath);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tobj_fichiers_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tobj_fichiers_BEFORE_UPDATE` BEFORE UPDATE ON `tobj_fichiers` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tobj_fichiers_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tobj_fichiers_AFTER_UPDATE` AFTER UPDATE ON `tobj_fichiers` FOR EACH ROW
BEGIN
	CALL logDataUpdate('tobj_fichiers',NEW.uid,NEW.filepath);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tobj_documents_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tobj_documents_BEFORE_INSERT` BEFORE INSERT ON `tobj_documents` FOR EACH ROW
BEGIN
	DECLARE pk_ai_currentTable INT;
    DECLARE s_Code VARCHAR(20);

    SELECT count(uid) INTO pk_ai_currentTable
    FROM tobj_documents
    WHERE typedoc_code = NEW.typedoc_code AND year = NEW.year; -- uid LIKE CONCAT('D-',NEW.typedoc_code,'-',CONVERT(NEW.year,CHAR),'-%') ;

	SET s_Code = CONCAT('D-',NEW.typedoc_code,'-',CONVERT(NEW.year,CHAR),'-',LPAD(CONVERT(pk_ai_currentTable+1,CHAR),3,'0'));
    SET NEW.uid = s_Code;
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tobj_documents_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tobj_documents_AFTER_INSERT` AFTER INSERT ON `tobj_documents` FOR EACH ROW
BEGIN
	CALL logDataInsert('tobj_documents',NEW.uid,NEW.code);
    CALL _instanciateMetadataForDocument(NEW.uid);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tobj_documents_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tobj_documents_BEFORE_UPDATE` BEFORE UPDATE ON `tobj_documents` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tobj_documents_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tobj_documents_AFTER_UPDATE` AFTER UPDATE ON `tobj_documents` FOR EACH ROW
BEGIN
	CALL logDataUpdate('tobj_documents',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_metadata_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_metadata_BEFORE_INSERT` BEFORE INSERT ON `tref_typesdoc_metadata` FOR EACH ROW
BEGIN
	DECLARE lStrCode VARCHAR(20);
    DECLARE iNbMetaTypeDoc INT;
    DECLARE pk_ai_currentTable INT DEFAULT 0;


    SELECT coreGetAutoIncrementNextValue('tref_typesdoc_metadata') INTO pk_ai_currentTable;
    SELECT COUNT(uid) into iNbMetaTypeDoc
		FROM tref_typesdoc_metadata
		WHERE typedoc_code = NEW.typedoc_code;

	SET lStrCode = CONCAT('TMDC-',NEW.typedoc_code,'-');

    SET NEW.uid = CONCAT('TMDC-',LPAD(CONVERT(pk_ai_currentTable,CHAR),10,'0'));
	SET NEW.code = CONCAT(lStrCode,LPAD(CONVERT(iNbMetaTypeDoc+1,CHAR),20-CHAR_LENGTH(lStrCode),'0'));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_metadata_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_metadata_AFTER_INSERT` AFTER INSERT ON `tref_typesdoc_metadata` FOR EACH ROW
BEGIN
	CALL logDataInsert('tref_typesdoc_metadata',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_metadata_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_metadata_BEFORE_UPDATE` BEFORE UPDATE ON `tref_typesdoc_metadata` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tref_typesdoc_metadata_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tref_typesdoc_metadata_AFTER_UPDATE` AFTER UPDATE ON `tref_typesdoc_metadata` FOR EACH ROW
BEGIN
	CALL logDataUpdate('tref_typesdoc_metadata',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_metadata_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_metadata_BEFORE_INSERT` BEFORE INSERT ON `tdta_metadata` FOR EACH ROW
BEGIN

	DECLARE pk_ai_currentTable INT DEFAULT 0;

    SELECT coreGetAutoIncrementNextValue('tdta_metadata') INTO pk_ai_currentTable;

	SET NEW.uid = CONCAT('MDOC-',LPAD(CONVERT(pk_ai_currentTable,CHAR),10,'0'));
    SET NEW.cuser = CURRENT_USER;
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_metadata_AFTER_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_metadata_AFTER_INSERT` AFTER INSERT ON `tdta_metadata` FOR EACH ROW
BEGIN
	CALL logDataInsert('tdta_containers',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_metadata_BEFORE_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_metadata_BEFORE_UPDATE` BEFORE UPDATE ON `tdta_metadata` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tdta_metadata_AFTER_UPDATE` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tdta_metadata_AFTER_UPDATE` AFTER UPDATE ON `tdta_metadata` FOR EACH ROW
BEGIN
	CALL logDataUpdate('tdta_metadata',NEW.uid,NEW.code);
END$$


USE `myecm`$$
DROP TRIGGER IF EXISTS `tlog_events_BEFORE_INSERT` $$
USE `myecm`$$
CREATE DEFINER = CURRENT_USER TRIGGER `myecm`.`tlog_events_BEFORE_INSERT` BEFORE INSERT ON `tlog_events` FOR EACH ROW
BEGIN
	SET NEW.cuser = CURRENT_USER;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
