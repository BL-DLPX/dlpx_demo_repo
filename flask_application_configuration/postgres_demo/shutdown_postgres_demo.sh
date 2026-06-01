#!/bin/bash
#
# shutdown Postgres Demo 2.0 application
#
docker stop app1_prod
docker stop app2_prod
docker stop app1_mask
docker stop app2_mask
docker ps
