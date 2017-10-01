# Scripts directory

## Project Organization

#### Worskspace Items

|Directory name|Comment|
|--------------|-------|
|_old   | Old scripts (out of GIT sync).   |
|_tmp   |  Temporary  SQL scripts and data.  |
|bash_cmd   | BASH scripts.   |
|db_deploy   | All deployement scripts generated.   |
| releases  | Releases directory.   |
|generic-business-modles-pattern   | Generic Business Objects Pattern.   |
|wip   | Work in progress.   | 
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
