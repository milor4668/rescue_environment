FROM debian:bookworm

RUN apt -y update && apt -y upgrade
RUN apt -y install apt-mirror rsync

COPY mirror.list /etc/apt/mirror.list

ENTRYPOINT ["/usr/bin/apt-mirror"]

