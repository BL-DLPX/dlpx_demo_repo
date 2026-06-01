#!/bin/bash
#
# initialize Postgres Liquibase Demo 2.0 application - database001
#
# prepares database001 tables (drop/create)
docker run --rm --env-file /root/postgres_liquibase_demo/env.postgres -p 8001:5000/tcp -v /root/postgres_liquibase_demo/postgres-model.yaml:/usr/src/app/models.yaml dcstolf/flask-app-postgres:latest migrations_seed.py
#
# loads database001 tables with fake data
#
docker run --rm --env-file /root/postgres_liquibase_demo/env.postgres -p 8001:5000/tcp -v /root/postgres_liquibase_demo/postgres-model.yaml:/usr/src/app/models.yaml dcstolf/flask-app-postgres:latest migrations_faker.py

