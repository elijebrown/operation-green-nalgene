### Docker / Environment Info:
- using docker-compose
- seperate containers for each process
- --watch flag is needed to live update (AKA hot reload) the containers
- seperate node_modules for each process, since they are in seperate docker containers anyway
- launch command: docker-compose up --watch 
  - -d (daemon) to run in background
  - --build to rebuild the containers

### Shelling into DB
docker exec -it database psql -U pablo_escobar_gaviria -d narcos -W
APyRnWxbJu7JB#

### Backing up the Database with Pg_dump
docker exec -e PGPASSWORD='APyRnWxbJu7JB#' database pg_dump -U pablo_escobar_gaviria --verbose --no-acl --no-owner narcos > backupDatabase.sql

### Restoring the Database
docker exec -e PGPASSWORD='APyRnWxbJu7JB#' \
  -i database psql -U pablo_escobar_gaviria -d narcos \
  < backupDatabase.sql

