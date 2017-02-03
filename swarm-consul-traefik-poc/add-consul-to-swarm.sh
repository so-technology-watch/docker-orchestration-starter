#!/bin/bash

# Pass by SSH for windows platform
#####################################
if [ "$OSTYPE" == "msys" ]; then
    # Use of ssh to launch command. Too compatibility problems with the docker client subCommandForWindows
    echo 'Windows detected'
    passBySSHForWindows_leader='docker-machine ssh leader1'
else
    eval "$(docker-machine env leader1)"
fi

# Servers
###################################################################
$passBySSHForWindows_leaderdocker service create --replicas 1 \
    --name consul-leader \
    --publish 8500:8500 \
    --network so-tech-net \
    --constraint=node.hostname=='leader1' \
    progrium/consul -server -bootstrap-expect 1 -ui-dir /ui


$passBySSHForWindows_leader docker service create \
    --name consul-nodes \
    --publish 8501:8500 \
    --network so-tech-net \
    --mode global \
    progrium/consul -server -join 10.1.9.3 -ui-dir /ui