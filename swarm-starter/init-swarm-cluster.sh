#!/bin/bash

# Servers
###################################################################
bash ./scripts/create-servers.sh

# Swarm
######################################################################""
bash ./scripts/initialize-swarm.sh

# Network
######################################################################""
bash ./scripts/create-network.sh

echo 'Connect the docker client to the leader1 server'
eval "$(docker-machine env leader1)"

