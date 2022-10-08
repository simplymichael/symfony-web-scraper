#!/bin/bash

## Install dependencies
echo "Running `composer install`"
composer install


## Install and verify browser client drivers used by symfony/panther
echo "Running `bdi detect drivers`"
vendor/bin/bdi detect drivers


## Setup the database 

### We don't need to recreate the database, 
### since docker-compose does that already. 
### /usr/local/bin/php bin/console doctrine:database:create
/usr/local/bin/php bin/console doctrine:migrations:migrate