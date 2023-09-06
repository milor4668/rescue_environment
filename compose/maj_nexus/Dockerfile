FROM debian:trixie

RUN apt -y update && apt -y upgrade

RUN apt -y install curl apt-mirror

COPY maj_debian12.sh /maj_debian12.sh
COPY apt-debian.json /apt-debian.json
COPY mirror.list /etc/apt/mirror.list
RUN chmod +x /maj_debian12.sh
