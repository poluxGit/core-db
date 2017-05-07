
-- -----------------------------------------------------
-- Dataset for Use CASES 01 - Tests Documents
-- -----------------------------------------------------
START TRANSACTION;
USE `myecm`;

  -- Tests CREATION AND VERSION AND REVISE DOC
  CALL `myecm`.`addNewDocument`('DS01 - Facture de 2016', 'FACT', 2016);
  CALL `myecm`.`addNewDocument`('DS01 - Avis Imposition 2015', 'AIMP', 2015);

  CALL  `reviseDocument`('D-FACT-2016-0001');
  CALL  `reviseDocument`('D-AIMP-2015-0001');
  CALL  `reviseDocument`('D-FACT-2016-0001');
  CALL  `reviseDocument`('D-FACT-2016-0001');

  CALL  `versionDocument`('D-AIMP-2015-0001');
  CALL  `versionDocument`('D-FACT-2016-0001');

  CALL  `reviseDocument`('D-FACT-2016-0001');
  CALL  `reviseDocument`('D-FACT-2016-0001');
  CALL  `reviseDocument`('D-FACT-2016-0001');

  -- > Expected result < ----- FACT V:2 Rev : 4 | AIMP V:2 Rev:1

  CALL `myecm`.`addLinkDocumentToCategorie`('D-AIMP-2015-0001', 'ADMIN', 1);
  CALL `myecm`.`addLinkDocumentToCategorie`('D-FACT-2016-0001', 'PRO', 1);



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

  CALL `myecm`.`addLinkDocumentToFichier`('D-FACT-2016-0001', 'FIC-00000000001');

  INSERT INTO `myecm`.`tobj_fichiers`
  (
  `filename`,
  `filepath`,
  `filesize`,
  `mime`)
  VALUES
  ('fichiertest2.txt',
  '/var/volume1/test2',
  123654,
  'text');

COMMIT;
