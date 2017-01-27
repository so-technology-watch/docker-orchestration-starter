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

eval "$(docker-machine env leader1)"