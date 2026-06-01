#
# Restart MySQL Flask Demo 2.0
#
systemctl restart docker
docker run --rm --detach --name app1_prod --env-file /root/mysql_demo/env.mysql -p 8001:5000/tcp -v /root/mysql_demo/mysql-model.yaml:/usr/src/app/models.yaml dcstolf/flask-app-mysql:latest
docker run --rm --detach --name app1_mask --env-file /root/mysql_demo/env.mysql.mask -p 9000:5000/tcp -v /root/mysql_demo/mysql-model.yaml:/usr/src/app/models.yaml dcstolf/flask-app-mysql:latest
docker ps
