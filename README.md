# kibana-plugin-primer

This repository contains resources that set up a Kibana 7.13 plugin development environment. The environment includes a Docker image with Kibana, and starts an Elasticsearch instance using docker-compose. Docker image is built seperately from docker-compose to enable its usage in other scenarios.

Plugins can be developed inside the plugins folder, that gets mapped inside the Kibana Docker container. For additional information regarding plugin development, please visit [Kibana Plugin Resources](https://www.elastic.co/guide/en/kibana/current/development-plugin-resources.html)

Building the Docker image:
```console
$ cd node-docker
$ docker build ./ --tag ivan-ikl/kibana-dev-env:latest
```

Running the environment:
```console
$ docker-compose up
```

Connecting to the environment:
```console
$ docker-compose exec kibana-dev-env bash
```

## Volumes

Docker-compose mapps three folders as volumes inside the kibana-dev-env container:

* _plugins_, mapped as /usr/share/kibana/plugins, can be used to develop and compile plugins
* _staging_, mapped as /usr/share/staging, can be used to include files and folders that are excluded from Kibana build
* _kibana-logs_ mapped as /usr/share/kibana-logs, can be used to store logs inside the container

## Included build script

This repository also includes a build automation script that restarts the Kibana container and builds the target plugin. The script can be invoked in the following manner:

```console
$ ./build-restart-kibana.sh PLUGIN_FOLDER_NAME
```

## Final remarks

Please ensure that the user kibana inside the kibana-dev-env container has write access to folders plugins, staging, and  directory, as lack of it could cause errors during plugin development.
