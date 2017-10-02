# SQL Scripts directory

## Project Organization

#### Worskspace Directories

|Directory name|Comment|
|--------------|-------|
|business-models   | Business Models related patterns.   |
|releases   |  Released SQL Scripts.  |
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
* [ ] Implement Generic function to getPreviousObject in case of Complex
  - [ ] Impact Generic Complex Object Pattern
* [ ] Add View defintion SQL for Object
  - [ ] From CSV file attrobj ? Complex/Simple ?
  - [ ] From CSV file attrlnk ? Complex/Simple ?
  - [ ] Find a way to auto-update view definition (triggers on CORE_ATTRDEFS)

#### TODO List - To plan
* [ ] NewTask
