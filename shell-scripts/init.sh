#!/bin/bash

chmod 777 /usr/shell-scripts

/usr/shell-scripts/composer-install.sh 
/usr/shell-scripts/create-cron-job.sh &
php-fpm
