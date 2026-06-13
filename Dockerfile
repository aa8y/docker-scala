ARG JDK_VERSION=21
FROM aa8y/core:jdk${JDK_VERSION}

ARG SCALA_VERSION=3.8.4
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
# Both Scala 2.x and 3.x ship on GitHub releases. They live in separate repos
# with different tag-name and archive-name conventions: scala/scala uses
# `vX.Y.Z` / `scala-X.Y.Z.tgz`, scala/scala3 uses `X.Y.Z` / `scala3-X.Y.Z.tar.gz`.
# (downloads.lightbend.com stopped getting new 2.x releases around 2.12.20 /
# 2.13.16, so we route everything through GitHub.)
RUN apk add --no-cache --update wget && \
    mkdir -p /opt/scala/bin && \
    cd /opt && \
    case "${SCALA_VERSION}" in \
      3.*) SCALA_URL="https://github.com/scala/scala3/releases/download/${SCALA_VERSION}/scala3-${SCALA_VERSION}.tar.gz" ;; \
      *)   SCALA_URL="https://github.com/scala/scala/releases/download/v${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" ;; \
    esac && \
    wget -q -O- --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 0 \
      "${SCALA_URL}" | \
      tar -xz --strip 1 -C /opt/scala/ && \
    ln -s /opt/scala/bin/scala /bin/scala && \
    ln -s /opt/scala/bin/scalac /bin/scalac && \
    ln -s "/opt/scala/bin/${SCALA_BIN}" /usr/local/bin/scala-entrypoint && \
    apk del --purge wget && \
    rm -rf /var/cache/apk/*
USER docker

ENTRYPOINT ["/usr/local/bin/scala-entrypoint"]
