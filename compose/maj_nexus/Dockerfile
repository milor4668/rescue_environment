FROM debian:bookworm

RUN apt -y update && apt -y upgrade
RUN apt -y install curl

COPY debian_bookworm.sources /debian_bookworm.sources
COPY maj_nexus.sh /maj_nexus.sh
COPY create_debian.json /create_debian.json
COPY update_debian.json /update_debian.json
COPY ftpsync.conf /ftpsync.conf
RUN chmod +x /maj_nexus.sh
