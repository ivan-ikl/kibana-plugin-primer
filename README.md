# kibana-plugin-primer

This repository contains resources that set up a Kibana 7.13.5 plugin development environment. The environment includes a Docker image with Kibana, and starts an Elasticsearch instance using docker-compose. Docker image is built seperately from docker-compose to enable its usage in other scenarios.

Plugins can be developed inside the plugins folder, that gets mapped inside the Kibana Docker container. For additional information regarding plugin development, please visit [Kibana Plugin Resources](https://www.elastic.co/guide/en/kibana/current/development-plugin-resources.html)

Building the Docker image:
```bash
cd node-docker
docker build ./ --tag ivan-ikl/kibana-dev-env:latest
```

Running the environment:
```
docker-compose up
```

Connecting to the environment:
```
docker-compose exec kibana-dev-env bash
```
