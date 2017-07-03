
-- -----------------------------------------------------
-- Data for table `tapp_users`
-- -----------------------------------------------------
START TRANSACTION;
USE `myecm`;
INSERT INTO `tapp_users` (`login`, `firstname`, `lastname`) VALUES ('polux@%', 'PoLuX', 'DEV');
INSERT INTO `tapp_users` (`login`, `firstname`, `lastname`) VALUES ('polux@localhost', 'PoLuX', 'Local');
INSERT INTO `tapp_users` (`login`, `firstname`, `lastname`) VALUES ('root@localhost', 'Root', 'Local');
INSERT INTO `tapp_users` (`login`, `firstname`, `lastname`) VALUES ('root@%', 'ROOT', 'Anywhere');
INSERT INTO `tapp_users` (`login`, `firstname`, `lastname`) VALUES ('@%', 'DEV', 'DEV');

COMMIT;


-- -----------------------------------------------------
-- Data for table `tref_categories`
-- -----------------------------------------------------
START TRANSACTION;
USE `myecm`;

INSERT INTO `tref_categories` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'ADMIN', 'Administratif', 'Documents Administratifs.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_categories` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'PRO', 'Professionel', 'Documents Professionnels.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_categories` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'FINACR', 'Finances', 'Documents Financiers.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_categories` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'LOGMT', 'Logement', 'Documents relatifs au(x) logement(s).', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_categories` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'TRANSPT', 'Transport', 'Documents relatifs au(x) transport(s).', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_categories` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'ECIVIL', 'Etat civil', 'Documents relatifs à l\'état civil.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_categories` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'SANTE', 'Santé', 'Documents relatifs à la santé.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_categories` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'FISC', 'Fiscalité', 'Documents relatifs à la Fiscalité.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_categories` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'EBOOK', 'E-Books', 'E-Books, Livres, Guides en tout genre.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_categories` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'LOISIRS', 'Loisirs', 'Loisirs en tout genre.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_categories` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'GAMING', 'Gaming', 'Gaming.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tref_tiers`
-- -----------------------------------------------------
START TRANSACTION;
USE `myecm`;

INSERT INTO `tref_tiers` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'EDF', 'Electricité de France', 'Fournisseur d\'énergie', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_tiers` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'ARCOLEIMMO', 'Agence ARCOLE Immobilier', 'Arcole Immo - Mme Déficis', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_tiers` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'TRESORPUBLIC', 'Trésor Public', 'Administration des finances', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_tiers` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'LIBEA', 'Libéa', 'Assurance Auto & Habitation', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_tiers` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'EASYJET', 'EaysJet', 'Compagnie Aérienne LowCost.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_tiers` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'AF', 'Air France', 'Compagnie Aérienne Air france.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_tiers` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'CDR', 'Carrier Delastre Rollet', 'Agence Immobilière Lyonnaise.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_tiers` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'NORAUTO', 'Norauto', 'Garagiste.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_tiers` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'BLIZZARD', 'Blizzard', 'Blizzard & Co.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tref_typesdoc`
-- -----------------------------------------------------
START TRANSACTION;
USE `myecm`;

INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('AECH', 'Avis d\'échéance', 'Avis d\'échéance.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('AIMP', 'Avis d\'imposition', 'Avis d\'imposition.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('DIMP', 'Déclaration d\'impots', 'Déclaration d\'imôts.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('AREC', 'Avis de réception', 'Avis de réception.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('ATTS', 'Attestation', 'Attestations diverses.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('CEMB', 'Carte d\'embarquement', 'Cartes d\'embarquement.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('CONT', 'Contrat', 'Contrats divers.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('CORR', 'Correspondance', 'Correspodances diverses.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('FACT', 'Facture', 'Factures diverses.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('INFO', 'Information', 'Informations diverses.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('RBAQ', 'Relevé de Banque', 'Relevés de Banque.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('AVCT', 'Contravention', 'Avis de contravention.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('BSAL', 'Bulletin de Salaire', 'Bulletin de Salaire.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('REMS', 'Remboursement de Santé', 'Remboursement de Santé.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('ELIX', 'Etat des lieux', 'Etat des lieux.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('QLOY', 'Quittance', 'Quittance de Loyer.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('BAIL', 'Bail location', 'Bail de location.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('DFSC', 'Déclaration Fiscale', 'Déclaration fiscale.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('BCOM', 'Bon de commande', 'Bon de commande.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('PVER', 'Procès Verbal', 'Procès Verbal de tous types.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('REMB', 'Remboursement', 'Remboursement divers.');
INSERT INTO `tref_typesdoc` (`code`, `title`, `description`) VALUES ('AVCT', 'Contravention', 'Avis de contravention.');


COMMIT;
-- -----------------------------------------------------
-- Data for table `tdta_containers`
-- -----------------------------------------------------
START TRANSACTION;
USE `myecm`;
INSERT INTO `tdta_containers` (`id`, `uid`, `code`, `rootpath`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'DEFAULT_CONTAINER', '/volume1/documents/myecm-dev/_imports', 'Default', 'Default Container of Documents', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tdta_containers` (`id`, `uid`, `code`, `rootpath`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'ADMINISTRATIF_CONT', '/volume1/documents/myecm-dev/Administratif', 'Administratif', 'Administratif documents container.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tdta_containers` (`id`, `uid`, `code`, `rootpath`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'LOGEMENT_CONT', '/volume1/documents/myecm-dev/Logement', 'Logement', 'Documents relatifs au logement.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tdta_containers` (`id`, `uid`, `code`, `rootpath`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'FISC_CONT', '/volume1/documents/myecm-dev/Fiscalite', 'Fiscalité', 'Documents relatifs à la fiscalité.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tdta_containers` (`id`, `uid`, `code`, `rootpath`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'BIBLIO_CONT', '/volume1/documents/myecm-dev/Biblios', 'Bibliothèque', 'Documents Editeur (Guides,Livres ...).', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);

INSERT INTO `tdta_containers` (`id`, `uid`, `code`, `rootpath`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'BIBLIO_CONT', '/volume1/documents/myecm-dev/Biblios', 'Bibliothèque', 'Documents Editeur (Guides,Livres ...).', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tdta_containers` (`id`, `uid`, `code`, `rootpath`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'BIBLIO_CONT', '/volume1/documents/myecm-dev/Biblios', 'Bibliothèque', 'Documents Editeur (Guides,Livres ...).', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tdta_containers` (`id`, `uid`, `code`, `rootpath`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'BIBLIO_CONT', '/volume1/documents/myecm-dev/Biblios', 'Bibliothèque', 'Documents Editeur (Guides,Livres ...).', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tdta_containers` (`id`, `uid`, `code`, `rootpath`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'BIBLIO_CONT', '/volume1/documents/myecm-dev/Biblios', 'Bibliothèque', 'Documents Editeur (Guides,Livres ...).', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tdta_containers` (`id`, `uid`, `code`, `rootpath`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'BIBLIO_CONT', '/volume1/documents/myecm-dev/Biblios', 'Bibliothèque', 'Documents Editeur (Guides,Livres ...).', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);


COMMIT;


-- -----------------------------------------------------
-- Data for table `tref_typesdoc_metadata`
-- -----------------------------------------------------
START TRANSACTION;
USE `myecm`;
INSERT INTO `tref_typesdoc_metadata` (`id`, `uid`, `code`, `typedoc_code`, `title`, `description`, `order_number`, `isMandatory`, `json_data`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`) VALUES (DEFAULT, DEFAULT, DEFAULT, 'FACT', 'Montant', 'Montant de la facture.', 1, 1, '{\'type\':\'numeric\',\'pattern\':\'%d €\'}', DEFAULT, DEFAULT, NULL, NULL, DEFAULT);
INSERT INTO `tref_typesdoc_metadata` (`id`, `uid`, `code`, `typedoc_code`, `title`, `description`, `order_number`, `isMandatory`, `json_data`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`) VALUES (DEFAULT, DEFAULT, DEFAULT, 'AIMP', 'Année imposée', 'Année fiscale d\'imposition', 1, 1, '{\'type\':\'year\'}', DEFAULT, DEFAULT, NULL, NULL, DEFAULT);
INSERT INTO `tref_typesdoc_metadata` (`id`, `uid`, `code`, `typedoc_code`, `title`, `description`, `order_number`, `isMandatory`, `json_data`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`) VALUES (DEFAULT, DEFAULT, DEFAULT, 'BSAL', 'Montant NET', 'Montant NET imposable.', 1, 1, '{\'type\':\'numeric\',\'pattern\':\'%d €\'}', DEFAULT, DEFAULT, NULL, NULL, DEFAULT);
INSERT INTO `tref_typesdoc_metadata` (`id`, `uid`, `code`, `typedoc_code`, `title`, `description`, `order_number`, `isMandatory`, `json_data`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`) VALUES (DEFAULT, DEFAULT, DEFAULT, 'BSAL', 'Montant BRUT', 'Montant BRUT.', 2, 1, '{\'type\':\'numeric\',\'pattern\':\'%d €\'}', DEFAULT, DEFAULT, NULL, NULL, DEFAULT);
INSERT INTO `tref_typesdoc_metadata` (`id`, `uid`, `code`, `typedoc_code`, `title`, `description`, `order_number`, `isMandatory`, `json_data`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`) VALUES (DEFAULT, DEFAULT, DEFAULT, 'CEMB', 'Aéroport Départ', 'Aéroport de départ.', 1, 0, '{\'type\':\'text\'}', DEFAULT, DEFAULT, NULL, NULL, DEFAULT);
INSERT INTO `tref_typesdoc_metadata` (`id`, `uid`, `code`, `typedoc_code`, `title`, `description`, `order_number`, `isMandatory`, `json_data`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`) VALUES (DEFAULT, DEFAULT, DEFAULT, 'CEMB', 'Aéroport Arrivée', 'Aéroport d\'arrivée.', 2, 0, '{\'type\':\'text\'}', DEFAULT, DEFAULT, NULL, NULL, DEFAULT);
INSERT INTO `tref_typesdoc_metadata` (`id`, `uid`, `code`, `typedoc_code`, `title`, `description`, `order_number`, `isMandatory`, `json_data`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`) VALUES (DEFAULT, DEFAULT, DEFAULT, 'AVCT', 'Montant', 'Montant de la contravention.', 1, 1, '{\'type\':\'numeric\',\'pattern\':\'%d €\'}', DEFAULT, DEFAULT, NULL, NULL, DEFAULT);

COMMIT;


DELIMITER $$
CREATE FUNCTION `capitalize`(s varchar(255)) RETURNS varchar(255)
BEGIN
  declare c int;
  declare x varchar(255);
  declare y varchar(255);
  declare z varchar(255);

  set x = UPPER( SUBSTRING( s, 1, 1));
  set y = SUBSTR( s, 2);
  set c = instr( y, ' ');

  while c > 0
    do
      set z = SUBSTR( y, 1, c);
      set x = CONCAT( x, z);
      set z = UPPER( SUBSTR( y, c+1, 1));
      set x = CONCAT( x, z);
      set y = SUBSTR( y, c+2);
      set c = INSTR( y, ' ');
  end while;
  set x = CONCAT(x, y);
  return x;
END$$

DELIMITER ;
