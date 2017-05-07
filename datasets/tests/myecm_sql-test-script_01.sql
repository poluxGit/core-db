CALL `myecm`.`addNewDocument`('Facture Test', 'FACT', 2016);

CALL `myecm`.`addNewDocument`('Document AIMP', 'AIMP', 2014);


CALL `myecm`.`_instanciateMetadataForDocument`('D-FACT-2016-003', 'FACT', 1, 1);

SELECT getLastDocUidFromCode('D-FACT-2016-0003');

CALL  `reviseDocument`('D-FACT-2016-0003');
CALL  `reviseDocument`('D-AIMP-2014-0003');


CALL  `versionDocument`('D-AIMP-2014-0003');
CALL  `versionDocument`('D-FACT-2016-0003');

CALL `myecm`.`addLinkDocumentToCategorie`('D-FACT-2016-0003', 'ADMIN', 1);
CALL `myecm`.`addLinkDocumentToCategorie`('D-FACT-2016-0003', 'PRO', 1);



CALL `myecm`.`addLinkDocumentToFichier`('D-FACT-2016-0003', 'FIC-00000000001');


INSERT INTO `myecm`.`tobj_fichiers`
(
`filename`,
`filepath`,
`filesize`,
`mime`)
VALUES
('toto.txt',
'/var/volume1/test',
123654,
'text');
