-- Catégories
INSERT INTO `ECM_CATEGORIE`(`bid`,`stitle`,`ltitle`,`comment`) VALUES ('CAT-ADMIN','Administratif','Documents Administratifs.','Documents Administratifs.');
INSERT INTO `ECM_CATEGORIE`(`bid`,`stitle`,`ltitle`,`comment`) VALUES ('CAT-FINAN','Financier','Documents Financiers.','Documents Financiers.');
INSERT INTO `ECM_CATEGORIE`(`bid`,`stitle`,`ltitle`,`comment`) VALUES ('CAT-LOGEMENT','Logement','Documents logements.','Documents logements.');
INSERT INTO `ECM_CATEGORIE`(`bid`,`stitle`,`ltitle`,`comment`) VALUES ('CAT-ENERGIE','Energie','Documents relatifs a l\'énergie.','Documents relatifs a l\'énergie.');
INSERT INTO `ECM_CATEGORIE`(`bid`,`stitle`,`ltitle`,`comment`) VALUES ('CAT-TRANSPORT','Transport','Documents reltifs aux transports.','Documents reltifs aux transports.');

-- Tiers
INSERT INTO `ECM_TIER`(`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIE-EDF','EDF','Electricité de France','Fournisseur d\'énergie.');
INSERT INTO `ECM_TIER`(`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIE-TRESORPUBLIC','Trésor Public','Trésor Public.','Trésor Public.');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-EDF','EDF',  'Electricité de France', 'Fournisseur d\'énergie');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-ARCOLEIMMO', 'ARCOLEIMMO', 'Agence ARCOLE Immobilier', 'Arcole Immo - Mme Déficis');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-TRESORPUBL', 'TRESORPUBLIC', 'Trésor Public', 'Administration des finances');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-LIBEA', 'LIBEA', 'Libéa', 'Assurance Auto & Habitation');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-EASYJET', 'EASYJET', 'EaysJet', 'Compagnie Aérienne LowCost.');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-AF', 'AF', 'Air France', 'Compagnie Aérienne Air france.');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-CDR', 'CDR', 'Carrier Delastre Rollet', 'Agence Immobilière Lyonnaise.');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-NORAUTO', 'NORAUTO', 'Norauto', 'Garagiste.');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-BLIZZARD', 'BLIZZARD', 'Blizzard', 'Blizzard & Co.');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-CS', 'CS', 'Communication & Systemes', 'Société de Service Informatique');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-CPAM', 'CPAM', 'Assurance Maladie', 'Assurance Maladie CPAM.');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-AMAZON', 'AMAZON', 'Amazon', 'Plateforme d \'achats en ligne');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-CEPARGNE', 'CEPARGNE', 'Caisse d\'épargne', 'Banque de dépôt.');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-DRSILHAM', 'DRSILHAM', 'Docteur SILHAM', 'Dentiste / Implantologue');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-MATHON', 'MATHON', 'Mathon', 'Equipement de cuisine');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-ENGIE', 'ENGIE', 'Engie', 'Fournisseur de GAZ');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-VIVINTER', 'VIVINTER', 'Vivinter', 'Mutuelle Santé');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-ATRIUMVISI', 'ATRIUMVISION', 'Atrium Vision', 'Centre Ophtalmo');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-MRETLSE', 'MRETLSE', 'Mairie de Toulouse', 'Mairie de Toulouse');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-REPFR', 'REPFR', 'République Française', 'République Française');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-APEYRAMAUR', 'APEYRAMAURE', 'Arnaud Peyramaure', 'Arnaud.');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-DARTY', 'DARTY', 'Darty', 'Enseigne commerciale Electro ménager.');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-FNAC', 'FNAC', 'Fnac', 'Enseigne multimédia');
INSERT INTO `ECM_TIER` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TIER-NORISKO', 'NORISKO', 'Norisko', 'Garage & CT');

-- TypeDoc
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TDOC-FACTURE','Facture','Type de document Facture','Type de document Facture');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`,`comment`) VALUES ('TDOC-CORRESPONDANCE','Correspondance','Type de document Correspondance','Type de document Correspondance');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-AECH', 'Avis d\'échéance', 'Avis d\'échéance.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-AIMP', 'Avis d\'imposition', 'Avis d\'imposition.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-DIMP', 'Déclaration d\'impots', 'Déclaration d\'imôts.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-AREC', 'Avis de réception', 'Avis de réception.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-ATTS', 'Attestation', 'Attestations diverses.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-CEMB', 'Carte d\'embarquement', 'Cartes d\'embarquement.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-CONT', 'Contrat', 'Contrats divers.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-CORR', 'Correspondance', 'Correspodances diverses.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-FACT', 'Facture', 'Factures diverses.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-INFO', 'Information', 'Informations diverses.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-RBAQ', 'Relevé de Banque', 'Relevés de Banque.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-AVCT', 'Contravention', 'Avis de contravention.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-BSAL', 'Bulletin de Salaire', 'Bulletin de Salaire.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-REMS', 'Remboursement de Santé', 'Remboursement de Santé.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-ELIX', 'Etat des lieux', 'Etat des lieux.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-QLOY', 'Quittance', 'Quittance de Loyer.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-BAIL', 'Bail location', 'Bail de location.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-DFSC', 'Déclaration Fiscale', 'Déclaration fiscale.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-BCOM', 'Bon de commande', 'Bon de commande.');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-REMB', 'Remboursement', 'Remboursement divers');
INSERT INTO `ECM_TYPEDOC` (`bid`,`stitle`,`ltitle`) VALUES ('TDOC-PV', 'Procès Verbal', 'Procès Verbal de tous types.');
