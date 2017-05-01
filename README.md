# MyECM-DB

MyECM Application - Database Conception and implementation.
___

## Informations sur la structure de la base de données


Version Min MySQL : TODEF
GIT_URL


___

### Prefix des objects

| Prefix     | Description   | Commentaires  |
|:----------:|:--------------------------------------------|:-----:|
| tref_      | Table de données références (non versionnés - supprimer logiquement). | -    |
| tobj_      | Table de données Objet (versionnées et complétées).      |   - |
| tlnk_      | Table de liens entre données.      |   - |
| tapp_      | Table de de données applicatives.      |    -|
| tdta_      | Table de de données autres.      |    -|


### Concepts transverses de l'organisation et définition des données

Champs internes et commun à toutes les tables de la base de données :

| Champ(s) | Définition  | Commentaires |Exemples|
|:--------:|:-----------:|--------------|--------|
|id        | Identifiant unique interne auto calculé. | Basé sur le compteur MySQL (i.e. AUTO_INCREMENT).| 000001|
|uid       | Identifiant unique interne. | Basé sur le champ 'id' + préfix Métier.| CAT-000001 |
|cuser      | Utilisateur créateur de la donnée.| Défini à partir du compte de connexion.|polux@%|
|ctime      | Valeur TIMESTAMP de la création de la donnée.| Défini par le système.|2017-04-24 00:04:27|
|uuser      | Utilisateur de la dernière mise à jour de la donnée.| Défini à partir du compte de connexion.|eric@%|
|utime      | Valeur TIMESTAMP de la dernière mise à jour de la donnée.| Défini par le système.|2017-04-24 00:54:12|
|isActive   | Flag de suppression logique (inactive pour les nouveaux).| Sur action utilisateur.|0 ou 1|
