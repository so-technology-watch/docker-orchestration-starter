#!/bin/bash

echo 'Init Swarm on the leader1 server'
echo '################################'
ip_leader1=$(docker-machine ip leader1)
echo 'leader1 IP : $ip_leader1'

initSwarmCommand="docker swarm init --listen-addr $ip_leader1 --advertise-addr $ip_leader1"
if [ "$OSTYPE" == "msys" ]; then
    # Pass by ssh. Too compatibility problems with the docker client on Windows (volumes, warning messages ...)
    echo '!! Windows detected !! -> Execute command by ssh'
    docker-machine ssh leader1 $initSwarmCommand
else
    # Launch command with the docker client connected to the leader1 server
    eval "$(docker-machine env leader1)"
    $initSwarmCommand
fi

echo 'Join worker1 and worker2 on the Swarm'
echo '#####################################'
getLeaderTokenCommand="docker swarm join-token worker -q"

if [ "$OSTYPE" == "msys" ]; then
    # Pass by ssh. Too compatibility problems with the docker client on Windows (volumes, warning messages ...)
    echo '!! Windows detected !! -> Execute command by ssh'
    token=$(docker-machine ssh leader1 $getLeaderTokenCommand)
else
    token=$($getLeaderTokenCommand)
fi

addWorkerCommand="docker swarm join --token $token $ip_leader1:2377"

if [ "$OSTYPE" == "msys" ]; then
    # Pass by ssh. Too compatibility problems with the docker client on Windows (volumes, warning messages ...)
    echo '!! Windows detected !! -> Execute command by ssh'
    echo 'Connect the worker1 server'
    docker-machine ssh worker1 $addWorkerCommand
    echo 'Connect the worker2 server'
    docker-machine ssh worker2 $addWorkerCommand
else
    echo 'Connect the worker1 server'
    eval "$(docker-machine env worker1)"    
    $addWorkerCommand
    echo 'Connect the worker2 server'
    eval "$(docker-machine env worker2)"
    $addWorkerCommand
fi
