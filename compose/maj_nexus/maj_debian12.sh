#!/bin/bash

IP="nexus"
PORT="8081"
USERNAME="admin"
PASSWORD="q3urmyZiZKXSKtM"

curl -u ${USERNAME}:${PASSWORD} -X POST "http://${IP}:${PORT}/service/rest/v1/repositories/apt/proxy" -H "Content-Type: application/json" -d @create_debian.json

#curl -u ${USERNAME}:${PASSWORD} -X PUT "http://${IP}:${PORT}/service/rest/v1/repositories/apt/proxy" -H "Content-Type: application/json" -d @update_debian.json

