# Symfony Web Scraper 
A simple news and blog URL scraper and parser.

## Tech Stack 
- Docker-compose
- Symfony 5.4
- Php 7.4
- Mysql 5.7
- Bootstrap 5.1
- RabbitMQ: 3.10


## Features 
- Crawl, parse and save a news or blog URL post for the following fields 
    - title 
    - description 
    - image/picture 
- No duplicates allowed. If article already exists in the DB, the last crawl date is updated.
- Parsing is done asynchronously using a message queue (RabbitMQ)
- Parsing is scheduled via cron
- Available pages 
    - **Home page:** 
    - **Login page:**
    - **Add News Source:** A page that provides a web-interface for adding a new blog or news source
    - **View Existing News Sources:** A page for viewing previously crawled, 
      parsed and saved blog or news sources.
    - **View Fetched Posts:** A page for viewing a paginated display of crawled and parsed articles 
      each with a title, description and image.
- User authentication and authorization.
  In dev mode, access denied errors are shown as thrown errors in a stack-trace format. 
  To view a UI-friendly error, 
  run the app in production mode by setting the `APP_ENV` variable value to `production` inside the `.env` file.
- User authorization levels: 
    - User: Cannot really do much
    - Moderator: Can view the paginated listing of crawled pages 
    - Admin: Has moderator access. In addition, an admin can delete an already saved article.


## Running 
### Prerequisites 
- [Docker][docker] 
- [Docker compose][compose] 
- Copy `.env.example` to `.env` and edit the `.env` file.
- Edit the *app/resources/sources.json* file and add any news sources you wish to scrape data from.
- On Windows, 
  check that every file in the *./shell-scripts/* sub-directory ends with Unix-style (`LF`) line-endings.

- **First run:** Run `docker-compose up -d --build`.
  This command will run `composer install` to install the project's dependencies.
  So, it will take some time before the app is available. 

  You can follow the logs by running `docker-compose logs -f php`.
- **Subsequent runs:** Run `docker-compose up -d`
- Navigate to *http://localhost:<APP_PORT>* where <APP_PORT> is the PORT value set in the *.env* file.


## Working With The Application 

### App Users 
The app currently implements three authentication account details configurable via the *.env* file. 
- **ADMIN**: This is an administrator account. It can view and delete downloaded news.
- **MODERATOR**: This is a moderator account. It can view, but cannot delete, downloaded news.
- **USER**: This is a non-privileged user account. It cannot not view nor delete downloaded news. 
  In development mode, Symfony shows the big exception page when the **USER** account tries to 
  view downloaded news. To view a properly themed error page, run the app in production mode. 

### Adding URL Sources 
There are two ways to add URL resources: 
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
I currently settled for the Goutte (`fabpot/goutte`) client instead, which works with non-SPA pages.
I am still working on getting the Panther client working.

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
  
For example, assuming the <APP_NAME> is **testapp**, 
- to log into the **php** container service, run: `docker exec -it testapp_php bash`.
- to view the logs of the **nginx** service, run: `docker-compose logs -f nginx`.










[docker]: https://www.docker.com/
[compose]: https://docs.docker.com/compose/