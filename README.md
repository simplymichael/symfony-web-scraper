## Prerequisites 
- Docker 
- Docker compose 
- Copy `.env.example` to `.env` and edit the `.env` file.
- Edit the *app/resources/sources.json* file and add any news sources you wish to scrape data from.

## Running 
- **First run:** Run `docker-compose up -d --build`.
  This command will run `composer install` to install the project's dependencies.
  So, it will take some time before the app is available. 

  You can follow the logs by running `docker-compose logs -f php`.
- **Subsequent runs:** Run `docker-compose up -d`
- Navigate to *http://localhost:<APP_PORT>* where <APP_PORT> is the PORT value set in the *.env* file.


## Working With The Application 

### Adding News Sources 
There are two ways to add resources: 
- Via the *app/resources/sources.json*.  This is the default method of adding a resource.
  The news resources in this file are processed asynchronously via the CLI.
  The CLI command is run as a cron job. 
  You can configure the cron schedule inside the *.env* file. 
  The default schedule is every minute (`* * * * *`).
- Add resources via the web interface. 
  These are processed synchronously via the web interface. 
  This was implemented when I was fleshing out the feature. 
  Anyway, I decided to leave it in place.
  Now I prefer to think of it as just a convenience 
  that allows us to add a resource and process and parse it 
  without waiting for the cron schedule timer to come around.

### Exceptions 
The app currently cannot read news from Single Page Applications (SPAs). 
I am currently having issues installing and setting up the chrome driver and browser 
needed by the `symphony/panther` client which is able to work with SPAs. 
I currently settled for the Goutte client instead, which works with non-SPA pages.
I am still working on getting the Panther client working, however, and I can submit an updated version 
when it is done, if I am asked to.

### App Users 
The app implements three authentication account details configurable via the *.env* file. 
- **ADMIN**: This is an administrator account. It can view and delete downloaded news.
- **MODERATOR**: This is a moderator account. It can view, but cannot delete, downloaded news.
- **USER**: This is a non-privileged user account. It cannot not view nor delete downloaded news. 
  In development mode, Symfony shows the big exception page when the **USER** account tries to 
  view downloaded news. To view a properly themed error page, run the app in production mode. 

### Container and Service Administration 
- To log into any container, run: 
  `docker exec -it <APP_NAME>_<SERVICE_NAME> bash` . 
- To view the logs of any service, maybe for troubleshooting purposes, run: 
  `docker-compose logs -f <SERVICE_NAME>`.

Here, 
- *<APP_NAME>* is the name of the containers as specified inside the `.env` file.
- *<SERVICE_NAME>* is the name of the service. The following services are available: 
    - **php**
    - **nginx**
    - **mysql**
    - **rabbitmq**
  
For example, assuming the <APP_NAME> is **appcake**, 
- to log into the **php** container service, run: `docker exec -it appcake_php bash`.
- to view the logs of the **nginx** service, run: `docker-compose logs -f nginx`.
