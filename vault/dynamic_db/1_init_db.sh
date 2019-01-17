. env.sh

#docker pull postgres
docker rm postgres &> /dev/null
docker run \
  --name postgres \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=${DB_ADMIN_PW}  \
  -v ${PWD}/sql:/docker-entrypoint-initdb.d \
  -d postgres


#docker pull dpage/pgadmin4
docker rm pgadmin4 &> /dev/null
docker run  \
  -p 8888:80 \
  --name pgadmin4 \
  -e "PGADMIN_DEFAULT_EMAIL=jlundberg@hashicorp.com" \
  -e "PGADMIN_DEFAULT_PASSWORD=${DB_ADMIN_PW}" \
  -d dpage/pgadmin4


echo "Connect to http://${DB_HOST}:8888 for the pgadmin web UI"

echo "Database is running on ${DB_HOST}:5432"
