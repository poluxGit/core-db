# SQL Scripts directory
- ---
## Project Organization

#### Worskspace Directories

|Directory name|Comment|
|--------------|-------|
|business-models   | Business Models related patterns.   |
|wip   | Work in progress.   |


#### Build commands

- CORE DB Packaging


```shell
./release-core.sh <TARGET_SCHEMA> <MajorVersion> <MinorVersion>
```

- Specific Business pattern Packaging (ECM for instance)

``` bash
./release-ecm.sh <TARGET_SCHEMA>
```

### Roadmap

#### Goals

1. Provide a sure way to store versionned objects into a Database

#### TODO List - Next Release
* [x] Integrate Attributes Definition First instanciation into TRIGGERS after update on Complex Object/On Simple Object too.
  - [x] Impact Generic Pattern Trigger definition
* [x] Add View defintion SQL for Object
  - [x] From CSV file attrobj ? Complex/Simple ?
  - [ ] From CSV file attrlnk ? Complex/Simple ?

#### TODO List - To plan
* [ ] Intégrer la gestion d'attribut sur objet (BID ? / TID ?).
  - [ ] Script de génération PHP - Impacts
  - [ ] Mise à jour des Modèles SQL
  - [ ] Tests de génération
* [ ] Intégrer la gestion de définition d'objet (INSERTS)
  - [ ] Script de génération PHP - Impacts
  - [ ] Mise à jour des Modèles SQL (Générique OBJS / OBJC)
* [ ] Implement Generic function to getPreviousObject in case of Complex
  - [ ] Impact Generic Complex Object Pattern
* [ ] Modèle Excel afin de faciliter la construction du fichier CSV.
  - [ ] Intégration de Ribbons Excel
  - [ ] Boutons ajout Objet
