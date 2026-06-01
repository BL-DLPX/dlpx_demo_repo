#!/bin/bash
#
# shutdown Digital Bank Demo 2.0 application
#
docker compose -f /root/digital_bank/prod/compose_prod.yaml down
docker compose -f /root/digital_bank/dev/compose_dev.yaml down
docker compose -f /root/digital_bank/qa/compose_qa.yaml down
docker compose -f /root/digital_bank/mask/compose_mask.yaml down
docker ps
