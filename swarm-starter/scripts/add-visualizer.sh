#!/bin/bash

# service Docker qui me permet de visualiser mon cluster
#########################################################
echo '###########################################################'
echo '# Lancement IHM de visualisation des services du cluster  #'
echo '###########################################################'

eval "$(docker-machine env leader1)"
ip_leader1=$(docker-machine ip leader1)

docker run -it -d -p 5000:8080 -e HOST=$ip_leader1 -v /var/run/docker.sock:/var/run/docker.sock manomarks/visualizer


# Launch the visualiser as a service => don't work :-(
# docker service create \
#   --name=viz \
#   --replicas 1 \
#   --publish=8080:8080/tcp \
#   --constraint=node.role==manager \
#   --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
#   manomarks/visualizer