#!/bin/bash

echo '######################################################################'
echo 'Create 3 virtuals servers'
echo '######################################################################'
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
