#!/bin/bash
#
# prepares database001 tables (drop/create)
#
docker run --rm --env-file /root/oracle_demo/env.oracle -p 8001:5000/tcp -v /root/oracle_demo/oracle-model.yaml:/usr/src/app/models.yaml dcstolf/flask-app-oracle:latest migrations_seed.py
#
# loads database001 tables with fake data
#
docker run --rm --env-file /root/oracle_demo/env.oracle -p 8001:5000/tcp -v /root/oracle_demo/oracle-model.yaml:/usr/src/app/models.yaml dcstolf/flask-app-oracle:latest migrations_faker.py

