#!/bin/bash


## Symfony will need to `git init` during setup.
## If we don't set the git user's name and email, 
## Symfony will exit with an error.
git config --global user.name "${GIT_USER_NAME} " && \
git config --global user.email "${GIT_USER_EMAIL}"


APP_DIR=/var/www/symfony_docker
VENDOR_DIR="${APP_DIR}/vendor"


## Install dependencies 
## But only if this is the first run
if [ ! -d ${VENDOR_DIR} ]; then
	echo "Running 'composer install'"
    composer install
fi


## Install and verify browser client drivers used by symfony/panther
#echo "Running 'bdi driver:chromedriver' to install Chrome driver"
#vendor/bin/bdi detect drivers
#vendor/bin/bdi driver:chromedriver
#cp ./chromedriver /usr/local/bin/chromedriver


## Setup the database 

### We don't need to recreate the database, 
### since docker-compose does that already. 
### /usr/local/bin/php bin/console doctrine:database:create
/usr/local/bin/php bin/console doctrine:migrations:migrate
