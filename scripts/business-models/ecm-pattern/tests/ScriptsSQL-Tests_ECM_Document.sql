SELECT COREDEV01.ECM_createDocumentObject('Document test', 'Un document de test', 'Un document de test');

SELECT `ECM_getLastVersionOnDocument`('DOC-0000000001');
SELECT `ECM_getLastRevisionOnDocument`('DOC-0000000001');


SELECT `ECM_incrementRevisionOnDocumentObject`('DOC-0000000001');

SELECT `ECM_getLastRevisionOnDocument`('DOC-0000000001');

SELECT `ECM_incrementVersionOnDocumentObject`('DOC-0000000001');





