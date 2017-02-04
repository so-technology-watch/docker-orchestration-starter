#!/bin/bash

# Create Consul leader
###################################################################
echo 'Launch the consul-leader service'
if [ "$OSTYPE" == "msys" ]; then
    # Pass by ssh. Too compatibility problems with the docker client on Windows (volumes, warning messages ...)
    echo 'Windows detected !!  -> Execute command by ssh'
else
    echo 'Connect to the leader1'
    eval "$(docker-machine env leader1)"
    echo 'Create consul-leader service'
    docker service create --replicas 1 --name consul-leader --publish 8500:8500 --network so_tech_net --constraint=node.hostname=='leader1' progrium/consul -server -bootstrap-expect 1 -ui-dir /ui
fi

# Wait for the service
while [ -z "$(docker ps --no-trunc -q -f name=consul-leader)" ]  
do
    echo "wait for container"
    sleep 1
done

# # Create Consul Nodes
# ###################################################################
echo 'Create consul-nodes services : One per worker in the swarm'

container_id=$(docker ps --no-trunc -q -f name=consul-leader)
echo " leader container-id: $container_id"

ip_consul_leader=$(docker inspect --format='{{.NetworkSettings.Networks.so_tech_net.IPAddress}}' $container_id)
echo "IPAddress consul-leader: $ip_consul_leader" 

eval "$(docker-machine env leader1)"
docker service create --name consul-nodes --publish 8501:8500 --network so_tech_net --mode global progrium/consul -server -join $ip_consul_leader

# Is done
leaderIp=$(docker-machine ip leader1)
tput bold; tput setaf 2; echo "Go the consul admin UI : http://$leaderIp:8500/"
tput sgr0

echo "Done !"