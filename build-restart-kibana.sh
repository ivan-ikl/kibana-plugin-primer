if [ "$1" == "" ]; then
    # Print usage instructions
    echo "Usage: $ ./build-restart-kibana.sh PLUGIN_FOLDER_NAME"
    exit 1
fi

if [ ! -d "plugins/$1" ]; then
    echo "Directory 'plugins/$1' does not exist!"
    exit 1
fi

PURPLE='\033[0;35m'
NO_COLOR='\033[0m'
timestamp() {
    date +"%Y-%m-%d_%H-%M-%S"
}

# Stop Kibana
docker-compose restart kibana-dev-env

# Compile plugin for version 7 (echo) and start Kibana
echo "Running plugin build and logging outputs to 'kibana-logs/yarn*'..."

docker-compose exec kibana-dev-env bash -c "
    cd plugins/$1/ &&
    yarn kbn bootstrap > /usr/share/kibana-logs/yarn-bootstrap-$1.log &&
    echo 7 | yarn plugin-helpers build > /usr/share/kibana-logs/yarn-build-$1.log"
error_code=$?

if [ "$error_code" != "0" ]; then
    echo "Plugin build failed!"
    echo -e "\n*** Yarn kbn bootstrap log ***"
    cat "kibana-logs/yarn-bootstrap-$1.log"
    echo -e "\n*** Yarn build log ***"
    cat "kibana-logs/yarn-build-$1.log"
else
    echo "Plugin build succeeded!"
    echo "Starting Kibana in background..."
    docker-compose exec -d kibana-dev-env bash -c "
        yarn start >> /usr/share/kibana-logs/$(timestamp).log"
fi
