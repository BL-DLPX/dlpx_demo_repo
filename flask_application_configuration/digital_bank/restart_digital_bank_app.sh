#!/bin/bash
#
# start Digital Bank Demo 2.0 application
#
systemctl restart docker
docker compose -f /root/digital_bank/prod/compose_prod.yaml up -d
docker compose -f /root/digital_bank/dev/compose_dev.yaml up -d
docker compose -f /root/digital_bank/qa/compose_qa.yaml up -d
docker compose -f /root/digital_bank/mask/compose_mask.yaml up -d
docker ps
