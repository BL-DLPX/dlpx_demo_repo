#
# Restart Postgres Demo 2.0
#
systemctl restart docker
docker run --rm --detach --name app1_prod --env-file /root/postgres_demo/env.postgres -p 8001:5000/tcp -v /root/postgres_demo/postgres-model.yaml:/usr/src/app/models.yaml dcstolf/flask-app-postgres:latest
docker run --rm --detach --name app2_prod --env-file /root/postgres_demo/env.postgres2 -p 9001:5000/tcp -v /root/postgres_demo/postgres-model2.yaml:/usr/src/app/models.yaml dcstolf/flask-app-postgres:latest
docker run --rm --detach --name app1_mask --env-file /root/postgres_demo/env.postgres.mask -p 9000:5000/tcp -v /root/postgres_demo/postgres-model.yaml:/usr/src/app/models.yaml dcstolf/flask-app-postgres:latest
docker run --rm --detach --name app2_mask --env-file /root/postgres_demo/env.postgres2.mask -p 10000:5000/tcp -v /root/postgres_demo/postgres-model2.yaml:/usr/src/app/models.yaml dcstolf/flask-app-postgres:latest
docker ps
