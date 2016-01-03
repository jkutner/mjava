# mjava

A small Java launcher. This binary knows how to find a JVM installed on any machine, even
if `JAVA_HOME` is not set.

## Goal of this project

Eventually, this tool will be able to download an install the JVM if it cannot be found on the system.

## Building

```
$ docker-compose build
$ docker-compose run compile
```

## Testing

```
$ docker-compose run mtest
```
