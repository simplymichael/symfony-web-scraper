#!/bin/bash

chmod 777 /usr/shell-scripts

#sudo su

## Wait for the (Symfony) app to be ready 
until $(curl --output /dev/null --silent --head --fail http://nginx:80/login); do
    printf '.'
    sleep 5
done

## Cron uses the environment variables defined inside the symfony app 
## So overwrite the values there with our set values  
## to prevent errors caused by invalid or missing env variable values.
## cron runs with a mostly empty environment,
## so it's almost as if Symfony exports its own .env file to cron: 
## See this SO answer to get an idea why: https://stackoverflow.com/a/53641735/1743192
echo "APP_ENV=${APP_ENV} 
DATABASE_URL=\"${DATABASE_URL}\" 
MESSENGER_TRANSPORT_DSN=\"${MESSENGER_TRANSPORT_DSN}\"
" >> /var/www/symfony_docker/.env 

echo "${CRON_SCHEDULE} /bin/bash /usr/shell-scripts/run-news-parser.sh >> /var/log/cron.log 2>&1" >> /etc/cron.d/parser_cron

crontab /etc/cron.d/parser_cron

## Run cron and supervisord
cron &
supervisord &