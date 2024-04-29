ARG APP_VERSION

ARG UBUNTU_VERSION=20.04

FROM ubuntu:${UBUNTU_VERSION}

RUN  apt update && apt -y install docker.io rsync

ENV TZ Europe/Amsterdam 

ENV XSOAR_VERSION=$APP_VERSION

RUN DEBIAN_FRONTEND=noninteractive TZ=Europe/Amsterdam apt-get -y install tzdata


COPY demistoserver-6.12-493375.sh  /tmp/

RUN chmod +x /tmp/demistoserver-6.12-493375.sh   
RUN /tmp/demistoserver-6.12-493375.sh  -- -y  -do-not-start-server  \
    && /tmp/demistoserver-6.12-493375.sh -- -y --purge

RUN groupadd -r demisto && useradd -r -g demisto demisto
