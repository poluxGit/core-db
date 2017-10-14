# Core DB
Informations pour développeur

## Répertoires du projet

|Nom      |Type|Description|
|:--------|:------:|-----------------|
|`build`|Répertoire|Sources relatives à l'environnement de développement.   |
|`datasets`|Répertoire|Jeux de données exemple.   |   
|`models`   |Répertoire   |Fichiers workbench de conception du modèle de base de données    |   
|`releases`   |Répertoire   |Versions des scripts de création de la base de données.   |
|`scripts`   |Répertoire   |Source des scripts générés (SQL).   |

## Scripts de génération des scripts SQL finaux

- Dans un environnement UNIX/LINUX (Shell)

```   
./scripts/release-core.sh <TARGET_DB_SCHEMA> <MAJOR_VERSION> <MINOR_VERSION>

```
[*Source du script*](./scripts/release-core.sh)
