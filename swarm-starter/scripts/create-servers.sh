#!/bin/bash

# Création des 3 serveurs qui va héberger nos clusters
###################################################################
docker-machine create \
      --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' \
      --driver virtualbox \
      leader1

docker-machine create \
       --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' \
       --driver virtualbox \
       worker1

docker-machine create \
       --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' \
       --driver virtualbox \
       worker2
