#!/bin/bash

echo '######################################################################'
echo 'Network initialization'
echo '######################################################################'

if [ "$OSTYPE" == "msys" ]; then
    # Use of ssh to launch command. Too compatibility problems with the docker client subCommandForWindows
    echo 'Windows detected'
    passBySSHForWindows='docker-machine ssh leader1'
else
    eval "$(docker-machine env leader1)"
fi

$passBySSHForWindows docker network create -d overlay --subnet 10.1.9.0/24 --attachable so-tech-net