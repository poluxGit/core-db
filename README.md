# Core Database

CORE Database Project
___
GIT Repository : [core-db](https://github.com/poluxGit/core-db.git)

# 1. TIMESTAMP
2. toto
3. lkfmld
4.

## Organisation du projet

```
Version Min Database : Maria DB (Synology)

```
___

## Releases Notes
### MyECM - alpha_02 - In Progress
* [x] Internal : Récupération des valeurs précédentes des metatdonnées (Version/Revision).
* [x] Internal : Duplication des liens vers Cat,Tier,Fic quand Version/revision d'un document.
* [ ] Internal : Intégrer la gestion des containers quand ajout de Document.
* [ ] Internal : Concevoir & Implémenter le déplacement de containers.
* [ ] Internal : Nouveau module de gestion des tâches -> nouveau schéma 'myecm-tasks'

### MyECM - alpha_01 - Released
* [x] DB Management : Triggers
* [x] Data Management : Procédures stockées pour gestion document & Functions (Version/Revision OK)
* [x] Data Management : Procédures stockées pour gestion des liens Document/Tables de références (Catégories,Tiers,Fichiers)
* [x] Internal : Instanciation automatique des metadonnées (sans récupération de valeurs)

## Technical Documentation - TODO UPDATE - OBSO
### Prefix des objects

| Prefix     | Description   | Commentaires  |
|:----------:|:--------------------------------------------|:-----:|
| tref_      | Table de données références (non versionnés - supprimer logiquement). | -    |
| tobj_      | Table de données Objet (versionnées et complétées).      |   - |
| tlnk_      | Table de liens entre données.      |   - |
| tapp_      | Table de de données applicatives.      |    -|
| tdta_      | Table de de données autres.      |    -|

### Concepts transverses de l'organisation et définition des données - TODO UPDATE - OBSO

Champs internes et commun à toutes les tables de la base de données :

| Champ(s) | Définition  | Commentaires |Exemples|
|:--------:|:-----------:|--------------|--------|
|id        | Identifiant unique interne auto calculé. | Basé sur le compteur MySQL (i.e. AUTO_INCREMENT).| 000001|
|uid       | Identifiant unique interne. | Basé sur le champ 'id' + préfix Métier.| CAT-000001 |
|code       | Identifiant unique fonctionnel. | Dépends de la table.| CAT-ADMIN |
|cuser      | Utilisateur créateur de la donnée.| Défini à partir du compte de connexion.|polux@%|
|ctime      | Valeur TIMESTAMP de la création de la donnée.| Défini par le système.|2017-04-24 00:04:27|
|uuser      | Utilisateur de la dernière mise à jour de la donnée.| Défini à partir du compte de connexion.|eric@%|
|utime      | Valeur TIMESTAMP de la dernière mise à jour de la donnée.| Défini par le système.|2017-04-24 00:54:12|
|isActive   | Flag de suppression logique (inactive pour les nouveaux).| Sur action utilisateur.|0 ou 1|

### UID générés / Codes générés

| Table     | Exemple d'identifiant   | Règles génériques  | Code correspondant |
|:----------:|:--------------------------------------------|:-----:|:-----:|
| tobj_tasks | T20170831233059 | T{YEAR}{MONTH}{DAY}{HOUR}{MINUTES}{SECONDS}    |T-20170831-233059 |
| tref_status | TSTA-INIT | TSTA-{STATUS_CODE}    | INIT |
