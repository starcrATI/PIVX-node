FROM ghcr.io/linuxserver/baseimage-ubuntu:focal

ENV PIVX_VERSION=5.0.1
ENV PIVX_URL=https://github.com/PIVX-Project/PIVX/releases/download/v${PIVX_VERSION}/pivx-${PIVX_VERSION}-x86_64-linux-gnu.tar.gz
LABEL maintainer="starcrATI <github@solmorrow.com>"

ARG DEBIAN_FRONTEND="noninteractive"

RUN \
    set -x; \
    apt-get update && \
    apt-get full-upgrade -y --no-show-upgraded && \
    apt-get install -y --no-install-recommends wget pwgen ca-certificates

RUN \
    set -x; \
    /usr/bin/wget --progress=dot:giga $PIVX_URL -O /app/pivx.tar.gz && \
    /bin/tar xf /app/pivx.tar.gz --directory /app/ && \
    rm /app/pivx.tar.gz

COPY root/ /

EXPOSE 51472 51473 51475
VOLUME /data
