-- Catégories
INSERT INTO `ECM_CATEGORIE`(`bid`,`stitle`,`ltitle`,`comment`) VALUES ('CAT-ADMIN','Administratif','Documents Administratifs.','Documents Administratifs.');
INSERT INTO `ECM_CATEGORIE`(`bid`,`stitle`,`ltitle`,`comment`) VALUES ('CAT-FINAN','Financier','Documents Financiers.','Documents Financiers.');
INSERT INTO `ECM_CATEGORIE`(`bid`,`stitle`,`ltitle`,`comment`) VALUES ('CAT-LOGEMENT','Logement','Documents logements.','Documents logements.');
INSERT INTO `ECM_CATEGORIE`(`bid`,`stitle`,`ltitle`,`comment`) VALUES ('CAT-ENERGIE','Energie','Documents relatifs a l\'énergie.','Documents relatifs a l\'énergie.');
INSERT INTO `ECM_CATEGORIE`(`bid`,`stitle`,`ltitle`,`comment`) VALUES ('CAT-TRANSPORT','Transport','Documents reltifs aux transports.','Documents reltifs aux transports.');

-- Tiers
INSERT INTO `ECM_TIER`(`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIE-EDF','EDF','Electricité de France','Fournisseur d\'énergie.');
INSERT INTO `ECM_TIER`(`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIE-TRESORPUBLIC','Trésor Public','Trésor Public.','Trésor Public.');

-- TypeDoc
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TDOC-FACTURE','Facture','Type de document Facture','Type de document Facture');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TDOC-CORRESPONDANCE','Correspondance','Type de document Correspondance','Type de document Correspondance');


