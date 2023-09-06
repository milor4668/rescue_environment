FROM debian:trixie

RUN apt -y update && apt -y upgrade

RUN apt -y install curl

COPY maj_debian12.sh /maj_debian12.sh
COPY apt-debian.json /apt-debian.json
RUN chmod +x /maj_debian12.sh
