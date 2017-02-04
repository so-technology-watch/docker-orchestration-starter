#!/bin/bash

# Servers
bash ./scripts/create-servers.sh

# Swarm
bash ./scripts/initialize-swarm.sh

# Network
bash ./scripts/create-network.sh

eval "$(docker-machine env leader1)"

leaderIp=$(docker-machine ip leader1)
tput bold; tput setaf 2; echo "To see your swarm, go to : http://$leaderIp:5000/"
tput sgr0

echo "Done !"



