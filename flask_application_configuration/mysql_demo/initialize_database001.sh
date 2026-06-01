#!/bin/bash
#
# prepares database001 tables (drop/create)
#
docker run --rm --env-file /root/mysql_demo/env.mysql -p 8001:5000/tcp -v /root/mysql_demo/mysql-model.yaml:/usr/src/app/models.yaml dcstolf/flask-app-mysql:latest migrations_seed.py
#
# loads database001 tables with fake data
#
docker run --rm --env-file /root/mysql_demo/env.mysql -p 8001:5000/tcp -v /root/mysql_demo/mysql-model.yaml:/usr/src/app/models.yaml dcstolf/flask-app-mysql:latest migrations_faker.py

