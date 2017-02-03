#!/bin/bash

if [ "$OSTYPE" == "msys" ]; then
    # Use of ssh to launch command. Too compatibility problems with the docker client subCommandForWindows
    echo 'Windows detected'
    passBySSHForWindows_leader='docker-machine ssh leader1'
    passBySSHForWindows_worker1='docker-machine ssh worker1'
    passBySSHForWindows_worker2='docker-machine ssh worker2'
else
    eval "$(docker-machine env leader1)"
fi

echo '######################################################################'
echo 'Init Swarm on the leader1 server'
echo '######################################################################'
ip_leader1=$(docker-machine ip leader1)

$passBySSHForWindows_leader docker swarm init \
    --listen-addr $ip_leader1 \
    --advertise-addr $ip_leader1

echo '######################################################################'
echo 'Join worker1 and worker2 on the Swarm'
echo '######################################################################'
if [ "$OSTYPE" == "msys" ]; then
    # Use of ssh to launch command. Too compatibility problems with the docker client subCommandForWindows
    echo 'get token leader : Windows detected'
    token=$(docker-machine ssh leader1 docker swarm join-token worker -q)
else
    token=$(docker swarm join-token worker -q)
fi

eval "$(docker-machine env worker1)"

$passBySSHForWindows_worker1 docker swarm join --token $token $ip_leader1:2377

eval "$(docker-machine env worker2)"

$passBySSHForWindows_worker2 docker swarm join --token $token $ip_leader1:2377

echo '######################'
echo 'Add visualization tool'
echo '######################'

if [ "$OSTYPE" == "msys" ]; then
    # Use of ssh to launch command. Too compatibility problems with the docker client subCommandForWindows
    $passBySSHForWindows_leader "docker run -it -d -p 5000:8080 -v /var/run/docker.sock:/var/run/docker.sock --restart=unless-stopped  julienbreux/docker-swarm-gui:latest"
else
    eval "$(docker-machine env leader1)"
    docker run -it -d -p 5000:8080 -v /var/run/docker.sock:/var/run/docker.sock --restart=unless-stopped  julienbreux/docker-swarm-gui:latest
fi