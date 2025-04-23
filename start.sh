#!/bin/bash

SCRIPT_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# create the network
docker network create foodtrucks-net

docker run -d --name es --net foodtrucks-net \
    -e "discovery.type=single-node" \
    docker.elastic.co/elasticsearch/elasticsearch:6.3.2

# start the flask app backend container
docker run -d --net foodtrucks-net --name foodtrucks-backend ft-backend
docker run -d --net foodtrucks-net --name foodtrucks-frontend ft-frontend

# start the proxy
docker run -d --net foodtrucks-net --publish 8080:80 \
    -v ${SCRIPT_PATH}/proxy/default.conf:/etc/nginx/conf.d/default.conf \
    --name foodtrucks-proxy \
    nginx:1.27
