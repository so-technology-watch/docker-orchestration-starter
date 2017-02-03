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

# Create Consul leader
###################################################################
echo 'Create Consul leader'
$passBySSHForWindows_leader docker service create --replicas 1 \
    --name consul-leader \
    --publish 8500:8500 \
    --network so_tech_net \
    --constraint=node.hostname=='leader1' \
    progrium/consul -server -bootstrap-expect 1 -ui-dir /ui

until $passBySSHForWindows_leader docker ps --no-trunc -f name=consul-leader
do
    echo "wait for container"
    sleep 1
done

# Create Consul Nodes
###################################################################
echo 'Create Consul Nodes, one per worker in the swarm'
eval "$(docker-machine env leader1)"
container_id=$($passBySSHForWindows_leader docker ps --no-trunc q -f name=consul-leader)
echo " leader container-id: $container_id"

docker-machine.exe ssh leader1 "docker inspect --format='{{.NetworkSettings.Networks.so_tech_net.IPAddress}}' $containerLeader"


ip_consul_leader=$($passBySSHForWindows_leader docker network inspect so_tech_net --format )

echo "consul-leader: $ip_consul_leader"

$passBySSHForWindows_leader docker service create \
    --name consul-nodes \
    --publish 8501:8500 \
    --network so_tech_net \
    --mode global \
    progrium/consul -server -join $ip_consul_leader -ui-dir /ui
