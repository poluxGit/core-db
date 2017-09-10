SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `CORE_TYPEOBJECTS`
-- -----------------------------------------------------
START TRANSACTION;
USE `TARGET_SCHEMA`;
INSERT INTO `CORE_TYPEOBJECTS` (
  `stitle`,
  `ltitle`,
  `comment`,
  `obj_type`,
  `obj_prefix`,
  `obj_tablename`,
  `isSystem`)
VALUES (
    'Object\'s types',
    'All Types of Objects',
    'Internal referentials about Type Of Objects - This Table.',
    'System',
    'TYOBJ',
    'CORE_TYPEOBJECTS',
    1);
INSERT INTO `CORE_TYPEOBJECTS` (
      `stitle`,
      `ltitle`,
      `comment`,
      `obj_type`,
      `obj_prefix`,
      `obj_tablename`,
      `isSystem`)
VALUES (
  'Links\' types',
  'All Types of Links between Objects',
  'Internal referentials about links types betwwen two type of Object.',
  'System',
  'TYLNK',
  'CORE_TYPELINKS',
   1);

   INSERT INTO `CORE_TYPEOBJECTS` (
         `stitle`,
         `ltitle`,
         `comment`,
         `obj_type`,
         `obj_prefix`,
         `obj_tablename`,
         `isSystem`)
   VALUES (
'Attributes\' definition', 'All defintion of Attributes.', 'Internal referentials about attributes defined by type of Links or type of Object.', 'System', 'ATDEF', 'CORE_ATTRDEFS', 1);
INSERT INTO `CORE_TYPEOBJECTS` (
      `stitle`,
      `ltitle`,
      `comment`,
      `obj_type`,
      `obj_prefix`,
      `obj_tablename`,
      `isSystem`)
VALUES (
 'Attributes\' values', 'All values of attributes', 'Internal referential about attributes values defined on Object or Link.', 'System', 'ATVAL', 'CORE_ATTROBJECTS',  1);

COMMIT;
