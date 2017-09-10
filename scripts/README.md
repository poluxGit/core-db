# Scripts directory

## Project Organization

#### Worskspace Items
- **scripts**
-- work-in_progress : ***Generic Script in developpement***
-- releases : ***Released scripts***
- cmd-release-script.sh : ***Shell Script releasing SQL scripts***


#### Shell Script - SQL Scripts Packaging

```bash
./cmd-release-script.sh <TARGET_SCHEMA> <MajorVersion> <MinorVersion>
```

#### Internal Releasing process
1. Identify and concatenate SQL files from 'WorkInProgressFolder'
2. Subsitute TARGET SCHEMA NAME into SQL Main script files
