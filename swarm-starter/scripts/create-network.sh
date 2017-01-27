#!/bin/bash

# Initialisation du réseau
######################################################################

eval "$(docker-machine env leader1)"

docker network create \
    -d overlay --subnet 10.1.9.0/24 \
    multi-host-net