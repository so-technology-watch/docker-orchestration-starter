#!/bin/bash

echo 'Create 3 virtuals servers'
echo 'leader1 >>>>>>> '
docker-machine create \
      --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' \
      --driver virtualbox \
      leader1

echo 'worker1 >>>>>>> '
docker-machine create \
       --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' \
       --driver virtualbox \
       worker1

echo 'worker2 >>>>>>> '
docker-machine create \
       --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' \
       --driver virtualbox \
       worker2
