#!/bin/bash
#
# initialize Postgres Demo 2.0 application - database002
#
# prepares database002 tables (drop/create)
docker run --rm --env-file /root/postgres_demo/env.postgres2 -p 9001:5000/tcp -v /root/postgres_demo/postgres-model2.yaml:/usr/src/app/models.yaml dcstolf/flask-app-postgres:latest migrations_seed.py
#
# loads database002 tables with fake data
#
docker run --rm --env-file /root/postgres_demo/env.postgres2 -p 9001:5000/tcp -v /root/postgres_demo/postgres-model2.yaml:/usr/src/app/models.yaml dcstolf/flask-app-postgres:latest migrations_faker.py

