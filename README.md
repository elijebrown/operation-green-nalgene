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
Access Control (ACL) breaks pg_dump for some reason, so exclude. (you will have to re-add)
Consequently, it makes sense to also remove ownership restrictions on the data (not sensitive data anyway)

pg_dump narcos --verbose -U pablo_escobar_gaviria -W --no-acl --no-owner -f /tmp/backupDatabase.sql

APyRnWxbJu7JB#

docker cp database:/tmp/backupDatabase.sql ./backupDatabase.sql

