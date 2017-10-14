### Env. de développement - MySQL/PHP-5.6/Apache 2.4

**Nom Env.** : *env-dev_01*


#### Dépendances:

- **db** : [Official MySQL Docker *Tag:5.7*](https://hub.docker.com/_/mysql/)
- **web** : [PHP 5.6 Dev Services *Tag:5.6*](https://hub.docker.com/r/webdevops/php-apache-dev/)


## docker-compose.yml

```yaml
version: '2'
services:
  db:
    image: mysql:5.7
    volumes:
      - LOCALPATH_DATAINTERNALBASE:/varl/lib/mysql
    ports:
      - 8800:3306
    environment:
      MYSQL_ROOT_PASSWORD: dev
      MYSQL_DATABASE: COREDEV01
  web:
    image: webdevops/php-apache-dev:5.6
    volumes:
      - LOCALPATH_APPLICATION:/app
    ports:
      - 5000:80
    depends_on:
      - db


```

[`Fichier source`](./docker-compose.yml)
