#
# Restart Oracle Flask Demo 2.0
#
systemctl restart docker
docker run --rm --detach --name app1_prod --env-file /root/oracle_demo/env.oracle -p 8001:5000/tcp -v /root/oracle_demo/oracle-model.yaml:/usr/src/app/models.yaml dcstolf/flask-app-oracle:latest
docker run --rm --detach --name app1_mask --env-file /root/oracle_demo/env.oracle.mask -p 9000:5000/tcp -v /root/oracle_demo/oracle-model.yaml:/usr/src/app/models.yaml dcstolf/flask-app-oracle:latest
docker ps
