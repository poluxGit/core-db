SELECT ECM_createDocumentObject('Document test', 'Un document de test', 'Un document de test');

SELECT `ECM_getLastVersionOnDocument`('DOC-0000000001');
SELECT `ECM_getLastRevisionOnDocument`('DOC-0000000001');


SELECT `ECM_incrementRevisionOnDocumentObject`('DOC-0000000001');

SELECT `ECM_getLastRevisionOnDocument`('DOC-0000000001');

SELECT `ECM_incrementVersionOnDocumentObject`('DOC-0000000001');




INSERT INTO `CORE_ATTROBJECTS`
  (
    `stitle`,
    `ltitle`,
    `obj_tid`,
    `adef_tid`,
    `attr_value`,
    `comment`
  )
SELECT
   `stitle`,
   `ltitle`,
    'DOC-00000000000000000000000001',
    `tid`,
    `attr_default_value`,
    `comment`
  FROM `CORE_ATTRDEFS`
  WHERE `tobj_tid` = 'TYOBJ-000000000000000000000006';
