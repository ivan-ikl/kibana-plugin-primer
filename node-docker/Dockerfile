FROM node:14.17.2

RUN cd /usr/share/ && \
    # Add user kibana and configure related access rights
    useradd -ms /bin/bash kibana && \
    mkdir /usr/share/kibana && \
    chown kibana:kibana /usr/share/kibana && \
    chown -R kibana:kibana /usr/local/lib/node_modules/ && \
    chown kibana:kibana /usr/local/bin/

USER kibana
WORKDIR /usr/share/
RUN git clone https://github.com/elastic/kibana.git --branch 7.13 --single-branch && \
    cd kibana && \
    # Bind Kibana to 0.0.0.0:5601
    echo "server.host: "\""0.0.0.0"\" >> ./config/kibana.yml && \
    # Specify Elasticsearch server
    echo "elasticsearch.hosts: ["\""http://elasticsearch-dev-env:9200"\""]" >> ./config/kibana.yml && \
    # Bootstrap Kibana
    yarn kbn bootstrap

WORKDIR /usr/share/kibana
ENTRYPOINT while true; do sleep 10000; done
