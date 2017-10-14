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
