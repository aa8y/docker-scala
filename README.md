# Docker Scala

[Scala](http://www.scala-lang.org/) is a JVM-based programming language which marries the functional and object oriented programming paradigms. It is mainly known for its use in the [Play](https://www.playframework.com/) and [Spark](http://spark.apache.org/) frameworks. This is a Docker image for Scala based on Alpine to get as small an image footprint as possible. Honestly, I don't expect anyone to use this (or any other Scala) image as a base for another image. This image just exists to provide an easy entry into the [Scala REPL](https://docs.scala-lang.org/overviews/repl/overview.html) without having to install it locally.

## Tags

I would guarantee tags for the latest and the previous patch release in a minor release (along with the minor release as a tag). What that means that for the `2.11` minor release, we would have `2.11.8` and `2.11.11` and `2.11` as tags. `latest` will _always_ point to the latest Scala release. See the `manifest.yml` file for more information on the tags.

## Usage

You can run the REPL for the _latest_ Scala version using.
```
docker run --rm -it aa8y/scala
```
For an older/specific version use.
```
docker run --rm -it aa8y/scala:2.11.11
```
For running an interactive shell within the container, use this command and specify the required version. You might want to do this when you want to use the Scala compiler, `scalac`.
```
docker run --rm -it --entrypoint /bin/bash aa8y/scala:2.10
```
