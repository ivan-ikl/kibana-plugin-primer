FROM node:16.18.1

RUN useradd -ms /bin/bash kibana && \
    mkdir /usr/share/kibana && \
    mkdir /usr/share/kibana-logs && \
    mkdir /usr/share/staging

RUN cd /usr/share/ && \
    # Add user kibana and configure related access rights
    chown kibana:kibana /usr/share/kibana && \
    chown -R kibana:kibana /usr/local/lib/node_modules/ && \
    chown kibana:kibana /usr/local/bin/ & \
    chown kibana:kibana /usr/share/kibana-logs & \
    chown kibana:kibana /usr/share/staging

USER kibana
WORKDIR /usr/share/
RUN git clone https://github.com/elastic/kibana.git --branch v8.6.0 --single-branch

USER root
RUN chown -R kibana:kibana /usr/local/lib/node_modules/ && \
    chown -R kibana:kibana /usr/local/bin/

USER kibana

RUN cd kibana && \
    # Bind Kibana to 0.0.0.0:5601
    echo "server.host: "\""0.0.0.0"\" >> ./config/kibana.yml && \
    # Specify Elasticsearch server
    echo "elasticsearch.hosts: ["\""http://elasticsearch-dev-env:9200"\""]" >> ./config/kibana.yml && \
    # Bootstrap Kibana
    yarn kbn bootstrap

WORKDIR /usr/share/kibana
ENTRYPOINT while true; do sleep 10000; done
