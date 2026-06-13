FROM aa8y/core:jdk8

ARG SCALA_VERSION=2.12.8
# SCALA_BIN selects the entrypoint binary. 2.10's REPL is broken in this build,
# so the 2.10 tag is built with SCALA_BIN=scalac; see manifest.yml.
ARG SCALA_BIN=scala

LABEL org.opencontainers.image.authors="https://github.com/aa8y" \
      org.opencontainers.image.description="Scala REPL image based on aa8y/core (Alpine)." \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/aa8y/docker-scala" \
      org.opencontainers.image.title="aa8y/scala" \
      org.opencontainers.image.url="https://hub.docker.com/r/aa8y/scala" \
      org.opencontainers.image.vendor="https://github.com/aa8y"

USER root
RUN apk add --no-cache --update wget && \
    mkdir -p /opt/scala/bin && \
    cd /opt && \
    wget -q -O- --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 \
      "https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" | \
      tar -xz --strip 1 -C /opt/scala/ && \
    ln -s /opt/scala/bin/scala /bin/scala && \
    ln -s /opt/scala/bin/scalac /bin/scalac && \
    ln -s "/opt/scala/bin/${SCALA_BIN}" /usr/local/bin/scala-entrypoint && \
    apk del --purge wget && \
    rm -rf /var/cache/apk/*
USER docker

ENTRYPOINT ["/usr/local/bin/scala-entrypoint"]
