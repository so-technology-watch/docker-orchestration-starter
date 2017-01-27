#!/bin/bash

# Initialisation du cluster Swarm
######################################################################
ip_leader1=$(docker-machine ip leader1)

eval "$(docker-machine env leader1)"

docker swarm init \
    --listen-addr $ip_leader1 \
    --advertise-addr $ip_leader1

token=$(docker swarm join-token worker -q)

eval "$(docker-machine env worker1)"

docker swarm join \
    --token $token \
    $ip_leader1:2377

eval "$(docker-machine env worker2)"

docker swarm join \
    --token $token \
    $ip_leader1:2377

