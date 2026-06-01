#
# Restart Postgres Liquibase Demo 2.0
#
systemctl restart docker
docker run --rm --detach --name app1_prod --env-file /root/postgres_liquibase_demo/env.postgres -p 8001:5000/tcp -v /root/postgres_liquibase_demo/postgres-model.yaml:/usr/src/app/models.yaml dcstolf/flask-app-postgres:latest
docker ps
