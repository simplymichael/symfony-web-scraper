## Prerequisites 
- Docker 
- Docker compose 
- Copy `.env.example` to `.env` and edit it: `cp .evn.example .env && vi .env`

## Running 
- Run `docker-compose up -d --build`

### Administration 
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

## Code
The application's code is located inside the */app/public/* directory. 
Here you can make changes to the app.