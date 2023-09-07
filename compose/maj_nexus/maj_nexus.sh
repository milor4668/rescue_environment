#!/bin/bash

IP="nexus"
PORT="8081"
USERNAME="admin"
PASSWORD=$(cat /nexus-data/admin.password)

while (true); do
    curl -Is http://${IP}:${PORT}/ |head -n 1 | grep "HTTP/1.1 200 OK"
    if [ $? -eq 0 ]; then
        break
    fi
    sleep 10
done

curl -u ${USERNAME}:${PASSWORD} -X POST "http://${IP}:${PORT}/service/rest/v1/repositories/apt/proxy" -H "Content-Type: application/json" -d @create_debian.json

mv /debian_bookworm.sources /etc/apt/sources.list.d/debian.sources
apt update -y 
