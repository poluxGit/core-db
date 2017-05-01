
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

COMMIT;


-- -----------------------------------------------------
-- Data for table `tref_tiers`
-- -----------------------------------------------------
START TRANSACTION;
USE `myecm`;
INSERT INTO `tref_tiers` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'EDF', 'Electricité de France', 'Fournisseur d\'énergie', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_tiers` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'ARCOLEIMMO', 'Agence ARCOLE Immobilier', 'Arcole Immo - Mme Déficis', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_tiers` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'TRESORPUBLIC', 'Trésor Public', 'Administration des finances', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tref_typesdoc`
-- -----------------------------------------------------
START TRANSACTION;
USE `myecm`;
INSERT INTO `tref_typesdoc` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'AECH', 'Avis d\'échéance', 'Avis d\'échéance.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_typesdoc` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'AIMP', 'Avis d\'imposition', 'Avis d\'imposition.',  DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_typesdoc` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'AREC', 'Avis de réception', 'Avis de réception.',  DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_typesdoc` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'ATTS', 'Attestation', 'Attestations diverses.',  DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_typesdoc` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'CEMB', 'Carte d\'embarquement', 'Cartes d\'embarquement.',  DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_typesdoc` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'CONT', 'Contrat', 'Contrats divers.',  DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_typesdoc` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'CORR', 'Correspondance', 'Correspodances diverses.',  DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_typesdoc` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'FACT', 'Facture', 'Factures diverses.',  DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_typesdoc` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'INFO', 'Information', 'Informations diverses.',  DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tref_typesdoc` (`id`, `uid`, `code`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'RBAQ', 'Relevé de Banque', 'Relevés de Banque.',  DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tdta_containers`
-- -----------------------------------------------------
START TRANSACTION;
USE `myecm`;
INSERT INTO `tdta_containers` (`id`, `uid`, `code`, `rootpath`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'DEFAULT_CONTAINER', '/home/mydocs/_imports', 'Default', 'Default Container of Documents', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tdta_containers` (`id`, `uid`, `code`, `rootpath`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'ADMINISTRATIF_CONT', '/home/mydocs/Administratif', 'Administratif', 'Administratif documents container.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);
INSERT INTO `tdta_containers` (`id`, `uid`, `code`, `rootpath`, `title`, `description`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`, `json_data`) VALUES (DEFAULT, DEFAULT, 'LOGEMENT_CONT', '/home/mydocs/Logement', 'Logement', 'Documents relatifs au logement.', DEFAULT, DEFAULT, NULL, NULL, DEFAULT, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tref_typesdoc_metadata`
-- -----------------------------------------------------
START TRANSACTION;
USE `myecm`;
INSERT INTO `tref_typesdoc_metadata` (`id`, `uid`, `code`, `typedoc_code`, `title`, `description`, `order_number`, `isMandatory`, `json_data`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`) VALUES (DEFAULT, DEFAULT, DEFAULT, 'FACT', 'Montant', 'Montant de la facture.', 1, 1, '{\'type\':\'numeric\',\'pattern\':\'%d €\'}', DEFAULT, DEFAULT, NULL, NULL, DEFAULT);
INSERT INTO `tref_typesdoc_metadata` (`id`, `uid`, `code`, `typedoc_code`, `title`, `description`, `order_number`, `isMandatory`, `json_data`, `ctime`, `cuser`, `utime`, `uuser`, `isActive`) VALUES (DEFAULT, DEFAULT, DEFAULT, 'AIMP', 'Année imposée', 'Année d\'imposition', 1, 1, '{\'type\':\'year\'}', DEFAULT, DEFAULT, NULL, NULL, DEFAULT);

COMMIT;
