#!/bin/bash

echo 'Network initialization'
echo '######################'
createNetworkCommand="docker network create -d overlay --subnet 10.1.9.0/24 --attachable so_tech_net"
if [ "$OSTYPE" == "msys" ]; then
    # Pass by ssh. Too compatibility problems with the docker client on Windows (volumes, warning messages ...)
    echo '!! Windows detected !! -> Execute command by ssh'
    docker-machine ssh leader1 $createNetworkCommand
else
    eval "$(docker-machine env leader1)"
    $createNetworkCommand
fi
