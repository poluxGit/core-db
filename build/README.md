
# Builds Commands and Stuffs

#### Dockers MySQL Server running ...

```bash

docker run --name mysql-dev-coredev01 -p 8806:3306 -e MYSQL_ROOT_PASSWORD=polux -e MYSQL_DATABASE=COREDEV01 -v F:\_dockers\_shared-dirs\mysql-coredev01:/var/lib/mysql -d mysql:5.7

```
