FROM openjdk:8-jdk-alpine

MAINTAINER Arun Allamsetty <arun.allamsetty@gmail.com>

RUN apk add --no-cache --update bash && \
    rm -rf /var/cache/apk/*

ARG SCALA_VERSION=2.12.3

RUN apk add --no-cache --update wget && \
    mkdir -p /opt/scala/bin && \
    cd /opt && \
    wget -q -O- --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 \
      "https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" | \
      tar -xz --strip 1 -C /opt/scala/ && \
    ln -s /opt/scala/bin/scala /bin/scala && \
    ln -s /opt/scala/bin/scalac /bin/scalac && \
    apk del --purge wget && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/bin/bash"]
