USE COREDEV01;
SELECT ECM_createDocumentObject('Facture', 'Facture test', 'document de test');
SELECT `ECM_getLastVersionOnDocument`('DOC-0000000001');
SELECT `ECM_getLastRevisionOnDocument`('DOC-0000000001');

-- Increment
SELECT `ECM_incrementRevisionOnDocumentObject`('DOC-0000000001');
SELECT `ECM_incrementVersionOnDocumentObject`('DOC-0000000001');
SELECT `ECM_incrementRevisionOnDocumentObject`('DOC-0000000001');
SELECT `ECM_incrementRevisionOnDocumentObject`('DOC-0000000001');
SELECT `ECM_incrementRevisionOnDocumentObject`('DOC-0000000001');
SELECT `ECM_incrementVersionOnDocumentObject`('DOC-0000000001');
SELECT `ECM_incrementRevisionOnDocumentObject`('DOC-0000000001');

SELECT `ECM_getLastVersionOnDocument`('DOC-0000000001');
SELECT `ECM_getLastRevisionOnDocument`('DOC-0000000001');

-- DOC N°2
SELECT ECM_createDocumentObject('Bilan', 'Bilan test', 'Bilan de test');
SELECT `ECM_incrementRevisionOnDocumentObject`('DOC-0000000002');
SELECT `ECM_incrementVersionOnDocumentObject`('DOC-0000000002');
SELECT `ECM_incrementRevisionOnDocumentObject`('DOC-0000000002');
