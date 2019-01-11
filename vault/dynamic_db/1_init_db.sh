. env.sh

#docker pull postgres
docker rm postgres &> /dev/null
docker run \
  --name postgres \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=${DB_ADMIN_PW}  \
  -v /Users/jake/git/demos/vault/dynamic_database/sql:/docker-entrypoint-initdb.d \
  -d postgres


#docker pull dpage/pgadmin4
docker rm pgadmin4 &> /dev/null
docker run  \
  -p 8888:80 \
  --name pgadmin4 \
  -e "PGADMIN_DEFAULT_EMAIL=jlundberg@hashicorp.com" \
  -e "PGADMIN_DEFAULT_PASSWORD=${DB_ADMIN_PW}" \
  -d dpage/pgadmin4
