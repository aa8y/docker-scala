# Docker Scala

[![CI](https://github.com/aa8y/docker-scala/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/aa8y/docker-scala/actions/workflows/ci.yml)

[Scala](http://www.scala-lang.org/) is a JVM-based programming language which marries the functional and object oriented programming paradigms. It is mainly known for its use in the [Play](https://www.playframework.com/) and [Spark](http://spark.apache.org/) frameworks. This is a Docker image for Scala based on Alpine to get as small an image footprint as possible. Honestly, I don't expect anyone to use this (or any other Scala) image as a base for another image. This image just exists to provide an easy entry into the [Scala REPL](https://docs.scala-lang.org/overviews/repl/overview.html) without having to install it locally.

## Tags

Only the latest patch release of each supported minor line is published.
`latest` tracks the newest stable; `lts` tracks the current LTS line.

| Tag      | Scala version | JDK   | Entrypoint    |
|----------|---------------|-------|---------------|
| `2.10`   | 2.10.7        | 8     | `/bin/scalac` |
| `2.11`   | 2.11.12       | 8     | `/bin/scala`  |
| `2.12`   | 2.12.21       | 21    | `/bin/scala`  |
| `2.13`   | 2.13.18       | 21    | `/bin/scala`  |
| `3.3`    | 3.3.8         | 21    | `/bin/scala`  |
| `3.8`    | 3.8.4         | 21    | `/bin/scala`  |
| `lts`    | 3.3.8         | 21    | `/bin/scala`  |
| `latest` | 3.8.4         | 21    | `/bin/scala`  |

Scala 2.10 and 2.11 are pinned to JDK 8 because those Scala versions predate
the JDK 9 module system and don't run on newer JDKs. The `2.10` image's
entrypoint is `scalac` because the REPL is broken in that build. See
`manifest.yml` for the full matrix.

## Usage

You can run the REPL for the _latest_ Scala version using.
```
docker run --rm -it aa8y/scala
```
For an older/specific minor use.
```
docker run --rm -it aa8y/scala:2.11
```
For running an interactive shell within the container, use this command and specify the required version. You might want to do this when you want to use the Scala compiler, `scalac`.
```
docker run --rm -it --entrypoint /bin/bash aa8y/scala:2.10
```

## Testing

Image tests are defined as [container-structure-test][cst] configs under
`test/config/` — a shared `common.yaml` plus one file per minor version. The
configs to apply per tag are declared in `manifest.yml` under `structureTest:`
and run natively by `dave structure-test`:

```sh
brew install container-structure-test     # one-time

dave build
dave structure-test
```

CI runs the same commands; see `.github/workflows/ci.yml`.

[cst]: https://github.com/GoogleContainerTools/container-structure-test
